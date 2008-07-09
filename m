Return-Path: <jrigby@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 815B2DE16C
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 06:54:17 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m69Ks9Od016576
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 13:54:10 -0700 (MST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4][Version 3] MPC5121 Add generic board support
Date: Wed,  9 Jul 2008 14:54:03 -0600
Message-Id: <1215636844-32040-4-git-send-email-jrigby@freescale.com>
In-Reply-To: <1215636844-32040-3-git-send-email-jrigby@freescale.com>
References: <1215636844-32040-1-git-send-email-jrigby@freescale.com>
	<1215636844-32040-2-git-send-email-jrigby@freescale.com>
	<1215636844-32040-3-git-send-email-jrigby@freescale.com>
Cc: John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move shared code from mpc5121_ads.c to new file mpc512x_shared.c
    mpc512x_find_ips_freq -> unchanged
    contents of mpc5121_ads_init_IRQ -> mpc512x_init_IRQ
	looking for fsl,mpc5121-ipic instead of fsl,ipic
    mpc5121_ads_declare_of_platform_devices -> mpc5121_declare_of_platform_devices
	and use compatible for lookup instead of node name

Add new generic board setup mpc5121_generic.c

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/platforms/512x/Kconfig                |   15 ++++-
 arch/powerpc/platforms/512x/Makefile               |    3 +-
 arch/powerpc/platforms/512x/mpc5121_ads.c          |   64 ++------------------
 arch/powerpc/platforms/512x/mpc5121_generic.c      |   58 ++++++++++++++++++
 arch/powerpc/platforms/512x/mpc512x.h              |   17 +++++
 .../512x/{mpc5121_ads.c => mpc512x_shared.c}       |   57 ++++++------------
 6 files changed, 112 insertions(+), 102 deletions(-)
 create mode 100644 arch/powerpc/platforms/512x/mpc5121_generic.c
 create mode 100644 arch/powerpc/platforms/512x/mpc512x.h
 copy arch/powerpc/platforms/512x/{mpc5121_ads.c => mpc512x_shared.c} (55%)

diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index 162af06..5d72dc3 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -3,12 +3,10 @@ config PPC_MPC512x
 	select FSL_SOC
 	select IPIC
 	select PPC_CLOCK
-	default n
 
 config PPC_MPC5121
 	bool
 	select PPC_MPC512x
-	default n
 
 config MPC5121_ADS
 	bool "Freescale MPC5121E ADS"
@@ -17,4 +15,15 @@ config MPC5121_ADS
 	select PPC_MPC5121
 	help
 	  This option enables support for the MPC5121E ADS board.
-	default n
+
+config MPC5121_GENERIC
+	bool "Generic support for simple MPC5121 based boards"
+	depends on PPC_MULTIPLATFORM && PPC32
+	select DEFAULT_UIMAGE
+	select PPC_MPC5121
+	help
+	  This option enables support for simple MPC5121 based boards
+	  which do not need custom platform specific setup.
+
+	  Compatible boards include:  Protonic LVT base boards (ZANMCU
+	  and VICVT2).
diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
index 90910c1..8090e22 100644
--- a/arch/powerpc/platforms/512x/Makefile
+++ b/arch/powerpc/platforms/512x/Makefile
@@ -1,5 +1,6 @@
 #
 # Makefile for the Freescale PowerPC 512x linux kernel.
 #
-obj-y				+= clock.o
+obj-y				+= clock.o mpc512x_shared.o
 obj-$(CONFIG_MPC5121_ADS)	+= mpc5121_ads.o
+obj-$(CONFIG_MPC5121_GENERIC)	+= mpc5121_generic.o
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
index 50bd3a3..3ec9ca3 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ * Copyright (C) 2007, 2008 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Author: John Rigby, <jrigby@freescale.com>, Thur Mar 29 2007
  *
@@ -15,7 +15,6 @@
 
 #include <linux/kernel.h>
 #include <linux/io.h>
-#include <linux/irq.h>
 #include <linux/of_platform.h>
 
 #include <asm/machdep.h>
@@ -23,65 +22,11 @@
 #include <asm/prom.h>
 #include <asm/time.h>
 
