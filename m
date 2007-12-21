Return-Path: <SRS0=0yox=RM=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 6A353DDE1B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 18:10:39 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] [POWERPC] Add AMCC Makalu board support to platforms/40x
Date: Fri, 21 Dec 2007 08:10:36 +0100
Message-Id: <1198221036-15270-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds basic support for the AMCC Makalu board to arch/powerpc.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/platforms/40x/Kconfig  |   10 ++++++
 arch/powerpc/platforms/40x/Makefile |    1 +
 arch/powerpc/platforms/40x/makalu.c |   61 +++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/40x/makalu.c

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index b685ec5..4742401 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -32,6 +32,16 @@ config KILAUEA
 	help
 	  This option enables support for the AMCC PPC405EX evaluation board.
 
+config MAKALU
+	bool "Makalu"
+	depends on 40x
+	default n
+	select 405EX
+	select PCI
+	select PPC4xx_PCI_EXPRESS
+	help
+	  This option enables support for the AMCC PPC405EX board.
+
 #config REDWOOD_5
 #	bool "Redwood-5"
 #	depends on 40x
diff --git a/arch/powerpc/platforms/40x/Makefile b/arch/powerpc/platforms/40x/Makefile
index 0f42fd4..5533a5c 100644
--- a/arch/powerpc/platforms/40x/Makefile
+++ b/arch/powerpc/platforms/40x/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_KILAUEA)				+= kilauea.o
+obj-$(CONFIG_MAKALU)				+= makalu.o
 obj-$(CONFIG_WALNUT)				+= walnut.o
 obj-$(CONFIG_XILINX_VIRTEX_GENERIC_BOARD)	+= virtex.o
 obj-$(CONFIG_EP405)				+= ep405.o
diff --git a/arch/powerpc/platforms/40x/makalu.c b/arch/powerpc/platforms/40x/makalu.c
new file mode 100644
index 0000000..780f5ec
--- /dev/null
+++ b/arch/powerpc/platforms/40x/makalu.c
@@ -0,0 +1,61 @@
+/*
+ * Makalu board specific routines
+ *
+ * Copyright 2007 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ *
+ * Based on the Walnut code by
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ * Copyright 2007 IBM Corporation
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/time.h>
+#include <asm/uic.h>
+#include <asm/pci-bridge.h>
+
+static struct of_device_id makalu_of_bus[] = {
+	{ .compatible = "ibm,plb4", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{},
+};
+
+static int __init makalu_device_probe(void)
+{
+	if (!machine_is(makalu))
+		return 0;
+
+	of_platform_bus_probe(NULL, makalu_of_bus, NULL);
+
+	return 0;
+}
+device_initcall(makalu_device_probe);
+
+static int __init makalu_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "amcc,makalu"))
+		return 0;
+
+	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+
+	return 1;
+}
+
+define_machine(makalu) {
+	.name 				= "Makalu",
+	.probe 				= makalu_probe,
+	.progress 			= udbg_progress,
+	.init_IRQ 			= uic_init_tree,
+	.get_irq 			= uic_get_irq,
+	.calibrate_decr			= generic_calibrate_decr,
+};
-- 
1.5.4.rc1
