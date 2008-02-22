Return-Path: <erick205@umn.edu>
Received: from mta-w2.tc.umn.edu (mta-w2.tc.umn.edu [134.84.119.6])
	by ozlabs.org (Postfix) with ESMTP id 3C8B9DDE36
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 10:44:08 +1100 (EST)
Date: Fri, 22 Feb 2008 15:28:44 -0800
Subject: [PATCH] [POWERPC] 40X: Add Default Restart Machdep Method to 40X
	Platforms
From: Grant Erickson <erick205@umn.edu>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Message-ID: <C3E49AAC.D8E4%erick205@umn.edu>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch restores the reset on restart functionality to 40x-based
platforms that was formerly provided--but not used in arch/powerpc--by
abort() in head_40x.S. This functionality is now provided by
ppc40x_reset_system(char *) in a fashion similar to that of the 44x-based
platforms.

Compiled, linked and tested against the AMCC Haleakala board.

Signed-off-by: Grant Erickson <gerickson@nuovations.com>
---
diff -rauN linux-2.6.25-rc2-git1/arch/powerpc/kernel/head_40x.S
linux-2.6.25-rc2-git1.N/arch/powerpc/kernel/head_40x.S
--- linux-2.6.25-rc2-git1/arch/powerpc/kernel/head_40x.S    2008-01-24
14:58:37.000000000 -0800
+++ linux-2.6.25-rc2-git1.N/arch/powerpc/kernel/head_40x.S    2008-02-22
11:02:56.000000000 -0800
@@ -961,11 +961,6 @@
 
     blr
 
-_GLOBAL(abort)
-        mfspr   r13,SPRN_DBCR0
-        oris    r13,r13,DBCR0_RST_SYSTEM@h
-        mtspr   SPRN_DBCR0,r13
-
 _GLOBAL(set_context)
 
 #ifdef CONFIG_BDI_SWITCH
diff -rauN linux-2.6.25-rc2-git1/arch/powerpc/platforms/40x/40x.h
linux-2.6.25-rc2-git1.N/arch/powerpc/platforms/40x/40x.h
--- linux-2.6.25-rc2-git1/arch/powerpc/platforms/40x/40x.h    1969-12-31
16:00:00.000000000 -0800
+++ linux-2.6.25-rc2-git1.N/arch/powerpc/platforms/40x/40x.h    2008-02-22
11:02:56.000000000 -0800
@@ -0,0 +1,6 @@
+#ifndef __POWERPC_PLATFORMS_40X_40X_H
+#define __POWERPC_PLATFORMS_40X_40X_H
+
+extern void ppc40x_reset_system(char *cmd);
+
+#endif /* __POWERPC_PLATFORMS_40X_40X_H */
diff -rauN linux-2.6.25-rc2-git1/arch/powerpc/platforms/40x/ep405.c
linux-2.6.25-rc2-git1.N/arch/powerpc/platforms/40x/ep405.c
--- linux-2.6.25-rc2-git1/arch/powerpc/platforms/40x/ep405.c    2008-02-22
11:07:53.000000000 -0800
+++ linux-2.6.25-rc2-git1.N/arch/powerpc/platforms/40x/ep405.c    2008-02-22
11:02:56.000000000 -0800
@@ -30,6 +30,8 @@
 #include <asm/uic.h>
 #include <asm/pci-bridge.h>
 
+#include "40x.h"
+
 static struct device_node *bcsr_node;
 static void __iomem *bcsr_regs;
 
@@ -119,5 +121,6 @@
     .progress        = udbg_progress,
     .init_IRQ        = uic_init_tree,
     .get_irq        = uic_get_irq,
-    .calibrate_decr        = generic_calibrate_decr,
+    .restart        = ppc40x_reset_system,
+    .calibrate_decr    = generic_calibrate_decr,
 };
diff -rauN linux-2.6.25-rc2-git1/arch/powerpc/platforms/40x/kilauea.c
linux-2.6.25-rc2-git1.N/arch/powerpc/platforms/40x/kilauea.c
--- linux-2.6.25-rc2-git1/arch/powerpc/platforms/40x/kilauea.c    2008-02-22
11:07:53.000000000 -0800
+++ linux-2.6.25-rc2-git1.N/arch/powerpc/platforms/40x/kilauea.c
2008-02-22 11:02:56.000000000 -0800
@@ -21,6 +21,8 @@
 #include <asm/uic.h>
 #include <asm/pci-bridge.h>
 
+#include "40x.h"
+
 static __initdata struct of_device_id kilauea_of_bus[] = {
     { .compatible = "ibm,plb4", },
     { .compatible = "ibm,opb", },
@@ -54,5 +56,6 @@
     .progress             = udbg_progress,
     .init_IRQ             = uic_init_tree,
     .get_irq             = uic_get_irq,
-    .calibrate_decr            = generic_calibrate_decr,
+    .restart            = ppc40x_reset_system,
+    .calibrate_decr        = generic_calibrate_decr,
 };
diff -rauN linux-2.6.25-rc2-git1/arch/powerpc/platforms/40x/makalu.c
linux-2.6.25-rc2-git1.N/arch/powerpc/platforms/40x/makalu.c
--- linux-2.6.25-rc2-git1/arch/powerpc/platforms/40x/makalu.c    2008-02-22
11:07:53.000000000 -0800
+++ linux-2.6.25-rc2-git1.N/arch/powerpc/platforms/40x/makalu.c
2008-02-22 11:02:56.000000000 -0800
@@ -21,6 +21,8 @@
 #include <asm/uic.h>
 #include <asm/pci-bridge.h>
 
