Return-Path: <linuxppc-dev+bounces-19768-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC540F41990
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 11:15:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwdpR1kqCz30T9;
	Wed, 15 Apr 2026 21:14:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776251695;
	cv=none; b=gkWMRWqGmOtBM5nYRZyVYmzvdjutEPetPsXrwcA05T3rcqMzfrirQPyWT/HuMtCM9WPOsrQtiXk39tu24fG+KWS7VOMOoFRSi3XoWtpwiMHy8M/AO3T+paGUa9/ozNEPppwDawS/2vgLx5+NLtLT2QrNdGNTTRZrsopGIwvPT8RLgQu1PcOj+mUKPXctvAe5amEJ8GofCIX05ppJlVFJpOovboQdZ8RxjJ/lmJkEQpdGmpuUF/cB4vBa/QwG/F8ALMxVYK2Uqa2eKxURn5GikLAJ4dtnijegza1JbLT8rhrvr8SJ83iLjXDKKv80YlMBcktD0oQ8PshL4vqiP+a3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776251695; c=relaxed/relaxed;
	bh=UUwLFe4sJwTmvK33kSzO0AkxCRTRozJKSvcgK9DIV10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JGb4anTThmFqJEZ8HfQS39iYtGkYdM+ddRnqmhHXHNhtl5G6mXVLCntwUg7+mN19huPqa8JtkyUVbfC0xf15/tXaYOzmTkI4M1puGZUpZ3JUxgmTmXnvL2+HhwZ4pDgMWHJ77mRSDOWcplxR6LnwgeBjjhyxhLsYtZuKYjpwWb2/UpfITaQ5KG3Lh/qAH2rGvktiAMnOcvtk7Q7qfSdw6N/5LBxsPZFebRTGAv5rRw1JItNUR3XVgMlrhY9uwe8ER79hHSVAJTA8djv0/ZCPBqA2TWMQWNEFG72UBxXE5bdvg8WipaKOZEJ9virxX/RhJhKh/IOcYivZLko8xxfEog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=cQN6iqDh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=cQN6iqDh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwdpQ3vKgz2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 21:14:54 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-c6e2355739dso2985899a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 04:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776251693; x=1776856493; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUwLFe4sJwTmvK33kSzO0AkxCRTRozJKSvcgK9DIV10=;
        b=cQN6iqDhKj0c/ObCuxXautvQ1q4xtpNq+Qy4ELWcyS4UhTBL78KkzbZ9KQOHMm9lpH
         jI3pRd359uicuPe+mAA5O7QfB4gzCkbNN9XF3G7kHMn3L9XjT2YqFo06fml21+KfRO7d
         3QP3ATE4aTkT6r8nDEzRZBf2deQExkVsyh0cdw2Em+KmuaWotj2p2JR38E03VvojOTqo
         FtA5VN/1800yo0mzRq58Rmn/vVR2gL0hbUAO58Zkcn+j8w27wPE4WsNRakWEz81AAITO
         Kov0Qaj9h1LrAeKYjDUuK6RSaVMtWLYoA0WjIL7f5SFIpvV1SYZEpMDT5dzQFVOvm+nO
         6SEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251693; x=1776856493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UUwLFe4sJwTmvK33kSzO0AkxCRTRozJKSvcgK9DIV10=;
        b=aGPHBqBTbVHtdqCStFvkese9E/ZFPRO7AUFNec6vqou6hnqc0cOHKpoK1AK0zHzso3
         +cfQ7Vh/YbQLvBKyS5kQY7JBZDGvHLyEm/FAjEdSWnXYX+RaaujlWBbTyq7kz6/d142I
         sY4nfrjjF1ch90FUQEVN5HTNPDV9338Nr/8sLLb7tkzMOIiU0msgJCJEVo+B+WlZyHl3
         4z2xrseZk191iOohh/h/nIOnP49ZHixEBmOWU3z8Yk+dxfeqiuK/BSuwuWlP8NlIIkkW
         K0LPbZhF9QdSbO9bv7/+yUhKLfIlA0MIQOCclZzEwRxRYR6k4FQjVTij3ucnfjteVv6Z
         Vckw==
