Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7DB0DB71E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 18:55:04 +1000 (EST)
Received: by mail-ew0-f51.google.com with SMTP id 6so1840101ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 01:55:03 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 11/14] 85xx: merge 32-bit QorIQ with DPA boards support
Date: Tue, 19 Jul 2011 12:53:48 +0400
Message-Id: <1311065631-3429-12-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Board support files for p4080ds, p3041ds and p2040rdb don't differ at
all (all differencies are hidden in dts files). So merge them into
single board file containing all necessary stuff.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/85xx/Kconfig                |   32 +------
 arch/powerpc/platforms/85xx/Makefile               |    4 +-
 arch/powerpc/platforms/85xx/p2040_rdb.c            |   88 -------------------
 arch/powerpc/platforms/85xx/p3041_ds.c             |   90 --------------------
 .../platforms/85xx/{p4080_ds.c => qoriq_dpa_ds.c}  |   24 +++--
 5 files changed, 20 insertions(+), 218 deletions(-)
 delete mode 100644 arch/powerpc/platforms/85xx/p2040_rdb.c
 delete mode 100644 arch/powerpc/platforms/85xx/p3041_ds.c
 rename arch/powerpc/platforms/85xx/{p4080_ds.c => qoriq_dpa_ds.c} (72%)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 498534c..7b9c042 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -171,8 +171,8 @@ config SBC8560
 	help
 	  This option enables support for the Wind River SBC8560 board
 
-config P2040_RDB
-	bool "Freescale P2040 RDB"
+config QORIQ_DPA_DS
+	bool "Freescale QorIQ with DPA development systems"
 	select DEFAULT_UIMAGE
 	select PPC_E500MC
 	select PHYS_64BIT
@@ -181,31 +181,9 @@ config P2040_RDB
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
 	help
-	  This option enables support for the P2040 RDB board
-
-config P3041_DS
-	bool "Freescale P3041 DS"
-	select DEFAULT_UIMAGE
-	select PPC_E500MC
-	select PHYS_64BIT
-	select SWIOTLB
-	select MPC8xxx_GPIO
-	select HAS_RAPIDIO
-	select PPC_EPAPR_HV_PIC
-	help
-	  This option enables support for the P3041 DS board
-
-config P4080_DS
-	bool "Freescale P4080 DS"
-	select DEFAULT_UIMAGE
-	select PPC_E500MC
-	select PHYS_64BIT
-	select SWIOTLB
-	select MPC8xxx_GPIO
-	select HAS_RAPIDIO
-	select PPC_EPAPR_HV_PIC
-	help
-	  This option enables support for the P4080 DS board
+	  This option enables support for the Freescale boards
+	  based on the QorIQ CPU with DPA: P2040 RDB, P3041 DS and
+	  P4080 DS boards
 
 endif # PPC32
 
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index a971b32..43b2162 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -13,9 +13,7 @@ obj-$(CONFIG_MPC85xx_RDB) += mpc85xx_rdb.o
 obj-$(CONFIG_P1010_RDB)   += p1010rdb.o
 obj-$(CONFIG_P1022_DS)    += p1022_ds.o
 obj-$(CONFIG_P1023_RDS)   += p1023_rds.o
-obj-$(CONFIG_P2040_RDB)   += p2040_rdb.o corenet_ds.o
-obj-$(CONFIG_P3041_DS)    += p3041_ds.o corenet_ds.o
-obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
+obj-$(CONFIG_QORIQ_DPA_DS)    += qoriq_dpa_ds.o corenet_ds.o
 obj-$(CONFIG_P5020_DS)    += p5020_ds.o corenet_ds.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
