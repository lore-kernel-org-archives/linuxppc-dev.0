Return-Path: <SRS0=DCot=PF=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 79CF5DE1C2
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 22:08:21 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4 v2] [POWERPC] Add AMCC Kilauea eval board support to
	platforms/40x
Date: Thu, 11 Oct 2007 14:08:21 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710111408.21421.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds basic support for the new 405EX and the AMCC eval board
Kilauea to arch/powerpc.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/platforms/40x/Kconfig   |    7 ++++
 arch/powerpc/platforms/40x/Makefile  |    5 ++-
 arch/powerpc/platforms/40x/kilauea.c |   58 ++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/40x/kilauea.c

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index a0a50b1..47b3b0a 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -29,6 +29,13 @@
 #	help
 #	  This option enables support for the extra features of the EP405PC board.
 
+config KILAUEA
+	bool "Kilauea"
+	depends on 40x
+	default n
+	help
+	  This option enables support for the AMCC PPC405EX evaluation board.
+
 #config REDWOOD_5
 #	bool "Redwood-5"
 #	depends on 40x
diff --git a/arch/powerpc/platforms/40x/Makefile b/arch/powerpc/platforms/40x/Makefile
index 0a3cfe9..51dadee 100644
--- a/arch/powerpc/platforms/40x/Makefile
+++ b/arch/powerpc/platforms/40x/Makefile
@@ -1,2 +1,3 @@
-obj-$(CONFIG_WALNUT) += walnut.o
-obj-$(CONFIG_XILINX_VIRTEX_GENERIC_BOARD) += virtex.o
+obj-$(CONFIG_KILAUEA)				+= kilauea.o
+obj-$(CONFIG_WALNUT)				+= walnut.o
+obj-$(CONFIG_XILINX_VIRTEX_GENERIC_BOARD)	+= virtex.o
diff --git a/arch/powerpc/platforms/40x/kilauea.c b/arch/powerpc/platforms/40x/kilauea.c
new file mode 100644
index 0000000..1bffdbd
--- /dev/null
+++ b/arch/powerpc/platforms/40x/kilauea.c
@@ -0,0 +1,58 @@
+/*
+ * Kilauea board specific routines
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
+
+static struct of_device_id kilauea_of_bus[] = {
+	{ .compatible = "ibm,plb4", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{},
+};
+
+static int __init kilauea_device_probe(void)
+{
+	if (!machine_is(kilauea))
+		return 0;
+
+	of_platform_bus_probe(NULL, kilauea_of_bus, NULL);
+
+	return 0;
+}
+device_initcall(kilauea_device_probe);
+
+static int __init kilauea_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "amcc,kilauea"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(kilauea) {
+	.name 				= "Kilauea",
+	.probe 				= kilauea_probe,
+	.progress 			= udbg_progress,
+	.init_IRQ 			= uic_init_tree,
+	.get_irq 			= uic_get_irq,
+	.calibrate_decr			= generic_calibrate_decr,
+};
-- 
1.5.3.4
