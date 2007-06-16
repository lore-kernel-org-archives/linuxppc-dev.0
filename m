Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id ADC59DDFD6
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 10:09:11 +1000 (EST)
Message-Id: <20070616000618.965439750@arndb.de>
References: <20070616000511.712667424@arndb.de>
Date: Sat, 16 Jun 2007 02:05:18 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 7/9] disallow building powermac and tsi108 without PCI
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The TSI108 code and the 32 bit powermac and chrp platforms
have dependency on PCI that is not easy or desirable to get rid
of.

The easiest fix is to always select CONFIG_PCI if one of those
platforms is enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -18,6 +18,7 @@ config LINKSTATION
 
 config MPC7448HPC2
 	bool "Freescale MPC7448HPC2(Taiga)"
+	select PCI
 	select TSI108_BRIDGE
 	select DEFAULT_UIMAGE
 	select PPC_UDBG_16550
@@ -31,6 +32,7 @@ config PPC_HOLLY
 	select TSI108_BRIDGE
 	select PPC_UDBG_16550
 	select CPU_7xx
+	select PCI
 	help
 	  Select PPC_HOLLY if configuring for an IBM 750GX/CL Eval
 	  Board with TSI108/9 bridge (Hickory/Holly)
Index: linux-2.6/arch/powerpc/platforms/powermac/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/Kconfig
+++ linux-2.6/arch/powerpc/platforms/powermac/Kconfig
@@ -2,6 +2,7 @@ config PPC_PMAC
 	bool "Apple PowerMac based machines"
 	depends on PPC_MULTIPLATFORM
 	select MPIC
+	select PCI
 	select PPC_INDIRECT_PCI if PPC32
 	select PPC_MPC106 if PPC32
 	select PPC_NATIVE
Index: linux-2.6/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig
+++ linux-2.6/arch/powerpc/Kconfig
@@ -435,7 +435,7 @@ config MCA
 config PCI
 	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
 		|| PPC_MPC52xx || (EMBEDDED && (PPC_PSERIES || PPC_ISERIES)) \
-		|| MPC7448HPC2 || PPC_PS3 || PPC_HOLLY
+		|| PPC_PS3
 	default y if !40x && !CPM2 && !8xx && !PPC_83xx \
 		&& !PPC_85xx && !PPC_86xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx
Index: linux-2.6/arch/powerpc/platforms/chrp/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/chrp/Kconfig
+++ linux-2.6/arch/powerpc/platforms/chrp/Kconfig
@@ -8,4 +8,5 @@ config PPC_CHRP
 	select PPC_MPC106
 	select PPC_UDBG_16550
 	select PPC_NATIVE
+	select PCI
 	default y
Index: linux-2.6/arch/powerpc/platforms/chrp/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/chrp/Makefile
+++ linux-2.6/arch/powerpc/platforms/chrp/Makefile
@@ -1,4 +1,3 @@
-obj-y				+= setup.o time.o pegasos_eth.o
-obj-$(CONFIG_PCI)		+= pci.o
+obj-y				+= setup.o time.o pegasos_eth.o pci.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_NVRAM)		+= nvram.o

--
