Return-Path: <linuxppc-dev+bounces-27463-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB67C88E5C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 06:44:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl8WC2rDCz2yjw;
	Wed, 16 Sep 2026 16:44:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789541063;
	cv=none; b=eB4iKfnHyNN0OwjIBgd1WXZlOe1DaDM2mwDP3U9V7zqBagUKoLTb1KEAbLH17dzhDyAH/9li3WZmRlXy8Yy/3i2yZxh75Gf56iOzZsozmOEDJClrP2efFB+dFcYt2V5DxMa363r04iK/H5JwbIkXblFVKdfoAT9NpCgA8G41oy+8tvM1qqZECK/2DquYguED0TIVr9pWFxVZ0h5KXl+K9OxDQaTPqGenZu1apg8Sefz+mnwTi6ndoxeW357Qav8fxW+EfEX1RtHJtyk9W7cYhMf2p2KmNdfbyOa/l/1xVkwP5bO+Wo6vYxpa+PZIYUcs64ECdDoQFuYXEFALnI8XAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789541063; c=relaxed/relaxed;
	bh=b1EqIpH0CyAwdpMqjXcOe7F5BCJx4eubUzqhI5rvq2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejx/IblsOnNKUXpSdex8xRQhzruYpojGddugdojGiPX08ox5fiTc7kwOxrc6Tw04tUBC5YZhqjJRP6y1mWDtrpgzlJ9+Ezv4DnUJ5KqMemYu9WhDPGhNNOtnnHWNZ7p3FfMt1fyT2dXBNTYuKoxRbTM59H9VFRxXr6gw/a4VREpOmtmIdy7l6fraPmMU3GbLALXJFuSPdXcXUIVVRwpNpBXYjGgtYvY57Og0s0kL7UEOTd/ZD6i6a5pqrFMiF/9JhcI4nvse0Aokho59xdnya7SSIwgd8CmzqytCxAPkgF9EBGqzNdkIgCp7n9d+79BKFNTmWdNrOyXrBLTni2Veug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Cr4pCLUq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Cr4pCLUq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl8WB4kG0z2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:44:22 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2db18fe459dso3567105ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 23:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789541060; x=1790145860; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1EqIpH0CyAwdpMqjXcOe7F5BCJx4eubUzqhI5rvq2s=;
        b=Cr4pCLUqLPhq5lbzh2Ve3G8zeFAFkTZ3U04Q+xmw9hJi0RPks6x8hLIXWJF+fpGlNl
         GWrYsp3uMH8qclWKDpoXsx7uHrhWCGmTcobGaPqeysoSjctMPZNRIN4kL1tD/2uWbSHL
         PDUsX1XLx+/4kNUJ1n4tw5lySOfHOeXDzKcMt51NXb/kcMdUW++CbdKSs01xsCj+faJv
         4CrgCoEYiWbmL3NcoRAdnEh+jg9Hctz/9hFoTRT89NJ57dQEH9hD3Y2jX6blX+X/p2hU
         TkU/ckqc5yuiIQLczYW71cr15WM/fqEvUkzjZtEMqLgheU0iAXq6dzIeRiFroIqYczFa
         Ag2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541060; x=1790145860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b1EqIpH0CyAwdpMqjXcOe7F5BCJx4eubUzqhI5rvq2s=;
        b=ydkkGPlj1UvjwfdcYuaiJxn6/plyEiViX3mg8pOlWPvIawoS9+Br6Q6B64+fPcZqDA
         RAIrpE+EC6RixNCZwc5eyfKuWJptHDEWi8sAgOct4sIu/yARLS05ecgrzJ0sybj2/hlo
         hX1AZPtYRmXsy+WbX4nTMhX32J8vMRYk6T1EEvb87tMpwp/e59k2X/yBLlgIVxmapH0R
         JpV90A8M9RsC0UZfy8b/9xjeAkNrjRywNrZ4d7cgdb1mZ+u1iMtd7oukIAde7/hxU1dX
         tWxNrBOuppFcuy23IXYYJXTzbdpveNArZr7+Ug93+MNhO3DE7zKa0BSv6msuYbEmS1bD
         8kag==
