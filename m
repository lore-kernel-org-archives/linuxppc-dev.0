MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Problem setting up a telnet server on a custom 8260 board (using Busybox)
Date: Fri, 9 Jan 2004 14:15:52 -0500
Message-ID: <8529B5552D4EAA4DAEDF49650C64B2B437137C@tarpon.mangrovesystems.com>
From: "Muhammad Sarwar" <msarwar@mangrovesystems.com>
To: "Joao Vicente" <joao.vicente@spectel.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Check if your inetd daemon is running. It may be part of your rcS script.


Regards,
 
Muhammad Sarwar
Mangrove Systems Inc.


-----Original Message-----
From: Joao Vicente [mailto:joao.vicente@spectel.com]
Sent: Friday, January 09, 2004 2:06 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem setting up a telnet server on a custom 8260 board (using Busybox)


Dear all

I am trying to set up a telnet server on a custom 8260 based board.

my xinetd.conf file is as shown below

#####################################################
#
# Simple configuration file for xinetd
#
# Some defaults, and include /etc/xinetd.d/

defaults
{
        instances               = 60
        log_type                = SYSLOG authpriv
        log_on_success          = HOST PID
        log_on_failure          = HOST
        cps                     = 25 30
}

includedir /etc/xinetd.d
#######################################################

My etc/xinetd.d/telnet config file is as follows

######################################################
# default: on
# description: The telnet server serves telnet sessions; it uses \
#       unencrypted username/password pairs for authentication.
service telnet
{
        flags           = REUSE
        socket_type     = stream
        wait            = no
        user            = root
        server          = /usr/sbin/in.telnetd
        log_on_failure  += USERID
        disable         = no
}
#######################################################

On inittab I am calling xinetd as follows:
######################################################
...
::once:/usr/sbin/xinetd
...
#####################################################

My telnet server is in:
/usr/sbin/in.telnetd

When I try to telnet from another machine I get the following
'telnet: connect to address 10.121.10.24: Connection refused'

When I try running telnet on locally 'telnet 127.0.0.1' I get the following message:
'telnet: Unable to connect to remote host: Connection refused'

I can ping my board from the machine I want to telnet from.

I cannot see the xinetd process running when I type 'ps -A'

I would apreciate if somebody could give me a 'push' in the right direction.

Thanks

Joao Vicente


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
