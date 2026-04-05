Return-Path: <linuxppc-dev+bounces-19367-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAE0F3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:57:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXYM1NtXz2yvh;
	Sun, 05 Apr 2026 22:57:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393847;
	cv=none; b=MYG40oUeMawD3aHeoFzSd4Fn6A/RZ+AJdtueWr22q0exIz/LMM3oSuqeOz3b+EGwr+d5wjwPgmFCfpaBMfe5N6TXHtlwinbSCAle6FB7wh8XsieyqHuiZ/cWNvsXqYOrcCCyuvHp0bhyFpWYnFo/lEA/FfMjMaCWZ4ty7y2/Lz10HI6F/b9Fm5W7FnVo0s6t9EmyWhjO7xydVCACDKJkQ2VS/mzKz/QP6HAQqQlawb1LIIsSQ/739FrMlr+7fve7/ZMCfYtmnMJL7GEeWHU4wb124H1sgwy/Xrqk4GjA7cF6gTwiTsoCQdiPovHq2SGllpLNjZjxgQjNF+xA9QOfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393847; c=relaxed/relaxed;
	bh=Un8QJIOHiLQFUGTVr1x/7L06qAEVN23h4FxFsc9SMV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IM35fB/+K/V977dBiS2WYmktwYzF5GaQGdz+MSmxx7Rhb01+txr5opJndU7hRYT0iDL8krq1CT9NchbPu8tyq/V29/5yqFamqee2xu2GIyM4LlLv6689hMEieH6WerGJnjEam6dqoF9jyp2tV4Aq39VqqLCe/8kRqzrhYKzxKHRJvML323qcW/q0cJyKm07mq47C6joqBstfVOP26JdCoqGYUPHRnNA+l7tUuTAfpX5PmOA3wQZ/rA0j9raNdUuw3gGzfg/9G11Ntqy/pSq62/1Bzd8HqM8LinBf0+R0ZAHMnRFNcsW64IWB23n/RPkW40RSgXxtmyabL04JD+MeLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TqYvIa//; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TqYvIa//;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXYL1hp8z2yvc
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:57:26 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-35d9923eec5so1861088a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393844; x=1775998644; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Un8QJIOHiLQFUGTVr1x/7L06qAEVN23h4FxFsc9SMV0=;
        b=TqYvIa//9irIUrXXuOjQOnI2GQN8BA5lEYS2zYq0cQnr4I1dq4EqAlxnHQzyu7L9m/
         lr87MfkVATRgZ6zZ7+3OPMlBRkycoBzZ2LgQCfClKYF33g2yPK3mufYVufXj3RrNG/yz
         eflFASdrlQ2WVqKJ6wM3TCfQuLmbXiGw4pybM2FG6lXP1gx9kmDu9uoKU+N8l0sI1UP/
         +NHPp7ugpenvnJccpNYqgNOjGBQe0ym+MaMHdrQk2yC25FqD+Jc8pbm/s+Jq8u2w0WHk
         ysYAl4DgF3XvE8C8I81hRtraGV0zwiN66lvk9ljEQS+zyDiAihsxu4Is1HUAY3olbtT1
         3gKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393844; x=1775998644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Un8QJIOHiLQFUGTVr1x/7L06qAEVN23h4FxFsc9SMV0=;
        b=rFMajnuAcqFp02GK/wd8s/yvFOQsTBakX3Cc8j/etQZdMEZPXUTlbhg6FiflvAKzIT
         5gZuKbAOnFo9f+xrgNtLKSgvPQQekNF58/ch6FFPeayW5AWwGWhxZjtpbEkIuO3yJIys
         wT7Qc7OaYNL7EeivGa2UMdW+v+9zMo8UeUNAAA/UEhfIYgOsNFv9+F8Kuz3qg6HK4zMP
         gqaGJelm1raXT5CGqTHiyWgu/ZclHzRcJMj/WrVMqVUPRuA9VQmkOiAf9OFjWNZa4WjG
         VkPYGCg1d/a0YrEz6p9F8mXzWgNFyNQzzIKWanmXL+FLb2SIch1c8R6lV5OE6z2R8C0a
         Kcxg==
