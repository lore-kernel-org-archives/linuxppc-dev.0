Return-Path: <linuxppc-dev+bounces-20030-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05574F589DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 02:56:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1yJz4nvLz2xZK;
	Fri, 24 Apr 2026 12:56:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776999379;
	cv=none; b=TLEYDxlb2PXE460iX7jhpE2e+QDeZKumXxw20WPU2rBrHEjXBSPY+wEzRO6drVhvYkvaTzBa1CijbjoG6QkgFkitHHhnsuIoCYaX2TvsKNjabhbKorZ7gW7FKZg7QR/kuvBVWsHR+8v0v7+3gIV5qQgozsBtv24x/s6RetT2jjHJMjwYMTGhUI+LHd/ktOkDXjWoLbO6sqcX3JAh6uULEtW9keoi65qpB+00C0p2vjGrrQP/syZR41XdoapC+eUv5sH5np3JPlRXtMjNhmuihsNoYwQZM4UnuVEIyKYgRUtnQTy4i2MlQhh2f3br4L6Ogjdw7mvfqrx0TMwia2ijZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776999379; c=relaxed/relaxed;
	bh=C94hv/3Q9yeZJL9WguueLZ0Nxmqh1CO+hZjQa23mqmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j6mrvV7m29Qy2ufuASnYyPIVBnCULDWFAlK9hhD6BeImtZ93/fJORgD8kfaPiZl0rhDQ6dWZLQz0+z5cchRqtRb4P7hdw+VvnKJ1T24PoKI04aORWGLe1IAvPkSoAj8nylftNVcvuQ+X6sMVEkVsGPEjBDICzyjqd5m1RtZhWeRtBOPdrt309mLWsGR3b6vZ6GqwSz18NHqe/B7BoyH0ziGsO5EnonaC4Wbi+HdfU3/OGknWiXaRlNISFcd23MVSKd7Zz5+zyoh10qeEZrXGiHYKVkaQYvclfDU4PrHjhFmy2k/wVi17kycq2lK06hULQZamhFJIRjjehVx97JyZMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BVX6mawZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BVX6mawZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1yJy6svxz2xnl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 12:56:18 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso34587565ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 19:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776999377; x=1777604177; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C94hv/3Q9yeZJL9WguueLZ0Nxmqh1CO+hZjQa23mqmc=;
        b=BVX6mawZEZlGTbeI9Hhgn1cV7iQsI/cl8pqtDLqQJRH6yFKsHIonqIl1xz10XYOzrj
         Xuw9lzHWZeXqjpTfn0GZqApxwBCeWkPX6EzBAWAEBFyGuVwgV2dGT6e7rhaQFq/qhsNn
         gU9YL2ezVnSP0vTljTc0dhsNOK9T2iwSK72aYjvcOe8JjBqeSNBJxrN9HZ84HtHcJumo
         AmflyGl7gUShFaQ+q9qUFrDKs3bnD5gvpuxt3NZ1P9CZky0bl57RBgd9IS2HTPdvywTf
         fABpUHBalXIYdbsEuu7cRXC2ead6BP/4wfLPjmSZSIXygpgHIhEmdkKRgWy9Ht0GymO8
         MFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776999377; x=1777604177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C94hv/3Q9yeZJL9WguueLZ0Nxmqh1CO+hZjQa23mqmc=;
        b=OfbhJ38mbimkaq2L2odobft2d/XC/Ur4Zqa09+vsCDohlKw95KuT2YEzsL/pAf3w23
         aGRqrTp1ekCeWpmc9zgvA1k6B8885vbUMD8ouPT4NbZwwz82bznbO6qN5ezwCrLcgKKA
         P0MfU/w4jbPZUY2xfRc+Hb+N0/07HbU3dsmzB+gdyVJL8iTBElPzw+Q0FVhjAfcDdfdj
         o/rH5/AI4SyUNLmod62XCYKxaIpzDXCkF0/sX2QHu5UTw6/TloOdEoK5aNnzqi33WNqP
         EmLPZsdmz/qXROa2zn5tJBBqXxQ4mwBzwAgxNbECZUPKrDoqhONy9nl0xa7rr42qx5Zg
         XvPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Ecv7gS/sKbkj18cLoeIpC8i63EC+H/cenwB5wdot+EOL+tkkK7fs6EJR4yxoRTeRq5lF5z3vk6eiX6qg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxHPU3b2DerTGBa3vnlxREHr1E0uxZbdVhUhHshgsQjk6TamL+0
	7tTkh9Q9To9YTYNZliGy93m7MRV1No2f8ZEFKhvGTtsm/ukbEBiJ19tPIzz7HJIv6TE=
