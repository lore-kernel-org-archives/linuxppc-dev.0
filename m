Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81E2ECDE43
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:17:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528BC21476
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528BC21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42by0j1kcSzF3TK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 18:17:25 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bxW54VdDzF3Tc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 17:55:13 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42bxW13S8Mz9ttFV;
 Fri, 19 Oct 2018 08:55:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ACounXFTczUi; Fri, 19 Oct 2018 08:55:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42bxW12wYxz9ttFM;
 Fri, 19 Oct 2018 08:55:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9FDF78B8DF;
 Fri, 19 Oct 2018 08:55:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 3GOxKT40NfJZ; Fri, 19 Oct 2018 08:55:10 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 79D588B75B;
 Fri, 19 Oct 2018 08:55:10 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 587E16F496; Fri, 19 Oct 2018 06:55:10 +0000 (UTC)
Message-Id: <d523a0ef0b49f6bfa252bd5a4bc7cf2b2a2e2572.1539931702.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539931702.git.christophe.leroy@c-s.fr>
References: <cover.1539931702.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 09/20] powerpc/8xx: Move SW perf counters in first 32kb of
 memory
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 19 Oct 2018 06:55:10 +0000 (UTC)
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

