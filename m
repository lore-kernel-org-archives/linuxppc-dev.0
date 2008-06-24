Return-Path: <jrigby@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C6192DE2B5
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 07:24:42 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m5OLOa7V006108
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 14:24:36 -0700 (MST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/8][Version 2] MPC5121 Add generic board support
Date: Tue, 24 Jun 2008 15:24:27 -0600
Message-Id: <1214342672-23536-4-git-send-email-jrigby@freescale.com>
In-Reply-To: <1214342672-23536-3-git-send-email-jrigby@freescale.com>
References: <1214342672-23536-1-git-send-email-jrigby@freescale.com>
	<1214342672-23536-2-git-send-email-jrigby@freescale.com>
	<1214342672-23536-3-git-send-email-jrigby@freescale.com>
Cc: John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move shared code from mpc5121_ads.c to mpc512x_shared.c.
Add new generic board setup mpc5121_generic.c

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/platforms/512x/Kconfig           |   15 ++++-
 arch/powerpc/platforms/512x/Makefile          |    3 +-
 arch/powerpc/platforms/512x/mpc5121_ads.c     |   45 +---------------
 arch/powerpc/platforms/512x/mpc5121_generic.c |   72 +++++++++++++++++++++++++
 arch/powerpc/platforms/512x/mpc512x.h         |   14 +++++
 arch/powerpc/platforms/512x/mpc512x_shared.c  |   66 ++++++++++++++++++++++
 6 files changed, 168 insertions(+), 47 deletions(-)
 create mode 100644 arch/powerpc/platforms/512x/mpc5121_generic.c
 create mode 100644 arch/powerpc/platforms/512x/mpc512x.h
 create mode 100644 arch/powerpc/platforms/512x/mpc512x_shared.c

diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index 4c0da0c..f9a04da 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -2,12 +2,10 @@ config PPC_MPC512x
 	bool
 	select FSL_SOC
 	select IPIC
-	default n
 
 config PPC_MPC5121
 	bool
 	select PPC_MPC512x
-	default n
 
 config MPC5121_ADS
 	bool "Freescale MPC5121E ADS"
@@ -16,4 +14,15 @@ config MPC5121_ADS
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
+	  which do not need custome platform specific setup.
+
+	  Compatible boards include:  Protonic LVT base boards (ZANMCU
+	  and VICVT2).
diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
index ef6c925..e6674c8 100644
--- a/arch/powerpc/platforms/512x/Makefile
+++ b/arch/powerpc/platforms/512x/Makefile
@@ -1,5 +1,6 @@
 #
 # Makefile for the Freescale PowerPC 512x linux kernel.
 #
-obj-y				:= clock.o
+obj-y				:= clock.o mpc512x_shared.o
 obj-$(CONFIG_MPC5121_ADS)	+= mpc5121_ads.o
+obj-$(CONFIG_MPC5121_GENERIC)	+= mpc5121_generic.o
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
index 50bd3a3..45bb2ef 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -15,7 +15,6 @@
 
 #include <linux/kernel.h>
 #include <linux/io.h>
-#include <linux/irq.h>
 #include <linux/of_platform.h>
 
 #include <asm/machdep.h>
@@ -23,34 +22,7 @@
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
+#include "mpc512x.h"
 
 static struct of_device_id __initdata of_bus_ids[] = {
 	{ .name = "soc", },
@@ -68,20 +40,7 @@ static void __init mpc5121_ads_declare_of_platform_devices(void)
 
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
diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/powerpc/platforms/512x/mpc5121_generic.c
new file mode 100644
index 0000000..0111a98
--- /dev/null
+++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
@@ -0,0 +1,72 @@
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
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .name = "soc", },
+	{ .name = "localbus", },
+	{},
+};
+
+static void __init mpc5121_generic_declare_of_platform_devices(void)
+{
+	/* Find every child of the SOC node and add it to of_platform */
+	if (of_platform_bus_probe(NULL, of_bus_ids, NULL))
+		printk(KERN_ERR __FILE__ ": "
+			"Error while probing of_platform bus\n");
+}
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
+	.init			= mpc5121_generic_declare_of_platform_devices,
+	.init_IRQ		= mpc512x_init_IRQ,
+	.get_irq		= ipic_get_irq,
+	.calibrate_decr		= generic_calibrate_decr,
+};
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
new file mode 100644
index 0000000..789b817
--- /dev/null
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MPC512X_H__
+#define __MPC512X_H__
+extern unsigned long mpc512x_find_ips_freq(struct device_node *node);
+extern void __init mpc512x_init_IRQ(void);
+#endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
new file mode 100644
index 0000000..4b8fe6a
--- /dev/null
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -0,0 +1,66 @@
+/*
+ * Copyright (C) 2007,2008 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author: John Rigby <jrigby@freescale.com>
+ *
+ * Description:
+ * MPC512x Shared code
+ *
+ * This is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
+#include <asm/ipic.h>
+#include <asm/prom.h>
+#include <asm/time.h>
+
+#include "mpc512x.h"
+
+unsigned long
+mpc512x_find_ips_freq(struct device_node *node)
+{
+	struct device_node *np;
+	const unsigned int *p_ips_freq = NULL;
+
+	of_node_get(node);
+	while (node) {
+		p_ips_freq = of_get_property(node, "bus-frequency", NULL);
+		if (p_ips_freq)
+			break;
+
+		np = of_get_parent(node);
+		of_node_put(node);
+		node = np;
+	}
+	if (node)
+		of_node_put(node);
+
+	return p_ips_freq ? *p_ips_freq : 0;
+}
+EXPORT_SYMBOL(mpc512x_find_ips_freq);
+
+void __init mpc512x_init_IRQ(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,ipic");
+	if (!np)
+		return;
+
+	ipic_init(np, 0);
+	of_node_put(np);
+
+	/*
+	 * Initialize the default interrupt mapping priorities,
+	 * in case the boot rom changed something on us.
+	 */
+	ipic_set_default_priority();
+}
-- 
1.5.6.rc0.46.gd2b3
