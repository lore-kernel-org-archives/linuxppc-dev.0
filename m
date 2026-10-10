Return-Path: <linuxppc-dev+bounces-29167-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA384CA9EC0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 07:58:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1x245r4Zz3bSw;
	Sat, 10 Oct 2026 18:58:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791619132;
	cv=none; b=FqwQZwlrqovEILCKM/l7DUrum5jg/YntQfi80Jef3bOdootHmAWrqyEYmMYKaOTtxa1/2AxYuYQT4LXobERhcjKaC7JHjFe8CV2Pxe0073ImKlt/gm4G5qHE1E9zfOqlpKKPF6TpKW09CplY4WDpAa0YxE0IMVcrDJqNX62m7AwrgrJjproYLVkjiohWiwMoU/bLWUTWBYrNLv6gm6zSQ8VBjAENb8GM896mCdc7SwjzNtSHcqpu+NhIC+6PvJJ4X2FWCeUhmJFOWipzLZo+fYzx/GrxfaDHjI0fMo0qb3lK5IZeBMFnhITP3hiDMq2GR0Cgknn+OseqJ6dkix66sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791619132; c=relaxed/relaxed;
	bh=gIpC3TTxDyvpOR8NKmtyMQLMyDufyxtaZeBdyCHZ6SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPzlTzd85foiKhENMMalL/4pkdeUCC12wavXKs6UqCRTkIfztdEGl0Ob27zDqYdymjHQcSf4pg4P+t9h+YhjtfvkiPFPnKWKVO3CWbvEbEY1PQPTPtD4yf+mkZ6fOHYNd1VLS/gZ2OFD40p+oFDXrVY/aOExFNe10zgGziA2YleSypCKzi3xp92DqohyZ+HxxSWGcg2uHwTPan2r5otHYw/p7nQ3xxkguX+WTBrmrMWa3uJjX/uLv9uBCBj8nTRGCcX2OCmLlyuw9yCbxx2NDDQq9g/jPUspP0D06j4ywWZcfmE/i4LOLrIK6tCp4qnWdnjOjNSSXOU0NHTcOO9Zxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jGGP8zrg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jGGP8zrg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1x240L0dz3bSn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 18:58:51 +1100 (AEDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-cc7cc8aafe6so146095a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 00:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791619130; x=1792223930; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gIpC3TTxDyvpOR8NKmtyMQLMyDufyxtaZeBdyCHZ6SI=;
        b=jGGP8zrgrc5rYw9SPQVcENk7XOv/iHBhCV50TC8YvDA2pt8eMPaXI9YHS9o3ugSUup
         6/VXJmmfMrx5sl7fbg4tN0E/utcBBl4TxQpnnFK6IEb6yjGkg3g97XsYflz0AXzJsMvW
         i1mEoVN/+6uKcUN97L9E4bR3Y/TNfShLbnC8BLjRPXFsyhC9CjBjjuJHOV2FwPVme2ze
         fg31d0olGxBfBZVQJ4UORqnW8DH55G5nCXtDH3/Xt9jxPHkN4kNSwhx/VneUaLAheVzQ
         XlopIRVFpD8vanebhDRswE9plJE9nNCCRaKI9wL/AGhUaz3Nku9JGnOFtv3t8c0lT3/r
         3BGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791619130; x=1792223930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gIpC3TTxDyvpOR8NKmtyMQLMyDufyxtaZeBdyCHZ6SI=;
        b=r5Lw6cPoQ5agIT7AXUJoyqcA8osx61E54ymbsuyU9AjN1b6iojX9RxYVPTarl0vaN+
         O/vwLjzDPgIufQ5rYdSuuctcR5EWvl9bsmfmpn5iBDoV416NwxOcS5niYgwi0Roee2z9
         JVlodPV3krs0dZikPteL0G4HmRv44Ox9byfXv6EKm7ArCNQYP23Ebv9HojFF9TrwBPRo
         74BBPaN3romFrhjvx7+ygQ5Z5TtneEu58mGLgl9KS+znDvHiHohsD58inz260P1XP9s8
         qTqUlhOH3ty450DdU5SkZ1/9Rjn4rwRR6gAdXti4cwpcqwiV7t1Ayk9y4WHZZ3ABzb9K
         0cVw==
X-Forwarded-Encrypted: i=1; AKwUvBzE6iO418T8wscJkGIqL50V8dDG3ZKJ5KS6lic2WQvVvhrLQqtvo4W2HqTZ89nQ2pEjzjzo9ROCnH9xpO4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIJg2rR93RrhOfkpZTiJMH9dDU7eibNdKQRX4UAB6byJaINbj01
	9lGiks4ZENUiHDkDhkSINxSaIlI2VYCFG8PgYL4YVsYaz2rjmwnxODOt9ycH0EvIWTw=
X-Gm-Gg: AYBFou0SiHO1Zvvo10sNqIIlNmXWHGtGbLbnmumlaRuGPs5+nGPPLfFapG4k4c0UHr1
	HqIII1pcaOF7W2IdG1lmXQankVO1H8V+rAt68zCYvexgfao22/Lh3mVkdj6O68AChrp4Z4LHHMQ
	U6xsHLFu9jNPwkbdYyIHMPmeTTxb0+48OBDwM8fx3NT/yZzwX/NAC1HLeHASg7gur5wwNz2MMYJ
	h13oMoknrvukYl7Cf2AugH8pZl0ddAYG9yuC5Hsoqh1QfXVe4zu4nAH7iI8bWmRUJIaQELxyWzN
	Yaz2CDr/DBIADHb1sTcO0PJfzuHW6P82a0fNPGgncUO04lwMLPAwk8ITtODVB+zDyrKUj5K1nGa
	mBl9yAf84Mkn882bDK5JGI/wN2npceenVvYxWTGfao8h5u18IXHZ478TDLumpeKJJvIqWkyLrHr
	3A6SkuoThaIaFiA3AvJktv+srlECEUkFNctMV5Jli/KUnag9OpyMxUpgvfBYRnsI2jEUS5v7DAd
	zNBIh3Cfa6tcUgIkoVlZw+gO3ALP9ug15BXeoTHZfIbSVpR
X-Received: by 2002:a17:90b:2ccb:b0:3ab:17b6:9a93 with SMTP id 98e67ed59e1d1-3ab3afcdc6emr4054531a91.52.1791619129838;
        Sat, 10 Oct 2026 00:58:49 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab57c05724sm3473569a91.4.2026.10.10.00.58.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 00:58:49 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Lance Yang <lance.yang@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v4 3/6] mm/sparse-vmemmap: drop Device DAX-specific population path
Date: Sat, 10 Oct 2026 15:57:52 +0800
Message-ID: <20261010075755.83339-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261010075755.83339-1-songmuchun@bytedance.com>
References: <20261010075755.83339-1-songmuchun@bytedance.com>
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
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v4:
- Collect Reviewed-by from Lance Yang

v3:
- Use the public order-based optimization predicate in the powerpc path

v2:
- Collect Acked-by from Qi Zheng
---
 arch/powerpc/mm/book3s64/radix_pgtable.c |  3 +
 mm/mm_init.c                             |  2 +-
 mm/sparse-vmemmap.c                      | 71 +-----------------------
 3 files changed, 5 insertions(+), 71 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index a3332f32ffb2..44868b62b14e 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1126,7 +1126,10 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	unsigned long pfn = page_to_pfn((struct page *)start);
 
+	if (vmemmap_optimizable_order(pfn_to_section_compound_order(pfn)))
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
index 62327ac15206..270b5def58e1 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -503,71 +503,6 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
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
-	const unsigned int order = pfn_to_section_compound_order(start_pfn);
-	unsigned long size, addr;
-	pte_t *pte;
-	struct page *page;
-	int rc;
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
@@ -580,11 +515,7 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
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


