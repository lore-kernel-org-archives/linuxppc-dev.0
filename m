Return-Path: <linuxppc-dev+bounces-20917-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C33CD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:23:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvKX44c0z3cQm;
	Wed, 13 May 2026 23:23:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678592;
	cv=none; b=M3lQSzzgewAUMChyJWuCLnH4X7u6nuI2Bxbc+Ku+lUbFPDTqQjzQd0qb2P3FFqBV7oNTnfgTrBjoIpGo0/e2DmOH8qarGhKNEygIMqAMUXMGNrF9ft3/OsUW3tcYd5vfK6s4eAzfdHXN7FAliTv3rMXT2pwrDuI+rY/1zqE/iKaolVBSCNn9d4+MOaxws+d5MzxJ5px5NPxI7WjVDD1f0nl8QlZO36WoOP7Inmdblon716nC6pjiBxi9TRcvSNN+cFnIoplho8Ct/ceZ0njXw37jUOwmZUC+cFUNz8xgC18A6zbpD1hCzSWSkiM4LXPxfM6JHSrNJqkW9xHkZJ/QNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678592; c=relaxed/relaxed;
	bh=EHqr9wHSnVyYVNoFiVSVd8oLdOOQgIPkLvJW4qLJj/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LK0DoRPyrTT0uHMK0lPcBJPva5cZ02xT1lmZbamdttElGgG2ZoSn5YvqD8jqeVpaVoo3O7sXmHYjWO6iSAu+pP+SE3932/GY8bWULYV6F3Zw9+451n4MtJlxsDUhel7ZaIMJtFp3U5eHwzbfcVl3vus6rMJ39vyPETV6vZEDO9PmUriQb8ic7SlCM07Vhaa2ER2b39kEnqNOW54NKjGh06KhbQeZOgrGmHv4DGeosFG43y6uoNnNbW3MdbTwqpGvPtr6pazVDNU/ro8V+tkLs3wFjY8jPR/VwDossiyO7lquCU67+F6tFf1XV9DrcA+//KE1vc5PGQb2UfXOHxaAag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=UO3Ceo6D; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=UO3Ceo6D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvKW5wbkz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:23:11 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so671871a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678590; x=1779283390; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHqr9wHSnVyYVNoFiVSVd8oLdOOQgIPkLvJW4qLJj/0=;
        b=UO3Ceo6Dq/tqnbWz4bVzMOOuNRqkAlp1uqYxULQ+kv0VDFxx5pr4T3sf9DA9ZXN5bL
         NVWqPJxBfej2mODWghuo7jhuV8kIExV0XNQeMyT0KpNDerp7y0+9WyoN9Kx2sZNkbMC8
         vqIshfqqfjjoKx+ICQEkTZ2UOm8FL+qyUEad3sy+lMACU77qmiXBkglmMrXwFAb9hAm+
         w5avi/F5ium6RhASnutIovM8p9mWj7tBUaMIgUcHMtqc0eCIb/IanHT/2fPoxaFruNAd
         jIu22yeQRMXHKisb7sX15/cT5goCaARODbNvHtGiFD0FdDP1X1CdAD0/RQHQOUr/1Nzl
         rhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678590; x=1779283390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EHqr9wHSnVyYVNoFiVSVd8oLdOOQgIPkLvJW4qLJj/0=;
        b=ZTU5720B0rN1s+ddW4dFwGV9iowRSJ9fr6NFOiCj1kzOjIfcmgs1KnHCZ+38rKJSL+
         nrNyc++qmt+3B4aTvaPbpgJaQF00ILlPK85KaenMTGICnqhQU57EyLNMQeYZUFxdrrnp
         0UI3v37Y+35bCETRy/5So666l9yGH/Y4CjdL2n0swseMrxPkcfmFotEJnzoQxGv9FgHo
         YJ2CqC0RmKp3vdZNT9SIn29YjJbPoQhtMU/3RAqn+TI/rjTuAAAG/wpixc6u1LKdocXF
         249EccE4I9+jr/H/PY1HIwgYSqLgFlR+Tfd969IzIWI7ql1zEgPFt3Y2zidnkyuWP5Mi
         L0HA==
X-Forwarded-Encrypted: i=1; AFNElJ+2D9RnUGsPgch3YEEoK91Ca6b58wyfLy+pCojxgBzYRT+SGtXAtDxio5MRx9eGKiJrRDWbol7Q9BKVlYo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxRXxCuIrH+/ir69wE8pBhoR9MgJbe5dPhzNBpxA5OpWidsrLjd
	hWTV7sPPawPvJ1nFq0MWoxVKpdDFPrYzUWwhaonEkX8jxvfh6Cje2RCrpthLkOxuoBc=
X-Gm-Gg: Acq92OHi/VN7hYoViJ6DC8Qvewp8o6NBm94UnhK+/WR5EAHL02RSPME3+oNjudj+e7C
	U2FBSEuq8RQHcL3DMF1NZxc9flCUFDVcnskDXKIED3ONCd8iVwTVAtv72Wzp1Mm+fbJAd2qdizK
	u3AAEffshJet/hgWX64w2uGjM9khYwQchBfITVvBL9YS/3PqDrwlfIKxQhXS5BaEwO9lnSSjgsr
	h0TEpxOf6Nk6zPPsmxSidE6Nca9z7bda343frvdPm4rn2oEiZFZyoTDbjX6keAdEtZCSIBLzEbS
	ff+rgUYoEEiSFNDOFMJcVoqe9QWXdG9dXH4jJiOXjSF7hlCayKDYTXvhwmsm4GELVio/mNGSELg
	xfU4xT1+IhaU6MiUix8+wNVcwxrl/5qfYkl4+rT2m3xD4tjTxNtP+1b38pDkYqavIfOdv7r55Ez
	GBb4h3Jk7F5JMGd7AbPAioHlzU4eTJHsbGQEd3ghAFL5bhvags+pYCXFnIcLKw
