Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id CF091DE473
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 08:41:05 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc: Add support for Wind River SBC8641D board
Date: Tue, 15 Apr 2008 18:41:30 -0400
Message-Id: <96011ba20ab9319aa866c12e2ff91ad579d26aed.1208296521.git.paul.gortmaker@windriver.com>
In-Reply-To: <1208299292-21937-1-git-send-email-paul.gortmaker@windriver.com>
References: <1208299292-21937-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds support for the Wind River SBC8641D board, based
largely on the mpc86xx_hpcn support.  The biggest difference is
the lack of the Uli and the i8259 cascade, which simplifies things.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/platforms/86xx/Kconfig    |    8 ++-
 arch/powerpc/platforms/86xx/Makefile   |    1 +
 arch/powerpc/platforms/86xx/sbc8641d.c |  164 ++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/platforms/86xx/sbc8641d.c

diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 21d1135..7442c58 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -11,6 +11,12 @@ config MPC8641_HPCN
 	help
 	  This option enables support for the MPC8641 HPCN board.
 
+config SBC8641D
+	bool "Wind River SBC8641D"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the WRS SBC8641D board.
+
 config MPC8610_HPCD
 	bool "Freescale MPC8610 HPCD"
 	select DEFAULT_UIMAGE
@@ -24,7 +30,7 @@ config MPC8641
 	select FSL_PCI if PCI
 	select PPC_UDBG_16550
 	select MPIC
-	default y if MPC8641_HPCN
+	default y if MPC8641_HPCN || SBC8641D
 
 config MPC8610
 	bool
diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/platforms/86xx/Makefile
index c967063..1b9b4a9 100644
--- a/arch/powerpc/platforms/86xx/Makefile
+++ b/arch/powerpc/platforms/86xx/Makefile
@@ -4,4 +4,5 @@
 
 obj-$(CONFIG_SMP)		+= mpc86xx_smp.o
 obj-$(CONFIG_MPC8641_HPCN)	+= mpc86xx_hpcn.o
+obj-$(CONFIG_SBC8641D)		+= sbc8641d.o
 obj-$(CONFIG_MPC8610_HPCD)	+= mpc8610_hpcd.o
diff --git a/arch/powerpc/platforms/86xx/sbc8641d.c b/arch/powerpc/platforms/86xx/sbc8641d.c
new file mode 100644
index 0000000..510a06e
--- /dev/null
+++ b/arch/powerpc/platforms/86xx/sbc8641d.c
@@ -0,0 +1,164 @@
+/*
+ * SBC8641D board specific routines
+ *
+ * Copyright 2008 Wind River Systems Inc.
+ *
+ * By Paul Gortmaker (see MAINTAINERS for contact information)
+ *
+ * Based largely on the 8641 HPCN support by Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/of_platform.h>
+
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpc86xx.h>
+#include <asm/prom.h>
+#include <mm/mmu_decl.h>
+#include <asm/udbg.h>
+
+#include <asm/mpic.h>
+
+#include <sysdev/fsl_pci.h>
+#include <sysdev/fsl_soc.h>
+
+#include "mpc86xx.h"
+
+static void __init
+sbc8641_init_irq(void)
+{
+	struct mpic *mpic1;
+	struct device_node *np;
+	struct resource res;
+
+	/* Determine PIC address. */
+	np = of_find_node_by_type(NULL, "open-pic");
+	if (np == NULL)
+		return;
+	of_address_to_resource(np, 0, &res);
+
+	/* Alloc mpic structure and per isu has 16 INT entries. */
+	mpic1 = mpic_alloc(np, res.start,
+			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			0, 256, " MPIC     ");
+	of_node_put(np);
+	BUG_ON(mpic1 == NULL);
+
+	mpic_init(mpic1);
+}
+
+static void __init
+sbc8641_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("sbc8641_setup_arch()", 0);
+
+#ifdef CONFIG_PCI
+	for_each_compatible_node(np, "pci", "fsl,mpc8641-pcie")
+		fsl_add_bridge(np, 0);
+#endif
+
+	printk("SBC8641 board from Wind River\n");
+
+#ifdef CONFIG_SMP
+	mpc86xx_smp_init();
+#endif
+}
+
+
+static void
+sbc8641_show_cpuinfo(struct seq_file *m)
+{
+	struct device_node *root;
+	uint memsize = total_memory;
+	const char *model = "";
+	uint svid = mfspr(SPRN_SVR);
+
+	seq_printf(m, "Vendor\t\t: Wind River Systems\n");
+
+	root = of_find_node_by_path("/");
+	if (root)
+		model = of_get_property(root, "model", NULL);
+	seq_printf(m, "Machine\t\t: %s\n", model);
+	of_node_put(root);
+
+	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+}
+
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init sbc8641_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "wind,sbc8641"))
+		return 1;	/* Looks good */
+
+	return 0;
+}
+
+static long __init
+mpc86xx_time_init(void)
+{
+	unsigned int temp;
+
+	/* Set the time base to zero */
+	mtspr(SPRN_TBWL, 0);
+	mtspr(SPRN_TBWU, 0);
+
+	temp = mfspr(SPRN_HID0);
+	temp |= HID0_TBEN;
+	mtspr(SPRN_HID0, temp);
+	asm volatile("isync");
+
+	return 0;
+}
+
+static __initdata struct of_device_id of_bus_ids[] = {
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(sbc8641, declare_of_platform_devices);
+
+define_machine(sbc8641) {
+	.name			= "SBC8641D",
+	.probe			= sbc8641_probe,
+	.setup_arch		= sbc8641_setup_arch,
+	.init_IRQ		= sbc8641_init_irq,
+	.show_cpuinfo		= sbc8641_show_cpuinfo,
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.time_init		= mpc86xx_time_init,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+};
-- 
1.5.4.3
