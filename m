Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 547DEDE354
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 07:05:33 +1100 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 9C43514399
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 21:06:24 +0100 (CET)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05877-09 for <linuxppc-dev@ozlabs.org>;
	Tue,  6 Nov 2007 21:06:22 +0100 (CET)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id B98F214377
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 21:06:22 +0100 (CET)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH v3 04/13] [POWERPC] Add generic support for simple MPC5200
	based boards
To: linuxppc-dev@ozlabs.org
Date: Tue, 06 Nov 2007 21:05:20 +0100
Message-ID: <20071106200520.10913.47002.stgit@hekate.izotz.org>
In-Reply-To: <20071106200446.10913.29338.stgit@hekate.izotz.org>
References: <20071106200446.10913.29338.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for 'mpc5200-simple-platform' compatible
boards which do not need a platform specific setup. Such boards
are supported assuming the following:

- GPIO pins are configured by the firmware,
- CDM configuration (clocking) is setup correctly by firmware,
- if the 'fsl,has-wdt' property is present in one of the
  gpt nodes, then it is safe to use such gpt to reset the board,
- PCI is supported if enabled in the kernel configuration

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
---

 arch/powerpc/boot/dts/lite5200.dts           |    2 -
 arch/powerpc/boot/dts/lite5200b.dts          |    2 -
 arch/powerpc/platforms/52xx/Kconfig          |   18 ++++++-
 arch/powerpc/platforms/52xx/Makefile         |    1 
 arch/powerpc/platforms/52xx/mpc5200_simple.c |   72 ++++++++++++++++++++++++++
 5 files changed, 91 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/platforms/52xx/mpc5200_simple.c


diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index 6731763..5902362 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -19,7 +19,7 @@
 / {
 	model = "fsl,lite5200";
 	// revision = "1.0";
-	compatible = "fsl,lite5200","generic-mpc5200";
+	compatible = "fsl,lite5200";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index b540388..b509129 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -19,7 +19,7 @@
 / {
 	model = "fsl,lite5200b";
 	// revision = "1.0";
-	compatible = "fsl,lite5200b","generic-mpc5200";
+	compatible = "fsl,lite5200b";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index 2938d49..b8a6ebc 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -19,6 +19,22 @@ config PPC_MPC5200_BUGFIX
 
 	  It is safe to say 'Y' here
 
+config PPC_MPC5200_SIMPLE
+	bool "Generic support for simple MPC5200 based boards"
+	depends on PPC_MULTIPLATFORM && PPC32
+	select PPC_MPC5200
+	default n
+	help
+	  This option enables support for a simple MPC52xx based boards which
+	  do not need a custom platform specific setup. Such boards are
+	  supported assuming the following:
+
+	  - GPIO pins are configured by the firmware,
+	  - CDM configuration (clocking) is setup correctly by firmware,
+	  - if the 'fsl,has-wdt' property is present in one of the
+	    gpt nodes, then it is safe to use such gpt to reset the board,
+	  - PCI is supported if enabled in the kernel configuration
+
 config PPC_EFIKA
 	bool "bPlan Efika 5k2. MPC5200B based computer"
 	depends on PPC_MULTIPLATFORM && PPC32
@@ -34,5 +50,3 @@ config PPC_LITE5200
 	select WANT_DEVICE_TREE
 	select PPC_MPC5200
 	default n
-
-
diff --git a/arch/powerpc/platforms/52xx/Makefile b/arch/powerpc/platforms/52xx/Makefile
index 307dbc1..fe1b81b 100644
--- a/arch/powerpc/platforms/52xx/Makefile
+++ b/arch/powerpc/platforms/52xx/Makefile
@@ -6,6 +6,7 @@ obj-y				+= mpc52xx_pic.o mpc52xx_common.o
 obj-$(CONFIG_PCI)		+= mpc52xx_pci.o
 endif
 
+obj-$(CONFIG_PPC_MPC5200_SIMPLE) += mpc5200_simple.o
 obj-$(CONFIG_PPC_EFIKA)		+= efika.o
 obj-$(CONFIG_PPC_LITE5200)	+= lite5200.o
 
diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c
new file mode 100644
index 0000000..618cf24
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
@@ -0,0 +1,72 @@
+/*
+ * Support for 'mpc5200-simple-platform' compatible boards.
+ *
+ * Written by Marian Balakowicz <m8@semihalf.com>
+ * Copyright (C) 2007 Semihalf
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Description:
+ * This code implements support for a simple MPC52xx based boards which
+ * do not need a custom platform specific setup. Such boards are
+ * supported assuming the following:
+ *
+ * - GPIO pins are configured by the firmware,
+ * - CDM configuration (clocking) is setup correctly by firmware,
+ * - if the 'fsl,has-wdt' property is present in one of the
+ *   gpt nodes, then it is safe to use such gpt to reset the board,
+ * - PCI is supported if enabled in the kernel configuration
+ */
+
+#undef DEBUG
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/of.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/mpc52xx.h>
+
+/*
+ * Setup the architecture
+ */
+static void __init mpc5200_simple_setup_arch(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("mpc5200_simple_setup_arch()", 0);
+
+	/* Some mpc5200 & mpc5200b related configuration */
+	mpc5200_setup_xlb_arbiter();
+
+	/* Map wdt for mpc52xx_restart() */
+	mpc52xx_map_wdt();
+
+	mpc52xx_setup_pci();
+}
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init mpc5200_simple_probe(void)
+{
+	unsigned long node = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(node, "mpc5200-simple-platform"))
+		return 0;
+	return 1;
+}
+
+define_machine(mpc5200_simple_platform) {
+	.name		= "mpc5200-simple-platform",
+	.probe		= mpc5200_simple_probe,
+	.setup_arch	= mpc5200_simple_setup_arch,
+	.init		= mpc52xx_declare_of_platform_devices,
+	.init_IRQ	= mpc52xx_init_irq,
+	.get_irq	= mpc52xx_get_irq,
+	.restart	= mpc52xx_restart,
+	.calibrate_decr	= generic_calibrate_decr,
+};
