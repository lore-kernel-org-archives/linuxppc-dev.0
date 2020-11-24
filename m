Return-Path: <SRS0=+0eX=E6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96199C2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 15:36:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1E8206D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 15:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1E8206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CgSlz6VZQzDqH1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 02:35:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CgSWL2nlPzDqZx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2020 02:25:02 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4CgSWF3f8Nz9v0dQ;
 Tue, 24 Nov 2020 16:24:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id dQD6BlWrLx0e; Tue, 24 Nov 2020 16:24:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4CgSWF2LLbz9v0dP;
 Tue, 24 Nov 2020 16:24:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CDF5A8B7B3;
 Tue, 24 Nov 2020 16:24:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id TuPnje_b7Xyn; Tue, 24 Nov 2020 16:24:58 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8580A8B7AF;
 Tue, 24 Nov 2020 16:24:58 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 64890668E2; Tue, 24 Nov 2020 15:24:58 +0000 (UTC)
Message-Id: <e3cc8f023ef40e1e8ae144e4dd1330a5ff022528.1606231483.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
References: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 5/6] powerpc/8xx: Use SPRN_SPRG_SCRATCH2 in DTLB miss
 exception
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 24 Nov 2020 15:24:58 +0000 (UTC)
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

Use SPRN_SPRG_SCRATCH2 in DTLB miss exception instead of DAR
in order to be similar to ITLB miss exception.

This also simplifies mpc8xx_pmu_del()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_8xx.S |  9 ++++-----
 arch/powerpc/perf/8xx-pmu.c    | 19 +++++++------------
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 45239b06b6ce..35707e86c5f3 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -247,7 +247,7 @@ InstructionTLBMiss:
 
 	. = 0x1200
 DataStoreTLBMiss:
-	mtspr	SPRN_DAR, r10
+	mtspr	SPRN_SPRG_SCRATCH2, r10
 	mtspr	SPRN_M_TW, r11
 	mfcr	r11
 
@@ -286,11 +286,11 @@ DataStoreTLBMiss:
 	li	r11, RPN_PATTERN
 	rlwimi	r10, r11, 0, 24, 27	/* Set 24-27 */
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
+	mtspr	SPRN_DAR, r11		/* Tag DAR */
 
 	/* Restore registers */
 
-0:	mfspr	r10, SPRN_DAR
-	mtspr	SPRN_DAR, r11	/* Tag DAR */
+0:	mfspr	r10, SPRN_SPRG_SCRATCH2
 	mfspr	r11, SPRN_M_TW
 	rfi
 	patch_site	0b, patch__dtlbmiss_exit_1
@@ -300,8 +300,7 @@ DataStoreTLBMiss:
 0:	lwz	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
 	addi	r10, r10, 1
 	stw	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
-	mfspr	r10, SPRN_DAR
-	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r10, SPRN_SPRG_SCRATCH2
 	mfspr	r11, SPRN_M_TW
 	rfi
 #endif
diff --git a/arch/powerpc/perf/8xx-pmu.c b/arch/powerpc/perf/8xx-pmu.c
index 02db58c7427a..93004ee586a1 100644
--- a/arch/powerpc/perf/8xx-pmu.c
+++ b/arch/powerpc/perf/8xx-pmu.c
@@ -153,6 +153,11 @@ static void mpc8xx_pmu_read(struct perf_event *event)
 
 static void mpc8xx_pmu_del(struct perf_event *event, int flags)
 {
+	struct ppc_inst insn;
+
+	/* mfspr r10, SPRN_SPRG_SCRATCH2 */
+	insn = ppc_inst(PPC_INST_MFSPR | __PPC_RS(R10) | __PPC_SPR(SPRN_SPRG_SCRATCH2));
+
 	mpc8xx_pmu_read(event);
 
 	/* If it was the last user, stop counting to avoid useles overhead */
@@ -164,22 +169,12 @@ static void mpc8xx_pmu_del(struct perf_event *event, int flags)
 			mtspr(SPRN_ICTRL, 7);
 		break;
 	case PERF_8xx_ID_ITLB_LOAD_MISS:
-		if (atomic_dec_return(&itlb_miss_ref) == 0) {
-			/* mfspr r10, SPRN_SPRG_SCRATCH2 */
-			struct ppc_inst insn = ppc_inst(PPC_INST_MFSPR | __PPC_RS(R10) |
-					    __PPC_SPR(SPRN_SPRG_SCRATCH2));
-
+		if (atomic_dec_return(&itlb_miss_ref) == 0)
 			patch_instruction_site(&patch__itlbmiss_exit_1, insn);
-		}
 		break;
 	case PERF_8xx_ID_DTLB_LOAD_MISS:
-		if (atomic_dec_return(&dtlb_miss_ref) == 0) {
-			/* mfspr r10, SPRN_DAR */
-			struct ppc_inst insn = ppc_inst(PPC_INST_MFSPR | __PPC_RS(R10) |
-					    __PPC_SPR(SPRN_DAR));
-
+		if (atomic_dec_return(&dtlb_miss_ref) == 0)
 			patch_instruction_site(&patch__dtlbmiss_exit_1, insn);
-		}
 		break;
 	}
 }
-- 
2.25.0

