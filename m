Return-Path: <linuxppc-dev+bounces-28566-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A800ACA5FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 14:08:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvxhp2mqqz30Qv;
	Thu, 01 Oct 2026 00:08:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::2a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790777290;
	cv=none; b=bykLbu1OA2G+PFknv3Lh6tOaeIvtlGrSbf+5Ga7WGuS71hRvn/FXU6abiaR1Lb2Gyu1Flo9Ro9ueb8GWj2vocFNJV1pyZyqx4jqzH6bi95/6KxPdB5juCxAgX26TKZ1h31r9ZyipylcNs7uxhMZU9ltfy8m0DCMfNJntmOTTpBDOWEivneIrJl1suhNJ0jaG0UvnpjHcJVnFGoKp2a79WeLg/67HgJ1IIrlst8OR7cZy8X+5FoCSsAcPFeNrpnI7MkmmMJYE09aNr7IUTBxMq1meoiCNwzykXE+mHhpEgmPXqzzsn7EtIKtiiSI0nSNcBNkkWwABJTIBPoy3JCIqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790777290; c=relaxed/relaxed;
	bh=u02WzeDH0Bf7WSzC/uPCm2Q+d5VUN+9hTC8v7YtK7B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmynRNJ6m2lTnnitdEccwZnROBAUfmX9xWj6e3RMyTkh3JjijC0j7EC4/TAuKkc3MedfTPllUq33zAyxgk++bHf/RywuqlumloYeFK4roozaZmA7P63gmw4zrMJGJGQO4+lr4c3Ow+Pb+2JKyi/V1DtO90DI5HFRKrOosz5GPUQ0FnLdAguqsCcxQ9j5HLwEzlJyPvvRdJI1SQwDj59gTFc+uEi8BXOiclkIGmhmKNYdpTXSmX3omrqQ7pwrenNQ7MutQHRR1o8qoLBW5dyFlCDSEOxYmA5DaaoewnSKFO3m8y013m2VbJ5KzDvny9ejEEAdL0MSKIdnPI7QID3Fhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Kmi0vflU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::2a; helo=mail-pj2-x2a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Kmi0vflU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::2a; helo=mail-pj2-x2a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x2a.google.com (mail-pj2-x2a.google.com [IPv6:2607:f8b0:4864:39::2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvxhn4cPGz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:08:09 +1000 (AEST)
Received: by mail-pj2-x2a.google.com with SMTP id 98e67ed59e1d1-3a4e9fbcc60so81433a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 07:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790777288; x=1791382088; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u02WzeDH0Bf7WSzC/uPCm2Q+d5VUN+9hTC8v7YtK7B0=;
        b=Kmi0vflUzTMSPGSI8vyeP6jPzyDQXCxbFXEsR4l1PVYPTnzaVHcHbOko9jR9fbm9F+
         ks1b4NueagVVCMgYugm6hB4lWjf1evO9Th5XFcWF7Wk+yVxeWRFw/hZruIpEb4mKJxGw
         my9d1oCtI7mQk7kHnkRwjZWSMRikL8WbXtoM/ptNmRy/7s4QXH78wSkprBHbCpTQrTli
         92q/yeH903wNwIt8FFinrhIJQzrg+rjgq4IbXcgZ4GGH6nYJs1WA9c6CjBDRfbFn0n4H
         lwvPMSr4y8hz4gU6nyb44vh7v+hgzXjhbMQNXCGMlRVrB72UfUKu0nuZwvQ+pzLB9YyZ
         yGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777288; x=1791382088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u02WzeDH0Bf7WSzC/uPCm2Q+d5VUN+9hTC8v7YtK7B0=;
        b=YNXoMSINrYJZw3v1EAphQkv/A3IUJOaG7Ic3Kl5kGqE7mD6RpaN9bI67cIorKXwWmh
         zqCzn3Nbzr8y5+8NinCPzctrsya93PQDesG66YNWPL/cAKcPr+veyax295z2ETIiMUFM
         RqK6IZML2gIrGNsD5dNpeBOopZ+YNBJx0N02iUWL48dA7IOW0iu8kvcV3Qd/LoG2LbDc
         R6A43YbOKHaiBTjdwH7iGb4JCj946fCdAC5WFmhKJxMJDGacR02MukVjhl4CA2g5sWii
         +0gbacaD4fZ3OvOE+QDKRs4hc1FZ3OLtGXuEu/oeh1FJVwisB/rL5Po4Zt/755csYyYa
         uGTA==
X-Forwarded-Encrypted: i=1; AKwUvBzlUGS4FA2sEL5uhuM624JkwP2EWzOPdaZ9oqaxD0UGqdNwqfc+8lG7V3op3nv52U3S+hWdjkQuHpniGpA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLeNR3Kyh+mx6frj7ok8ztQXU9ogu2bKZHaUP73rkX/5UJDeqE0
	sw9U0jutfEd2oMQdPHfIBGxa8QVnnaaxHEBeJjFmKTgkfF+rUh0lU8WwbE3IUXzYevI=
X-Gm-Gg: AYBFou1QS1x/uxrbmmZ/3IjYkiur6eNf0G5EsTIQSHvStVRBhUQ4/JeJnwa8Dl2CAKW
	QPc1Ss6faA+u+Y8r2SyTbTDmhl/RIFAV7eyz9ekWRQYZcwAKkDa17vajfXB6IEvFQ8v70CJE87j
	LZDNX+tjxAlm2JHzfUEcadEsdB3ai12pXkFw6kJxPrIbU4Tzl68/UPeKx1ujIN01nUtPdD1zQvx
	L/d29UTY65q60vMDr2tQqcqYVyBBhXhA5BXeR/xQUFkKmqXSIwW0JnufPcNiuOmeeZa8Ywz4Ztz
	wBwbcQtKyXh2vfYwxW4MZbLxb66egg56qx58WdHRRkDC0dly3vjqPg8iPoMbZloJIIkFIk2o+h5
	FytWZjkqdLMfZZDQlOHf7yKUq+3rG/R4tRa0jFX08wTm98TPQS4DadIjYabfoM6+SWjd4s8viH/
	vl76sBWj50Plz21sPFNrg6U+OgbA0PsVKNzrnDYUjHX510+BVnPvOyG9oo55OvLyfVR4dwhEVQR
	mOG50K6ECsa+A==
X-Received: by 2002:a17:90b:35cc:b0:3a4:9656:413 with SMTP id 98e67ed59e1d1-3a4d1795eefmr1315479a91.41.1790777287518;
        Wed, 30 Sep 2026 07:08:07 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4e60ea12csm639509a91.1.2026.09.30.07.07.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 07:08:06 -0700 (PDT)
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
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v6 06/12] mm/sparse-vmemmap: set compound page order for device DAX
Date: Wed, 30 Sep 2026 22:06:21 +0800
Message-ID: <20260930140627.57431-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930140627.57431-1-songmuchun@bytedance.com>
References: <20260930140627.57431-1-songmuchun@bytedance.com>
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
populated with a compound-page geometry. Record that geometry as the
compound page order in section metadata before populating the section, so
later vmemmap accounting and population decisions can use the section state
directly.

Clear the compound page order when the section becomes empty again. Also
reject partial additions to a section that already has optimized vmemmap
mappings. compound_nr_pages() determines how many struct pages to
initialize with a section as the smallest granularity. A section therefore
cannot safely mix optimized and ordinary vmemmap layouts.

Partial additions continue to use ordinary vmemmap population, so they do
not save vmemmap memory. Such additions are uncommon, and the lost saving
is negligible.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
v6:
- Collect Acked-by from David Hildenbrand

v3:
- Update the subject and commit message to use compound page order
  terminology
- Use EOPNOTSUPP instead of ENOTSUPP

v2:
- Explain why optimized and ordinary layouts cannot share a section
  (suggested by Qi Zheng)
- Collect Acked-by from Qi Zheng
---
 mm/mm_init.c        | 15 +++++----------
 mm/sparse-vmemmap.c | 16 ++++++++++++----
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 97e0158d2aca..efffa8609b85 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1049,16 +1049,11 @@ static void zone_device_page_init_from_template(struct page *page,
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
@@ -1144,7 +1139,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	memcpy(&template, page, sizeof(*page));
 	if (pfns_per_compound != 1)
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(pfn, altmap, pgmap));
+				     compound_nr_pages(pfn, pgmap));
 	pfn += pfns_per_compound;
 
 	/* Initialize the remaining head pages from template. */
