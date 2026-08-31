Return-Path: <linuxppc-dev+bounces-26244-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B66C624C2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 07:55:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYLqy1Z8Gz2yv8;
	Mon, 31 Aug 2026 17:54:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788162894;
	cv=none; b=ceZEJ5NjIOX1DypR9tETv81EnYd2i5NycHSxCXs0TchsAADGj10e2ujhuNPLLQeETQFML/ufkFVYSXbePOThYdy80L/oUGWZ6BSrCog808N+5snNYj2MaLrJTdMnH+W9QFLCFRn61x4c5ywAcIo0cxAwYVT4N6kwGLKJHgiotS4Tkz0WFElIn/ubkeBIjJws0xL0nPPgFEC6Pz3Izfa0jdFtB5qNKDFynWA07iVISERP6Rav3ati2ESoLdUTC80SbZ/uw6fgZEZv40Wln+eulsff/C/62CAmK4s25Z989guDnctg14CZg2+qX93BMCrYFQ6DLwvIlFCqGWBYVWADEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788162894; c=relaxed/relaxed;
	bh=d85H49jI1quBgxYs+PQ2R3ebCcg9h4JyI/UtxSGskms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2aa6fP1MPGnltrTMLeAdcof+ma+sIwjK7/BgYxnzu7mw3K4GR/xKlGQCmJcEWjzr0kRayD4NxA87L/rsAjfjDyhSRb5s5hFK8ruqvDQejhHDzH/+dCyw6FNuZGS96AtXX7Fn8A7o+WkiFXCATl0Yxf6hV05RHjNdVPbGvu6Zbb8WjgYtkeYucCHxOkYIJXNsL5sJ7d6Whk1CUyf2U1+c0iF4mZCADTQ5NQUk96RKWiyHNznKdutDa3sLGy8aE3sc6kaNC0g41LwUivZiZqPHMNenMxrxxCd6z11k07xirMPa+JJJTiVPUxVlKnUJyTyVA7mjWKxedhXIOhisDcnYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=XTR9VwWp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=XTR9VwWp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYLqx34gLz2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 17:54:53 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so3268080a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788162891; x=1788767691; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d85H49jI1quBgxYs+PQ2R3ebCcg9h4JyI/UtxSGskms=;
        b=XTR9VwWpGHaF2oTYcMx6fH9iImc8vN72Hz0UME2aHBzQtJ/pvOJso0IJNQga6GoIFP
         g7GRRbuiiMHhjWpDzkBNijrT0RrQWMvuDMbtATm6xHQcoc5Av+vRNzE4FYWgbftqHeck
         tQZ3HfufPApcWl2zRNCH4orkK7tigOHqvi//Bw2EEXur7yJMJGNkr15r7CJVzMwxHha+
         dIZr8M56wVFwxQME6FtouijPx+pLi1D9ZXS/8X+5oEQzFN+2zj4uAWNkcneaSVj3oV8W
         xFJXgwg1/kcDTSz7/cS7c83SgA/g6AiQUVkKiZ5j160/Co9thXzSk1dlsUr6IlfUVxO2
         fT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788162891; x=1788767691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d85H49jI1quBgxYs+PQ2R3ebCcg9h4JyI/UtxSGskms=;
        b=mFA4/UuPPb/9hflRqoxHLFExYNgyNnQ8JiGkSlFvvjOblP1sHMPLtlpNZP7jYiqIKZ
         JE4bHizYOOZCtcZLZFUDWmQPAn6VVh/KpMCqnJLu8I+xN4d5xFSpPMz/NjiAmKe2ZV7s
         6FjiJxgE07aIxLBvihj91Cl55/zw1gKBiXzghs8ACg+lLdB2TSvzhISU0JOVoQR9+POY
         VSL6DbpnvUP2Qzgk31vv+f3tkRom35BZa5BOsK5kIwvXTwaW41Vl6vQQwtQjiHO1+qHv
         cR0LJ5z6AU9xS/PTv9CM6adUkEm/MgDM2+V6bLBlFeVhpruXam+YXsXWkKTzsEfxm5uH
         pczw==
X-Forwarded-Encrypted: i=1; AHgh+RqYQgfmXV3YllQpduotjImAsFprM9uOT04zktIWA31gIBe7JlL6MZrsUx1YmkkgyR2L3X3zJPP9NjF5zso=@lists.ozlabs.org
X-Gm-Message-State: AFuF++moGpzWGBGyzEuocRV0orsEjzuzy/lUFEk9TL/+wmDVL38DgpiW
	/GUBElMeNmdQ1AFWbAJcSLMQhr7xiQgzXwIOzaQyX+6VXqM8q3rxC2cyDcnI/jLR8I0=
