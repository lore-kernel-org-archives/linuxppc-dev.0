Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id E9DF767DE3
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 08:17:35 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 7/9] [POWERPC] Add lite5200 board support to arch/powerpc
Date: Mon, 27 Nov 2006 14:16:28 -0700
Message-Id: <11646622083725-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11646622072224-git-send-email-grant.likely@secretlab.ca>
References: <1164662190802-git-send-email-grant.likely@secretlab.ca>
	<11646622052490-git-send-email-grant.likely@secretlab.ca>
	<11646622063980-git-send-email-grant.likely@secretlab.ca>
	<11646622073115-git-send-email-grant.likely@secretlab.ca>
	<11646622072999-git-send-email-grant.likely@secretlab.ca>
	<1164662207513-git-send-email-grant.likely@secretlab.ca>
	<11646622072224-git-send-email-grant.likely@secretlab.ca>
Cc: Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/Kconfig                   |    6 +
 arch/powerpc/platforms/52xx/Makefile   |    3 +-
 arch/powerpc/platforms/52xx/lite5200.c |  162 ++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2c6f8d1..90efb0a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -420,6 +420,12 @@ config PPC_EFIKA
 	select PPC_MPC52xx
 	default y
 
+config PPC_LITE5200
+	bool "Freescale Lite5200 Eval Board"
+	depends on PPC_MULTIPLATFORM && PPC32
+	select PPC_MPC52xx
+	default n
+
 config PPC_PMAC
 	bool "Apple PowerMac based machines"
 	depends on PPC_MULTIPLATFORM
diff --git a/arch/powerpc/platforms/52xx/Makefile b/arch/powerpc/platforms/52xx/Makefile
index b8f27a8..a46184a 100644
--- a/arch/powerpc/platforms/52xx/Makefile
+++ b/arch/powerpc/platforms/52xx/Makefile
@@ -5,4 +5,5 @@ ifeq ($(CONFIG_PPC_MERGE),y)
 obj-y				+= mpc52xx_pic.o mpc52xx_common.o
 endif
 
-obj-$(CONFIG_PPC_EFIKA) += efika-setup.o efika-pci.o
+obj-$(CONFIG_PPC_EFIKA)		+= efika-setup.o efika-pci.o
+obj-$(CONFIG_PPC_LITE5200)	+= lite5200.o
diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
new file mode 100644
index 0000000..fddd1bc
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -0,0 +1,162 @@
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
+#include <asm/qe.h>
+#include <asm/qe_ic.h>
+#include <asm/of_platform.h>
+
+#include <asm/mpc52xx.h>
+
+/* ************************************************************************
+ *
+ * Setup the architecture
+ *
+ */
+
+static void __init
+lite52xx_setup_cpu(void)
+{
+	struct mpc52xx_gpio __iomem *gpio;
+	u32 port_config;
+
+	/* Map zones */
+	gpio = mpc52xx_find_and_map("mpc52xx-gpio");
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
+static void __init lite52xx_setup_arch(void)
+{
+	struct device_node *np;
+
+	if (ppc_md.progress)
+		ppc_md.progress("lite52xx_setup_arch()", 0);
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
+	/* CPU & Port mux setup */
+	mpc52xx_setup_cpu();	/* Generic */
+	lite52xx_setup_cpu();	/* Platorm specific */
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
+
+}
+
+void lite52xx_show_cpuinfo(struct seq_file *m)
+{
+	struct device_node* np = of_find_all_nodes(NULL);
+	const char *model = NULL;
+
+	if (np)
+		model = get_property(np, "model", NULL);
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
+static int __init lite52xx_probe(void)
+{
+	unsigned long node = of_get_flat_dt_root();
+	const char *model = of_get_flat_dt_prop(node, "model", NULL);
+
+	if (!of_flat_dt_is_compatible(node, "lite52xx"))
+		return 0;
+	pr_debug("%s board w/ mpc52xx found\n", model ? model : "unknown");
+
+	return 1;
+}
+
+define_machine(lite52xx) {
+	.name 		= "lite52xx",
+	.probe 		= lite52xx_probe,
+	.setup_arch 	= lite52xx_setup_arch,
+	.init_IRQ 	= mpc52xx_init_irq,
+	.get_irq 	= mpc52xx_get_irq,
+	.show_cpuinfo	= lite52xx_show_cpuinfo,
+	.calibrate_decr	= generic_calibrate_decr,
+};
-- 
1.4.3.rc2.g0503
