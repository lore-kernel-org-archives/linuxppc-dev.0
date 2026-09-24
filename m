Return-Path: <linuxppc-dev+bounces-28100-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5F1C98315
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 07:58:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr5ms4vqyz30TL;
	Thu, 24 Sep 2026 17:58:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790236701;
	cv=none; b=Ao4EoVv7UAzTr3KTj49DoMI8tPgg1075xEUjT2izKVEPfmKVjdrSwrSU4rv3HS8Ybpyvt1rGshx8u9G2pZ2l3sn49EErk7aqdrPbkBU0Eq0T8E1sgsZ5NdFU2dW4rGk4ONPzb7ncxsWFLzJnQDvu3/VTzRMhLjZJx7R1xu7BmgEQdtLAJUYuaRkgazhaysGL2/mtGTXzFCitKv/fNXQO8LHTTcz05msofSQZnFVzp+2Z0QH4gvX3L7hynfG1uzXohUMj2FZDTiJcF/SyB9Wm5MF1EKRTq6O7GpoWsYI5qQkj+fsz5s2SuGIszPwkkXKbqpEGDSvzQD5jYRsOUaIh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790236701; c=relaxed/relaxed;
	bh=Mwg8qfU0YRGSE8UK0HBy9iZTs3Sk7OFpk3Nxuz+XYco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAY513uv9WZ4LeyVGL0oAQai2I3DXGLbw0XaLz+o5s37bQVUiqk9Ocqw9sk8YFQeVOjnddooKzt2aMXfNoDrRRmC3s9FSSzcHFYoJFEVuby6rKH6Nffl5eEPWWGcGrJNvfyygb6ngCO2T3DdJq4LXC9EzaoDpwhvJvjZVFkWL9gkcH3iyuu8asM8wnwP1b5b07ftDxWGz2yspHCGo39O4Jq3DtxoIFLLInGTzavaWlJTW7u6vE7/NYNHfypkysK2LMVyPB+10dtllP/hBedGB2c+vhAvRuMjjunW8HeCQXxZGsZzTUUET18YXlgHSZd2NLF3ahjUOjscC/PpNdO9Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Q8aED7nZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Q8aED7nZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr5mr5sx3z30T9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 17:58:20 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-398a1676000so1072344a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 00:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790236698; x=1790841498; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mwg8qfU0YRGSE8UK0HBy9iZTs3Sk7OFpk3Nxuz+XYco=;
        b=Q8aED7nZLEywCzc4P3uQhlpUbsvVw2otzQxD/eSvASAsbvvXbBvhzICGlwknJFIc2I
         RHppa2IisiD8aB7RFYm8xPtchyS34B8uXfZmAxWCJXBUz7H3aXMhOtlsPMd3jDnniAvq
         tUTFZOnrCE+LyjHjGFl5A6x9pu4NPT15bpdD47i5AWbKAoMLGWPiqQCg+NGMa9BlFoR1
         +PaHZAx120Dxn0goNeRQF3GgdZ3TNrvEd1bdmMFukaDXapMIW+84csledB+88NFD48Si
         4y9KafVS+QY/PEU9OYhnNJP+d11u5YrAyC57j2DWi2Y4FPmf1VN8L+5AY4ZlG+M8F6kH
         2XSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790236698; x=1790841498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mwg8qfU0YRGSE8UK0HBy9iZTs3Sk7OFpk3Nxuz+XYco=;
        b=rk1B9pg866W/zS2HJ7xWYLu9im93SC2476fwKtNHlhOIeCB2VZQKWvfS886ZKiY6vw
         4ZWx3JpZ+9aTWBUHjCRuiIXUQ4EN+wX9OEZMpK/mf4iU/EsQTy9328iLHy1gg5BEWEy+
         VjVBgv1PQrfyDFnUppCZdNkEhnrXmPPavuPSsLdNJ27m3BSOnilhdPnfy0LTfygRLdOo
         7JQ6oncZ32k2Nx0zS9yFg3h7S8qZP1AnJ25x8gWCTCkBU5ikMM1jheu+zLdYifvGJgtE
         xCD2R6oWL4erjTyuPkqnXfPZ4AWpYbuY15EfH9lgwSPlwSz5C7nnp8plIdCDfs7l4yrq
         h+vg==
X-Forwarded-Encrypted: i=1; AKwUvBzv0DcT8GT1TM1/PJH4tKX92nArE0jsx51DeDEYHsURitMvaJavaUMTrKYs0A809kxC61X/Xis0nWJDupQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lZAZjAMwF10fcybF9HovXiOcHjN+++CtbKBE40qsydY9ZgpjHB
	shNLU6a1hFY+843eo2e/xA57JU5qI5kxtQWI1w+i9bEL2VWjwORH3CNSmIVQ8jePao0=
