Return-Path: <linuxppc-dev+bounces-22544-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D91CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 04:01:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5QW0zdKz3cJD;
	Fri, 12 Jun 2026 14:00:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236835;
	cv=none; b=Mtz0XD07f7rftUIOLu8NZ64Vska3HbX6zF+sWsrjlTie4eFgjiWb4BBDlKzpFMn9hf+Pl27oaUFvia25HhvKSXvK/wc0kOl/jCb0Ezc+ELvvatbfsIm+eRFVxIFH0pbXu8eNmMM1/hk80eAN/Z82sG2ukOsYSxNLrWRSjP8SWN4yM0Yj114P4Z1IBei7rM4kIUqjlQ/IlecNiwaBgIwWqaPwTkDmYuJ3KetXP7ZCuOLdiumVbxvkHLk9DU7/2hWsxSk3aTip+2lRFPOGWrufURIZJflmDrtq5TUBwTuZ4hrMWRwZNdJBPqKj0Z6Om4OwIZWzBJJeab3dekbb1cbYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236835; c=relaxed/relaxed;
	bh=2HtmZnZAkf01rz+eJDlHmM06i2kCJlpB00/bCPPffXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWL164fif6muYGDZjq2wow5/9ywXfh94jfKteMdP4SVYZQjWR1cnx+OV/MUo8izSZRB8WWgDNwVw9hxMKQs8nPCoWzo706kKvTu5LDT8jtks+82iWv/2GpNvWvxVi25QBDLiiksPgjxWF2ExyXkMZaS3igTvbLov6yXENqCWmo1/QdEb3wSHT+bOqRgLWZto2oYwM9QbBjZ+OP0T7Dq1d1lvHeOHhDsoU6QqSmlrnJJEHVfBt5dtg8Nv2yKl1avREOgGsdZ74ZUWHZVFVxJxV2LkI+wZsXm+Jxxi5cRN7NI+wqj/3CrJ2HlhasbC+bQHANoUu84aHdJNdRyDjovSJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jVjZVrW8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jVjZVrW8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5QV0JWdz3cPW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 14:00:34 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-8422f148dfcso349555b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 21:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236832; x=1781841632; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HtmZnZAkf01rz+eJDlHmM06i2kCJlpB00/bCPPffXw=;
        b=jVjZVrW8PfNJIxEjVHGLwgDiawYuIZWPRAJOVfFKx5yiEZ10NEcrfAAL5UBLs+sFjQ
         JnnfHkS0cl+RkAI/dHV0OaHabsJjfN5GLCJxq4h3ROIBKWEtLPhEXHOkQIw79Z4NahLr
         tiWlkkGQQtBxjkSUZ5dknhGGcz2gKvYWyTlwYkIr3LFyzgFrq6O0q3S5Trbp+IVzxGNC
         5oDQ6Z0FCQQLXlR571wbzsb3rSpc/6wZBNHMD1VDhcrCvmBKENk36Impb8eI+mVH2qV3
         p9mVQmGsOSSg6Td166I7GYaAecwBjV2xXMIdfFp6uL5CjVrdsojBauAfn3xUgPD0qXxP
         c6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236832; x=1781841632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2HtmZnZAkf01rz+eJDlHmM06i2kCJlpB00/bCPPffXw=;
        b=SGpjj4T4NZXlyf7A7wu3h4VRyOyz7eR0+gIv9WeHyzvJcyBCrAoHQM8k0VRQ98WYaj
         pLF0O8xen+82Kz1p6bIREy3DhCqlxrxcP2mid8KqReFcQakIJo1qx+5ARNThgmcwni2f
         ikB4DpWz7RSIq+smNjxvK86p77uLR3b4vCtLbmfCvy2Im/eTEc2lKVDfrUGRaI1Upf1a
         xN17SMitKfswVjFbqZqr0FwAZ8pOxlBagPtQ/xD4r/XOTYWF+6lo2pu157SjRvzfyJO0
         vdSWXqYbvcx0KkSYhq6TJAvsxt/iuFWtgFF7h7S2A4O5de6f9P5XbjbsUt5sQciHjDEh
         T7Cg==
