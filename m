Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 4/4] powerpc: New reg.h for the zImage
In-Reply-To: <20070322054812.GA16993@localhost.localdomain>
Message-Id: <20070322060221.8B1D9DDF51@ozlabs.org>
Date: Thu, 22 Mar 2007 17:02:21 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a reg.h to the zImage code, with common definitions
for accessing system reigsters.  For now, this includes functions for
retreiving the PVR and the stack pointer.  This patch then uses the
new reg.h to let start() display the running stack address without
having to explicitly pass the stack as a parameter from the asm code.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/boot/crt0.S |    1 -
 arch/powerpc/boot/main.c |    5 +++--
 arch/powerpc/boot/ops.h  |    2 +-
 arch/powerpc/boot/reg.h  |   22 ++++++++++++++++++++++
 4 files changed, 26 insertions(+), 4 deletions(-)

Index: working-2.6/arch/powerpc/boot/reg.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/reg.h	2007-03-21 17:28:38.000000000 +1100
@@ -0,0 +1,22 @@
+#ifndef _PPC_BOOT_REG_H
+#define _PPC_BOOT_REG_H
+/*
+ * Copyright 2007 Davud Gibson, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+static inline u32 mfpvr(void)
+{
+	u32 pvr;
+	asm volatile ("mfpvr	%0" : "=r"(pvr));
+	return pvr;
+}
+
+register void *__stack_pointer asm("r1");
+#define get_sp()	(__stack_pointer)
+
+#endif	/* _PPC_BOOT_REG_H */
Index: working-2.6/arch/powerpc/boot/crt0.S
===================================================================
--- working-2.6.orig/arch/powerpc/boot/crt0.S	2007-03-21 17:24:48.000000000 +1100
+++ working-2.6/arch/powerpc/boot/crt0.S	2007-03-21 17:24:48.000000000 +1100
@@ -97,5 +97,4 @@ _zimage_start_lib:
 	bl	platform_init
 
 	/* Call start */
-	mr	r3,r1
 	b	start
Index: working-2.6/arch/powerpc/boot/main.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/main.c	2007-03-21 17:24:48.000000000 +1100
+++ working-2.6/arch/powerpc/boot/main.c	2007-03-21 17:24:48.000000000 +1100
@@ -17,6 +17,7 @@
 #include "ops.h"
 #include "gunzip_util.h"
 #include "flatdevtree.h"
+#include "reg.h"
 
 extern char _start[];
 extern char __bss_start[];
@@ -230,7 +231,7 @@ struct dt_ops dt_ops;
 struct console_ops console_ops;
 struct loader_info loader_info;
 
-void start(void *sp)
+void start(void)
 {
 	struct addr_range vmlinux, initrd;
 	kernel_entry_t kentry;
@@ -249,7 +250,7 @@ void start(void *sp)
 		platform_ops.fixups();
 
 	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r",
-	       _start, sp);
+	       _start, get_sp());
 
 	/* Ensure that the device tree has a /chosen node */
 	if (! finddevice("/chosen"))
Index: working-2.6/arch/powerpc/boot/ops.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ops.h	2007-03-21 17:24:48.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ops.h	2007-03-21 17:24:48.000000000 +1100
@@ -75,7 +75,7 @@ struct loader_info {
 };
 extern struct loader_info loader_info;
 
-void start(void *sp);
+void start(void);
 int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device);
 int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
