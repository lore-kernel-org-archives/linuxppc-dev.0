Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86BC8DDEB8
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 04:01:50 +1000 (EST)
Date: Thu, 20 Sep 2007 21:55:58 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC: add setup_cpu for 44x for processor-specific init
Message-ID: <20070920175558.GA3191@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200709201732.l8KHWuGA035995@sullivan.realtime.net>
Cc: miltonm@bga.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds cpu_setup functionality to PowerPC 44x platform.
The cpu_setup callback is invoked by head_32 code and 
the identify_cpu() function at early init and is used to 
initialize FPU on 440EP(x) processors. The FPU initialization 
was previously done in head_44x.S. Also a workaround for 
the incorrect write to DDR SDRAM 440EPx/440GRx errata added.
Data can be written to wrong address in SDRAM when write 
pipelining is enabled on plb0. The setup_cpu function
for these processors disables write pipelining.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/kernel/Makefile        |    1 
 arch/powerpc/kernel/cpu_setup_44x.S |   54 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c      |   25 ++++++++++------
 arch/powerpc/kernel/head_44x.S      |   10 ------
 4 files changed, 70 insertions(+), 20 deletions(-)

diff -ruN linux-2.6.orig/arch/powerpc/kernel/cpu_setup_44x.S linux-2.6/arch/powerpc/kernel/cpu_setup_44x.S
--- linux-2.6.orig/arch/powerpc/kernel/cpu_setup_44x.S	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/arch/powerpc/kernel/cpu_setup_44x.S	2007-09-20 21:05:44.000000000 +0400
@@ -0,0 +1,54 @@
+/*
+ * This file contains low level CPU setup functions.
+ * Valentine Barshak <vbarshak@ru.mvista.com>
+ * MontaVista Software, Inc (c) 2007
+ *
+ * Based on cpu_setup_6xx code by 
+ * Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <asm/processor.h>
+#include <asm/cputable.h>
+#include <asm/ppc_asm.h>
+
+_GLOBAL(__setup_cpu_440ep)
+	b	__init_fpu_44x
+_GLOBAL(__setup_cpu_440epx)
+	mflr	r4
+	bl	__init_fpu_44x
+_GLOBAL(__setup_cpu_440grx)
+	bl	__plb_disable_wrp
+	mtlr	r4
+	blr
+
+/* enable APU between CPU and FPU */
+_GLOBAL(__init_fpu_44x)
+	mfspr	r3,SPRN_CCR0
+	/* Clear DAPUIB flag in CCR0 */
+	rlwinm	r3,r3,0,12,10
+	mtspr	SPRN_CCR0,r3
+	isync
+	blr
+
+/*
+ * Workaround for the incorrect write to DDR SDRAM errata.
+ * The write address can be corrupted during writes to
+ * DDR SDRAM when write pipelining is enabled on PLB0.
+ * Disable write pipelining here.
+ */
+#define DCRN_PLB4A0_ACR	0x81
+
+_GLOBAL(__plb_disable_wrp)
+	mfdcr	r3,DCRN_PLB4A0_ACR
+	/* clear WRP bit in PLB4A0_ACR */
+	rlwinm	r3,r3,0,8,6
+	mtdcr	DCRN_PLB4A0_ACR,r3
+	isync
+	blr
+
diff -ruN linux-2.6.orig/arch/powerpc/kernel/cputable.c linux-2.6/arch/powerpc/kernel/cputable.c
--- linux-2.6.orig/arch/powerpc/kernel/cputable.c	2007-09-20 19:30:47.000000000 +0400
+++ linux-2.6/arch/powerpc/kernel/cputable.c	2007-09-20 21:27:35.000000000 +0400
@@ -31,6 +31,9 @@
  * and ppc64
  */
 #ifdef CONFIG_PPC32
+extern void __setup_cpu_440ep(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_440epx(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_440grx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_750(unsigned long offset, struct cpu_spec* spec);
@@ -1111,6 +1114,7 @@
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440ep,
 		.platform		= "ppc440",
 	},
 	{
@@ -1121,6 +1125,7 @@
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440ep,
 		.platform		= "ppc440",
 	},
 	{ /* 440EPX */
@@ -1131,6 +1136,8 @@
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440epx,
+		.platform		= "ppc440",
 	},
 	{ /* 440GRX */
 		.pvr_mask		= 0xf0000ffb,
@@ -1140,6 +1147,8 @@
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440grx,
+		.platform		= "ppc440",
 	},
 	{	/* 440GP Rev. B */
 		.pvr_mask		= 0xf0000fff,
@@ -1318,18 +1327,14 @@
 
 	for (i = 0; i < ARRAY_SIZE(cpu_specs); i++,s++)
 		if ((pvr & s->pvr_mask) == s->pvr_value) {
+			cpu_setup_t setup_func  = PTRRELOC(s->cpu_setup);
+
 			*cur = cpu_specs + i;
-#ifdef CONFIG_PPC64
-			/* ppc64 expects identify_cpu to also call setup_cpu
-			 * for that processor. I will consolidate that at a
-			 * later time, for now, just use our friend #ifdef.
-			 * we also don't need to PTRRELOC the function pointer
-			 * on ppc64 as we are running at 0 in real mode.
+			/* ppc expects identify_cpu to also call setup_cpu
+			 * for that processor.
 			 */
-			if (s->cpu_setup) {
-				s->cpu_setup(offset, s);
-			}
-#endif /* CONFIG_PPC64 */
+			if (setup_func)
+				setup_func(offset, s);
 			return s;
 		}
 	BUG();
diff -ruN linux-2.6.orig/arch/powerpc/kernel/head_44x.S linux-2.6/arch/powerpc/kernel/head_44x.S
--- linux-2.6.orig/arch/powerpc/kernel/head_44x.S	2007-09-20 19:30:47.000000000 +0400
+++ linux-2.6/arch/powerpc/kernel/head_44x.S	2007-09-20 20:04:39.000000000 +0400
@@ -217,16 +217,6 @@
 	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
 	mtspr	SPRN_IVPR,r4
 
-#if defined(CONFIG_440EP) || defined(CONFIG_440EPX)
-	/* Clear DAPUIB flag in CCR0 (enable APU between CPU and FPU) */
-	mfspr	r2,SPRN_CCR0
-	lis	r3,0xffef
-	ori	r3,r3,0xffff
-	and	r2,r2,r3
-	mtspr	SPRN_CCR0,r2
-	isync
-#endif
-
 	/*
 	 * This is where the main kernel code starts.
 	 */
diff -ruN linux-2.6.orig/arch/powerpc/kernel/Makefile linux-2.6/arch/powerpc/kernel/Makefile
--- linux-2.6.orig/arch/powerpc/kernel/Makefile	2007-09-20 19:30:47.000000000 +0400
+++ linux-2.6/arch/powerpc/kernel/Makefile	2007-09-20 19:52:21.000000000 +0400
@@ -56,6 +56,7 @@
 				   udbg.o misc.o io.o
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o misc_32.o
 obj-$(CONFIG_PPC64)		+= misc_64.o dma_64.o iommu.o
+obj-$(CONFIG_44x)		+= cpu_setup_44x.o
 obj-$(CONFIG_PPC_MULTIPLATFORM)	+= prom_init.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