X-Forwarded-Encrypted: i=1; AFNElJ8mXmkpdGVEfFHyyOAqfpyto0vcld/CtefjU7kz2K/oOxWlMHEqs50XapN30fhDFAzdwUaLb/2n7RBTEyQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwZCfOJwFeI0Q0hYFVi+GqdWnJ9ffLO8QhOpD8kJVruP9YDJaiH
	9YWSPENwbVcTC4nvlmhe95PlKw2Qky1taMFbWESOxCEC9R1k6G5888fE62BKd1A2jk0=
X-Gm-Gg: Acq92OFafwd2ynaIcudTlZlnS6F4jugFT0Fn1coOCRrLmXYutmfSCxubCJULtjPCtA9
	wmnCA/QerwIbgO9axdfiQ4K/GmkWqjeHdLkM2asfHq2D0Qz/C+H4aKFDKDMqWL4pGf3IyK0eT+C
	bK+q+bgxf1POOzUGa5SnEH6HXBxPykVH5MroysRtCoNdlN/clF/bqH2whF1F7EkH9byETQvoC/f
	w9idlEw2g7GhEL49IjAVsD6I1WDeLSIGUOvLNKNmIhpEO0eGG8XAH8uhI1aBZS+li7+5jR4fyd/
	iDf2w4+WJUY8zd2UHU3hG8Inp+3p4KciZ5uDVsUwKkVOF5H6lcEqZluwbnCVddcFVGe8JIO0rML
	KSF3Be9TM+OBh7xV9TtQ45/IhnEn1mxTta4ABDrOFIlOyNhM+6JRWSiraMgWAUaadqYUidWqtJB
	z9UQsMKk9tZ2yKoUSwpVyiVxBpWaBt60IFikjwvcXvRhPDdxxawUX3ig==
X-Received: by 2002:a05:6a00:4fcf:b0:842:5711:9a2f with SMTP id d2e1a72fcca58-8434cf4f362mr1184453b3a.36.1781236832074;
        Thu, 11 Jun 2026 21:00:32 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.21.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:00:31 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 16/19] mm/hugetlb: Remove obsolete bootmem cross-zone checks
Date: Fri, 12 Jun 2026 11:59:00 +0800
Message-ID: <20260612035903.2468601-17-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612035903.2468601-1-songmuchun@bytedance.com>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
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

Bootmem gigantic HugeTLB pages used to be validated again during
gather_bootmem_prealloc_node() and any cross-zone pages were discarded
there.

That validation is no longer needed. Cross-zone bootmem gigantic pages
are now detected during allocation and freed before they reach the later
bootmem gathering path, so the remaining pages are already zone-valid.

Remove the obsolete cross-zone validation, invalid-page freeing, and the
associated discarded-page accounting.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

---
v3->v4:
- Collect Acked-by from Mike Rapoport
---
 include/linux/hugetlb.h |  3 --
 mm/hugetlb.c            | 70 -----------------------------------------
 2 files changed, 73 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 09f28dd773b7..f68a390d43bd 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -678,9 +678,6 @@ struct hstate {
 #define HUGE_BOOTMEM_ZONES_VALID	0x0002
 #define HUGE_BOOTMEM_CMA		0x0004
 
-struct huge_bootmem_page;
-bool hugetlb_bootmem_page_zones_valid(int nid, struct huge_bootmem_page *m);
-
 int isolate_or_dissolve_huge_folio(struct folio *folio, struct list_head *list);
 int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
 void wait_for_freed_hugetlb_folios(void);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 218fb1ca45f4..47c3d6d11c58 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -58,7 +58,6 @@ struct hstate hstates[HUGE_MAX_HSTATE];
 
 __initdata nodemask_t hugetlb_bootmem_nodes;
 __initdata struct list_head huge_boot_pages[MAX_NUMNODES];
-static unsigned long hstate_boot_nrinvalid[HUGE_MAX_HSTATE] __initdata;
 
 /*
  * Due to ordering constraints across the init code for various
@@ -3221,57 +3220,6 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
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
@@ -3287,17 +3235,6 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
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
@@ -3692,20 +3629,13 @@ static void __init hugetlb_init_hstates(void)
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
-- 
2.54.0