X-Received: by 2002:a17:90a:d610:b0:35d:a3b4:2f0d with SMTP id 98e67ed59e1d1-368f3bd73f7mr3554267a91.6.1778678589854;
        Wed, 13 May 2026 06:23:09 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.23.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:23:09 -0700 (PDT)
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
Subject: [PATCH v2 68/69] mm/mm_init: Initialize pageblock migratetype in memmap init helpers
Date: Wed, 13 May 2026 21:20:33 +0800
Message-ID: <20260513132044.41690-22-songmuchun@bytedance.com>
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

Move MIGRATE_MOVABLE pageblock initialization into the memmap init
helpers in mm/mm_init.c.

Let init_single_page_frozen() initialize the pageblock migratetype for
single-page folios, and let memmap_init_compound_page_frozen() handle
the whole range for compound pages. With pageblock initialization
centralized there, drop the duplicate hugetlb bootmem-specific
initialization in mm/hugetlb.c.

The old hugetlb_bootmem_init_migratetype() skipped CMA folios (via
folio_test_hugetlb_cma()), but the new helpers always set
MIGRATE_MOVABLE. This is safe because cma_activate_area() will later
override the migratetype for CMA pageblocks, so the initial
MIGRATE_MOVABLE setting does not matter for CMA pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 25 -------------------------
 mm/mm_init.c | 20 ++++++++++++--------
 2 files changed, 12 insertions(+), 33 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index df798f9386d6..fa269560f657 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3118,30 +3118,6 @@ static bool __init alloc_bootmem_huge_page(struct hstate *h, int nid)
 	return true;
 }
 
-/*
- * memblock-allocated pageblocks might not have the migrate type set
- * if marked with the 'noinit' flag. Set it to the default (MIGRATE_MOVABLE)
- * here, or MIGRATE_CMA if this was a page allocated through an early CMA
- * reservation.
- *
- * In case of vmemmap optimized folios, the tail vmemmap pages are mapped
- * read-only, but that's ok - for sparse vmemmap this does not write to
- * the page structure.
- */
-static void __init hugetlb_bootmem_init_migratetype(struct folio *folio,
-							  struct hstate *h)
-{
-	unsigned long nr_pages = pages_per_huge_page(h), i;
-
-	WARN_ON_ONCE(!pageblock_aligned(folio_pfn(folio)));
-
-	for (i = 0; i < nr_pages; i += pageblock_nr_pages) {
-		if (!folio_test_hugetlb_cma(folio))
-			init_pageblock_migratetype(folio_page(folio, i),
-					  MIGRATE_MOVABLE, false);
-	}
-}
-
 static void __init prep_and_add_bootmem_folios(struct hstate *h,
 					struct list_head *folio_list)
 {
@@ -3149,7 +3125,6 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 	struct folio *folio, *tmp_f;
 
 	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
-		hugetlb_bootmem_init_migratetype(folio, h);
 		/* Subdivide locks to achieve better parallel performance */
 		spin_lock_irqsave(&hugetlb_lock, flags);
 		account_new_hugetlb_folio(h, folio);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index ff6e9fb468bd..17ae0eb1ccfb 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1018,7 +1018,7 @@ static void __init memmap_init(void)
 		init_unavailable_range(hole_pfn, end_pfn, zone_id, nid);
 }
 
-static void __meminit init_single_page_frozen(struct page *page, unsigned long pfn,
+static void __meminit __init_single_page_frozen(struct page *page, unsigned long pfn,
 		enum zone_type zone, int nid)
 {
 	__init_single_page(page, pfn, zone, nid);
@@ -1042,19 +1042,28 @@ static void __meminit init_single_page_frozen(struct page *page, unsigned long p
 	set_page_count(page, 0);
 }
 
+static void __meminit init_single_page_frozen(struct page *page, unsigned long pfn,
+		enum zone_type zone, int nid)
+{
+	__init_single_page_frozen(page, pfn, zone, nid);
+	pageblock_migratetype_init_range(pfn, 1, MIGRATE_MOVABLE, false, false);
+}
+
 void __meminit memmap_init_compound_page_frozen(struct page *head, unsigned long pfn,
 		enum zone_type zone, int nid, unsigned int order)
 {
 	int nr_pages = vmemmap_nr_struct_pages(pfn, 1UL << order);
 
-	init_single_page_frozen(head, pfn, zone, nid);
+	__init_single_page_frozen(head, pfn, zone, nid);
 
 	__SetPageHead(head);
 	for (int i = 1; i < nr_pages; i++) {
-		init_single_page_frozen(head + i, pfn + i, zone, nid);
+		__init_single_page_frozen(head + i, pfn + i, zone, nid);
 		prep_compound_tail(head + i, head, order);
 	}
 	prep_compound_head(head, order);
+
+	pageblock_migratetype_init_range(pfn, 1UL << order, MIGRATE_MOVABLE, false, false);
 }
 
 #ifdef CONFIG_ZONE_DEVICE
@@ -1087,9 +1096,6 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
 		struct page *head = pfn_to_page(pfn);
 
-		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
-			cond_resched();
-
 		if (pgmap->vmemmap_shift)
 			memmap_init_compound_page_frozen(head, pfn, zone_idx, nid,
 							 pgmap->vmemmap_shift);
@@ -1105,8 +1111,6 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		((struct folio *)head)->pgmap = pgmap;
 	}
 
-	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE, false, false);
-
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
 		nr_pages, jiffies_to_msecs(jiffies - start));
 }
-- 
2.54.0


