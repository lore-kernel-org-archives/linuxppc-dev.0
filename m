Return-Path: <linuxppc-dev+bounces-19364-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F610EEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:57:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXXy5wckz2yvR;
	Sun, 05 Apr 2026 22:57:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393826;
	cv=none; b=FXjJSX0GSNRVN3Yv/XiDqoTs+OTKbywm1Uv5s6DRQccOKYVy+TqdiNmsP6vyJQckurbmUuy6LC3bJbGMqUo5WRp3n+LSdy/VNrmsblUM5NcAUtwdYvUq2BuiC6FPoVvMiFMspNFG901wnk7ao83eT2EAoYd6K1bFd2iS0eMlU5K8d3EdQpPZfrgIJQXjp+A22/di9PB7pDVfCDAO4FxbFav98OG0PsZ6WXy4wP5qMr3bky73nbWtIbhqwfM8h5Ue+hvek3mn31j1B7lbBp/iWr3mxWiDeLssarwBPnIQ35ndZenENYyBl2nOD9q/OitqOuFsEYRpiXpVmVJAyLpy2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393826; c=relaxed/relaxed;
	bh=dvO4goCvgbIDjzyl1a4aazkWRerXOYwkBjCejKe9WH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SP1H9Axhf+9m/cYmjn+GyYt2zdUwQyQNHQzysFVxb7WXuLsvLRRBKReWZl+GCBEWBQSFHmin6ReAQWrmO/WMWUqAUHMh0ATqown3JJLEPqcRhgkhlegd/nUyb5WmjEQsiUXk74031pNjm1gq2jS0TxiZ3n4p9GNCalD10m5M8WQsVo4vUfpc5VAQtnEXGO41n5jDUrBjpF8Vbktq2iY3x15Hnl2ayB8huUwIIsTWG8/Preb2cBPnohkGoTVJDNRYwAZfOIHYYKUNsn1+4kARxjPOqU60eEkPbjW7/v4aUAm97dPHVcwQMz97FIeUd0fCU9ew51kTGfBUdzOK0lY46g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VLHUY2wF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VLHUY2wF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXXy0dDKz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:57:05 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-35c1d101355so1241815a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393824; x=1775998624; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvO4goCvgbIDjzyl1a4aazkWRerXOYwkBjCejKe9WH8=;
        b=VLHUY2wFHjketRhSzoOYXJ8M9DJAi1OnZsk9n+KDmij3glfrc8E1vK7E0b8yioOVkq
         5VVPaOCQg6XikusxhgRKMPVV/4aS4e5ctl4/QHDYp8XDgU6eemxZKgrnDOOO2i3Ta6UR
         j4H6UHIjCK3Tds82TJm86yGGwfTKA3TnpSRhfSfjH6YVa4dg4SEVqEMh5+1QPdtQGpKT
         6LbLZ27ayGIyaCy0H8ths/6tAes91MvJBiyRXYNi+WcAeJ4rKeTQeR8LbtFTExUKF7cR
         ajeg7gHWWmqLOHqhNAhYsys8sTMfA48smViQl4D+uGFdysTw35FvVtUl9VDniYQMrlTY
         X1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393824; x=1775998624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dvO4goCvgbIDjzyl1a4aazkWRerXOYwkBjCejKe9WH8=;
        b=sKh0FGnzghq/wxTUqScehgedBtPOd3zrlCArUyrhAlTV6pZAml8Xoj30KZmp2Y1lZU
         AQFQv/CjFY/nu9oAvEPe7W62Sr2pvRBRB8y9hYA0boV764WqCn+EIKZLrq2832gOQ/5F
         98FOiD3qrs/RgUtxzQOAKgc+0owAf2wkF16iB7juY7scRlEmQQWapVvgb8xonCcR55DB
         BT0JYf9upGz7vMyBvZ4XwaCZ2FDjUagnMdD3wuAWbvqw10xPo7mnoxgYMTZjtV3l4f+O
         GP6VL7GWzdvcBrMpmXycO0QdkcXKvz8EGb58og7KrO9QXgQWzbwtCAXxLwC8B9wQstca
         +o6g==
X-Forwarded-Encrypted: i=1; AJvYcCVKj9LuLYnfWQm/APdPBHf+TxfSBR2VK3QxJulXjlvKBxn7Rfm458ptKvQ81m1E7FV6zv0OEWJ5LvSe6IY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywu4LQAzQhTKy2QXHpFC2IWFovrT6kmY7dmD3AVqwHCkURPrQ2I
	ExGUV+0OFjWbznhxSLgaUOCPa7AHBLCqu/99WhofpHzY74R7WMta01yPLSIqoAdcAxw=
