Return-Path: <linuxppc-dev+bounces-20913-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A46ECD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:23:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvK36Gbwz3cMg;
	Wed, 13 May 2026 23:22:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678567;
	cv=none; b=ONczu84TVd4okF/xeNV2pIqne+8IIRxMjxA5vXUE3WIH8iSRSIemflLHTeFRcMzIiFMIOavV/HWpP6s5sshWza5EcVug/Hu3ipeaPeiEmnrCzB77SCE93vUy/K04iDM9x8GO0V29dmQZdA3Qi3IRDwPippbRE7w0wHwUP7EdHzlWHCQ/9ya/prONO/ZLrd6RG85d6AKtHkaRe+Ig6RRVMD05kRxLeT/1vMN5xchNly/FXBpoAtllHqGp/EoMY9t9GHdCUC58wpGrxR6HM4Yy6fkpQvyG9oe41yQpdWCgvbThqRN3GBtYfc/9ef7+nftJ+Y6JuVCdGGauAgBk8YeNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678567; c=relaxed/relaxed;
	bh=flkX+tolfoJMepk6tCll9FGS1Em3GZPOVlthey3SFjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5smcyX7tIZVI1C4XsDNIB8tqZJw31As10/G8B8OIv8/IP6+0hEPtWlLQukm5OiisUKtVMKqdwdfeIPlYfdFv/j/vNLDdIMOBB5tzLEuW3+uIvZNFiA5y5nRrwhMejsknVRVAj6H7rWWCDAMqsnBlrg+L/nckSG9Qris/ldy/8arzOlWkuZprYbKrsce7Q0o1q5zdJGzowkb2GA4oiMpfCJXmJVLp19KPBah2LdDk74LVZE0sSIMvPBglP68IDeQ4avVbbVllJUrDxcvzKOYjcbz+q1yScT+qVUPvKkNqcVTzfcy0p0RPNrXAlpIzZCp55AInal5runqYEy9aCVv9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=YT4h8y2b; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=YT4h8y2b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvK31FKXz2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:22:47 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-366375c43c2so3972348a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678565; x=1779283365; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flkX+tolfoJMepk6tCll9FGS1Em3GZPOVlthey3SFjQ=;
        b=YT4h8y2btbEiOpw1NHTDHy+IpoB+sJfCp1Xt1inAWDUsV3iLz0VpFm8CZmhH4WnBpP
         xlHQS1N64xHlQchojbpo5bgLTJx9gwBq2VrpmK715rs+VmGeDQuyw7ucmfwn3w5YcHpT
         KB34DxFXHoaUSwuSl/B+9HPgAyW7PfU3pEs11P3XG26hG15uFBBFUR5vJM0m6jJzlh52
         vC15SeU1OM/Ol8gQ1oTh28T+jZSUUx/cvMnFYouXfxYBIOA3JPxNlSrzCZ+YCYRms6f/
         v2FRSyKY+4GOX2E2ykQHE9qQpqEU9Mg8H6bfW8/ebXaySTuUdrKIkrrcppK/Yx75qa3/
         O49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678565; x=1779283365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=flkX+tolfoJMepk6tCll9FGS1Em3GZPOVlthey3SFjQ=;
        b=DFPUVN15tYtRSdoMOU6N1Qk/ehyV7g7SFXop3VCAraM8IMRNgGXWazMpX1vZjaXHH5
         deXhy6a4oa1g2Ny0DGWFIFM0VT1nmVDQnD6Vh2vWcOhN9NLp9jGoPartpiMoik3O+Pv0
         bChlxQHrZjZwJsZdEyfXxBHUI/wMSMBmqW5hD32vbCDb19xXiorxtWleYP495lFMcHHi
         MwFMP3wkeX5XJ2s+Vz/0icffAVHm2MkQcoYGKUE8Wf9xn5waRSarnTUMWwDVAFsfGLKJ
         z7vMeryKLKg7mB456q95JrEIGCBV1xLCKUsmJ/Eevta+624vuPLpC8YC5CNllz02m/p9
         XWRg==
X-Forwarded-Encrypted: i=1; AFNElJ/i/yVeNeDwaghyI/Wmd1NeFLimwtcfqeKzHhAlq+fc8i99HMFgtRl/AGZwdyuWlg+W362swVwfqaRQfEI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxp8b1/6PsbdBWYtXvHx5LBhLo/9VqTbUDERMf0FEQSPp5+qpGv
	uHLlQ5MZK8+KtN7CHsEXT/I3YrWBE3yGm03+iwcXdDi7Nq28E9gp9T3krMIWQh6uGdM=
