Date: Fri, 28 Dec 2001 22:23:40 +0100
From: Tim Schmielau <tim@physik3.uni-rostock.de>
Message-Id: <200112282123.fBSLNeV03367@gans.physik3.uni-rostock.de>
To: dmalek@jlc.net
Subject: [patch] fix compares of jiffies
Cc: source@mvista.com, benh@kernel.crashing.org,
	linuxppc-dev@lists.linuxppc.org, tim@physik3.uni-rostock.de
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Linux kernel code maintainer,

some weeks ago in the course of a discussion on lkml
(see http://www.uwsg.indiana.edu/hypermail/linux/kernel/0110.3/1553.html
and follow-ups) linux kernels of the 2.4 series turned out to sometime
lock up after 497.1 days of uptime, when the "jiffies" variable wraps
back to zero.

Checking the kernel code, I found a number of places where jiffies
were compared in a way that seems to break when they wrap. For these,
I made up patches to use the macros "time_before()" or "time_after()"
that are supposed to handle wraparound correctly.

For a small part of the patches, I believe you to be the relevant kernel code
maintainer. Appended to this email you will find some lines explaining
why I decided to mail or cc: you on this (an extract of the copyright notice
or the MAINTAINERS file), followed by the patch itself. If I mailed you
in error, please drop me a short note.

I kindly ask you to approve the correctness of the patch, and pass it on to
the relevant people for inclusion into the mainline kernel.

Thanks,
Tim Schmielau (tim@physik3.uni-rostock.de)



/*
 * BK Id: SCCS/s.uart.c 1.19 10/26/01 09:59:32 trini
 */
/*
 *  UART driver for MPC860 CPM SCC or SMC
 *  Copyright (c) 1997 Dan Malek (dmalek@jlc.net)
 *

/*
 * BK Id: SCCS/s.uart.c 1.6 05/17/01 18:14:20 cort
 */
/*
 *  UART driver for MPC8260 CPM SCC or SMC
 *  Copyright (c) 1999 Dan Malek (dmalek@jlc.net)
 *  Copyright (c) 2000 MontaVista Software, Inc. (source@mvista.com)
 *	2.3.99 updates
 *

LINUX FOR POWER MACINTOSH
P:	Benjamin Herrenschmidt
M:	benh@kernel.crashing.org
W:	http://www.linuxppc.org/
L:	linuxppc-dev@lists.linuxppc.org
S:	Maintained



--- linux-2.4.18-pre1/arch/ppc/8xx_io/uart.c	Sat Nov  3 02:43:54 2001
+++ linux-2.4.18-pre1-jiffies64/arch/ppc/8xx_io/uart.c	Fri Dec 28 15:07:17 2001
@@ -1802,7 +1802,7 @@
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 			break;
-		if (timeout && ((orig_jiffies + timeout) < jiffies))
+		if (timeout && time_after(jiffies, orig_jiffies + timeout))
 			break;

 		/* The 'tx_cur' is really the next buffer to send.  We
--- linux-2.4.18-pre1/arch/ppc/8260_io/uart.c	Tue May 22 02:04:46 2001
+++ linux-2.4.18-pre1-jiffies64/arch/ppc/8260_io/uart.c	Fri Dec 28 15:11:16 2001
@@ -1736,7 +1736,7 @@
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 			break;
-		if (timeout && ((orig_jiffies + timeout) < jiffies))
+		if (timeout && time_after(jiffies, orig_jiffies + timeout))
 			break;
 		bdp = info->tx_cur;
 	} while (bdp->cbd_sc & BD_SC_READY);

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
