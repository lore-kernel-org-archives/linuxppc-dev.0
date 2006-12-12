Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 291A367C64
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 16:23:22 +1100 (EST)
Subject: [PATCH] ppc: fix build of DCR bits on 4xx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 16:23:14 +1100
Message-Id: <1165900994.11914.27.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The new dcr.c file shouldn't be compiled on arch/ppc, and dcr-low.S
should only be built if CONFIG_PPC_DCR_NATIVE is set.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-cell/arch/powerpc/sysdev/Makefile
===================================================================
--- linux-cell.orig/arch/powerpc/sysdev/Makefile	2006-12-12 16:18:27.000000000 +1100
+++ linux-cell/arch/powerpc/sysdev/Makefile	2006-12-12 16:19:12.000000000 +1100
@@ -5,7 +5,7 @@ endif
 obj-$(CONFIG_MPIC)		+= mpic.o
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
 obj-$(CONFIG_PPC_MPC106)	+= grackle.o
-obj-$(CONFIG_PPC_DCR)		+= dcr.o dcr-low.o
+obj-$(CONFIG_PPC_DCR_NATIVE)	+= dcr-low.o
 obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
@@ -14,6 +14,7 @@ obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 obj-$(CONFIG_OF_SERIAL)	+= of_serial.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
+obj-$(CONFIG_PPC_DCR)		+= dcr.o
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
 obj-$(CONFIG_PPC_83xx)		+= ipic.o
 obj-$(CONFIG_PPC_MPC52xx)	+= mpc52xx_pic.o
