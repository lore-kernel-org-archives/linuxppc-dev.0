Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E8FECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:14:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B1F120869
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1F120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bxxb1PNLzF3TR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 18:14:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bxW35TTBzF3TN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 17:55:11 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42bxVz3cgnz9ttFY;
 Fri, 19 Oct 2018 08:55:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id NXgTtgoG_mjD; Fri, 19 Oct 2018 08:55:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42bxVz35Q3z9ttFM;
 Fri, 19 Oct 2018 08:55:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F7228B8DF;
 Fri, 19 Oct 2018 08:55:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 8rfDOFYUPlyw; Fri, 19 Oct 2018 08:55:08 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 712608B75B;
 Fri, 19 Oct 2018 08:55:08 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 539706F496; Fri, 19 Oct 2018 06:55:08 +0000 (UTC)
Message-Id: <231cb98301edd62a0e9f444044ef6ab535733da6.1539931702.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539931702.git.christophe.leroy@c-s.fr>
References: <cover.1539931702.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 08/20] powerpc/8xx: Use patch_site for perf counters setup
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 19 Oct 2018 06:55:08 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The 8xx TLB miss routines are patched when (de)activating
perf counters.

This patch uses the new patch_site functionality in order
to get a better code readability and avoid a label mess when
dumping the code with 'objdump -d'

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h |  4 ++++
 arch/powerpc/kernel/head_8xx.S               | 33 ++++++++++++++++------------
 arch/powerpc/perf/8xx-pmu.c                  | 27 ++++++++++-------------
 3 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index 3a15d6647d47..fa05aa566ece 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
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

