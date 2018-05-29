Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wJ926NNYzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 01:50:46 +1000 (AEST)
Message-Id: <58beaff9ad5caeef64b72dedd6dd31c52401322b.1527608397.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527608397.git.christophe.leroy@c-s.fr>
References: <cover.1527608397.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 14/14] powerpc/8xx: Move SW perf counters in first 32kb of
 memory
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 29 May 2018 15:50:42 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to simplify time critical exceptions handling 8xx
specific SW perf counters, this patch moves the counters into
the begining of memory. This is possible because .text is readable
and the counters are never modified outside of the handlers.

By doing this, we avoid having to set a second register with
the upper part of the address of the counters.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 75 +++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 81b125475213..084a76a012b5 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -106,6 +106,23 @@ turn_on_mmu:
 	mtspr	SPRN_SRR0,r0
 	rfi				/* enables MMU */
 
+
+#ifdef CONFIG_PERF_EVENTS
+	.align	4
+
+	.globl	itlb_miss_counter
+itlb_miss_counter:
+	.space	4
+
+	.globl	dtlb_miss_counter
+dtlb_miss_counter:
+	.space	4
+
+	.globl	instruction_counter
+instruction_counter:
+	.space	4
+#endif
+
 /*
  * Exception entry code.  This code runs with address translation
  * turned off, i.e. using physical addresses.
@@ -368,25 +385,20 @@ _ENTRY(ITLBMiss_cmp)
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
 	/* Restore registers */
-_ENTRY(itlb_miss_exit_1)
-	mfspr	r10, SPRN_SPRG_SCRATCH0
 #if defined(ITLB_MISS_KERNEL) || defined(CONFIG_SWAP)
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 #endif
+_ENTRY(itlb_miss_exit_1)
+	mfspr	r10, SPRN_SPRG_SCRATCH0
 	rfi
 #ifdef CONFIG_PERF_EVENTS
 _ENTRY(itlb_miss_perf)
-#if !defined(ITLB_MISS_KERNEL) && !defined(CONFIG_SWAP)
-	mtspr	SPRN_SPRG_SCRATCH1, r11
-#endif
-	lis	r10, (itlb_miss_counter - PAGE_OFFSET)@ha
-	lwz	r11, (itlb_miss_counter - PAGE_OFFSET)@l(r10)
-	addi	r11, r11, 1
-	stw	r11, (itlb_miss_counter - PAGE_OFFSET)@l(r10)
-#endif
+	lwz	r10, (itlb_miss_counter - PAGE_OFFSET)@l(0)
+	addi	r10, r10, 1
+	stw	r10, (itlb_miss_counter - PAGE_OFFSET)@l(0)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
 	rfi
+#endif
 
 #ifndef CONFIG_PIN_TLB_TEXT
 ITLBMissLinear:
@@ -399,9 +411,9 @@ ITLBMissLinear:
 			  _PAGE_PRESENT
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
+	mfspr	r11, SPRN_SPRG_SCRATCH1
 _ENTRY(itlb_miss_exit_2)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
 	rfi
 #endif
 
@@ -465,20 +477,18 @@ _ENTRY(DTLBMiss_jmp)
 
 	/* Restore registers */
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r11, SPRN_SPRG_SCRATCH1
 _ENTRY(dtlb_miss_exit_1)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
 	rfi
 #ifdef CONFIG_PERF_EVENTS
 _ENTRY(dtlb_miss_perf)
-	lis	r10, (dtlb_miss_counter - PAGE_OFFSET)@ha
-	lwz	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
-	addi	r11, r11, 1
-	stw	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
-#endif
+	lwz	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
+	addi	r10, r10, 1
+	stw	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
 	rfi
+#endif
 
 DTLBMissIMMR:
 	mtcr	r11
@@ -493,9 +503,9 @@ DTLBMissIMMR:
 
 	li	r11, RPN_PATTERN
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r11, SPRN_SPRG_SCRATCH1
 _ENTRY(dtlb_miss_exit_2)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
 	rfi
 
 DTLBMissLinear:
@@ -510,9 +520,9 @@ DTLBMissLinear:
 
 	li	r11, RPN_PATTERN
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r11, SPRN_SPRG_SCRATCH1
 _ENTRY(dtlb_miss_exit_3)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
 	rfi
 
 /* This is an instruction TLB error on the MPC8xx.  This could be due
@@ -598,16 +608,13 @@ DataBreakpoint:
 	. = 0x1d00
 InstructionBreakpoint:
 	mtspr	SPRN_SPRG_SCRATCH0, r10
-	mtspr	SPRN_SPRG_SCRATCH1, r11
-	lis	r10, (instruction_counter - PAGE_OFFSET)@ha
-	lwz	r11, (instruction_counter - PAGE_OFFSET)@l(r10)
-	addi	r11, r11, -1
-	stw	r11, (instruction_counter - PAGE_OFFSET)@l(r10)
+	lwz	r10, (instruction_counter - PAGE_OFFSET)@l(0)
+	addi	r10, r10, -1
+	stw	r10, (instruction_counter - PAGE_OFFSET)@l(0)
 	lis	r10, 0xffff
 	ori	r10, r10, 0x01
 	mtspr	SPRN_COUNTA, r10
 	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
 	rfi
 #else
 	EXCEPTION(0x1d00, Trap_1d, unknown_exception, EXC_XFER_EE)
@@ -966,17 +973,3 @@ swapper_pg_dir:
  */
 abatron_pteptrs:
 	.space	8
-
-#ifdef CONFIG_PERF_EVENTS
-	.globl	itlb_miss_counter
-itlb_miss_counter:
-	.space	4
-
-	.globl	dtlb_miss_counter
-dtlb_miss_counter:
-	.space	4
-
-	.globl	instruction_counter
-instruction_counter:
-	.space	4
-#endif
-- 
2.13.3
