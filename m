Return-Path: <linuxppc-dev+bounces-20912-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE976CD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:22:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvJx4v99z2yWK;
	Wed, 13 May 2026 23:22:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678561;
	cv=none; b=Oju1Tqt7CSMS7unDRmZkBhVZ1xrG9L1ZXTN0WpokjOXIRNYBqbMVrTXI8Gyrs/MGxfr9c3fvHebXnU0LPt8KPJ3/6em7jgeU/x7PzCrLC0qCMlwG91GY8iBiBlaqfflMaO9G+CFvut2B27owonO5ca1tTpyE8mGTk2L2syFTsVvzkRJo1qqlf/E4hXN8QEO6J0YvniTdHk/UZKNfz0IBDjvccRR2SM8H/GeUFH5L+P3jlJjqf6DF5edcqWFBRYURnMOQ91tBuicPAzpKykOlnzvYpgV9PlyGHQXUb3qmyBb2/imK3azuzAA+0sKLCthCrHjua6Q03kU796BCCTkuYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678561; c=relaxed/relaxed;
	bh=JweoZhL4wX+SrFX5pL1+i9XjuzkUT4z611TUJKtW0N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fe4XkiQgE4kAEghLCSZZhJSM1d+yQOt479Hd1f0HQOnbWP4qpfT/anNc5mtUvMyvVsLPRHVo/TWN2Bz1D7hvEirhd4KT1EqisUuOiwdRMNKOHIOpCiIrPGTsJ9fFtKYvvuN6+dQXKojMQV+jj+jK/R/4vWRbWxv3JaISi8n5Ycn2PH2IDkYSo/VWBMvU5c8/2pI/N1npOWthAiOg6m4XEUf1VfTgARq07JB0YcRCWBhlWsxs2EJ7O4kLAzvD2s6M2Iro186hGe3BWXYFSX0qxzW06wWposbrpAG2k6JgV6sa4P2I6htv5f1DZBwZUXEAra/zssnZ/N7xmkdPNtgPfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EV7KFMo5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EV7KFMo5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvJw6Phdz2yVv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:22:40 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2babfd18435so34605705ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678559; x=1779283359; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JweoZhL4wX+SrFX5pL1+i9XjuzkUT4z611TUJKtW0N4=;
        b=EV7KFMo5Uj1d89tDXHkUXFAQfyW/vq50luPlHxLemYEO2Xc88b7814utjO1PDv4Zi5
         9OPubCsJciWsiYyId/Mm5I0kCbc5HYYQCeHQ0O9XcurqAtWJbLMa3UqrGWJege/lCi/3
         j3ZS71+QruVPkD+nJTmCIZpdg0ZqjVvQy0UMwgQQjlCJvwdtQpcw6FbUsMfv0OTEpb3S
         OFAzAHJghy4DQCPn4B/UXa6rgWijWqDzl7RQMwUOeaOz5HXIilpYkQ8mIyR6HvK469+9
         /3QyZ7c6y9TO8buKc6FmORTgjU3ggFvTqqMAScbapgHCznvuZ/n4VidiqhgyTg81wI6/
         bObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678559; x=1779283359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JweoZhL4wX+SrFX5pL1+i9XjuzkUT4z611TUJKtW0N4=;
        b=ljxyxjtXkbbbowDjkbuYh6j5as5aP+9pDo5DHCC6+xHpvUgYzps0E7i0sir12O1aPx
         MwwEKhHGuBHTWBNd0V1tNrkCsM0vNBY8fAo8SYHpYcaAhALrADynPmkN8f9C5GSEVuQR
         D8QA7WwDRw8P6l+wtFJpKMwB6rDKL7gC5/jsTSDh10zOMhpdB5TSa4CPsKegQjigUS4D
         v+t3yQC75od4oosyYNrJ6gsLSuoBmjdQVo2sf9BS1bq+QfIx8Yk1LpnLz6xAY3wPQabl
         71SleHv6vbi5uO7htMKyOv/yib2A5iTjsGbuGvaaYqBbq4OpawHk2NjkgUnNnExmVbx4
         +PiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/YRQNg13k1Td9LqBBkSBo3ZR9IkHUGvA4zGKa9IuejXy+qvbE1EUFvHdo2RbbpEMi3XciaQs+Z86cdl4g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxmBvFcDrMy5DhBsMBLPrJs5bT8rQNtv148eQwM0OaKi9duHzf6
	Ih3GfrZ7jrgqlQAFKyOcuBzD6ITh2yKPTK1rPPHexR07W5qoilv+BbOCvflB0kmyy7c=
