Message-ID: <3BA1335F.F5480826@seranoa.com>
Date: Thu, 13 Sep 2001 18:29:51 -0400
From: Andrew Dixon <andrew.dixon@seranoa.com>
MIME-Version: 1.0
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: problems with inetd
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,
I'm trying to set up inetd to run on a box that I'm working on over here
and I was wondering if anyone had any advice.

I've gotten telnetd to run on the box and I'd now like to have inetd
spawn telnetd when there's a connection.

I've installed inetd in /usr/sbin/inetd and have created
/etc/inetd.conf, /etc/services, /etc/protocols, and /etc/nsswitch.conf
but I can't get it to work.

When I try to telnet into the box I get the following output:
	dixon@rowling:~$ telnet 172.16.1.159
	Trying 172.16.1.159...
	telnet: Unable to connect to remote host: Connection refused

I start telnetd on the host with the following command:
	# /usr/sbin/inetd -d
	ADD : discard proto=tcp, wait.max=0.40, user.group=root.(null)
builtin=10014530 server=internal
	ADD : discard proto=udp, wait.max=0.40, user.group=root.(null)
builtin=10014540 server=internal
	ADD : daytime proto=tcp, wait.max=0.40, user.group=root.(null)
builtin=10014570 server=internal
	ADD : time proto=tcp, wait.max=0.40, user.group=root.(null)
builtin=10014550 server=internal
	ADD : telnet proto=tcp, wait.max=0.40, user.group=root.root
builtin=0 server=/usr/sbin/telnetd
	ADD : smtp proto=tcp, wait.max=0.40, user.group=mail.(null)
builtin=0 server=/usr/sbin/exim

what I don't see is the:
	someone wants telnet
	accept, ctrl 3
	1876 execl /usr/sbin/in.telnetd

that you'd expect.

Any ideas on what's going on?

Thanks,
Andy

P.S. Please cc me on replies.


--
Andrew Dixon
Software Engineer
Seranoa Networks
978.897.3434 x231

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
