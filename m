Return-Path: <linuxppc-dev+bounces-22542-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04910CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 04:01:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5QK1Rtxz3bpt;
	Fri, 12 Jun 2026 14:00:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236825;
	cv=none; b=Auq7giHnssNgu/vL8zwkmQNeciyz55xZLvUDOfYsc562hQfQLGTb5owQnn7/FFI9wh8NwWHeL6MsSXjxY/f34yXWoc/wxNp4Zgii5loxvQVA3GrN/LBAXQy7w4ZbWaDfRb/Z8fIvLYh6symcJJY2pZpaFcrKhpK/SZmZ/eX6yOtZ1mJSmDFRp/pWUXOvQCg6IpbhHuAL9d3RZ07gntp6drchv6WTrsRysoYBUZVOMZcsg/ZQHl/LQbv4IZBt35C7tAasHNub8UKtk67SfwbLwoBBr9BHXkN94o0lGSS4yL3YTi60CdQnsS5j5L7o+84E/pjj3pX7abWGcvgFit/QfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236825; c=relaxed/relaxed;
	bh=E/u6lKC7hQ/GhzoNdcnEA7gND1myfeYXkd1NgoaUr0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXRzpGC9CdW+JGKGwqVAAXZNPHs1Q1VHeJVybjC9oTWtwhecWRSsiP3ikKSY4M4c0BfkxuxoaCtWzmxcaTVdHG02wn4TNCw9+eyi6pxWy661fh1LxtvsNe0qnMw8G9s/UJvt0wRLZ/EzIWlDKp8/EuTBs+VsT9mnQk96hL9ZbmMxQhu76xN8D3iOTBXPU/HzVYfaQsz5VLVyWjMHZZMFtl1955QVknrC0ZAepNSpn3Xk2QCvXN5y/s0scli6bAjWrx/LzsgO4BGVPzf7XTaV6RuIoLHfz5ijI4jprdXavg+XhUdiNSvgt2Esh/Ohzka6NimQwIPChyBt1FbCDgDSjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LZaVNjCb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LZaVNjCb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5QJ07CNz3bsn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 14:00:24 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-842307472d4so251753b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 21:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236822; x=1781841622; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/u6lKC7hQ/GhzoNdcnEA7gND1myfeYXkd1NgoaUr0Y=;
        b=LZaVNjCbXSo+bx6lzfnLGkHF64lXqvw+Hz9Ou8tr/tdTqD2lGuf6gFjVzgNj5FR52P
         CSqulmeE5ulmrvlYXGE4O74ktY0cr55nXbhil/a1OVqjCwYP+Sib3RJd74pjsPgHtsan
         aQPlesy8yT8WFjkNZ3JMVCM2DXFaqEAgL11tCkqyMvAQM9tFy0BLFt0XedN8XO7nd7GG
         jBzQNUyPL60+BpMWzVZ5Yn73gO1PpFvoGg1J7Qir3ubgeb5ZmNy7MpTJjVFHjdowQmi2
         ENQFntfGEkWKNtQu0TiG4sq2V5J3pXMvGjEQkhWb4LkiBlCY2IQ4fOiijblFxezyhE+V
         4XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236822; x=1781841622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E/u6lKC7hQ/GhzoNdcnEA7gND1myfeYXkd1NgoaUr0Y=;
        b=iDnpDhuC65AM4fBMTVrGvn3FHnA9o7hgLUNacFfPo6TPnR5XpyC8R1RwBuTZh4+Ius
         gLXcUVriVcGx849NNK8siV38hDEl0YiIqGU7YggD0OHOLQjmXiW+or4rypSsTokj4RZk
         5TXUqTEbfP7Q4SSfLcnfmF2d49K0bDiMhQJpu9SKctN6yFgOSUUO6eL6VhLMUeXrw4p3
         a1jBTuOGPxnRSBlFqN4UbzveboclEsGjOw3ztjV9rReuKWoIdm1p7SimMW32gAqU+ql6
         dh6QQ4JjXyjdSGHq3eNUNysOlKwQWoXmtgBj0gDiX9GJV+W7QpUp766ypX4gutFiDgTg
         YpBg==
