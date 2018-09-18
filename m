Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F8L22jJCzF3Fm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 02:57:14 +1000 (AEST)
Message-Id: <e3fe32b2253ef1a5fb00a6242ee7b6800a067a19.1537288312.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537288312.git.christophe.leroy@c-s.fr>
References: <cover.1537288312.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 04/20] powerpc/8xx: Use patch_site for perf counters setup
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 18 Sep 2018 16:57:10 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 8xx TLB miss routines are patched when (de)activating
perf counters.

This patch uses the new patch_site functionality in order
to get a better code readability and avoid a label mess when
dumping the code with 'objdump -d'

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu-8xx.h |  4 ++++
 arch/powerpc/kernel/head_8xx.S     | 33 +++++++++++++++++++--------------
 arch/powerpc/perf/8xx-pmu.c        | 27 ++++++++++++---------------
 3 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index 3a15d6647d47..fa05aa566ece 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -234,6 +234,10 @@ extern s32 patch__itlbmiss_linmem_top;
 extern s32 patch__dtlbmiss_linmem_top, patch__dtlbmiss_immr_jmp;
 extern s32 patch__fixupdar_linmem_top;
 
+extern s32 patch__itlbmiss_exit_1, patch__itlbmiss_exit_2;
+extern s32 patch__dtlbmiss_exit_1, patch__dtlbmiss_exit_2, patch__dtlbmiss_exit_3;
+extern s32 patch__itlbmiss_perf, patch__dtlbmiss_perf;
+
 #endif /* !__ASSEMBLY__ */
 
 #if defined(CONFIG_PPC_4K_PAGES)
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 0425571a533d..3b67b9533c82 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -374,16 +374,17 @@ InstructionTLBMiss:
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
 	/* Restore registers */
-_ENTRY(itlb_miss_exit_1)
-	mfspr	r10, SPRN_SPRG_SCRATCH0
+0:	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 #if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
 	mfspr	r12, SPRN_SPRG_SCRATCH2
 #endif
 	rfi
+	patch_site	0b, patch__itlbmiss_exit_1
+
 #ifdef CONFIG_PERF_EVENTS
-_ENTRY(itlb_miss_perf)
-	lis	r10, (itlb_miss_counter - PAGE_OFFSET)@ha
+	patch_site	0f, patch__itlbmiss_perf
+0:	lis	r10, (itlb_miss_counter - PAGE_OFFSET)@ha
 	lwz	r11, (itlb_miss_counter - PAGE_OFFSET)@l(r10)
 	addi	r11, r11, 1
 	stw	r11, (itlb_miss_counter - PAGE_OFFSET)@l(r10)
@@ -499,14 +500,16 @@ DataStoreTLBMiss:
 
 	/* Restore registers */
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
-_ENTRY(dtlb_miss_exit_1)
-	mfspr	r10, SPRN_SPRG_SCRATCH0
+
+0:	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
+	patch_site	0b, patch__dtlbmiss_exit_1
+
 #ifdef CONFIG_PERF_EVENTS
-_ENTRY(dtlb_miss_perf)
-	lis	r10, (dtlb_miss_counter - PAGE_OFFSET)@ha
+	patch_site	0f, patch__dtlbmiss_perf
+0:	lis	r10, (dtlb_miss_counter - PAGE_OFFSET)@ha
 	lwz	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
 	addi	r11, r11, 1
 	stw	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
@@ -658,11 +661,12 @@ DTLBMissIMMR:
 
 	li	r11, RPN_PATTERN
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
-_ENTRY(dtlb_miss_exit_2)
-	mfspr	r10, SPRN_SPRG_SCRATCH0
+
+0:	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
+	patch_site	0b, patch__dtlbmiss_exit_2
 
 DTLBMissLinear:
 	mtcr	r12
@@ -676,11 +680,12 @@ DTLBMissLinear:
 
 	li	r11, RPN_PATTERN
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
-_ENTRY(dtlb_miss_exit_3)
-	mfspr	r10, SPRN_SPRG_SCRATCH0
+
+0:	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
+	patch_site	0b, patch__dtlbmiss_exit_3
 
 #ifndef CONFIG_PIN_TLB_TEXT
 ITLBMissLinear:
