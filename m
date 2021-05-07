Return-Path: <SRS0=iVLG=KC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C97C433ED
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 May 2021 05:02:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90779610FC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 May 2021 05:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90779610FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FbyxN6qhLz2yhK
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 May 2021 15:02:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fbywz5T2Xz2xvJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 May 2021 15:02:07 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4Fbywq6kJXz9sZN;
 Fri,  7 May 2021 07:02:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tY7tSNZsE6nd; Fri,  7 May 2021 07:02:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4Fbywq5q8Cz9sZL;
 Fri,  7 May 2021 07:02:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0D5098B80D;
 Fri,  7 May 2021 07:02:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id mqdM4eBXc__4; Fri,  7 May 2021 07:02:02 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 870218B764;
 Fri,  7 May 2021 07:02:02 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 442C2648FD; Fri,  7 May 2021 05:02:02 +0000 (UTC)
Message-Id: <603725297466959419628ef7964aaf3417fb647d.1620363691.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/603: Avoid a pile of NOPs when not using SW LRU in
 TLB exceptions
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri,  7 May 2021 05:02:02 +0000 (UTC)
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

The SW LRU is in an MMU feature section. When not used, that's a
dozen of NOPs to fetch for nothing.

Define an ALT section that does the few remaining operations.

That also avoids a double read on SRR1 in the SW LRU case.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_book3s_32.S | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 065178f19a3d..f2a5ceff52b2 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -518,8 +518,6 @@ BEGIN_FTR_SECTION
 	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
 END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	mtspr	SPRN_RPA,r1
-	mfspr	r2,SPRN_SRR1		/* Need to restore CR0 */
-	mtcrf	0x80,r2
 BEGIN_MMU_FTR_SECTION
 	li	r0,1
 	mfspr	r1,SPRN_SPRG_603_LRU
@@ -531,9 +529,15 @@ BEGIN_MMU_FTR_SECTION
 	mfspr	r2,SPRN_SRR1
 	rlwimi	r2,r0,31-14,14,14
 	mtspr   SPRN_SRR1,r2
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
+	mtcrf	0x80,r2
+	tlbld	r3
+	rfi
+MMU_FTR_SECTION_ELSE
+	mfspr	r2,SPRN_SRR1		/* Need to restore CR0 */
+	mtcrf	0x80,r2
 	tlbld	r3
 	rfi
+ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
 DataAddressInvalid:
 	mfspr	r3,SPRN_SRR1
 	rlwinm	r1,r3,9,6,6	/* Get load/store bit */
@@ -607,9 +611,15 @@ BEGIN_MMU_FTR_SECTION
 	mfspr	r2,SPRN_SRR1
 	rlwimi	r2,r0,31-14,14,14
 	mtspr   SPRN_SRR1,r2
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
+	mtcrf	0x80,r2
+	tlbld	r3
+	rfi
+MMU_FTR_SECTION_ELSE
+	mfspr	r2,SPRN_SRR1		/* Need to restore CR0 */
+	mtcrf	0x80,r2
 	tlbld	r3
 	rfi
+ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
 
 #ifndef CONFIG_ALTIVEC
 #define altivec_assist_exception	unknown_exception
-- 
2.25.0

