Return-Path: <linuxppc-dev+bounces-28442-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E61CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 05:33:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv6KX0mC1z30Vs;
	Tue, 29 Sep 2026 15:33:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::17"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790660016;
	cv=none; b=iSmsTgHucInD5DEqiXxVkQNu5JRnwJ+4gOb2PugKBv3mjJSAE/Pvy0kKwKViPZSjURuleyQApIF+CPwmXusZqw+B4F5fOSCBIWEB6v3Q+dlwTyPZXoBkTH/CCrGXc2Jl2qEYcEZVK/xNj1rocjriNriX7BXIITdDlddQ9z1LjJHvFNJIq956danrENPZhP7Jyql9gg2M5n/K/9BGiDny8zcNSxPXh2DGk9OpD3HhfSXobehV29CwfoOBEbU/ShkGQrrXj0i7YrrgXZVF3kA53B+gvXu1+5Pb/TmLTSjTk0vGqZWWKT0hH3X/3cTRAuuVfuglQ0b2ADB0puRTAq6xHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790660016; c=relaxed/relaxed;
	bh=xWQii0KU4eCZDNyN5Go6yzEsWjVyPkRiAzmEp1lyEhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVSHBmUCqbcPowk0jMcNG2eA+QcInFL6iC9r3lmE8jAylF+0/cNkYwyZ/RApYB5RtyJhc2LHdxQ2K7bEsvHCmOrxOkh+xceQulss9tNvP/ceDSFXp1k9cefg3ye6piBW62XXUlITZx0aznMlf9EwRb4UOrIoIMlWPPnWtCLb1aD1B36p7DUcf/gf/lQV8jkxVfN6KuRWs4UhwgmEub2jhgD22zh1BpGoM+57K5AfltNOEZiFx0yA8I8AmQPxYfjMI5Qklr8I8nRTjsh9uV7qTfUIhSWIyCbAd8WIIcLRs+2IorVbwlYQD5e0AAUQTQkQTgTJ6SwJBK3Zb3ViQulqdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=i0zi0CMz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::17; helo=mail-pj2-x17.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=i0zi0CMz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::17; helo=mail-pj2-x17.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x17.google.com (mail-pj2-x17.google.com [IPv6:2607:f8b0:4864:39::17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv6KW2sLwz30Vb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 15:33:35 +1000 (AEST)
Received: by mail-pj2-x17.google.com with SMTP id d9443c01a7336-2db18fe433fso16573345ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 22:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790660013; x=1791264813; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xWQii0KU4eCZDNyN5Go6yzEsWjVyPkRiAzmEp1lyEhc=;
        b=i0zi0CMzL8ep7CH9Xw6UfB0sl/TNzGb/8DG2dXj/yhlMfJOir4Tv8K1oz5CPa8GW/5
         NZSTEU4IpuERXm4V70aVY+sNpKIhTMokAuU19h8/59rGh3APdVSvcNXUhpnHy7OyLk85
         wCLia1t0U8TaGDDdzgF2ERnVwYGBTH008Y5CR5Qu0IAjGVL56LIECX9bUr5krnIW+Bl4
         1IYAqfaoxS1Bw/18/103rwJpFFKrCe6MOUX2hjN5h63K1KdvUgkdQa3pyms2re4nOX1p
         6OWC9vMWwNpUpa6s0tGZHUju3Lw8uU4WecPQ+CqMdtYo38y589hNf53ezj3tRRNQPd/9
         uZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790660013; x=1791264813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xWQii0KU4eCZDNyN5Go6yzEsWjVyPkRiAzmEp1lyEhc=;
        b=xJUuf4n3L8CjznECjgEnBXc/c6BF+yu68pAVlvfCEjz//Ua6WIRO59k8je3XcO/5Ms
         uRu2f9VhJwFAplmbDyTc92BCoS7A4prZQqoHX+ASF+AVAsdWwSjzV7kZX4kxTPMxJ5/h
         TpNtbyvBBvLDyAqnGfrpPj7ko/jG7++q6t3jkkIr8KfIPVBiZtYIiwPkItNQDI4C5M0q
         WR6WOsd7AsXf6BVZONeOlR0/l3Up4U5xXvB8+z468hWa3Ndz0vLxYIVlhxPjLM3/yFPx
         Xd6Dao5/pSGzDIX1zpkhVtY6QFAJAvb4VK02Or5ed8NpbcMX04qSrqiDIhAeW7QT3pyH
         oIpA==
X-Forwarded-Encrypted: i=1; AKwUvBw/Tc7+ip59E2K3yyPfOCUuk/WkYvg0EcLHfgIfAZVbT3JkPRfQzeKiIXkC2B5Q8NpWecK43uIVdAORrA8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLNyd017ThB+cwX8BZD6ytq0YmvYERlzMFSY3QModVWAVS3Etzn
	SYyu8o9fK9UnDRaImB9OByhBNEw8SxhYuzxiPBFT8HiVi04yAWGKFK6bTFprxk9sH9A=
X-Gm-Gg: AYBFou2sUV63N0g7zxPipv9mpNpVgqAutx3kkzfzcba+zt1KgtivGYc7yQHj+aZLneo
	ld04V/Kce2RPnr7bbrP/5/LQEjFBLEpz4RDJFGz+M+6LS6UR5BxltFLXZ3o/pUKZLdeT24VPRhp
	l/2/oetDuWj3hl7+TSJPzaY8y17JNg/zGn8GBPUJ45nDwRaTgXJ1r0B034UtzfoHlHj8VdgRUHa
	WoECDzjGLNzjr/yICI78XGx4Sw8q5Q5Qq+RISgv8eOZT/5NGvpifdqov/fgUpiuWnOgCzWzU2V8
	Yc0o3fmkL0+0GDNNNIhQC3Lqugj1CFwK2Ft3YaDxePX8gjzOEL1NPur56AN3mg51gAvcqOBuTj9
	ETGGlUuPSPjOMGidYcSRh+CgmzFAy/8dVQ1jPPThgAickwXX6fQ2F5FQ3EgORu4aOSwv3QdQaBL
	oycpIG9H3WOpKqIyuM8NQ0wYh3tzF1cBz/Y7zDSLtsjMaJTpcfYZlZgi+ZylgI58U3I6DcHNBl4
	lno5s8fUo6Y+RYUOmo=
X-Received: by 2002:a17:902:d98b:b0:2df:8ff9:514d with SMTP id d9443c01a7336-2df8ff97286mr102857185ad.62.1790660013300;
        Mon, 28 Sep 2026 22:33:33 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142bafesm49251765ad.51.2026.09.28.22.33.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 22:33:32 -0700 (PDT)
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
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v3 3/6] mm/sparse-vmemmap: drop Device DAX-specific population path
Date: Tue, 29 Sep 2026 13:32:28 +0800
Message-ID: <20260929053231.66085-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929053231.66085-1-songmuchun@bytedance.com>
References: <20260929053231.66085-1-songmuchun@bytedance.com>
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
index 9ca28e4a610a..fd13fa91e5c0 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1122,7 +1122,10 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
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
index ee4c113ca938..dee95e520376 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -499,71 +499,6 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
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
@@ -576,11 +511,7 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
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


