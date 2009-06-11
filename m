Return-Path: <ncase@xes-inc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CD203B7136
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 05:43:32 +1000 (EST)
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1ABDDDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 05:43:29 +1000 (EST)
From: Nate Case <ncase@xes-inc.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH -next 1/4] powerpc/85xx: Add platform support for X-ES MPC85xx
	boards
Date: Thu, 11 Jun 2009 14:42:58 -0500
Message-Id: <1244749381-17429-2-git-send-email-ncase@xes-inc.com>
In-Reply-To: <1244749381-17429-1-git-send-email-ncase@xes-inc.com>
References: <1244749381-17429-1-git-send-email-ncase@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org, Nate Case <ncase@xes-inc.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for X-ES single-board computers based on the Freescale
MPC85xx processors.

Signed-off-by: Nate Case <ncase@xes-inc.com>
---
 arch/powerpc/platforms/85xx/Kconfig       |   10 +
 arch/powerpc/platforms/85xx/Makefile      |    1 +
 arch/powerpc/platforms/85xx/xes_mpc85xx.c |  282 +++++++++++++++++++++++++++++
 3 files changed, 293 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/xes_mpc85xx.c

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 43d385c..e0d39bf 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -64,6 +64,16 @@ config KSI8560
         help
           This option enables support for the Emerson KSI8560 board
 
+config XES_MPC85xx
+	bool "X-ES single-board computer"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the various single-board
+	  computers from Extreme Engineering Solutions (X-ES) based on
+	  Freescale MPC85xx processors.
+	  Manufacturer: Extreme Engineering Solutions, Inc.
+	  URL: <http://www.xes-inc.com/>
+
 config STX_GP3
 	bool "Silicon Turnkey Express GP3"
 	help
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index a857b35..835733f 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_SBC8560)     += sbc8560.o
 obj-$(CONFIG_SBC8548)     += sbc8548.o
 obj-$(CONFIG_SOCRATES)    += socrates.o socrates_fpga_pic.o
 obj-$(CONFIG_KSI8560)	  += ksi8560.o
