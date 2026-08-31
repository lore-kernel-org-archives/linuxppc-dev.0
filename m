Return-Path: <linuxppc-dev+bounces-26243-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC25C624C2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 07:55:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYLqs5G7lz2yCt;
	Mon, 31 Aug 2026 17:54:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788162889;
	cv=none; b=dZKsCANdw6NZ6lg+O6XcyMdRVmP9ax7oz0nW0gM4hq+NiScx0PMgzq78uJT1QadwUNv+uwNcqNGlq69lkxi/bdeMe6n2I/V/8AqKCYJ82DF2e4ut4Xfo7yH3L8iEMet2pgYJ5A3IkVbmT5q8RaB1RFoWgk8SFsA8krQRvj/RhccL0ugtJHopoxcTappA2GkGtu/3/yPLu1LztVX1wR1zSvnK8CMAWrNZLYcIJ63awYGpPJuM1V9PNsGjUumWCgjZq+krHSrnM1VkH3mlRwvuLhmVKemUhQgal0CQu4xKL3IykMzqz9PN90lvMCKRblNAgRR4U7uiF2B8V7bgUXeZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788162889; c=relaxed/relaxed;
	bh=YVp9a6es5dGYiwq82JtXpVvKTCPlSq+5R8j2MYX8xm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+KqjoPoXSTuqKUO3RRaWVLIqlgbwHhScfgGa6VJ/ZhsEFapkc21mME4HtNLw1fuqANamVduGIFanxn2Dc0/q7iz0hf5GgmqNZd3QW5qBjqvlyJgxB/m5ttID/OmlYIDHzIuuP+1Fb3iCXym99ojLNyktamUFisJkDQToJHklpSmpmpBcn4oNCDw4veKNqTjllRNk042WwPH0QyHlBuKc+gsLJcU4nVoGtw2vpifVZn0XtOs8of0nNy06kshU3ddqua/tsJgt1IaKqEiFtK0x7byY0lbpDnUw+lb4buSKe2aC/VWbrjGyFrXW8LoB4zuAtuGUOiPFhlOh/eLv7hiFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Jn19vy/K; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Jn19vy/K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYLqr4w17z2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 17:54:48 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso2689133b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 00:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788162886; x=1788767686; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YVp9a6es5dGYiwq82JtXpVvKTCPlSq+5R8j2MYX8xm8=;
        b=Jn19vy/KdSG6BYxiKjjqNYAdjj/90KTkVJWBFTlx1+DjWf8SFvRjKyTDESBeN9VVwb
         usliochc7SP4yXAGkLErH1megSd8ngVFD3u+zzixVNt82DdncrMn2Rx7PAyo7AIfngYP
         YK2sp1k+Z+64Jv4iIRGt00GH+5V/g99BlRJtexyOBp37pN1sI4PQz6xRZAbUVZ5RF5Al
         wd3+EdHjS4la9sx/MOhFA46IfqPBj6zFl74wYPRnQ7fDuSJcDCzUuMupq+UuH1udYoyC
         ZMhI712TUTmIME+Wa8femQGb9FDxBlC7GNvNDeKQi3La86ULRkjg51s0AKi3UABthwc/
         Homw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788162886; x=1788767686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YVp9a6es5dGYiwq82JtXpVvKTCPlSq+5R8j2MYX8xm8=;
        b=PEu0uHC7J4QymHCRpCJC+jpaNWIEd5jf5+bDkbj5lXGGVQpFVT/lDq9EGDLqUTtmp8
         8yTVdbhzvmj4HpiYDwwfM5gWM0WCB5A7O9WofA6ABCpjfXtAWZRE/xG+oSp39vud4Pmw
         djIh8Cf1I5IXhT6CT2f2zec10WpqjAhblUTZVlVQ9x/10OENwknyxB42mIkJFwND8ugu
         iFQ4xUi+EaQsmz0timO1Oidz/cgGVjAOxpV/Cdl+I3bCKcd2/JKSsJVOHzLkTRhnUt/g
         D708EQjps9X4vpjDT3pekJz3pACdmNfXmRgEg1lQzpkVxO0Wuvz+UywA9rMGhCuw3jhm
         ZzBg==
X-Forwarded-Encrypted: i=1; AHgh+RoF+jTkrkKO2pEUdoj3kqKAiSycPApLjHkbSVJ5qU8VTwBoCaV97btyKZfb9wDtFwto5aNUZ9toNp6lmOw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nVRFkcSemEVnMndCBaUsw5KjlPhtgArg6PnkIvO34Mvcs2RRfx
	o6d1JtEC6QSqUk2UmYHRq0d13o8NbmOacKOwgsM61O079/NoSe0DH9E4LL4OWQHYuCA=
X-Gm-Gg: AR+sD1220Zx1IRzytRcbJX7pLPzD1+AYgeHJhgYXxKzCvLH2xItwg/hYI2A7de1Hl+n
	azb/W0iCXS5mJhlwgAT/mUW8KcaMUWWP1rC+yLOosztUH7NYifi0adzePJ3jhSisW1auHlAeGYA
	kY+qwaRDArBRy0g+IY8nYgjFKztFaRHSkqJVTwiQ1SaLuXeOQmybyHtsWCV+020dIJeGk2zMQLu
	VQzhLMTDpSTeZXBn7RCoLkmy3bnsnYUgW8tsJRTp2TJHa6wxMUPjnJvDboQgyDS/RQLTERLz62b
	m57zCZNKJLmo/1BLVBSNVJYUHQbGkgT8ZT8oNBhyXp5hHFmVpwcrUG7mdgZiixxz5bJX7e2knsb
	swzBjD8by9p9xg2V+yQbCPXHuo5gV5EQtyMqFavG7grCzB37QdELDOq96rsIWc3QzyMRXN4F1ug
	4widGfIx0QSAzKZjpADP4KHNKv1mUWkc14AMFWZHSKvc/Pi97jYWhUuEnHBDG4pCZ6AUB5gS5X2
	dcTVcEOBaLxJw8u2tCcm6i+
X-Received: by 2002:a05:6a00:1706:b0:851:c1d2:c48d with SMTP id d2e1a72fcca58-8562a1f8fd6mr37313481b3a.8.1788162886422;
        Mon, 31 Aug 2026 00:54:46 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f330f88csm3590256a12.10.2026.08.31.00.54.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 00:54:46 -0700 (PDT)
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
Subject: [PATCH 04/11] mm/sparse-vmemmap: prepare DAX vmemmap population for section orders
Date: Mon, 31 Aug 2026 15:53:35 +0800
Message-ID: <20260831075342.57563-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831075342.57563-1-songmuchun@bytedance.com>
References: <20260831075342.57563-1-songmuchun@bytedance.com>
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
population path yet. Once a later patch records the DAX compound-page
geometry in the section order, DAX head and first-tail PFNs can look
optimizable to the generic helpers as well.

Add a DAX-specific population flag for this transition. It keeps DAX
head/first-tail allocations on the normal vmemmap allocation path, while
preserving the existing page reference for reused DAX tail mappings.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index e453ce4675a0..54ae8c284324 100644
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
 	const unsigned int order = pfn_to_section_order(pfn);
 
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


