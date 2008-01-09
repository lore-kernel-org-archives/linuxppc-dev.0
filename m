Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id CF02FDDF51
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 16:18:32 +1100 (EST)
Received: from localhost.localdomain (yow-pgortmak-d1.ottawa.windriver.com
	[128.224.146.65])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m095IVo8001412
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 21:18:31 -0800 (PST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Cc: 
Subject: [PATCH 0/5] Powerpc support for SBC8548 board
Date: Wed,  9 Jan 2008 00:18:25 -0500
Message-Id: <1199855910574-git-send-email-paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a repost of the SBC8548 patches, as requested, which contains the
dts-v1 patch and the pci exclude removal in addition to the original
three 8548 patches.  These are layered on top of the SBC8560 patches
I'd sent yesterday (since they both go after the same Makefile/Kconfig etc).

The patches are as follows:

1) Add basic support for Wind River SBC8548 as powerpc

This adds in the basic platform support file -- closely matching that which
exists for the MPC8548CDS board.  


2) Add device tree source for Wind River SBC8548 board

This also closely matches what exists for the MPC8548CDS platform.  The big
difference here is that this board doesn't have physical access to PCI#2
and it doesn't have the CDS's bridges, i8259, peripherals, etc, so the dts
is overall quite a bit smaller.  I've believe I've got all aliases and the
associated gianfar updates etc. that I'd somehow missed in the sbc8560 dts.


3) Add default .config file for Wind River SBC8548

This config gives basic serial console and ethernet support for doing an
NFS root setup.  The SBC8548 has one PCI-X slot, and a short PCI-e slot,
so I've enabled PCI.  


4) Convert device tree to be dts-v1 compatible

Tag all the values/resources normally in hex with 0x; convert items like
frequencies usually expressed in decimal to decimal; add the dts-v1 tag.


5) Remove PCI exclude device for sbc8548 and sbc8560

The exclude device doesn't need to filter out the PHB anymore, and since
that was all it was doing, it can go entirely.

Paul.
