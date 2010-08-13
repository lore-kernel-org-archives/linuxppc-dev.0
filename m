Return-Path: <anton@ozlabs.org>
Date: Fri, 13 Aug 2010 12:28:09 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Add support for popcnt instructions
Message-ID: <20100813022809.GY29316@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


POWER5 added popcntb, and POWER7 added popcntw and popcntd. As a first step
this patch does all the work out of line, but it would be nice to implement
them as inlines with an out of line fallback.

The performance issue with hweight was noticed when disabling SMT on a large
(192 thread) POWER7 box. The patch improves that testcase by about 8%.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/include/asm/cputable.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/cputable.h	2010-08-13 11:19:42.691991439 +1000
+++ powerpc.git/arch/powerpc/include/asm/cputable.h	2010-08-13 11:24:55.510741618 +1000
@@ -199,6 +199,8 @@ extern const char *powerpc_base_platform
 #define CPU_FTR_UNALIGNED_LD_STD	LONG_ASM_CONST(0x0080000000000000)
 #define CPU_FTR_ASYM_SMT		LONG_ASM_CONST(0x0100000000000000)
 #define CPU_FTR_STCX_CHECKS_ADDRESS	LONG_ASM_CONST(0x0200000000000000)
+#define CPU_FTR_POPCNTB			LONG_ASM_CONST(0x0400000000000000)
+#define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0800000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -403,21 +405,22 @@ extern const char *powerpc_base_platform
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
-	    CPU_FTR_PURR | CPU_FTR_STCX_CHECKS_ADDRESS)
+	    CPU_FTR_PURR | CPU_FTR_STCX_CHECKS_ADDRESS | \
+	    CPU_FTR_POPCNTB)
 #define CPU_FTRS_POWER6 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_UNALIGNED_LD_STD | \
-	    CPU_FTR_STCX_CHECKS_ADDRESS)
+	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB)
 #define CPU_FTRS_POWER7 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
-	    CPU_FTR_STCX_CHECKS_ADDRESS)
+	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
Index: powerpc.git/arch/powerpc/lib/Makefile
===================================================================
--- powerpc.git.orig/arch/powerpc/lib/Makefile	2010-08-13 11:19:43.653241065 +1000
+++ powerpc.git/arch/powerpc/lib/Makefile	2010-08-13 11:19:45.930743841 +1000
@@ -18,7 +18,7 @@ obj-$(CONFIG_HAS_IOMEM)	+= devres.o
 
 obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
 			   memcpy_64.o usercopy_64.o mem_64.o string.o \
-			   checksum_wrappers_64.o
+			   checksum_wrappers_64.o hweight_64.o
 obj-$(CONFIG_XMON)	+= sstep.o ldstfp.o
 obj-$(CONFIG_KPROBES)	+= sstep.o ldstfp.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= sstep.o ldstfp.o
Index: powerpc.git/arch/powerpc/lib/hweight_64.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ powerpc.git/arch/powerpc/lib/hweight_64.S	2010-08-13 11:19:45.940741462 +1000
@@ -0,0 +1,110 @@
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
+ * Copyright (C) IBM Corporation, 2010
+ *
+ * Author: Anton Blanchard <anton@au.ibm.com>
+ */
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+
+/* Note: This code relies on -mminimal-toc */
+
+_GLOBAL(__arch_hweight8)
+BEGIN_FTR_SECTION
+	b .__sw_hweight8
+	nop
+	nop
+FTR_SECTION_ELSE
+	popcntb	r3,r3
+	clrldi	r3,r3,64-8
+	blr
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
+
+_GLOBAL(__arch_hweight16)
+BEGIN_FTR_SECTION
+	b .__sw_hweight16
+	nop
+	nop
+	nop
+	nop
+FTR_SECTION_ELSE
+  BEGIN_FTR_SECTION_NESTED(50)
+	popcntb r3,r3
+	srdi	r4,r3,8
+	add	r3,r4,r3
+	clrldi	r3,r3,64-8
+	blr
+  FTR_SECTION_ELSE_NESTED(50)
+	clrlwi  r3,r3,16
+	popcntw	r3,r3
+	clrldi	r3,r3,64-8
+	blr
+  ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 50)
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
+
+_GLOBAL(__arch_hweight32)
+BEGIN_FTR_SECTION
+	b .__sw_hweight32
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+FTR_SECTION_ELSE
+  BEGIN_FTR_SECTION_NESTED(51)
+	popcntb r3,r3
+	srdi	r4,r3,16
+	add	r3,r4,r3
+	srdi	r4,r3,8
+	add	r3,r4,r3
+	clrldi	r3,r3,64-8
+	blr
+  FTR_SECTION_ELSE_NESTED(51)
+	popcntw	r3,r3
+	clrldi	r3,r3,64-8
+	blr
+  ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 51)
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
+
+_GLOBAL(__arch_hweight64)
+BEGIN_FTR_SECTION
+	b .__sw_hweight64
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+FTR_SECTION_ELSE
+  BEGIN_FTR_SECTION_NESTED(52)
+	popcntb r3,r3
+	srdi	r4,r3,32
+	add	r3,r4,r3
+	srdi	r4,r3,16
+	add	r3,r4,r3
+	srdi	r4,r3,8
+	add	r3,r4,r3
+	clrldi	r3,r3,64-8
+	blr
+  FTR_SECTION_ELSE_NESTED(52)
+	popcntd	r3,r3
+	clrldi	r3,r3,64-8
+	blr
+  ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 52)
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
Index: powerpc.git/arch/powerpc/include/asm/bitops.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/bitops.h	2010-08-13 11:06:20.991992998 +1000
+++ powerpc.git/arch/powerpc/include/asm/bitops.h	2010-08-13 11:19:45.940741462 +1000
@@ -267,7 +267,16 @@ static __inline__ int fls64(__u64 x)
 #include <asm-generic/bitops/fls64.h>
 #endif /* __powerpc64__ */
 
+#ifdef CONFIG_PPC64
+unsigned int __arch_hweight8(unsigned int w);
+unsigned int __arch_hweight16(unsigned int w);
+unsigned int __arch_hweight32(unsigned int w);
+unsigned long __arch_hweight64(__u64 w);
+#include <asm-generic/bitops/const_hweight.h>
+#else
 #include <asm-generic/bitops/hweight.h>
+#endif
+
 #include <asm-generic/bitops/find.h>
 
 /* Little-endian versions */
Index: powerpc.git/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/ppc_ksyms.c	2010-08-13 11:06:21.011991745 +1000
+++ powerpc.git/arch/powerpc/kernel/ppc_ksyms.c	2010-08-13 11:19:45.940741462 +1000
@@ -186,3 +186,10 @@ EXPORT_SYMBOL(__mtdcr);
 EXPORT_SYMBOL(__mfdcr);
 #endif
 EXPORT_SYMBOL(empty_zero_page);
+
+#ifdef CONFIG_PPC64
+EXPORT_SYMBOL(__arch_hweight8);
+EXPORT_SYMBOL(__arch_hweight16);
+EXPORT_SYMBOL(__arch_hweight32);
+EXPORT_SYMBOL(__arch_hweight64);
+#endif
