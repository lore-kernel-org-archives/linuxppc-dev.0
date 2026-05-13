Return-Path: <linuxppc-dev+bounces-20869-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24125CD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:10:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv1f3YPgz2ySV;
	Wed, 13 May 2026 23:09:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677766;
	cv=none; b=arPxliLgg0JvMXOCUKsCMwor3GxUWykPu2Hj9yPctwAPdl2eVVqyyhfYhHK+/DF27tWCQ/+IU0g0UY1jU2AycEgTJpFNd+mw2dsVmOamhhbspMYKY5CHKG84yWlQ32IWPfaKN/eowT9YyvQHDcyhf6m27Gd/0ApHTvCjQ/kMhIeftUa5+zaRc+odOkgWGRsIrWdOlQZT8C7IE2oDd5uKOQobuJ6vqzIL/wY8sSU6TldNwCW6KWg9+Xik4F/wpIMjCp536KviahVgyqniLXebJF+ihQ7mvvsfDXCqc/mdhnmGrJ9/VVQNcsnskfFPFCjfK1BXLwYtKMRKlSc640gkFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677766; c=relaxed/relaxed;
	bh=jxlTDmfL7zgwYuPQPoNgGF9X7KRsj/YO5X5OnwZ25t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQXdiGtcrdRGbY8OT/gUsm6QLJt27s9o3yc0xZyyemaOJYjgkkcxlsieq8aBueaMIWHcpMkbN8ZyREfTSXkB3k5VEZVVCeC0jT5/klfzfmKdYkak9jKXJAZH3hFaUyx84ieZEFUqgNoaBnPk2Odw9Ecn9X2vd+g1U6eoZncc0+AYEUcg+qU5oPf4vexIl9Q6P8puWGKCYdmlAkEHUtS+Xoo1O6dlB4vFVTD/vp4bhX23Wh7EnJtK9GoLWYwkpA1jAbWVgdKJmC7TZigfFcFO7odZLF0wpOeJcW2cKh3hbHj3ZF63aziq0S/D+K8YRaXIZg4B9TPIdybSQobTSW5mnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=OEC4XgxJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=OEC4XgxJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv1d5FRLz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:09:25 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2bcf48850c4so18641855ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677764; x=1779282564; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxlTDmfL7zgwYuPQPoNgGF9X7KRsj/YO5X5OnwZ25t4=;
        b=OEC4XgxJAx5OCwlXfVF62twjsBa+5HGcKjhsCRq+6XV0U0pgg9lvFKiFlyIY+Q+hKn
         uLIX9ibi8kfCu4CxL/0luwZv7+Xs2vY32FTQzqd9LmUeFdOMxjYfcFoWNDyMri0oHzNX
         WW0+ZpgvxyklnPJBPkdFtwlgAv+7H9kPuUINvDjaiyYDph8DqExN0TGP8V81Jr3myosw
         uH+POtJK93PprjPTaN2wx73eUyGjRf6tfy+1FXyPqWsIZWyMZrtAHAd5QssGf3ycnOfw
         mprfDy43jeG5kY4FgXjaPMgCFecB7f4n4ozG9PhLYJBJkMepNwwzvYSodUPk0mt3Itka
         wGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677764; x=1779282564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jxlTDmfL7zgwYuPQPoNgGF9X7KRsj/YO5X5OnwZ25t4=;
        b=OWhwjJMoN6dJmVplevWEOHAk76JLXR8jzQ31JI3dc5ZBbmLQs4hoRJ/q9lKdbhmLUE
         akVYNyIAfwVEiMOXiSrvHzskeJF7YXwiuvs3CGwfUPOY1iS3sRqZ1w8j2eWAzknulTxx
         n0TtZR2Z7erIcbdeBrQMfoHRlWczt/+AHiD8U79Mm1BIH+qSHc/mT0c3hAI/C+XXB1ii
         3uBQbwRBUmJJVdnS+XBkl1rp9uBKAxxlgKGpUMBcclk2oQrwMP9PTN4hwZgTQAnxViKo
         GmLfvNbg/mFiMro7mjRkBFHmRt43BPLlHbuZweW8bOI1/2W9S6PbqXzfCVjfbsNJHcoH
         7mgA==
