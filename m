Return-Path: <linuxppc-dev+bounces-20898-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8CECD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:21:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvHF66j4z2xSb;
	Wed, 13 May 2026 23:21:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678473;
	cv=none; b=kBeclQpbS29HnebVSG0RkFhNWBHFlU/HWLPmOfMeKOTwj/h/C2fQ32Km9/miJ7xkhN7nfHW8G2FHBWucRNjG11B5BIO1aiZKGD7Ew0UozeHOlTR+YR+1FaPqXE7uXUZl2M+wM6QJoAxzSlzAhHRNVuoRmBt5ocSvwZhsxWe7H02VAbZn7lBKj7eqFghceTc6wOtxW1sUhE1JYB8ZB9PjcKHv+lobnM8TmNlfNxc1Mzm8E170xxqYqcymwxFkWbzzqmvl1scqJKXhZ1zbtIuypqnc3bcx1Sm8tsSBBsUIIXF33jcHic0/JfT19JP/nU8yKCHu9s6SHejj7Huud9tXZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678473; c=relaxed/relaxed;
	bh=e4zXGt+6aCEAt5utokxBlmTHRiyLkdnOANcW299C8MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=js1GTKDXLmQLaGVrQSN9DcbhCpflhA/GhKTMuXm54mcJWi3IuDeTMVGDoabyGLlck30GbBBi+4g3bP9L81/SM9pIe9p23lQe9Sm2Rrd2QdLKCuyRk2e1PfeHOf6zWAfDYiEvMVmz0rz/2djYOKY4f2sGEm/o/CUpHHwY77LGB3UUHAtbM7cH8Ixqbb7VW6fIBaWIJfVQQevr363lRyYzZc23ys9yN4MnFYdb7a+MyuSPznDo9mAhuXpHdfUgJ+zQC8FEZNFv8gYZsZeunXt6JV6AnSQTEjVxqpST1z5Di+CFYDilUwDBWUpJ96KpPutm+Fz04GM0CxfHThDn0mYkUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lPkwpkW7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lPkwpkW7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvHD5z2Tz2ySN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:21:12 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-36523acb0c1so4788021a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678471; x=1779283271; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4zXGt+6aCEAt5utokxBlmTHRiyLkdnOANcW299C8MM=;
        b=lPkwpkW7FBCoqc26tvHY+PCERUJ2WEUgN3T9gKYCglLWppb3MY+ikyCT53rwZJUxMQ
         ywIqPGBj3ebGv1jdJs+3ENgZTgOFYUG4kqa3yFyoBYYNbDyh9Ojl38dhR5sgDS6y8v5u
         //vRNfRoXbIFHMmg+Ma2ziqxAxJ9yDRCS98XukOpNCa7XT0zNXncfhn9FT6X6WDw6M+b
         YJLsRspAT3asri/g2hZHrCReEig+H8ZejrovEq92w/h2tCv7NDIn2VfFIUCsqiFwAeTc
         baAeGOLk7WLDduVi6y5JXi9ctK2kOnj8uPnTqzGoOQvhgFaJvFJs1MypxPDL3rXLrBXQ
         aAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678471; x=1779283271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e4zXGt+6aCEAt5utokxBlmTHRiyLkdnOANcW299C8MM=;
        b=APTx2/yukt6AMVcP7rH/ruPI5NzI5Szca5zPZgpD/CPcSgNeps4mXUz1k7eMero7GP
         xKHp5ZtmgsoHHUs7Tv1W9y4RYZ3Wsxx+4Muevd+RLZvs1O/3LLlgqJkwSRRuYZBPL30w
         LHR0uwBYnP/4NbvmiDUszqgOY49xmC8RUXAF3yFPDcFD3hNDNYSEXydFGQCZadpUJo+7
         INb+72eQBbvwdTy4Qfci7TDEI3aAEWeKHkr4ADeZXTlK9RaI8bc7sCl6F+C0lXPNCO5k
         vzmVwvH2s+OnIRf8X29j6pp1dgVCI2zjIqnTuqm+5s+KQPpnLc59DFxwncUpx4u4wn9L
         2egw==
