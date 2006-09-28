Return-Path: <christophe.alayrac@cresitt.com>
Received: from postfix2-g20.free.fr (postfix2-g20.free.fr [212.27.60.43])
	by ozlabs.org (Postfix) with ESMTP id BF44B67A3A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Sep 2006 20:39:06 +1000 (EST)
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by postfix2-g20.free.fr (Postfix) with ESMTP id B1798133397
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Sep 2006 12:18:00 +0200 (CEST)
Received: from [192.168.0.1] (sou45-1-82-229-118-71.fbx.proxad.net
	[82.229.118.71])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A70BC49655
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Sep 2006 12:17:57 +0200 (CEST)
Subject: ML403 UBOOT
From: alayrac christophe <christophe.alayrac@cresitt.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Thu, 28 Sep 2006 14:17:39 +0200
Message-Id: <1159445859.13293.23.camel@localhost.localdomain>
Mime-Version: 1.0
Reply-To: christophe.alayrac@cresitt.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I succeed to start u-boot on my ML403 board.

To do so I've dowloaded the ml403_emb_ref_ppc_81.zip from xilnx website
as well as u-boot.zip (from ml410 documentation on xilinx web site).

1) First you I've modifie the xparameters.h file in
u-boot/board/xilnx/ml403 directory to match hardware design of
ml403_emb...81 design.
(The memory mapping is different)

I'm know have u-boot working on ML403 but the IIC EEPROM can(t be
accessed.

imd command (imd 50 10.2 10 )return error message, iprobe hang up and
saveenv did not save anything into I2C memory.

Does any one as any experience on that issue?
To use I2C one should define either CONFIG_HARD_I2C or CONFIG_SOFT_I2C,
but Xilinx as writen function (i2c_read...) in iic_addapter.c without
using this macro.
Is it the right way?

2) If I manually load kernel uImage in memory (fatload ace 0 400000
linux/uboot.uImage)
and then boot the kernel (bootm 400000) then the process stop after
Uncompressing Kernel Image ... Ok

Note: The kernel has been compiled with a command line to boot via NFS.
This image works properly if associated to bitsream in the ace file.
The kernel 2.4.26 has bee patched for u-boot and recompiled with same
config (using mkimage to generate uImage)

Any suggestion?

3) The board did not start at powerup with that ace file (bitsream +
uboot),the done light did not go on, I need to press sysace rst button
to start properly.

Does any one face that cold start prolblem?

Thank in advance for any help

Chris
