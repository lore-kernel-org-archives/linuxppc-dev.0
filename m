Return-Path: <rubini@mail.gnudd.com>
Received: from mail.gnudd.com (adsl-203-134.38-151.net24.it [151.38.134.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 96D86DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Mar 2007 09:56:39 +1100 (EST)
Received: from mail.gnudd.com (rubini@localhost [127.0.0.1])
	by mail.gnudd.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	l2GMgkJH032233
	for <linuxppc-embedded@ozlabs.org>; Fri, 16 Mar 2007 23:42:46 +0100
Received: (from rubini@localhost)
	by mail.gnudd.com (8.13.4/8.13.4/Submit) id l2GMgjJe032230
	for linuxppc-embedded@ozlabs.org; Fri, 16 Mar 2007 23:42:45 +0100
Date: Fri, 16 Mar 2007 23:42:45 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: login on console=tty with serial input
Message-ID: <20070316224245.GA32224@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: rubini@gnudd.com
In-Reply-To: <381D3B2C62C8B94B95219E2DA47C8DCF08E3CA@stnzolex2.securiton.int>
References: <381D3B2C62C8B94B95219E2DA47C8DCF08E3CA@stnzolex2.securiton.int>
	<OF1C808DEE.C8EB82B2-ONC1257295.003752BA-C1257296.0038EEB2@rockwellcollins.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> As GUI library, I started to evaluate Nano-X, FLTK and wxWitgets. But there
>  is the problem that I don't have keyboard input whether form the serial
>  line nor form a remote shell (Ethernet).

What you type in the serial console reaches user space in /dev/ttyS0
or whatever the name on your platform. What you type in the network
connection reaches user space in the socket, where the server (sshd,
telnetd or whatever) pushes it back to a pty master, so your shell
reads it from the pty (slave) is has on its stdin.

Programs using /dev/fb usually open /dev/tty1 (or /dev/tty2 etc) to
read keyboard input from. The device driver that manages it is nether
the serial driver nor the pty driver, but the "virtual console" one.
What is reported there as keypresses are the input events reported by
a keyboard.
 
> As far I understand the matter the problem is that the console that is
>  running on the frame buffer needs as input a keyboard device and not a
>  serial line. Unfortunately I found till now no solution to redirect the
>  serial line to a keyboard device.

Read /dev/ttyS0 and post keypress events associated to the ascii data
you read. Your graphic environment will see them. You can write
your own module to post keyboard data or use uinput (CONFIG_INPUT_UINPUT).

hope this helps
/alessandro