X-Forwarded-Encrypted: i=1; AFNElJ/Z7iMvm+gA2pgCeQN6a7jJFRcFw+RHjf/EPoreo4yacEdTt8jYqWFf7zE66ZYGqUgqDoHCPM+eQ6xAGLQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx9WEKM8SWBE/k+ZnnjpyhL8aEm4k8dDLqwomNoB+JJANXwRN2K
	SohXZxVjVXpPA6C9D1sN+cgS0wz4kb85SVYH6/xACcttDTBB07JBapGQ9POS2aAOXVM=
X-Gm-Gg: Acq92OEjcpaAMM6ksiWJiTYkj+M6JubCw7CpHd0q3YwHvupKLMnG6Kqzt4OZgu6mBsS
	raf9BLfItf2K4tTgV6m14ZwEZnnaxTSp/mXF4POxGybnfSDZSZemJfIBvC0iaf0o+Dgwz6Hrehr
	eYh4CVhHcezQryBPOmSi44Pe4Oms/TW0zVOf0QwxNuosXaeQUkP9U5f1lwT3abDTa8R5jBPpyD4
	jncaV+EpuC64aXc2q41YEs9X/Q63RvnO+FaEQ/NL5Ikm3SPWc/WHZrJC6WnFgmMlEv4m7FdyUFz
	WVqIryg5cfqz9rYe9+jMSmjAV/xdrfqxStHf1TraTMG02ifYYpD7IpOwayXLkVccsZHA9rq7HIb
	eQO05XuX4FRwmCJwqkSK/yzUoQE+7Dqe7KbP6+ekiybliQFN+V804cgH3itYztpi5Gdp/WoZAiX
	Y+OVJKdhX52RUZZyG+79BmMxugBwquYW1CkRrJ5tGqxgQzqL+OPKyMwKxnSjsc
X-Received: by 2002:a17:90a:d610:b0:35d:a3b4:2f0d with SMTP id 98e67ed59e1d1-368f3bd73f7mr3546310a91.6.1778678470505;
        Wed, 13 May 2026 06:21:10 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.21.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:21:10 -0700 (PDT)
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
Subject: [PATCH v2 49/69] mm/hugetlb_vmemmap: Remove vmemmap_wrprotect_hvo()
Date: Wed, 13 May 2026 21:20:14 +0800
Message-ID: <20260513132044.41690-3-songmuchun@bytedance.com>
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

Shared vmemmap tail pages are now mapped read-only when their PTEs are
installed, so HugeTLB bootmem optimization no longer needs a separate
write-protect pass afterwards.

Remove vmemmap_wrprotect_hvo() and the bootmem-specific HugeTLB wrapper,
and let bootmem folios use the normal hugetlb_vmemmap_optimize_folios()
path.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h   |  2 --
 mm/hugetlb.c         |  2 +-
 mm/hugetlb_vmemmap.c | 45 +++++++++-----------------------------------
 mm/hugetlb_vmemmap.h |  6 ------
 mm/sparse-vmemmap.c  | 23 ----------------------
 5 files changed, 10 insertions(+), 68 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 86d7cecb834e..5e38c9a16a0a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4863,8 +4863,6 @@ int vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 			       int node, struct vmem_altmap *altmap);
 int vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap);
-void vmemmap_wrprotect_hvo(unsigned long start, unsigned long end, int node,
-			  unsigned long headsize);
 void vmemmap_populate_print_last(void);
 struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 74770c1648fc..54ef7d12c585 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3202,7 +3202,7 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 	struct folio *folio, *tmp_f;
 
 	/* Send list for bulk vmemmap optimization processing */
