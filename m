Return-Path: <linuxppc-dev+bounces-27461-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BDBC88E5C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 06:44:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl8W31y7xz2y2Q;
	Wed, 16 Sep 2026 16:44:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789541055;
	cv=none; b=GEx1GQXlcUsvr2iLA1pJVn7VejYa34AzB6VRELADdYZmogej4LO/bKHriPMAgogEOE0kwiU+88YKqDploi0KqShgwywhEpNpNbYie33AgwSSYwkPkDmwA8JanzQkvfd+WPA1eANjYwJCoTbL14kWd7MbrkfXsVUFKcx0utZcUbK5aO4+Y/adp+5SpWw46wZimfh1DvK17SWjPV0i4F69xmGLG8AwMN/sCHXPmTn4a9ZWu9UNu6X+2Ge8ngZzS3R0SlXekeJd+hs4KwC5c45RS+QPUTGnH1lRkW+NYPoL8EBaTT+oZi7DHtTlcEWQGDtj8GdmqTmFDWlIdjc2oZjglw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789541055; c=relaxed/relaxed;
	bh=jrSUwqa7xtL2ZBs1WlB04Z11tmz781BnHoaaNOznkvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XS/m5sD/1h134lNvZ4StyC28gfN5TvC74h2LJfGepTosz9q3qxTqXZSukTaC+5pigf6R5B/B0/pYin/T0p+X4/5lwwmi7h9ncNru7X3kEQfYR9zUCdj+9s95t+PVDfZ+EqENsH8+P4gmYiaTR/ye3xThMbDWneLnPQ0hFNQmJkZJPoBU2QlbY3rbhYRInlHccs32AZODJdkqhtRzxm/Wy4exTlJshps84a0DrbBbaxxDUusj6G1PD/Q3kjn0sZqdh08RDquGCLvzhyaODWSGeKkhzpDl2da0lUSEXzaMap1hUaojXTpeSgMWulBgCJYiY9HBwVAYLG0YkAB1yJ9eAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=N4+PANFF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=N4+PANFF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl8W230Vvz2yGT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:44:14 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2db18fe433fso5142485ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 23:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789541052; x=1790145852; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jrSUwqa7xtL2ZBs1WlB04Z11tmz781BnHoaaNOznkvI=;
        b=N4+PANFFBnVciSv+MnQFhqQuafTi+E0IswiVUMp9gj3MT8IME6xNrjdgHXjgNe62ET
         3YnDYkI+AGcIsnvmGs/20Pm7OKrWFgiDhJ15yHTtMSpvqcxjMNDegZtz3QKrUmmFsjU3
         foi1j4zQ0uMf7f0/Zw4MndjWqU4/898DFCgs+WRjR3ckxjnnfDpxKxGxuxP0r5i/ClWg
         BkRPrJhfdD0ZXzpdDavARE1Z8Woov+6U5xBKgvWY0XP9lLIuJHk18TsfCUbx3bX/AUI9
         zxFym0dGtlODYoRkapIf2nAaVhWjiMISTV0S2zKTlG9L1yLNLpmHnMd6OcH6q31d5SfG
         J4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541052; x=1790145852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jrSUwqa7xtL2ZBs1WlB04Z11tmz781BnHoaaNOznkvI=;
        b=WV5+JkQwYexKqzObFqIeatQcQMPtUA2HW+/V8aA5CPurVXT+s+hNOCQJKkY3fG7/Vt
         38FFiU8eNWRdXoUFcRTnyGg5wfmYfqYTZFKr51m4P8lC2qZyZds1QOos/wEDKxDiwHn8
         pxvjqonUzE75PhWtq+BhK2/RroasBPXszqKxZjt3WyJr/sSq9MIm0VZ6mys9C0PETJkq
         KRUBSVUUowJYFLDPg2+9KGAiCMdsIKw0mGHrosw5dKlcsjiRKABWpFoUw1UYOw+QGH7p
         74OJEW+TB0nUS40CU5pE7bYZFT8BZhvm666N6CSUog9eaCvkt7IwKgBOnY15llvx0jPa
         QCkw==
X-Forwarded-Encrypted: i=1; AKwUvBy6iTmeY9nlaIOHbNofjDeUddJHJxEOXV6D47YVOIApaJ3nJRgCGbimyD0GgquDY5FoyCcjZrhtCW+KyA0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nGrvMky0pyGW2WtGlxfyaMZJgzu4biEkefkHDyn0945wkC7yaG
	4iR9kuywaEfoBfr8xJ8iEldUrrQ4v2AsL1c/XZlEcSMhRlhfz+z+t948raqUT7cT6Js=
X-Gm-Gg: AYBFou1af7Do5VXpudBwyYBrhJDlP/iXCUSD0rNMrqZ9JGZexAEbDWP0Ls9TA2veJf2
	BmGWAtDq7BH95ED0c5gvUdyWr/o6ZtETmIse/5OqxFe9G0fFCG/WmJano+UHmbfDCCF4BUlyj40
	DB0GIjqpK7hU7D0Rdz6TTExjLwh9AO7Uq8+Hy2ocTNDOhaMHgqGNvfyah3OIUJnB5NrADK9jsrC
	O4fguyGyFzMPp45jDCxdcjV79/+4GZMTk/O3c6abdsqEHTzQ8iQcpCnFc7Ut3QZsH7q6YZX0Dco
	Q0WKQLtftddHNhCzF+ld7s2ZSmhO32h7CxV7Sl+bHTMTcj0SEFaBXklPjsG0glggbS30fbBrOgo
	LWS6hH0MhEKn6jYfLgfHriWwn04Nd/U0DFMsBZK+cr+j3ChRcPFUVXGTqqYACDqJDxUiuzcOJMq
	VLs7DvGfdFj9tZ2fWb8HckfZY/yRc7ymzoAH78FI/0by0lGm8nNiSakCpP5OeABjKp8xFbfIfbK
	UlbmWVNs3wXgrIsQ6A=
X-Received: by 2002:a17:903:1251:b0:2d8:d4d0:792c with SMTP id d9443c01a7336-2dd8e752f13mr29866745ad.16.1789541050075;
        Tue, 15 Sep 2026 23:44:10 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f0592asm6074755ad.62.2026.09.15.23.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:44:09 -0700 (PDT)
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
Subject: [PATCH v4 04/11] mm/sparse-vmemmap: prepare DAX vmemmap population for compound page orders
Date: Wed, 16 Sep 2026 14:43:34 +0800
Message-ID: <20260916064341.1825793-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916064341.1825793-1-songmuchun@bytedance.com>
References: <20260916064341.1825793-1-songmuchun@bytedance.com>
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


