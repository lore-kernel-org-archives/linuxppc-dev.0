MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Problem of concurrency in arch/ppc/8260_io/uart.c
Date: Thu, 6 Mar 2003 16:39:10 -0500
Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B093BCD@mail1.mediatrix.com>
From: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
To: "Linux PPC embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have a problem of concurrency on my 8250 based custom board.
I'm using kernel 2.4.19, and the output on the serial port goes crappy.

It seems to appear when printk is called from interrupt context,
while a user mode process is writing to stdout.

I wrote a user mode program + a kernel module to reproduce the problem.
The kernel module starts a timer that calls printk (34 chars) each 100ms.
The user mode program performs a while(1) printf(...);
That combination almost immediatly mess the serial driver,
that begins to output characters in an unpredictable order, until we reboot.
It never crashes, however, but it is annoying.

Has anyone encoutered that problem?
or has any suggestion before I go further?
or wish to have the test program to give it a try?

Thanks,
--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
