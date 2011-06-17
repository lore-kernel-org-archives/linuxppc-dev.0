Return-Path: <anton@samba.org>
Message-Id: <20110617045421.538184870@samba.org>
Date: Fri, 17 Jun 2011 14:53:59 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org,
 mikey@neuling.org
Subject: [PATCH 1/3] powerpc: POWER7 optimised copy_page using VMX
References: <20110617045358.544896830@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement a POWER7 optimised copy_page using VMX. We copy a cacheline
at a time using VMX loads and stores.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

How do we want to handle per machine optimised functions? I create
yet another feature bit, but feature bits might get out of control
at some point.

Index: linux-powerpc/arch/powerpc/include/asm/cputable.h
===================================================================
--- linux-powerpc.orig/arch/powerpc/include/asm/cputable.h	2011-06-06 08:07:35.128707749 +1000
+++ linux-powerpc/arch/powerpc/include/asm/cputable.h	2011-06-17 07:39:58.996165527 +1000
@@ -200,6 +200,7 @@ extern const char *powerpc_base_platform
 #define CPU_FTR_POPCNTB			LONG_ASM_CONST(0x0400000000000000)
 #define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0800000000000000)
 #define CPU_FTR_ICSWX			LONG_ASM_CONST(0x1000000000000000)
+#define CPU_FTR_POWER7			LONG_ASM_CONST(0x2000000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -423,7 +424,7 @@ extern const char *powerpc_base_platform
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
-	    CPU_FTR_ICSWX | CPU_FTR_CFAR)
+	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_POWER7)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
Index: linux-powerpc/arch/powerpc/lib/copypage_power7.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-powerpc/arch/powerpc/lib/copypage_power7.S	2011-06-17 07:39:58.996165527 +1000
@@ -0,0 +1,70 @@
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
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2011
+ *
+ * Author: Anton Blanchard <anton@au.ibm.com>
+ */
+#include <asm/page.h>
+#include <asm/ppc_asm.h>
+
+#define STACKFRAMESIZE	112
+
+_GLOBAL(copypage_power7)
+	mflr	r0
+	std	r3,48(r1)
+	std	r4,56(r1)
+	std	r0,16(r1)
+	stdu	r1,-STACKFRAMESIZE(r1)
+
+	bl	.enable_kernel_altivec
+
+	ld	r12,STACKFRAMESIZE+16(r1)
+	ld	r4,STACKFRAMESIZE+56(r1)
+	li	r0,(PAGE_SIZE/128)
+	li	r6,16
+	ld	r3,STACKFRAMESIZE+48(r1)
+	li	r7,32
+	li	r8,48
+	mtctr	r0
+	li	r9,64
+	li	r10,80
+	mtlr	r12
+	li	r11,96
+	li	r12,112
+	addi	r1,r1,STACKFRAMESIZE
+
+	.align	5
+1:	lvx	vr7,r0,r4
+	lvx	vr6,r4,r6
+	lvx	vr5,r4,r7
+	lvx	vr4,r4,r8
+	lvx	vr3,r4,r9
+	lvx	vr2,r4,r10
+	lvx	vr1,r4,r11
+	lvx	vr0,r4,r12
+	addi	r4,r4,128
+	stvx	vr7,r0,r3
+	stvx	vr6,r3,r6
+	stvx	vr5,r3,r7
+	stvx	vr4,r3,r8
+	stvx	vr3,r3,r9
+	stvx	vr2,r3,r10
+	stvx	vr1,r3,r11
+	stvx	vr0,r3,r12
+	addi	r3,r3,128
+	bdnz	1b
+
+	blr
Index: linux-powerpc/arch/powerpc/lib/Makefile
===================================================================
--- linux-powerpc.orig/arch/powerpc/lib/Makefile	2011-05-19 19:57:38.058570608 +1000
+++ linux-powerpc/arch/powerpc/lib/Makefile	2011-06-17 07:39:58.996165527 +1000
@@ -16,7 +16,8 @@ obj-$(CONFIG_HAS_IOMEM)	+= devres.o
 
 obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
 			   memcpy_64.o usercopy_64.o mem_64.o string.o \
-			   checksum_wrappers_64.o hweight_64.o
+			   checksum_wrappers_64.o hweight_64.o \
+			   copypage_power7.o
 obj-$(CONFIG_XMON)	+= sstep.o ldstfp.o
 obj-$(CONFIG_KPROBES)	+= sstep.o ldstfp.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= sstep.o ldstfp.o
Index: linux-powerpc/arch/powerpc/lib/copypage_64.S
===================================================================
--- linux-powerpc.orig/arch/powerpc/lib/copypage_64.S	2011-06-06 08:07:35.000000000 +1000
+++ linux-powerpc/arch/powerpc/lib/copypage_64.S	2011-06-17 07:39:58.996165527 +1000
@@ -17,7 +17,11 @@ PPC64_CACHES:
         .section        ".text"
 
 _GLOBAL(copy_page)
+BEGIN_FTR_SECTION
 	lis	r5,PAGE_SIZE@h
+FTR_SECTION_ELSE
+        b       .copypage_power7
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POWER7)
 	ori	r5,r5,PAGE_SIZE@l
 BEGIN_FTR_SECTION
 	ld      r10,PPC64_CACHES@toc(r2)
