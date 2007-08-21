Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 96397DDE40
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 14:55:57 +1000 (EST)
Date: Tue, 21 Aug 2007 14:55:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 4/4] [POWERPC] Split out iSeries specific exception macros
Message-Id: <20070821145549.61a842d5.sfr@canb.auug.org.au>
In-Reply-To: <20070821144538.4c6ce421.sfr@canb.auug.org.au>
References: <20070821144222.e240bbf0.sfr@canb.auug.org.au>
	<20070821144422.776257e3.sfr@canb.auug.org.au>
	<20070821144538.4c6ce421.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/exception.h |   58 ++++++++++++++++++++++
 arch/powerpc/platforms/iseries/head.S      |   15 +++---
 include/asm-powerpc/exception.h            |   71 +++++-----------------------
 3 files changed, 78 insertions(+), 66 deletions(-)
 create mode 100644 arch/powerpc/platforms/iseries/exception.h

Built for iseries_defconfig, pseries_defconfig, ppc64_defconfig,
allmodconfig, booted on iSeries 270 for iseries_defconfig and
ppc64_defconfig and booted on pSeries POWER5+ for pseries_defconfig and
ppc64_defconfig.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/exception.h b/arch/powerpc/platforms/iseries/exception.h
new file mode 100644
index 0000000..5b3f285
--- /dev/null
+++ b/arch/powerpc/platforms/iseries/exception.h
@@ -0,0 +1,58 @@
+#ifndef _ASM_POWERPC_ISERIES_EXCEPTION_H
+#define _ASM_POWERPC_ISERIES_EXCEPTION_H
+/*
+ * Extracted from head_64.S
+ *
+ *  PowerPC version
+ *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
+ *
+ *  Rewritten by Cort Dougan (cort@cs.nmt.edu) for PReP
+ *    Copyright (C) 1996 Cort Dougan <cort@cs.nmt.edu>
+ *  Adapted for Power Macintosh by Paul Mackerras.
+ *  Low-level exception handlers and MMU support
+ *  rewritten by Paul Mackerras.
+ *    Copyright (C) 1996 Paul Mackerras.
+ *
+ *  Adapted for 64bit PowerPC by Dave Engebretsen, Peter Bergner, and
+ *    Mike Corrigan {engebret|bergner|mikejc}@us.ibm.com
+ *
+ *  This file contains the low-level support and setup for the
+ *  PowerPC-64 platform, including trap and interrupt dispatch.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+#include <asm/exception.h>
+
+#define EXCEPTION_PROLOG_ISERIES_1					\
+	mfmsr	r10;							\
+	ld	r12,PACALPPACAPTR(r13);					\
+	ld	r11,LPPACASRR0(r12);					\
+	ld	r12,LPPACASRR1(r12);					\
+	ori	r10,r10,MSR_RI;						\
+	mtmsrd	r10,1
+
+#define STD_EXCEPTION_ISERIES(n, label, area)				\
+	.globl label##_iSeries;						\
+label##_iSeries:							\
+	HMT_MEDIUM;							\
+	mtspr	SPRN_SPRG1,r13;		/* save r13 */			\
+	EXCEPTION_PROLOG_1(area);					\
+	EXCEPTION_PROLOG_ISERIES_1;					\
+	b	label##_common
+
+#define MASKABLE_EXCEPTION_ISERIES(n, label)				\
+	.globl label##_iSeries;						\
+label##_iSeries:							\
+	HMT_MEDIUM;							\
+	mtspr	SPRN_SPRG1,r13;		/* save r13 */			\
+	EXCEPTION_PROLOG_1(PACA_EXGEN);					\
+	lbz	r10,PACASOFTIRQEN(r13);					\
+	cmpwi	0,r10,0;						\
+	beq-	label##_iSeries_masked;					\
+	EXCEPTION_PROLOG_ISERIES_1;					\
+	b	label##_common;						\
+
+#endif	/* _ASM_POWERPC_ISERIES_EXCEPTION_H */
diff --git a/arch/powerpc/platforms/iseries/head.S b/arch/powerpc/platforms/iseries/head.S
index b5f6006..e9a3435 100644
--- a/arch/powerpc/platforms/iseries/head.S
+++ b/arch/powerpc/platforms/iseries/head.S
@@ -30,9 +30,10 @@
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/ptrace.h>
-#include <asm/exception.h>
 #include <asm/cputable.h>
 
+#include "exception.h"
+
 	.text
 
 	.globl system_reset_iSeries
@@ -104,15 +105,15 @@ BEGIN_FTR_SECTION
 	mtcrf	0x80,r12
 	mfspr	r12,SPRN_SPRG2
 END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
-	EXCEPTION_PROLOG_ISERIES_1(PACA_EXGEN)
-	EXCEPTION_PROLOG_ISERIES_2
+	EXCEPTION_PROLOG_1(PACA_EXGEN)
+	EXCEPTION_PROLOG_ISERIES_1
 	b	data_access_common
 
 .do_stab_bolted_iSeries:
 	mtcrf	0x80,r12
 	mfspr	r12,SPRN_SPRG2
-	EXCEPTION_PROLOG_ISERIES_1(PACA_EXSLB)
-	EXCEPTION_PROLOG_ISERIES_2
+	EXCEPTION_PROLOG_1(PACA_EXSLB)
+	EXCEPTION_PROLOG_ISERIES_1
 	b	.do_stab_bolted
 
 	.globl	data_access_slb_iSeries
@@ -171,7 +172,7 @@ slb_miss_user_iseries:
 	std	r10,PACA_EXGEN+EX_R13(r13)
 	std	r11,PACA_EXGEN+EX_R9(r13)
 	std	r12,PACA_EXGEN+EX_R3(r13)
