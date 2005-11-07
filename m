Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id B6165686AE
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 06:51:48 +1100 (EST)
Date: Mon, 7 Nov 2005 12:51:47 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20051107125147.D1671@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: Fix RapidIO build on 85xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fixes mismerged Makefile that prevented the ppc85xx rapidio support
from being built.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
index 5bd33ba..5b7f2b8 100644
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -33,7 +33,6 @@ obj-$(CONFIG_PPC4xx_DMA)	+= ppc4xx_dma.o
 obj-$(CONFIG_PPC4xx_EDMA)	+= ppc4xx_sgdma.o
 ifeq ($(CONFIG_40x),y)
 obj-$(CONFIG_PCI)		+= pci_auto.o ppc405_pci.o
-obj-$(CONFIG_RAPIDIO)		+= ppc85xx_rio.o
 endif
 endif
 obj-$(CONFIG_8xx)		+= m8xx_setup.o ppc8xx_pic.o $(wdt-mpc8xx-y) \
@@ -96,6 +95,7 @@ obj-$(CONFIG_85xx)		+= open_pic.o ppc85x
 ifeq ($(CONFIG_85xx),y)
 obj-$(CONFIG_PCI)		+= pci_auto.o
 endif
+obj-$(CONFIG_RAPIDIO)		+= ppc85xx_rio.o
 obj-$(CONFIG_83xx)		+= ipic.o ppc83xx_setup.o ppc_sys.o \
 					mpc83xx_sys.o mpc83xx_devices.o
 ifeq ($(CONFIG_83xx),y)