X-Gm-Gg: Acq92OGB5osViyJxIuqaMO6CVeEcu6oRZHySBpssyaVDx15Y4ONIWwmnmM1XDVX78ER
	BFAowhBWIi0JZASJw8Zc/3MjCHl29oOOKliqh7Mz+oW1FTJPjcGB09OBluzd+0ppz3RMu1w7uTP
	aqifO8foEeucTtljGx7PFrE3snQq7ECxlqFzMF++Gy0PTXCeZPD4hquO5xRsL2ER+obrmrGrv8F
	LYNt9wcGTgb/o8pqBXJYLY9tMvCLqIEoeylJC8zquqA8stArczNivyRP4oj/Bd4FGK711rDdp90
	R5yWzaFe+8g80B877i37uxZmh+d18GwsZpeqKkAtGvYFKrWEjelRehcC7e3L98dqyUSMQm4L4r0
	Vgi6PWsZImtkj99uXAsXNL8gGQmPEV0CEFqFJHVKPAn19CQJb/3u9Rgl+Cq9QGMfFl1tJ2xaAOa
	0iW28GGlzrKfdwPJHEMikNGDz5Wz5MCwlauJJVTynmygxutOqOW2pQanm1PfL3hC4bcr9TCq0=
X-Received: by 2002:a17:90b:53cf:b0:35e:3103:d4d8 with SMTP id 98e67ed59e1d1-368f3ad4a1emr3575522a91.6.1778678565011;
        Wed, 13 May 2026 06:22:45 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.22.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:22:44 -0700 (PDT)
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
Subject: [PATCH v2 64/69] mm/mm_init: Factor out compound page initialization
Date: Wed, 13 May 2026 21:20:29 +0800
Message-ID: <20260513132044.41690-18-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513132044.41690-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513132044.41690-1-songmuchun@bytedance.com>
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

The compound struct page initialization needed by boot-time gigantic hugetlb
folios is currently open-coded in hugetlb code, while ZONE_DEVICE has its own
separate initialization path in mm_init.c.

Factor the common compound memmap setup into memmap_init_compound_page_frozen()
so both paths can share the same frozen page initialization logic. This removes
duplicated open-coded compound page setup and keeps the initialization rules
in one place.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c  |  25 +-----------
 mm/internal.h |   2 +
 mm/mm_init.c  | 111 +++++++++++++++++++-------------------------------
 3 files changed, 45 insertions(+), 93 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 10f04fa95d43..7e9f49882395 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3118,28 +3118,6 @@ static bool __init alloc_bootmem_huge_page(struct hstate *h, int nid)
 	return true;
 }
 
-static void __init hugetlb_folio_init_vmemmap(struct page *head, unsigned long pfn,
-		enum zone_type zone, int nid, unsigned int order, unsigned int nr_pages)
-{
-	/*
-	 * This is an open-coded prep_compound_page() whereby we avoid
-	 * walking pages twice by initializing/preparing+freezing them in the
-	 * same go.
-	 */
-	__init_single_page(head, pfn, zone, nid);
-	set_page_count(head, 0);
-
-	__SetPageHead(head);
-	for (int i = 1; i < nr_pages; i++) {
-		struct page *page = head + i;
-
-		__init_single_page(page, pfn + i, zone, nid);
-		prep_compound_tail(page, head, order);
-		set_page_count(page, 0);
-	}
-	prep_compound_head(head, order);
-}
-
 /*
  * memblock-allocated pageblocks might not have the migrate type set
  * if marked with the 'noinit' flag. Set it to the default (MIGRATE_MOVABLE)
@@ -3210,8 +3188,7 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
 
-		hugetlb_folio_init_vmemmap(page, pfn, zone, nid, huge_page_order(h),
-					   vmemmap_nr_struct_pages(pfn, nr_pages));
+		memmap_init_compound_page_frozen(page, pfn, zone, nid, huge_page_order(h));
 		init_new_hugetlb_folio(folio);
 
 		if (order_vmemmap_optimizable(pfn_to_section_order(pfn))) {
diff --git a/mm/internal.h b/mm/internal.h
index 416afdf7b2ec..2c67ae25124b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1793,6 +1793,8 @@ static inline bool pte_needs_soft_dirty_wp(struct vm_area_struct *vma, pte_t pte
 
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid);
+void __meminit memmap_init_compound_page_frozen(struct page *head, unsigned long pfn,
+		enum zone_type zone, int nid, unsigned int order);
 
 /* shrinker related functions */
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 95422e92ede8..9b23c31db8c6 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1018,79 +1018,46 @@ static void __init memmap_init(void)
 		init_unavailable_range(hole_pfn, end_pfn, zone_id, nid);
 }
 
