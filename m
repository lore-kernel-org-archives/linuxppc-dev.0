Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 145EADDEC8
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 21:20:09 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 8C585143DA
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 13:20:06 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14326-08 for <linuxppc-dev@ozlabs.org>;
	Sun,  7 Oct 2007 13:20:04 +0200 (CEST)
Message-ID: <4708C0DA.2040606@semihalf.com>
Date: Sun, 07 Oct 2007 13:19:54 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [POWERPC 03/15] [POWERPC] TQM5200 board support
References: <47075FA7.3030108@semihalf.com>
In-Reply-To: <47075FA7.3030108@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Add arch/powerpc board support for TQM5200.

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
Signed-off-by: Jan Wrobel <wrr@semihalf.com>
---

 Kconfig   |    5 +
 Makefile  |    1 
 tqm5200.c |  174 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+)

diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index 3ffaa06..7c828eb 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -33,4 +33,9 @@ config PPC_LITE5200
 	select PPC_MPC5200
 	default n
 
+config PPC_TQM5200
+	bool "TQM5200 Board"
+ 	depends on PPC_MULTIPLATFORM && PPC32
+ 	select PPC_MPC5200
+ 	default n
 
diff --git a/arch/powerpc/platforms/52xx/Makefile b/arch/powerpc/platforms/52xx/Makefile
index b91e39c..4997ebf 100644
--- a/arch/powerpc/platforms/52xx/Makefile
+++ b/arch/powerpc/platforms/52xx/Makefile
@@ -8,5 +8,6 @@ endif
 
 obj-$(CONFIG_PPC_EFIKA)		+= efika.o
 obj-$(CONFIG_PPC_LITE5200)	+= lite5200.o
+obj-$(CONFIG_PPC_TQM5200)	+= tqm5200.o
 
 obj-$(CONFIG_PM)		+= mpc52xx_sleep.o mpc52xx_pm.o
diff --git a/arch/powerpc/platforms/52xx/tqm5200.c b/arch/powerpc/platforms/52xx/tqm5200.c
new file mode 100644
index 0000000..780b79f
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/tqm5200.c
@@ -0,0 +1,174 @@
+/*
+ * TQM5200 board support
+ *
+ * Written by: Grant Likely <grant.likely@secretlab.ca> for lite5200
+ * Adapted for tqm5200 by: Jan Wrobel <wrr@semihalf.com>
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
+#undef DEBUG
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
+#include <asm/of_platform.h>
+
+#include <asm/mpc52xx.h>
+
+/* ************************************************************************
+ *
+ * Setup the architecture
+ *
+ */
+static void __init
+tqm5200_setup_cpu(void)
+{
+	struct mpc52xx_gpio __iomem *gpio;
+	u32 port_config;
+
+	/* Map zones */
+	gpio = mpc52xx_find_and_map("mpc5200-gpio");
+	if (!gpio) {
+		printk(KERN_ERR __FILE__ ": "
+			"Error while mapping GPIO register for port config. "
+			"Expect some abnormal behavior\n");
+		goto error;
+	}
+
+	/* Set port config */
+	port_config = in_be32(&gpio->port_config);
+
+	port_config &= ~0x00800000;	/* 48Mhz internal, pin is GPIO	*/
+
+	port_config &= ~0x00007000;	/* USB port : Differential mode	*/
+	port_config |=  0x00001000;	/*            USB 1 only	*/
+
+	port_config &= ~0x03000000;	/* ATA CS is on csb_4/5		*/
+	port_config |=  0x01000000;
+
+	pr_debug("port_config: old:%x new:%x\n",
+	         in_be32(&gpio->port_config), port_config);
+	out_be32(&gpio->port_config, port_config);
+
+	/* Unmap zone */
+error:
+	iounmap(gpio);
+}
+
+static void __init tqm5200_setup_arch(void)
+{
+	struct device_node *np;
+
+	if (ppc_md.progress)
+		ppc_md.progress("tqm5200_setup_arch()", 0);
+
+	np = of_find_node_by_type(NULL, "cpu");
+	if (np) {
+		unsigned int *fp =
+		    (int *)of_get_property(np, "clock-frequency", NULL);
+		if (fp != 0)
+			loops_per_jiffy = *fp / HZ;
+		else
+			loops_per_jiffy = 50000000 / HZ;
+		of_node_put(np);
+	}
+
+	/* CPU & Port mux setup */
+	mpc52xx_setup_cpu();
+	tqm5200_setup_cpu();
+
+#ifdef CONFIG_PCI
+	np = of_find_node_by_type(NULL, "pci");
+	if (np) {
+		mpc52xx_add_bridge(np);
+		of_node_put(np);
+	}
+#endif
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		/*
+		 * We want the proper initrd behavior, i.e., launching of
+		 * /linuxrc from the initial root file system, and not only
+		 * mounting it as the normal root file system.
+		 */
+		ROOT_DEV = 0x0;
+	else
+#endif
+#ifdef  CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+		ROOT_DEV = Root_HDA1;
+#endif
+
+}
+
+void tqm5200_show_cpuinfo(struct seq_file *m)
+{
+	struct device_node* np = of_find_all_nodes(NULL);
+	const char *model = NULL;
+
+	if (np)
+		model = of_get_property(np, "model", NULL);
+
+	seq_printf(m, "vendor\t\t:	Freescale Semiconductor\n");
+	seq_printf(m, "machine\t\t:	%s\n", model ? model : "unknown");
+
+	of_node_put(np);
+}
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init tqm5200_probe(void)
+{
+	unsigned long node = of_get_flat_dt_root();
+	const char *model = of_get_flat_dt_prop(node, "model", NULL);
+
+	if (!of_flat_dt_is_compatible(node, "fsl,tqm5200"))
+		return 0;
+	pr_debug("%s board found\n", model ? model : "unknown");
+
+	return 1;
+}
+
+define_machine(tqm5200) {
+	.name		= "tqm5200",
+	.probe		= tqm5200_probe,
+	.setup_arch	= tqm5200_setup_arch,
+	.init		= mpc52xx_declare_of_platform_devices,
+	.init_IRQ	= mpc52xx_init_irq,
+	.get_irq	= mpc52xx_get_irq,
+	.show_cpuinfo	= tqm5200_show_cpuinfo,
+	.calibrate_decr	= generic_calibrate_decr,
+};
