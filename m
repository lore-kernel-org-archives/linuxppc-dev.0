Return-Path: <linuxppc-dev+bounces-20900-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26507CD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:21:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvHT4tFTz2ySN;
	Wed, 13 May 2026 23:21:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678485;
	cv=none; b=WAFHdCcCiYsyGonf/n+aH9hBEQWJUghiZDUKU79TKLz1DP6eY+en+OUsI/boPFnzE0MSjPUicmDlaanHENSAmmNdMGHRIucIDa3KM06KOYc5A6xEKVYYVdq0TJJAr+ULSA01GkxpkO6SbY8j7TfN8x5b/xXw3EzN5/AyLzx2kNKeyXCm6OpmOAGACYGvNqyQXaGgD9xhpg7453fAN3K7vV77sIQd6QcWpD3lhON90vkvqf46sBMdPel1AgPJv3Ss0k2WwiXQqG407TjrjI8+Zbo3eu2M5tJomCbx/ec0WxHGEMpEBN618aegSpbV9kS9bGdn+K9bVxU9vRduVvX8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678485; c=relaxed/relaxed;
	bh=awvhCSRpADYIDd9yqdYnymlqYSzgggMn8w5U+iOMJHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGNpBK2xM0gfo+4+nflEC6f/FT0VaACiETJwCw9kh+/gvR0vHnR2p8rZ+zM90P3CviAl8m01AQGswElca1p5wpH1ZK1FId5eWyuYrNtOlZup++utMzRj3DqVpIbXQy+qI8Ih0K9AheD2jk/YsfUlQ11oZF032wn07Qacc+A6YH0VgCBp82Y49EodwQafEfXBLJaHGcMigOiZtVH7PdVSdBOgGzksp5wkq3QgkPTlMpVJYRBgDrM9HYAXXTghjXaHXY7Kn34l+iZcPGiIQWuCJdOq5M9TOLEdKxmjVmeNhb8MWsKO1iWdsL/L0YZFJm3pQpNci5QHJZU7fL7QEby01Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=h0pyfIJd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=h0pyfIJd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvHT0J4Qz2yTP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:21:24 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-367cbac9cb1so4526775a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678483; x=1779283283; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awvhCSRpADYIDd9yqdYnymlqYSzgggMn8w5U+iOMJHM=;
        b=h0pyfIJds6c8G9jgC1OMMyPewngPErHeiORA3EZy1SH3xBvrsMta4d9Cit/F/Z8BTf
         Ru7vfcqFWGfrjHYyapvcVcinIeDs23XsZg8EaK9OVv3O/90KoJAVPRTSCmAtgUrwuByU
         TRYjciAs49fH5Qtqw2paKPtO4zAsRN1teEyfmb2+fg0CgZ0iRxFIqJmx9w9eW8qioFwH
         eiXje7+jjNrN4Wi2lvY1ibFcr0Hr6vkBdKrxyfgt1N7Yu5TNA1yn8I/r4Rz3YzDRa7fp
         6YwyzL0VOGC8D1MtJWuKo1xqj2BJg98WmZbg4oky2OS5Y2POrYXOq71+OzsXonQwKZ4p
         3S2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678483; x=1779283283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=awvhCSRpADYIDd9yqdYnymlqYSzgggMn8w5U+iOMJHM=;
        b=aGHY9KsLqKnIbxJ/KNaXWmJUmxCK/HDMHH6K40BL3ZWDdKCZxEDQo31SIlXTssvCKE
         9jH7+x+HRIOJAuScjaMvJ60rQ44/J5qSbPcAOMtlmlC3/3Vo01co5wV5fzoJEX8oP+ya
         djTroUjX8y+OAJ/XwHvHj3VPcWDYtMQ3Ppu0JXrJlHhwD4bPfsIfMu+1sEZuC8GLnDjq
         Jhmaje70C0/4JxwZvML1+HT896hOby2qtPaD4sit+96d9nNaZ3yXoVqUxbhuUYos595V
         X0GiVmEP01FPhYluynrNJ0Db/aSR/HUby/7pKcjXsgJqeCkSZJt9LGKvQDQR313rYpWF
         d7nA==
X-Forwarded-Encrypted: i=1; AFNElJ/eyokiH2ZfEuRhdy71IKnt0z3ZrWMSzBSUqtWHSJ3pK74eeRbzMx2OVAUInc/MvvX3Pfb8Y88FbjbxwIc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyni8tl6OfGCSHA/F0F4abRtQPup8nesfRtYMUtj8WGlmMdTphU
	NlzY72EXFm1oU/VeZwj2uEhhkdxhgXtwh0b/sw0yg9/mCinPR7uYTOhSp1uRfn0dy9Q=
