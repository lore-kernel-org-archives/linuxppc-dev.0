Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJ2XQ2smTzF0kL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 23:45:25 +1100 (AEDT)
Message-Id: <317df1bb52648ef08045fb76107f9d7667896e6f.1515759812.git.christophe.leroy@c-s.fr>
In-Reply-To: <bb30d80cc985d7307fa1286c9e6824230698919b.1515759812.git.christophe.leroy@c-s.fr>
References: <bb30d80cc985d7307fa1286c9e6824230698919b.1515759812.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/8] powerpc/8xx: remove EXCEPTION_PROLOG/EPILOG_0 and change
 r3 to r12
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 12 Jan 2018 13:45:21 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

EXCEPTION_PROLOG_0 and EXCEPTION_EPILOG_0 were added some
time ago in order to regroup the two mtspr/mfspr to SCRATCH0 and
SCRATCH1 and the mfcr/mtcr in order to ease entry and exit of
function not using the full EXCEPTION_PROLOG.

Since then, the mfcr/mtcr has been taken out, hence just leaving
the two mtspr/mfspr in the macro.

In order to improve readability of the exception functions, we
remove those two macros and copy back the two mtspr/mfspr instead.

As r10 and r11 are used for SCRATCH0 and SCRATCH1, lets also use
r12 for SCRATCH2. It will also improve the readability/maintenance.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 78 ++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 728b513c07b8..eda582b96dbf 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -117,15 +117,12 @@ turn_on_mmu:
  * task's thread_struct.
  */
 #define EXCEPTION_PROLOG	\
-	EXCEPTION_PROLOG_0;	\
+	mtspr	SPRN_SPRG_SCRATCH0, r10;	\
+	mtspr	SPRN_SPRG_SCRATCH1, r11;	\
 	mfcr	r10;		\
 	EXCEPTION_PROLOG_1;	\
 	EXCEPTION_PROLOG_2
 
-#define EXCEPTION_PROLOG_0	\
-	mtspr	SPRN_SPRG_SCRATCH0,r10;	\
-	mtspr	SPRN_SPRG_SCRATCH1,r11
-
 #define EXCEPTION_PROLOG_1	\
 	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel */ \
 	andi.	r11,r11,MSR_PR;	\
@@ -160,13 +157,6 @@ turn_on_mmu:
 	SAVE_2GPRS(7, r11)
 
 /*
- * Exception exit code.
- */
-#define EXCEPTION_EPILOG_0	\
-	mfspr	r10,SPRN_SPRG_SCRATCH0;	\
-	mfspr	r11,SPRN_SPRG_SCRATCH1
-
-/*
  * Note: code which follows this uses cr0.eq (set if from kernel),
  * r11, r12 (SRR0), and r9 (SRR1).
  *
@@ -309,10 +299,11 @@ SystemCall:
 #endif
 
 InstructionTLBMiss:
+	mtspr	SPRN_SPRG_SCRATCH0, r10
+	mtspr	SPRN_SPRG_SCRATCH1, r11
 #if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
-	mtspr	SPRN_SPRG_SCRATCH2, r3
+	mtspr	SPRN_SPRG_SCRATCH2, r12
 #endif
-	EXCEPTION_PROLOG_0
 #ifdef CONFIG_PPC_8xx_PERF_EVENT
 	lis	r10, (itlb_miss_counter - PAGE_OFFSET)@ha
 	lwz	r11, (itlb_miss_counter - PAGE_OFFSET)@l(r10)
@@ -328,7 +319,7 @@ InstructionTLBMiss:
 	/* Only modules will cause ITLB Misses as we always
 	 * pin the first 8MB of kernel memory */
 #if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
-	mfcr	r3
+	mfcr	r12
 #endif
 #ifdef ITLB_MISS_KERNEL
 #if defined(SIMPLE_KERNEL_ADDRESS) && defined(CONFIG_PIN_TLB_TEXT)
@@ -371,7 +362,7 @@ _ENTRY(ITLBMiss_cmp)
 	lwz	r10, 0(r10)	/* Get the pte */
 4:
 #if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
-	mtcr	r3
+	mtcr	r12
 #endif
 	/* Insert the APG into the TWC from the Linux PTE. */
 	rlwimi	r11, r10, 0, 25, 26
@@ -401,10 +392,11 @@ _ENTRY(ITLBMiss_cmp)
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
 	/* Restore registers */
+	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
 #if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
-	mfspr	r3, SPRN_SPRG_SCRATCH2
+	mfspr	r12, SPRN_SPRG_SCRATCH2
 #endif
-	EXCEPTION_EPILOG_0
 	rfi
 
 #ifdef CONFIG_HUGETLB_PAGE
@@ -434,15 +426,16 @@ _ENTRY(ITLBMiss_cmp)
 
 	. = 0x1200
 DataStoreTLBMiss:
