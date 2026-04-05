Return-Path: <linuxppc-dev+bounces-19365-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCEDEEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:57:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXY46vqNz2yvV;
	Sun, 05 Apr 2026 22:57:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393832;
	cv=none; b=ShReN/H+9iD5qcrVMZLd212ZMoS3G+rc4/ZcxIzZjjBxRMEOVoJATJSDvkq4iq2IvQ+ICoJqYG6WPAGsvEn1MKhzDc8VIbrKoq0y8vsEb5SlH6AH2q4zX4lhnVS7vHKXLpmP0WYvm2lSMBGBK2e7VDqpWkPATi9WYz+Bbdu4Vgl1UukMyNYnyQnPz+N9TDvFG5sN4MAbKDJv44IXODncx30ay9tgBol353si5XKutK5F9f1MI7OXFARASYhVUwU7BA9BykdFJQkpiZBn3vMrmAtpuYLpD65HIP/1qOYkbp4WVki+aSOHrdol4r1i5BGAEJYJAoHeint8gl4XO/oi5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393832; c=relaxed/relaxed;
	bh=wYLFkhjHZeMhg1MIWamwRyHzBSmpgXxo2vlP0IB+Kzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8uEx794eJwA0VquwtKSWGypCqalo6vnIbdDEdlUNZ+enMyPNW4DMIXmXM72x01z5EUXpaSslGsvcZtzHQHDN1FU6/lF97gn5RdDYYNcNCmvBs8zsqXib9hT11uw9+AQE/L2znU+XxJuVDtMoBtVDdz8idl1gtnx6+VphkadhrKddlAOp6H8cbATxH57vLqEs0c/xLakM1B29+0rMC+T7hKa+dkez2GWpVSJI1klw2W+fk4miKyjdkkEr1mKYoxxH4p5yxU5KclOaH5xg36gzoIqp73KomAM0aFYnfVQGzlkeElfQDh45i72+utV2ZHKFFzOki9JLNQQDfXwYIqbgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Iduxrj5H; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Iduxrj5H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXY40NZwz2yvW
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:57:11 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-35d965648a2so2429796a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393830; x=1775998630; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYLFkhjHZeMhg1MIWamwRyHzBSmpgXxo2vlP0IB+Kzg=;
        b=Iduxrj5H7MwarRLQbAri7ePLBu9NMED67k/KoYwK+InmAb/63nraJtGaSUq60EtU0I
         J2fXPAMGL23cuMTAWqWNn+U1QZYH54H98sq/PxwHGpsxcS9p9YM+8AqHFokFwveyY75e
         fUWmDhjkMDEzmpJfKzAAmh6y7PKZ3hWdr3eMi1rfkx3TuAxX9eA/hMGOLvMF/5i8fpi+
         wLrO447mTgH9EPZnChR7RPJSMScZg5MtnWvePSoH8/a6niq8u0rkpC+37mesZ6bUZyHf
         0iU06OeVvfv5rdnPnqErL6hKydXdDb1AgTzdcSRQw+SbOiKGbSddYq+Dar3GbihZ3z4H
         SbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393830; x=1775998630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wYLFkhjHZeMhg1MIWamwRyHzBSmpgXxo2vlP0IB+Kzg=;
        b=ZjlMFudttQjmMY4Np2N3zhQyG3h6DdSZAFa7RqEsAIp8prGTCYbs4CwNxqVPBBLZl7
         +D2xp/i5jduX/A1Sh0Q23VvE6+DvGjCxugoWcU+D9sK5uLzhApZ7HiwIiAbSm3hcGJQO
         NKzrwI/Amu+Ge0bUqWyNTR7IcTKUllnDEez0X0v5OxFHNdueKmhLbuKArjcI767HvT1W
         UtdsTDWxAKDwSuQmS2R5Za4nSdYf21NDPdMJNOSg4WgtE1e5KrwsBLU7cpgiyyqHzz8i
         RI9zPCudTYpXpyrpu1UKIHglnA6G8VgiSaKGgWUS7u9E8/aHof4a8bEqmSLum3vUhzQB
         JtoA==