-/**
- * 	mpc512x_find_ips_freq - Find the IPS bus frequency for a device
- * 	@node:	device node
- *
- * 	Returns IPS bus frequency, or 0 if the bus frequency cannot be found.
- */
-unsigned long
-mpc512x_find_ips_freq(struct device_node *node)
-{
-	struct device_node *np;
-	const unsigned int *p_ips_freq = NULL;
-
-	of_node_get(node);
-	while (node) {
-		p_ips_freq = of_get_property(node, "bus-frequency", NULL);
-		if (p_ips_freq)
-			break;
-
-		np = of_get_parent(node);
-		of_node_put(node);
-		node = np;
-	}
-	if (node)
-		of_node_put(node);
-
-	return p_ips_freq ? *p_ips_freq : 0;
-}
-EXPORT_SYMBOL(mpc512x_find_ips_freq);
-
-static struct of_device_id __initdata of_bus_ids[] = {
-	{ .name = "soc", },
-	{ .name = "localbus", },
-	{},
-};
-
-static void __init mpc5121_ads_declare_of_platform_devices(void)
-{
-	/* Find every child of the SOC node and add it to of_platform */
-	if (of_platform_bus_probe(NULL, of_bus_ids, NULL))
-		printk(KERN_ERR __FILE__ ": "
-			"Error while probing of_platform bus\n");
-}
+#include "mpc512x.h"
 
 static void __init mpc5121_ads_init_IRQ(void)
 {
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-	of_node_put(np);
-
-	/*
-	 * Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
+	mpc512x_init_IRQ();
 }
 
 /*
@@ -97,7 +42,8 @@ static int __init mpc5121_ads_probe(void)
 define_machine(mpc5121_ads) {
 	.name			= "MPC5121 ADS",
 	.probe			= mpc5121_ads_probe,
-	.init			= mpc5121_ads_declare_of_platform_devices,
+	.setup_arch		= mpc5121_ads_setup_arch,
+	.init			= mpc512x_declare_of_platform_devices,
 	.init_IRQ		= mpc5121_ads_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/powerpc/platforms/512x/mpc5121_generic.c
new file mode 100644
index 0000000..2479de9
--- /dev/null
+++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2007,2008 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author: John Rigby, <jrigby@freescale.com>
+ *
+ * Description:
+ * MPC5121 SoC setup
+ *
+ * This is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
+#include <asm/ipic.h>
+#include <asm/prom.h>
+#include <asm/time.h>
+
+#include "mpc512x.h"
+
+/*
+ * list of supported boards
+ */
+static char *board[] __initdata = {
+	"prt,prtlvt",
+	NULL
+};
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init mpc5121_generic_probe(void)
+{
+	unsigned long node = of_get_flat_dt_root();
+	int i = 0;
+
+	while (board[i]) {
+		if (of_flat_dt_is_compatible(node, board[i]))
+			break;
+		i++;
+	}
+
+	return board[i] != NULL;
+}
+
+define_machine(mpc5121_generic) {
+	.name			= "MPC5121 generic",
+	.probe			= mpc5121_generic_probe,
+	.init			= mpc512x_declare_of_platform_devices,
+	.init_IRQ		= mpc512x_init_IRQ,
+	.get_irq		= ipic_get_irq,
+	.calibrate_decr		= generic_calibrate_decr,
+};
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
new file mode 100644
index 0000000..9c03693
--- /dev/null
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Prototypes for MPC512x shared code
+ */
+
+#ifndef __MPC512X_H__
+#define __MPC512X_H__
+extern unsigned long mpc512x_find_ips_freq(struct device_node *node);
+extern void __init mpc512x_init_IRQ(void);
+void __init mpc512x_declare_of_platform_devices(void);
+#endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
similarity index 55%
copy from arch/powerpc/platforms/512x/mpc5121_ads.c
copy to arch/powerpc/platforms/512x/mpc512x_shared.c
index 50bd3a3..d8cd579 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -1,16 +1,15 @@
 /*
- * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ * Copyright (C) 2007,2008 Freescale Semiconductor, Inc. All rights reserved.
  *
- * Author: John Rigby, <jrigby@freescale.com>, Thur Mar 29 2007
+ * Author: John Rigby <jrigby@freescale.com>
  *
  * Description:
- * MPC5121 ADS board setup
+ * MPC512x Shared code
  *
  * This is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- *
  */
 
 #include <linux/kernel.h>
@@ -23,12 +22,8 @@
 #include <asm/prom.h>
 #include <asm/time.h>
 
-/**
- * 	mpc512x_find_ips_freq - Find the IPS bus frequency for a device
- * 	@node:	device node
- *
- * 	Returns IPS bus frequency, or 0 if the bus frequency cannot be found.
- */
+#include "mpc512x.h"
+
 unsigned long
 mpc512x_find_ips_freq(struct device_node *node)
 {
@@ -52,25 +47,11 @@ mpc512x_find_ips_freq(struct device_node *node)
 }
 EXPORT_SYMBOL(mpc512x_find_ips_freq);
 
-static struct of_device_id __initdata of_bus_ids[] = {
-	{ .name = "soc", },
-	{ .name = "localbus", },
-	{},
-};
-
-static void __init mpc5121_ads_declare_of_platform_devices(void)
-{
-	/* Find every child of the SOC node and add it to of_platform */
-	if (of_platform_bus_probe(NULL, of_bus_ids, NULL))
-		printk(KERN_ERR __FILE__ ": "
-			"Error while probing of_platform bus\n");
-}
-
-static void __init mpc5121_ads_init_IRQ(void)
+void __init mpc512x_init_IRQ(void)
 {
 	struct device_node *np;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,ipic");
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-ipic");
 	if (!np)
 		return;
 
@@ -85,20 +66,18 @@ static void __init mpc5121_ads_init_IRQ(void)
 }
 
 /*
- * Called very early, MMU is off, device-tree isn't unflattened
+ * Nodes to do bus probe on, soc and localbus
  */
-static int __init mpc5121_ads_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .compatible = "fsl,mpc5121-immr", },
+	{ .compatible = "fsl,mpc5121-localbus", },
+	{},
+};
 
-	return of_flat_dt_is_compatible(root, "fsl,mpc5121ads");
+void __init mpc512x_declare_of_platform_devices(void)
+{
+	if (of_platform_bus_probe(NULL, of_bus_ids, NULL))
+		printk(KERN_ERR __FILE__ ": "
+			"Error while probing of_platform bus\n");
 }
 
-define_machine(mpc5121_ads) {
-	.name			= "MPC5121 ADS",
-	.probe			= mpc5121_ads_probe,
-	.init			= mpc5121_ads_declare_of_platform_devices,
-	.init_IRQ		= mpc5121_ads_init_IRQ,
-	.get_irq		= ipic_get_irq,
-	.calibrate_decr		= generic_calibrate_decr,
-};
-- 
