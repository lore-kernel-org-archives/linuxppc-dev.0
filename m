Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 805DE2C01E6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Sep 2013 17:43:11 +1000 (EST)
Received: by mail-pa0-f53.google.com with SMTP id kq14so1086085pab.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Sep 2013 00:43:09 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2 1/2] powerpc/85xx: introduce corenet_generic machine
Date: Sun, 22 Sep 2013 15:42:29 +0800
Message-Id: <1379835750-23999-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1379835750-23999-1-git-send-email-haokexin@gmail.com>
References: <1379835750-23999-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the current kernel, the board files for p2041rdb, p3041ds, p4080ds,
p5020ds, p5040ds, t4240qds and b4qds are almost the same except the
machine name. So this introduces a cornet_generic machine to support
all these boards to avoid the code duplication.

With these changes the file corenet_ds.h becomes useless. Just delete
it.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2:
  - Fix the typo in subject.
  - Fold the original patch 2 into this one.
  - Change the machine name from "CORENET GENERIC" to "CORENET Generic".

v1:
  - This patch is based on http://patchwork.ozlabs.org/patch/274390/

 arch/powerpc/platforms/85xx/Kconfig      | 10 ++++
 arch/powerpc/platforms/85xx/Makefile     |  8 +--
 arch/powerpc/platforms/85xx/b4_qds.c     | 97 --------------------------------
 arch/powerpc/platforms/85xx/corenet_ds.c | 86 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/corenet_ds.h | 19 -------
 arch/powerpc/platforms/85xx/p2041_rdb.c  | 87 ----------------------------
 arch/powerpc/platforms/85xx/p3041_ds.c   | 89 -----------------------------
 arch/powerpc/platforms/85xx/p4080_ds.c   | 87 ----------------------------
 arch/powerpc/platforms/85xx/p5020_ds.c   | 93 ------------------------------
 arch/powerpc/platforms/85xx/p5040_ds.c   | 84 ---------------------------
 arch/powerpc/platforms/85xx/t4240_qds.c  | 93 ------------------------------
 11 files changed, 97 insertions(+), 656 deletions(-)
 delete mode 100644 arch/powerpc/platforms/85xx/b4_qds.c
 delete mode 100644 arch/powerpc/platforms/85xx/corenet_ds.h
 delete mode 100644 arch/powerpc/platforms/85xx/p2041_rdb.c
 delete mode 100644 arch/powerpc/platforms/85xx/p3041_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/p4080_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/p5020_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/p5040_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/t4240_qds.c

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index de2eb93..3bee943 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -228,6 +228,7 @@ config P2041_RDB
 	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
+	select CORENET_GENERIC
 	help
 	  This option enables support for the P2041 RDB board
 
@@ -241,6 +242,7 @@ config P3041_DS
 	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
+	select CORENET_GENERIC
 	help
 	  This option enables support for the P3041 DS board
 
@@ -254,6 +256,7 @@ config P4080_DS
 	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
+	select CORENET_GENERIC
 	help
 	  This option enables support for the P4080 DS board
 
@@ -278,6 +281,7 @@ config P5020_DS
 	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
+	select CORENET_GENERIC
 	help
 	  This option enables support for the P5020 DS board
 
@@ -292,6 +296,7 @@ config P5040_DS
 	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
+	select CORENET_GENERIC
 	help
 	  This option enables support for the P5040 DS board
 
@@ -323,6 +328,7 @@ config T4240_QDS
 	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
+	select CORENET_GENERIC
 	help
 	  This option enables support for the T4240 QDS board
 
@@ -337,6 +343,7 @@ config B4_QDS
 	select ARCH_REQUIRE_GPIOLIB
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
+	select CORENET_GENERIC
 	help
 	  This option enables support for the B4 QDS board
 	  The B4 application development system B4 QDS is a complete
@@ -348,3 +355,6 @@ endif # FSL_SOC_BOOKE
 
 config TQM85xx
 	bool
+
+config CORENET_GENERIC
+	bool
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 53c9f75..a6c281d 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -18,13 +18,7 @@ obj-$(CONFIG_P1010_RDB)   += p1010rdb.o
 obj-$(CONFIG_P1022_DS)    += p1022_ds.o
 obj-$(CONFIG_P1022_RDK)   += p1022_rdk.o
 obj-$(CONFIG_P1023_RDS)   += p1023_rds.o
