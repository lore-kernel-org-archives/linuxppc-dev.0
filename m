Return-Path: <linuxppc-dev+bounces-28567-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0004CA5FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 14:08:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvxhz2sFmz30TL;
	Thu, 01 Oct 2026 00:08:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790777299;
	cv=none; b=XQ3CSGNwVbq0Ngh2PUfzTTclYVb6vK/s3NeIR5ll+Wkr+HfAQyq0erMrXIhRpmdU9Mub6sBYJPFHydeieMZKZ9TSAKoiGu24XhLcz7asQiivWLTz6oiGgXgVhm9pBhcHZ8HOkZ57khM4MFZIrhxCl278s0FwkHnfC0PGhvV+9NRTKBe6Tff7ksenKby0bI/MA88jM0UQrw3dkt+E0fI5xNnYpUkyUht0d/t/z1JkTsrp3VgLRqiquQ8ylhji3FaSOHz+c0Cnci1CXb3fUgQjPb6dh+UYW1KzofIrDoUKADo/cqW/+qU2s+OCz/cn4htuA3OgATPjt3THhEM3JNzIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790777299; c=relaxed/relaxed;
	bh=mwIkzvmvri0jNuEZQ8eiZ6f7IsoamN6cu2j85HlYjLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iouD+/a8EGtTqfbOizZlGbHvem3Uikq5W3G2NAI/sYoKrbn3xs1n7ocdTgSrBJEhqtU/eIEZVziKkJDIJv5gEPugZp6cCfiKn1wCdtHR8JnkyIJOZg/rUIW1UQY4LaKwd0RDcZQ53uDq0qVZ8wTV44DJQX/pM97OrkagEFMTZ27XdIBuZyzgjpxSWK9x5MkR6xfa5YwB81Gd7Bgas7ROR/GDDxykPAGAgYBmeM0rJLPxW+2Bp4gCA5NJlV3YPwOJie20lvVsz2kmnfHfUGpoykuqPVxdI7VlskiSWbI5ML94q4vcAKT5QbEG1PhpWdLRaATMJeMUECYLyMTHLJee0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=NgqZPfJe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::e; helo=mail-pj2-x0e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=NgqZPfJe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::e; helo=mail-pj2-x0e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0e.google.com (mail-pj2-x0e.google.com [IPv6:2607:f8b0:4864:39::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvxhx5q8pz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:08:17 +1000 (AEST)
Received: by mail-pj2-x0e.google.com with SMTP id 98e67ed59e1d1-396ccda24afso2790774a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 07:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790777296; x=1791382096; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mwIkzvmvri0jNuEZQ8eiZ6f7IsoamN6cu2j85HlYjLQ=;
        b=NgqZPfJehRF93LdxY3Sx7TmjEca/UUj/BrfIfuEHZVCqWiZy875RX2oIQrZgsToUuj
         7TiFGMtNgkOvywee/9nIZc18K/l9owzeCBb7gzJ/79cYGUmMMiQqzWDpXFKIZAR5bKJX
         vMAZYFtBxYBswqaE7ztsBqHq+6jCV2GX483d7dUni8Ma84oQwuxn+o3IhyCjaLZ2gqrO
         NOTDNINxpKTkf0VDZ3qQTqajkeJwBzZbcDFDDIS4xEz/mpaQKxvw1/+BG+LbN8WulgeK
         omyFBTa4Co4Dgr0ppMAC8Z8dAw8mNZoBG+t8xUF9qLO+92cxGw+lePggakqTB07WxGKz
         1T4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777296; x=1791382096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mwIkzvmvri0jNuEZQ8eiZ6f7IsoamN6cu2j85HlYjLQ=;
        b=GSkLA27MmI1Yqxo3M8zEBL5RhxayfrzNapp375LPEMtbJTFWB/h0ZlvQqfhQBBTTna
         /G0vDNVc4aluXaSQtAu5ZYb9fx92dTyOVNKgdgx5N1ybHDMSPt0tuhh+8NkCV2yE7WXt
         toWF5DohUkVXLKKRYXWI2mf0PEXkXQ6zdT+fhL4KI3vku6P144SZD71wuhP/OeYjBtIQ
         HoWzFy4IpPJefGydGooepvz9Cvp3pQ1kRKjvVphXN+KFBp6NnXjDV5g3pBjAJHnpI1p0
         N6jyyO0pKyeNp0Ng02hcM/51HM9EiuIXUMxfbOFgNoWdQLzsNho+znWkELx/1ywpNXKY
         A0DA==
X-Forwarded-Encrypted: i=1; AKwUvBxokww0NZ+ulttY6IAQ85j8aoEokyoXW/l7TV4vlvebVRtlSXQ3q6FayWQYbMX5SZp4IOt9lTW32pFL5ck=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLP8aKKyy1l40q1d/I8wxx6Vc8OY2VPInrDBkWLAVIjPuh5rMo7
	C09KdQfpt1lxnXwAlzE37Wt+8MOCx9GlAOm9CEBwQK0Gyy8hdcCWMdEgZDu4UapK3A0=
X-Gm-Gg: AYBFou3ETW+gETeAw8Wv6zb0Rc4k3oOOq/zgIucXaVXf2KMBTtlkd5xSFHacXkI+eem
	42GMmy4wP2IsErzN/o39C6DvjphpNaBljM4TirMQXG6DjkQ9KRDFgIzrw6OqdllkL9dwueU8p9U
	JvOb0cAZKcWSmzw4d5sbX8LkYBgR5VVYU+X0i/zt9iDvrc3vmAqrfuFGuOuz1pY17rpoc4fKo87
	GDym39BDIxyy1eHZFXF41Qq17+VMSZvZk9gjznUocZLLtqH+uZg36Nz4Go6EiN9hVm0gW1146//
	1PXYVIOAh4eWcQF7pEj7NMfjeeo3l+z/XOlz76Q5zGNzet/bWB43pAXYzlz/rkgOVkguetNR+CL
	oKQIzqFsW16FLXcW3hdlsju5S2E4w+PTKSyC8x1iJXf/3PuEK36MN8QsMSE+JXDaCTf32hpWAVP
	a6yYNs04l8sc9ScxIhAi6YRd1nkBeLex0U0rBIM8lvnYa8GOXuBFdqoiNRjxp7nJWbm7Q1Fvpf4
	wdEoddfrvcjgA==
X-Received: by 2002:a17:90b:4b11:b0:3a0:d79d:b6bf with SMTP id 98e67ed59e1d1-3a4d14de36bmr642331a91.20.1790777295537;
        Wed, 30 Sep 2026 07:08:15 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4e60ea12csm639509a91.1.2026.09.30.07.08.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 07:08:14 -0700 (PDT)
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
Subject: [PATCH v6 07/12] mm/sparse-vmemmap: switch device DAX to shared tail vmemmap pages
Date: Wed, 30 Sep 2026 22:06:22 +0800
Message-ID: <20260930140627.57431-8-songmuchun@bytedance.com>
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

HugeTLB vmemmap optimization now uses per-zone shared tail vmemmap pages.
Device DAX has not been switched to that mechanism yet.

Switch device DAX to vmemmap_shared_tail_page() as well. This aligns DAX
with HugeTLB by using the common per-zone shared tail vmemmap page.

The optimization is enabled only for DEV-DAX through pgmap->vmemmap_shift,
which supplies the compound page order recorded in section metadata before
vmemmap population. Unlike FS-DAX, DEV-DAX does not modify tail struct
pages, so sharing them is safe.

Since the shared tail page can now back ZONE_DEVICE vmemmap mappings,
initialize its entries with PG_reserved for device zones. Also skip
poisoning vmemmap-optimizable sections while their struct pages may be
shared.

Each PTE mapping the shared device DAX tail page takes a page reference.
A sufficiently large range could therefore cycle the reference count back
to zero if population were allowed to continue after it became
non-positive. Use try_get_page() so further mappings fail at that point.
The section population error path tears down mappings created for the
failed section, while the warning makes this currently impractical limit
visible.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v6:
- Prevent shared DAX tail-page refcount overflow with try_get_page()
  (suggested by Andrew Morton)
- Make order const and move it to the top of the function (suggested by
  David Hildenbrand)
- Clarify why optimized tail pages must not be poisoned (suggested by
  David Hildenbrand)

v3:
- Move device_zone() after the definition of NODE_DATA() to fix
  non-NUMA builds.
- Update the commit message to describe the compound page order stored
  in section metadata
- Collect Acked-by from Qi Zheng

v2:
- Explain why sharing tail vmemmap pages is safe for DEV-DAX
  (suggested by Qi Zheng)
---
 include/linux/mmzone.h | 10 +++++++
 mm/memory_hotplug.c    |  6 ++--
 mm/sparse-vmemmap.c    | 63 +++++++++++++++++-------------------------
 3 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ee9cbaaa63f4..cd68c1904c91 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2143,11 +2143,21 @@ static inline int online_device_section(const struct mem_section *section)
 
 	return section && ((section->section_mem_map & flags) == flags);
 }
+
+static inline struct zone *device_zone(int nid)
+{
+	return &NODE_DATA(nid)->node_zones[ZONE_DEVICE];
+}
 #else
 static inline int online_device_section(const struct mem_section *section)
 {
 	return 0;
 }
+
+static inline struct zone *device_zone(int nid)
+{
+	return NULL;
+}
 #endif
 
 static inline int online_section_nr(unsigned long nr)
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b428da66d279..d7a59167bec4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -43,6 +43,7 @@
 #include "mm_init.h"
 #include "page_alloc.h"
 #include "shuffle.h"
+#include "sparse.h"
 
 enum {
 	MEMMAP_ON_MEMORY_DISABLE = 0,
@@ -554,8 +555,9 @@ void remove_pfn_range_from_zone(struct zone *zone,
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
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 26be355aaa37..d40a2f5b5fca 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -225,6 +225,8 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 		set_page_node(page, zone_to_nid(zone));
 		set_page_zone(page, zone_idx(zone));
 		prep_compound_tail(page, NULL, order);
+		if (zone_is_zone_device(zone))
+			__SetPageReserved(page);
 	}
 
 	page = virt_to_page(addr);
@@ -288,14 +290,18 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 			/*
 			 * When a PTE/PMD entry is freed from the init_mm
 			 * there's a free_pages() call to this page allocated
-			 * above. Thus this get_page() is paired with the
+			 * above. Thus this try_get_page() is paired with the
 			 * put_page_testzero() on the freeing path.
 			 * This can only called by certain ZONE_DEVICE path,
 			 * and through vmemmap_populate_compound_pages() when
 			 * slab is available.
+			 *
+			 * Use try_get_page() to prevent the shared page refcount
+			 * from overflowing.
 			 */
-			if (flags & VMEMMAP_POPULATE_DAX)
-				get_page(pfn_to_page(ptpfn));
+			if ((flags & VMEMMAP_POPULATE_DAX) &&
+			    !try_get_page(pfn_to_page(ptpfn)))
+				return NULL;
 		}
 		entry = pfn_pte(ptpfn, PAGE_KERNEL);
 		set_pte_at(&init_mm, addr, pte, entry);
@@ -529,47 +535,27 @@ static bool __meminit reuse_compound_section(unsigned long start_pfn,
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
 static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 						     unsigned long start,
 						     unsigned long end, int node,
 						     struct dev_pagemap *pgmap)
 {
 	const unsigned long flags = VMEMMAP_POPULATE_DAX;
+	const unsigned int order = pfn_to_section_compound_order(start_pfn);
 	unsigned long size, addr;
 	pte_t *pte;
+	struct page *page;
 	int rc;
 
-	if (reuse_compound_section(start_pfn, pgmap)) {
-		pte = compound_section_tail_page(start);
-		if (!pte)
-			return -ENOMEM;
+	page = vmemmap_shared_tail_page(order, device_zone(node));
+	if (!page)
+		return -ENOMEM;
 
-		/*
-		 * Reuse the page that was populated in the prior iteration
-		 * with just tail struct pages.
-		 */
+	if (reuse_compound_section(start_pfn, pgmap))
 		return vmemmap_populate_range(start, end, node, NULL,
-					      pte_pfn(ptep_get(pte)), flags);
-	}
+					      page_to_pfn(page), flags);
 
-	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
+	size = min(end - start, (1UL << order) * sizeof(struct page));
 	for (addr = start; addr < end; addr += size) {
 		unsigned long next, last = addr + size;
 
@@ -585,12 +571,12 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 			return -ENOMEM;
 
 		/*
-		 * Reuse the previous page for the rest of tail pages
+		 * Reuse the shared page for the rest of tail pages
 		 * See layout diagram in Documentation/mm/vmemmap_dedup.rst
 		 */
 		next += PAGE_SIZE;
 		rc = vmemmap_populate_range(next, last, node, NULL,
-					    pte_pfn(ptep_get(pte)), flags);
+					    page_to_pfn(page), flags);
 		if (rc)
 			return -ENOMEM;
 	}
@@ -922,13 +908,16 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	if (IS_ERR(memmap))
 		return PTR_ERR(memmap);
 
+	ms = __nr_to_section(section_nr);
 	/*
-	 * Poison uninitialized struct pages in order to catch invalid flags
-	 * combinations.
+	 * Poison uninitialized struct pages to catch invalid flag combinations.
+	 *
+	 * Tail struct pages in a vmemmap-optimized section are initialized and
+	 * shared during vmemmap population, so they must not be overwritten here.
 	 */
-	page_init_poison(memmap, sizeof(struct page) * nr_pages);
+	if (!section_vmemmap_optimizable(ms))
+		page_init_poison(memmap, sizeof(struct page) * nr_pages);
 
-	ms = __nr_to_section(section_nr);
 	__section_mark_present(ms, section_nr);
 
 	/* Align memmap to section boundary in the subsection case */
-- 
2.54.0