X-Forwarded-Encrypted: i=1; AJvYcCVi0Kmc6IZ0fDBv9dX/Fx8ijnTe+omWc8eBwQzPFPpd5HSVoOqo70I7D8G+ekBEZyJ9kW/M5M2SLpx/LKk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwsPyHw+p9/0azc/24vlB55/S2BTd3nQIzd/Oyv6+pHtlnrLdiG
	RISjxfS68EOiJxCSZrKYDe0vQvpavo6IcCbnxnSxmHjJDLiOQawKXcfNNLMBNJJ7OMM=
X-Gm-Gg: AeBDietVxGqHR28cbwEXNQBnd/7Pr1oqh6WKDZobl/yVhlNSbjiCWcWqb8AO0+9QDuE
	UUKI8oZtdsHzAglo/eJfCIennpKgaQnMfiQzYanHSyB9I5iul87JOxAhg0tsiathRfn1bJIWL3j
	RlgOXD9IG9u6Mq+J771MOcmEVq+ddQRMNck8a4Fy/bsbOAFyEJqzQQqX6ZoVcHt5XN6hUXmSLj/
	CucNyTooTFRJ8MxwfB2si7DKnEQ0hK7iClOrcY7XRRXGemVdFBceEu1Lw4dRIccPDZxXdrXmPru
	4Dyplc4U790suCvD3Kblq03/QbmC+6W68lrJ3Vz3EJwHzm/OsDrPfSzVG3Zrs1dIQgUIcGPShvb
	/BwA32NdwGB68ICFyVZalYQEq3PbOG42jCTNrFES4DVY8n66AYDbt9qrGgMvbWgQ9a51n8Sgv5d
	uTyJ+ApLtYqHfZLQ+h5KFWJmsvXznDiKWlGZMusonzeYA=
X-Received: by 2002:a17:90b:4fc4:b0:35d:a374:b385 with SMTP id 98e67ed59e1d1-35de6a1951bmr7999215a91.29.1775393844264;
        Sun, 05 Apr 2026 05:57:24 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:57:23 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 37/49] mm/sparse-vmemmap: unify DAX and HugeTLB vmemmap optimization
Date: Sun,  5 Apr 2026 20:52:28 +0800
Message-Id: <20260405125240.2558577-38-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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

The ultimate goal of the recent refactoring series is to unify the vmemmap
optimization logic for both DAX and HugeTLB under a common framework
(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION).

A key breakthrough in this unification is that DAX now only requires 1
vmemmap page to be preserved (the head page), aligning its requirements
exactly with HugeTLB. Previously, DAX optimization relied on a dedicated
upper-level function, vmemmap_populate_compound_pages, which handled the
manual allocation of the head page AND the first tail page before reusing
the shared tail page for the rest.

Because DAX and HugeTLB are now perfectly aligned in their optimization
requirements (1 reserved page + reused shared tail pages), this patch
eliminates the dedicated compound page mapping loop entirely. Instead, it
pushes the optimization decision down to the lowest level in
vmemmap_pte_populate. Now, all mapping requests flow through the standard
vmemmap_populate_basepages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c |  13 +-
 include/linux/mm.h                       |   2 +-
 mm/mm_init.c                             |   2 +-
 mm/sparse-vmemmap.c                      | 185 +++++------------------
 4 files changed, 40 insertions(+), 162 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 5ce3deb464d5..714d5cdc10ec 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1326,17 +1326,8 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
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
-				addr_pfn += 2;
-				next = addr + 2 * PAGE_SIZE;
+				addr_pfn += 1;
+				next = addr + PAGE_SIZE;
 				continue;
 			}
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 15841829b7eb..bceef0dc578b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4912,7 +4912,7 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
 }
 #endif
 
-#define VMEMMAP_RESERVE_NR	2
+#define VMEMMAP_RESERVE_NR	OPTIMIZED_FOLIO_VMEMMAP_PAGES
 #ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
 					  struct dev_pagemap *pgmap)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 636a0f9644f6..6b23b5f02544 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1066,7 +1066,7 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
  * initialize is a lot smaller that the total amount of struct pages being
  * mapped. This is a paired / mild layering violation with explicit knowledge
  * of how the sparse_vmemmap internals handle compound pages in the lack
