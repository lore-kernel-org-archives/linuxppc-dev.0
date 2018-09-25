Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KRsS0TPSzF13T
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 02:50:52 +1000 (AEST)
Message-Id: <60c0f3b871bba32a4e3ddb4c93b3543fd6a7973c.1537892498.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537892498.git.christophe.leroy@c-s.fr>
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 05/22] powerpc/8xx: Move SW perf counters in first 32kb of
 memory
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 25 Sep 2018 16:50:48 +0000 (UTC)
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
the beginning of memory. This is possible because .text is readable
and the counters are never modified outside of the handlers.

By doing this, we avoid having to set a second register with
the upper part of the address of the counters.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 58 ++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 3b67b9533c82..c203defe49a4 100644
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
@@ -384,17 +401,16 @@ InstructionTLBMiss:
 
 #ifdef CONFIG_PERF_EVENTS
 	patch_site	0f, patch__itlbmiss_perf
-0:	lis	r10, (itlb_miss_counter - PAGE_OFFSET)@ha
-	lwz	r11, (itlb_miss_counter - PAGE_OFFSET)@l(r10)
-	addi	r11, r11, 1
-	stw	r11, (itlb_miss_counter - PAGE_OFFSET)@l(r10)
-#endif
+0:	lwz	r10, (itlb_miss_counter - PAGE_OFFSET)@l(0)
+	addi	r10, r10, 1
+	stw	r10, (itlb_miss_counter - PAGE_OFFSET)@l(0)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 #if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
 	mfspr	r12, SPRN_SPRG_SCRATCH2
 #endif
 	rfi
+#endif
 
 #ifdef CONFIG_HUGETLB_PAGE
 10:	/* 8M pages */
@@ -509,15 +525,14 @@ DataStoreTLBMiss:
 
 #ifdef CONFIG_PERF_EVENTS
 	patch_site	0f, patch__dtlbmiss_perf
-0:	lis	r10, (dtlb_miss_counter - PAGE_OFFSET)@ha
-	lwz	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
-	addi	r11, r11, 1
-	stw	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
-#endif
+0:	lwz	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
+	addi	r10, r10, 1
+	stw	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
+#endif
 
 #ifdef CONFIG_HUGETLB_PAGE
 10:	/* 8M pages */
@@ -625,16 +640,13 @@ DataBreakpoint:
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
@@ -1065,17 +1077,3 @@ swapper_pg_dir:
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
