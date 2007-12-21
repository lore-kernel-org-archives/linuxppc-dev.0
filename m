Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 204A4DDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 17:43:55 +1100 (EST)
Received: from localhost.localdomain (yow-pgortmak-d1.ottawa.windriver.com
	[128.224.146.65])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id lBL6hr75015208
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 22:43:53 -0800 (PST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Cc: 
Subject: [PATCH 0/3] Powerpc support for SBC8548 board
Date: Fri, 21 Dec 2007 01:43:50 -0500
Message-Id: <11982194332672-git-send-email-paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The following three patches add support for the Wind River SBC8548 board
onto the powerpc branch.  The patches are as follows:

1) Add basic support for Wind River SBC8548 as powerpc

This adds in the basic platform support file -- closely matching that which
exists for the MPC8548CDS board.  These are layered on top of the earlier
SBC8560 patches (only is an issue for the usual Makefile/Kconfig patch
collisions).

 powerpc/arch/powerpc/platforms/85xx/Kconfig   |   10 +
 powerpc/arch/powerpc/platforms/85xx/Makefile  |    1 
 powerpc/arch/powerpc/platforms/85xx/sbc8548.c |  182 ++++++++++++++++++++++++++
 3 files changed, 191 insertions(+), 2 deletions(-)


2) Add device tree source for Wind River SBC8548 board

This also closely matches what exists for the MPC8548CDS platform.  The big
difference here is that this board doesn't have physical access to PCI#2
and it doesn't have the CDS's bridges, i8259, peripherals, etc, so the dts
is overall quite a bit smaller.  I've believe I've got all aliases and the
associated gianfar updates etc. that I'd somehow missed in the sbc8560 dts.

 powerpc/arch/powerpc/boot/dts/sbc8548.dts |  219 ++++++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)


3) Add default .config file for Wind River SBC8548

This config gives basic serial console and ethernet support for doing an
NFS root setup.  The SBC8548 has one PCI-X slot, and a short PCI-e slot,
so I've enabled PCI.  

 powerpc/arch/powerpc/configs/sbc8548_defconfig |  740 +++++++++++++++++++++++++
 1 file changed, 740 insertions(+)


Like the 8560 board, I'd quickly spun together a u-boot 1.2.0 for testing
this -- since that was the quickest route for me to get a powerpc capable
version.  This too needs a proper u-boot 1.3.1 patchset so we get all the
associated updates within that, like local-mac-address etc.  Soon...

Paul.
