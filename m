Return-Path: <linuxppc-dev+bounces-20910-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9276ECD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:22:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvJj2c7gz30T9;
	Wed, 13 May 2026 23:22:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678549;
	cv=none; b=V3XDQ//fpI/0vC6F3bxE/tHVnwmuGvjMw9palwJnk6igoCwUzYfZL85TJJTRj2ONJJMrqCjCRzB7jKQ6wciWRm8PBPmQawekkXgqWhMxfcN+arSbdgoQO4UdaiFs330Alj5kBNYISmlhyVVtUXgU2e/eiqvljsecVEtilqk55TRhCBB49I35zo3xfAk+AiE1NQ3PPoOA97c6B4XMSlSft1S6IjfdqePH5OjwFQ5AN+5rfmmAMTyuK1HiJi9/Iaqnws+YKAwKdCiNtskbAEddymZemJ3bdTP9RCj3DURfpmGj1LWmc0Gu4D52RVDGVt5LrTq0jkw4AjAA0FVSzq2ufA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678549; c=relaxed/relaxed;
	bh=5LFbqiG/RD0CCzo7+/AP1zWQqzbysWKSZNji4RwzSyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGsacAI+SoFu7OaCPJ1Gqr/P0zmxLUgTm4UdU1tWjAjTkZaMrkjU2lzLcKSkMC1M6l/iP1/p1bjGVrZzTLUXtz+FFluBPnHuifw0rBFuxjqw5iXcnhjjEbUpHoFH34eAca/I2zXB0Wx55wSjUT5WomgimfbRw7rRoHx+/rFPz6g9Vuh/L2yEEcDGAPw3BFCEVeFIvLgTR/DWGHTkqX/iIuN/xe6n+v8pbi6p0ScuiBE9ayzxXWq3W0yKw0FYuqyiw3r+rvLTjSD0H6i3ea+VLbxkoRLrqdVCSc0zgTEjS+69KelZ0Ciq1FAR1M8TAk3UvXHW271JuYwqlu4CNdZteQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gy0RaltD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gy0RaltD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvJh4ZPKz30DV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:22:28 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-367c2a39fcfso2512613a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678547; x=1779283347; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LFbqiG/RD0CCzo7+/AP1zWQqzbysWKSZNji4RwzSyY=;
        b=gy0RaltDCqMJ/8gNmEu/INTkeYEMluy1FM1CckKIkN7mKjHSdOnzosMkmpbo37TEWp
         d2J7C3OPiLb6Sykjogtj7LlUO0PFCdYmNRTivxV49x6kMh3z5HPtI/DoWopxb4vq1UKn
         LzWZNHGkP53DZWGMHUFxWCsueAkxUcwkoMvmCSsTcI6bVV1ezwr0EqJfUzmxVEW/2I8T
         K1GseGcIOgSirfyYTZP8s2Ax9oOyIPrH+mBO/sH3s1IjYIKCcjRPFj6WJbygeo+1phCm
         bp4BmQc5QT95AHKi0NW1CQQLodMQ2sWNtn7YTbl4ei+3O6qFYRnXPBsTArXmI0glBSzW
         1psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678547; x=1779283347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5LFbqiG/RD0CCzo7+/AP1zWQqzbysWKSZNji4RwzSyY=;
        b=ZyJ/oL3nsS7KFbbgc+P3kWUIepypj+SW777vcIWldnkjFeE3SlH/rkPIP8Kbqk4Qsy
         1UrXA0haIWFC9jBQfH2gqRyMmDe4cRmOisaHXzvFIo+z23YqOcbdrYmVwJEuOpbxfigA
         DgEpCnRq6l2jiVE3tyHcZ3YR8M6JYhLrNCwS6Pq0SNPFFzooDwlaWdcDo9aI1i6BEbdu
         I1LZihsN4/O83s/r8WYAmScA7ZLu9VrjSp7x+VSbaZGN3bDYm23jE4PZ0AE4cJzkE9+J
         4p7I0JbH52Qm2aMk7uQ0wGlP2yWo/0LBKcrqi4sjrJL5oNwc2gmL3f1R9+zPDKtKGJ94
         ftfw==
X-Forwarded-Encrypted: i=1; AFNElJ9U5/HaYEqgH3gxoFzct2JJ2MPmT8dRrclHT9/K3/Y371oJmaaQA/mkVibbN80Hj9oQ9s0a16K+0xg0Cto=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxr98vhupoOnnPd60SnaTNSU+85a/q1h+vU0PdHir5U29s7NWbJ
	IUjX1st4QG4OcclzxbXYsgDa2oM5d+NSPhHmyTfoyJ+/C1Yi2qANt/pvycRWB7/8FFw=
