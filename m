Return-Path: <linuxppc-dev+bounces-27093-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD89DC88E41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 05:04:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2WT3LW5z2ygK;
	Fri, 11 Sep 2026 15:03:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789103029;
	cv=none; b=e1XpT2QEUIA6jL2599ad5cqfwpmsjghQhBxuWhnyrRiQoF4jOC2ukPSRVLMe/cxNcDmZEEuz8oLWUnl2hCZsZGjXP80kegPZWn/7wir8Zltx6yaX481DyrTIC3zZ5If34/ahylrQYLjsrN0Zuj/3Ld1t4SAa6fQ0sgY0DTI/PohmgZspc2zAPqYxah3Q8DIf4Lqmw1x2MixmNK6kOKH0pfjJPsrlgf5d8u8M8ymnXqvv8EvfgLn0xq1W4WmmCgP89cRisD/w7FAzRmg7jSDArGSwAWdhsJ7+dGRtoWqoK2daNNXiL5P8MqcVsnPHm3YjwrXsrWODh53LoqCKZnpZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789103029; c=relaxed/relaxed;
	bh=jrSUwqa7xtL2ZBs1WlB04Z11tmz781BnHoaaNOznkvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXzIQe/CjzlPkdOHQ+g3hUStQ7cU0tZzBKgO+fwHo79BTT51ERz4yHHAesI0tku1YAfbJricKRuagj8ZmleuZNJ8SPyqajGXCiysZtUoRT37BXyRcs/p4grZPRNkDeD1jfuunqfcrwvGDvUIHLbLM0gbOJwl3nNENEEyTpdMpZZSEbuQdAYGilbz1OhSSLesQMMdDs6MeDFh2XFtdygS9GSMfwMtqkGcQbonG2yi+iW0WQzyEGnbErs9WI6oiSEdCIpa5N5t790ts9RHWBSeyeRRhKjxSXKYhVLIREJwVo9mibFn3k60rLWAdEjCavkw5pvLxoFn826twCeeEaFyIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VsIQ98iq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VsIQ98iq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2WS4yKhz2yFj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:03:48 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc4bdf8acd6so462636a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 22:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789103026; x=1789707826; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jrSUwqa7xtL2ZBs1WlB04Z11tmz781BnHoaaNOznkvI=;
        b=VsIQ98iqdSZQNbOm8wHN1O/19ChGfKkXdhAY6YGNOf1MLbcUAfgF0g3Vqf/z0GGWaZ
         P67VtQmGQiI2fkanEgFlyH1/Vl3T+xv3y5ickFQaHRuMOctGWCffAA4MRZ9pDLuU17DP
         Z3QjIPzaOHojGZnjSzmw/WMt6wSz8Jf/Bp3XR4MzyUCYRCa/wib1B9aAEmCiPXID94uO
         OKu4HIh4LQrqk90jCLfsGkFvZKUV1jzw4NE8Cz20BNxAs2Yi4qBUKPDTS2Gta1/usrKq
         /cJbBHRBHckm/8h9Ps8FPjkMDBVHNvOE1FmWK+8GHh6OnBZNHrd0gtexRd2NLYyzGzFl
         jkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103026; x=1789707826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jrSUwqa7xtL2ZBs1WlB04Z11tmz781BnHoaaNOznkvI=;
        b=TaIII8Jj98ezQ4DWPIwwhVWSP0Lj3sg6H1cbS1GTO/KDnICLo0Qyfo3aJFGdRR+M3Z
         afte3ptOnFnYHQAIfyzMKTx3uCgtnlpAmj+/RPtKtncJnMMwVyYQK6sKir8w2mwzFFDn
         JtSfnTpbequ6akt17dpb5Mud7qYeJSCn2EpebxTWlE/SoEDfSZPGsx7uMis5hiB7PwTj
         NFtJbBz5PRhnf551CVknMIUXr3pxWmu9raRu1+WUCISNI5prGvRtCpN2vhzwhJn913iS
         8lOhmZEmFFguZQUM2BCa+k2jFQvwk7uxJcbjGDRic5ZTW8wLJrBD6KiPyLumn23gARcG
         uqkg==
X-Forwarded-Encrypted: i=1; AKwUvByPuZbgwnCjQ6+jmbmjEMMXv2i0M8PeCMIqnmnKUQnKRU2wD1aTw2V6z9LqUNcVY5yC1KuwjxUnAWmyOUM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mgSVOWSSGQtmDBJV7PRErhlxBAA+7bHdmNw1whPW+f6l9j9zFb
	b6fJ/EPE3FP7AGU81kgVQir2VauOcIQ3gxzBT0+2NrSO7F8fp9ZIUfT+GWZCqLCPiYU=
X-Gm-Gg: AYBFou0wQ7I0Fx7FbxLySwd8TWN/M9ENV8HrEronxUkyYLNIJfxPOSUs+ZlsQagPim7
	Xswhh2RksoyEy69X+6InhskERwwxxLmP0pltmyrWZouas/svRiIzXBFLVoT1Aba8MXwiBKDEFK/
	uhPaei4YCuoC7BiXDJJEj8dOIG0Q2Er9yB/FxQgT81KX78Xx8S1mZqAgHoScWyh8JQ+WuI96xcM
	NDllZGHzPlu2OjuDREnl3CuR9ryFn4DGrrTAbUCFAXnBnnOUcRxO0lXIEt6h0wjkA0h5b5dLBas
	wPdqdWQAdSrzygfnypm33HsiEP+LeWCr9IPg/rJAlZHEEXWEMZH3q/vizR1zX0J0Zrvl2DFx6mv
	O/EIkwVa42UpeBzHtMIB51hChS1n30blZjyDzRqnqu4+oErY+u/L8ofrzUf8iIWDvG9ztIWDkfG
	izhkYUE2SCj/3B1YrvyNYSuneEoMqzWXyQQcMGoLHcLEi5+uZLxN5nMd3XHgTMvEBPhjESq0aBQ
	M3O3i9GiM96ghrncZcDN5gieM0Drjgkai4Q