X-Gm-Gg: Acq92OFOeubJ540NHct4U+YSFH8866tIYGKnHd0vw2xkSVSw+Bq+Irfqo6+GA5P/ocx
	pIYo3pWLN7Dq30MVaT9BTtTi3cy5bQPjIqMgD90gAmK8GcchR5jVz6PFUvsY/wqJDS4O6vIbmAz
	1jnrTgzxy0R0uMvOt8mnUq5k3OFbs8Ph3K32klw9GVz/A1NjwYUGLZMhhrLPGCc30405pynILfz
	nVeMDccC1ZPOHJ6QCaDJh5QcJVxPISddS3jzD1sXXAOwjU9834kekhLLVUrUkyaJsonjkxtr+Gl
	flLB6GBik5OsYbLgELaVcYhBC0sfLYzgUbKL+HRwFe+HYuM2zREE8116GPaLSvjkvgvktrAIaQT
	w11VBlRx6c15dIP+9Scphh0N94GC0tr8RUMy0NZKjv3DOPCu9y+R7qiavQmPXz2eB/TrYvlMLYC
	qAm64egomFT144vh1xh9+vuDtXh7qaocL57j+tgdK7wAlu8UW/hgtf+UQ7Zbjs
X-Received: by 2002:a17:90a:fc44:b0:366:aba:4c86 with SMTP id 98e67ed59e1d1-368f3e62d47mr4012510a91.27.1778678558803;
        Wed, 13 May 2026 06:22:38 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.22.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:22:38 -0700 (PDT)
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
Subject: [PATCH v2 63/69] mm/hugetlb: Initialize the full bootmem hugepage in hugetlb code
Date: Wed, 13 May 2026 21:20:28 +0800
Message-ID: <20260513132044.41690-17-songmuchun@bytedance.com>
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

Boot-time gigantic hugepages currently leave the head struct page to
the generic memmap initialization path while the HugeTLB code
initializes the remaining struct pages itself.

Mark the full hugepage noinit and initialize the head struct page in
hugetlb_folio_init_vmemmap() as well, so the whole compound-page setup
is handled in one place.

This can also reduce memblock metadata overhead when many boot-time
HugeTLB pages are reserved, because physically contiguous hugepages
can be covered by fewer noinit regions.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 950b0fa3bc27..10f04fa95d43 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3112,15 +3112,7 @@ static bool __init alloc_bootmem_huge_page(struct hstate *h, int nid)
 		list_add_tail(&m->list, &huge_boot_pages[nid]);
 		m->flags |= HUGE_BOOTMEM_ZONES_VALID;
 		hugetlb_vmemmap_optimize_bootmem_page(m);
-		/*
-		 * Only initialize the head struct page in memmap_init_reserved_pages,
-		 * rest of the struct pages will be initialized by the HugeTLB
-		 * subsystem itself.
-		 * The head struct page is used to get folio information by the HugeTLB
-		 * subsystem like zone id and node id.
-		 */
-		memblock_reserved_mark_noinit(__pa((void *)m + PAGE_SIZE),
-				huge_page_size(h) - PAGE_SIZE);
+		memblock_reserved_mark_noinit(__pa(m), huge_page_size(h));
 	}
 
 	return true;
@@ -3129,16 +3121,13 @@ static bool __init alloc_bootmem_huge_page(struct hstate *h, int nid)
 static void __init hugetlb_folio_init_vmemmap(struct page *head, unsigned long pfn,
 		enum zone_type zone, int nid, unsigned int order, unsigned int nr_pages)
 {
-	int ret;
-
 	/*
 	 * This is an open-coded prep_compound_page() whereby we avoid
 	 * walking pages twice by initializing/preparing+freezing them in the
 	 * same go.
 	 */
-	__ClearPageReserved(head);
-	ret = page_ref_freeze(head, 1);
-	VM_BUG_ON(!ret);
+	__init_single_page(head, pfn, zone, nid);
+	set_page_count(head, 0);
 
 	__SetPageHead(head);
 	for (int i = 1; i < nr_pages; i++) {
@@ -3208,7 +3197,7 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 		struct folio *folio = (void *)page;
 		unsigned long pfn = PHYS_PFN(__pa(m));
 		unsigned long nr_pages = pages_per_huge_page(m->hstate);
-		enum zone_type zone = folio_zonenum(folio);
+		enum zone_type zone = zone_idx(pfn_to_zone(pfn, nid));
 
 		h = m->hstate;
 		/*
@@ -3220,7 +3209,6 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 		prev_h = h;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
-		WARN_ON(folio_ref_count(folio) != 1);
 
 		hugetlb_folio_init_vmemmap(page, pfn, zone, nid, huge_page_order(h),
 					   vmemmap_nr_struct_pages(pfn, nr_pages));
-- 
2.54.0


