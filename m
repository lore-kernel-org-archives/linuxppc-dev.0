Return-Path: <linuxppc-dev+bounces-19996-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B05F99340
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 07:19:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1SCP0P9Qz2ynv;
	Thu, 23 Apr 2026 17:19:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776928785;
	cv=none; b=RorDj15Zm3sH9C+mJzyksyy6s6ZiWkNLNkHY4Gd9AZqB0LPJXixRofie0DIxsdujJbjLlzU4xltswGF0TuHv5BWHRC5LdLNImNFXw9j+HwgqOw6vQh6Iqz+678eizotfsUIO68pVfeh7LAzZE55n7akRjS6qZGcmR9IMc+X5ju+ZUHFkUnw1jEJ+8Mgx8YzBd65rRji8cGVoRGrRl+GeoBtEbwgpgHO8HxSCT055MSsU+6myJ5aKEQQ4SCXbHf3112GSMiIzE8UoV7hDlIX4kKvRzdzr4r1RaQfhqS1/Hlcb8LuKJEzznNcbVc48LhBBRWIBq8qMAT3lJIQ+HvyDaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776928785; c=relaxed/relaxed;
	bh=hLTLnoewwRhtugCkWIDfQqYKu4KougM+msAio3RkTvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K8lyp7iHnZlVskdmrJNVXCeyRKwYrtQxorpjcfmOfm8+diAI3If7JNroGv/3lI0YIeZZ3lq92fE2gE2BOwVK2QJCvTsl8jxGhIS5UHbC/PMwo1fULlL1yGYWlDBUwQLasosSzOv9uH25gxlNlnY7Y8MaoDuUQRIzzKtB7ulbSAlrTVhtUNbVoQA3hOx4BJHSAw5tk4kDc6OoLyVvUu43g3kXECFYZMVEjpHT3W9FZfIyGarES0FZ27to3j7aPI6FQT30TGTsvBU/vF03QY454XdzqSfWxMGH527nb+bZKFYZOWkIHb14mJHRwqjAwa+wnPzsewVXLoShCcYi6f3vcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PCdJFU8G; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PCdJFU8G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1SCN2YZzz2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 17:19:44 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-35da8d037a5so3061982a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 00:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776928782; x=1777533582; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLTLnoewwRhtugCkWIDfQqYKu4KougM+msAio3RkTvg=;
        b=PCdJFU8GYnRX3B/ITbJPQXYK44gO3umGt2ygeBDvr5H9cIC9fDX2zNNSZA/WT7f3i/
         eEC6GbZ6ZzHROzIUunN4agbcF0QZkSN0Z1aCti7cGRxiMm+JYSvM3YpjZWcrYKsEYFkx
         FRUJ7d9v5PyOzUyKlWwQfuDPkpvkp81bxmAqQoiN8+bIdn5LU4spl8BoMDOB3ea+7PgE
         zdyeSJdulWbQ9lTSec4PvV97V3V7WaCYzKDzq7H5Wf02IawgSBedYFf3EkZfs7Zslito
         5IFrTketkXEnVWA4Dy1o8VFl/9OiqkS7eiH6lAnvOFRYLKpMLBXApXD/zI0+kVVk/VVn
         0fVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776928782; x=1777533582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLTLnoewwRhtugCkWIDfQqYKu4KougM+msAio3RkTvg=;
        b=myoxACu/nMcn9wsAbTSqwd5BpoRdRGFtxybf1jfuX0p5osmy8/FNP7Pbr2OApM9GlS
         3fRYh4ytseeMLHfGc2syLFim6Sg9gGpDBMUjAds1LghdwdIOgG4hBwP/iIEul9FaHB++
         9/hXn2hNYR45bisCjYItOIEFHiUsjSiP+RTxsIs3Agrn/nDYxW/TzI6FHP/iAfTH6QqR
         w4ExQl2S0bWLXdAktiHEA/MhBQP34EjeVZS+M4uD3ToHV2knIQ8n9wgqu+WFUsy0jS9V
         KtroLp6jd9phFK8NjnK36rhGbXnGAY3shPy4DVmqTvqlZtWdNfs0hIgjchjnRcX9tW/0
         Fpfw==
X-Forwarded-Encrypted: i=1; AFNElJ+yPpKI8sjQwVFRJTuBGtZ2/+43oYGfcp8VFDanlmxH3gVN9fqtEj+irgkSScwMvdAXjgM7vB1FjRBaIAw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyfoWh/wbSl4Tkw2H8b9jaaor6vFk10DQ5nQYN2tsihPa/aZD1Q
	0mvAYN+Y+v1kBZmwfgj5UTcKZMSo7UEZ2oXsQO1CyehHp3Mtkn8NG3RgtGBvVub9mTk=
X-Gm-Gg: AeBDietIMc22dWNC2aGgUo5zbintQlfUSQdd2YFnEM2XrJY5syZX2OKCZSRqHKpErr7
	6QvdKb0RyznttBK7GPOL2PEK5dm9vub7mVDNnhNiEILfPvMbvwQvIqbPkN27JiU9BXr7xczn5qJ
	mb92yunYDI+mgSwYepUNe00p72cm1PnPlbfH/ZQpT4c0gIVRd14kC8jIYfv/0K4LHtke4tazQ6q
	Yxao3MvG0V3OCnyp2QrvMbr33GG9Kpy0s9e6E1pUygmIcOQiJTzaH6UskDHjLqloU2B8jPvTj3N
	ALbHwC7cLnRtAOaXOzCK27RytX1doLMmRlGnfxzgGt0nFFg3WOdTjPqImYZr81f2+45M1H8MnAQ
	wwzqtUFftVOLwanBM6wjBNmHAmfyoIXTgC4glQEpV2tmxWjkmOlLLFN2hxaP4dJLpW1YyqxPigu
	ok6FEmCurWZ/LFsfhSnDurv0rImZ8vQ4SuBjNHYp2tGUdtyxiH24l+mA==
X-Received: by 2002:a17:90b:1d8a:b0:35f:b4c1:91f6 with SMTP id 98e67ed59e1d1-361403f2807mr27201547a91.10.1776928782107;
        Thu, 23 Apr 2026 00:19:42 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fbd970fsm7092372a91.14.2026.04.23.00.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 00:19:41 -0700 (PDT)
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
Subject: [PATCH v5 v5 4/6] mm/sparse-vmemmap: Fix DAX vmemmap accounting with optimization
Date: Thu, 23 Apr 2026 15:19:09 +0800
Message-Id: <20260423071911.1962859-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260423071911.1962859-1-songmuchun@bytedance.com>
References: <20260423071911.1962859-1-songmuchun@bytedance.com>
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
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
 mm/sparse-vmemmap.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 3340f6d30b01..979d71158c9b 100644
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
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_compound));
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
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