+obj-$(CONFIG_XES_MPC85xx) += xes_mpc85xx.o
\ No newline at end of file
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
new file mode 100644
index 0000000..ee01532
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -0,0 +1,282 @@
+/*
+ * Copyright (C) 2009 Extreme Engineering Solutions, Inc.
+ *
+ * X-ES board-specific functionality
+ *
+ * Based on mpc85xx_ds code from Freescale Semiconductor, Inc.
+ *
+ * Author: Nate Case <ncase@xes-inc.com>
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/interrupt.h>
+#include <linux/of_platform.h>
+
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <mm/mmu_decl.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+#include <linux/of_platform.h>
+
+/* A few bit definitions needed for fixups on some boards */
+#define MPC85xx_L2CTL_L2E		0x80000000 /* L2 enable */
+#define MPC85xx_L2CTL_L2I		0x40000000 /* L2 flash invalidate */
+#define MPC85xx_L2CTL_L2SIZ_MASK	0x30000000 /* L2 SRAM size (R/O) */
+
+void __init xes_mpc85xx_pic_init(void)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np;
+
+	np = of_find_node_by_type(NULL, "open-pic");
+	if (np == NULL) {
+		printk(KERN_ERR "Could not find open-pic node\n");
+		return;
+	}
+
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Failed to map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	mpic = mpic_alloc(np, r.start,
+			  MPIC_PRIMARY | MPIC_WANTS_RESET |
+			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
+			0, 256, " OpenPIC  ");
+	BUG_ON(mpic == NULL);
+	of_node_put(np);
+
+	mpic_init(mpic);
+}
+
+static void xes_mpc85xx_configure_l2(void __iomem *l2_base)
+{
+	volatile uint32_t ctl, tmp;
+
+	asm volatile("msync; isync");
+	tmp = in_be32(l2_base);
+
+	/*
+	 * xMon may have enabled part of L2 as SRAM, so we need to set it
+	 * up for all cache mode just to be safe.
+	 */
+	printk(KERN_INFO "xes_mpc85xx: Enabling L2 as cache\n");
+
+	ctl = MPC85xx_L2CTL_L2E | MPC85xx_L2CTL_L2I;
+	if (machine_is_compatible("MPC8540") ||
+	    machine_is_compatible("MPC8560"))
+		/*
+		 * Assume L2 SRAM is used fully for cache, so set
+		 * L2BLKSZ (bits 4:5) to match L2SIZ (bits 2:3).
+		 */
+		ctl |= (tmp & MPC85xx_L2CTL_L2SIZ_MASK) >> 2;
+
+	asm volatile("msync; isync");
+	out_be32(l2_base, ctl);
+	asm volatile("msync; isync");
+}
+
+static void xes_mpc85xx_fixups(void)
+{
+	struct device_node *np;
+	int err;
+
+	/*
+	 * Legacy xMon firmware on some X-ES boards does not enable L2
+	 * as cache.  We must ensure that they get enabled here.
+	 */
+	for_each_node_by_name(np, "l2-cache-controller") {
+		struct resource r[2];
+		void __iomem *l2_base;
+
+		/* Only MPC8548, MPC8540, and MPC8560 boards are affected */
+		if (!of_device_is_compatible(np,
+				    "fsl,mpc8548-l2-cache-controller") &&
+		    !of_device_is_compatible(np,
+				    "fsl,mpc8540-l2-cache-controller") &&
+		    !of_device_is_compatible(np,
+				    "fsl,mpc8560-l2-cache-controller"))
+			continue;
+
+		err = of_address_to_resource(np, 0, &r[0]);
+		if (err) {
+			printk(KERN_WARNING "xes_mpc85xx: Could not get "
+			       "resource for device tree node '%s'",
+			       np->full_name);
+			continue;
+		}
+
+		l2_base = ioremap(r[0].start, r[0].end - r[0].start + 1);
+
+		xes_mpc85xx_configure_l2(l2_base);
+	}
+}
+
+#ifdef CONFIG_PCI
+static int primary_phb_addr;
+#endif
+
+/*
+ * Setup the architecture
+ */
+#ifdef CONFIG_SMP
+extern void __init mpc85xx_smp_init(void);
+#endif
+static void __init xes_mpc85xx_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+	struct device_node *root;
+	const char *model = "Unknown";
+
+	root = of_find_node_by_path("/");
+	if (root == NULL)
+		return;
+
+	model = of_get_property(root, "model", NULL);
+
+	printk(KERN_INFO "X-ES MPC85xx-based single-board computer: %s\n",
+	       model + strlen("xes,"));
+
+	xes_mpc85xx_fixups();
+
+#ifdef CONFIG_PCI
+	for_each_node_by_type(np, "pci") {
+		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
+		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
+			struct resource rsrc;
+			of_address_to_resource(np, 0, &rsrc);
+			if ((rsrc.start & 0xfffff) == primary_phb_addr)
+				fsl_add_bridge(np, 1);
+			else
+				fsl_add_bridge(np, 0);
+		}
+	}
+#endif
+
+#ifdef CONFIG_SMP
+	mpc85xx_smp_init();
+#endif
+}
+
+static struct of_device_id __initdata xes_mpc85xx_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
+	{},
+};
+
+static int __init xes_mpc85xx_publish_devices(void)
+{
+	return of_platform_bus_probe(NULL, xes_mpc85xx_ids, NULL);
+}
+machine_device_initcall(xes_mpc8572, xes_mpc85xx_publish_devices);
+machine_device_initcall(xes_mpc8548, xes_mpc85xx_publish_devices);
+machine_device_initcall(xes_mpc8540, xes_mpc85xx_publish_devices);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init xes_mpc8572_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "xes,MPC8572")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+static int __init xes_mpc8548_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "xes,MPC8548")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0xb000;
+#endif
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+static int __init xes_mpc8540_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "xes,MPC8540")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0xb000;
+#endif
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+define_machine(xes_mpc8572) {
+	.name			= "X-ES MPC8572",
+	.probe			= xes_mpc8572_probe,
+	.setup_arch		= xes_mpc85xx_setup_arch,
+	.init_IRQ		= xes_mpc85xx_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
+
+define_machine(xes_mpc8548) {
+	.name			= "X-ES MPC8548",
+	.probe			= xes_mpc8548_probe,
+	.setup_arch		= xes_mpc85xx_setup_arch,
+	.init_IRQ		= xes_mpc85xx_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
+
+define_machine(xes_mpc8540) {
+	.name			= "X-ES MPC8540",
+	.probe			= xes_mpc8540_probe,
+	.setup_arch		= xes_mpc85xx_setup_arch,
+	.init_IRQ		= xes_mpc85xx_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.6.0.4