X-Gm-Gg: AYBFou1H6hVOY+biHx4qOyu+IKkA4XnA4v389iGJHt4ZCc4vo5GPTKAtMJCOoACrmwR
	XrBIlETa/RIZVTHhObhZSqQZQ8+r0KnD6xeiGntCPDI5Afb+YLo28qRjeisncAi3J5L1cQ5Fgzq
	oTJG0nWejzSOUdqoeo0b2Eilvzx6tWHrhAMstSSP1nihUOd0rYbxCKlLS4a7vdUITbw0FaNjnex
	QygdRkZTBn7BxZIset+7Bg+KkuBk3KCbC1sdB93bJDP4J8lq8SK9nsOMoEqLwTV4XTQVsMIqc5G
	qoES0wigIeOvTSYUfeDYSoEMR0aie2OSlSwk2pr7hWiTX9auylId+Qj95qbGdP93ew/KYqqyTWX
	JmmgFmF64R925cHc9zv2YwC/qj56t+k39cecWFsgJwC7vuUozeWdkb5Q3vfAUT1rCqGzNy2XYr8
	Dxsql0H+kOkW1RYFoHvB5mK7sHxLBSYfcNosbxsHHqlOjLwL7g0APJ2lrvdmKR/ZXcAtJbOMPVp
	AKj0RTSjybVa7Vxcmlh
X-Received: by 2002:a17:90b:4e8f:b0:39e:4c80:f67c with SMTP id 98e67ed59e1d1-3a09875f8f6mr1584809a91.27.1790236698392;
        Thu, 24 Sep 2026 00:58:18 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972eec92sm3575622a91.7.2026.09.24.00.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:58:17 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v2 3/6] mm/sparse-vmemmap: drop Device DAX-specific population path
Date: Thu, 24 Sep 2026 15:52:56 +0800
Message-ID: <20260924075259.2013039-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260924075259.2013039-1-songmuchun@bytedance.com>
References: <20260924075259.2013039-1-songmuchun@bytedance.com>
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

The common vmemmap path selects the shared page for optimized mappings
itself, so Device DAX no longer needs vmemmap_populate_compound_pages()
to find a shared tail page and pass its backing PFN through the generic
population helpers.

Remove the Device DAX-specific population path and let section memmap
population always use vmemmap_populate(). The powerpc retains an
architecture-specific compound-page implementation, so select it directly
from radix__vmemmap_populate() for optimizable sections.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v2:
- Collect Acked-by from Qi Zheng
---
 arch/powerpc/mm/book3s64/radix_pgtable.c |  3 +
 mm/mm_init.c                             |  2 +-
 mm/sparse-vmemmap.c                      | 71 +-----------------------
 3 files changed, 5 insertions(+), 71 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 9ca28e4a610a..cb72d9ccf747 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1122,7 +1122,10 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	unsigned long pfn = page_to_pfn((struct page *)start);
 
+	if (section_vmemmap_optimizable(__pfn_to_section(pfn)))
+		return vmemmap_populate_compound_pages(pfn, start, end, node, NULL);
 	/*
 	 * If altmap is present, Make sure we align the start vmemmap addr
 	 * to PAGE_SIZE so that we calculate the correct start_pfn in
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 56bb4567a494..1650d6bc1211 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1046,7 +1046,7 @@ static void zone_device_page_init_from_template(struct page *page,
  * initialize is a lot smaller that the total amount of struct pages being
  * mapped. This is a paired / mild layering violation with explicit knowledge
  * of how the sparse_vmemmap internals handle compound pages in the lack
- * of an altmap. See vmemmap_populate_compound_pages().
+ * of an altmap.
  */
 static inline unsigned long compound_nr_pages(unsigned long pfn,
 					      struct dev_pagemap *pgmap)
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index cdcc93714a9a..4aae22beca21 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -466,71 +466,6 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 	return 0;
 }
 
-#ifndef vmemmap_populate_compound_pages
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
-static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-						     unsigned long start,
-						     unsigned long end, int node,
-						     struct dev_pagemap *pgmap)
-{
-	unsigned long size, addr;
-	pte_t *pte;
-	int rc;
-	struct page *page;
-	unsigned int order = pfn_to_section_compound_order(start_pfn);
-
-	page = vmemmap_shared_tail_page(order, device_zone(node));
-	if (!page)
-		return -ENOMEM;
-
-	if (reuse_compound_section(start_pfn, pgmap))
-		return vmemmap_populate_range(start, end, node, NULL,
-					      page_to_pfn(page));
-
-	size = min(end - start, (1UL << order) * sizeof(struct page));
-	for (addr = start; addr < end; addr += size) {
-		unsigned long next, last = addr + size;
-
-		/* Populate the head page vmemmap page */
-		pte = vmemmap_populate_address(addr, node, NULL, -1);
-		if (!pte)
-			return -ENOMEM;
-
-		/*
-		 * Reuse the shared page for the rest of tail pages
-		 * See layout diagram in Documentation/mm/vmemmap_dedup.rst
-		 */
-		next = addr + PAGE_SIZE;
-		rc = vmemmap_populate_range(next, last, node, NULL,
-					    page_to_pfn(page));
-		if (rc)
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-
-#endif
-
 struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
@@ -543,11 +478,7 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
-	if (pgmap && section_vmemmap_optimizable(__pfn_to_section(pfn)))
-		r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
-	else
-		r = vmemmap_populate(start, end, nid, altmap);
-
+	r = vmemmap_populate(start, end, nid, altmap);
 	if (r < 0)
 		return NULL;
 
-- 
2.54.0


