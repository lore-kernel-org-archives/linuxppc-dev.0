Return-Path: <linuxppc-dev+bounces-27098-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD75C79FA1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 05:04:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2Wy0PZ7z2yql;
	Fri, 11 Sep 2026 15:04:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789103054;
	cv=none; b=cvGaQeV6bz9+kKRomuNR/FkUCByazEWqC5VzPT+QyxEEcng4RJXAZmmc1wt5EKDOP+ehRY6U/MiWb0cQ2V8RcTCcPO1iXwV0g4B/T/EmhJ5QM+MjyINeFx7QDKIUWDlgnBYvaV0M7dOfnBchno8Us6nJg+9lc74Gx6YDCGVEgnkBIhVf+IEwuk7MCrAaf4+zsEsirVgxU5Cu//F70YMDD1s/rrsiwCKrtnpVAjqhQesMF284SbvkL5vh9sDyy1oPpLmspY0VZQpucGZGPA+xKZopimSTHO4O+Vlkliu806f1TWwr8XWWqP2gkyxQoG5WuK5rBvhfh3zqXAO6th5Tsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789103054; c=relaxed/relaxed;
	bh=OZ9EEhriv4uQFVrwFElKF7ZgZH1tSjYdJIJZrcuS8I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hgn3Pz8TGa/tjgl9ahhybvxBoeXScRgL8oydCIqidP6ni9DkslKMGTDZvNSVFUJX/RfcnWic9qKMilYA4fiShJq/pw2B3r/yXPbjHBDnBb9fBQZPHpww4ovtwZXK1+f/PabfhvKBLxThhgDdnCNAZdSOG/gtvQ3LZy6sUWLYiqjUGrVX61nr0hPWX2k5kSNbORcoXf7AQJehnPNGbGMWhShmoPHIIBD1KCmDs//H4rxrBIFxL3ppsGMcFvzvwtcrzvHys3PQIflrCVUe2x4fzNJPKy/GOJaMwl4k/qEYki3w/xfQ4ia1azbqAdBLMC7rD8hRnZsTaClsL5Jt9kqpdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=IzE4WDSG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=IzE4WDSG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2Wx1FNkz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:04:13 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so188789a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 22:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789103051; x=1789707851; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OZ9EEhriv4uQFVrwFElKF7ZgZH1tSjYdJIJZrcuS8I4=;
        b=IzE4WDSGaVzsTVUas4F/AUgTCdpMebFI/DEMgMPR+9hRK3KAql7KKmBHspW0xniwi5
         sapAp+TfJN53JUMbN1FagZXNm7nsjWVl0qStIq9k1AqjMKSmqiSoHsxy8ws/D8hkZTqn
         3G8xoWKjlL8NTt403+S2+vslx0LWtsqMVL0LyCU3xfU0xKv+HSvKnCW/TfsprG+d6jpG
         X49Om2zPxPOLNluBdh5kZ1EuCuGFVL+2jgR1mJ8936RwqEejI6GE1DcKr62LF/UtZes0
         fJ++tQULETt0nFBOufEbfC3rBEbDFjLh5/LhJixSw2P5cMv6Ouce9jo+mk5EB4huYsr5
         0dCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103051; x=1789707851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OZ9EEhriv4uQFVrwFElKF7ZgZH1tSjYdJIJZrcuS8I4=;
        b=nTkTTySrWdqCmM882S8f/ccCPKSadI4NuyTd9OwuZZxGInCVelFOEhZMYsZ2F74SeX
         dMddlHDYuUrlDL0ru9kEsIeohwLDAwCN3tYmA7+8SiWKW+w29RzUnIiRWGPYgvdidhRQ
         KCK2XdzxaqivXFZO5DpgTukiP/Bwq5dw63v0IkmQE/+u0ovgHSO4APavM/XpBZvdOmCC
         RB5YP7ZBH0uD+WgO5824n5ZkVAX0mL09rX2Ni8X81LEElroxfkMUqW2xBqndEyUlcDfs
         WwnC5ZgE5/yQ8qDbIDpdJZ+nDf21zHkQiUxOaRxn5OHY929lEC3vQQN8L1jMyjYQqA7V
         jmgw==
X-Forwarded-Encrypted: i=1; AKwUvBxzGS/n7SQFh9DlFTI9Q0lbTpa2rjFMxs3TgqaGtyyVCgbsHu2R21LXXjfUZ9buLbaiY40vMiF2Jb7M9O4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lAjTOgG+BfWF+0BAh57smAI/XuHWhmbUGekeLS8uVeDv7m8ott
	PB17r49CD+c4rTDgUxEcK7jVtA0QVH70Ce03Q7sRpE2wsMDzdx8RrZUK0WWsPykhK6c=
X-Gm-Gg: AYBFou1vuMRciZwAt35HrLcbDR4ngwGmjdSgO3eaejcn7UiTyrnkFve6UKlrLTw6BcO
	tYG1yFipTKHgWm7LRCH2PcBe78z2Ma1UupEJgLOBZR7DVWyWKudSJV+QYNfyv1oywR1YIoCbma8
	YqC1j383DHCH9veLIDsaUn/fUEbhiGr7boZUsXTrNz3zss4BEnYlUNfd/KN0rsDp+99Rnv2wOGX
	enM17GPNGRTqQmDYWTFaKeh0dHVCDdNjJKEgV88C2HyOn4lkEWaJEjT/VzVw3KwQV2g5tL27yt2
	Wd0ScJoJhvUbtDlE0vPQa6VAQKYMiS06Oaqmw1SAbQ80uaAYhP3x6vVBqWKRk4PlZClTrq6pco4
	cWNbLwZPjvS+nMrqan5NsxlNqiH3IA5ssitmJhqQ81+NCf99uW6hT9kiGpEiRrWC0cpgPwdN+hi
	dLdhnKsnfTXmYhiRCzOQN8nlBk38CEpubAHngs3BuQmk+8ScczU+PZVO0/2jexuIlWWob2Gg5Xc
	2SKUwXZyRrrUf/xkz3foXVJISNYdMqDltjq
X-Received: by 2002:a17:90b:4c4e:b0:38e:7297:a92e with SMTP id 98e67ed59e1d1-39d9805da27mr2729392a91.9.1789103051065;
        Thu, 10 Sep 2026 22:04:11 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b16sm2651561a91.14.2026.09.10.22.04.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 22:04:10 -0700 (PDT)
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
Subject: [PATCH v3 09/11] mm/sparse-vmemmap: drop the extra tail page from device DAX reservation
Date: Fri, 11 Sep 2026 13:02:26 +0800
Message-ID: <20260911050228.58884-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260911050228.58884-1-songmuchun@bytedance.com>
References: <20260911050228.58884-1-songmuchun@bytedance.com>
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
index a2ebe87e7654..969594074fd2 100644
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


