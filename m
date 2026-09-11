Return-Path: <linuxppc-dev+bounces-27094-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753DAC88E41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 05:04:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2Wg0XJCz2yqL;
	Fri, 11 Sep 2026 15:03:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789103039;
	cv=none; b=kxg+9q+oX/EiXJWYlQyp7AxRRyyzaOYMSxmKXur1bv4jGfYkUwtxWhGj19J7FegDrAIvBPPUMWAYtw8/zYi3gVmXyGhMS1zvdhNeW/nnHEX5wWrZlPwUmpPDIo+UR2khqwztRh0gHUZkMyUF//8m4bVMzELNAE2ZF0Ed/zbVLLmsZT1G0UmEQt5Q02DkrQMT9jqoIkJ7OC6UBtGZ/aHyfg2oMg9emOgcXJp2YTaNUZmsEHLAHR9vc6Z6K3pOlVy8XY6bber28E/T6Um/URCEEixqjXt+pZKZA0n779GO12ZF/801Ru7HUVyUpd6yqWhIfCGmkp+tbgmyiuxyeJxLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789103039; c=relaxed/relaxed;
	bh=4SoYJ7WMuU/pqlbOJzY7F/meqClQuD0NoJ+12TnNHPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqUgbkjN4V2MN69x4S7ONmQfS35+ewogFw+JQAjR5zoWS2sPd2b4+g5VvC3znIdHkWeMf/+64WzckbICMgg9PlgVijsP74EAdO6mNzwlDBxG+VxTgKCqPvst/bGaVolx+UvSCZQxwdDbEsc3/9PEShrCtfTm/yI37UlMTOolj3AssJo7WHGR1v3oqZvt1PjQfxbVGiqoCWXA+aI8hOv1sYV39I+sKJmCyI31g5/XijCky3VZ3f3Vfegack2aUpiVA00e5Eo1EwX6I1nJdytccwcOjOmx9Gnq6gqqA9qLxh+zWXgGWP+j6fSb/F4n7sAiQTUpSpIFezIi5PMQsXa1aA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=T7QA/r2h; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=T7QA/r2h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2Wf1Shsz2ypW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:03:58 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so462913a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 22:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789103036; x=1789707836; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4SoYJ7WMuU/pqlbOJzY7F/meqClQuD0NoJ+12TnNHPs=;
        b=T7QA/r2hZtuye9sk3uw4eQmIvg0WA829hsr76fHd7d+9JTz+2HgXB+O7OdfVSVczKz
         uypR0d2OIWNmk4rEIVmGRMnH/ozQ0Fp28KxCEB4gd83egyOqpjMmK+DfuT3iMkukg869
         7wrf6kd4xHNk3D8/t9zL7NhIrqNuv+SvOcfuLCuWavkgw3KXbPlLkrPd9L3mBLP9o2U2
         zXZFKY9fl+i61bnJ6cWaOGjWdSe+st9vJriU8M3TFPjkmUSlmEpL0eBRdl24MiGQMGf9
         ujhL4C8OoYD4IHHXQp+IgrtmjP0MrzCb30ACVZtEDIs7CeyYtMIHYvVNgvSDCL21sYOb
         mAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103036; x=1789707836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4SoYJ7WMuU/pqlbOJzY7F/meqClQuD0NoJ+12TnNHPs=;
        b=T5fRp7SzXQXfaZpx2YS7WtprJvtVJCFHmn/lojBV/T6zANBSVwOtaRJGkgL1MTJ5jY
         /tE90ZAiYh/06gFm7HsFSzVIfabCErmWhOIJukZu3gKAEq29Izh+NGSmiLWP7IcRvY4S
         AkFta3u7A2RerCV6cY3oIuHM7zhN9gV91owCkF85VFjV6a6SL8Vz1NtObwJedaXzJhDE
         KTIscMxvUd+Tj21oGC7hbJYiaLmUNn1g6TbvMiq4iMlNtZLBr5fkmKzdNBEKJ3qXFEPb
         nNSxe7vkttuakNh+2W50uhyrcpwyOqrCv0UyCOdGg75mEAiIuZL6tqXm7gMU7L58lN1x
         leQw==
X-Forwarded-Encrypted: i=1; AKwUvBxyPtxwtxeJHMNXFcZz/XA9CZ0UWesUnCNWza/6IeMxENr6Jycxex9DmCk9L0NO4JG5c6S1pq8X4EiLcg0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++musf/sdVHnWgxsSAbcttOhMEmJp6jg9zOLnR+6mSO9fm9dF6fl
	BuajHPjyPlEHc3i09hhHdMQCILq2S2tDHzhzpiLAK3PIifdspVx8QjWLAYO4jEPNg5c=
X-Gm-Gg: AYBFou3XesnGc8k4ARn+Lngkku1xx3lNJvlfa+4GnNmBU6VmGc+ehwUEhvMjpOoft6S
	dE2/mKMLqlmZPrGYExK0qUHNGSAsxam5x3ePqezioBJA6oEMNNdFwE6J7W2BnW6BCVukj6DvVlc
	JTPIisnepF2mD14oBSlLmJBfiuy4RZ17uvlZOP++155ExDKTgzEVpm8ZGgtgnGJ+kgUGdTGBM6V
	Bnkyt9GYo/ksGRG1bNctlRWALsUQszAOZJW0oPpQIw4xIrcORF2S6N0FlJY2012RIeEcvBY28Ah
	wmq0BTnCGJ8m3Mm74sedgUJbGWcNoQDPzbA39Y5nOXXSgOVpn807mNTPXBL/V9nVQ1jeUkkI8He
	qoZRJdlQbNSZ67eiKBOuSv1M/qoqNFZrgANSc2Quf53qWXzFEzhB//hwDvbKGirK6eIbgAmx2wQ
	5ifhdJNXNT5vusw4W88f3OhAzJ69gPgUeqv4GZQ9sKLI/Upa6nzRQH/xnoQWp9QiwlrwqgW2ge2
	t1zTiReypJzk2ArPL7qTGTOX7HaD5b4n9Hh
X-Received: by 2002:a17:90b:2b50:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-39d9c1c199dmr3979201a91.14.1789103036192;
        Thu, 10 Sep 2026 22:03:56 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b16sm2651561a91.14.2026.09.10.22.03.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 22:03:55 -0700 (PDT)
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
Subject: [PATCH v3 06/11] mm/sparse-vmemmap: switch device DAX to shared tail vmemmap pages
Date: Fri, 11 Sep 2026 13:02:23 +0800
Message-ID: <20260911050228.58884-7-songmuchun@bytedance.com>
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
index 1a18c1c40c8c..f8a2d823f7de 100644
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


