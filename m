Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 76D1067E77
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 02:59:27 +1000 (EST)
Date: Thu, 10 Aug 2006 11:51:46 -0500
From: Milton Miller <miltonm@bga.com>
To: v.selvamuthukumar@gdatech.co.in, linuxppc-dev@ozlabs.org,
Subject: Re: Reg. Serial and Virtual consoles
Message-Id: <3115522870674b0dc514.719885386.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It sounds to me that you want all input and output on the serial line to be echoed to  the vga screen both user and kernel.  Do you also require keyboard input?

While others have described how to get the kernel messages displayed on both the screen and the serial port, they were missing the userspace requirement.

You will either need to write your own multiplexer program in user space and do the mirroring there, or use something like the screen program.  Either way the program will be running on a pty and some agent will be mirroring the text.  If you only require serial input it could be as simple as opening tty1, ttyS0, and the pty master and forking tee and cat to handle the master, your getty would run on the slave.

milton