X-Forwarded-Encrypted: i=1; AFNElJ+tPQ5hhN18Fi8p5EITelG0woQYUy7f4W0JjaFNsVbG6YTK0lOO8NhLGZ+3Ds6bbpqAeK6v9R2CwnXQ74w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzTPVtmxyCOwxa7q6+1dLx3lQK9V+ZGV3vXskjnWfF+3+LxVelt
	FYu84sqpQTlqU9tG8+mr2Xc7vTcA7cnog4M1uy/VzOJn19ZI/cVdUtnr9eOj8hh17LA=
X-Gm-Gg: Acq92OE0spgGnBSu1WPfbZhlrkdL8jnKygMWA875+KjOlz+CGbKhwTCsxI2SDGuU2CK
	PClvcDV8LjG8urvxPYRRGlG1yz7/RvzM3HOtVNV7YqAM0NfyycRe24hIULWOaeuRGz1BMtfZNag
	1PcMViti7pZ95SpK7LQkejCL9TEumG+eN5LLnMNOA2G//riiHdx7EzNgkSn3NlDsnFBqzzV8Pp+
	APKZhOtKRB458CMceSmOw5b1oOYDR/bxxXAXr1XFUoMdpTKPoJzIFNbhb3Z9WmnC/J4gD81nkym
	cso/bcFacEvgdA/tiwHjU8i7eSlWDgqDhsnbtEGCoTb6+yHYZ4pd3wUk8aBulDF41lwgIffdorr
	655e34EACNDrAlwBS4Uq1ihig1p8O28NmsfvJ9os+/lZjADfPCFgfgzB6MZ6h8ZHlOEadKZ46z4
	qLx3WeBL4+YIJZZpNZpQY2WKUE/GScDc1gzWrbUtBFi+o=
X-Received: by 2002:a05:6a00:114c:b0:842:4b88:20ee with SMTP id d2e1a72fcca58-8434d103dbemr974121b3a.44.1781236821951;
        Thu, 11 Jun 2026 21:00:21 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.21.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:00:21 -0700 (PDT)
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
Subject: [PATCH v4 14/19] mm/hugetlb: Free cross-zone bootmem gigantic pages after allocation
Date: Fri, 12 Jun 2026 11:58:58 +0800
Message-ID: <20260612035903.2468601-15-songmuchun@bytedance.com>
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

Now that hugetlb reservation runs after zone initialization, bootmem
gigantic page allocation can detect pages that span multiple zones.

Keep those cross-zone pages separate during allocation and free them
after allocation completes, so later hugetlb initialization only sees
zone-valid gigantic pages.