-obj-$(CONFIG_P2041_RDB)   += p2041_rdb.o corenet_ds.o
-obj-$(CONFIG_P3041_DS)    += p3041_ds.o corenet_ds.o
-obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
-obj-$(CONFIG_P5020_DS)    += p5020_ds.o corenet_ds.o
-obj-$(CONFIG_P5040_DS)    += p5040_ds.o corenet_ds.o
-obj-$(CONFIG_T4240_QDS)   += t4240_qds.o corenet_ds.o
-obj-$(CONFIG_B4_QDS)	  += b4_qds.o corenet_ds.o
+obj-$(CONFIG_CORENET_GENERIC)   += corenet_ds.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
 obj-$(CONFIG_SBC8548)     += sbc8548.o
diff --git a/arch/powerpc/platforms/85xx/b4_qds.c b/arch/powerpc/platforms/85xx/b4_qds.c
deleted file mode 100644
index 0f18663..0000000
--- a/arch/powerpc/platforms/85xx/b4_qds.c
+++ /dev/null
@@ -1,97 +0,0 @@
-/*
- * B4 QDS Setup
- * Should apply for QDS platform of B4860 and it's personalities.
- * viz B4860/B4420/B4220QDS
- *
- * Copyright 2012 Freescale Semiconductor Inc.
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
-static int __init b4_qds_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-#ifdef CONFIG_SMP
-	extern struct smp_ops_t smp_85xx_ops;
-#endif
-
-	if ((of_flat_dt_is_compatible(root, "fsl,B4860QDS")) ||
-		(of_flat_dt_is_compatible(root, "fsl,B4420QDS")) ||
-			(of_flat_dt_is_compatible(root, "fsl,B4220QDS")))
-		return 1;
-
-	/* Check if we're running under the Freescale hypervisor */
-	if ((of_flat_dt_is_compatible(root, "fsl,B4860QDS-hv")) ||
-		(of_flat_dt_is_compatible(root, "fsl,B4420QDS-hv")) ||
-			(of_flat_dt_is_compatible(root, "fsl,B4220QDS-hv"))) {
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
-define_machine(b4_qds) {
-	.name			= "B4 QDS",
-	.probe			= b4_qds_probe,
-	.setup_arch		= corenet_ds_setup_arch,
-	.init_IRQ		= corenet_ds_pic_init,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-#endif
-	.get_irq		= mpic_get_coreint_irq,
-	.restart		= fsl_rstcr_restart,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-#ifdef CONFIG_PPC64
-	.power_save		= book3e_idle,
-#else
-	.power_save		= e500_idle,
-#endif
-};
-
-machine_arch_initcall(b4_qds, corenet_ds_publish_devices);
-
-#ifdef CONFIG_SWIOTLB
-machine_arch_initcall(b4_qds, swiotlb_setup_bus_notifier);
-#endif
diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index aa3690b..7007829 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -25,6 +25,7 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
+#include <asm/ehv_pic.h>
 
 #include <linux/of_platform.h>
 #include <sysdev/fsl_soc.h>
@@ -94,3 +95,88 @@ int __init corenet_ds_publish_devices(void)
 {
 	return of_platform_bus_probe(NULL, of_device_ids, NULL);
 }
+
+static const char * const boards[] __initconst = {
+	"fsl,P2041RDB",
+	"fsl,P3041DS",
+	"fsl,P4080DS",
+	"fsl,P5020DS",
+	"fsl,P5040DS",
+	"fsl,T4240QDS",
+	"fsl,B4860QDS",
+	"fsl,B4420QDS",
+	"fsl,B4220QDS",
+	NULL
+};
+
+static const char * const hv_boards[] __initconst = {
+	"fsl,P2041RDB-hv",
+	"fsl,P3041DS-hv",
+	"fsl,P4080DS-hv",
+	"fsl,P5020DS-hv",
+	"fsl,P5040DS-hv",
+	"fsl,T4240QDS-hv",
+	"fsl,B4860QDS-hv",
+	"fsl,B4420QDS-hv",
+	"fsl,B4220QDS-hv",
+	NULL
+};
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init corenet_generic_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+#ifdef CONFIG_SMP
+	extern struct smp_ops_t smp_85xx_ops;
+#endif
+
+	if (of_flat_dt_match(root, boards))
+		return 1;
+
+	/* Check if we're running under the Freescale hypervisor */
+	if (of_flat_dt_match(root, hv_boards)) {
+		ppc_md.init_IRQ = ehv_pic_init;
+		ppc_md.get_irq = ehv_pic_get_irq;
+		ppc_md.restart = fsl_hv_restart;
+		ppc_md.power_off = fsl_hv_halt;
+		ppc_md.halt = fsl_hv_halt;
+#ifdef CONFIG_SMP
+		/*
+		 * Disable the timebase sync operations because we can't write
+		 * to the timebase registers under the hypervisor.
+		  */
+		smp_85xx_ops.give_timebase = NULL;
+		smp_85xx_ops.take_timebase = NULL;
+#endif
+		return 1;
+	}
+
+	return 0;
+}
+
+define_machine(corenet_generic) {
+	.name			= "CORENET Generic",
+	.probe			= corenet_generic_probe,
+	.setup_arch		= corenet_ds_setup_arch,
+	.init_IRQ		= corenet_ds_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_coreint_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+#ifdef CONFIG_PPC64
+	.power_save		= book3e_idle,
+#else
+	.power_save		= e500_idle,
+#endif
+};
+
+machine_arch_initcall(corenet_generic, corenet_ds_publish_devices);
+
+#ifdef CONFIG_SWIOTLB
+machine_arch_initcall(corenet_generic, swiotlb_setup_bus_notifier);
+#endif
diff --git a/arch/powerpc/platforms/85xx/corenet_ds.h b/arch/powerpc/platforms/85xx/corenet_ds.h
deleted file mode 100644
index ddd700b..0000000
--- a/arch/powerpc/platforms/85xx/corenet_ds.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Corenet based SoC DS Setup
- *
- * Copyright 2009 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#ifndef CORENET_DS_H
-#define CORENET_DS_H
-
-extern void __init corenet_ds_pic_init(void);
-extern void __init corenet_ds_setup_arch(void);
-extern int __init corenet_ds_publish_devices(void);
-
-#endif
diff --git a/arch/powerpc/platforms/85xx/p2041_rdb.c b/arch/powerpc/platforms/85xx/p2041_rdb.c
deleted file mode 100644
index 000c089..0000000
--- a/arch/powerpc/platforms/85xx/p2041_rdb.c
+++ /dev/null
@@ -1,87 +0,0 @@
-/*
- * P2041 RDB Setup
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
-static int __init p2041_rdb_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-#ifdef CONFIG_SMP
-	extern struct smp_ops_t smp_85xx_ops;
-#endif
-
-	if (of_flat_dt_is_compatible(root, "fsl,P2041RDB"))
-		return 1;
-
-	/* Check if we're running under the Freescale hypervisor */
-	if (of_flat_dt_is_compatible(root, "fsl,P2041RDB-hv")) {
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
-define_machine(p2041_rdb) {
-	.name			= "P2041 RDB",
-	.probe			= p2041_rdb_probe,
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
-machine_arch_initcall(p2041_rdb, corenet_ds_publish_devices);
-
-#ifdef CONFIG_SWIOTLB
-machine_arch_initcall(p2041_rdb, swiotlb_setup_bus_notifier);
-#endif
diff --git a/arch/powerpc/platforms/85xx/p3041_ds.c b/arch/powerpc/platforms/85xx/p3041_ds.c
deleted file mode 100644
index b3edc20..0000000
--- a/arch/powerpc/platforms/85xx/p3041_ds.c
+++ /dev/null
@@ -1,89 +0,0 @@
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
-machine_arch_initcall(p3041_ds, corenet_ds_publish_devices);
-
-#ifdef CONFIG_SWIOTLB
-machine_arch_initcall(p3041_ds, swiotlb_setup_bus_notifier);
-#endif
diff --git a/arch/powerpc/platforms/85xx/p4080_ds.c b/arch/powerpc/platforms/85xx/p4080_ds.c
deleted file mode 100644
index 54df106..0000000
--- a/arch/powerpc/platforms/85xx/p4080_ds.c
+++ /dev/null
@@ -1,87 +0,0 @@
-/*
- * P4080 DS Setup
- *
- * Maintained by Kumar Gala (see MAINTAINERS for contact information)
- *
- * Copyright 2009 Freescale Semiconductor Inc.
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
-
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
-static int __init p4080_ds_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-#ifdef CONFIG_SMP
-	extern struct smp_ops_t smp_85xx_ops;
-#endif
-
-	if (of_flat_dt_is_compatible(root, "fsl,P4080DS"))
-		return 1;
-
-	/* Check if we're running under the Freescale hypervisor */
-	if (of_flat_dt_is_compatible(root, "fsl,P4080DS-hv")) {
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
-define_machine(p4080_ds) {
-	.name			= "P4080 DS",
-	.probe			= p4080_ds_probe,
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
-machine_arch_initcall(p4080_ds, corenet_ds_publish_devices);
-#ifdef CONFIG_SWIOTLB
-machine_arch_initcall(p4080_ds, swiotlb_setup_bus_notifier);
-#endif
diff --git a/arch/powerpc/platforms/85xx/p5020_ds.c b/arch/powerpc/platforms/85xx/p5020_ds.c
deleted file mode 100644
index 39cfa40..0000000
--- a/arch/powerpc/platforms/85xx/p5020_ds.c
+++ /dev/null
@@ -1,93 +0,0 @@
-/*
- * P5020 DS Setup
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
-static int __init p5020_ds_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-#ifdef CONFIG_SMP
-	extern struct smp_ops_t smp_85xx_ops;
-#endif
-
-	if (of_flat_dt_is_compatible(root, "fsl,P5020DS"))
-		return 1;
-
-	/* Check if we're running under the Freescale hypervisor */
-	if (of_flat_dt_is_compatible(root, "fsl,P5020DS-hv")) {
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
-define_machine(p5020_ds) {
-	.name			= "P5020 DS",
-	.probe			= p5020_ds_probe,
-	.setup_arch		= corenet_ds_setup_arch,
-	.init_IRQ		= corenet_ds_pic_init,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-#endif
-	.get_irq		= mpic_get_coreint_irq,
-	.restart		= fsl_rstcr_restart,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-#ifdef CONFIG_PPC64
-	.power_save		= book3e_idle,
-#else
-	.power_save		= e500_idle,
-#endif
-};
-
-machine_arch_initcall(p5020_ds, corenet_ds_publish_devices);
-
-#ifdef CONFIG_SWIOTLB
-machine_arch_initcall(p5020_ds, swiotlb_setup_bus_notifier);
-#endif
diff --git a/arch/powerpc/platforms/85xx/p5040_ds.c b/arch/powerpc/platforms/85xx/p5040_ds.c
deleted file mode 100644
index f70e74c..0000000
--- a/arch/powerpc/platforms/85xx/p5040_ds.c
+++ /dev/null
@@ -1,84 +0,0 @@
-/*
- * P5040 DS Setup
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
-
-#include <asm/machdep.h>
-#include <asm/udbg.h>
-#include <asm/mpic.h>
-
-#include <linux/of_fdt.h>
-
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
-#include <asm/ehv_pic.h>
-
-#include "corenet_ds.h"
-
-/*
- * Called very early, device-tree isn't unflattened
- */
-static int __init p5040_ds_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-#ifdef CONFIG_SMP
-	extern struct smp_ops_t smp_85xx_ops;
-#endif
-
-	if (of_flat_dt_is_compatible(root, "fsl,P5040DS"))
-		return 1;
-
-	/* Check if we're running under the Freescale hypervisor */
-	if (of_flat_dt_is_compatible(root, "fsl,P5040DS-hv")) {
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
-define_machine(p5040_ds) {
-	.name			= "P5040 DS",
-	.probe			= p5040_ds_probe,
-	.setup_arch		= corenet_ds_setup_arch,
-	.init_IRQ		= corenet_ds_pic_init,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-#endif
-	.get_irq		= mpic_get_coreint_irq,
-	.restart		= fsl_rstcr_restart,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-#ifdef CONFIG_PPC64
-	.power_save		= book3e_idle,
-#else
-	.power_save		= e500_idle,
-#endif
-};
-
-machine_arch_initcall(p5040_ds, corenet_ds_publish_devices);
-
-#ifdef CONFIG_SWIOTLB
-machine_arch_initcall(p5040_ds, swiotlb_setup_bus_notifier);
-#endif
diff --git a/arch/powerpc/platforms/85xx/t4240_qds.c b/arch/powerpc/platforms/85xx/t4240_qds.c
deleted file mode 100644
index 91ead6b..0000000
--- a/arch/powerpc/platforms/85xx/t4240_qds.c
+++ /dev/null
@@ -1,93 +0,0 @@
-/*
- * T4240 QDS Setup
- *
- * Maintained by Kumar Gala (see MAINTAINERS for contact information)
- *
- * Copyright 2012 Freescale Semiconductor Inc.
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
-static int __init t4240_qds_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-#ifdef CONFIG_SMP
-	extern struct smp_ops_t smp_85xx_ops;
-#endif
-
-	if (of_flat_dt_is_compatible(root, "fsl,T4240QDS"))
-		return 1;
-
-	/* Check if we're running under the Freescale hypervisor */
-	if (of_flat_dt_is_compatible(root, "fsl,T4240QDS-hv")) {
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
-define_machine(t4240_qds) {
-	.name			= "T4240 QDS",
-	.probe			= t4240_qds_probe,
-	.setup_arch		= corenet_ds_setup_arch,
-	.init_IRQ		= corenet_ds_pic_init,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-#endif
-	.get_irq		= mpic_get_coreint_irq,
-	.restart		= fsl_rstcr_restart,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-#ifdef CONFIG_PPC64
-	.power_save		= book3e_idle,
-#else
-	.power_save		= e500_idle,
-#endif
-};
-
-machine_arch_initcall(t4240_qds, corenet_ds_publish_devices);
-
-#ifdef CONFIG_SWIOTLB
-machine_arch_initcall(t4240_qds, swiotlb_setup_bus_notifier);
-#endif
-- 
1.8.3.1