X-Gm-Gg: Acq92OFv28BhF17RLXjhEaaj000dMBUzWqDpM5gAvn8ZdRPkjVYzBC8PK1QxeG+9/EZ
	WWdTdCRC3Tl07L7cDk1gJt2vWfidzDcrcy4YWf22hpXuLoV8LizxDNqf7vlF72L2fFD/z5+r4s0
	nGkslZlNVDOMve4JkkNDkzREEpAelgUPVBWb2RlaaKVq6bERgxQ8sf9YEhEoBAv2vgcB+evhyLy
	IB9xSpi0BUlSlsbwo1l5iG4K8+DCfb41tIBVpUUlUjSLjg7oGFu6vUOnW93K4nMLo79Hu4zRz6p
	xRoXZmVXV/itPmM4j2EsuEuSH6bpNr5YW/0rtYFQzgd5Ali2Qp+VTlxuccXB0eYmXW2E4AzVAWc
	bG2jEshb4jy9BfSXdAN+coEVB/zAXUo2p1zD4zirzEkA9gNfKigojxc2PQ+oDWy8CjjMcF1P5JN
	EvancO/AYyKrdws5TG7VYa0ZI7PNtY73wDVxh61NqCec8ne9DAbj9g6DlVE7Iv
X-Received: by 2002:a17:90b:2ccb:b0:367:db13:aca6 with SMTP id 98e67ed59e1d1-368f7a26e42mr3016818a91.26.1778678482924;
        Wed, 13 May 2026 06:21:22 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.21.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:21:22 -0700 (PDT)
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
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 51/69] mm/sparse-vmemmap: Introduce vmemmap_nr_struct_pages()
Date: Wed, 13 May 2026 21:20:16 +0800
Message-ID: <20260513132044.41690-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513132044.41690-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513132044.41690-1-songmuchun@bytedance.com>
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

compound_nr_pages() exposes sparse vmemmap optimization details to the
core memory initialization code.

Introduce vmemmap_nr_struct_pages() to report how many struct pages are
actually allocated and need initialization for an optimized vmemmap
mapping. This gives memmap_init_zone_device() the information it needs
without depending on sparse-vmemmap internals.

With this helper in place, drop compound_nr_pages() and keep the
vmemmap-specific logic inside sparse-vmemmap code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/internal.h | 11 ++++++++++-
 mm/mm_init.c  | 21 +--------------------
 mm/sparse.c   | 13 ++++++-------
 3 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 06022074ebcb..9597a703bc73 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -997,7 +997,16 @@ static inline void __section_mark_present(struct mem_section *ms,
 	ms->section_mem_map |= SECTION_MARKED_PRESENT;
 }
 
-int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages);
+int vmemmap_nr_struct_pages(unsigned long pfn, unsigned long nr_pages);
+
+static inline int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages)
+{
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION));
+	VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
+
+	return DIV_ROUND_UP(vmemmap_nr_struct_pages(pfn, nr_pages) * sizeof(struct page),
+			    PAGE_SIZE);
+}
 #else
 static inline void sparse_memblocks_present(void) {}
 static inline void sparse_init(void) {}
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 9ff118e35641..4ea39392993b 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1062,25 +1062,6 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	}
 }
 
-/*
- * With compound page geometry and when struct pages are stored in ram most
- * tail pages are reused. Consequently, the amount of unique struct pages to
- * initialize is a lot smaller that the total amount of struct pages being
- * mapped. This is a paired / mild layering violation with explicit knowledge
- * of how the sparse_vmemmap internals handle compound pages in the lack
- * of an altmap.
- */
-static inline unsigned long compound_nr_pages(unsigned long pfn,
-					      struct dev_pagemap *pgmap)
-{
-	const struct mem_section *ms = __pfn_to_section(pfn);
-
-	if (!section_vmemmap_optimizable(ms))
-		return pgmap_vmemmap_nr(pgmap);
-
-	return VMEMMAP_RESERVE_NR * (PAGE_SIZE / sizeof(struct page));
-}
-
 static void __ref memmap_init_compound(struct page *head,
 				       unsigned long head_pfn,
 				       unsigned long zone_idx, int nid,
@@ -1145,7 +1126,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(pfn, pgmap));
+				     vmemmap_nr_struct_pages(pfn, pfns_per_compound));
 	}
 
 	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE, false, false);
diff --git a/mm/sparse.c b/mm/sparse.c
index 3390cb82f114..f314b9babc4a 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -237,26 +237,25 @@ void __weak __meminit vmemmap_populate_print_last(void)
 {
 }
 
-int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages)
+int __meminit vmemmap_nr_struct_pages(unsigned long pfn, unsigned long nr_pages)
 {
 	const unsigned int order = pfn_to_section_order(pfn);
 	const unsigned long pages_per_compound = 1UL << order;
 
-	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION));
-	VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
-
 	if (!order_vmemmap_optimizable(order))
-		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
+		return nr_pages;
 
 	if (order < PFN_SECTION_SHIFT) {
 		VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_compound));
-		return OPTIMIZED_FOLIO_VMEMMAP_PAGES * nr_pages / pages_per_compound;
+		return OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES * nr_pages / pages_per_compound;
 	}
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
+	/* Ensure the requested range does not cross a compound page boundary. */
+	VM_WARN_ON_ONCE((pfn % pages_per_compound) + nr_pages > pages_per_compound);
 
 	if (IS_ALIGNED(pfn, pages_per_compound))
-		return OPTIMIZED_FOLIO_VMEMMAP_PAGES;
+		return OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES;
 
 	return 0;
 }
-- 
2.54.0