+#include "40x.h"
+
 static __initdata struct of_device_id makalu_of_bus[] = {
     { .compatible = "ibm,plb4", },
     { .compatible = "ibm,opb", },
@@ -54,5 +56,6 @@
     .progress             = udbg_progress,
     .init_IRQ             = uic_init_tree,
     .get_irq             = uic_get_irq,
-    .calibrate_decr            = generic_calibrate_decr,
+    .restart            = ppc40x_reset_system,
+    .calibrate_decr        = generic_calibrate_decr,
 };
diff -rauN linux-2.6.25-rc2-git1/arch/powerpc/platforms/40x/Makefile
linux-2.6.25-rc2-git1.N/arch/powerpc/platforms/40x/Makefile
--- linux-2.6.25-rc2-git1/arch/powerpc/platforms/40x/Makefile    2008-02-22
11:07:53.000000000 -0800
+++ linux-2.6.25-rc2-git1.N/arch/powerpc/platforms/40x/Makefile
2008-02-22 11:02:56.000000000 -0800
@@ -1,3 +1,4 @@
+obj-$(CONFIG_40x)                += misc_40x.o
 obj-$(CONFIG_KILAUEA)                += kilauea.o
 obj-$(CONFIG_MAKALU)                += makalu.o
 obj-$(CONFIG_WALNUT)                += walnut.o
diff -rauN linux-2.6.25-rc2-git1/arch/powerpc/platforms/40x/misc_40x.S
linux-2.6.25-rc2-git1.N/arch/powerpc/platforms/40x/misc_40x.S
--- linux-2.6.25-rc2-git1/arch/powerpc/platforms/40x/misc_40x.S
1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.25-rc2-git1.N/arch/powerpc/platforms/40x/misc_40x.S
2008-02-22 15:19:14.000000000 -0800
@@ -0,0 +1,30 @@
+/*
+ * This file contains miscellaneous low-level functions for PPC 40x.
+ *
+ *    Copyright (c) 1999 Grant Erickson <grant@lcse.umn.edu>
+ *    Copyright 2007 David Gibson <dwg@au1.ibm.com>, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <asm/reg.h>
+#include <asm/ppc_asm.h>
+
+    .text
+
+/*
+ * void ppc40x_reset_system(char *cmd)
+ *
+ * At present, this just applies a system reset which, historically, when
+ * this routine existed as '_abort' in head_40x.S was sufficient for most
+ * systems.
+ */
+_GLOBAL(ppc40x_reset_system)
+        mfspr   r13,SPRN_DBCR0
+        oris    r13,r13,DBCR0_RST_SYSTEM@h
+        mtspr   SPRN_DBCR0,r13
+    b    .                /* Just in case reset fails. */
diff -rauN linux-2.6.25-rc2-git1/arch/powerpc/platforms/40x/virtex.c
linux-2.6.25-rc2-git1.N/arch/powerpc/platforms/40x/virtex.c
--- linux-2.6.25-rc2-git1/arch/powerpc/platforms/40x/virtex.c    2008-02-22
11:07:53.000000000 -0800
+++ linux-2.6.25-rc2-git1.N/arch/powerpc/platforms/40x/virtex.c
2008-02-22 11:02:56.000000000 -0800
@@ -15,6 +15,8 @@
 #include <asm/time.h>
 #include <asm/xilinx_intc.h>
 
+#include "40x.h"
+
 static struct of_device_id xilinx_of_bus_ids[] __initdata = {
     { .compatible = "xlnx,plb-v46-1.00.a", },
     { .compatible = "xlnx,plb-v34-1.01.a", },
@@ -48,5 +50,6 @@
     .probe            = virtex_probe,
     .init_IRQ        = xilinx_intc_init_tree,
     .get_irq        = xilinx_intc_get_irq,
-    .calibrate_decr        = generic_calibrate_decr,
+    .restart        = ppc40x_reset_system,
+    .calibrate_decr    = generic_calibrate_decr,
 };
diff -rauN linux-2.6.25-rc2-git1/arch/powerpc/platforms/40x/walnut.c
linux-2.6.25-rc2-git1.N/arch/powerpc/platforms/40x/walnut.c
--- linux-2.6.25-rc2-git1/arch/powerpc/platforms/40x/walnut.c    2008-02-22
11:07:53.000000000 -0800
+++ linux-2.6.25-rc2-git1.N/arch/powerpc/platforms/40x/walnut.c
2008-02-22 11:02:56.000000000 -0800
@@ -27,6 +27,8 @@
 #include <asm/uic.h>
 #include <asm/pci-bridge.h>
 
+#include "40x.h"
+
 static __initdata struct of_device_id walnut_of_bus[] = {
     { .compatible = "ibm,plb3", },
     { .compatible = "ibm,opb", },
@@ -61,5 +63,6 @@
     .progress        = udbg_progress,
     .init_IRQ        = uic_init_tree,
     .get_irq        = uic_get_irq,
+    .restart        = ppc40x_reset_system,
     .calibrate_decr    = generic_calibrate_decr,
 };