X-Gm-Gg: AeBDievFFPblVRseUvRfwK/BhriLuUBEKARKOqjrzhMt5c2NAcVh8sxk8U5GuZwCTNL
	4r++7vPFoU7VEl1WOji8rurwZgOCeD7cAkudAYn6g/0aqHI1hoHBMUMPOWxjXr4WWzOOek/Am5V
	DCXw2fzuD+3JelgFQWvR2nbfl6O3+6AuNFjvW9x+jagLwW62gCpLBYriXtii7uZJpF6oCKGp6JQ
	wLKzhbvvRF8pSRk+WqZRiZ1MrX5Rx8L41ObhghqtMEYJsBns0J2S1zEiqqNDung5udK4xxcV2nQ
	NIyOw7PIm8RjmQJVZQTgcVtqV460JbpZukxcfGuS3r5Dpl7FMz6niQxIjDnn2qtASJOt12VA5Xy
	kRqJqdCxONnv2iCpGVw2YFDKBIkxJaJpP2aUBqimghGnl4aNW8OdOpEelP5iFFzjnDehha2YvN7
	5zrLIWqTd7+TIpq49o6t6fJc8rxTaKlZzbh52pD6Aaj4xpFKAGcNBCeog=
X-Received: by 2002:a17:903:28f:b0:2b4:5309:2c14 with SMTP id d9443c01a7336-2b5f9f3ad64mr324239485ad.31.1776999376914;
        Thu, 23 Apr 2026 19:56:16 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20d33sm221668325ad.63.2026.04.23.19.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 19:56:16 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 4/7] mm/sparse-vmemmap: Fix DAX vmemmap accounting with optimization
Date: Fri, 24 Apr 2026 10:55:44 +0800
Message-Id: <20260424025547.3806072-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260424025547.3806072-1-songmuchun@bytedance.com>
References: <20260424025547.3806072-1-songmuchun@bytedance.com>
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

When vmemmap optimization is enabled for DAX, the nr_memmap_pages
counter in /proc/vmstat is incorrect. The current code always accounts
for the full, non-optimized vmemmap size, but vmemmap optimization
reduces the actual number of vmemmap pages by reusing tail pages. This
causes the system to overcount vmemmap usage, leading to inaccurate
page statistics in /proc/vmstat.

Fix this by introducing section_vmemmap_pages(), which returns the exact
vmemmap page count for a given pfn range based on whether optimization
is in effect.

Fixes: 15995a352474 ("mm: report per-page metadata information")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
 mm/sparse-vmemmap.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 3340f6d30b01..2e642c5ff3f2 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -652,6 +652,28 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 	}
 }
 
+static int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
+		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+{
+	const unsigned int order = pgmap ? pgmap->vmemmap_shift : 0;
+	const unsigned long pages_per_compound = 1UL << order;
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages,
+				    min(pages_per_compound, PAGES_PER_SECTION)));
+	VM_WARN_ON_ONCE(pfn_to_section_nr(pfn) != pfn_to_section_nr(pfn + nr_pages - 1));
+
+	if (!vmemmap_can_optimize(altmap, pgmap))
+		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
+
+	if (order < PFN_SECTION_SHIFT)
+		return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound;
+
+	if (IS_ALIGNED(pfn, pages_per_compound))
+		return VMEMMAP_RESERVE_NR;
+
+	return 0;
+}
+
 static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
@@ -659,7 +681,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
 						      pgmap);
 
-	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
+	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
 
 	return page;
 }
@@ -670,7 +692,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
+	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
 	vmemmap_free(start, end, altmap);
 }
 
@@ -678,9 +700,10 @@ static void free_map_bootmem(struct page *memmap)
 {
 	unsigned long start = (unsigned long)memmap;
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
+	unsigned long pfn = page_to_pfn(memmap);
 
-	memmap_boot_pages_add(-1L * (DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
-						  PAGE_SIZE)));
+	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
+							NULL, NULL));
 	vmemmap_free(start, end, NULL);
 }
 
-- 
2.20.1