diff --git a/arch/powerpc/platforms/85xx/p2040_rdb.c b/arch/powerpc/platforms/85xx/p2040_rdb.c
deleted file mode 100644
index 32b56ac..0000000
--- a/arch/powerpc/platforms/85xx/p2040_rdb.c
+++ /dev/null
@@ -1,88 +0,0 @@
-/*
- * P2040 RDB Setup
- *
- * Copyright 2011 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/phy.h>
-
-#include <asm/system.h>
-#include <asm/time.h>
-#include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
-#include <asm/udbg.h>
-#include <asm/mpic.h>
-
-#include <linux/of_platform.h>
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
-#include <asm/ehv_pic.h>
-
-#include "corenet_ds.h"
-
-/*
- * Called very early, device-tree isn't unflattened
- */
-static int __init p2040_rdb_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-#ifdef CONFIG_SMP
-	extern struct smp_ops_t smp_85xx_ops;
-#endif
-
-	if (of_flat_dt_is_compatible(root, "fsl,P2040RDB"))
-		return 1;
-
-	/* Check if we're running under the Freescale hypervisor */
-	if (of_flat_dt_is_compatible(root, "fsl,P2040RDB-hv")) {
-		ppc_md.init_IRQ = ehv_pic_init;
-		ppc_md.get_irq = ehv_pic_get_irq;
-		ppc_md.restart = fsl_hv_restart;
-		ppc_md.power_off = fsl_hv_halt;
-		ppc_md.halt = fsl_hv_halt;
-#ifdef CONFIG_SMP
-		/*
-		 * Disable the timebase sync operations because we can't write
-		 * to the timebase registers under the hypervisor.
-		  */
-		smp_85xx_ops.give_timebase = NULL;
-		smp_85xx_ops.take_timebase = NULL;
-#endif
-		return 1;
-	}
-
-	return 0;
-}
-
-define_machine(p2040_rdb) {
-	.name			= "P2040 RDB",
-	.probe			= p2040_rdb_probe,
-	.setup_arch		= corenet_ds_setup_arch,
-	.init_IRQ		= corenet_ds_pic_init,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-#endif
-	.get_irq		= mpic_get_coreint_irq,
-	.restart		= fsl_rstcr_restart,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-	.power_save		= e500_idle,
-};
-
-machine_device_initcall(p2040_rdb, corenet_ds_publish_devices);
-
-#ifdef CONFIG_SWIOTLB
-machine_arch_initcall(p2040_rdb, swiotlb_setup_bus_notifier);
-#endif
diff --git a/arch/powerpc/platforms/85xx/p3041_ds.c b/arch/powerpc/platforms/85xx/p3041_ds.c
deleted file mode 100644
index 96d99a3..0000000
--- a/arch/powerpc/platforms/85xx/p3041_ds.c
+++ /dev/null
@@ -1,90 +0,0 @@
-/*
- * P3041 DS Setup
- *
- * Maintained by Kumar Gala (see MAINTAINERS for contact information)
- *
- * Copyright 2009-2010 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/phy.h>
-
-#include <asm/system.h>
-#include <asm/time.h>
-#include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
-#include <asm/udbg.h>
-#include <asm/mpic.h>
-
-#include <linux/of_platform.h>
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
-#include <asm/ehv_pic.h>
-
-#include "corenet_ds.h"
-
-/*
- * Called very early, device-tree isn't unflattened
- */
-static int __init p3041_ds_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-#ifdef CONFIG_SMP
-	extern struct smp_ops_t smp_85xx_ops;
-#endif
-
-	if (of_flat_dt_is_compatible(root, "fsl,P3041DS"))
-		return 1;
-
-	/* Check if we're running under the Freescale hypervisor */
-	if (of_flat_dt_is_compatible(root, "fsl,P3041DS-hv")) {
-		ppc_md.init_IRQ = ehv_pic_init;
-		ppc_md.get_irq = ehv_pic_get_irq;
-		ppc_md.restart = fsl_hv_restart;
-		ppc_md.power_off = fsl_hv_halt;
-		ppc_md.halt = fsl_hv_halt;
-#ifdef CONFIG_SMP
-		/*
-		 * Disable the timebase sync operations because we can't write
-		 * to the timebase registers under the hypervisor.
-		  */
-		smp_85xx_ops.give_timebase = NULL;
-		smp_85xx_ops.take_timebase = NULL;
-#endif
-		return 1;
-	}
-
-	return 0;
-}
-
-define_machine(p3041_ds) {
-	.name			= "P3041 DS",
-	.probe			= p3041_ds_probe,
-	.setup_arch		= corenet_ds_setup_arch,
-	.init_IRQ		= corenet_ds_pic_init,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-#endif
-	.get_irq		= mpic_get_coreint_irq,
-	.restart		= fsl_rstcr_restart,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-	.power_save		= e500_idle,
-};
-
-machine_device_initcall(p3041_ds, corenet_ds_publish_devices);
-
-#ifdef CONFIG_SWIOTLB
-machine_arch_initcall(p3041_ds, swiotlb_setup_bus_notifier);
-#endif
diff --git a/arch/powerpc/platforms/85xx/p4080_ds.c b/arch/powerpc/platforms/85xx/qoriq_dpa_ds.c
similarity index 72%
rename from arch/powerpc/platforms/85xx/p4080_ds.c
rename to arch/powerpc/platforms/85xx/qoriq_dpa_ds.c
index d1b21d7..2f5eaea 100644
--- a/arch/powerpc/platforms/85xx/p4080_ds.c
+++ b/arch/powerpc/platforms/85xx/qoriq_dpa_ds.c
@@ -1,9 +1,9 @@
 /*
- * P4080 DS Setup
+ * Setup for Freescale boards based on QorIQ with DPA
  *
  * Maintained by Kumar Gala (see MAINTAINERS for contact information)
  *
- * Copyright 2009 Freescale Semiconductor Inc.
+ * Copyright 2009-2011 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -36,18 +36,22 @@
 /*
  * Called very early, device-tree isn't unflattened
  */