@@ -693,11 +698,11 @@ ITLBMissLinear:
 			  _PAGE_PRESENT
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
-_ENTRY(itlb_miss_exit_2)
-	mfspr	r10, SPRN_SPRG_SCRATCH0
+0:	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
+	patch_site	0b, patch__itlbmiss_exit_2
 #endif
 
 /* This is the procedure to calculate the data EA for buggy dcbx,dcbi instructions
diff --git a/arch/powerpc/perf/8xx-pmu.c b/arch/powerpc/perf/8xx-pmu.c
index 6c0020d1c561..808f1873de61 100644
--- a/arch/powerpc/perf/8xx-pmu.c
+++ b/arch/powerpc/perf/8xx-pmu.c
@@ -31,9 +31,6 @@
 
 extern unsigned long itlb_miss_counter, dtlb_miss_counter;
 extern atomic_t instruction_counter;
-extern unsigned int itlb_miss_perf, dtlb_miss_perf;
-extern unsigned int itlb_miss_exit_1, itlb_miss_exit_2;
-extern unsigned int dtlb_miss_exit_1, dtlb_miss_exit_2, dtlb_miss_exit_3;
 
 static atomic_t insn_ctr_ref;
 static atomic_t itlb_miss_ref;
@@ -103,22 +100,22 @@ static int mpc8xx_pmu_add(struct perf_event *event, int flags)
 		break;
 	case PERF_8xx_ID_ITLB_LOAD_MISS:
 		if (atomic_inc_return(&itlb_miss_ref) == 1) {
-			unsigned long target = (unsigned long)&itlb_miss_perf;
+			unsigned long target = site_addr(&patch__itlbmiss_perf);
 
-			patch_branch(&itlb_miss_exit_1, target, 0);
+			patch_branch_site(&patch__itlbmiss_exit_1, target, 0);
 #ifndef CONFIG_PIN_TLB_TEXT
-			patch_branch(&itlb_miss_exit_2, target, 0);
+			patch_branch_site(&patch__itlbmiss_exit_2, target, 0);
 #endif
 		}
 		val = itlb_miss_counter;
 		break;
 	case PERF_8xx_ID_DTLB_LOAD_MISS:
 		if (atomic_inc_return(&dtlb_miss_ref) == 1) {
-			unsigned long target = (unsigned long)&dtlb_miss_perf;
+			unsigned long target = site_addr(&patch__dtlbmiss_perf);
 
-			patch_branch(&dtlb_miss_exit_1, target, 0);
-			patch_branch(&dtlb_miss_exit_2, target, 0);
-			patch_branch(&dtlb_miss_exit_3, target, 0);
+			patch_branch_site(&patch__dtlbmiss_exit_1, target, 0);
+			patch_branch_site(&patch__dtlbmiss_exit_2, target, 0);
+			patch_branch_site(&patch__dtlbmiss_exit_3, target, 0);
 		}
 		val = dtlb_miss_counter;
 		break;
@@ -180,17 +177,17 @@ static void mpc8xx_pmu_del(struct perf_event *event, int flags)
 		break;
 	case PERF_8xx_ID_ITLB_LOAD_MISS:
 		if (atomic_dec_return(&itlb_miss_ref) == 0) {
-			patch_instruction(&itlb_miss_exit_1, insn);
+			patch_instruction_site(&patch__itlbmiss_exit_1, insn);
 #ifndef CONFIG_PIN_TLB_TEXT
-			patch_instruction(&itlb_miss_exit_2, insn);
+			patch_instruction_site(&patch__itlbmiss_exit_2, insn);
 #endif
 		}
 		break;
 	case PERF_8xx_ID_DTLB_LOAD_MISS:
 		if (atomic_dec_return(&dtlb_miss_ref) == 0) {
-			patch_instruction(&dtlb_miss_exit_1, insn);
-			patch_instruction(&dtlb_miss_exit_2, insn);
-			patch_instruction(&dtlb_miss_exit_3, insn);
+			patch_instruction_site(&patch__dtlbmiss_exit_1, insn);
+			patch_instruction_site(&patch__dtlbmiss_exit_2, insn);
+			patch_instruction_site(&patch__dtlbmiss_exit_3, insn);
 		}
 		break;
 	}
-- 
2.13.3
