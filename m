Return-Path: <linuxppc-dev+bounces-28298-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581A9C98328
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 02:55:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hspvv27Vwz30Vn;
	Sun, 27 Sep 2026 12:55:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790477723;
	cv=none; b=DYbLPuuLymD+Ea5Iq3tLn7eUpCJzBJTqzUekGygVodyQJPvL0JA9VLYniRifHx9HcPV4YE/HJ6994fFv5e9T3aB0BSVZrT66Yhq6H7oh8AdRu4DioCFsmRK4LfL5+WLv7akfw7Dh3AMC7LGDtfpzSqTN2drja/gE6Cg7RFPpXGTPRldb172Y0B5VFGZ0xIGP35gu08N4u8/0B5CFlbyC6k6g0twE7sXO8/bUy/lf+RCYOaDkXV2N0uLy98MdX9TNazvIL2nCWIUDpfzAhhKID9vrwFeg+QCLVskdcGUsNCRtnMvWGR9ylOLJknjXw3o+VTueYCTkwnJSFo6DSRaWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790477723; c=relaxed/relaxed;
	bh=WBlSYhutFVpa615i7UF023108ER8B6ja1OjBI94hgy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=en/uydBgw7L+IHHNDK8pmU4S9wO3BeBZXg4p8W4/FS7Q3dchH9eAQR/Rd7kdBZXXte3vavbvXwO3cV/jdivOD48sYxblpsHhM23AwbuthlrFHjQ6BcOclyv/3mrGwh2+C6ztjR9KcPERupDU272d6ZYxLGT6hS4X/8J+D5hyckvxa+LDBQxoDIJ7YTrFkNChd44vGPebrdIbgJwMkP17TWMHcc6ka0vWinKG88v+yCZDm4YrHg9AdGirQLLXNxpyd0OCdL1u4JKKCYkVGi4m8w3OhgK0Ii66FhkRJlOE64gr8ux1Idf8Z1yV3eZc1EIE91xcd4EHoA2kC2mNBoeyow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=aSTX7XKb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::d; helo=mail-pj2-x0d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=aSTX7XKb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::d; helo=mail-pj2-x0d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0d.google.com (mail-pj2-x0d.google.com [IPv6:2607:f8b0:4864:39::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hspvt3RXSz30Vm
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 12:55:22 +1000 (AEST)
Received: by mail-pj2-x0d.google.com with SMTP id 98e67ed59e1d1-3a0bec20a6fso746231a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 19:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790477721; x=1791082521; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WBlSYhutFVpa615i7UF023108ER8B6ja1OjBI94hgy4=;
        b=aSTX7XKbjN3O8nT018joJg8cuAej0qlThmXrZ4CqaHKhVfzF7OSPSXv1O6/piCB0ma
         w+5allRyfX/+hd0xipLG3MSyeJ5SqSRe3F2hD17aWcNX3pz32hF0vDRr0bofb3UWthg3
         B5tVvW4l38jl13e9aK6Suef5CJXmYC6upKTP3NS7saMOttf/41Zknf5JbalVaOcZxjio
         RMXIzi7CQmoEb4v+5n/WbEXNI5tCWId6cytn0nXe3YSn0I9uMGfO9wKVxTrnL3bWlecw
         ObqsMvgE/wlBLvpGa+UAbsV3wZn4dIwKyIjyAl8Pcea05rnDjLCkHB6yBebJ7BqvFvj0
         SOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790477721; x=1791082521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WBlSYhutFVpa615i7UF023108ER8B6ja1OjBI94hgy4=;
        b=gMnC7xZ+VPcQotyUkRq28TJFlw6lpQjqUd4dTKA5GBpWByRqxsB8rxuRIAJCRBR6Jc
         iE/HbaqM71b4/tjY23m2Z2xLfIaWNQLU3qPSH5QX79wzqmfOs9S6SjlSEzjTk5GWZ5J+
         wX2sk6dLV/jluQwJQCiIDp2AAMt+/gQjswRqmYYLCPKOY+kgYxeHh3EDb8vZzXWn3YOi
         aTUICb6+QivjdXkfgoGMkzZeF9aDayOm3rpRG6Mvhn7rvnJt2RBEYq0W7akzrtv3L/m5
         uKXzUOUcNIXmVokN+Wrai91up/8Grx+07DSTmN0nl3QVnWsSysddcIfEkzWBEaDU9dkV
         p4Zw==
X-Forwarded-Encrypted: i=1; AKwUvBwr0HMD6mGvItvoNcKxkK/aju0lndNJuIf18/VPMf7C7G15P37JT3872DIk7HNcUBuAxmKxNSAsU8X0+Jg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYImvbAY4mJK2Py0/sKT16zNFMpy1Ytw9Hvpq1aIZJSXjbzkSgFe
	P5Fd8dYcPZFilvAEVfDzI5MCC/2qtQgimG3Ns5801grpvqnGv6OauwFhG3z2dX8Qsq4=
X-Gm-Gg: AYBFou0sMIUuyAB04L9rjahU6E8Fz88OvuQziukLNtb2FYrhjrSAZp1xa/LTB8n/XC+
	ofzYzAI617PYd1Ijg3a7+KJXD1bc4QMMHUsYKP6r8+mX8Mk/MPqqo8pFmUJu0suVuQffH9pis+w
	6h6civF2dYYtTZca64KJybdfrCPRun3RFZ//N0GFD6Cyf1L4dM6G7l3n0zrhj5OZZ5I8DZHIKid
	IoGUzTtpA6oIsVuCKhcj9qeu88jU9Gayon2+Wxc8/2S+JgwTu7F1xTLDP7/XEfO1IkIGgZu3J+5
	/qPdE5fg3ApiU91oua82Y/kx8wb9AHYRxpe8DNMfJc2NAGEzgrW9EEtc/Sqgg0txNGPrUWFt5cv
	FX2uhrDDiq6BPYiGUSEkJDHe0X6HpTIxQefeHfwrK33Mz2FhaqzFDH0Q2Cqf/OmWL2bN/oPhkTA
	//tpFjgWW/7/DzDVApfJJ98SY8rxF6lb9Edl4k5l1ftKH2RLWBxAaex/CKjnc7I5OT6SMFXAo3L
	6rFOJBid99g62OuqcR+
X-Received: by 2002:a17:90a:d64f:b0:3a0:e985:9ca2 with SMTP id 98e67ed59e1d1-3a0e985a241mr1295162a91.31.1790477720535;
        Sat, 26 Sep 2026 19:55:20 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm13461377a91.1.2026.09.26.19.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 19:55:20 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v5 06/12] mm/sparse-vmemmap: set compound page order for device DAX
Date: Sun, 27 Sep 2026 10:54:35 +0800
Message-ID: <20260927025441.741633-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260927025441.741633-1-songmuchun@bytedance.com>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
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
index 2457ea2c6dca..ca2470e96a74 100644
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
@@ -608,7 +608,7 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
-	if (vmemmap_can_optimize(altmap, pgmap))
+	if (pgmap && section_vmemmap_optimizable(__pfn_to_section(pfn)))
 		r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
 	else
 		r = vmemmap_populate(start, end, nid, altmap);
@@ -827,8 +827,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	else if (memmap)
 		free_map_bootmem(memmap);
 
-	if (empty)
+	if (empty) {
 		ms->section_mem_map = (unsigned long)NULL;
+		section_set_compound_order(ms, 0);
+	}
 }
 
 static struct page * __meminit section_activate(int nid, unsigned long pfn,
@@ -838,8 +840,13 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
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
@@ -865,6 +872,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	if (nr_pages < PAGES_PER_SECTION && early_section(ms))
 		return pfn_to_page(pfn);
 
+	section_set_compound_order_range(pfn, nr_pages, order);
 	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
 	if (!memmap) {
 		section_deactivate(pfn, nr_pages, altmap, pgmap);
-- 
2.54.0


