Return-Path: <linuxppc-dev+bounces-27466-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE191C88E77
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 06:45:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl8WT2wMdz2yqq;
	Wed, 16 Sep 2026 16:44:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789541077;
	cv=none; b=UzpOOXumWaKWD3FypqvKzULeuBwHm+6/UEyeE8oc8vNc/1qnXmOTHNPmbQCTDGxxeW3fRdIggEHJMsU95zPR2OwYQrZKWt2crfkChC8Eqx8YIs3Bro/mWgzuklte98/GEYLq3jSwWjqGwXDpnfPHokHFV2ehdMdAGnlqn8WTnw6TUwFLx9CBuvbEqoFyyERu/r0T5nWa6hVMcEaDGlkJkYzBUR+7rMNq1ewc0d7lqfrjcsBygHZD4lRhPHnvL/laBHPbDsNAuTXZuJoPghisViva2qgGHL8P/XwJi+Wy3JwtY3pTCTNe8WL0581FEOc8cOMyzmpAnEd8Dprl3FELbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789541077; c=relaxed/relaxed;
	bh=iVLitPRwuorHo3p/kYxhVkChlufVFy2kYjbuHRdLiho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZltevfV5SCquLRwl9avJBDurthXRhgQ6whaZtcqSJIDXaf7mCo3NyHdRPj+pGq63oSaOWS5G92kAZCCOXUdVBBcim6416x6d2lDCPSOAPXfCrjVzjgXDVRNJF53qD2CDr8xJSQlYk29otCRf2q5hgm4qlCB/dypkLUDqVJuV2Pji8HIgP4nPsU4IlLhoCKZZLLipUL1OewUq/tAip4Xq/0SUWr2Rxc6WchDxyqTPMOkhaEPS45mROcyLLBQvo0PVz7gBUumqVMzHTGl/AB3A0gcbe6eEmmD8JtZCtVZlh3Qj1b6ghFfs62uilKSWk/qJYNsjpvWQeyJ6SmJsc4v8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Gufvi7yd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Gufvi7yd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl8WS4rMRz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:44:36 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2db1ca069c8so5243085ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 23:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789541075; x=1790145875; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iVLitPRwuorHo3p/kYxhVkChlufVFy2kYjbuHRdLiho=;
        b=Gufvi7ydKz/ncv5U64zkQ6Pj0STCtF0KyZ1ZN2vKgPw6ZpdjrsiepyXEf/jVwKXIty
         Tj2OS2OJUexLsJdFq85KNdmz90+Y8UuuKsCERDejwuwSPyZs4JIeXx98V3Y5kTZ1CqJV
         5upskdMz+1h+fXeQKl9RHSjDDbS6TzsRdBr3aqVOcnX/BnFzaErUT6+vQOcHpHu5Gz2R
         x0TmaScDNkvqLPNKYx5TgyzL7bE4DsmC5EPAwMH+kCifsnKzlXvdb/ZSp73aICu2LnOg
         SkJAOOKlQjQKOMMqPwUTsgdgZi1LYp00j58HTx98OLDLBBzYtTEGLNTm1m5sJHzPtXxv
         Q27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541075; x=1790145875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iVLitPRwuorHo3p/kYxhVkChlufVFy2kYjbuHRdLiho=;
        b=HY7eI4V7XH6uR7oMDToLlh3K9QtgV+Qn2/9dfDMzoYILrDKV6mpf+smGHT33Z9WPqG
         Nqm8Nze4COPeT8ldSl1Awq21Bq/EB8icmAJQtekBrLJDI4Znd0+PIitGz9iIluOSpcDY
         dsdtV5gGsBf2CZbzRuRKwfnOje+EG8ctXj2N7HOJQtwmEpCNjdm1PaZMmEssuMk4RikW
         ZnLUU5b60wn6hgtRLeCZM2AZwI/6Op63hIviIanRCug+3PXpKkSrCgV8yGtjx+EQ6Txd
         HN/tZDqWFC7dg/Fdeun4/ODU1UisvFZhToGHtS2e/vZoii0Ymvk26Go6kp9yveoyS6KW
         1wEA==
