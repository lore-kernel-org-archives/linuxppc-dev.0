MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Problem setting up a telnet server on a custom 8260 board (using Busybox)
Date: Fri, 9 Jan 2004 19:06:26 -0000
Message-ID: <DEF39A0710293E489D45B10E06645CBD0284286E@dub-msx1.spectelcorp.com>
From: "Joao Vicente" <joao.vicente@spectel.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