X-Gm-Gg: Acq92OE23ldSmg6xgeTvaRF6FiGZD9VXi1FKjUF5XDGUzE7oYLbTmrhLyJJcFMgyZ2H
	M7g5V1k1oCMPLNZuDOUFiWrco+gERTkDv/FCwcSt3MUbtPcR1lfk7f2bUU9E38TLl7b+EEgiAVU
	hfuRVsiACyzrZ1QKAHmto1jda7r4Yn1pgMeMVDB9bRjVNJ3t9biUw2T7Klq4qURMafruxTLN4EC
	kaKde3q8k4woy280DOmgufUwAkK4yI9jWupNpwgr8Rkgg8vEnc2lyYnuqlxnf1OtMqy464+Lh0i
	JWrQI6WiMhRG0mc2E+KY4ra2WU1DXA1ND0+4CqAXXLwjmq8XVUQ3z+C3dTz5pyjC9AuhSXF1THO
	GfknJ6TZksoO7IK7w4vNyYFCMBpOGCfzjjrwFYbx/7sZ1djGBb06fzPBi9Dc/bjNWfG9iEwvByj
	TBi4pJamxtyChiGhnKncr+W/Y/F6kPc19kxLybjHXAgJRmgZWXvYo5bwCKhTwnJO89grl+Koo=
X-Received: by 2002:a17:90a:da8b:b0:368:ddd7:abca with SMTP id 98e67ed59e1d1-368f79e8cfbmr3065574a91.26.1778678546422;
        Wed, 13 May 2026 06:22:26 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.22.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:22:25 -0700 (PDT)
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
Subject: [PATCH v2 61/69] mm/hugetlb: Drop boot-time HVO handling for gigantic folios
Date: Wed, 13 May 2026 21:20:26 +0800
Message-ID: <20260513132044.41690-15-songmuchun@bytedance.com>
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

HugeTLB HVO is currently supported on x86-64, riscv64, and LoongArch.
On x86-64 and riscv64, gigantic HugeTLB pages are larger than the
section size, so the existing section-based vmemmap optimization
infrastructure is already sufficient to cover the whole folio.  On
LoongArch, HugeTLB HVO is supported without gigantic HugeTLB pages.

Therefore, boot-time HugeTLB HVO folios can rely on the section-based
vmemmap optimization infrastructure directly, without the extra bulk
optimization and fallback handling.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         | 25 ++++++-------------------
 mm/hugetlb_vmemmap.c | 21 ++++++---------------
 mm/internal.h        | 25 +++++++++++++++++++++++--
 mm/sparse.c          | 23 -----------------------
 4 files changed, 35 insertions(+), 59 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bd136fc6aec0..3cb8fffb9e3e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3201,21 +3201,7 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 	unsigned long flags;
 	struct folio *folio, *tmp_f;
 
-	/* Send list for bulk vmemmap optimization processing */
-	hugetlb_vmemmap_optimize_folios(h, folio_list);
-
 	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
-		if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
-			/*
-			 * If HVO fails, initialize all tail struct pages
-			 * We do not worry about potential long lock hold
-			 * time as this is early in boot and there should
-			 * be no contention.
-			 */
-			hugetlb_folio_init_tail_vmemmap(folio, h,
-					OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES,
-					pages_per_huge_page(h));
-		}
 		hugetlb_bootmem_init_migratetype(folio, h);
 		/* Subdivide locks to achieve better parallel performance */
 		spin_lock_irqsave(&hugetlb_lock, flags);
