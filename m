Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD758C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 08:47:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573FA2081B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 08:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573FA2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435B475f0QzDqs3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 19:47:51 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4359FG0JvDzDr27
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 19:10:42 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4359FB0058z9vGpG;
 Thu, 29 Nov 2018 09:10:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id cLhJIE9RtZXO; Thu, 29 Nov 2018 09:10:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4359F96cgFz9vGnW;
 Thu, 29 Nov 2018 09:10:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C343C8B890;
 Thu, 29 Nov 2018 09:10:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id w_j-zok4fp9k; Thu, 29 Nov 2018 09:10:38 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 968BA8B762;
 Thu, 29 Nov 2018 09:10:38 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 4159B69AEA; Thu, 29 Nov 2018 08:10:38 +0000 (UTC)
Message-Id: <00b47f8f30643550d38d21a7180cf3c8d918a012.1543478200.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543478199.git.christophe.leroy@c-s.fr>
References: <cover.1543478199.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 17/20] powerpc/8xx: Enable 512k hugepage support with HW
 assistance
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 29 Nov 2018 08:10:38 +0000 (UTC)
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

For using 512k pages with hardware assistance, the PTEs have to be spread
every 128 bytes in the L2 table.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hugetlb.h |  4 +++-
 arch/powerpc/mm/hugetlbpage.c      | 10 +++++++++-
 arch/powerpc/mm/tlb_nohash.c       |  3 +++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index dfb8bf236586..62a0ca02ca7d 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -74,7 +74,9 @@ static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
 	unsigned long idx = 0;
 
 	pte_t *dir = hugepd_page(hpd);
-#ifndef CONFIG_PPC_FSL_BOOK3E
+#ifdef CONFIG_PPC_8xx
+	idx = (addr & ((1UL << pdshift) - 1)) >> PAGE_SHIFT;
+#elif !defined(CONFIG_PPC_FSL_BOOK3E)
 	idx = (addr & ((1UL << pdshift) - 1)) >> hugepd_shift(hpd);
 #endif
 
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index bc97874d7c74..5f22f1d399b3 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -65,6 +65,9 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	if (pshift >= pdshift) {
 		cachep = PGT_CACHE(PTE_T_ORDER);
 		num_hugepd = 1 << (pshift - pdshift);
+	} else if (IS_ENABLED(CONFIG_PPC_8xx)) {
+		cachep = PGT_CACHE(PTE_SHIFT);
+		num_hugepd = 1;
 	} else {
 		cachep = PGT_CACHE(pdshift - pshift);
 		num_hugepd = 1;
@@ -331,6 +334,9 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
 
 	if (shift >= pdshift)
 		hugepd_free(tlb, hugepte);
+	else if (IS_ENABLED(CONFIG_PPC_8xx))
+		pgtable_free_tlb(tlb, hugepte,
+				 get_hugepd_cache_index(PTE_SHIFT));
 	else
 		pgtable_free_tlb(tlb, hugepte,
 				 get_hugepd_cache_index(pdshift - shift));
@@ -700,7 +706,9 @@ static int __init hugetlbpage_init(void)
 		 * if we have pdshift and shift value same, we don't
 		 * use pgt cache for hugepd.
 		 */
-		if (pdshift > shift)
+		if (pdshift > shift && IS_ENABLED(CONFIG_PPC_8xx))
+			pgtable_cache_add(PTE_SHIFT);
+		else if (pdshift > shift)
 			pgtable_cache_add(pdshift - shift);
 #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 		else
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 8ad7aab150b7..ae5d568e267f 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -97,6 +97,9 @@ struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 		.shift	= 14,
 	},
 #endif
+	[MMU_PAGE_512K] = {
+		.shift	= 19,
+	},
 	[MMU_PAGE_8M] = {
 		.shift	= 23,
 	},
-- 
2.13.3

