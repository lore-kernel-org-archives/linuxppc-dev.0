Return-Path: <linuxppc-dev+bounces-19362-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD143F3D5E1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:57:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXXk22Vdz2yvM;
	Sun, 05 Apr 2026 22:56:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393814;
	cv=none; b=KEhTB6slFN4RYdXWdR1QWiPxofDbzS/PGqPSvWwhgJAmgF5PIJxE9pUaKsQHNK0TMBhW4ilJqaK4i6VUG3blIhV2N6w/rzwGpWHfIj/CrTq3URILqmjsoLJ3ht5t7NCRtHENq1C2Lpn3Ce1hVWzTbr+hBn7l5iWFXBlB2DSAQq82KbAjX5Yz5T3LGfnyiMsi9vQHWK3wiUnq+ZNXqC8w6vE8jt4gA7jEI2ANvUMjWOn+U+VAAe72cD1ROY9UNz3JNfuaBdlTpzJITjhGIA01MJcq+RpuwptULTKa/YBfRJJGjdAjGjwFZJIulvuBi3zPQRmnDMW3Nc09un7mOB3fsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393814; c=relaxed/relaxed;
	bh=A80UjlR159hWaMO6LOhQ/IhxwfIv1wi1/ZVyLQIlI8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hEVDvmoApkkTloZO6QtxBEPAgU3ffuUlyH9kz+4HAb0YVnt1SEhgc2wUQ/Sfv7J0hw9EtECxfoNqInEWOP4LAVRh3y/K+0j/geZMeadTCC21zvy5heLSEKtTHESm7n6gG2fzheBVl4TKG28T+5lIdIFuRma4mP684vxme4zkqzMy52dTEHjzO+HqtoOllIu80IV8lvxB2avBjqTVSAEBmrzqFxiXTn2kth4nNfLxUPR/twy/dM++NZD4DFyU/l3OMvatjE8VYL8gYBrNqMg3YI/n0k4rJzrp4Pegm+EeLBv0vB9ns+OUmHgG77jBK4TZMEIt0kGFUeIXH3+4MD8HyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ca6xQcsy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ca6xQcsy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXXj4MPRz2ynH
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:56:53 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso2170158a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393812; x=1775998612; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A80UjlR159hWaMO6LOhQ/IhxwfIv1wi1/ZVyLQIlI8g=;
        b=ca6xQcsyvFCFIiAisekWPmO78kOipAUPrX7VqZhsHMF7sVd4XGwmbtGFfis8fSiXjw
         2giTTzi/tvu31zlKzio7s+wBEonoc04M+AraEly6xqHXfs6lANIGxp6+mwzWwvxAuMCb
         dCwnjGh4jr7In8Btx7NBeKv+3SqcHAYn+Lut2h83ByyQcUlEl5Yu3ZU7S6oAMeiqbKoD
         TKRlesP3QVy63Hbss/rzUf/GKIy8Dk5BKovLZIm6s3rqSVfT/PdZd3n2WPSxOnB1v2/I
         2vxjm8LoPdfD1KjFTzaP/HuK1kcGjDnCUblp6ECF1oSHRgGr4bTXrhgxaoxd9Et8L1NE
         uz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393812; x=1775998612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A80UjlR159hWaMO6LOhQ/IhxwfIv1wi1/ZVyLQIlI8g=;
        b=Qsq2flp1xZtuOuk3TFLEEKrf7MOizcaBdNwjbDBT9gZoMUzC+5IjHfgaN7bEgcBIV0
         hI4tK6+YCMbflZd1HlZ1933vwol2H1IPagIm6lrxtB6zv5hZRwiZCiaMhveRzRP/inpT
         3beB8SdfZtlso2Ji6as5YA7czvNQJMACmE4IOlw31EpNdX9hFNz8phjRj9MgvSpHlQgk
         OBAWfh9Nh2GHFIFo2nsTaQLshTYOfT9fvH8rd4ShxW2BnAHD0BYJoiCncRQPDtZrCStA
         S55UwlektsiPMadHI2MlnOX5/MgFDCm11MUjlK9iuhG5xVnGf0zkEb8lvjLPDNV8BPlK
         Aq4g==