-#ifdef CONFIG_ZONE_DEVICE
-static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
-					  unsigned long zone_idx, int nid,
-					  struct dev_pagemap *pgmap)
+static void __meminit init_single_page_frozen(struct page *page, unsigned long pfn,
+		enum zone_type zone, int nid)
 {
+	__init_single_page(page, pfn, zone, nid);
+	if (zone_is_zone_device(&NODE_DATA(nid)->node_zones[zone])) {
+		/*
+		 * ZONE_DEVICE pages are not managed by the page allocator, mark
+		 * them reserved to prevent them from being touched elsewhere.
+		 *
+		 * We can use the non-atomic __set_bit operation for setting
+		 * the flag as we are still initializing the pages.
+		 */
+		__SetPageReserved(page);
 
-	__init_single_page(page, pfn, zone_idx, nid);
-
-	/*
-	 * Mark page reserved as it will need to wait for onlining
-	 * phase for it to be fully associated with a zone.
-	 *
-	 * We can use the non-atomic __set_bit operation for setting
-	 * the flag as we are still initializing the pages.
-	 */
-	__SetPageReserved(page);
-
-	/*
-	 * ZONE_DEVICE pages union ->lru with a ->pgmap back pointer
-	 * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
-	 * ever freed or placed on a driver-private list.
-	 */
-	page_folio(page)->pgmap = pgmap;
-	page->zone_device_data = NULL;
-
-	/*
-	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
-	 * directly to the driver page allocator which will set the page count
-	 * to 1 when allocating the page.
-	 *
-	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
-	 * their refcount reset to one whenever they are freed (ie. after
-	 * their refcount drops to 0).
-	 */
-	switch (pgmap->type) {
-	case MEMORY_DEVICE_FS_DAX:
-	case MEMORY_DEVICE_PRIVATE:
-	case MEMORY_DEVICE_COHERENT:
-	case MEMORY_DEVICE_PCI_P2PDMA:
-		set_page_count(page, 0);
-		break;
-
-	case MEMORY_DEVICE_GENERIC:
-		break;
+		/*
+		 * ZONE_DEVICE pages union ->lru with a ->pgmap back pointer
+		 * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
+		 * ever freed or placed on a driver-private list.
+		 */
+		page->zone_device_data = NULL;
 	}
+	set_page_count(page, 0);
 }
 
-static void __ref memmap_init_compound(struct page *head,
-				       unsigned long head_pfn,
-				       unsigned long zone_idx, int nid,
-				       struct dev_pagemap *pgmap,
-				       unsigned long nr_pages)
+void __meminit memmap_init_compound_page_frozen(struct page *head, unsigned long pfn,
+		enum zone_type zone, int nid, unsigned int order)
 {
-	unsigned long pfn, end_pfn = head_pfn + nr_pages;
-	unsigned int order = pgmap->vmemmap_shift;
+	int nr_pages = vmemmap_nr_struct_pages(pfn, 1UL << order);
 
-	/*
-	 * We have to initialize the pages, including setting up page links.
-	 * prep_compound_page() does not take care of that, so instead we
-	 * open-code prep_compound_page() so we can take care of initializing
-	 * the pages in the same go.
-	 */
-	__SetPageHead(head);
-	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
-		struct page *page = pfn_to_page(pfn);
+	init_single_page_frozen(head, pfn, zone, nid);
 
-		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
-		prep_compound_tail(page, head, order);
-		set_page_count(page, 0);
+	__SetPageHead(head);
+	for (int i = 1; i < nr_pages; i++) {
+		init_single_page_frozen(head + i, pfn + i, zone, nid);
+		prep_compound_tail(head + i, head, order);
 	}
 	prep_compound_head(head, order);
 }
 
+#ifdef CONFIG_ZONE_DEVICE
 void __ref memmap_init_zone_device(struct zone *zone,
 				   unsigned long start_pfn,
 				   unsigned long nr_pages,
@@ -1118,18 +1085,24 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	}
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
-		struct page *page = pfn_to_page(pfn);
-
-		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
+		struct page *head = pfn_to_page(pfn);
 
 		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
 			cond_resched();
 
-		if (pfns_per_compound == 1)
-			continue;
-
-		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     vmemmap_nr_struct_pages(pfn, pfns_per_compound));
+		if (pgmap->vmemmap_shift)
+			memmap_init_compound_page_frozen(head, pfn, zone_idx, nid,
+							 pgmap->vmemmap_shift);
+		else
+			init_single_page_frozen(head, pfn, zone_idx, nid);
+		/*
+		 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
+		 * directly to the driver page allocator which will set the page
+		 * count to 1 when allocating the page.
+		 */
+		if (pgmap->type == MEMORY_DEVICE_GENERIC)
+			init_page_count(head);
+		((struct folio *)head)->pgmap = pgmap;
 	}
 
 	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE, false, false);
-- 
2.54.0


