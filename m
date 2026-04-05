Return-Path: <linuxppc-dev+bounces-19347-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545F1EEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:55:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXVq3479z2yjs;
	Sun, 05 Apr 2026 22:55:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393715;
	cv=none; b=ToYEahniE+uOaPMhs/vG65coZDLDuBHliCyP6S14ju+mPHchfxMgkEpLuGg2uGSO13kMzRFwhXrghn/oYRURKuoAprRRtQqacoR6ZOraJOxDwGMKoD3M74bOUZR0pe7sLmXOH1GFlE8iDINnFLuxCMcddZqH6f/nRsz99MYU+/KAxdztcx88M9SnL3+hPEBW2IWq3k5WmM5vvUuT/K38ZW3RQXwX17e5cVUeGqj28dMCaWmNyAJssMTaHuerplVJE3ZO+EQSheIEepnk1PQnn0rDLasMOJL4PQm1WwiijqEf572sPaGrzIDZAa7DKY27zSVrNLuyvH4XCK41S/1kQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393715; c=relaxed/relaxed;
	bh=KKli8yHSnxAMZ2GmFUDAbnEpbh1w6hBHm6LRjyjJACk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIzYd0sPNPgIg15HgwRNv1Jayv8U49OTaaCROxokdFTHi5SPW66LZ/ALoCHHxYEVxMXEgKYuonzPreZl3hcm0Y5bdkSLhGr+CmUdJD2cIzR9QpLT353t9y0yWPN5SiRAS0J0ckJd2Ly2QaIfshI62an58SzPDY8mvy7uD+gVrSOEzESrKpyBH+XC6wUOiod+GgFLyzDOYZEtnnQ8LW11ioHHn9ktFi47zVmGfdP6qNZX4K7yQiCwnDT6B0RHOkEvdkN9pD5b3IDB5AEAOUA9b6XFE2fBLD7sGX/6sgmDjdbZK1k5snLRztBHzhah0p2T/9htAVk0k/IMacCR8DrZig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hTwGp1x8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hTwGp1x8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXVp4hNBz2yrS
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:55:14 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-35d9c7bf9a1so2804712a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393713; x=1775998513; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKli8yHSnxAMZ2GmFUDAbnEpbh1w6hBHm6LRjyjJACk=;
        b=hTwGp1x85OGfAUTgMlU7Ep57TkoTbkLFTDXlQ8LHo2zcizTn0sU8lAwf5JGA7Gdv5b
         95bFMzeIq4iIWhAHIOsUGDCWDMSWlwGQeqgYU2m1PrEupaQ7dgSjUoz31i1NS3Ip8ZHP
         rS8sf3ivLQGrhMG0TycaKB+2qJsXUNZULwKqIcvhN0b/moVjKkWv2HAOvyrKocIj0o54
         zvYvpTW13XgEyM8iZP2YTkH0vajlrCg1AgY6ufsyx1jkJfK0OjzDgdWhaXbvGqI68Svz
         80DeZpV6bFwpCsoI6+9SIP8D0ym9TIjzsyQFALzP5ukTUH6tHOZNm+Tez4Uyb9acnEKI
         bUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393713; x=1775998513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KKli8yHSnxAMZ2GmFUDAbnEpbh1w6hBHm6LRjyjJACk=;
        b=LWMK2Mz0ybH7JtnZ1BYw5gsA32Uz0gYgkE9kb9zZwt0KdGdUxfc1NBLVBgjwqbSJuA
         07vxSESuw1Xb0Uj+jxLhc0XondE57NlfPYjB3k/R/Tsqa4PDr3xhW5n+dGZ1DUcxO4C7
         /y3rd+flwZq3dh8qAZ9iFIRLC+GsHuDv2LqbE6thn6lRvLb9OwnIPtrtei/iJUf44lFV
         f/NQWzAAOIriCF1s5crP2oF85TxNXzmt+w0g2gRFurl3Hi0cgpz4VYMoI7Vitlk1X57/
         rV12RugFF6m+yof8OeAf3Il0FE/dJNs/mF5Jsi3lMEpXaYIOKM3nC5yzs6NJ/JXzVd0w
         Ovxw==