X-Gm-Gg: AeBDievKqGnqbdMeepzy7U6DQficUU1Yq5HHfJY0u11CLlHJM+BkIxKnEGTCiedyF8V
	JjIv7tMrV6cCDwXnca8zTrWg1/jcEu7znLE6r92xXQKc3si+9c+p/etkFoQH5wF8H6zS8+CsN8f
	Sja/PlsqBDkxMqiK6HoygeK4oyYKULNWhz5p2FbdwCYepKoYCpO9pSV5eMcaFOHEyv1H1xbvovd
	65hkcQU5UvaU7Mrz6XbIIIkrgkxctXM30/ND7l33gB/y3PIWPzdc5dlvXfQK+x7MDTq2XoTQXPJ
	BcACAGx2p3ac1RPhwXPsyYg2P+CstKjEgag+ngGmKycWbC+/Lr1tKq9JR6FKU3X+NUkQhvAu1N5
	ujLf7GiczB5Fpbz/F1MjML0Mhwp9RgqUQGGMJ83Z9FHm/Q/HYzmkCgBcOe3wXfYp6Rjc1zuq6q9
	eRXDbnl6cJ74TnhCFmihDP8NZLBsofriz9jTGRVo1e7k0=
X-Received: by 2002:a17:90a:d2c7:b0:35c:cba:344f with SMTP id 98e67ed59e1d1-35de68414eemr9240766a91.13.1775393824055;
        Sun, 05 Apr 2026 05:57:04 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:57:03 -0700 (PDT)
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
Subject: [PATCH 34/49] mm/sparse-vmemmap: switch DAX to use generic vmemmap optimization
Date: Sun,  5 Apr 2026 20:52:25 +0800
Message-Id: <20260405125240.2558577-35-songmuchun@bytedance.com>
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

Recent refactoring introduced common vmemmap optimization logic via
CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION. While HugeTLB already uses it,
DAX requires slightly different handling because it needs to preserve
2 vmemmap pages, instead of the 1 page HugeTLB preserves.

This patch updates DAX vmemmap optimization to manually allocate the
second vmemmap page, and integrates DAX memory setup to correctly set
the compound order and allocate/reuse the shared vmemmap tail page.

Note that manually allocating the vmemmap page is a temporary solution
and will be unified with the logic that HugeTLB relies on in the future.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c |  5 +-
 mm/memory_hotplug.c                      |  5 +-
 mm/mm_init.c                             |  8 ++-
 mm/sparse-vmemmap.c                      | 82 ++++++++++++++----------
 4 files changed, 58 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index dfa2f7dc7e15..ad44883b1030 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1124,9 +1124,10 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	unsigned long pfn = page_to_pfn((struct page *)start);
 
-	if (vmemmap_can_optimize(altmap, pgmap))
-		return vmemmap_populate_compound_pages(page_to_pfn((struct page *)start), start, end, node, pgmap);
+	if (vmemmap_can_optimize(altmap, pgmap) && section_vmemmap_optimizable(__pfn_to_section(pfn)))
+		return vmemmap_populate_compound_pages(pfn, start, end, node, pgmap);
 	/*
 	 * If altmap is present, Make sure we align the start vmemmap addr
 	 * to PAGE_SIZE so that we calculate the correct start_pfn in
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 05f5df12d843..28306196c0fe 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -551,8 +551,9 @@ void remove_pfn_range_from_zone(struct zone *zone,
 		/* Select all remaining pages up to the next section boundary */
 		cur_nr_pages =
 			min(end_pfn - pfn, SECTION_ALIGN_UP(pfn + 1) - pfn);
-		page_init_poison(pfn_to_page(pfn),
-				 sizeof(struct page) * cur_nr_pages);
+		if (!section_vmemmap_optimizable(__pfn_to_section(pfn)))
+			page_init_poison(pfn_to_page(pfn),
+					 sizeof(struct page) * cur_nr_pages);
 	}
 
 	/*
diff --git a/mm/mm_init.c b/mm/mm_init.c
index e47d08b63154..636a0f9644f6 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1069,9 +1069,10 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
  * of an altmap. See vmemmap_populate_compound_pages().
  */
 static inline unsigned long compound_nr_pages(struct vmem_altmap *altmap,
-					      struct dev_pagemap *pgmap)
+					      struct dev_pagemap *pgmap,
+					      const struct mem_section *ms)
 {
-	if (!vmemmap_can_optimize(altmap, pgmap))
+	if (!section_vmemmap_optimizable(ms))
 		return pgmap_vmemmap_nr(pgmap);
 
 	return VMEMMAP_RESERVE_NR * (PAGE_SIZE / sizeof(struct page));
@@ -1140,7 +1141,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(altmap, pgmap));
+				     compound_nr_pages(altmap, pgmap,
+						       __pfn_to_section(pfn)));
 	}
 
 	/*
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 309d935fb05e..6f959a999d5b 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -353,8 +353,12 @@ struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone)
 	if (!addr)
 		return NULL;
 
-	for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++)
-		init_compound_tail((struct page *)addr + i, NULL, order, zone);
+	for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++) {
+		page = (struct page *)addr + i;
+		if (zone_is_zone_device(zone))
+			__SetPageReserved(page);
+		init_compound_tail(page, NULL, order, zone);
+	}
 
 	page = virt_to_page(addr);
 	if (cmpxchg(&zone->vmemmap_tails[idx], NULL, page) != NULL) {
@@ -458,23 +462,6 @@ static bool __meminit reuse_compound_section(unsigned long start_pfn,
 	return !IS_ALIGNED(offset, nr_pages) && nr_pages > PAGES_PER_SUBSECTION;
 }
 
-static pte_t * __meminit compound_section_tail_page(unsigned long addr)
-{
-	pte_t *pte;
-
-	addr -= PAGE_SIZE;
-
-	/*
-	 * Assuming sections are populated sequentially, the previous section's
-	 * page data can be reused.
-	 */
-	pte = pte_offset_kernel(pmd_off_k(addr), addr);
-	if (!pte)
-		return NULL;
-
-	return pte;
-}
-
 static int __meminit vmemmap_populate_compound_pages(unsigned long start,
 						     unsigned long end, int node,
 						     struct dev_pagemap *pgmap)
