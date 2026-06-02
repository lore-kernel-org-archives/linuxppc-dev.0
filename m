Return-Path: <linuxppc-dev+bounces-21889-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA59CD6E61
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:12:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV67x3NjMz3br2;
	Tue, 02 Jun 2026 20:12:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395133;
	cv=none; b=nkgZJWKGta70UE4sr3JnwMUQndLIIusI5zBlFEEOoZKsgD2SPf3ZKcafoxxJjk7G56fVvxu+YHctft28+vHGqeC6W9maaMs+bMA/hJalEdkRgCI+eS26LosQCszHnVEuPu53M/mNbhJn/Uzw+pfbcns1amiD1NLctsGn96qlwdAN6TZauqWBiHRPgkn3RGl54PIOniAExYlR9v3F7JF71K4fGUToo7+AtBeezotU1Uq3T7PuLsLML3UiFSPBtWZxn3oURS4i9Krmf/3zmN/zzqhjXfTNxuUszJmPULUYkqRupmUufnqD/ttTrVeSABAsR+OZacGhum/KB18SPnfJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395133; c=relaxed/relaxed;
	bh=E/u6lKC7hQ/GhzoNdcnEA7gND1myfeYXkd1NgoaUr0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpNwRNe/hGrSSvYUWgwkNuekoIVzyd+fbnDKGz/TlExni3AQjkeHlVNgcvQz0/toLiRf68PrieDmZWey1b8YDGxkAT76mgcMniY5IURSJNgZQmIwpU0MZ1BdfohS56JSQB0EvEEabWWpu3eJ5mih/islViTC46PfHE5w+oIUUo0uAw9KtjZxzCLyJkohAhu+qRLRTC65pj+yBd8pJ8lvZdoe5MRCExPU3pQkq0HE8YXkSfs58X9B/5jzb6FYhrexysc5+MJTMeGlnEJRwcaoR29QZJVkGsiC+4iC/WoRSDFGFQZZAu+as8CZ8ZZT4DLFezSpnWpdV35udMR8j3CLNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ZXxgE4OX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ZXxgE4OX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV67w5SSpz3bqh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:12:12 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-84232e83ca9so1043706b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395131; x=1780999931; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/u6lKC7hQ/GhzoNdcnEA7gND1myfeYXkd1NgoaUr0Y=;
        b=ZXxgE4OXn2wGNcUXbq+Bwdd7l4JFjBloFMZraiYFfzD/aeW5gBfjulRGjLTy98p+E/
         u6hwTNhboKgneF7g5sGyRZOhcsVtpxa5apuVuouGanRDQDSzKZJ/WoIR8+P8iFMUocnY
         0WK+VQbsf1F6hkYgdXcvbAb50ibZvNhOsvUp7rNrXk2AMV7bOyf74P+Ba5sZUGJLuDql
         EGKgD8K8aiY09AAunuJI1xnXEfIZMabYUrSgJh5FcCqbqjcWrBDVUJFiI9kt9kDVUqsd
         bWrlOkUKAt6PuXs5AKP3T2T3bA2v8ynGfYsIrf/AJ1OCD43Bb5MFDiUFqi7CaV6LZIT+
         ZCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395131; x=1780999931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E/u6lKC7hQ/GhzoNdcnEA7gND1myfeYXkd1NgoaUr0Y=;
        b=nD+2rWANrhzpg6ALtVKAeWbHV2h5z+QBzn1vwXRQQSjjLOL578ACxYMz2+cEaLEzMN
         XpK7S3VoLo7gkIiINN7yWdD0jkaVUxzPNfUC4K7031SZtAcTlRHhonMBGhW1fBQPE/5S
         c7ftiaQ0gduFGjXS4f8/Nn9qW35U2FCmV9/7dhWVYXrYY3RjPvqDOrrDvwrexcEKWUx/
         qdMdUBa9+ppuiwN9GjvRJuG+BFMTE5W2BcfJtXk42iuBgeUk+PgG+CpE5ezvhNpCMbJG
         dV0qd0/UnG5QtD8+uhz5/XT0oEfv+z1xsJMbEXDQkWLCMYK72mvHOHlk9fyDAawVimZq
         2sww==
X-Forwarded-Encrypted: i=1; AFNElJ9SYS5C1Zfvpb7rt3tjMf7DIqtUq7IRsvw/EHqJjca3Gex+9z3tSwlzL16GvWWzFUaVRM66tYqYNKH4OE8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw9ef2LpX0EshDde0FRPtKoCSZzCq9LxRJSs3KoAH1cjTfK8NXl
	axZctXNBgBR/E+8wIr+GuB2XOvuMnJUxwnZF6oVhgrrRJuFFROx5OaAYFFoN7UailaM=
X-Gm-Gg: Acq92OEAtp/5aoE4hKsK0R+K4ov9KyJHzmNLgWIAYSQdfed2EAWaBaVaDxfdvUmbDd6
	4/j+KNXovR/6x1iVe6UbNlwvzQhhfjxbSkQ5sFb05NST++MVX4BHnt0Hz7L5LPRapHtaDBVZxGR
	DGk9ueWjUZNolTTiQ2y/jpUXImZADHn3MW8VmLoNapiMElEreSCXH9tXkjLJIQODrEfRPgZcz28
	U1q1JCVkCAEb6O1VHvwOvmJEZiZys1059KuBc7opG2XgA/8dG1D++iDPWxO7jKQyWms7w69TpBl
	x1DjnMNBUcOQdj/YUdipi4ldWEQMsl35GF1tKMKpc3KAJdUJG5A3fzqTXWqlKkA/h0vvQ+hBcyp
	TcxcN17dp6XI0LK5vxl6hrZm3+Aewfk9k6uTkSyn2fa1Aac1ZYBjNBaqJO4BMh2HIVzuqaPz2ut
	7h4DvDpVEnaXMN8TFNg3Tq5glnou7FIWSnto9XFFV0TKfSrWq+Lp5iEvk=
X-Received: by 2002:a05:6a00:2da7:b0:842:7a78:8f14 with SMTP id d2e1a72fcca58-8427a789a5cmr998275b3a.6.1780395130964;
        Tue, 02 Jun 2026 03:12:10 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:12:10 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 14/19] mm/hugetlb: Free cross-zone bootmem gigantic pages after allocation
Date: Tue,  2 Jun 2026 18:10:34 +0800
Message-ID: <20260602101039.1867613-15-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602101039.1867613-1-songmuchun@bytedance.com>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
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


