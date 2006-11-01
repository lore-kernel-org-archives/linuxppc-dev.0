Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 9C99067EDE
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Nov 2006 19:40:37 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Sylvain Munaut <tnt@246tnt.com>, linuxppc-embedded@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] [POWERPC] Add support for lite5200b to arch/powerpc
Date: Wed,  1 Nov 2006 01:39:56 -0700
Message-Id: <11623704073652-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11623704072881-git-send-email-grant.likely@secretlab.ca>
References: <11623703962380-git-send-email-grant.likely@secretlab.ca>
	<11623704061869-git-send-email-grant.likely@secretlab.ca>
	<11623704063907-git-send-email-grant.likely@secretlab.ca>
	<11623704071131-git-send-email-grant.likely@secretlab.ca>
	<1162370407105-git-send-email-grant.likely@secretlab.ca>
	<11623704073308-git-send-email-grant.likely@secretlab.ca>
	<11623704072881-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Here is an inital attempt at porting the lite5200b to arch/powerpc.  Many
things are probably missing/broken

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/platforms/embedded6xx/Makefile   |    1 +
 arch/powerpc/platforms/embedded6xx/lite5200.c |  156 +++++++++++++++++++++++++
 2 files changed, 157 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/platforms/embedded6xx/Makefile
index fa499fe..a33f34d 100644
--- a/arch/powerpc/platforms/embedded6xx/Makefile
+++ b/arch/powerpc/platforms/embedded6xx/Makefile
@@ -2,3 +2,4 @@ #
 # Makefile for the 6xx/7xx/7xxxx linux kernel.
 #
 obj-$(CONFIG_MPC7448HPC2)	+= mpc7448_hpc2.o
+obj-$(CONFIG_LITE5200)		+= lite5200.o
diff --git a/arch/powerpc/platforms/embedded6xx/lite5200.c b/arch/powerpc/platforms/embedded6xx/lite5200.c
new file mode 100644
index 0000000..fd14dec
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/lite5200.c
@@ -0,0 +1,156 @@
+/*
+ * Freescale Lite5200 board support
+ *
+ * Written by: Grant Likely <grant.likely@secretlab.ca>
+ *
+ * Copyright (C) Secret Lab Technologies Ltd. 2006. All rights reserved.
+ * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Description:
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#define DEBUG
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/major.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/initrd.h>
+
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/ipic.h>
+#include <asm/bootinfo.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <sysdev/fsl_soc.h>
+#include <asm/qe.h>
+#include <asm/qe_ic.h>
+#include <asm/of_device.h>
+
+#include <asm/mpc52xx.h>
+
+#ifndef CONFIG_PCI
+unsigned long isa_io_base = 0;
+unsigned long isa_mem_base = 0;
+#endif
+
+/* ************************************************************************
+ *
+ * Setup the architecture
+ *
+ */
+
+static int __init mpc52xx_declare_of_platform_devices(void)
+{
+	struct device_node *np;
+	struct device_node *cnp = NULL;
+	const u32 *base;
+	char *name;
+
+	/* Find every child of the SOC node and add it to of_platform */
+	np = of_find_node_by_name(NULL, "soc5200");
+	if (np) {
+		while ((cnp = of_get_next_child(np, cnp))) {
+			name = kmalloc(BUS_ID_SIZE, GFP_KERNEL);
+			strcpy(name, cnp->name);
+
+			base = get_property(cnp, "reg", NULL);
+			if (base)
+				sprintf(name+strlen(name), "@%x", *base);
+
+			of_platform_device_create(cnp, name, NULL);
+		}
+	}
+
+	return 0;
+}
+
+device_initcall(mpc52xx_declare_of_platform_devices);
+
+static void __init lite5200_setup_arch(void)
+{
+	struct device_node *np;
+
+	if (ppc_md.progress)
+		ppc_md.progress("lite5200_setup_arch()", 0);
+
+	np = of_find_node_by_type(NULL, "cpu");
+	if (np) {
+		unsigned int *fp =
+		    (int *)get_property(np, "clock-frequency", NULL);
+		if (fp != 0)
+			loops_per_jiffy = *fp / HZ;
+		else
+			loops_per_jiffy = 50000000 / HZ;
+		of_node_put(np);
+	}
+
+#ifdef CONFIG_PCI
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+		add_bridge(np);
+
+	ppc_md.pci_swizzle = common_swizzle;
+	ppc_md.pci_exclude_device = mpc52xx_exclude_device;
+#endif
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else
+#endif
+#ifdef  CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+		ROOT_DEV = Root_HDA1;
+#endif
+}
+
+void lite5200_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "vendor\t\t:	Freescale Semiconductor\n");
+	seq_printf(m, "machine\t\t:	Lite5200\n");
+}
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init lite5200_probe(void)
+{
+	char *compatible = of_get_flat_dt_prop(of_get_flat_dt_root(),
+	                                       "compatible", NULL);
+
+	if (compatible == NULL)
+		return 0;
+	if (strcmp(compatible, "mpc5200"))
+		return 0;
+
+	pr_debug("%s-based board found\n", compatible);
+
+	return 1;
+}
+
+define_machine(mpc52xx) {
+	.name 		= "mpc52xx",
+	.probe 		= lite5200_probe,
+	.setup_arch 	= lite5200_setup_arch,
+	.init_IRQ 	= mpc52xx_init_irq,
+	.show_cpuinfo	= lite5200_show_cpuinfo,
+	.calibrate_decr	= generic_calibrate_decr,
+};
-- 
1.4.3.rc2.g0503
