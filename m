Return-Path: <miltonm@sullivan.realtime.net>
Date: Wed, 11 Apr 2007 03:33:27 -0500 (CDT)
Subject: [PATCH 4/8] bootwrapper: help for 64 bit cpus
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-4-04.miltonm@bga.com>
In-Reply-To: <boot-4-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A procedure descriptior for the entry point, and a routine to
clear MSR[SF] if we are running in 64 bit mode via mtmsrd before
calling _zimage_start_lib.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 

Index: kernel/arch/powerpc/boot/misc64.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/misc64.S	2007-03-29 03:42:25.000000000 -0500
@@ -0,0 +1,67 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright (C) 2007 IBM Corporation.
+ *
+ * Authors: Milton Miller <miltonm@bga.com>
+ *
+ */
+#include "ppc_asm.h"
+
+
+	.globl _zimage_start_32_64
+_zimage_start_32_64:
+
+	/*
+	 * Run code compiled and linked as ELF32 in 32 bit mode.
+	 *
+	 * Check if the processor is running in 32 bit mode, using
+	 * only 32 bit instructions which should be safe on 32 and
+	 * 64 bit processors.
+	 *
+	 * Subtract bottom 32 bits of MSR from full value recording
+	 * the result.  Since MSR[SF] is in the high word, we will
+	 * be not-equal iff in 32 bit mode (MSR[SF] = 0 or 32 bit
+	 * processor).
+	 */
+	mfmsr	r0		/* grab whole msr		*/
+	rlwinm	r8,r0,0,0,31	/* extract bottom word		*/
+	subf.	r8,r8,r0	/* subtract, same?		*/
+	beq	1f		/* yes: we are 32 bit mode	*/
+
+	/* We are in 64-bit mode.  This program must run in 32 bit
+	 * mode.  Assume we are actually running somewhere in the
+	 * low 32 bits of the address space, so we can just turn
+	 * off MSR[SF] which is bit 0.
+	 */
+	.machine push
+	.machine "ppc64"
+	rldicl	r0,r0,0,1
+	sync
+	mtmsrd	r0
+	isync
+	.machine pop
+
+1:	b	_zimage_start_lib
+
+
+	.data
+
+	/* a procedure descriptor used when pretending to be elf64_powerpc */
+	.balign	8
+	.global	_zimage_start64
+_zimage_start64:
+	.long	0, _zimage_start	/* big endian, supported reloc ppc32 */
+	.quad	0, 0, 0
Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2007-03-29 03:30:20.000000000 -0500
+++ kernel/arch/powerpc/boot/Makefile	2007-03-29 03:43:17.000000000 -0500
@@ -41,7 +41,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
 		$(addprefix $(obj)/,$(zlibheader))
 
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
-		marshal.c memranges.c \
+		marshal.c memranges.c misc64.S \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c $(zlib)
 src-plat := of.c