@@ -1160,7 +1155,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(pfn, altmap, pgmap));
+				     compound_nr_pages(pfn, pgmap));
 	}
 
 	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index b4b72f233bf6..26be355aaa37 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -135,14 +135,14 @@ int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages
 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	const struct mem_section *ms = __pfn_to_section(pfn);
-	const int order = pgmap ? pgmap->vmemmap_shift : section_compound_order(ms);
+	const int order = section_compound_order(ms);
 	const int vmemmap_pages = pgmap ? VMEMMAP_RESERVE_NR : VMEMMAP_OPTIMIZATION_PAGES;
 	const unsigned long pages_per_compound = 1UL << order;
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION));
 	VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
 
-	if (!vmemmap_can_optimize(altmap, pgmap) && !section_vmemmap_optimizable(ms))
+	if (!section_vmemmap_optimizable(ms))
 		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
 
 	if (order < PFN_SECTION_SHIFT) {
@@ -612,7 +612,7 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
-	if (vmemmap_can_optimize(altmap, pgmap))
+	if (pgmap && section_vmemmap_optimizable(__pfn_to_section(pfn)))
 		r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
 	else
 		r = vmemmap_populate(start, end, nid, altmap);
@@ -831,8 +831,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	else if (memmap)
 		free_map_bootmem(memmap);
 
-	if (empty)
+	if (empty) {
 		ms->section_mem_map = (unsigned long)NULL;
+		section_set_compound_order(ms, 0);
+	}
 }
 
 static struct page * __meminit section_activate(int nid, unsigned long pfn,
@@ -842,8 +844,13 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	struct mem_section *ms = __pfn_to_section(pfn);
 	struct mem_section_usage *usage = NULL;
 	struct page *memmap;
+	unsigned int order;
 	int rc;
 
+	order = vmemmap_can_optimize(altmap, pgmap) ? pgmap->vmemmap_shift : 0;
+	if (nr_pages < PAGES_PER_SECTION && section_compound_order(ms))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (!ms->usage) {
 		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
 		if (!usage)
@@ -869,6 +876,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	if (nr_pages < PAGES_PER_SECTION && early_section(ms))
 		return pfn_to_page(pfn);
 
+	section_set_compound_order_range(pfn, nr_pages, order);
 	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
 	if (!memmap) {
 		section_deactivate(pfn, nr_pages, altmap, pgmap);
-- 
2.54.0


