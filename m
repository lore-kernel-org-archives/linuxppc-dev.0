Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id C746DDE043
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 04:12:14 +1100 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 3A9C914355
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 18:13:22 +0100 (CET)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00621-03 for <linuxppc-dev@ozlabs.org>;
	Fri,  9 Nov 2007 18:13:20 +0100 (CET)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id 4CF681431C
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 18:13:20 +0100 (CET)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH v4 04/13] [POWERPC] Add generic support for simple MPC5200
	based boards
To: linuxppc-dev@ozlabs.org
Date: Fri, 09 Nov 2007 18:12:02 +0100
Message-ID: <20071109171202.16289.2618.stgit@hekate.izotz.org>
In-Reply-To: <20071109171137.16289.39575.stgit@hekate.izotz.org>
References: <20071109171137.16289.39575.stgit@hekate.izotz.org>
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
and if there is a PCI bus node defined in the device tree.

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
---

 arch/powerpc/boot/dts/lite5200.dts           |    2 -
 arch/powerpc/boot/dts/lite5200b.dts          |    2 -
 arch/powerpc/platforms/52xx/Kconfig          |   22 ++++++-
 arch/powerpc/platforms/52xx/Makefile         |    1 
 arch/powerpc/platforms/52xx/mpc5200_simple.c |   84 ++++++++++++++++++++++++++
 5 files changed, 107 insertions(+), 4 deletions(-)
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
index 2938d49..36e880b 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -19,6 +19,26 @@ config PPC_MPC5200_BUGFIX
 
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
+	    and if there is a PCI bus node defined in the device tree.
+
+	  Boards that are compatible with this generic platform support
+	  are: 'tqc,tqm5200', 'promess,motionpro', 'schindler,cm5200'.
+
 config PPC_EFIKA
 	bool "bPlan Efika 5k2. MPC5200B based computer"
 	depends on PPC_MULTIPLATFORM && PPC32
@@ -34,5 +54,3 @@ config PPC_LITE5200
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
index 0000000..ad50c57
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
@@ -0,0 +1,84 @@
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
+ *   and if there is a PCI bus node defined in the device tree.
+ *
+ * Boards that are compatible with this generic platform support
+ * are: 'tqc,tqm5200', 'promess,motionpro', 'schindler,cm5200'.
+ */
+
+#undef DEBUG
+#include <asm/time.h>
+#include <asm/machdep.h>
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
+	int i = 0;
+
+	/* list of the supported boards */
+	const char *board[] = {	
+		"tqc,tqm5200",
+		"promess,motionpro",
+		"schindler,cm5200",
+		NULL
+	};
+
+	while (board[i]) {
+		if (of_flat_dt_is_compatible(node, board[i]))
+			break;
+		i++;
+	}
+	
+	return (board[i] != NULL);
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
