Return-Path: <jwboyer@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 6116BDE9DD
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 05:11:13 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m33so962870wag.9
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 11:11:11 -0700 (PDT)
Message-Id: <89c4121dc4a0897323fc5590ba69fea9db5c1a5e.1223921238.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <cover.1223921238.git.jwboyer@linux.vnet.ibm.com>
References: <cover.1223921238.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: [PATCH 3/5] powerpc/40x: Add PowerPC 40x simple platform support
To: linuxppc-dev@ozlabs.org
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Date: Mon, 13 Oct 2008 18:11:15 -0000

This adds a common board file for almost all of the "simple" PowerPC 40x
boards that exist today.  This is intended to be a single place to add
support for boards that do not differ in platform support from most of the
evaluation boards that are used as reference platforms.  Boards that have
specific requirements or custom hardware setup should still have their own
board.c file.

The first board ported to this is the AMCC PowerPC 405EZ Acadia board.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/40x/Kconfig         |   22 ++++++++
 arch/powerpc/platforms/40x/Makefile        |    1 +
 arch/powerpc/platforms/40x/ppc40x_simple.c |   80 ++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/40x/ppc40x_simple.c

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index a9260e2..72ba3a7 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -14,6 +14,15 @@
 #	help
 #	  This option enables support for the CPCI405 board.
 
+config ACADIA
+	bool "Acadia"
+	depends on 40x
+	default n
+	select PPC40x_SIMPLE
+	select 405EZ
+	help
+	  This option enables support for the AMCC 405EZ Acadia evaluation board.
+
 config EP405
 	bool "EP405/EP405PC"
 	depends on 40x
@@ -93,6 +102,13 @@ config XILINX_VIRTEX_GENERIC_BOARD
 	  Most Virtex designs should use this unless it needs to do some
 	  special configuration at board probe time.
 
+config PPC40x_SIMPLE
+	bool "Simple PowerPC 40x board support"
+	depends on 40x
+	default n
+	help
+	  This option enables the simple PowerPC 40x platform support.
+
 # 40x specific CPU modules, selected based on the board above.
 config NP405H
 	bool
@@ -118,6 +134,12 @@ config 405EX
 	select IBM_NEW_EMAC_EMAC4
 	select IBM_NEW_EMAC_RGMII
 
+config 405EZ
+	bool
+	select IBM_NEW_EMAC_NO_FLOW_CTRL
+	select IBM_NEW_EMAC_MAL_CLR_ICINTSTAT
+	select IBM_NEW_EMAC_MAL_COMMON_ERR
+
 config 405GPR
 	bool
 
diff --git a/arch/powerpc/platforms/40x/Makefile b/arch/powerpc/platforms/40x/Makefile
index 5533a5c..1d93273 100644
--- a/arch/powerpc/platforms/40x/Makefile
+++ b/arch/powerpc/platforms/40x/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_MAKALU)				+= makalu.o
 obj-$(CONFIG_WALNUT)				+= walnut.o
 obj-$(CONFIG_XILINX_VIRTEX_GENERIC_BOARD)	+= virtex.o
 obj-$(CONFIG_EP405)				+= ep405.o
+obj-$(CONFIG_PPC40x_SIMPLE)		+= ppc40x_simple.o
diff --git a/arch/powerpc/platforms/40x/ppc40x_simple.c b/arch/powerpc/platforms/40x/ppc40x_simple.c
new file mode 100644
index 0000000..4498a86
--- /dev/null
+++ b/arch/powerpc/platforms/40x/ppc40x_simple.c
@@ -0,0 +1,80 @@
+/*
+ * Generic PowerPC 40x platform support
+ *
+ * Copyright 2008 IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ *
+ * This implements simple platform support for PowerPC 44x chips.  This is
+ * mostly used for eval boards or other simple and "generic" 44x boards.  If
+ * your board has custom functions or hardware, then you will likely want to
+ * implement your own board.c file to accommodate it.
+ */
+
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc4xx.h>
+#include <asm/prom.h>
+#include <asm/time.h>
+#include <asm/udbg.h>
+#include <asm/uic.h>
+
+#include <linux/init.h>
+#include <linux/of_platform.h>
+
+static __initdata struct of_device_id ppc40x_of_bus[] = {
+	{ .compatible = "ibm,plb3", },
+	{ .compatible = "ibm,plb4", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+static int __init ppc40x_device_probe(void)
+{
+	of_platform_bus_probe(NULL, ppc40x_of_bus, NULL);
+
+	return 0;
+}
+machine_device_initcall(ppc40x_simple, ppc40x_device_probe);
+
+/* This is the list of boards that can be supported by this simple
+ * platform code.  This does _not_ mean the boards are compatible,
+ * as they most certainly are not from a device tree perspective.
+ * However, their differences are handled by the device tree and the
+ * drivers and therefore they don't need custom board support files.
+ *
+ * Again, if your board needs to do things differently then create a
+ * board.c file for it rather than adding it to this list.
+ */
+static char *board[] __initdata = {
+	"amcc,acadia"
+};
+
+static int __init ppc40x_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+	int i = 0;
+
+	for (i = 0; i < ARRAY_SIZE(board); i++) {
+		if (of_flat_dt_is_compatible(root, board[i])) {
+			ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+define_machine(ppc40x_simple) {
+	.name = "PowerPC 40x Platform",
+	.probe = ppc40x_probe,
+	.progress = udbg_progress,
+	.init_IRQ = uic_init_tree,
+	.get_irq = uic_get_irq,
+	.restart = ppc4xx_reset_system,
+	.calibrate_decr = generic_calibrate_decr,
+};
-- 
1.5.5.1