X-Forwarded-Encrypted: i=1; AFNElJ8jdoF3Jbd30rEiacsM9KqGrSvXGDjPSm1bldy/mupraMfh42ngoRaHh5Bi7T1bOCKowENnmS0jwyWEJLI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyFNdWKfi7i7AKstjCWrKNtbXrQhRlSdyKPOPk9+vgyxU+48r6V
	tKYoygAZ5IoBLXdOVFpCR5SpDnzCZ452goakN2xPWKFJTstg/jAPv3Ofb9uuYTtxr6I=
X-Gm-Gg: Acq92OGoj9GP4fq5gT8AWezqGME/OKEHrFm+BMKoe2nCVcFKAAk8C1dae6VeBqTRsYJ
	57We+uTvV9MO1OM6SkdfSmNEm8P5oErLIZUdeE8tlMOI5bp1P+1m8TcZA+hQTHpM8UNVUz65/JW
	s8n3prb6sjD75OLxBc9T4bJr6M/G3xGa64mbUU5+akvP5Oe9wp0iUi8NOkKZJHUbYEn/arCucph
	h3NDXC/676RX3lc1rBArAa3gfe8LbCobYs9z+ZI4dTrd9XkUTsl3BmofyxVlwdmwMJOwvG5ZdFL
	RsZe9J5pH64pKR8SWoc19ThRx8I5pNuQ3Z8uyEri9h5XV1UsSxtnNyso0GXpbYUda2bxTefUYeB
	1cSgcJMwR8xIWnb0J9F2etQsYiOB1Cpw+2oIHve5Ai6Udeqz4GuYWedPggfGlX7h+W33EFMht2Z
	q2Z3rRETxWgNEW5hTKAZhxXJTnUNHxlEA8IBL7YuwNQwJc8bibsVEuYYOICRQ=
X-Received: by 2002:a17:903:120a:b0:2b9:fb0b:b727 with SMTP id d9443c01a7336-2bd27714d46mr39301505ad.39.1778677763716;
        Wed, 13 May 2026 06:09:23 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.09.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:09:22 -0700 (PDT)
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
Subject: [PATCH v2 20/69] mm/sparse-vmemmap: Drop VMEMMAP_POPULATE_PAGEREF
Date: Wed, 13 May 2026 21:04:48 +0800
Message-ID: <20260513130542.35604-21-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513130542.35604-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
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

VMEMMAP_POPULATE_PAGEREF is only needed once the slab allocator is
available, so it does not need to be passed through the vmemmap
population call chain.

Drop the flag and test slab_is_available() directly in
vmemmap_pte_populate() instead.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 17d45dac4324..d7e9fb47f7ee 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -33,13 +33,6 @@
 #include <asm/tlbflush.h>
 
 #include "hugetlb_vmemmap.h"
-
-/*
- * Flags for vmemmap_populate_range and friends.
- */
-/* Get a ref on the head page struct page, for ZONE_DEVICE compound pages */
-#define VMEMMAP_POPULATE_PAGEREF	0x0001
-
 #include "internal.h"
 
 /*
@@ -147,8 +140,8 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 }
 
 static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-				       struct vmem_altmap *altmap,
-				       unsigned long ptpfn, unsigned long flags)
+					      struct vmem_altmap *altmap,
+					      unsigned long ptpfn)
 {
 	pte_t *pte = pte_offset_kernel(pmd, addr);
 	if (pte_none(ptep_get(pte))) {
@@ -170,7 +163,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 			 * and through vmemmap_populate_compound_pages() when
 			 * slab is available.
 			 */
