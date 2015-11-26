Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D7D971A006B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 12:00:00 +1100 (AEDT)
Received: by pacdm15 with SMTP id dm15so72770136pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 16:59:58 -0800 (PST)
Received: from circle.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id u67sm23233400pfi.74.2015.11.25.16.59.56
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 25 Nov 2015 16:59:58 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/cell: Remove the Cell QPACE code.
Date: Thu, 26 Nov 2015 11:59:47 +1100
Message-Id: <1448499587-25604-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All users of QPACE have upgraded to QPACE2 so remove the Cell QPACE code.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 arch/powerpc/boot/Makefile                |   2 -
 arch/powerpc/configs/ppc64_defconfig      |   1 -
 arch/powerpc/platforms/cell/Kconfig       |   5 -
 arch/powerpc/platforms/cell/Makefile      |   3 -
 arch/powerpc/platforms/cell/qpace_setup.c | 148 ------------------------------
 5 files changed, 159 deletions(-)
 delete mode 100644 arch/powerpc/platforms/cell/qpace_setup.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 99e4487248ff..61165101342c 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -113,7 +113,6 @@ src-plat-$(CONFIG_EPAPR_BOOT) += epapr.c epapr-wrapper.c
 src-plat-$(CONFIG_PPC_PSERIES) += pseries-head.S
 src-plat-$(CONFIG_PPC_POWERNV) += pseries-head.S
 src-plat-$(CONFIG_PPC_IBM_CELL_BLADE) += pseries-head.S
-src-plat-$(CONFIG_PPC_CELL_QPACE) += pseries-head.S
 
 src-wlib := $(sort $(src-wlib-y))
 src-plat := $(sort $(src-plat-y))
@@ -217,7 +216,6 @@ image-$(CONFIG_PPC_POWERNV)		+= zImage.pseries
 image-$(CONFIG_PPC_MAPLE)		+= zImage.maple
 image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
 image-$(CONFIG_PPC_PS3)			+= dtbImage.ps3
-image-$(CONFIG_PPC_CELL_QPACE)		+= zImage.pseries
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 2c041b535a64..b041fb607376 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -36,7 +36,6 @@ CONFIG_PS3_ROM=m
 CONFIG_PS3_FLASH=m
 CONFIG_PS3_LPM=m
 CONFIG_PPC_IBM_CELL_BLADE=y
-CONFIG_PPC_CELL_QPACE=y
 CONFIG_RTAS_FLASH=m
 CONFIG_IBMEBUS=y
 CONFIG_CPU_FREQ_PMAC64=y
diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 429fc59d2a47..d9088f0b8fcc 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -33,11 +33,6 @@ config PPC_IBM_CELL_BLADE
 	select PPC_UDBG_16550
 	select UDBG_RTAS_CONSOLE
 
-config PPC_CELL_QPACE
-	bool "IBM Cell - QPACE"
-	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
-	select PPC_CELL_COMMON
-
 config AXON_MSI
 	bool
 	depends on PPC_IBM_CELL_BLADE && PCI_MSI
diff --git a/arch/powerpc/platforms/cell/Makefile b/arch/powerpc/platforms/cell/Makefile
index 34699bddfddd..070edd1584cf 100644
--- a/arch/powerpc/platforms/cell/Makefile
+++ b/arch/powerpc/platforms/cell/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_PPC_IBM_CELL_POWERBUTTON)	+= cbe_powerbutton.o
 
 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_PPC_CELL_NATIVE)		+= smp.o
-obj-$(CONFIG_PPC_CELL_QPACE)		+= smp.o
 endif
 
 # needed only when building loadable spufs.ko
@@ -27,5 +26,3 @@ obj-$(CONFIG_SPU_BASE)			+= spu_callbacks.o spu_base.o \
 
 obj-$(CONFIG_AXON_MSI)			+= axon_msi.o
 
