MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Serial-to-socket conversion
Date: Tue, 25 May 2004 10:16:28 -0600
Message-ID: <065ACD8E84315E4394C835E398C8D5EB09224F@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Traditionally this was known as a reverse telnet server.

I haven't tried it, but I think netcat will do the job for you.  Run it on your target computer (the one with an ethernet and a serial port you want to connect to) using "-l -p <port>", netcat will listen on <port> for a connection.  Then redirect netcat's stdin and stdout to your serial device:
  nc -t -l -p 1234 < /dev/ttyS0 > /dev/ttyS0

At this point you should be able to telnet into your target computer, port 1234 (in the above example), from your remote computer:
  telnet 192.168.1.1 1234
(filling in the proper IP address and port number).  Anything you type should go out the serial port and anything that comes in the serial port should be sent to your telnet session.

Let us know if you get it working, its one of those "toolbox" things that you only need occasionally but, when you need it, you need it _bad_ and you need it _now_.

gvb


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Joshua
> Lamorie
> Sent: Tuesday, May 25, 2004 11:14 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Serial-to-socket conversion
>
>
>
> Gidday there,
>
> I want to remotely access a serial port, but I can't just open a shell
> on the remote computer.  What I would like to do is open minicom (or
> kermit or pppd) point it to some device local to my computer
> which then
> bridges through a socket to my funky remote serial port.  I can't find
> any references to similar code other than perhaps pty-redir.
> Sorry for
> polluting this mailing list, but if you can point me towards something
> more appropriate, I would appreciate it.
>
> Thanks
>
> Joshua
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