X-Forwarded-Encrypted: i=1; AFNElJ8sgtdJmoEERfV1DJo/TMvEbT8UaTzEAHblzl1bzXX8yxMRsMc679R0PD+m7t58SajxkPP5t8vIpwK4auk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxpGoDeZRB+t1dzgGf1HMsfJRgVJKmAJKQvilnNBCoT6uDQ99D/
	+yRl2Sum68GOWh3H59htvMaaZNUyxZNaJZAniyAjzKIut5baQTtymWxhGuqq35UIUlA=
X-Gm-Gg: AeBDietUyGxJiMZFLzX2INE9Vc7QL1CwWUuEegHFDBRhw7Z5ikUdH2LK8f0aI3Wpuhp
	0LOcqJdzwqPgCvZd0/kQscPdOh8lj1tZsx3UwHhXs49YZuv8ezpXr+5Ahg0ySYcdlIcKrOQhcKZ
	3RSslyi10Ccf0l/q0z7s4Ca9IHop0NZ1rEESul/d29ZFf8FXQMNzLzDlWXb26AS2IF0CDx99vBl
	zeJ7dcCGt7/O4mop6BHIGR6syn4BoRCg3vGzP7c6hzhGMy1aAgwP8/zrR3grMdFJLajTP2SkmU4
	e9FzVLOUzw1cjfAEpqw0mwO+1qjzaSO+v+lx4iaXX+ObVnpHtQ1uN8Hvh04bK+zM0PGmBEuh3Ay
	+jHIBTq9ZKU2BVnyWyEhjJha4qQINpsGuYBvWV4NDhzDLEKtA4VGdmJnQF4N50RikLUBnGGxxJk
	/QxX9DrgPjkSVH4eIL/tKAv5LljAGnzAyxjbgwfCCLZn4=
X-Received: by 2002:a17:903:37c6:b0:2b2:49a7:a5bc with SMTP id d9443c01a7336-2b2d5a60603mr217754215ad.39.1776251692524;
        Wed, 15 Apr 2026 04:14:52 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b477fd3724sm19509485ad.0.2026.04.15.04.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:14:52 -0700 (PDT)
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
Subject: [PATCH v2 5/6] mm/sparse-vmemmap: Fix missing architecture-specific page table sync
Date: Wed, 15 Apr 2026 19:14:11 +0800
Message-Id: <20260415111412.1003526-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260415111412.1003526-1-songmuchun@bytedance.com>
References: <20260415111412.1003526-1-songmuchun@bytedance.com>
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

On x86-64, vmemmap_populate() normally calls sync_global_pgds() to
keep the page tables in sync. However, when vmemmap optimization for
compound devmaps is enabled, vmemmap_populate_compound_pages() is called
directly from __populate_section_memmap(), bypassing the architecture-
specific vmemmap_populate() entirely. This skips the sync on x86-64
and can later trigger vmemmap-access faults.

Fix this by moving the vmemmap_can_optimize() dispatch from
__populate_section_memmap() into the generic helpers --
vmemmap_populate_basepages() and vmemmap_populate_hugepages(). This way,
the architecture vmemmap_populate() is always invoked first, ensuring
any arch-specific post-population steps (e.g. sync_global_pgds()) are
executed before returning.

Architectures that override vmemmap_populate() (e.g. powerpc) handle
the optimization dispatch in their own implementation instead.

Fixes: 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory savings for compound devmaps")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h |  6 ------
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 16 ++++++++++-----
 mm/sparse-vmemmap.c                        | 24 +++++++++++-----------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index bde07c6f900f..2600defa2dc2 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -357,11 +357,5 @@ int radix__remove_section_mapping(unsigned long start, unsigned long end);
 #define vmemmap_can_optimize vmemmap_can_optimize
 bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
 #endif