X-Forwarded-Encrypted: i=1; AJvYcCUpVhK4Qc0Ovlhylr5QZ3y/920HVrZcSCX9nnZfJRiHAw/sOXH9dccJAR2LgQ0k4TKSq6lv0e5oOOHYiH8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyBFk/5SqTWpQ7v+GzXwbEaUkLY4kJQkkUYYr0S9nxFB3eQRSgG
	u7Kfjlhan1MdoohyleyXUuSdRuSECXQT3+rG785v/t0Bi/XOxoLY5RHbLSpYXDOPDLM=
X-Gm-Gg: AeBDiesjkpJYojO6OIUjRRU2Kw4uE7M+B0iE7c6+Rnq61SRHH+K3ns1HyPzJhDi/R4b
	KuPOangIs2PAeEV/tOzAMitClW+vu92By+V2/7Ld7Z8mD7Gz6OucvNtEE8TBzk6vk4f20B7o9Jf
	O7dsX587rVfB7B0vm8TykGwhrNj1j5I0+O3dHarIxWK1h4lhxk4YWCdt1ujmTKDGe96AELpLDwa
	Qsq/tT2ZJKpXOoPPJVvpL3ZRa5S88ACSSp1J9J+kGezmvLy9PYRqcez4a4EjT2k0P6+JWUJwmtG
	EHJCYX4dB8tm1zTBLS5egzAEnie27JXL56+v+Xsk4xyv0fG2g9Kwzy1zZHiYf94lIk92QpKnKcb
	w1YXW/sVTaOoOVhVOHXqFQrkix08ft0wse8tR2rFLnbOuqvIEXCkKBhk1SQYwJCNTfJnCC6Tmse
	5qrgk8/+V9Ga6YIy4shJTwbJFlvrCcB1GbRYSfSCqIjpaBlu/nEpwg/w==
X-Received: by 2002:a17:90b:224e:b0:35d:a90d:580e with SMTP id 98e67ed59e1d1-35de693d12amr8416296a91.23.1775393712638;
        Sun, 05 Apr 2026 05:55:12 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:55:12 -0700 (PDT)
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
Subject: [PATCH 17/49] mm: remove sparse_vmemmap_init_nid_late()
Date: Sun,  5 Apr 2026 20:52:08 +0800
Message-Id: <20260405125240.2558577-18-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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

After deferring hugetlb bootmem allocation until after free_area_init()
and checking cross-zone pages during allocation, the hugetlb_vmemmap_init_late()
function is no longer needed:

1. hugetlb_bootmem_alloc() is now called after free_area_init(), so zone
   information is available during bootmem huge page allocation.
2. During alloc_bootmem(), cross-zone pages are identified and marked with
   HUGE_BOOTMEM_ZONES_VALID flag.
3. After allocation, hugetlb_free_cross_zone_pages() frees those pages that
   intersect multiple zones.

Since cross-zone pages are already handled in the allocation path, the late-stage
validation in hugetlb_vmemmap_init_late() is redundant and can be removed.

Also, the sparse_vmemmap_init_nid_late() function is now empty and unused.
Remove it to clean up the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  2 --
 include/linux/mmzone.h  |  7 -----
 mm/hugetlb.c            | 70 -----------------------------------------
 mm/hugetlb_vmemmap.c    | 58 ----------------------------------
 mm/hugetlb_vmemmap.h    |  5 ---
 mm/sparse-vmemmap.c     | 11 -------
 mm/sparse.c             |  2 --
 7 files changed, 155 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9c098a02a09e..23d95ed6121f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -699,8 +699,6 @@ struct huge_bootmem_page {
 #define HUGE_BOOTMEM_ZONES_VALID	0x0002
 #define HUGE_BOOTMEM_CMA		0x0004
 
-bool hugetlb_bootmem_page_zones_valid(int nid, struct huge_bootmem_page *m);
-
 int isolate_or_dissolve_huge_folio(struct folio *folio, struct list_head *list);
 int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
 void wait_for_freed_hugetlb_folios(void);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a071f1a0e242..8ee9dc60120a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2153,8 +2153,6 @@ static inline int preinited_vmemmap_section(const struct mem_section *section)
 }
 
 void sparse_vmemmap_init_nid_early(int nid);