- * of an altmap. See vmemmap_populate_compound_pages().
+ * of an altmap.
  */
 static inline unsigned long compound_nr_pages(struct vmem_altmap *altmap,
 					      struct dev_pagemap *pgmap,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 1867b5dcc73c..fd7b0e1e5aba 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -152,46 +152,40 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 					      struct vmem_altmap *altmap,
 					      unsigned long ptpfn)
 {
-	pte_t *pte = pte_offset_kernel(pmd, addr);
-
-	if (pte_none(ptep_get(pte))) {
-		pte_t entry;
-
-		if (vmemmap_page_optimizable((struct page *)addr) &&
-		    ptpfn == (unsigned long)-1) {
-			struct page *page;
-			unsigned long pfn = page_to_pfn((struct page *)addr);
-			const struct mem_section *ms = __pfn_to_section(pfn);
-
-			page = vmemmap_shared_tail_page(section_order(ms),
-							section_to_zone(ms, node));
-			if (!page)
-				return NULL;
-			ptpfn = page_to_pfn(page);
-		}
+	pte_t entry, *pte = pte_offset_kernel(pmd, addr);
 
-		if (ptpfn == (unsigned long)-1) {
-			void *p = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
-
-			if (!p)
-				return NULL;
-			ptpfn = PHYS_PFN(__pa(p));
-		} else {
-			/*
-			 * When a PTE/PMD entry is freed from the init_mm
-			 * there's a free_pages() call to this page allocated
-			 * above. Thus this get_page() is paired with the
-			 * put_page_testzero() on the freeing path.
-			 * This can only called by certain ZONE_DEVICE path,
-			 * and through vmemmap_populate_compound_pages() when
-			 * slab is available.
-			 */
-			if (slab_is_available())
-				get_page(pfn_to_page(ptpfn));
-		}
-		entry = pfn_pte(ptpfn, PAGE_KERNEL);
-		set_pte_at(&init_mm, addr, pte, entry);
+	if (!pte_none(ptep_get(pte)))
+		return pte;
+
+	/* See layout diagram in Documentation/mm/vmemmap_dedup.rst. */
+	if (vmemmap_page_optimizable((struct page *)addr)) {
+		struct page *page;
+		unsigned long pfn = page_to_pfn((struct page *)addr);
+		const struct mem_section *ms = __pfn_to_section(pfn);
+
+		page = vmemmap_shared_tail_page(section_order(ms),
+						section_to_zone(ms, node));
+		if (!page)
+			return NULL;
+
+		/*
+		 * When a PTE entry is freed, a free_pages() call occurs. This
+		 * get_page() pairs with put_page_testzero() on the freeing
+		 * path. This can only occur when slab is available.
+		 */
+		if (slab_is_available())
+			get_page(page);
+		ptpfn = page_to_pfn(page);
+	} else {
+		void *p = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
+
+		if (!p)
+			return NULL;
+		ptpfn = PHYS_PFN(__pa(p));
 	}
+	entry = pfn_pte(ptpfn, PAGE_KERNEL);
+	set_pte_at(&init_mm, addr, pte, entry);
+
 	return pte;
 }
 
@@ -287,17 +281,15 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	return pte;
 }
 