@@ -483,42 +470,62 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start,
 	pte_t *pte;
 	int rc;
 	unsigned long start_pfn = page_to_pfn((struct page *)start);
+	const struct mem_section *ms = __pfn_to_section(start_pfn);
+	struct page *tail = NULL;
 
-	if (reuse_compound_section(start_pfn, pgmap)) {
-		pte = compound_section_tail_page(start);
-		if (!pte)
-			return -ENOMEM;
+	/* This may occur in sub-section scenarios. */
+	if (!section_vmemmap_optimizable(ms))
+		return vmemmap_populate_range(start, end, node, NULL, -1);
 
-		/*
-		 * Reuse the page that was populated in the prior iteration
-		 * with just tail struct pages.
-		 */
+#ifdef CONFIG_ZONE_DEVICE
+	tail = vmemmap_shared_tail_page(section_order(ms),
+					&NODE_DATA(node)->node_zones[ZONE_DEVICE]);
+#endif
+	if (!tail)
+		return -ENOMEM;
+
+	if (reuse_compound_section(start_pfn, pgmap))
 		return vmemmap_populate_range(start, end, node, NULL,
-					      pte_pfn(ptep_get(pte)));
-	}
+					      page_to_pfn(tail));
 
 	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
 	for (addr = start; addr < end; addr += size) {
 		unsigned long next, last = addr + size;
+		void *p;
 
 		/* Populate the head page vmemmap page */
 		pte = vmemmap_populate_address(addr, node, NULL, -1);
 		if (!pte)
 			return -ENOMEM;
 
+		/*
+		 * Allocate manually since vmemmap_populate_address() will assume DAX
+		 * only needs 1 vmemmap page to be reserved, however DAX now needs 2
+		 * vmemmap pages. This is a temporary solution and will be unified
+		 * with HugeTLB in the future.
+		 */
+		p = vmemmap_alloc_block_buf(PAGE_SIZE, node, NULL);
+		if (!p)
+			return -ENOMEM;
+
 		/* Populate the tail pages vmemmap page */
 		next = addr + PAGE_SIZE;
-		pte = vmemmap_populate_address(next, node, NULL, -1);
+		pte = vmemmap_populate_address(next, node, NULL, PHYS_PFN(__pa(p)));
+		/*
+		 * get_page() is called above. Since we are not actually
+		 * reusing it, to avoid a memory leak, we call put_page() here.
+		 */
+		put_page(virt_to_page(p));
 		if (!pte)
 			return -ENOMEM;
 
 		/*
-		 * Reuse the previous page for the rest of tail pages
+		 * Reuse the shared vmemmap page for the rest of tail pages
 		 * See layout diagram in Documentation/mm/vmemmap_dedup.rst
 		 */
 		next += PAGE_SIZE;
 		rc = vmemmap_populate_range(next, last, node, NULL,
-					    pte_pfn(ptep_get(pte)));
+					    page_to_pfn(tail));
 		if (rc)
 			return -ENOMEM;
 	}
@@ -744,8 +751,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		free_map_bootmem(memmap);
 	}
 
-	if (empty)
+	if (empty) {
 		ms->section_mem_map = (unsigned long)NULL;
+		section_set_order(ms, 0);
+	}
 }
 
 static struct page * __meminit section_activate(int nid, unsigned long pfn,
@@ -824,6 +833,9 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	if (ret < 0)
 		return ret;
 
+	ms = __nr_to_section(section_nr);
+	if (vmemmap_can_optimize(altmap, pgmap) && nr_pages == PAGES_PER_SECTION)
+		section_set_order(ms, pgmap->vmemmap_shift);
 	memmap = section_activate(nid, start_pfn, nr_pages, altmap, pgmap);
 	if (IS_ERR(memmap))
 		return PTR_ERR(memmap);
@@ -832,9 +844,9 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	 * Poison uninitialized struct pages in order to catch invalid flags
 	 * combinations.
 	 */
-	page_init_poison(memmap, sizeof(struct page) * nr_pages);
+	if (!section_vmemmap_optimizable(ms))
+		page_init_poison(memmap, sizeof(struct page) * nr_pages);
 
-	ms = __nr_to_section(section_nr);
 	__section_mark_present(ms, section_nr);
 
 	/* Align memmap to section boundary in the subsection case */
-- 
2.20.1