X-Forwarded-Encrypted: i=1; AKwUvByIKkFdIV5+KnTALtSxPHgo2cliVi4YounVGf2r3yvpYUi0OvIATfbOMdbRWhArkDaUbo72zn31yIDqhCs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n760pPevXqJecpRR/SZ/gTa37YQmFHGa+kkXD3vwZdKy5ILqaJ
	+6Z4ht0qVU3TUZN3A4QVF1pUn2/4v8psIyKeCt7ZXQy9xkyJzstCZBvY+P9GqSvw9A0=
X-Gm-Gg: AYBFou1RA2x1mEzNeo7/BIfsy3USUo9WmZbr/tUD9F2HTrbtAjb2WfyFjblYpWWpMrt
	kgOjXSrEw5VHaXFP2bnNkvatkp8zYQ/qIjNgjamYEbacP/nfGk9IqTMRJHBUkTiJo39XEfA+vp6
	+lvRj/uEMwE2vlev4vP8zGyI03kILIElzLiE3Q5xJ1pg/UMLLCfltGh+wycnek0DHhYGVcITCYS
	INlZRdS1cITmPYjTeubgJP7CJiMi5J0RaicHKzonyqUTyoI1O21n08YIQIaK+oh9LGMtl/nyhMb
	eXdnfivda0ZfueD/JYSyqb+nI0w5Wzf2s9aPboQ6lb7AI13VSgr+R4Ah3jRFv9WIPsih/Mi1CH7
	Lxic+vOq7KCKKThiABMdFw+2Px58TvshX+hphdbBdzswuqw/SX9TgdF4ut+d51sPB/Sjce6nb9C
	8TuPcgpqWk7HL2C3vhpkuPALNzIWweoxL1E+Kkbb080RO7KfMPJtGof1P0Jo+bpeEjl//KGvzG9
	C7MYFAqrg3haQww46cKA4Y9PX0fEQ==
X-Received: by 2002:a17:902:eac9:b0:2db:5c0a:f18c with SMTP id d9443c01a7336-2dd8e00ecdamr19914175ad.6.1789541074649;
        Tue, 15 Sep 2026 23:44:34 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f0592asm6074755ad.62.2026.09.15.23.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:44:34 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 09/11] mm/sparse-vmemmap: drop the extra tail page from device DAX reservation
Date: Wed, 16 Sep 2026 14:43:39 +0800
Message-ID: <20260916064341.1825793-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916064341.1825793-1-songmuchun@bytedance.com>
References: <20260916064341.1825793-1-songmuchun@bytedance.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device DAX vmemmap population still reserves one extra tail vmemmap
page after the head page.

Drop that extra reservation and let the shared tail page cover all tail
vmemmap pages after the head page, so DAX follows the same reservation
model as HugeTLB.

This reduces the reserved vmemmap pages for optimized DAX mappings to
one and removes the now-unneeded first-tail population from the generic
and powerpc paths to simplify the code as well.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v3:
- Collect Acked-by from Qi Zheng
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 46 ++----------------------
 include/linux/mm.h                       |  3 +-
 mm/mm_init.c                             |  2 +-
 mm/sparse-vmemmap.c                      | 13 ++-----
 4 files changed, 7 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index ee068f24a79f..9ca28e4a610a 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1218,39 +1218,6 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	return 0;
 }
 
-static pte_t * __meminit radix__vmemmap_populate_address(unsigned long addr, int node,
-							 struct vmem_altmap *altmap,
-							 struct page *reuse)
-{
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	pgd = pgd_offset_k(addr);
-	p4d = p4d_offset(pgd, addr);
-	pud = vmemmap_pud_alloc(p4d, node, addr);
-	if (!pud)
-		return NULL;
-	pmd = vmemmap_pmd_alloc(pud, node, addr);
-	if (!pmd)
-		return NULL;
-	if (pmd_leaf(*pmd))
-		/*
-		 * The second page is mapped as a hugepage due to a nearby request.
-		 * Force our mapping to page size without deduplication
-		 */
-		return NULL;
-	pte = vmemmap_pte_alloc(pmd, node, addr);
-	if (!pte)
-		return NULL;
-	radix__vmemmap_pte_populate(pmd, addr, node, NULL, NULL);
-	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
-
-	return pte;
-}
-
 int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 					      unsigned long start,
 					      unsigned long end, int node,
