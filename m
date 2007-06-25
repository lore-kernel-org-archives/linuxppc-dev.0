Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D4C9DDED0
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 18:45:35 +1000 (EST)
Received: from [172.17.0.11] (helo=iron.emcraft.com)
	by ocean.emcraft.com with esmtp (Exim 4.43) id 1I2kCJ-0007Js-MS
	for linuxppc-dev@ozlabs.org; Mon, 25 Jun 2007 12:45:23 +0400
From: Yuri Tikhonov <yur@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc: Marvell mv64x60 drivers for ppc platforms fix
Date: Mon, 25 Jun 2007 12:47:51 +0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200706251247.51518.yur@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 Hi Dale, Kumar,

 Thank you for your comments. All they make sense. Here is an update.

 --

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index c3ce0bd..37c37a9 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -16,8 +16,6 @@ obj-$(CONFIG_FSL_SOC)         += fsl_soc.o
 obj-$(CONFIG_FSL_PCIE)         += fsl_pcie.o
 obj-$(CONFIG_TSI108_BRIDGE)    += tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)     += qe_lib/
-mv64x60-$(CONFIG_PCI)          += mv64x60_pci.o
-obj-$(CONFIG_MV64X60)          += $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o

 # contains only the suspend handler for time
 obj-$(CONFIG_PM)               += timer.o
@@ -26,6 +24,8 @@ ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_I8259)                += i8259.o
 obj-$(CONFIG_PPC_83xx)         += ipic.o
 obj-$(CONFIG_4xx)              += uic.o
+mv64x60-$(CONFIG_PCI)          += mv64x60_pci.o
+obj-$(CONFIG_MV64X60)          += $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o
 endif

 # Temporary hack until we have migrated to asm-powerpc
