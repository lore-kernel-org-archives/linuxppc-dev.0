Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A364C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 08:33:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8BB620834
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 08:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BB620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4359lg5z2yzDqYX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 19:33:35 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4359Dz3LHtzDr1b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 19:10:27 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4359Dv4RTMz9vGpM;
 Thu, 29 Nov 2018 09:10:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id nlqr_9EF-5s8; Thu, 29 Nov 2018 09:10:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4359Dv3zbpz9vGnx;
 Thu, 29 Nov 2018 09:10:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 68F628B891;
 Thu, 29 Nov 2018 09:10:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id BAiVABMCs8g1; Thu, 29 Nov 2018 09:10:24 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3BCAB8B762;
 Thu, 29 Nov 2018 09:10:24 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id F002A69AEA; Thu, 29 Nov 2018 08:10:23 +0000 (UTC)
Message-Id: <253ef37295b5c7eecdac4224d2defff54c889a4e.1543478200.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543478199.git.christophe.leroy@c-s.fr>
References: <cover.1543478199.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 10/20] powerpc/mm: replace hugetlb_cache by
 PGT_CACHE(PTE_T_ORDER)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 29 Nov 2018 08:10:23 +0000 (UTC)
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

Instead of opencoding cache handling for the special case
of hugepage tables having a single pte_t element, this
patch makes use of the common pgtable_cache helpers

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hugetlb.h |  2 --
 arch/powerpc/mm/hugetlbpage.c      | 26 +++++++-------------------
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 98004262bc87..dfb8bf236586 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -5,8 +5,6 @@
 #ifdef CONFIG_HUGETLB_PAGE
 #include <asm/page.h>
 
-extern struct kmem_cache *hugepte_cache;
-
 #ifdef CONFIG_PPC_BOOK3S_64
 
 #include <asm/book3s/64/hugetlb.h>
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 8cf035e68378..c4f1263228b8 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -42,6 +42,8 @@ EXPORT_SYMBOL(HPAGE_SHIFT);
 
 #define hugepd_none(hpd)	(hpd_val(hpd) == 0)
 
+#define PTE_T_ORDER	(__builtin_ffs(sizeof(pte_t)) - __builtin_ffs(sizeof(void *)))
+
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr, unsigned long sz)
 {
 	/*
@@ -61,7 +63,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	int num_hugepd;
 
 	if (pshift >= pdshift) {
-		cachep = hugepte_cache;
+		cachep = PGT_CACHE(PTE_T_ORDER);
 		num_hugepd = 1 << (pshift - pdshift);
 	} else {
 		cachep = PGT_CACHE(pdshift - pshift);
@@ -264,7 +266,7 @@ static void hugepd_free_rcu_callback(struct rcu_head *head)
 	unsigned int i;
 
 	for (i = 0; i < batch->index; i++)
-		kmem_cache_free(hugepte_cache, batch->ptes[i]);
+		kmem_cache_free(PGT_CACHE(PTE_T_ORDER), batch->ptes[i]);
 
 	free_page((unsigned long)batch);
 }
@@ -277,7 +279,7 @@ static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
 
 	if (atomic_read(&tlb->mm->mm_users) < 2 ||
 	    mm_is_thread_local(tlb->mm)) {
-		kmem_cache_free(hugepte_cache, hugepte);
+		kmem_cache_free(PGT_CACHE(PTE_T_ORDER), hugepte);
 		put_cpu_var(hugepd_freelist_cur);
 		return;
 	}
@@ -652,7 +654,6 @@ static int __init hugepage_setup_sz(char *str)
 }
 __setup("hugepagesz=", hugepage_setup_sz);
 
-struct kmem_cache *hugepte_cache;
 static int __init hugetlbpage_init(void)
 {
 	int psize;
@@ -702,21 +703,8 @@ static int __init hugetlbpage_init(void)
 		if (pdshift > shift)
 			pgtable_cache_add(pdshift - shift, NULL);
 #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
-		else if (!hugepte_cache) {
-			/*
-			 * Create a kmem cache for hugeptes.  The bottom bits in
-			 * the pte have size information encoded in them, so
-			 * align them to allow this
-			 */
-			hugepte_cache = kmem_cache_create("hugepte-cache",
-							  sizeof(pte_t),
-							  HUGEPD_SHIFT_MASK + 1,
-							  0, NULL);
-			if (hugepte_cache == NULL)
-				panic("%s: Unable to create kmem cache "
-				      "for hugeptes\n", __func__);
-
-		}
+		else
+			pgtable_cache_add(PTE_T_ORDER, NULL);
 #endif
 	}
 
-- 
2.13.3