@@ -3238,6 +3224,8 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 	list_for_each_entry_safe(m, tm, &huge_boot_pages[nid], list) {
 		struct page *page = virt_to_page(m);
 		struct folio *folio = (void *)page;
+		unsigned long pfn = PHYS_PFN(__pa(m));
+		unsigned long nr_pages = pages_per_huge_page(m->hstate);
 
 		h = m->hstate;
 		/*
@@ -3251,13 +3239,12 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(folio_ref_count(folio) != 1);
 
-		hugetlb_folio_init_vmemmap(folio, h,
-					   OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES);
+		hugetlb_folio_init_vmemmap(folio, h, vmemmap_nr_struct_pages(pfn, nr_pages));
 		init_new_hugetlb_folio(folio);
 
-		if (order_vmemmap_optimizable(pfn_to_section_order(folio_pfn(folio)))) {
+		if (order_vmemmap_optimizable(pfn_to_section_order(pfn))) {
 			folio_set_hugetlb_vmemmap_optimized(folio);
-			section_set_order_range(folio_pfn(folio), folio_nr_pages(folio), 0);
+			section_set_order_range(pfn, nr_pages, 0);
 		}
 
 		if (hugetlb_early_cma(h))
@@ -3274,7 +3261,7 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 		 * (via hugetlb_bootmem_init_migratetype), so skip it here.
 		 */
 		if (!folio_test_hugetlb_cma(folio))
-			adjust_managed_page_count(page, pages_per_huge_page(h));
+			adjust_managed_page_count(page, nr_pages);
 		cond_resched();
 	}
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 1305bee1195a..d20d2ce13906 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -599,23 +599,17 @@ static int hugetlb_vmemmap_split_folio(const struct hstate *h, struct folio *fol
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
-	unsigned long nr_to_optimize = 0;
 	LIST_HEAD(vmemmap_pages);
 	unsigned long flags = VMEMMAP_REMAP_NO_TLB_FLUSH;
 
-	list_for_each_entry(folio, folio_list, lru) {
-		int ret;
-
-		/*
-		 * Bootmem gigantic folios may already be marked optimized when
-		 * their vmemmap layout was prepared earlier, so skip them here.
-		 */
-		if (folio_test_hugetlb_vmemmap_optimized(folio))
-			continue;
+	if (!vmemmap_should_optimize(h))
+		return;
 
-		nr_to_optimize++;
+	if (list_empty(folio_list))
+		return;
 
-		ret = hugetlb_vmemmap_split_folio(h, folio);
+	list_for_each_entry(folio, folio_list, lru) {
+		int ret = hugetlb_vmemmap_split_folio(h, folio);
 
 		/*
 		 * Splitting the PMD requires allocating a page, thus let's fail
@@ -627,9 +621,6 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 			break;
 	}
 
-	if (!nr_to_optimize)
-		return;
-
 	flush_tlb_all();
 
 	list_for_each_entry(folio, folio_list, lru) {
diff --git a/mm/internal.h b/mm/internal.h
index aff7cebb1da4..416afdf7b2ec 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -949,6 +949,29 @@ void memmap_init_range(unsigned long, int, unsigned long, unsigned long,
 		unsigned long, enum meminit_context, struct vmem_altmap *, int,
 		bool);
 
+static inline int vmemmap_nr_struct_pages(unsigned long pfn, unsigned long nr_pages)
+{
+	const unsigned int order = pfn_to_section_order(pfn);
+	const unsigned long pages_per_compound = 1UL << order;
+
+	if (!order_vmemmap_optimizable(order))
+		return nr_pages;
+
+	if (order < PFN_SECTION_SHIFT) {
+		VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_compound));
+		return OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES * nr_pages / pages_per_compound;
+	}
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
+	/* Ensure the requested range does not cross a compound page boundary. */
+	VM_WARN_ON_ONCE((pfn % pages_per_compound) + nr_pages > pages_per_compound);
+
+	if (IS_ALIGNED(pfn, pages_per_compound))
+		return OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES;
+
+	return 0;
+}
+
 /*
  * mm/sparse.c
  */
@@ -988,8 +1011,6 @@ static inline void __section_mark_present(struct mem_section *ms,
 	ms->section_mem_map |= SECTION_MARKED_PRESENT;
 }
 
-int vmemmap_nr_struct_pages(unsigned long pfn, unsigned long nr_pages);
-
 static inline int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages)
 {
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION));
diff --git a/mm/sparse.c b/mm/sparse.c
index 598da1651e49..21a0eb636fea 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -236,29 +236,6 @@ void __weak __meminit vmemmap_populate_print_last(void)
 {
 }
 
-int __meminit vmemmap_nr_struct_pages(unsigned long pfn, unsigned long nr_pages)
-{
-	const unsigned int order = pfn_to_section_order(pfn);
-	const unsigned long pages_per_compound = 1UL << order;
-
-	if (!order_vmemmap_optimizable(order))
-		return nr_pages;
-
-	if (order < PFN_SECTION_SHIFT) {
-		VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_compound));
-		return OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES * nr_pages / pages_per_compound;
-	}
-
-	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
-	/* Ensure the requested range does not cross a compound page boundary. */
-	VM_WARN_ON_ONCE((pfn % pages_per_compound) + nr_pages > pages_per_compound);
-
-	if (IS_ALIGNED(pfn, pages_per_compound))
-		return OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES;
-
-	return 0;
-}
-
 /*
  * Initialize sparse on a specific node. The node spans [pnum_begin, pnum_end)
  * And number of present sections in this node is map_count.
-- 
2.54.0


