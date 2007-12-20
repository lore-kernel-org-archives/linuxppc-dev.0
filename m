Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 1C5AADDE2A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 05:20:01 +1100 (EST)
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id lBKEsXmu025813
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 06:54:33 -0800 (PST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Cc: 
Subject: [PATCH 0/4] arch/powerpc support for SBC8560 board
Date: Thu, 20 Dec 2007 09:54:28 -0500
Message-Id: <11981624722785-git-send-email-paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



The following four patches add support for the Wind River SBC8560 board
onto the powerpc branch.  The patches are as follows:

1) Add basic support for Wind River SBC8560 as powerpc

This adds in the basic platform support file -- closely matching that which
exists for the MPC8560ADS board.

 b/arch/powerpc/platforms/85xx/Kconfig   |   11 -
 b/arch/powerpc/platforms/85xx/Makefile  |    1 
 b/arch/powerpc/platforms/85xx/sbc8560.c |  303 +++++++++++++++++++++++++++++++-


2) Make support for the CPM2 optional on 8560 based boards

Since the SBC8560 has a 16550 compatible UART on board, there really is
no direct requirement for any of the CPM functionality to be forced on
all the time.  This allows you to turn off the CPM2 support for this board.

 b/arch/powerpc/platforms/85xx/Kconfig |    4 ++--
 b/arch/powerpc/platforms/Kconfig      |    5 ++---


3) Add device tree source for Wind River SBC8560 board

This is probably the most interesting part of the group, given that the
board doesn't use the CPM2 to provide the serial console.  I've made a
duart dts entry that is kind of similar to what is done for the tsi108
on the mpc7448/hpc-ii board, and made sure that the serial had their
parent marked as "soc" (found out the hard way that UARTs were ignored
as possible consoles unless they were soc or tsi108 children...)

 b/arch/powerpc/boot/dts/sbc8560.dts |  203 +++++++++++++++++++++++++++++++++++-


4) Add default .config file for Wind River SBC8560

 b/arch/powerpc/configs/sbc8560_defconfig |  765 ++++++++++++++++++++++++++++++-

This config gives basic serial console and ethernet support for doing an
NFS root setup.  The SBC8560 can be used as a PCI host when put into
a suitable backplane, and the FCC ports can be used for eth2/eth3 if
the board is fitted with a daughtercard with a couple Broadcom PHY, but
at the moment these features aren't enabled/tested as they weren't on
the board I was using.


I'd quickly spun together a u-boot 1.2.0 for testing this -- since that was
the quickest route to getting a powerpc capable version.  I'll see what
can be done for getting a u-boot 1.3.1 patchset out so the local-mac-address
vs address thing in the dtb isn't an issue.

Paul.