-
-#define vmemmap_populate_compound_pages vmemmap_populate_compound_pages
-int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-					      unsigned long start,
-					      unsigned long end, int node,
-					      struct dev_pagemap *pgmap);
 #endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 568500343e5f..21fece355fbb 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1109,7 +1109,10 @@ static inline pte_t *vmemmap_pte_alloc(pmd_t *pmdp, int node,
 	return pte_offset_kernel(pmdp, address);
 }
 
-
+static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
+						    unsigned long start,
+						    unsigned long end, int node,
+						    struct dev_pagemap *pgmap);
 
 int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, int node,
 				      struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
@@ -1122,6 +1125,9 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	pmd_t *pmd;
 	pte_t *pte;
 
+	if (vmemmap_can_optimize(altmap, pgmap))
+		return vmemmap_populate_compound_pages(page_to_pfn((struct page *)start),
+						       start, end, node, pgmap);
 	/*
 	 * If altmap is present, Make sure we align the start vmemmap addr
 	 * to PAGE_SIZE so that we calculate the correct start_pfn in
@@ -1303,10 +1309,10 @@ static pte_t * __meminit vmemmap_compound_tail_page(unsigned long addr,
 	return pte;
 }
 
-int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-					      unsigned long start,
-					      unsigned long end, int node,
-					      struct dev_pagemap *pgmap)
+static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
+						     unsigned long start,
+						     unsigned long end, int node,
+						     struct dev_pagemap *pgmap)
 {
 	/*
 	 * we want to map things as base page size mapping so that
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index f5245647afee..7f684ed3479e 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -296,10 +296,16 @@ static int __meminit vmemmap_populate_range(unsigned long start,
 	return 0;
 }
 
+static int __meminit vmemmap_populate_compound_pages(unsigned long start,
+						     unsigned long end, int node,
+						     struct dev_pagemap *pgmap);
+
 int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 					 int node, struct vmem_altmap *altmap,
 					 struct dev_pagemap *pgmap)
 {
+	if (vmemmap_can_optimize(altmap, pgmap))
+		return vmemmap_populate_compound_pages(start, end, node, pgmap);
 	return vmemmap_populate_range(start, end, node, altmap, -1, 0);
 }
 
@@ -411,6 +417,9 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 	pud_t *pud;
 	pmd_t *pmd;
 
+	if (vmemmap_can_optimize(altmap, pgmap))
+		return vmemmap_populate_compound_pages(start, end, node, pgmap);
+
 	for (addr = start; addr < end; addr = next) {
 		next = pmd_addr_end(addr, end);
 
@@ -453,7 +462,6 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 	return 0;
 }
 
-#ifndef vmemmap_populate_compound_pages
 /*
  * For compound pages bigger than section size (e.g. x86 1G compound
  * pages with 2M subsection size) fill the rest of sections as tail
@@ -491,14 +499,14 @@ static pte_t * __meminit compound_section_tail_page(unsigned long addr)
 	return pte;
 }
 
-static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-						     unsigned long start,
+static int __meminit vmemmap_populate_compound_pages(unsigned long start,
 						     unsigned long end, int node,
 						     struct dev_pagemap *pgmap)
 {
 	unsigned long size, addr;
 	pte_t *pte;
 	int rc;
+	unsigned long start_pfn = page_to_pfn((struct page *)start);
 
 	if (reuse_compound_section(start_pfn, pgmap)) {
 		pte = compound_section_tail_page(start);
@@ -544,26 +552,18 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	return 0;
 }
 
-#endif
-
 struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
 {
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
-	int r;
 
 	if (WARN_ON_ONCE(!IS_ALIGNED(pfn, PAGES_PER_SUBSECTION) ||
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
-	if (vmemmap_can_optimize(altmap, pgmap))
-		r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
-	else
-		r = vmemmap_populate(start, end, nid, altmap, pgmap);
-
-	if (r < 0)
+	if (vmemmap_populate(start, end, nid, altmap, pgmap))
 		return NULL;
 
 	return pfn_to_page(pfn);
-- 
2.20.1


