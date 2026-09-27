Return-Path: <linuxppc-dev+bounces-28299-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A7FC9832A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 02:55:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hspvz5Sb9z3bk0;
	Sun, 27 Sep 2026 12:55:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790477727;
	cv=none; b=olHNL4rgpGuI/S4V+MFueSmM4aFjARU7gkh3NFL25hHnKmfIeHMlBw3aD72/31JFEw3s/TeO2wpNtzfPy6D15RmALXh3ik/B66BY1YywSKn7I9OmbY/t/2n8ml6sWBbYPy/fkQeoOdlDlGh7ozEurrWSJSMTz6KUDVvciJsl0LKF2GF7DzFiKxomdzkdbfUgCfSBUc7FH2gEfz1MZxcJ+Y1FVa6KYlQZOIIU/7Un5IGDnmVE3HLCT3+ecwpOpl8eqTYEfy6sr+e49eV0iXW6JBKfWdpeFBl7qy2WCHpCNLe43d6N7cui4+w1+dQMS/cckGR5DodPOCiWP0ld71xEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790477727; c=relaxed/relaxed;
	bh=eDg0B4GTZoaBgeAm1Zuaxbe7/C+fLySFm30qNgbQ5Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBLb7IbfFVWqMNyaPWvL2sz9A32zF6zS6R7/+LMDiEwqHG8Dw9p1pvcp5fJKhu1+tl0LVC+h2L+ZjOxpeyM0869K8O/6md+6Ge36MxsNr1AbNIV/oItAeatS0oN3wSRN+HiDFECCsxhRMBaIXa6EtdDhGop3I4lUwle4CRxnMqkiSk+Ru62PXJKxriaxAOux9IhPQ5v/ovlw5reW6PVZ6XkSYJXc/+vcYFwx0iWmQIZFKn7RN1eAioKPaOVFe/GU2KCX/KVJxCIX3vzkvFtz+5zoPoY0LFmKvYQQv48b//bGuB1pZnD9QNg9gJeGAHU5NcI7bECPrdhDYtr7AHMvdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VsK8mW2H; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VsK8mW2H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hspvz0TGBz30Vm
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 12:55:27 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-396ccc02279so1161317a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 19:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790477725; x=1791082525; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eDg0B4GTZoaBgeAm1Zuaxbe7/C+fLySFm30qNgbQ5Ns=;
        b=VsK8mW2HWD28P7YEn66ez6ZOabVG3BUwkgCgeDLxM4Bp5qSS/TG5WD9Q/6jZK4SUhW
         OdIl2Gomg8dyeJ6ddaKx8l8flD7YVkzEf3AimuJvMft17NwBDqlL0s7C7SV2ljtVqAXk
         uyzJc5b9iDOccw5fwPFtJRt0gLzSyyItPuFnULCRMfAek5OSkxyR06N0mDengTLNxR8Z
         ZOcVqw1WFw4sn/4WlXo1rpdBcGWnizYqy1qrel9EkinENSgKWraXUmUcAFZv1tHj/PZh
         u806ejqZOn5c+1BJlKs5fRq4WgBzuo3xcGzdAxPIi/1TN+6DEre5s7WNQlL77xJ/O/GG
         Xluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790477725; x=1791082525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eDg0B4GTZoaBgeAm1Zuaxbe7/C+fLySFm30qNgbQ5Ns=;
        b=iIBzcrXgQipR4vhqH4L6ZVoTkIXHXsCFveNCec3n4sEyxwLIqniJezb5nE/1mqSjf2
         qk2+NBtQozRNixN6knxM4FrkgR1J1x7msoj2MVQXspnW4pVjdWBiXr7gA951rGLmz6T6
         1uHtefrmO9JqzNFXr3O9xLh0LLtTazpbo3TaJb68ZL6vMTGUaDxtbuTxBsbQAGDk8s/t
         iX+uC1L/X6WmoVLK0FHB8KBjragrSqeQduDaUu4fyrD33MyzFzuBKmp1p2ChmvBZ2OrF
         Ry7XgwF7k9Sp+da42sM6OWnmXSDxULBwL3C2BKq594vsLbNXnI/U6LqZ+J0b1jJdnKex
         8JIA==
X-Forwarded-Encrypted: i=1; AKwUvByoGbLnHPp9IRX7/YmWJmp5mdSAAR2pBuEMCtmhu+swEayTKXu/vYhl3m8DgwRwSfrNj/dZwGLY2Cfrc7M=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI3qcDzhFtnD8UrHJItpTB6QASECxNt1mZXYzHmWg6ogTvtY1+5
	CuuVOS8lU1dzjguYqSzdQnry5D+TmcB0QbLygmPG5HkTDi5jKYHHblzTeVNGpgBGEQE=
X-Gm-Gg: AYBFou3+OwkoVxwHmECWwDG+o6c8+HSC6qHGM/fW/07qQmbz8Irp+LUa6YOrEuq+zbI
	ig3IHedVZFqFrEGutSnOp+59mJSVYt+WhC/3kh3o+vuDkJyu6aZ0ccxgCvyo0anO7NAJyMGTloQ
	RZBqBM1YuMNZJ54XFNPCaOpeIWW4KEzJzFy26qGoUrjtCRRXIGFK9iIn2vyS5u2NbU0dZTgP5tI
	tq2PQzi5ol+jpuHMoo0shxUMNl49xZuCvUWJhTM8rTnUQmr7Ry0w4XmdHkYjSQwC+zpIf8Yu1ca
	vG3V8FZtpZnyWiBUwUYRfGFE5r8H/BJEGhyV+rwg09zb/bXc0qsqmyKa+OH430sxGlUkBE3LUsP
	dwpSB7Yk3PU3oV4yhjmdO1o8S9rUjK2hGEl3wJJp3JybZAZXo5nx2C4uCM3anC2nYvKseIjJO+r
	Ibz39V5qE9jCUiVxQ6e4p5LWLEjCBBXLeB+nzGkLgYW6J/vVaQnwXWkyA1mXB4vbiia2+RkMFGS
	RVL877nloKyD09jh9Ns
X-Received: by 2002:a17:90b:4a45:b0:39e:6c68:c77c with SMTP id 98e67ed59e1d1-3a098e07a64mr8528965a91.50.1790477725206;
        Sat, 26 Sep 2026 19:55:25 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm13461377a91.1.2026.09.26.19.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 19:55:24 -0700 (PDT)
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
Subject: [PATCH v5 07/12] mm/sparse-vmemmap: switch device DAX to shared tail vmemmap pages
Date: Sun, 27 Sep 2026 10:54:36 +0800
Message-ID: <20260927025441.741633-8-songmuchun@bytedance.com>
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
index ca2470e96a74..2bc78aa053a1 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -221,6 +221,8 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 		set_page_node(page, zone_to_nid(zone));
 		set_page_zone(page, zone_idx(zone));
 		prep_compound_tail(page, NULL, order);
+		if (zone_is_zone_device(zone))
+			__SetPageReserved(page);
 	}
 
 	page = virt_to_page(addr);
@@ -525,23 +527,6 @@ static bool __meminit reuse_compound_section(unsigned long start_pfn,
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
@@ -551,21 +536,18 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
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
 
@@ -581,12 +563,12 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
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
@@ -918,13 +900,14 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
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


