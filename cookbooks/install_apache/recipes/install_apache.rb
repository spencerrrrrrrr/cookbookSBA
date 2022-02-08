# Install basic packages

package 'Install basic packages' do
  package_name %w(vim wget curl bash-completion)
end

# Install Apache web server
package 'Install Apache web server' do
  case node['platform']
  when 'redhat', 'centos', 'fedora'
    package_name 'httpd'
  when 'ubuntu', 'debian'
    package_name 'apache2'
  end
end

# Start and enable the service

service 'Start and enable apache service' do
  case node['platform']
  when 'redhat', 'centos', 'fedora'
    service_name 'httpd'
  when 'ubuntu', 'debian'
    service_name 'apache2'
  end
  action [:enable, :start]
end

# Copy apache template

template '/var/www/html/index.html' do
  source 'index.html.erb'
  mode '0644'
  case node['platform']
  when 'redhat', 'centos', 'fedora', 'scientific'
    owner 'apache'
    group 'apache'
  when node['platform']
    owner 'www-data'
    group 'www-data'
  end
end
