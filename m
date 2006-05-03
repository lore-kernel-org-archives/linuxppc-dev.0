Return-Path: <jean-marie.teuler@lcp.u-psud.fr>
Received: from smtp2.u-psud.fr (smtp2.u-psud.fr [129.175.33.42])
	by ozlabs.org (Postfix) with ESMTP id E128267A63
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 May 2006 23:56:50 +1000 (EST)
Received: from smtp2.u-psud.fr (localhost [127.0.0.1])
	by localhost (MTA) with SMTP id 6408E382C89
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 May 2006 15:34:51 +0200 (CEST)
Received: from upsn240.cri.u-psud.fr (upsn240.cri.u-psud.fr [129.175.34.240])
	by smtp2.u-psud.fr (MTA) with ESMTP id 59C7338296E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 May 2006 15:34:51 +0200 (CEST)
Received: from ext.lcp.u-psud.fr (ext.lcp.u-psud.fr [129.175.100.5])
	by upsn240.cri.u-psud.fr (8.12.10/8.12.0.Beta10) with ESMTP id
	k43DYmRV012195
	for <linuxppc-embedded@ozlabs.org>; Wed, 3 May 2006 15:34:48 +0200
Received: from khnoum.lcp.u-psud.fr (khnoum.lcp.u-psud.fr [129.175.100.38])
	by ext.lcp.u-psud.fr (8.13.5.20060308/8.13.5) with ESMTP id
	k43DYpGd015187
	for <linuxppc-embedded@ozlabs.org>; Wed, 3 May 2006 15:34:51 +0200
Subject: Impossible to open the root console with 2.6.15
From: Jean-Marie Teuler <jean-marie.teuler@lcp.u-psud.fr>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 03 May 2006 15:36:08 +0200
Message-Id: <1146663369.2448.25.camel@khnoum.lcp.u-psud.fr>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi there,

I am trying to use ELDK 4.0 on my TQM860L board.

I have compiled the included 2.6.15 kernel with reasonable options, but
when I try to boot it, I do not get the prompt after the message
"Uncompressing Kernel Image ... OK"

Actually, I know that the system is not hanging because
1) I see there is network traffic between the board and the NFS server
2) There are messages written in /var/log/messages, and I see that the
initialization is completed (even my /etc/rc.local has been executed)

So I suspect that the problem comes from reading/writing on the console.
As my /etc/inittab has the line
...............................................
3:2345:respawn:/sbin/mingetty --noclear console
...............................................
I have put a wrapper around the binary "mingetty" and I have checked
that indeed it is called... only that I do not see anything on the
screen.

I am pretty sure that this problem is related to the kernel because if I
boot on a 2.4 kernel with the same root filesystem everything works
fine.

With the 2.4 kernel I had the following messages in /var/log/messages
.................................................................
Jan 22 12:16:34 tqm kernel: ttyS0 at 0x0280 is on SMC1 using BRG1
Jan 22 12:16:34 tqm kernel: ttyS1 at 0x0380 is on SMC2 using BRG2
.................................................................

and with the 2.6
......................................................................
Jan 26 20:25:26 tqm kernel: ttyCPM0 at MMIO 0xfff00a80 (irq = 20) is a
CPM UART
Jan 26 20:25:26 tqm kernel: ttyCPM1 at MMIO 0xfff00a90 (irq = 19) is a
CPM UART
......................................................................

I have tried to create these devices with the following characteristics:
......................................................................
crw-rw---- 1 root root 204, 46 mai  3 14:43 dev/ttyCPM0
crw-rw---- 1 root root 204, 47 mai  3 14:43 dev/ttyCPM1
......................................................................
but to no avail.

I have seen that there are many new options related to serial lines in
the new kernel, so I guess that I am doing something wrong.

Thanks in advance for any hint.

Jean-Marie Teuler

........................................................................
: Jean-Marie Teuler              :                                     :
: Laboratoire de Chimie Physique :  Téléphone (33) (1) 69 15 42 05     :
: Université de Paris-sud        :  Télécopie (33) (1) 69 15 61 88     :
: Bâtiment 349                   :  Mél       teuler@lcp.u-psud.fr     :
: 91 405 Orsay Cedex             :  Web       http://www.lcp.u-psud.fr :
........................................................................
