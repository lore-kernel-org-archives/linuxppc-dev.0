Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 11/13] Consolidate cuboot initialization code
In-Reply-To: <20070613045031.GD16148@localhost.localdomain>
Message-Id: <20070613045300.B0D1DDDEC7@ozlabs.org>
Date: Wed, 13 Jun 2007 14:53:00 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The various cuboot platforms (i.e. pre-device tree aware u-boot for
83xx, 85xx and Ebony) share a certain amount of code for parsing the
boot parameters.  To a certain extent that's inevitable, since they
platforms have different definitions of the bd_t structure.  However,
with some macro work and a helper function, this patch improves the
situation a bit.

In the process, this fixes a bug on Ebony, which was incorrectly
handling the parameters passed form u-boot for the command line (the
bug was copied from 83xx and 85xx which have subsequently been fixed).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/boot/Makefile       |    2 +-
 arch/powerpc/boot/cuboot-83xx.c  |   13 ++-----------
 arch/powerpc/boot/cuboot-85xx.c  |   13 ++-----------
 arch/powerpc/boot/cuboot-ebony.c |   16 ++--------------
 arch/powerpc/boot/cuboot.c       |   35 +++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/cuboot.h       |   14 ++++++++++++++
 6 files changed, 56 insertions(+), 37 deletions(-)

Index: working-2.6/arch/powerpc/boot/cuboot.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/cuboot.c	2007-05-29 17:23:39.000000000 +1000
@@ -0,0 +1,35 @@
+/*
+ * Compatibility for old (not device tree aware) U-Boot versions
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ * Consolidated using macros by David Gibson <david@gibson.dropbear.id.au>
+ *
+ * Copyright 2007 David Gibson, IBM Corporation.
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "stdio.h"
+
+#include "ppcboot.h"
+
+extern char _end[];
+extern char _dtb_start[], _dtb_end[];
+
+void cuboot_init(unsigned long r4, unsigned long r5,
+		 unsigned long r6, unsigned long r7,
+		 unsigned long end_of_ram)
+{
+	unsigned long avail_ram = end_of_ram - (unsigned long)_end;
+
+	loader_info.initrd_addr = r4;
+	loader_info.initrd_size = r4 ? r5 - r4 : 0;
+	loader_info.cmdline = (char *)r6;
+	loader_info.cmdline_len = r7 - r6;
+
+	simple_alloc_init(_end, avail_ram - 1024*1024, 32, 64);
+}
Index: working-2.6/arch/powerpc/boot/cuboot-83xx.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/cuboot-83xx.c	2007-05-29 17:23:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/cuboot-83xx.c	2007-05-29 17:23:39.000000000 +1000
@@ -12,12 +12,12 @@
 
 #include "ops.h"
 #include "stdio.h"
+#include "cuboot.h"
 
 #define TARGET_83xx
 #include "ppcboot.h"
 
 static bd_t bd;
-extern char _end[];
 extern char _dtb_start[], _dtb_end[];
 
 static void platform_fixups(void)
@@ -52,16 +52,7 @@ static void platform_fixups(void)
 void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
                    unsigned long r6, unsigned long r7)
 {
-	unsigned long end_of_ram = bd.bi_memstart + bd.bi_memsize;
-	unsigned long avail_ram = end_of_ram - (unsigned long)_end;
-
-	memcpy(&bd, (bd_t *)r3, sizeof(bd));
-	loader_info.initrd_addr = r4;
-	loader_info.initrd_size = r4 ? r5 - r4 : 0;
-	loader_info.cmdline = (char *)r6;
-	loader_info.cmdline_len = r7 - r6;
-
-	simple_alloc_init(_end, avail_ram - 1024*1024, 32, 64);
+	CUBOOT_INIT();
 	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
 	serial_console_init();
 	platform_ops.fixups = platform_fixups;
Index: working-2.6/arch/powerpc/boot/cuboot-85xx.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/cuboot-85xx.c	2007-05-29 17:23:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/cuboot-85xx.c	2007-05-29 17:23:39.000000000 +1000
@@ -12,12 +12,12 @@
 
 #include "ops.h"
 #include "stdio.h"
+#include "cuboot.h"
 
 #define TARGET_85xx
 #include "ppcboot.h"
 
 static bd_t bd;
-extern char _end[];
 extern char _dtb_start[], _dtb_end[];
 
 static void platform_fixups(void)
@@ -53,16 +53,7 @@ static void platform_fixups(void)
 void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
                    unsigned long r6, unsigned long r7)
 {
-	unsigned long end_of_ram = bd.bi_memstart + bd.bi_memsize;
-	unsigned long avail_ram = end_of_ram - (unsigned long)_end;
-
-	memcpy(&bd, (bd_t *)r3, sizeof(bd));
-	loader_info.initrd_addr = r4;
-	loader_info.initrd_size = r4 ? r5 - r4 : 0;
-	loader_info.cmdline = (char *)r6;
-	loader_info.cmdline_len = r7 - r6;
-
-	simple_alloc_init(_end, avail_ram - 1024*1024, 32, 64);
+	CUBOOT_INIT();
 	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
 	serial_console_init();
 	platform_ops.fixups = platform_fixups;
Index: working-2.6/arch/powerpc/boot/cuboot.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/cuboot.h	2007-05-29 17:23:39.000000000 +1000
@@ -0,0 +1,14 @@
+#ifndef _PPC_BOOT_CUBOOT_H_
+#define _PPC_BOOT_CUBOOT_H_
+
+void cuboot_init(unsigned long r4, unsigned long r5,
+		 unsigned long r6, unsigned long r7,
+		 unsigned long end_of_ram);
+
+#define CUBOOT_INIT() \
+	do { \
+		memcpy(&bd, (bd_t *)r3, sizeof(bd)); \
+		cuboot_init(r4, r5, r6, r7, bd.bi_memstart + bd.bi_memsize); \
+	} while (0)
+
+#endif /* _PPC_BOOT_CUBOOT_H_ */
Index: working-2.6/arch/powerpc/boot/cuboot-ebony.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/cuboot-ebony.c	2007-05-29 17:23:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/cuboot-ebony.c	2007-05-29 17:23:39.000000000 +1000
@@ -15,28 +15,16 @@
 #include "ops.h"
 #include "stdio.h"
 #include "44x.h"
+#include "cuboot.h"
 
 #define TARGET_44x
 #include "ppcboot.h"
 
 static bd_t bd;
-extern char _end[];
-
-BSS_STACK(4096);
 
 void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
                    unsigned long r6, unsigned long r7)
 {
-	unsigned long end_of_ram = bd.bi_memstart + bd.bi_memsize;
-	unsigned long avail_ram = end_of_ram - (unsigned long)_end;
-
-	memcpy(&bd, (bd_t *)r3, sizeof(bd));
-	loader_info.initrd_addr = r4;
-	loader_info.initrd_size = r4 ? r5 : 0;
-	loader_info.cmdline = (char *)r6;
-	loader_info.cmdline_len = r7 - r6;
-
-	simple_alloc_init(_end, avail_ram, 32, 64);
-
+	CUBOOT_INIT();
 	ebony_init(&bd.bi_enetaddr, &bd.bi_enet1addr);
 }
Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-05-29 17:23:53.000000000 +1000
+++ working-2.6/arch/powerpc/boot/Makefile	2007-05-29 17:24:16.000000000 +1000
@@ -44,7 +44,7 @@ $(addprefix $(obj)/,$(zlib) gunzip_util.
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
-		44x.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c
+		44x.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c
 src-boot := $(src-wlib) $(src-plat) empty.c