-	EXCEPTION_PROLOG_ISERIES_2
+	EXCEPTION_PROLOG_ISERIES_1
 	b	slb_miss_user_common
 #endif
 
@@ -187,7 +188,7 @@ slb_miss_user_iseries:
 system_call_iSeries:
 	mr	r9,r13
 	mfspr	r13,SPRN_SPRG3
-	EXCEPTION_PROLOG_ISERIES_2
+	EXCEPTION_PROLOG_ISERIES_1
 	b	system_call_common
 
 	STD_EXCEPTION_ISERIES( 0xd00, single_step, PACA_EXGEN)
diff --git a/include/asm-powerpc/exception.h b/include/asm-powerpc/exception.h
index 1980ed3..d850c8e 100644
--- a/include/asm-powerpc/exception.h
+++ b/include/asm-powerpc/exception.h
@@ -62,6 +62,16 @@
 	ori	reg,reg,(label)@l;	/* virt addr of handler ... */
 #endif
 
+#define EXCEPTION_PROLOG_1(area)				\
+	mfspr	r13,SPRN_SPRG3;		/* get paca address into r13 */	\
+	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
+	std	r10,area+EX_R10(r13);					\
+	std	r11,area+EX_R11(r13);					\
+	std	r12,area+EX_R12(r13);					\
+	mfspr	r9,SPRN_SPRG1;						\
+	std	r9,area+EX_R13(r13);					\
+	mfcr	r9
+
 /*
  * Equal to EXCEPTION_PROLOG_PSERIES, except that it forces 64bit mode.
  * The firmware calls the registered system_reset_fwnmi and
@@ -70,14 +80,7 @@
  * This firmware bug is present on POWER4 and JS20.
  */
 #define EXCEPTION_PROLOG_PSERIES_FORCE_64BIT(area, label)		\
-	mfspr	r13,SPRN_SPRG3;		/* get paca address into r13 */	\
-	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
-	std	r10,area+EX_R10(r13);					\
-	std	r11,area+EX_R11(r13);					\
-	std	r12,area+EX_R12(r13);					\
-	mfspr	r9,SPRN_SPRG1;						\
-	std	r9,area+EX_R13(r13);					\
-	mfcr	r9;							\
+	EXCEPTION_PROLOG_1(area);					\
 	clrrdi	r12,r13,32;		/* get high part of &label */	\
 	mfmsr	r10;							\
 	/* force 64bit mode */						\
@@ -94,14 +97,7 @@
 	b	.	/* prevent speculative execution */
 
 #define EXCEPTION_PROLOG_PSERIES(area, label)				\
-	mfspr	r13,SPRN_SPRG3;		/* get paca address into r13 */	\
-	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
-	std	r10,area+EX_R10(r13);					\
-	std	r11,area+EX_R11(r13);					\
-	std	r12,area+EX_R12(r13);					\
-	mfspr	r9,SPRN_SPRG1;						\
-	std	r9,area+EX_R13(r13);					\
-	mfcr	r9;							\
+	EXCEPTION_PROLOG_1(area);					\
 	clrrdi	r12,r13,32;		/* get high part of &label */	\
 	mfmsr	r10;							\
 	mfspr	r11,SPRN_SRR0;		/* save SRR0 */			\
@@ -114,28 +110,6 @@
 	b	.	/* prevent speculative execution */
 
 /*
- * This is the start of the interrupt handlers for iSeries
- * This code runs with relocation on.
- */
-#define EXCEPTION_PROLOG_ISERIES_1(area)				\
-	mfspr	r13,SPRN_SPRG3;		/* get paca address into r13 */	\
-	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
-	std	r10,area+EX_R10(r13);					\
-	std	r11,area+EX_R11(r13);					\
-	std	r12,area+EX_R12(r13);					\
-	mfspr	r9,SPRN_SPRG1;						\
-	std	r9,area+EX_R13(r13);					\
-	mfcr	r9
-
-#define EXCEPTION_PROLOG_ISERIES_2					\
-	mfmsr	r10;							\
-	ld	r12,PACALPPACAPTR(r13);					\
-	ld	r11,LPPACASRR0(r12);					\
-	ld	r12,LPPACASRR1(r12);					\
-	ori	r10,r10,MSR_RI;						\
-	mtmsrd	r10,1
-
-/*
  * The common exception prolog is used for all except a few exceptions
  * such as a segment miss on a kernel address.  We have to be prepared
  * to take another exception from the point where we first touch the
@@ -247,27 +221,6 @@ label##_pSeries:							\
 	rfid;								\
 	b	.	/* prevent speculative execution */
 
-#define STD_EXCEPTION_ISERIES(n, label, area)		\
-	.globl label##_iSeries;				\
-label##_iSeries:					\
-	HMT_MEDIUM;					\
-	mtspr	SPRN_SPRG1,r13;		/* save r13 */	\
-	EXCEPTION_PROLOG_ISERIES_1(area);		\
-	EXCEPTION_PROLOG_ISERIES_2;			\
-	b	label##_common
-
-#define MASKABLE_EXCEPTION_ISERIES(n, label)				\
-	.globl label##_iSeries;						\
-label##_iSeries:							\
-	HMT_MEDIUM;							\
-	mtspr	SPRN_SPRG1,r13;		/* save r13 */			\
-	EXCEPTION_PROLOG_ISERIES_1(PACA_EXGEN);				\
-	lbz	r10,PACASOFTIRQEN(r13);					\
-	cmpwi	0,r10,0;						\
-	beq-	label##_iSeries_masked;					\
-	EXCEPTION_PROLOG_ISERIES_2;					\
-	b	label##_common;						\
-
 #ifdef CONFIG_PPC_ISERIES
 #define DISABLE_INTS				\
 	li	r11,0;				\
-- 
1.5.2.4
