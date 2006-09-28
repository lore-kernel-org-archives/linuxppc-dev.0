Return-Path: <christophe.alayrac@univ-orleans.fr>
Received: from ka.univ-orleans.fr (ka.univ-orleans.fr [193.49.83.5])
	by ozlabs.org (Postfix) with ESMTP id 70B4D67B99
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 02:10:28 +1000 (EST)
Received: from [194.254.8.167] (localhost [127.0.0.1])
	by ka.univ-orleans.fr (Postfix) with ESMTP id 263BD12AD4C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Sep 2006 18:10:23 +0200 (CEST)
Subject: ML403 UBOOT,  I2C and Linux boot problem
From: alayrac <christophe.alayrac@univ-orleans.fr>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Thu, 28 Sep 2006 18:10:30 +0200
Message-Id: <1159459831.5737.3.camel@Serge-Linux>
Mime-Version: 1.0
Reply-To: christophe.alayrac@univ-orleans.fr
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

To do so I've dowloaded the ml403_emb_ref_ppc_81.zip from xilinx website
as well as u-boot.zip (from ml410 documentation on xilinx web site).

1) First you I've modifie the xparameters.h file in
u-boot/board/xilnx/ml403 directory to match hardware design of
ml403_emb...81 design.
(The memory mapping is different)

I now have u-boot working on ML403 but the IIC EEPROM can't be
accessed.

imd command (imd 50 10.2 10 )return error message, iprobe hang up and
saveenv did not save anything into I2C memory.

Does any one as any experience on that issue?

Note :To use I2C one should define either CONFIG_HARD_I2C or
CONFIG_SOFT_I2C, but Xilinx as writen function (i2c_read...) in
iic_addapter.c without using this macro.
Is it the right way?

2) If I manually load kernel uImage in memory (fatload ace 0 400000
linux/uboot.uImage) and then boot the kernel (bootm 400000) then the
process stop after 
Uncompressing Kernel Image ... Ok

Note: The kernel has been compiled with a command line to boot via NFS.
This image works properly if associated to bitsream in the ace file.
The kernel 2.4.26 has been patched for u-boot and recompiled with same
config (using mkimage to generate uImage)

Any suggestion?

3) The board did not start at powerup with that uboot ace file, the done
light did not go on, I need to press sysace rst button to start
properly.

Does any one face that cold start prolblem?

Thank in advance for any help

Chris
