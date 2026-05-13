Return-Path: <linuxppc-dev+bounces-20863-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDA9CD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:09:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv110x0xz2yMl;
	Wed, 13 May 2026 23:08:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677733;
	cv=none; b=XbP9vpR/X6SGXB4nuQfYBSYQSHFiZwlW9kBWXu7fXCtF8ldVqDs5nZvlgbjCJVxAIM1zP/bc6c/XKsUH0bOqddzgl+F+V97mBUOSjAWqSIKqVAePO/jmHLv73YBFjNYH3EB4IChAXanKXxiqb8l8EPv5V8K90+56SKBjMdvGDlCWWytTMKEbrEC0PVgV+0vm1Hz5qjLz70x865trW85krNP0+PFvjhl2ZHAidXaFZ4GHWhtE2Ya7okD0DaDzCctwUqQ8XK+xPbD1ObrAcd0EXEM7S/LbxwTgvM23nYCqJpPhzSrJ0+pIrGycuj4kjHOTjBsDi47gq2qeAC0yISAUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677733; c=relaxed/relaxed;
	bh=hECduHIccySBzXm1iwDhAhigl+PnFtS+sgbTNemvQzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcwlknxS97UKCrisNeB5oV2vUvj5yTFVCI19HYmrmBn52iwbjkb8eraH1s77X82xHTbES+G8z+jN4lQ9wF73gtiLUdADR6CLkJS1sPxpI/ObCWnUfSnOmb+UkyVoPzZDk8X5Aa8ZO+M40VC1lOZSQAFHgJs+1WLIhlgq6Jy4aOt8YarE71EyzbFfS8GJNOml+87kAHuRRSyLswjrgXzWTeBc9zJC3/oL58wtxo0KHyencJak0ZHyR3p4YOsofFr8dycaeYYUXPniQn70EiFnXT23iiYXXzNfCQ5dYvraO0peoA78YNNtWy8Txmq9y3YwIPBdKSYlXSopDXZFXgKenQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=JUjQbwS/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=JUjQbwS/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv103X4tz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:08:52 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2ba21d32776so45313285ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677730; x=1779282530; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hECduHIccySBzXm1iwDhAhigl+PnFtS+sgbTNemvQzE=;
        b=JUjQbwS/nnLzbMFjsE4y7xOo6G2Hj5xgvgVoH9bfmr5ntWFLJzz4NqzN7ev7Msykvm
         fnDR9KEGq7nWWLi7LxDQLIfijm40lfrY6jFXnheItOjUGRfkPZPQX8JMabG3rbCPgZw5
         sWyGHCVQQNa3MlY5tLCTjG142/cZpwAgIzkq7k7GNJ8jWWW3d3LSqmsdITDqk9vvZgsh
         tsAkXorT3HUdCwPg0aRQnE7QAd3//e/i94wABTqQ5ni1FlwFP1K3vCL8Ooy2AuJMS+BL
         AHN1/OPC34NgQdyOgIeM0uEU/424XJvCDdIpGLcn3G0ucR0KyecTuhb4u6e8c3fySlNu
         P6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677730; x=1779282530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hECduHIccySBzXm1iwDhAhigl+PnFtS+sgbTNemvQzE=;
        b=OV+9Q1tae/whE3z6Ynnr4h1uhWFF22NHmBZ9MIexwOfIUMJMmSrq4y7XcdHMUL6dYE
         9EvA7Pxh8dCh/bCKwZpuWDCWBAExaBvkd/SS9OomB8W4vcvEuGzoXkRLHEolcJVnzzis
         gWOMH+fWUW3LOTglDX7khOWO+Adtsn2mvUz6iz7mrpoNln2A8RIcCKiF8BHoHyT0CTnS
         +ouHLCxTtIG3rjm9xbft+n4XpglvdcM/QfvcnIiQMiQKeffYix+cCzPrzx07q1oXx7GJ
         kI1+VgNbkIbfDDCwf8WfpcAHQF+Dbm/LP4xaqPhXOD1LazOj8AEko/mwJVGKUKCGSbS2
         nbBw==