@@ -1297,7 +1264,7 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		if (!pte_none(*pte)) {
 			/*
 			 * This could be because we already have a compound
-			 * page whose VMEMMAP_RESERVE_NR pages were mapped and
+			 * page whose retained vmemmap page was mapped and
 			 * this request fall in those pages.
 			 */
 			next = addr + PAGE_SIZE;
@@ -1318,16 +1285,7 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 					return -ENOMEM;
 				vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
 
-				/*
-				 * Populate the tail pages vmemmap page
-				 * It can fall in different pmd, hence
-				 * vmemmap_populate_address()
-				 */
-				pte = radix__vmemmap_populate_address(addr + PAGE_SIZE, node, NULL, NULL);
-				if (!pte)
-					return -ENOMEM;
-
-				next = addr + 2 * PAGE_SIZE;
+				next = addr + PAGE_SIZE;
 				continue;
 			}
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 070ce27e9cd3..66d384da4433 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5167,7 +5167,6 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
 }
 #endif
 
-#define VMEMMAP_RESERVE_NR	2
 #ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
 					  struct dev_pagemap *pgmap)
@@ -5187,7 +5186,7 @@ static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
 	 * For vmemmap optimization with DAX we need minimum 2 vmemmap
 	 * pages. See layout diagram in Documentation/mm/vmemmap_dedup.rst
 	 */
-	return !altmap && (nr_vmemmap_pages > VMEMMAP_RESERVE_NR);
+	return !altmap && (nr_vmemmap_pages > VMEMMAP_OPTIMIZATION_PAGES);
 }
 /*
  * If we don't have an architecture override, use the generic rule
diff --git a/mm/mm_init.c b/mm/mm_init.c
index efffa8609b85..56bb4567a494 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1056,7 +1056,7 @@ static inline unsigned long compound_nr_pages(unsigned long pfn,
 	if (!section_vmemmap_optimizable(ms))
 		return pgmap_vmemmap_nr(pgmap);
 
-	return VMEMMAP_RESERVE_NR * (PAGE_SIZE / sizeof(struct page));
+	return VMEMMAP_OPTIMIZATION_PAGES * (PAGE_SIZE / sizeof(struct page));
 }
 
 static void __ref memmap_init_compound(struct page *head,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 7b5b9ceec697..39f0cfeefc6a 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -136,7 +136,6 @@ int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages
 {
 	const struct mem_section *ms = __pfn_to_section(pfn);
 	const int order = section_compound_order(ms);
-	const int vmemmap_pages = pgmap ? VMEMMAP_RESERVE_NR : VMEMMAP_OPTIMIZATION_PAGES;
 	const unsigned long pages_per_compound = 1UL << order;
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION));
@@ -147,13 +146,13 @@ int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages
 
 	if (order < PFN_SECTION_SHIFT) {
 		VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_compound));
-		return vmemmap_pages * nr_pages / pages_per_compound;
+		return VMEMMAP_OPTIMIZATION_PAGES * nr_pages / pages_per_compound;
 	}
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
 
 	if (IS_ALIGNED(pfn, pages_per_compound))
-		return vmemmap_pages;
+		return VMEMMAP_OPTIMIZATION_PAGES;
 
 	return 0;
 }
@@ -521,17 +520,11 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		if (!pte)
 			return -ENOMEM;
 
-		/* Populate the tail pages vmemmap page */
-		next = addr + PAGE_SIZE;
-		pte = vmemmap_populate_address(next, node, NULL, -1, flags);
-		if (!pte)
-			return -ENOMEM;
-
 		/*
 		 * Reuse the shared page for the rest of tail pages
 		 * See layout diagram in Documentation/mm/vmemmap_dedup.rst
 		 */
-		next += PAGE_SIZE;
+		next = addr + PAGE_SIZE;
 		rc = vmemmap_populate_range(next, last, node, NULL,
 					    page_to_pfn(page), flags);
 		if (rc)
-- 
2.54.0