-			if (flags & VMEMMAP_POPULATE_PAGEREF)
+			if (slab_is_available())
 				get_page(pfn_to_page(ptpfn));
 		}
 		entry = pfn_pte(ptpfn, PAGE_KERNEL);
@@ -243,8 +236,7 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 
 static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 					      struct vmem_altmap *altmap,
-					      unsigned long ptpfn,
-					      unsigned long flags)
+					      unsigned long ptpfn)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -264,7 +256,7 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd = vmemmap_pmd_populate(pud, addr, node);
 	if (!pmd)
 		return NULL;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn, flags);
+	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn);
 	if (!pte)
 		return NULL;
 	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
@@ -275,15 +267,14 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 static int __meminit vmemmap_populate_range(unsigned long start,
 					    unsigned long end, int node,
 					    struct vmem_altmap *altmap,
-					    unsigned long ptpfn,
-					    unsigned long flags)
+					    unsigned long ptpfn)
 {
 	unsigned long addr = start;
 	pte_t *pte;
 
 	for (; addr < end; addr += PAGE_SIZE) {
 		pte = vmemmap_populate_address(addr, node, altmap,
-					       ptpfn, flags);
+					       ptpfn);
 		if (!pte)
 			return -ENOMEM;
 	}
@@ -294,7 +285,7 @@ static int __meminit vmemmap_populate_range(unsigned long start,
 int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 					 int node, struct vmem_altmap *altmap)
 {
-	return vmemmap_populate_range(start, end, node, altmap, -1, 0);
+	return vmemmap_populate_range(start, end, node, altmap, -1);
 }
 
 /*
@@ -370,7 +361,7 @@ int __meminit vmemmap_populate_hvo(unsigned long addr, unsigned long end,
 		return -ENOMEM;
 
 	for (maddr = addr; maddr < addr + headsize; maddr += PAGE_SIZE) {
-		pte = vmemmap_populate_address(maddr, node, NULL, -1, 0);
+		pte = vmemmap_populate_address(maddr, node, NULL, -1);
 		if (!pte)
 			return -ENOMEM;
 	}
@@ -378,8 +369,7 @@ int __meminit vmemmap_populate_hvo(unsigned long addr, unsigned long end,
 	/*
 	 * Reuse the last page struct page mapped above for the rest.
 	 */
-	return vmemmap_populate_range(maddr, end, node, NULL,
-				      page_to_pfn(tail), 0);
+	return vmemmap_populate_range(maddr, end, node, NULL, page_to_pfn(tail));
 }
 #endif
 
@@ -503,8 +493,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		 * with just tail struct pages.
 		 */
 		return vmemmap_populate_range(start, end, node, NULL,
-					      pte_pfn(ptep_get(pte)),
-					      VMEMMAP_POPULATE_PAGEREF);
+					      pte_pfn(ptep_get(pte)));
 	}
 
 	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
@@ -512,13 +501,13 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		unsigned long next, last = addr + size;
 
 		/* Populate the head page vmemmap page */
-		pte = vmemmap_populate_address(addr, node, NULL, -1, 0);
+		pte = vmemmap_populate_address(addr, node, NULL, -1);
 		if (!pte)
 			return -ENOMEM;
 
 		/* Populate the tail pages vmemmap page */
 		next = addr + PAGE_SIZE;
-		pte = vmemmap_populate_address(next, node, NULL, -1, 0);
+		pte = vmemmap_populate_address(next, node, NULL, -1);
 		if (!pte)
 			return -ENOMEM;
 
@@ -528,8 +517,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		 */
 		next += PAGE_SIZE;
 		rc = vmemmap_populate_range(next, last, node, NULL,
-					    pte_pfn(ptep_get(pte)),
-					    VMEMMAP_POPULATE_PAGEREF);
+					    pte_pfn(ptep_get(pte)));
 		if (rc)
 			return -ENOMEM;
 	}
-- 
2.54.0


