Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
To: Joshua Lamorie <jpl@xiphos.ca>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial-to-socket conversion 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 25 May 2004 11:14:02 EDT."
             <40B362BA.3080908@xiphos.ca>
Date: Tue, 25 May 2004 18:26:41 +0200
Message-Id: <20040525162646.A291FC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <40B362BA.3080908@xiphos.ca> you wrote:
>
> I want to remotely access a serial port, but I can't just open a shell
> on the remote computer.  What I would like to do is open minicom (or
> kermit or pppd) point it to some device local to my computer which then
> bridges through a socket to my funky remote serial port.  I can't find
> any references to similar code other than perhaps pty-redir.  Sorry for
> polluting this mailing list, but if you can point me towards something
> more appropriate, I would appreciate it.

We're running a modified version of netkit-rsh which  allows  to  use
"rlogin <host> -l <portname>" to connect to a remote serial port; for
example, this config file might be used:

	#
	# tserver.conf
	#
	# This file should contain one line for each board.
	#
	# The first field is the name of the board.
	# The next field is the device to which the board is attached.
	# Next comes a comma-separated list of parameters in the form
	# BAUDRATE,DATABITS,PARITY,STOPBITS,FLOWCONTROL.
	#
	# port  device          parameters
	#
	board1	/dev/ttyS0      19200,8,N,1
	board2	/dev/ttyS1      57600,8,N,1,CRTSCTS
	board3	/dev/ttyUSB0	9600,8,N,1
	board4	/dev/ttyUSB1    115200,8,N,1

If you want I can send you the stuff; if ther eis more interest I can
put it on our FTP server.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
As far as the laws of mathematics refer  to  reality,  they  are  not
certain;  and  as  far  as  they  are  certain,  they do not refer to
reality.                                           -- Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
