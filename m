Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 16/16] Support for Ebony in arch/powerpc
In-Reply-To: <20070213060904.GA6214@localhost.localdomain>
Message-Id: <20070213061026.7979DDDDF0@ozlabs.org>
Date: Tue, 13 Feb 2007 17:10:26 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds platform support code for the Ebony (440GP) evaluation
board.

Signed-off-by: David Gibson <dwg@au1.ibm.com>
---

 arch/powerpc/platforms/4xx/Kconfig  |    3 +
 arch/powerpc/platforms/4xx/Makefile |    2 -
 arch/powerpc/platforms/4xx/ebony.c  |   68 ++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 2 deletions(-)

Index: working-2.6/arch/powerpc/platforms/4xx/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/4xx/Makefile	2007-02-13 12:37:37.000000000 +1100
+++ working-2.6/arch/powerpc/platforms/4xx/Makefile	2007-02-13 12:39:02.000000000 +1100
@@ -1 +1 @@
-# empty makefile so make clean works
\ No newline at end of file
+obj-$(CONFIG_EBONY)	:= ebony.o
Index: working-2.6/arch/powerpc/platforms/4xx/ebony.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/platforms/4xx/ebony.c	2007-02-13 12:39:02.000000000 +1100
@@ -0,0 +1,68 @@
+/*
+ * Ebony board specific routines
+ *
+ * Matt Porter <mporter@kernel.crashing.org>
+ * Copyright 2002-2005 MontaVista Software Inc.
+ *
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ * Copyright (c) 2003-2005 Zultys Technologies
+ *
+ * Rewritten and ported to the merged powerpc tree:
+ * Copyright 2007 David Gibson <dwg@au1.ibm.com>, IBM Corporation.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/time.h>
+#include <asm/uic.h>
+#include <asm/of_platform.h>
+
+static struct of_device_id ebony_of_bus[] = {
+	{ .type = "soc", },
+	{},
+};
+
+static int __init ebony_device_probe(void)
+{
+	if (! machine_is(ebony))
+		return 0;
+
+	of_platform_bus_probe(NULL, ebony_of_bus, NULL);
+
+	return 0;
+}
+device_initcall(ebony_device_probe);
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init ebony_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "Ebony"))
+		return 0;
+
+	return 1;
+}
+
+static void __init ebony_setup_arch(void)
+{
+}
+
+define_machine(ebony) {
+	.name			= "Ebony",
+	.probe			= ebony_probe,
+	.setup_arch		= ebony_setup_arch,
+	.progress		= udbg_progress,
+	.init_IRQ		= uic_init_tree,
+	.get_irq		= uic_get_irq,
+	.calibrate_decr		= generic_calibrate_decr,
+};
Index: working-2.6/arch/powerpc/platforms/4xx/Kconfig
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/4xx/Kconfig	2007-02-13 12:37:37.000000000 +1100
+++ working-2.6/arch/powerpc/platforms/4xx/Kconfig	2007-02-13 12:39:02.000000000 +1100
@@ -112,7 +112,8 @@ config 440EP
 config 440GP
 	bool
 	depends on EBONY
-	default y
+	select IBM_NEW_EMAC_ZMII
+ 	default y
 
 config 440GX
 	bool