-	mtspr	SPRN_SPRG_SCRATCH2, r3
-	EXCEPTION_PROLOG_0
+	mtspr	SPRN_SPRG_SCRATCH0, r10
+	mtspr	SPRN_SPRG_SCRATCH1, r11
+	mtspr	SPRN_SPRG_SCRATCH2, r12
 #ifdef CONFIG_PPC_8xx_PERF_EVENT
 	lis	r10, (dtlb_miss_counter - PAGE_OFFSET)@ha
 	lwz	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
 	addi	r11, r11, 1
 	stw	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
 #endif
-	mfcr	r3
+	mfcr	r12
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
@@ -482,7 +475,7 @@ _ENTRY(DTLBMiss_jmp)
 	rlwimi	r10, r11, 0, 0, 32 - PAGE_SHIFT - 1	/* Add level 2 base */
 	lwz	r10, 0(r10)	/* Get the pte */
 4:
-	mtcr	r3
+	mtcr	r12
 
 	/* Insert the Guarded flag and APG into the TWC from the Linux PTE.
 	 * It is bit 26-27 of both the Linux PTE and the TWC (at least
@@ -532,9 +525,10 @@ _ENTRY(DTLBMiss_jmp)
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
 
 	/* Restore registers */
-	mfspr	r3, SPRN_SPRG_SCRATCH2
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
-	EXCEPTION_EPILOG_0
+	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
 
 #ifdef CONFIG_HUGETLB_PAGE
@@ -584,7 +578,8 @@ itlbie:
  */
 	. = 0x1400
 DataTLBError:
-	EXCEPTION_PROLOG_0
+	mtspr	SPRN_SPRG_SCRATCH0, r10
+	mtspr	SPRN_SPRG_SCRATCH1, r11
 	mfcr	r10
 
 	mfspr	r11, SPRN_DAR
@@ -619,7 +614,8 @@ dtlbie:
  */
 	. = 0x1c00
 DataBreakpoint:
-	EXCEPTION_PROLOG_0
+	mtspr	SPRN_SPRG_SCRATCH0, r10
+	mtspr	SPRN_SPRG_SCRATCH1, r11
 	mfcr	r10
 	mfspr	r11, SPRN_SRR0
 	cmplwi	cr0, r11, (dtlbie - PAGE_OFFSET)@l
@@ -635,13 +631,15 @@ DataBreakpoint:
 	EXC_XFER_EE(0x1c00, do_break)
 11:
 	mtcr	r10
-	EXCEPTION_EPILOG_0
+	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
 	rfi
 
 #ifdef CONFIG_PPC_8xx_PERF_EVENT
 	. = 0x1d00
 InstructionBreakpoint:
-	EXCEPTION_PROLOG_0
+	mtspr	SPRN_SPRG_SCRATCH0, r10
+	mtspr	SPRN_SPRG_SCRATCH1, r11
 	lis	r10, (instruction_counter - PAGE_OFFSET)@ha
 	lwz	r11, (instruction_counter - PAGE_OFFSET)@l(r10)
 	addi	r11, r11, -1
@@ -649,7 +647,8 @@ InstructionBreakpoint:
 	lis	r10, 0xffff
 	ori	r10, r10, 0x01
 	mtspr	SPRN_COUNTA, r10
-	EXCEPTION_EPILOG_0
+	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
 	rfi
 #else
 	EXCEPTION(0x1d00, Trap_1d, unknown_exception, EXC_XFER_EE)
@@ -664,7 +663,7 @@ InstructionBreakpoint:
  * not enough space in the DataStoreTLBMiss area.
  */
 DTLBMissIMMR:
-	mtcr	r3
+	mtcr	r12
 	/* Set 512k byte guarded page and mark it valid */
 	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID
 	mtspr	SPRN_MD_TWC, r10
@@ -676,12 +675,13 @@ DTLBMissIMMR:
 
 	li	r11, RPN_PATTERN
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
-	mfspr	r3, SPRN_SPRG_SCRATCH2
-	EXCEPTION_EPILOG_0
+	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
 
 DTLBMissLinear:
-	mtcr	r3
+	mtcr	r12
 	/* Set 8M byte page and mark it valid */
 	li	r11, MD_PS8MEG | MD_SVALID
 	mtspr	SPRN_MD_TWC, r11
@@ -692,13 +692,14 @@ DTLBMissLinear:
 
 	li	r11, RPN_PATTERN
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
-	mfspr	r3, SPRN_SPRG_SCRATCH2
-	EXCEPTION_EPILOG_0
+	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
 
 #ifndef CONFIG_PIN_TLB_TEXT
 ITLBMissLinear:
-	mtcr	r3
+	mtcr	r12
 	/* Set 8M byte page and mark it valid */
 	li	r11, MI_PS8MEG | MI_SVALID | _PAGE_EXEC
 	mtspr	SPRN_MI_TWC, r11
@@ -707,8 +708,9 @@ ITLBMissLinear:
 			  _PAGE_PRESENT
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
-	mfspr	r3, SPRN_SPRG_SCRATCH2
-	EXCEPTION_EPILOG_0
+	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
 #endif
 
-- 
2.13.3