-void sparse_vmemmap_init_nid_late(int nid);
-
 #else
 static inline int preinited_vmemmap_section(const struct mem_section *section)
 {
@@ -2163,10 +2161,6 @@ static inline int preinited_vmemmap_section(const struct mem_section *section)
 static inline void sparse_vmemmap_init_nid_early(int nid)
 {
 }
-
-static inline void sparse_vmemmap_init_nid_late(int nid)
-{
-}
 #endif
 
 static inline int online_section_nr(unsigned long nr)
@@ -2371,7 +2365,6 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
 
 #else
 #define sparse_vmemmap_init_nid_early(_nid) do {} while (0)
-#define sparse_vmemmap_init_nid_late(_nid) do {} while (0)
 #define pfn_in_present_section pfn_valid
 #endif /* CONFIG_SPARSEMEM */
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 238495fd04e4..a00c9f3672b7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -58,7 +58,6 @@ struct hstate hstates[HUGE_MAX_HSTATE];
 
 __initdata nodemask_t hugetlb_bootmem_nodes;
 __initdata struct list_head huge_boot_pages[MAX_NUMNODES];
-static unsigned long hstate_boot_nrinvalid[HUGE_MAX_HSTATE] __initdata;
 
 /*
  * Due to ordering constraints across the init code for various
@@ -3254,57 +3253,6 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 	}
 }
 
-bool __init hugetlb_bootmem_page_zones_valid(int nid,
-					     struct huge_bootmem_page *m)
-{
-	unsigned long start_pfn;
-	bool valid;
-
-	if (m->flags & HUGE_BOOTMEM_ZONES_VALID) {
-		/*
-		 * Already validated, skip check.
-		 */
-		return true;
-	}
-
-	if (hugetlb_bootmem_page_earlycma(m)) {
-		valid = cma_validate_zones(m->cma);
-		goto out;
-	}
-
-	start_pfn = virt_to_phys(m) >> PAGE_SHIFT;
-
-	valid = !pfn_range_intersects_zones(nid, start_pfn,
-			pages_per_huge_page(m->hstate));
-out:
-	if (!valid)
-		hstate_boot_nrinvalid[hstate_index(m->hstate)]++;
-
-	return valid;
-}
-
-/*
- * Free a bootmem page that was found to be invalid (intersecting with
- * multiple zones).
- *
- * Since it intersects with multiple zones, we can't just do a free
- * operation on all pages at once, but instead have to walk all
- * pages, freeing them one by one.
- */
-static void __init hugetlb_bootmem_free_invalid_page(int nid, struct page *page,
-					     struct hstate *h)
-{
-	unsigned long npages = pages_per_huge_page(h);
-	unsigned long pfn;
-
-	while (npages--) {
-		pfn = page_to_pfn(page);
-		__init_page_from_nid(pfn, nid);
-		free_reserved_page(page);
-		page++;
-	}
-}
-
 /*
  * Put bootmem huge pages into the standard lists after mem_map is up.
  * Note: This only applies to gigantic (order > MAX_PAGE_ORDER) pages.
@@ -3320,17 +3268,6 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 		struct folio *folio = (void *)page;
 
 		h = m->hstate;
-		if (!hugetlb_bootmem_page_zones_valid(nid, m)) {
-			/*
-			 * Can't use this page. Initialize the
-			 * page structures if that hasn't already
-			 * been done, and give them to the page
-			 * allocator.
-			 */
-			hugetlb_bootmem_free_invalid_page(nid, page, h);
-			continue;
-		}
-
 		/*
 		 * It is possible to have multiple huge page sizes (hstates)
 		 * in this list.  If so, process each size separately.
@@ -3700,20 +3637,13 @@ static void __init hugetlb_init_hstates(void)
 static void __init report_hugepages(void)
 {
 	struct hstate *h;
-	unsigned long nrinvalid;
 
 	for_each_hstate(h) {
 		char buf[32];
 
-		nrinvalid = hstate_boot_nrinvalid[hstate_index(h)];
-		h->max_huge_pages -= nrinvalid;
-
 		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
 		pr_info("HugeTLB: registered %s page size, pre-allocated %ld pages\n",
 			buf, h->nr_huge_pages);
-		if (nrinvalid)
-			pr_info("HugeTLB: %s page size: %lu invalid page%s discarded\n",
-					buf, nrinvalid, str_plural(nrinvalid));
 		pr_info("HugeTLB: %d KiB vmemmap can be freed for a %s page\n",
 			hugetlb_vmemmap_optimizable_size(h) / SZ_1K, buf);
 	}
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index e25c70453928..535f0369a496 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -807,64 +807,6 @@ void __init hugetlb_vmemmap_init_early(int nid)
 		m->flags |= HUGE_BOOTMEM_HVO;
 	}
 }
-
-void __init hugetlb_vmemmap_init_late(int nid)
-{
-	struct huge_bootmem_page *m, *tm;
-	unsigned long phys, nr_pages, start, end;
-	unsigned long pfn, nr_mmap;
-	struct zone *zone = NULL;
-	struct hstate *h;
-	void *map;
-
-	if (!READ_ONCE(vmemmap_optimize_enabled))
-		return;
-
-	list_for_each_entry_safe(m, tm, &huge_boot_pages[nid], list) {
-		if (!(m->flags & HUGE_BOOTMEM_HVO))
-			continue;
-
-		phys = virt_to_phys(m);
-		h = m->hstate;
-		pfn = PHYS_PFN(phys);
-		nr_pages = pages_per_huge_page(h);
-		map = pfn_to_page(pfn);
-		start = (unsigned long)map;
-		end = start + nr_pages * sizeof(struct page);
-
-		if (!hugetlb_bootmem_page_zones_valid(nid, m)) {
-			/*
-			 * Oops, the hugetlb page spans multiple zones.
-			 * Remove it from the list, and populate it normally.
-			 */
-			list_del(&m->list);
-
-			vmemmap_populate(start, end, nid, NULL, NULL);
-			nr_mmap = end - start;
-			memmap_boot_pages_add(DIV_ROUND_UP(nr_mmap, PAGE_SIZE));
-
-			memblock_phys_free(phys, huge_page_size(h));
-			continue;
-		}
-
-		if (!zone || !zone_spans_pfn(zone, pfn))
-			zone = pfn_to_zone(nid, pfn);
-		if (WARN_ON_ONCE(!zone))
-			continue;
-
-		if (vmemmap_populate_hvo(start, end, huge_page_order(h), zone,
-					 HUGETLB_VMEMMAP_RESERVE_SIZE) < 0) {
-			/* Fallback if HVO population fails */
-			vmemmap_populate(start, end, nid, NULL, NULL);
-			nr_mmap = end - start;
-		} else {
-			m->flags |= HUGE_BOOTMEM_ZONES_VALID;
-			nr_mmap = HUGETLB_VMEMMAP_RESERVE_SIZE;
-		}
-
-		memmap_boot_pages_add(DIV_ROUND_UP(nr_mmap, PAGE_SIZE));
-	}
-}
 #endif
 
 static const struct ctl_table hugetlb_vmemmap_sysctls[] = {
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 18b490825215..7ac49c52457d 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -29,7 +29,6 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h, struct list_head *folio_list);
 #ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
 void hugetlb_vmemmap_init_early(int nid);
-void hugetlb_vmemmap_init_late(int nid);
 #endif
 
 
@@ -81,10 +80,6 @@ static inline void hugetlb_vmemmap_init_early(int nid)
 {
 }
 
-static inline void hugetlb_vmemmap_init_late(int nid)
-{
-}
-
 static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
 	return 0;
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index b7201c235419..26cb55c12a83 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -581,17 +581,6 @@ void __init sparse_vmemmap_init_nid_early(int nid)
 {
 	hugetlb_vmemmap_init_early(nid);
 }
-
-/*
- * This is called just before the initialization of page structures
- * through memmap_init. Zones are now initialized, so any work that
- * needs to be done that needs zone information can be done from
- * here.
- */
-void __init sparse_vmemmap_init_nid_late(int nid)
-{
-	hugetlb_vmemmap_init_late(nid);
-}
 #endif
 
 static void subsection_mask_set(unsigned long *map, unsigned long pfn,
diff --git a/mm/sparse.c b/mm/sparse.c
index d940b973df66..5fe0a7e66775 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -383,8 +383,6 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 	}
 	sparse_usage_fini();
 	sparse_buffer_fini();
-
-	sparse_vmemmap_init_nid_late(nid);
 }
 
 /*
-- 
2.20.1