X-Forwarded-Encrypted: i=1; AJvYcCXjK7Nk1yWwn7B8YcA9/eLGHKsElHPyIFOKxqqa/0WhmG1PnvT6l9BwsEDWpm+2tvR5luoPzq56kYCh4J4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxkWQQrrNW0+BwACTKkLZmMqSlQ0DIHCsQ+7OLbawdOTwZcgsiU
	0OXoGL3JsZfkz8lQEYHJA1wOitBYRCZnwaaqjt0LKq0cKq3W7XC8k50RSQk5OYVk1Y8=
X-Gm-Gg: AeBDietYTx1VsLQNSjYN4GGd4U7co2C9NMKrqXUUJNtkVLjN8dOlzMMUSXcztDrQnS2
	t0iT/fPD5UQcUjflntrp4gxH5nY3SZEgODEp76b0D72Dz8/utq768biXGRktXRn+GvSPKTclG/x
	6gDi6pt+ZUQH7zNNDYQkJIzvotujpOpX5gRy5uZb73uk/7rahCvuLP7Cf12Jr53IwbyBSLRVo5z
	eZ4wMZLrXhtaBrgsT6BLNJebjSxdnVFh7Lix3TtcJeANmxCjIk0CXfFzv45sHzNbftHMQaDRl5H
	JswBRbAHqx+kbilwAqsEv3OXP9+kRzV6AyweXmMD45CU4K2/HAdNL7rL2xR3dbxCO1tAb01Hm+D
	ps58c4QzCrVh7PoYqqAw2hS6B8rDVj32oHjdzK0XWZ8qDz7tYJLe4nskmwPiBSUzpPNqpJJhTxa
	me8u1Fo2syGeZ7QGtAJNOiAsv0CuasFuVUYmEpP6VBPz4=
X-Received: by 2002:a17:90a:d005:b0:35d:9d28:e897 with SMTP id 98e67ed59e1d1-35de699f483mr8495535a91.28.1775393830042;
        Sun, 05 Apr 2026 05:57:10 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:57:09 -0700 (PDT)
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
Subject: [PATCH 35/49] mm/sparse-vmemmap: introduce section zone to struct mem_section
Date: Sun,  5 Apr 2026 20:52:26 +0800
Message-Id: <20260405125240.2558577-36-songmuchun@bytedance.com>
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

Currently, HugeTLB obtains zone information for vmemmap optimization
through early pfn_to_zone(). However, ZONE_DEVICE cannot utilize this
approach because its zone information is updated after vmemmap population.

To pave the way for unifying DAX and HugeTLB vmemmap optimization,
this patch introduces the 'zone' member to struct mem_section. This
allows both DAX and HugeTLB to reliably obtain zone information
directly from the memory section.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h | 31 +++++++++++++++++++++++++++----
 mm/hugetlb.c           |  2 +-
 mm/hugetlb_vmemmap.c   |  4 +++-
 mm/sparse-vmemmap.c    | 19 +++++++++++++------
 4 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 6edcb0cc46c4..846a7ee1334f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2022,6 +2022,7 @@ struct mem_section {
 	 * multiple sections.
 	 */
 	unsigned int order;
+	enum zone_type zone;
 #endif
 };
 
@@ -2214,32 +2215,54 @@ static inline void section_set_order(struct mem_section *section, unsigned int o
 	section->order = order;
 }
 
+static inline void section_set_zone(struct mem_section *section, enum zone_type zone)
+{
+	section->zone = zone;
+}
+
 static inline unsigned int section_order(const struct mem_section *section)
 {
 	return section->order;
 }
+
+static inline enum zone_type section_zone(const struct mem_section *section)
+{
+	return section->zone;
+}
 #else
 static inline void section_set_order(struct mem_section *section, unsigned int order)
 {
 }
 
+static inline void section_set_zone(struct mem_section *section, enum zone_type zone)
+{
+}
+
 static inline unsigned int section_order(const struct mem_section *section)
 {
 	return 0;
 }
+
+static inline enum zone_type section_zone(const struct mem_section *section)
+{
+	return 0;
+}
 #endif
 
-static inline void section_set_order_pfn_range(unsigned long pfn,
-					       unsigned long nr_pages,
-					       unsigned int order)
+static inline void section_set_compound_range(unsigned long pfn,
+					      unsigned long nr_pages,
+					      unsigned int order,
+					      enum zone_type zone)
 {
 	unsigned long section_nr = pfn_to_section_nr(pfn);
 
 	if (!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION))
 		return;
 
