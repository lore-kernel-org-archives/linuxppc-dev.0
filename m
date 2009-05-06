Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id BF479DF89A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 06:21:07 +1000 (EST)
From: Wolfgang Denk <wd@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/04] mpc5121: add support for ARIA board
Date: Wed,  6 May 2009 22:21:00 +0200
Message-Id: <1241641262-5202-4-git-send-email-wd@denx.de>
In-Reply-To: <1241641262-5202-1-git-send-email-wd@denx.de>
References: <1241641262-5202-1-git-send-email-wd@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ARIA is a MPC5121E based COM Express module by Dave/DENX.

Signed-off-by: Wolfgang Denk <wd@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
---
 arch/powerpc/platforms/512x/Kconfig           |    9 +++
 arch/powerpc/platforms/512x/Makefile          |    1 +
 arch/powerpc/platforms/512x/aria.c            |   73 +++++++++++++++++++++++++
 arch/powerpc/platforms/512x/mpc5121_generic.c |    1 +
 4 files changed, 84 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/512x/aria.c

diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index 4dac9b0..faef03e 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -10,6 +10,15 @@ config PPC_MPC5121
 	bool
 	select PPC_MPC512x
 
+config ARIA
+	bool "Dave/DENX ARIA COM Express module"
+	depends on 6xx
+	select DEFAULT_UIMAGE
+	select PPC_MPC5121
+	help
+	  This option enables support for the ARIA board,
+	  a MPC5121E based COM Express module by Dave/DENX.
+
 config MPC5121_ADS
 	bool "Freescale MPC5121E ADS"
 	depends on 6xx
diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
--- a/arch/powerpc/platforms/512x/Makefile
+++ b/arch/powerpc/platforms/512x/Makefile
@@ -2,5 +2,6 @@
 # Makefile for the Freescale PowerPC 512x linux kernel.
 #
 obj-y				+= clock.o mpc512x_shared.o
+obj-$(CONFIG_ARIA)		+= aria.o
 obj-$(CONFIG_MPC5121_ADS)	+= mpc5121_ads.o mpc5121_ads_cpld.o
 obj-$(CONFIG_MPC5121_GENERIC)	+= mpc5121_generic.o
diff --git a/arch/powerpc/platforms/512x/aria.c b/arch/powerpc/platforms/512x/aria.c
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/platforms/512x/aria.c
@@ -0,0 +1,70 @@
+/*
+ * Copyright (C) 2009 Wolfgang Denk <wd@denx.de>
+ *
+ * based on mpc5121_ads.c:
+ *
+ * Copyright (C) 2007, 2008 Freescale Semiconductor, Inc. All rights reserved.
+ * Author: John Rigby, <jrigby@freescale.com>, Thur Mar 29 2007
+ *
+ * Description:
+ * ARIA board setup
+ *
+ * This is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
+#include <asm/ipic.h>
+#include <asm/prom.h>
+#include <asm/time.h>
+
+#include <sysdev/fsl_pci.h>
+
+#include "mpc512x.h"
+
+static void __init aria_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+	printk(KERN_INFO "ARIA board from Dave/DENX\n");
+
+#ifdef CONFIG_PCI
+	for_each_compatible_node(np, "pci", "fsl,mpc5121-pci")
+		mpc83xx_add_bridge(np);
+#endif
+
+	mpc512x_init_i2c();
+}
+
+static void __init aria_init_IRQ(void)
+{
+	mpc512x_init_IRQ();
+}
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init aria_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "davedenx,aria");
+}
+
+define_machine(aria) {
+	.name			= "ARIA",
+	.probe			= aria_probe,
+	.setup_arch		= aria_setup_arch,
+	.init			= mpc512x_declare_of_platform_devices,
+	.init_IRQ		= aria_init_IRQ,
+	.get_irq		= ipic_get_irq,
+	.calibrate_decr		= generic_calibrate_decr,
+};
diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/powerpc/platforms/512x/mpc5121_generic.c
index 2479de9..228d9a2 100644
--- a/arch/powerpc/platforms/512x/mpc5121_generic.c
+++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
@@ -27,6 +27,7 @@
  * list of supported boards
  */
 static char *board[] __initdata = {
+	"davedenx,aria",
 	"prt,prtlvt",
 	NULL
 };
-- 
1.6.0.6