X-Received: by 2002:a17:90b:390f:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-39d9c0b7047mr3845524a91.12.1789103026376;
        Thu, 10 Sep 2026 22:03:46 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b16sm2651561a91.14.2026.09.10.22.03.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 22:03:46 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 04/11] mm/sparse-vmemmap: prepare DAX vmemmap population for compound page orders
Date: Fri, 11 Sep 2026 13:02:21 +0800
Message-ID: <20260911050228.58884-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260911050228.58884-1-songmuchun@bytedance.com>
References: <20260911050228.58884-1-songmuchun@bytedance.com>
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

Device DAX still uses vmemmap_populate_compound_pages() to populate its
compound-page vmemmap mappings. That helper allocates the head and first
tail vmemmap pages explicitly, then reuses the first tail page for the
remaining tail page mappings.

Device DAX is being moved to the section-based vmemmap optimization
infrastructure, but it cannot switch to the generic section-based
population path yet. Once a later patch records the DAX compound page
order in section metadata, DAX head and first-tail PFNs can look
optimizable to the generic helpers as well.

Add a DAX-specific population flag for this transition. It keeps DAX
head/first-tail allocations on the normal vmemmap allocation path, while
preserving the existing page reference for reused DAX tail mappings.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v3:
- Update the subject and commit message to use compound page order
  terminology

v2:
- Collect Acked-by from Qi Zheng
---
 mm/sparse-vmemmap.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 861e09b2b096..aa89c16f7fc7 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -35,8 +35,8 @@
 /*
  * Flags for vmemmap_populate_range and friends.
  */
-/* Get a ref on the head page struct page, for ZONE_DEVICE compound pages */
-#define VMEMMAP_POPULATE_PAGEREF	0x0001
+/* Vmemmap population for ZONE_DEVICE compound pages */
+#define VMEMMAP_POPULATE_DAX		0x0001
 
 #include "internal.h"
 #include "mm_init.h"
@@ -208,13 +208,17 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 }
 
 static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
-					 struct vmem_altmap *altmap)
+		struct vmem_altmap *altmap, unsigned long flags)
 {
 	struct zone *zone;
 	struct page *page;
 	const unsigned int order = pfn_to_section_compound_order(pfn);
 
-	if (!vmemmap_optimizable_pfn(pfn))
+	/*
+	 * Device DAX still relies on vmemmap_populate_compound_pages() for
+	 * head/first-tail allocation and tail-page reuse.
+	 */
+	if (!vmemmap_optimizable_pfn(pfn) || flags & VMEMMAP_POPULATE_DAX)
 		return vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
 
 	zone = pfn_to_zone(pfn, node);
@@ -236,7 +240,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 		pte_t entry;
 
 		if (ptpfn == (unsigned long)-1) {
-			void *p = vmemmap_alloc_pte(pfn, node, altmap);
+			void *p = vmemmap_alloc_pte(pfn, node, altmap, flags);
 
 			if (!p)
 				return NULL;
@@ -251,7 +255,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 			 * and through vmemmap_populate_compound_pages() when
 			 * slab is available.
 			 */
-			if (flags & VMEMMAP_POPULATE_PAGEREF)
+			if (flags & VMEMMAP_POPULATE_DAX)
 				get_page(pfn_to_page(ptpfn));
 		}
 		entry = pfn_pte(ptpfn, PAGE_KERNEL);
@@ -511,6 +515,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	unsigned long size, addr;
 	pte_t *pte;
 	int rc;
+	unsigned long flags = VMEMMAP_POPULATE_DAX;
 
 	if (reuse_compound_section(start_pfn, pgmap)) {
 		pte = compound_section_tail_page(start);
@@ -522,8 +527,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		 * with just tail struct pages.
 		 */
 		return vmemmap_populate_range(start, end, node, NULL,
-					      pte_pfn(ptep_get(pte)),
-					      VMEMMAP_POPULATE_PAGEREF);
+					      pte_pfn(ptep_get(pte)), flags);
 	}
 
 	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
@@ -531,13 +535,13 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		unsigned long next, last = addr + size;
 
 		/* Populate the head page vmemmap page */
-		pte = vmemmap_populate_address(addr, node, NULL, -1, 0);
+		pte = vmemmap_populate_address(addr, node, NULL, -1, flags);
 		if (!pte)
 			return -ENOMEM;
 
 		/* Populate the tail pages vmemmap page */
 		next = addr + PAGE_SIZE;
-		pte = vmemmap_populate_address(next, node, NULL, -1, 0);
+		pte = vmemmap_populate_address(next, node, NULL, -1, flags);
 		if (!pte)
 			return -ENOMEM;
 
@@ -547,8 +551,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		 */
 		next += PAGE_SIZE;
 		rc = vmemmap_populate_range(next, last, node, NULL,
-					    pte_pfn(ptep_get(pte)),
-					    VMEMMAP_POPULATE_PAGEREF);
+					    pte_pfn(ptep_get(pte)), flags);
 		if (rc)
 			return -ENOMEM;
 	}
-- 
2.54.0