-static int __init p4080_ds_probe(void)
+static int __init qoriq_dpa_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 #ifdef CONFIG_SMP
 	extern struct smp_ops_t smp_85xx_ops;
 #endif
 
-	if (of_flat_dt_is_compatible(root, "fsl,P4080DS"))
+	if (of_flat_dt_is_compatible(root, "fsl,P2040RDB") ||
+	    of_flat_dt_is_compatible(root, "fsl,P3041DS") ||
+	    of_flat_dt_is_compatible(root, "fsl,P4080DS")) {
 		return 1;
 
 	/* Check if we're running under the Freescale hypervisor */
-	if (of_flat_dt_is_compatible(root, "fsl,P4080DS-hv")) {
+	if (of_flat_dt_is_compatible(root, "fsl,P2040RDB-hv") ||
+	    of_flat_dt_is_compatible(root, "fsl,P3041DS-hv") ||
+	    of_flat_dt_is_compatible(root, "fsl,P4080DS-hv")) {
 		ppc_md.init_IRQ = ehv_pic_init;
 		ppc_md.get_irq = ehv_pic_get_irq;
 		ppc_md.restart = fsl_hv_restart;
@@ -67,9 +71,9 @@ static int __init p4080_ds_probe(void)
 	return 0;
 }
 
-define_machine(p4080_ds) {
-	.name			= "P4080 DS",
-	.probe			= p4080_ds_probe,
+define_machine(qoriq_dpa) {
+	.name			= "QorIQ with DPA DS",
+	.probe			= qoriq_dpa_probe,
 	.setup_arch		= corenet_ds_setup_arch,
 	.init_IRQ		= corenet_ds_pic_init,
 #ifdef CONFIG_PCI
@@ -82,7 +86,7 @@ define_machine(p4080_ds) {
 	.power_save		= e500_idle,
 };
 
-machine_device_initcall(p4080_ds, corenet_ds_publish_devices);
+machine_device_initcall(qoriq_dpa, corenet_ds_publish_devices);
 #ifdef CONFIG_SWIOTLB
-machine_arch_initcall(p4080_ds, swiotlb_setup_bus_notifier);
+machine_arch_initcall(qoriq_dpa, swiotlb_setup_bus_notifier);
 #endif
-- 
1.7.2.5