-# qpace setup
-obj-$(CONFIG_PPC_CELL_QPACE)		+= qpace_setup.o
diff --git a/arch/powerpc/platforms/cell/qpace_setup.c b/arch/powerpc/platforms/cell/qpace_setup.c
deleted file mode 100644
index d328140dc6f5..000000000000
--- a/arch/powerpc/platforms/cell/qpace_setup.c
+++ /dev/null
@@ -1,148 +0,0 @@
-/*
- *  linux/arch/powerpc/platforms/cell/qpace_setup.c
- *
- *  Copyright (C) 1995  Linus Torvalds
- *  Adapted from 'alpha' version by Gary Thomas
- *  Modified by Cort Dougan (cort@cs.nmt.edu)
- *  Modified by PPC64 Team, IBM Corp
- *  Modified by Cell Team, IBM Deutschland Entwicklung GmbH
- *  Modified by Benjamin Krill <ben@codiert.org>, IBM Corp.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/export.h>
-#include <linux/delay.h>
-#include <linux/irq.h>
-#include <linux/console.h>
-#include <linux/of_platform.h>
-
-#include <asm/mmu.h>
-#include <asm/processor.h>
-#include <asm/io.h>
-#include <asm/kexec.h>
-#include <asm/pgtable.h>
-#include <asm/prom.h>
-#include <asm/rtas.h>
-#include <asm/dma.h>
-#include <asm/machdep.h>
-#include <asm/time.h>
-#include <asm/cputable.h>
-#include <asm/irq.h>
-#include <asm/spu.h>
-#include <asm/spu_priv1.h>
-#include <asm/udbg.h>
-#include <asm/cell-regs.h>
-
-#include "interrupt.h"
-#include "pervasive.h"
-#include "ras.h"
-
-static void qpace_show_cpuinfo(struct seq_file *m)
-{
-	struct device_node *root;
-	const char *model = "";
-
-	root = of_find_node_by_path("/");
-	if (root)
-		model = of_get_property(root, "model", NULL);
-	seq_printf(m, "machine\t\t: CHRP %s\n", model);
-	of_node_put(root);
-}
-
-static void qpace_progress(char *s, unsigned short hex)
-{
-	printk("*** %04x : %s\n", hex, s ? s : "");
-}
-
-static const struct of_device_id qpace_bus_ids[] __initconst = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .type = "spider", },
-	{ .type = "axon", },
-	{ .type = "plb5", },
-	{ .type = "plb4", },
-	{ .type = "opb", },
-	{ .type = "ebc", },
-	{},
-};
-
-static int __init qpace_publish_devices(void)
-{
-	int node;
-
-	/* Publish OF platform devices for southbridge IOs */
-	of_platform_bus_probe(NULL, qpace_bus_ids, NULL);
-
-	/* There is no device for the MIC memory controller, thus we create
-	 * a platform device for it to attach the EDAC driver to.
-	 */
-	for_each_online_node(node) {
-		if (cbe_get_cpu_mic_tm_regs(cbe_node_to_cpu(node)) == NULL)
-			continue;
-		platform_device_register_simple("cbe-mic", node, NULL, 0);
-	}
-
-	return 0;
-}
-machine_subsys_initcall(qpace, qpace_publish_devices);
-
-static void __init qpace_setup_arch(void)
-{
-#ifdef CONFIG_SPU_BASE
-	spu_priv1_ops = &spu_priv1_mmio_ops;
-	spu_management_ops = &spu_management_of_ops;
-#endif
-
-	cbe_regs_init();
-
-#ifdef CONFIG_CBE_RAS
-	cbe_ras_init();
-#endif
-
-#ifdef CONFIG_SMP
-	smp_init_cell();
-#endif
-
-	/* init to some ~sane value until calibrate_delay() runs */
-	loops_per_jiffy = 50000000;
-
-	cbe_pervasive_init();
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-}
-
-static int __init qpace_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "IBM,QPACE"))
-		return 0;
-
-	hpte_init_native();
-	pm_power_off = rtas_power_off;
-
-	return 1;
-}
-
-define_machine(qpace) {
-	.name			= "QPACE",
-	.probe			= qpace_probe,
-	.setup_arch		= qpace_setup_arch,
-	.show_cpuinfo		= qpace_show_cpuinfo,
-	.restart		= rtas_restart,
-	.halt			= rtas_halt,
-	.get_boot_time		= rtas_get_boot_time,
-	.get_rtc_time		= rtas_get_rtc_time,
-	.set_rtc_time		= rtas_set_rtc_time,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= qpace_progress,
-	.init_IRQ		= iic_init_IRQ,
-};
-- 
2.5.0