-static int __meminit vmemmap_populate_range(unsigned long start,
-					    unsigned long end, int node,
-					    struct vmem_altmap *altmap,
-					    unsigned long ptpfn)
+int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
+					 int node, struct vmem_altmap *altmap,
+					 struct dev_pagemap *pgmap)
 {
 	unsigned long addr = start;
 	pte_t *pte;
 
 	for (; addr < end; addr += PAGE_SIZE) {
-		pte = vmemmap_populate_address(addr, node, altmap,
-					       ptpfn);
+		pte = vmemmap_populate_address(addr, node, altmap, -1);
 		if (!pte)
 			return -ENOMEM;
 	}
@@ -305,19 +297,6 @@ static int __meminit vmemmap_populate_range(unsigned long start,
 	return 0;
 }
 
-static int __meminit vmemmap_populate_compound_pages(unsigned long start,
-						     unsigned long end, int node,
-						     struct dev_pagemap *pgmap);
-
-int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
-					 int node, struct vmem_altmap *altmap,
-					 struct dev_pagemap *pgmap)
-{
-	if (vmemmap_can_optimize(altmap, pgmap))
-		return vmemmap_populate_compound_pages(start, end, node, pgmap);
-	return vmemmap_populate_range(start, end, node, altmap, -1);
-}
-
 /*
  * Write protect the mirrored tail page structs for HVO. This will be
  * called from the hugetlb code when gathering and initializing the
@@ -397,9 +376,6 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 	pud_t *pud;
 	pmd_t *pmd;
 
-	if (vmemmap_can_optimize(altmap, pgmap))
-		return vmemmap_populate_compound_pages(start, end, node, pgmap);
-
 	for (addr = start; addr < end; addr = next) {
 		unsigned long pfn = page_to_pfn((struct page *)addr);
 		const struct mem_section *ms = __pfn_to_section(pfn);
@@ -447,95 +423,6 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 	return 0;
 }
 
-/*
- * For compound pages bigger than section size (e.g. x86 1G compound
- * pages with 2M subsection size) fill the rest of sections as tail
- * pages.
- *
- * Note that memremap_pages() resets @nr_range value and will increment
- * it after each range successful onlining. Thus the value or @nr_range
- * at section memmap populate corresponds to the in-progress range
- * being onlined here.
- */
-static bool __meminit reuse_compound_section(unsigned long start_pfn,
-					     struct dev_pagemap *pgmap)
-{
-	unsigned long nr_pages = pgmap_vmemmap_nr(pgmap);
-	unsigned long offset = start_pfn -
-		PHYS_PFN(pgmap->ranges[pgmap->nr_range].start);
-
-	return !IS_ALIGNED(offset, nr_pages) && nr_pages > PAGES_PER_SUBSECTION;
-}
-
-static int __meminit vmemmap_populate_compound_pages(unsigned long start,
-						     unsigned long end, int node,
-						     struct dev_pagemap *pgmap)
-{
-	unsigned long size, addr;
-	pte_t *pte;
-	int rc;
-	unsigned long start_pfn = page_to_pfn((struct page *)start);
-	const struct mem_section *ms = __pfn_to_section(start_pfn);
-	struct page *tail;
-
-	/* This may occur in sub-section scenarios. */
-	if (!section_vmemmap_optimizable(ms))
-		return vmemmap_populate_range(start, end, node, NULL, -1);
-
-	tail = vmemmap_shared_tail_page(section_order(ms),
-					section_to_zone(ms, node));
-	if (!tail)
-		return -ENOMEM;
-
-	if (reuse_compound_section(start_pfn, pgmap))
-		return vmemmap_populate_range(start, end, node, NULL,
-					      page_to_pfn(tail));
-
-	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
-	for (addr = start; addr < end; addr += size) {
-		unsigned long next, last = addr + size;
-		void *p;
-
-		/* Populate the head page vmemmap page */
-		pte = vmemmap_populate_address(addr, node, NULL, -1);
-		if (!pte)
-			return -ENOMEM;
-
-		/*
-		 * Allocate manually since vmemmap_populate_address() will assume DAX
-		 * only needs 1 vmemmap page to be reserved, however DAX now needs 2
-		 * vmemmap pages. This is a temporary solution and will be unified
-		 * with HugeTLB in the future.
-		 */
-		p = vmemmap_alloc_block_buf(PAGE_SIZE, node, NULL);
-		if (!p)
-			return -ENOMEM;
-
-		/* Populate the tail pages vmemmap page */
-		next = addr + PAGE_SIZE;
-		pte = vmemmap_populate_address(next, node, NULL, PHYS_PFN(__pa(p)));
-		/*
-		 * get_page() is called above. Since we are not actually
-		 * reusing it, to avoid a memory leak, we call put_page() here.
-		 */
-		put_page(virt_to_page(p));
-		if (!pte)
-			return -ENOMEM;
-
-		/*
-		 * Reuse the shared vmemmap page for the rest of tail pages
-		 * See layout diagram in Documentation/mm/vmemmap_dedup.rst
-		 */
-		next += PAGE_SIZE;
-		rc = vmemmap_populate_range(next, last, node, NULL,
-					    page_to_pfn(tail));
-		if (rc)
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-
 struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
-- 
2.20.1