X-Forwarded-Encrypted: i=1; AJvYcCV+Ui1i4+2JwxXapcnDkv5lhqVLQCGyLfyup6PEirwxDGTLeaHLRURnZjVMALgx4wvEQIwXeP5hQBh+Jtc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyuxa5FXA999Cw6OSOEenSYzxZxP9FMuwGBYdJmHqu1SMVLxW99
	mHmOBXGk2Cv0g8NMsLJWsDCPmU8N0B2aILBMh4subduY0z8bxkWgQKyo+i67dTfeJqM=
X-Gm-Gg: AeBDietn8qHDL9snTuVt8EJcNx4QfgbYKvHqhlKrddnlFcroJkQ1flcZJEbNsZsGlAJ
	mO9pGcgm25p9Lm4QOQclbwdy6wbp2nrUC4s0UX34dYEFEVgaMO13L+GqsCLf0UTRexQbEPXkFDs
	W0b5QG1GA3tEYxz1LFUAQbACvxRSgIczbaffFGaoey7nxC6xtOjDCqskyAjdIzNp4aEMTxSnjRx
	KaDZXKP3fwNZyk1jvYWQwdwfhgUuJjHeKYEg/1Bq0xN01x9wO7TD7C6oVtNUGNbtcHuwFy4tD2f
	yi6qnawh5ckA3cH8qszTHfFpnWJdpcrOtCOvWroOw5AoQOodh5rh1h3a4PKyTIFu0JPqAJwcbuN
	CzmZPxHIMMKnQ1QjUPxHtTx2C56VK7IamL4IyhdJPBMuJmhso+EmtPJ6BchVibKnhBKu4qLqBUu
	t1K6kIyw5Aam71ygwlBf2V03l8UVl+7u5IqZfNaEtcq04=
X-Received: by 2002:a17:90b:3889:b0:34c:2db6:578f with SMTP id 98e67ed59e1d1-35de691abfcmr8431895a91.19.1775393811585;
        Sun, 05 Apr 2026 05:56:51 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:56:51 -0700 (PDT)
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
Subject: [PATCH 32/49] mm/sparse-vmemmap: consolidate shared tail page allocation
Date: Sun,  5 Apr 2026 20:52:23 +0800
Message-Id: <20260405125240.2558577-33-songmuchun@bytedance.com>
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

Currently, both HugeTLB and sparse-vmemmap have their own logic to get
or allocate the shared tail page for vmemmap optimization. The HugeTLB
version handles runtime concurrency using cmpxchg, while the
sparse-vmemmap version (used only at boot time) was simpler.

This patch unifies them into a single function in mm/sparse-vmemmap.c.

The new function of vmemmap_shared_tail_page() is introduced: it returns
the shared page frame used to map the tail vmemmap pages of a compound
page.

Furthermore, vmemmap_alloc_block_zero() is used as a safe allocation
method for both situations:

1. It calls alloc_pages_node() (via vmemmap_alloc_block()) when slab is
   available.

2. It falls back to bootmem allocation during early boot, making the function
   suitable for use in both early boot (sparse-vmemmap init) and runtime
   (HugeTLB HVO) contexts.