X-Forwarded-Encrypted: i=1; AFNElJ/ElTSH4KhEQbTjqmdT9uInYwarljGfAoGt0LcKH11d8C9X6EU1cXzFs5Di7oy8Ai/jcIEatwyKjaU1fF4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyiPZ8+OZS8oWgIR9O6zGznW9JILGttmO0e5T+ZeDqYYHYnhdrN
	JUQm1KkhtuYLpaOBGVyI+fcFI7tywm76gz27I7eGy8ceEdGsacS1tIiqVFVka0bQnc0=
X-Gm-Gg: Acq92OEqPDhSfYdRf4cG6KJMzU/Z/V+yFgOcwUGv05BWMmPK2PXfn5HAAtUCAcarT0l
	6iqlehkre/Y+mmC8PZMIScq9ZzXieQYCOn5Gsz6Vz7palltmTTeQTfPBQQyrDgAqhAhLd9t3oqI
	Ww0l7wqMeaebpxo+TuY4zHz/LhMRPhq+0ri3B4Pl8u0wSKdNJ0mbFi5BC1H9wmnomAAGAydw/+z
	llprMs2SUeImXfecILUTd86ylRrw0AeT6RnecVMoIT7RwC+q3CVEj9iHvAOxJLtti0PGt4Z+qut
	n5y7LXz9peHi29tZ3vkKojl/PO9djY3W6csoQraccPZVFilnxSMOTgDRrOLtA3HoPAOm1j8YlyP
	6dw9IkvmghzmVgXXnn0MZ7qwneknI9Gr4lahvvN1FPYYv9wKInNezEgG5Hp0xZjKI2GdtShD0tl
	331KXmHzWfMrq31cCvReZtPzeID60TLOn8zHH0HaiwEexeiEGBiw89QD/Rqd38r+PaJMjx3g==
X-Received: by 2002:a17:903:3803:b0:2b9:e82f:bfef with SMTP id d9443c01a7336-2bd275b1d3bmr34581465ad.21.1778677730063;
        Wed, 13 May 2026 06:08:50 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.08.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:08:49 -0700 (PDT)
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
Subject: [PATCH v2 14/69] mm/hugetlb: Free cross-zone bootmem gigantic pages after allocation
Date: Wed, 13 May 2026 21:04:42 +0800
Message-ID: <20260513130542.35604-15-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513130542.35604-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
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
index e9ba0be2eb17..d5d324f69d7a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3077,12 +3077,15 @@ void *__init __alloc_bootmem_huge_page(struct hstate *h, int nid)
 
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
@@ -3090,22 +3093,38 @@ static bool __init alloc_bootmem_huge_page(struct hstate *h, int nid)
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
+		 * (e.g. on PowerPC LPARs), put it on the requested node's list.
+		 * Otherwise, the cross-zone page will be stranded and never
+		 * freed, as the cleanup code only operates on the requested node.
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
@@ -3384,6 +3403,34 @@ void __init hugetlb_struct_page_init(void)
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
@@ -3414,6 +3461,8 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 		cond_resched();
 	}
 
+	i -= hugetlb_free_cross_zone_pages(h, nid);
+
 	if (!list_empty(&folio_list))
 		prep_and_add_allocated_folios(h, &folio_list);
 
@@ -3487,6 +3536,7 @@ static void __init hugetlb_pages_alloc_boot_node(unsigned long start, unsigned l
 
 static unsigned long __init hugetlb_gigantic_pages_alloc_boot(struct hstate *h)
 {
+	int nid;
 	unsigned long i;
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
@@ -3495,6 +3545,9 @@ static unsigned long __init hugetlb_gigantic_pages_alloc_boot(struct hstate *h)
 		cond_resched();
 	}
 
+	for_each_node(nid)
+		i -= hugetlb_free_cross_zone_pages(h, nid);
+
 	return i;
 }
 
-- 
2.54.0


