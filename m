Return-Path: <michael@ozlabs.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 02 May 2006 19:54:03 +1000
Subject: [PATCH 2/3] powerpc: Add early debugging / xmon support for Cell
Message-Id: <20060502095406.C25DA67B3B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds udbg routines for cell, and hooks them up for use as an early
debugging console or for xmon.

With this patch xmon seems to work. On one occasion after sitting in xmon
for a while I lost hard disk interrupts and had to power off, not sure what
the story was there.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/Kconfig.debug           |    6 ++
 arch/powerpc/kernel/udbg.c           |    3 +
 arch/powerpc/platforms/cell/Makefile |    2 
 arch/powerpc/platforms/cell/setup.c  |    3 +
 arch/powerpc/platforms/cell/udbg.c   |   86 +++++++++++++++++++++++++++++++++++
 include/asm-powerpc/udbg.h           |    1 
 6 files changed, 100 insertions(+), 1 deletion(-)

Index: cell/arch/powerpc/Kconfig.debug
===================================================================
--- cell.orig/arch/powerpc/Kconfig.debug
+++ cell/arch/powerpc/Kconfig.debug
@@ -131,6 +131,12 @@ config PPC_EARLY_DEBUG_G5
 	help
 	  Select this to enable early debugging for Apple G5 machines.
 
+config PPC_EARLY_DEBUG_CELL
+	bool "Cell RTAS console"
+	depends on PPC_CELL
+	help
+	  Select this to enable early debugging for Cell systems.
+
 config PPC_EARLY_DEBUG_RTAS
 	bool "RTAS Panel"
 	depends on PPC_RTAS
Index: cell/arch/powerpc/kernel/udbg.c
===================================================================
--- cell.orig/arch/powerpc/kernel/udbg.c
+++ cell/arch/powerpc/kernel/udbg.c
@@ -42,6 +42,9 @@ void __init udbg_early_init(void)
 #elif defined(CONFIG_PPC_EARLY_DEBUG_ISERIES)
 	/* For iSeries - hit Ctrl-x Ctrl-x to see the output */
 	udbg_init_iseries();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_CELL)
+	/* Cell RTAS console */
+	udbg_init_cell();
 #endif
 }
 
Index: cell/arch/powerpc/platforms/cell/Makefile
===================================================================
--- cell.orig/arch/powerpc/platforms/cell/Makefile
+++ cell/arch/powerpc/platforms/cell/Makefile
@@ -1,5 +1,5 @@
 obj-y			+= interrupt.o iommu.o setup.o spider-pic.o
-obj-y			+= pervasive.o pci.o
+obj-y			+= pervasive.o pci.o udbg.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_SPU_FS)	+= spufs/
Index: cell/arch/powerpc/platforms/cell/setup.c
===================================================================
--- cell.orig/arch/powerpc/platforms/cell/setup.c
+++ cell/arch/powerpc/platforms/cell/setup.c
@@ -49,6 +49,7 @@
 #include <asm/ppc-pci.h>
 #include <asm/irq.h>
 #include <asm/spu.h>
+#include <asm/udbg.h>
 
 #include "interrupt.h"
 #include "iommu.h"
@@ -145,6 +146,8 @@ static void __init cell_init_early(void)
 {
 	DBG(" -> cell_init_early()\n");
 
+	udbg_init_cell();
+
 	hpte_init_native();
 
 	cell_init_iommu();
Index: cell/arch/powerpc/platforms/cell/udbg.c
===================================================================
--- /dev/null
+++ cell/arch/powerpc/platforms/cell/udbg.c
@@ -0,0 +1,86 @@
+#ifndef _CELL_UDBG_H
+#define _CELL_UDBG_H
+
+/*
+ * Copyright (C) 2006 Michael Ellerman, IBM Corporation
+ *
+ * Early debugging and xmon console support.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <asm/rtas.h>
+#include <asm/udbg.h>
+
+/*
+ * For early debugging it's too early to get these out of the device tree,
+ * so we use hard coded values. These may change in future, check that they
+ * match your firmware!
+ * For normal use we get the values from the device tree, so that should
+ * always work ok.
+ */
+static int put_char_token = 0x27;
+static int get_char_token = 0x28;
+
+/*
+ * If firmware won't accept a character, try this many times before
+ * giving up and just throwing the chracter away.
+ */
+#define PUT_ATTEMPTS	16
+
+static void udbg_putc_cell(char c)
+{
+	int i;
+
+	if (c == '\n')
+		udbg_putc_cell('\r');
+
+	for (i = 0; i < PUT_ATTEMPTS; i++) {
+		if (rtas_call(put_char_token, 1, 1, NULL, c) == 0)
+			break;
+		udelay(100);
+	}
+}
+
+static int udbg_getc_poll_cell(void)
+{
+	int c;
+
+	if (rtas_call(get_char_token, 0, 2, &c))
+		c = -1;
+
+	return c;
+}
+
+static int udbg_getc_cell(void)
+{
+	int c;
+
+	while (1) {
+		c = udbg_getc_poll_cell();
+		if (c != -1)
+			return c;
+	}
+}
+
+void __init udbg_init_cell(void)
+{
+	int token;
+
+	token = rtas_token("put-term-char");
+	if (token != RTAS_UNKNOWN_SERVICE)
+		put_char_token = token;
+
+	token = rtas_token("get-term-char");
+	if (token != RTAS_UNKNOWN_SERVICE)
+		get_char_token = token;
+
+	udbg_putc = udbg_putc_cell;
+	udbg_getc = udbg_getc_cell;
+	udbg_getc_poll = udbg_getc_poll_cell;
+}
+
+#endif /* _CELL_UDBG_H */
Index: cell/include/asm-powerpc/udbg.h
===================================================================
--- cell.orig/include/asm-powerpc/udbg.h
+++ cell/include/asm-powerpc/udbg.h
@@ -42,6 +42,7 @@ extern void __init udbg_init_pmac_realmo
 extern void __init udbg_init_maple_realmode(void);
 extern void __init udbg_init_iseries(void);
 extern void __init udbg_init_rtas(void);
+extern void __init udbg_init_cell(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_UDBG_H */
