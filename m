Return-Path: <SRS0=9EYR=PC=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id C024EDDF17
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 19:14:01 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] [POWERPC] Add AMCC Kilauea eval board support to
	platforms/40x
Date: Mon, 8 Oct 2007 11:08:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710081108.51625.sr@denx.de>
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
 arch/powerpc/platforms/40x/Kconfig   |   17 +++++++--
 arch/powerpc/platforms/40x/Makefile  |    5 ++-
 arch/powerpc/platforms/40x/kilauea.c |   63 ++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 5 deletions(-)
 create mode 100644 arch/powerpc/platforms/40x/kilauea.c

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index a0a50b1..da8d02d 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -29,6 +29,14 @@
 #	help
 #	  This option enables support for the extra features of the EP405PC board.
 
+config KILAUEA
+	bool "Kilauea"
+	depends on 40x
+	default y
+	select 405EX
+	help
+	  This option enables support for the AMCC PPC405EX evaluation board.
+
 #config REDWOOD_5
 #	bool "Redwood-5"
 #	depends on 40x
@@ -89,14 +97,17 @@ config 403GCX
 	#depends on OAK
 	select IBM405_ERR51
 
+config 405EP
+	bool
+
+config 405EX
+	bool
+
 config 405GP
 	bool
 	select IBM405_ERR77
 	select IBM405_ERR51
 
-config 405EP
-	bool
-
 config 405GPR
 	bool
 
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
index 0000000..6cbd528
--- /dev/null
+++ b/arch/powerpc/platforms/40x/kilauea.c
@@ -0,0 +1,63 @@
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
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/time.h>
+#include <asm/uic.h>
+#include <asm/of_platform.h>
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
+static void __init kilauea_setup_arch(void)
+{
+}
+
+define_machine(kilauea) {
+	.name 				= "Kilauea",
+	.probe 				= kilauea_probe,
+	.setup_arch			= kilauea_setup_arch,
+	.progress 			= udbg_progress,
+	.init_IRQ 			= uic_init_tree,
+	.get_irq 			= uic_get_irq,
+	.calibrate_decr			= generic_calibrate_decr,
+};
-- 
1.5.3.4
