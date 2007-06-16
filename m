Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 8162FDDFE3
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 10:09:13 +1000 (EST)
Message-Id: <20070616000618.706193913@arndb.de>
References: <20070616000511.712667424@arndb.de>
Date: Sat, 16 Jun 2007 02:05:16 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 5/9] kill isa_{io,mem}_base definitions for !PCI
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When CONFIG_PCI is disabled, the definitions for isa_io_base,
isa_mem_base and pci_dram_offset are entirely unused, but they
can result in link failure because they are defined in multiple
places.

The easiest fix is to just remove all these definitions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6/arch/powerpc/platforms/83xx/mpc8313_rdb.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/mpc8313_rdb.c
+++ linux-2.6/arch/powerpc/platforms/83xx/mpc8313_rdb.c
@@ -28,11 +28,6 @@
 #define DBG(fmt...)
 #endif
 
-#ifndef CONFIG_PCI
-unsigned long isa_io_base = 0;
-unsigned long isa_mem_base = 0;
-#endif
-
 /* ************************************************************************
  *
  * Setup the architecture
Index: linux-2.6/arch/powerpc/platforms/83xx/mpc832x_mds.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ linux-2.6/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -49,11 +49,6 @@
 #define DBG(fmt...)
 #endif
 
-#ifndef CONFIG_PCI
-unsigned long isa_io_base = 0;
-unsigned long isa_mem_base = 0;
-#endif
-
 static u8 *bcsr_regs = NULL;
 
 /* ************************************************************************
Index: linux-2.6/arch/powerpc/platforms/83xx/mpc832x_rdb.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ linux-2.6/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -32,11 +32,6 @@
 #define DBG(fmt...)
 #endif
 
-#ifndef CONFIG_PCI
-unsigned long isa_io_base = 0;
-unsigned long isa_mem_base = 0;
-#endif
-
 /* ************************************************************************
  *
  * Setup the architecture
Index: linux-2.6/arch/powerpc/platforms/83xx/mpc834x_itx.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ linux-2.6/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -38,11 +38,6 @@
 
 #include "mpc83xx.h"
 
-#ifndef CONFIG_PCI
-unsigned long isa_io_base = 0;
-unsigned long isa_mem_base = 0;
-#endif
-
 /* ************************************************************************
  *
  * Setup the architecture
Index: linux-2.6/arch/powerpc/platforms/83xx/mpc834x_mds.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ linux-2.6/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -38,11 +38,6 @@
 
 #include "mpc83xx.h"
 
-#ifndef CONFIG_PCI
-unsigned long isa_io_base = 0;
-unsigned long isa_mem_base = 0;
-#endif
-
 #define BCSR5_INT_USB		0x02
 /* Note: This is only for PB, not for PB+PIB
  * On PB only port0 is connected using ULPI */
Index: linux-2.6/arch/powerpc/platforms/83xx/mpc836x_mds.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ linux-2.6/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -55,11 +55,6 @@
 #define DBG(fmt...)
 #endif
 
-#ifndef CONFIG_PCI
-unsigned long isa_io_base = 0;
-unsigned long isa_mem_base = 0;
-#endif
-
 static u8 *bcsr_regs = NULL;
 
 /* ************************************************************************
Index: linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_ads.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -38,11 +38,6 @@
 #include <asm/fs_pd.h>
 #endif
 
-#ifndef CONFIG_PCI
-unsigned long isa_io_base = 0;
-unsigned long isa_mem_base = 0;
-#endif
-
 #ifdef CONFIG_PCI
 static int mpc85xx_exclude_device(u_char bus, u_char devfn)
 {
Index: linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_cds.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -47,11 +47,6 @@
 #include <sysdev/fsl_soc.h>
 #include "mpc85xx.h"
 
-#ifndef CONFIG_PCI
-unsigned long isa_io_base = 0;
-unsigned long isa_mem_base = 0;
-#endif
-
 static int cds_pci_slot = 2;
 static volatile u8 *cadmus;
 
Index: linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_mds.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -59,11 +59,6 @@
 #define DBG(fmt...)
 #endif
 
-#ifndef CONFIG_PCI
-unsigned long isa_io_base = 0;
-unsigned long isa_mem_base = 0;
-#endif
-
 /* ************************************************************************
  *
  * Setup the architecture
Index: linux-2.6/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ linux-2.6/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -44,13 +44,6 @@
 #define DBG(fmt...) do { } while(0)
 #endif
 
-#ifndef CONFIG_PCI
-unsigned long isa_io_base = 0;
-unsigned long isa_mem_base = 0;
-unsigned long pci_dram_offset = 0;
-#endif
-
-
 #ifdef CONFIG_PCI
 static void mpc86xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
Index: linux-2.6/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -54,12 +54,6 @@
 
 #define MPC7448HPC2_PCI_CFG_PHYS 0xfb000000
 
-#ifndef CONFIG_PCI
-isa_io_base = MPC7448_HPC2_ISA_IO_BASE;
-isa_mem_base = MPC7448_HPC2_ISA_MEM_BASE;
-pci_dram_offset = MPC7448_HPC2_PCI_MEM_OFFSET;
-#endif
-
 extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
 
 int mpc7448_hpc2_exclude_device(u_char bus, u_char devfn)
Index: linux-2.6/include/asm-powerpc/mpc86xx.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/mpc86xx.h
+++ linux-2.6/include/asm-powerpc/mpc86xx.h
@@ -19,12 +19,6 @@
 
 #ifdef CONFIG_PPC_86xx
 
-#define _IO_BASE        isa_io_base
-#define _ISA_MEM_BASE   isa_mem_base
-#ifdef CONFIG_PCI
-#define PCI_DRAM_OFFSET pci_dram_offset
-#endif
-
 #define CPU0_BOOT_RELEASE 0x01000000
 #define CPU1_BOOT_RELEASE 0x02000000
 #define CPU_ALL_RELEASED (CPU0_BOOT_RELEASE | CPU1_BOOT_RELEASE)

--