-	hugetlb_vmemmap_optimize_bootmem_folios(h, folio_list);
+	hugetlb_vmemmap_optimize_folios(h, folio_list);
 
 	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
 		if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index d24143dd6051..fce772e95adc 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -595,31 +595,22 @@ static int hugetlb_vmemmap_split_folio(const struct hstate *h, struct folio *fol
 	return vmemmap_remap_split(vmemmap_start, vmemmap_end);
 }
 
-static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
-					      struct list_head *folio_list,
-					      bool boot)
+void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
-	int nr_to_optimize;
+	unsigned long nr_to_optimize = 0;
 	LIST_HEAD(vmemmap_pages);
 	unsigned long flags = VMEMMAP_REMAP_NO_TLB_FLUSH;
 
-	nr_to_optimize = 0;
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret;
-		unsigned long spfn, epfn;
-
-		if (boot && folio_test_hugetlb_vmemmap_optimized(folio)) {
-			/*
-			 * Already optimized by pre-HVO, just map the
-			 * mirrored tail page structs RO.
-			 */
-			spfn = (unsigned long)&folio->page;
-			epfn = spfn + hugetlb_vmemmap_size(h);
-			vmemmap_wrprotect_hvo(spfn, epfn, folio_nid(folio),
-					OPTIMIZED_FOLIO_VMEMMAP_SIZE);
+
+		/*
+		 * Bootmem gigantic folios may already be marked optimized when
+		 * their vmemmap layout was prepared earlier, so skip them here.
+		 */
+		if (folio_test_hugetlb_vmemmap_optimized(folio))
 			continue;
-		}
 
 		nr_to_optimize++;
 
@@ -636,14 +627,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 	}
 
 	if (!nr_to_optimize)
-		/*
-		 * All pre-HVO folios, nothing left to do. It's ok if
-		 * there is a mix of pre-HVO and not yet HVO-ed folios
-		 * here, as __hugetlb_vmemmap_optimize_folio() will
-		 * skip any folios that already have the optimized flag
-		 * set, see vmemmap_should_optimize_folio().
-		 */
-		goto out;
+		return;
 
 	flush_tlb_all();
 
@@ -668,21 +652,10 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 		}
 	}
 
-out:
 	flush_tlb_all();
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
-void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
-{
-	__hugetlb_vmemmap_optimize_folios(h, folio_list, false);
-}
-
-void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h, struct list_head *folio_list)
-{
-	__hugetlb_vmemmap_optimize_folios(h, folio_list, true);
-}
-
 void __init hugetlb_vmemmap_optimize_bootmem_page(struct huge_bootmem_page *m)
 {
 	struct hstate *h = m->hstate;
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 0d8c88997066..2b0a85e09602 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -17,7 +17,6 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 					struct list_head *non_hvo_folios);
 void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
-void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h, struct list_head *folio_list);
 void hugetlb_vmemmap_optimize_bootmem_page(struct huge_bootmem_page *m);
 
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
@@ -59,11 +58,6 @@ static inline void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list
 {
 }
 
-static inline void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h,
-						struct list_head *folio_list)
-{
-}
-
 static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
 	return 0;
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 5d5cd5f73365..ce1cf5cdf613 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -265,29 +265,6 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 	return 0;
 }
 
-/*
- * Write protect the mirrored tail page structs for HVO. This will be
- * called from the hugetlb code when gathering and initializing the
- * memblock allocated gigantic pages. The write protect can't be
- * done earlier, since it can't be guaranteed that the reserved
- * page structures will not be written to during initialization,
- * even if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
- *
- * The PTEs are known to exist, and nothing else should be touching
- * these pages. The caller is responsible for any TLB flushing.
- */
-void vmemmap_wrprotect_hvo(unsigned long addr, unsigned long end,
-				    int node, unsigned long headsize)
-{
-	unsigned long maddr;
-	pte_t *pte;
-
-	for (maddr = addr + headsize; maddr < end; maddr += PAGE_SIZE) {
-		pte = virt_to_kpte(maddr);
-		ptep_set_wrprotect(&init_mm, maddr, pte);
-	}
-}
-
 struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zone)
 {
 	void *addr;
-- 
2.54.0