-	for (int i = 0; i < nr_pages / PAGES_PER_SECTION; i++)
+	for (int i = 0; i < nr_pages / PAGES_PER_SECTION; i++) {
 		section_set_order(__nr_to_section(section_nr + i), order);
+		section_set_zone(__nr_to_section(section_nr + i), zone);
+	}
 }
 
 static inline bool section_vmemmap_optimizable(const struct mem_section *section)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 59728e942384..ce5a58aab5c3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3281,7 +3281,7 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 
 		if (section_vmemmap_optimizable(__pfn_to_section(folio_pfn(folio))))
 			folio_set_hugetlb_vmemmap_optimized(folio);
-		section_set_order_pfn_range(folio_pfn(folio), folio_nr_pages(folio), 0);
+		section_set_compound_range(folio_pfn(folio), folio_nr_pages(folio), 0, 0);
 
 		if (hugetlb_bootmem_page_earlycma(m))
 			folio_set_hugetlb_cma(folio);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index a7ea98fcc18e..92c95ebdbb9a 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -681,11 +681,13 @@ void __init hugetlb_vmemmap_optimize_bootmem_page(struct huge_bootmem_page *m)
 {
 	struct hstate *h = m->hstate;
 	unsigned long pfn = PHYS_PFN(virt_to_phys(m));
+	int nid = early_pfn_to_nid(PHYS_PFN(__pa(m)));
 
 	if (!READ_ONCE(vmemmap_optimize_enabled))
 		return;
 
-	section_set_order_pfn_range(pfn, pages_per_huge_page(h), huge_page_order(h));
+	section_set_compound_range(pfn, pages_per_huge_page(h), huge_page_order(h),
+				   zone_idx(pfn_to_zone(pfn, nid)));
 }
 
 static const struct ctl_table hugetlb_vmemmap_sysctls[] = {
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 6f959a999d5b..1867b5dcc73c 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -143,6 +143,11 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 			start, end - 1);
 }
 
+static inline struct zone *section_to_zone(const struct mem_section *ms, int nid)
+{
+	return &NODE_DATA(nid)->node_zones[section_zone(ms)];
+}
+
 static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
 					      struct vmem_altmap *altmap,
 					      unsigned long ptpfn)
@@ -159,7 +164,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 			const struct mem_section *ms = __pfn_to_section(pfn);
 
 			page = vmemmap_shared_tail_page(section_order(ms),
-							pfn_to_zone(pfn, node));
+							section_to_zone(ms, node));
 			if (!page)
 				return NULL;
 			ptpfn = page_to_pfn(page);
@@ -471,16 +476,14 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start,
 	int rc;
 	unsigned long start_pfn = page_to_pfn((struct page *)start);
 	const struct mem_section *ms = __pfn_to_section(start_pfn);
-	struct page *tail = NULL;
+	struct page *tail;
 
 	/* This may occur in sub-section scenarios. */
 	if (!section_vmemmap_optimizable(ms))
 		return vmemmap_populate_range(start, end, node, NULL, -1);
 
-#ifdef CONFIG_ZONE_DEVICE
 	tail = vmemmap_shared_tail_page(section_order(ms),
-					&NODE_DATA(node)->node_zones[ZONE_DEVICE]);
-#endif
+					section_to_zone(ms, node));
 	if (!tail)
 		return -ENOMEM;
 
@@ -834,8 +837,12 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 		return ret;
 
 	ms = __nr_to_section(section_nr);
-	if (vmemmap_can_optimize(altmap, pgmap) && nr_pages == PAGES_PER_SECTION)
+	if (vmemmap_can_optimize(altmap, pgmap) && nr_pages == PAGES_PER_SECTION) {
 		section_set_order(ms, pgmap->vmemmap_shift);
+#ifdef CONFIG_ZONE_DEVICE
+		section_set_zone(ms, ZONE_DEVICE);
+#endif
+	}
 	memmap = section_activate(nid, start_pfn, nr_pages, altmap, pgmap);
 	if (IS_ERR(memmap))
 		return PTR_ERR(memmap);
-- 
2.20.1


