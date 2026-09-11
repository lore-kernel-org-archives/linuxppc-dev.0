Return-Path: <linuxppc-dev+bounces-27095-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B55C88E41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 05:04:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2Wg4C86z2yxL;
	Fri, 11 Sep 2026 15:03:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789103039;
	cv=none; b=AI8lqidVkdiBIupwZD3Snefih+iRr2YDwmYmxSkwCUI2PoAYzj7DvwtWEr16UrWouI1Xscx56MKz/dctnyPMYnRRuAp2RkptwKNKSaHMLk1CCrgKY9DR6j4t1Evf0gOpF+8flsUDr9/GKHE3IqAhSArQr/IcEW/GoyIHBXmPFh3ZRWprsf9TCb9bOOpyUKbMtAcXLnz8cSVQ4C4bGt9Sm7d2UbJ5IcmK7gOaeSgYCQRhy+mA/NHMUDOKXOYHgayc6aN8N7SN8EuvWaY5qEysB74MFbSwCo7/vOR5Dy1vAZgpYUsxdwSLaJ5o0yyPcaqXdk7tVxv4e9BOSaEwqGrscg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789103039; c=relaxed/relaxed;
	bh=6sM9zpfll+quDztLFFF0jfXeRCau4il9IJzrgeT16pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZM2tVdEem/1s1/tixHZunqO9Q47Rei9ikGTHIM5VTKbXMv1QSfXLYVkRvzMMuYLruMg6EQLxLS0PZrH+lhepBEUkyrmAo9NApv43QQJ0wt00lhIqhnNd7/owIyGEEM2uELRQMvYq3+jxNqraPiqkoBn7A/KuVhfqbiTNXT6UBM9L1vS3ErnWOPb1yarTFfasP6b34vfqRhGWXnNpZThcmjQsTAg14URYH+WG8B/W2xK6ThLiozPd5FeydQkYEMDVIAJM1CKR8Te2HCiBJjz33tNKUia1kqzxB+AHpo7RgyXEtDxMOqb6Y7lPizxI8rAHr0FhYQ1pb8wPrCHS3DD9qA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gcQts1Bd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gcQts1Bd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2Wf3sNqz2yps
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:03:58 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so462912a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 22:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789103036; x=1789707836; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6sM9zpfll+quDztLFFF0jfXeRCau4il9IJzrgeT16pM=;
        b=gcQts1Bd7IXgj+8haOLBfCOl7aiaYLdIbmfyRS7l62lvA23ej9oU3POwdP2OPPzEMf
         /6SJUBYLk/qXrcX24MCzS7Yb5c0KDTFPZeVWdr4fvivJQDjBsz2lL74heA6Ep6BhJfvo
         QiB5zQYpaN0UOg57Gm+ApZLb/UQkbvpEj5k4iP+vbsQlnYio4Qc7Pi0vcbut00XAYwLM
         9SkGG7nYMrZthdWIls5LT3mTT75is8c8yKV1Y/73qUi5SzmmI+5It86zPcsSMrWY/vQf
         5ZOD7d+5Nd4er6zKI42d/psnv/joPm2zvtKR+y+QbbhII/DhGGQENai1/b8Q9fUmtVgj
         5LkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103036; x=1789707836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6sM9zpfll+quDztLFFF0jfXeRCau4il9IJzrgeT16pM=;
        b=mxKP9bq9Jd29uj9u608ZGvTLAf/rajjmJfSRr+Xv0CDi2rX88dmbm0qjElDBMNJYeV
         Nx7zE66/Uj/FwdyHjiDBHF2g+MNJhsx7459xDpFvuYGK/lgqjFunZLvflonTumuzSo2/
         aIFJVDKxsYjAMeZFxTt3+nSgiCS1JzLO3SdE14FWOtULJL4gKcvGxeZOwtOLBJzaUhx2
         yydMAVO9lCq6oqUkACvgnuGyk7vNM6IsE+90LvbDCKgYQBSpPXrqc+I43kdMqsw7PMjP
         FFQCiNCQiJ+wC1Ef0gG0mKDuyNeHearvPbXSvqWNTMYAFBc0IbcqrI7tf10zDzq2LnGX
         C/6g==
X-Forwarded-Encrypted: i=1; AKwUvBycShV+Pn/dEqBZec+O0SK/csAsjRL8ld/g5wN95pdW3j9dfXUmjN3O3g2SRv4uo0ljGCa0g1faX/3aMAY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kBzxk3N3tN/2L+2Pwri1vRuLyrdivRBQb6WSIWQSvV4MvbUhVe
	FUdNbIIAeAARUMnxh4GUnaLlEbV8WvoBkaHFi2aOulHLMqUBQCMK89TdEOEyX29sTN0=
X-Gm-Gg: AYBFou1jdLy5ODhrazPP88iSH1RFUAfRHROkANKf5lA7yDkQ51SfiNQtd6p+WZsxMfG
	s1EOt9B5KEQsL39nIgFNW0VRCEyh8MrfRdC2uZO7d9RiZX0LYx5KRCuEmvvwdXQf7VIvJonDw37
	VvS+dBm08LhR6WGKvZyx9uWSDUk8XDGm0iWzqtpI1gPxrXFy4ye8ee/VQ85XpaSuvbQ5kruYue2
	2hCd+STjjD0vq0Ycvje/gqlutsLGGTocEF8dOOIWQt4vghyEHWAe86YsXZdER13DKyjS2HS3lQq
	RCEfRvniDYgFwZzZ4UfmWNGBTe1snj05t5At/U95+mRKY8kbtGX++NjiStOglRjIs1wYSymOuy/
	ql2FJO2yLRi1lPO+Zyjgc5+SXrPLUwClTKZonLtpfk6tXm7lXSvEgdnsGP0hrkE2zBPaZPxUXG+
	y2uR40djshWU6I5H4v7kmNdEQS6Qx+3QFrcLAYmB/yBALHkTJpwKgzQ6BV08i3jLP4xUpfT6WS8
	L/WZn2BuIEwg+v0B/l3efdryagF4pOmNcfl
X-Received: by 2002:a17:90b:2b43:b0:398:a2a3:b631 with SMTP id 98e67ed59e1d1-39d9c21f8c9mr4085781a91.19.1789103031225;
        Thu, 10 Sep 2026 22:03:51 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b16sm2651561a91.14.2026.09.10.22.03.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 22:03:50 -0700 (PDT)
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
Subject: [PATCH v3 05/11] mm/sparse-vmemmap: set compound page order for device DAX
Date: Fri, 11 Sep 2026 13:02:22 +0800
Message-ID: <20260911050228.58884-6-songmuchun@bytedance.com>
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
---
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
index aa89c16f7fc7..02da1321197d 100644
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
+		section_set_compound_order(ms, 0);
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
+	if (nr_pages < PAGES_PER_SECTION && section_compound_order(ms))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (!ms->usage) {
 		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
 		if (!usage)
@@ -830,6 +837,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	if (nr_pages < PAGES_PER_SECTION && early_section(ms))
 		return pfn_to_page(pfn);
 
+	section_set_compound_order_range(pfn, nr_pages, order);
 	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
 	if (!memmap) {
 		section_deactivate(pfn, nr_pages, altmap, pgmap);
-- 
2.54.0