X-Forwarded-Encrypted: i=1; AKwUvBxMNUiYnhvlb18FJM4VzbGP4BMgfKNtjS/zf+Vz08N1zEyo6pmbqR0neff9hBWfMpsW891GIlGSgx/EM4U=@lists.ozlabs.org
X-Gm-Message-State: AFuF++naLxs8Bc4+48ru+wM8wi0iafKV6F5tMNBC36Xucdl9EDwm76hU
	2w4RpCOfw9iBmZt/qUg2jlev1YnLO3TBjfT6lk+1bE1NPp2vgicFtVg+1PoDPOlU/u8=
X-Gm-Gg: AYBFou14Xg84vZJXQ7/QVXenRKpiKvLCfHrDcC5C6Deja+d9w4rm66xThDuvzcVHijY
	ugFsxD2dGLrTSJLcTxiWYcxt6lNuwcpiO/0tIEc5WPqVVDTcasrACPPIkVrOOxaO9wQTYSlLEOQ
	k39ZW74pLY22SdbcAe2+CEPAxhebGQWsJtYm8aa40X5XqsnLJzRsU8/BIi9y+eXmIYDGjcxE+rX
	lR9AUoK/xiP7EjXVu59DQoFYwHqn6tHaZaB8JagHHXojJWQc5UuMMts8Me2pm7iRVzPWlWxNNF6
	AwRG3uSsEfrH95ReFw6eIsZY9z75FNkLAuUm1X5NW1dpS70jQzJDG668XxEc+pdfmyYkH5yfqpf
	LYfIWDDE7erv3ZqpT2fnqLuMAnl3Sdslt6+xVBS7Hd9B/oA/Um2pVhijEBL0/yuem/CdSkfnS7H
	cixc7NMh1ad7h9kSMUwXzmH39BLa+HcfbcZ/KFvr/rzsYPcAKXEhd5fpGQ4dyWhNO/k4CVLNOoP
	0Kg8zTPfzNGm4kBobWJ
X-Received: by 2002:a17:902:c401:b0:2dc:fcfc:bdeb with SMTP id d9443c01a7336-2dd8e76f78dmr28974185ad.22.1789541060351;
        Tue, 15 Sep 2026 23:44:20 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f0592asm6074755ad.62.2026.09.15.23.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:44:19 -0700 (PDT)
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
Subject: [PATCH v4 06/11] mm/sparse-vmemmap: switch device DAX to shared tail vmemmap pages
Date: Wed, 16 Sep 2026 14:43:36 +0800
Message-ID: <20260916064341.1825793-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916064341.1825793-1-songmuchun@bytedance.com>
References: <20260916064341.1825793-1-songmuchun@bytedance.com>
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

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
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
 include/linux/mmzone.h | 10 +++++++++
 mm/memory_hotplug.c    |  6 ++++--
 mm/sparse-vmemmap.c    | 47 ++++++++++++++----------------------------
 3 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 97147c764658..ebbda6f31139 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2149,11 +2149,21 @@ static inline int online_device_section(const struct mem_section *section)
 
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
index 02da1321197d..7b5b9ceec697 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -193,6 +193,8 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 		set_page_node(page, zone_to_nid(zone));
 		set_page_zone(page, zone_idx(zone));
 		prep_compound_tail(page, NULL, order);
+		if (zone_is_zone_device(zone))
+			__SetPageReserved(page);
 	}
 
 	page = virt_to_page(addr);
@@ -490,23 +492,6 @@ static bool __meminit reuse_compound_section(unsigned long start_pfn,
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
@@ -516,21 +501,18 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	pte_t *pte;
 	int rc;
 	unsigned long flags = VMEMMAP_POPULATE_DAX;
+	struct page *page;
+	unsigned int order = pfn_to_section_compound_order(start_pfn);
 
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
 
@@ -546,12 +528,12 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
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
@@ -883,13 +865,14 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	if (IS_ERR(memmap))
 		return PTR_ERR(memmap);
 
+	ms = __nr_to_section(section_nr);
 	/*
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
2.54.0


