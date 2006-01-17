Return-Path: <markc@mail.com>
Received: from relay02.roc.ny.frontiernet.net (relay02.roc.ny.frontiernet.net
	[66.133.182.165]) by ozlabs.org (Postfix) with ESMTP id 2C643681B8
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jan 2006 07:59:21 +1100 (EST)
Message-ID: <004f01c61ba4$f77c41e0$6401a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: =?iso-8859-1?Q?Jose_Fran=E7a_\=28Ext=5FGTBC\=29?=
	<Jose.Franca.Ext@siemens.com>, <linuxppc-dev@ozlabs.org>
References: <16FD2D70D281D44F9BFCF6ACF9B6117102AF6570@lisi053a.siemens.pt>
Subject: Re: Linux-2.4.31 porting 
Date: Tue, 17 Jan 2006 15:31:09 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linux-2.4.31 porting

>Hello u all!
>        Have you already ported a linux-2.4.31 to be used on a PPC mpc8272
(or anyone from the family) based board?
>        The problem that I have is that i don't have console. As far as i
could debug, the kernel stucks on my_console_write (in
arch/ppc/cpm2_io/uart.c), waiting >for transmitter fifo to empty (line
2298 - "while (bdp->cbd_sc & BD_SC_READY)").
>        Any suggestions will be highly welcomed!

I have used 2.4.24 running on an mpc8247 based board.  My board uses SMC1,
SCC3 and SCC4 for tty,
(console on SCC4) so I had to edit the configuration in uart.c, but no other
changes.  You probably have
a configuration mis-match, maybe your parallel port pins are not getting set
up right.

By the way, 2.4.24 put FCC ethernet tables in reserved memory, but I think
that was fixed by 2.4.31.
Check that you have CONFIG_8272 in your .config file to be sure.

Also, I worked from CONFIG_ADS8260 and I couldn't make a bit of sense of the
PCI implementation.
I think the mpc8266ads_pci.c implementation assumes some setup from the
bootloader. I'll be glad to share
what I did (though I'm not very sure of it) if you run into the same
problem.

Mark Chambers
