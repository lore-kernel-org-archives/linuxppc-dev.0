Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 10/16] Add support for BSS stack for zImage wrapper
In-Reply-To: <20070213060904.GA6214@localhost.localdomain>
Message-Id: <20070213061025.50601DDD0D@ozlabs.org>
Date: Tue, 13 Feb 2007 17:10:25 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some embedded powerpc firmwares don't set up a stack before the zImage
wrapper enters, or set up a stack at an address which is not usable
for some reason.  This patch provides an (optional) alternate,
fixed-size stack included in the zImage's BSS area.  Platforms which
need their own stack can use the USE_BSS_STACK macro in their platform
.o files to force the BSS stack to be used instead of assuming that r1
contains a usable stack pointer on entry.

Signed-off-by: David Gibson <dwg@au1.ibm.com>
---

 arch/powerpc/boot/Makefile    |    2 +-
 arch/powerpc/boot/bss_stack.S |   17 +++++++++++++++++
 arch/powerpc/boot/crt0.S      |   11 +++++++++--
 arch/powerpc/boot/ops.h       |    3 +++
 4 files changed, 30 insertions(+), 3 deletions(-)

Index: working-2.6/arch/powerpc/boot/bss_stack.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/bss_stack.S	2007-02-06 13:49:05.000000000 +1100
@@ -0,0 +1,17 @@
+/*
+ * Copyright 2007 David Gibson, IBM Corporation.  <dwg@au1.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * NOTE: this code runs in 32 bit mode and is packaged as ELF32.
+ */
+
+	.section ".bss"
+	.weak	_bss_stack, _bss_stack_top
+	.globl	_bss_stack, _bss_stack_top
+_bss_stack:
+	.space	4096
+_bss_stack_top:
Index: working-2.6/arch/powerpc/boot/crt0.S
===================================================================
--- working-2.6.orig/arch/powerpc/boot/crt0.S	2007-02-06 13:48:27.000000000 +1100
+++ working-2.6/arch/powerpc/boot/crt0.S	2007-02-06 14:04:28.000000000 +1100
@@ -11,6 +11,8 @@
 
 #include "ppc_asm.h"
 
+	.weak	_bss_stack_top
+
 	.text
 	/* a procedure descriptor used when booting this as a COFF file */
 _zimage_start_opd:
@@ -59,6 +61,11 @@ _zimage_start:
 	sync
 	isync
 
-	mr	r6,r1
-	b	start
+	lis	r6,_bss_stack_top@ha
+	addi	r6,r6,_bss_stack_top@l
+	cmpwi	r6,0
+	beq	5f
+	mr	r1,r6
 
+5:	mr	r6,r1
+	b	start
Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-02-06 13:48:27.000000000 +1100
+++ working-2.6/arch/powerpc/boot/Makefile	2007-02-06 14:15:08.000000000 +1100
@@ -41,7 +41,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
 		$(addprefix $(obj)/,$(zlibheader))
 
 src-wlib := string.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
-		ns16550.c serial.c simple_alloc.c div64.S util.S $(zlib)
+		ns16550.c serial.c simple_alloc.c div64.S util.S bss_stack.S $(zlib)
 src-plat := of.c
 src-boot := crt0.S $(src-wlib) $(src-plat) empty.c
 
Index: working-2.6/arch/powerpc/boot/ops.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ops.h	2007-02-06 14:14:00.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ops.h	2007-02-06 14:15:45.000000000 +1100
@@ -100,4 +100,7 @@ static inline void exit(void)
 	for(;;);
 }
 
+extern char _bss_stack[], _bss_stack_top[];
+#define USE_BSS_STACK	void *_bss_stack_ptr = &_bss_stack_top
+
 #endif /* _PPC_BOOT_OPS_H_ */
