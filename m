Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4F8C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 05:50:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61D620815
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 05:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61D620815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L17k6rRjzDqx5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 16:50:26 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43L15T2vW3zDqsx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 16:48:29 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43L15P2NC9z9v19v;
 Thu, 20 Dec 2018 06:48:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ApFvyzevhNja; Thu, 20 Dec 2018 06:48:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43L15P1m8Nz9v137;
 Thu, 20 Dec 2018 06:48:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 092648B790;
 Thu, 20 Dec 2018 06:48:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ko83aFK7tFNs; Thu, 20 Dec 2018 06:48:25 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CD25C8B755;
 Thu, 20 Dec 2018 06:48:25 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 8FAA871739; Thu, 20 Dec 2018 05:48:25 +0000 (UTC)
Message-Id: <27edd227d3b9dcda4e2ce7d00d9fddeb7a5520a1.1545241146.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: Map a second 8M text page at startup when needed.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 20 Dec 2018 05:48:25 +0000 (UTC)
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

Some debug setup like CONFIG_KASAN generate huge
kernels with text size over the 8M limit.

This patch maps a second 8M page when _einittext is over 8M.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 27 +++++++++++++++++++++++++--
 arch/powerpc/mm/8xx_mmu.c      |  4 ++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index b171b7c0a0e7..f6bc4392ea9f 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -334,8 +334,8 @@ InstructionTLBMiss:
 	rlwinm	r10, r10, 16, 0xfff8
 	cmpli	cr0, r10, PAGE_OFFSET@h
 #ifndef CONFIG_PIN_TLB_TEXT
-	/* It is assumed that kernel code fits into the first 8M page */
-0:	cmpli	cr7, r10, (PAGE_OFFSET + 0x0800000)@h
+	/* It is assumed that kernel code fits into the two first 8M pages */
+0:	cmpli	cr7, r10, (PAGE_OFFSET + 0x1000000)@h
 	patch_site	0b, patch__itlbmiss_linmem_top
 #endif
 #endif
@@ -904,6 +904,29 @@ initial_mmu:
 	li	r8, MI_BOOTINIT		/* Create RPN for address 0 */
 	mtspr	SPRN_MI_RPN, r8		/* Store TLB entry */
 
+	/* Map a second 8M page if needed */
+	lis	r9, _einittext@h
+	oris	r9, r9, _einittext@l
+	cmpli	cr0, r9, (PAGE_OFFSET + 0x8000000)@h
+	blt	1f
+
+#ifdef CONFIG_PIN_TLB_TEXT
+	lis	r8, MI_RSV4I@h
+	ori	r8, r8, 0x1d00
+
+	mtspr	SPRN_MI_CTR, r8	/* Set instruction MMU control */
+#endif
+
+	lis	r8, (KERNELBASE + 0x800000)@h	/* Create vaddr for TLB */
+	ori	r8, r8, MI_EVALID	/* Mark it valid */
+	mtspr	SPRN_MI_EPN, r8
+	li	r8, MI_PS8MEG /* Set 8M byte page */
+	ori	r8, r8, MI_SVALID	/* Make it valid */
+	mtspr	SPRN_MI_TWC, r8
+	li	r8, MI_BOOTINIT		/* Create RPN for address 0 */
+	addis	r8, r8, 0x80
+	mtspr	SPRN_MI_RPN, r8		/* Store TLB entry */
+1:
 	lis	r8, MI_APG_INIT@h	/* Set protection modes */
 	ori	r8, r8, MI_APG_INIT@l
 	mtspr	SPRN_MI_AP, r8
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index e2b6687ebb50..1bdbfbf9fe16 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -122,6 +122,10 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 #endif
 	} else {
 		mapped = top & ~(LARGE_PAGE_SIZE_8M - 1);
+#ifndef CONFIG_PIN_TLB_TEXT
+		mmu_patch_cmp_limit(&patch__itlbmiss_linmem_top,
+				    _ALIGN(__pa(_einittext), 8 << 20));
+#endif
 	}
 
 	mmu_patch_cmp_limit(&patch__dtlbmiss_linmem_top, mapped);
-- 
2.13.3

