class smokeping::install {
    include smokeping::params
    
    package { 'smokeping':
        ensure => $smokeping::version
    }

    if ! defined (Package[$smokeping::params::package_perldoc]) {
        package {$smokeping::params::package_perldoc: ensure => installed; }
    }

    # correct permissions
    file {
        $smokeping::path_datadir:
            ensure  => directory,
            owner   => $smokeping::daemon_user,
            group   => $smokeping::daemon_group,
            require => Package['smokeping'],
            recurse => true;
        $smokeping::path_piddir:
            ensure  => directory,
            owner   => $smokeping::daemon_user,
            group   => $smokeping::daemon_group,
            require => Package['smokeping'],
            recurse => true;
        $smokeping::path_imgcache:
            ensure  => directory,
            owner   => $smokeping::webserver_user,
            group   => $smokeping::webserver_group,
            require => Package['smokeping'],
            recurse => true;
    }

}