This chooses to free cross-zone gigantic pages directly instead of
retrying allocation. In practice, such cross-zone cases are expected to
be very rare, so adding retry logic does not seem justified at this
point. Keeping the handling simple also preserves the previous behavior.
If similar real-world reports show up later, retry support can be
reconsidered then.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 75 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5e557c05d80a..218fb1ca45f4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3060,12 +3060,15 @@ void *__init __alloc_bootmem_huge_page(struct hstate *h, int nid)
 
 static bool __init alloc_bootmem_huge_page(struct hstate *h, int nid)
 {
+	unsigned long pfn;
+	unsigned int nid_request = nid;
 	struct huge_bootmem_page *m = arch_alloc_bootmem_huge_page(h, nid);
 
 	if (!m)
 		return false;
 
-	nid = early_pfn_to_nid(PHYS_PFN(__pa(m)));
+	pfn = PHYS_PFN(__pa(m));
+	nid = early_pfn_to_nid(pfn);
 	/*
 	 * Use the beginning of the huge page to store the huge_bootmem_page
 	 * struct (until gather_bootmem puts them into the mem_map).
@@ -3073,22 +3076,38 @@ static bool __init alloc_bootmem_huge_page(struct hstate *h, int nid)
 	 * Put them into a private list first because mem_map is not up yet.
 	 */
 	INIT_LIST_HEAD(&m->list);
-	list_add(&m->list, &huge_boot_pages[nid]);
 	m->hstate = h;
 	if (!hugetlb_early_cma(h)) {
 		m->cma = NULL;
 		m->flags = 0;
 	}
 
-	/*
-	 * Only initialize the head struct page in memmap_init_reserved_pages,
-	 * rest of the struct pages will be initialized by the HugeTLB
-	 * subsystem itself.
-	 * The head struct page is used to get folio information by the HugeTLB
-	 * subsystem like zone id and node id.
-	 */
-	memblock_reserved_mark_noinit(__pa((void *)m + PAGE_SIZE),
-		huge_page_size(h) - PAGE_SIZE);
+	/* CMA pages: zone-crossing is validated in hugetlb_cma_reserve(). */
+	if (!hugetlb_early_cma(h) &&
+	    pfn_range_intersects_zones(nid, pfn, pages_per_huge_page(h))) {
+		/*
+		 * If the allocated page is on a different node than requested
+		 * (e.g., on PowerPC LPARs), put it on the requested node's list,
+		 * because hugetlb_free_cross_zone_pages() only frees cross-zone
+		 * pages belonging to the requested node.
+		 */
+		if (WARN_ON_ONCE(nid_request != NUMA_NO_NODE && nid != nid_request))
+			list_add(&m->list, &huge_boot_pages[nid_request]);
+		else
+			list_add(&m->list, &huge_boot_pages[nid]);
+	} else {
+		list_add_tail(&m->list, &huge_boot_pages[nid]);
+		m->flags |= HUGE_BOOTMEM_ZONES_VALID;
+		/*
+		 * Only initialize the head struct page in memmap_init_reserved_pages,
+		 * rest of the struct pages will be initialized by the HugeTLB
+		 * subsystem itself.
+		 * The head struct page is used to get folio information by the HugeTLB
+		 * subsystem like zone id and node id.
+		 */
+		memblock_reserved_mark_noinit(__pa((void *)m + PAGE_SIZE),
+				huge_page_size(h) - PAGE_SIZE);
+	}
 
 	return true;
 }
@@ -3373,6 +3392,34 @@ void __init hugetlb_bootmem_struct_page_init(void)
 	padata_do_multithreaded(&job);
 }
 
+static unsigned long __init hugetlb_free_cross_zone_pages(struct hstate *h, int nid)
+{
+	unsigned long freed = 0;
+	struct huge_bootmem_page *m, *tmp;
+
+	if (!hstate_is_gigantic(h))
+		return freed;
+
+	list_for_each_entry_safe(m, tmp, &huge_boot_pages[nid], list) {
+		if (m->flags & HUGE_BOOTMEM_ZONES_VALID)
+			break;
+
+		list_del(&m->list);
+		memblock_free(m, huge_page_size(h));
+		freed++;
+	}
+
+	if (freed) {
+		char buf[32];
+
+		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, sizeof(buf));
+		pr_warn("HugeTLB: freed %lu cross-zone hugepages of size %s on node %d.\n",
+			freed, buf, nid);
+	}
+
+	return freed;
+}
+
 static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 {
 	unsigned long i;
@@ -3403,6 +3450,8 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 		cond_resched();
 	}
 
+	i -= hugetlb_free_cross_zone_pages(h, nid);
+
 	if (!list_empty(&folio_list))
 		prep_and_add_allocated_folios(h, &folio_list);
 
@@ -3476,6 +3525,7 @@ static void __init hugetlb_pages_alloc_boot_node(unsigned long start, unsigned l
 
 static unsigned long __init hugetlb_gigantic_pages_alloc_boot(struct hstate *h)
 {
+	int nid;
 	unsigned long i;
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
@@ -3484,6 +3534,9 @@ static unsigned long __init hugetlb_gigantic_pages_alloc_boot(struct hstate *h)
 		cond_resched();
 	}
 
+	for_each_node(nid)
+		i -= hugetlb_free_cross_zone_pages(h, nid);
+
 	return i;
 }
 
-- 
2.54.0