This reduces code duplication and ensures consistent behavior.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h   |  1 +
 mm/hugetlb_vmemmap.c | 28 +---------------------------
 mm/sparse-vmemmap.c  | 42 +++++++++++++++++++++---------------------
 3 files changed, 23 insertions(+), 48 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 93e447468131..15841829b7eb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4880,6 +4880,7 @@ int vmemmap_populate(unsigned long start, unsigned long end, int node,
 void vmemmap_wrprotect_hvo(unsigned long start, unsigned long end, int node,
 			  unsigned long headsize);
 void vmemmap_populate_print_last(void);
+struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
 #ifdef CONFIG_MEMORY_HOTPLUG
 void vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index a190b9b94346..a7ea98fcc18e 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -493,32 +493,6 @@ static bool vmemmap_should_optimize_folio(const struct hstate *h, struct folio *
 	return true;
 }
 
-static struct page *vmemmap_get_tail(unsigned int order, struct zone *zone)
-{
-	const unsigned int idx = order - OPTIMIZABLE_FOLIO_MIN_ORDER;
-	struct page *tail, *p;
-	int node = zone_to_nid(zone);
-
-	tail = READ_ONCE(zone->vmemmap_tails[idx]);
-	if (likely(tail))
-		return tail;
-
-	tail = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
-	if (!tail)
-		return NULL;
-
-	p = page_to_virt(tail);
-	for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++)
-		init_compound_tail(p + i, NULL, order, zone);
-
-	if (cmpxchg(&zone->vmemmap_tails[idx], NULL, tail)) {
-		__free_page(tail);
-		tail = READ_ONCE(zone->vmemmap_tails[idx]);
-	}
-
-	return tail;
-}
-
 static int __hugetlb_vmemmap_optimize_folio(const struct hstate *h,
 					    struct folio *folio,
 					    struct list_head *vmemmap_pages,
@@ -535,7 +509,7 @@ static int __hugetlb_vmemmap_optimize_folio(const struct hstate *h,
 		return ret;
 
 	nid = folio_nid(folio);
-	vmemmap_tail = vmemmap_get_tail(h->order, folio_zone(folio));
+	vmemmap_tail = vmemmap_shared_tail_page(h->order, folio_zone(folio));
 	if (!vmemmap_tail)
 		return -ENOMEM;
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index c35d912a1fef..309d935fb05e 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -143,8 +143,6 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 			start, end - 1);
 }
 
-static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *zone);
-
 static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
 					      struct vmem_altmap *altmap,
 					      unsigned long ptpfn)
@@ -160,8 +158,8 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 			unsigned long pfn = page_to_pfn((struct page *)addr);
 			const struct mem_section *ms = __pfn_to_section(pfn);
 
-			page = vmemmap_get_tail(section_order(ms),
-						pfn_to_zone(pfn, node));
+			page = vmemmap_shared_tail_page(section_order(ms),
+							pfn_to_zone(pfn, node));
 			if (!page)
 				return NULL;
 			ptpfn = page_to_pfn(page);
@@ -338,32 +336,34 @@ void vmemmap_wrprotect_hvo(unsigned long addr, unsigned long end,
 	}
 }
 
-static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *zone)
+struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone)
 {
-	struct page *p, *tail;
-	unsigned int idx;
-	int node = zone_to_nid(zone);
+	void *addr;
+	struct page *page;
+	unsigned int idx = order - OPTIMIZABLE_FOLIO_MIN_ORDER;
 
-	if (WARN_ON_ONCE(order < OPTIMIZABLE_FOLIO_MIN_ORDER))
-		return NULL;
-	if (WARN_ON_ONCE(order > MAX_FOLIO_ORDER))
+	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(zone->vmemmap_tails)))
 		return NULL;
 
-	idx = order - OPTIMIZABLE_FOLIO_MIN_ORDER;
-	tail = zone->vmemmap_tails[idx];
-	if (tail)
-		return tail;
+	page = READ_ONCE(zone->vmemmap_tails[idx]);
+	if (likely(page))
+		return page;
 
-	p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
-	if (!p)
+	addr = vmemmap_alloc_block_zero(PAGE_SIZE, zone_to_nid(zone));
+	if (!addr)
 		return NULL;
+
 	for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++)
-		init_compound_tail(p + i, NULL, order, zone);
+		init_compound_tail((struct page *)addr + i, NULL, order, zone);
 
-	tail = virt_to_page(p);
-	zone->vmemmap_tails[idx] = tail;
+	page = virt_to_page(addr);
+	if (cmpxchg(&zone->vmemmap_tails[idx], NULL, page) != NULL) {
+		VM_BUG_ON(!slab_is_available());
+		__free_page(page);
+		page = READ_ONCE(zone->vmemmap_tails[idx]);
+	}
 
-	return tail;
+	return page;
 }
 
 void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
-- 
2.20.1