X-Gm-Gg: AR+sD13i524pQDLmL6nhWEHJt85wx5w2zC9Ac3d39LtD0kmDEKrupi/l/Iq4Giu8Q7F
	Q/+OaZ8iyVsg8BvLz4qfbHN1D4DRGTZfz6zqcpRo8UcFhjr+5ZTgS+d90F/zpQ+0GWe1fkB23gV
	KwBRTgBq+ZC8pLj/mvrzRlU1P1cgKi+L9/RE2651R7/0YKtyuKbxneVxfM4cOJ738AL9a0gkV7E
	8HVI5g6bniYByfqGz4bJ6dRQX/vBMB13LnBrUIeMV9CqNSodCtIlxzJ02t/t4GjT38HCGolkQpi
	O0aYuA+LcazvyVp8B9CC5oxOQEqO0expYcDoBvI/BDHW969UJV+hfSVLQ0DecwLbq8+IWLNkh5F
	2ZuLkNevrSpqW83/9/2LqVsTlCEzSpYtIKX8ZPnYchF1Dhn4K/xftvE71i1PbH+mIgjQ25jICP5
	wt6+AwxG0pNhyP3U02lThnxieZik5tVq+vxKPWd61Kmeh2vrFPLx0Rjd0LIqaTt4xwOPiNZqa2U
	swaIeubXP3RNnzWrKOKG2FU
X-Received: by 2002:a05:6300:220d:b0:3cc:faf3:331a with SMTP id adf61e73a8af0-3d2686aa479mr43643171637.10.1788162891372;
        Mon, 31 Aug 2026 00:54:51 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f330f88csm3590256a12.10.2026.08.31.00.54.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 00:54:50 -0700 (PDT)
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
Subject: [PATCH 05/11] mm/sparse-vmemmap: set section order for device DAX
Date: Mon, 31 Aug 2026 15:53:36 +0800
Message-ID: <20260831075342.57563-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831075342.57563-1-songmuchun@bytedance.com>
References: <20260831075342.57563-1-songmuchun@bytedance.com>
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

Device DAX can use vmemmap optimization only when a full section is
populated with a compound-page geometry. Record that geometry in the
section order before populating the section, so later vmemmap accounting
and population decisions can use the section state directly.

Clear the section order when the section becomes empty again. Also reject
partial additions to a section that already has optimized vmemmap mappings,
because a section cannot safely mix optimized and ordinary vmemmap layouts.

Partial additions continue to use ordinary vmemmap population, so they do
not save vmemmap memory. Such additions are uncommon, and the lost saving
is negligible.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/mm_init.c        | 13 ++++---------
 mm/sparse-vmemmap.c | 16 ++++++++++++----
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 33ff95141adb..c4cd61978ce8 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1042,16 +1042,11 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
  * of an altmap. See vmemmap_populate_compound_pages().
  */
 static inline unsigned long compound_nr_pages(unsigned long pfn,
-					      struct vmem_altmap *altmap,
 					      struct dev_pagemap *pgmap)
 {
-	/*
-	 * If DAX memory is hot-plugged into an unoccupied subsection
-	 * of an early section, the unoptimized boot memmap is reused.
-	 * See section_activate().
-	 */
-	if (early_section(__pfn_to_section(pfn)) ||
-	    !vmemmap_can_optimize(altmap, pgmap))
+	const struct mem_section *ms = __pfn_to_section(pfn);
+
+	if (!section_vmemmap_optimizable(ms))
 		return pgmap_vmemmap_nr(pgmap);
 
 	return VMEMMAP_RESERVE_NR * (PAGE_SIZE / sizeof(struct page));
@@ -1121,7 +1116,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(pfn, altmap, pgmap));
+				     compound_nr_pages(pfn, pgmap));
 	}
 
 	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 54ae8c284324..aed1e7429daa 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -135,14 +135,14 @@ int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages
 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	const struct mem_section *ms = __pfn_to_section(pfn);
-	const int order = pgmap ? pgmap->vmemmap_shift : section_order(ms);
+	const int order = section_order(ms);
 	const int vmemmap_pages = pgmap ? VMEMMAP_RESERVE_NR : VMEMMAP_OPTIMIZATION_PAGES;
 	const unsigned long pages_per_compound = 1UL << order;
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION));
 	VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
 
-	if (!vmemmap_can_optimize(altmap, pgmap) && !section_vmemmap_optimizable(ms))
+	if (!section_vmemmap_optimizable(ms))
 		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
 
 	if (order < PFN_SECTION_SHIFT) {
@@ -573,7 +573,7 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
-	if (vmemmap_can_optimize(altmap, pgmap))
+	if (pgmap && section_vmemmap_optimizable(__pfn_to_section(pfn)))
 		r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
 	else
 		r = vmemmap_populate(start, end, nid, altmap);
@@ -792,8 +792,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	else if (memmap)
 		free_map_bootmem(memmap);
 
-	if (empty)
+	if (empty) {
 		ms->section_mem_map = (unsigned long)NULL;
+		section_set_order(ms, 0);
+	}
 }
 
 static struct page * __meminit section_activate(int nid, unsigned long pfn,
@@ -803,8 +805,13 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	struct mem_section *ms = __pfn_to_section(pfn);
 	struct mem_section_usage *usage = NULL;
 	struct page *memmap;
+	unsigned int order;
 	int rc;
 
+	order = vmemmap_can_optimize(altmap, pgmap) ? pgmap->vmemmap_shift : 0;
+	if (nr_pages < PAGES_PER_SECTION && section_order(ms))
+		return ERR_PTR(-ENOTSUPP);
+
 	if (!ms->usage) {
 		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
 		if (!usage)
@@ -830,6 +837,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	if (nr_pages < PAGES_PER_SECTION && early_section(ms))
 		return pfn_to_page(pfn);
 
+	section_set_order_range(pfn, nr_pages, order);
 	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
 	if (!memmap) {
 		section_deactivate(pfn, nr_pages, altmap, pgmap);
-- 
2.54.0


