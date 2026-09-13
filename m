Return-Path: <linuxppc-dev+bounces-27188-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27576C88E56
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Sep 2026 08:40:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjMDv22Z9z30Lw;
	Sun, 13 Sep 2026 18:40:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789288847;
	cv=none; b=CYHewVbcJBf2ANmwXf/h0Z+P8/L4YZmxKiNqdkP64oNR9NGFBeq1NNliclmtFXoZOrCPKewwROvL0rPPb+Wn9v4IFPvpsDhoV1y9SBJVRr+e3EOki+xEPFW1xGt7es2L9psn3bn6x7MKdNO6j8ENn1noEPlOtAeA2cUqOi7DjI4p98Kvp7M/XrbxLJz4h5ZHSbOteItsDJPj+iIDzEHMv5gHWekc6o/3e/VO6pJNrhv78niUx8yzbdYrS1w/teonU85efIFo70FQH+22SdkYeuodt+sIUsUzwtRgp/jmXrhR8TMcCiTCsALOuk4xu55Fp9a0vn8EVReik8wmKt14JA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789288847; c=relaxed/relaxed;
	bh=ML0t01Bj4qeBUEzdqhHtr19Sc8eC1B+HcCN0p8hsXSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d692DXVMuy2imKMP43DlNO9IGs3c+7Hzq1x6JILqsyGCl+AhYoefRxLYg4fj9Y0xsZmyyVS9r9SpIU6YDo+CDYtgamiK6DwAFD9fRwyAcvdDDFtIJDhH1x6gnyBCWV8zf1SV3P2frvP9pBemATtD2yYxiRfGfrbhoYLMf++h4MPxpPuUIc8i3m6pEvpDe7pahFYHIh1TKWZ+PrKCPkDeaDdmKURoQgM2iFUlXMs6nL7LiA+ZkTJRn5o/2x/ZTIoe/L8qgHu7CbErcmQ8Y2Y8xzlAGHFCZMERW+WgiTsc/Ms/5oUADSP7GGJnqljFbXLP5KaR6srBsjkcYB7awX3C5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PvxIxpjN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PvxIxpjN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjMDt3sGXz2xkr
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 18:40:46 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id d2e1a72fcca58-85469e25400so816394b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 01:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789288844; x=1789893644; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ML0t01Bj4qeBUEzdqhHtr19Sc8eC1B+HcCN0p8hsXSo=;
        b=PvxIxpjNqNkSv/uaU+vJR9bZebFnGF4Z9FsyfDyjFPO5ZJ4CzXh7unuI20uKzb797A
         KswhEIwi1jXKxqKVU8Dl46AUEwsDduziwDzsQI4/S8WDlFbOjH+DVZBrO3977SQ/LPvn
         IU4PIhiMp3P83OJaq8hm1ya5HxiUTiGEPJ4hNQYJVWu6qHFSigersKYcWD42hFZvT/rP
         trDd+heK2H228UHrqfWj5ZyxLoEnScrJsrk7CHDcNZp8WdK33DClVml0ofwtRSTM/TiQ
         GpXnRdpqVpRku09ys1meD2+SRZAMF2/GU0RAvfH5UwjboSY6dizQRH4qmfuTd71KSW2M
         WIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789288844; x=1789893644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ML0t01Bj4qeBUEzdqhHtr19Sc8eC1B+HcCN0p8hsXSo=;
        b=qxtTIbn6taCVvcJDdlGxzCv81TMREq7hvseJ8kqivf7owjOH3dhxnAUrv8BGgoGRAx
         Iv8snqBCl3YnA9Ok20v2FhSnzF59BF0jHjLCkZ4zOcfLSbL7s0b7WX4vSPA+3vtSmoy+
         zAM7ipp603KO4/66B0vibXwzNdoKocXXciAv1JYi0XtJPkvkwiLDFo9T+rsaqugXYYtN
         EZaQHNeneruxFcwixX7IE8mYF167BzsFRBl5D1qezVm/X6aiSlZ61RqNxjwNYUSEBu9t
         nN6uc36v1m8dlzT6m8vfdDlnFkFI+n5vbhg0Z9ccWwf/eEg/M/7uvdUDl5RjzhckwVP/
         4jHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwCsVw3hJuPRKX5+0/aK4+H++WwE/o5KlguEWSFMt5osA1J8O+zNbJmE8TZDnBZYAjMiL9nlMeK3WKV5lM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nPTBEUI6Mbt8k3uveZBgvvhMvve8gQjR3YeP3+Nphc4aGoYg3b
	YoqbZpfIqrUW72EzeX8eL5kcsRfdPMHBL+3lRMdqeTmQI1nDkOzvFZjgPWlaSZr5/VE=
X-Gm-Gg: AYBFou0PmQQVzE/BMJZ3hmxHyNcrUaO9zH5/kkVhKhNQnhWFvaisGvy+HptXhG0b2FQ
	bDKhZPC9krksa7jbQ6c3RkEZjkZEAa9prWTR1D3HtyZLglBWlFfgTbO2ntbKVgzbcM0CN4K4FsL
	X+f9e8d2V9eT2IS+UNK7L+H2rGNPO8ZEkxUxqMWPXmGm0GRAGX1qGGM5qSws7pAxyv+qgsNPBrc
	0/ZOJ3x4YCAb8MBecPBt6RNZJMEUvZqEcwCU+L69wXHUov0RrFVmYma515lMuv+lgJDK0A1ugBS
	TAMa4SWPTI1JES8iTJHQfCUpdpa+TainvZGreHchsgdStXsy/662wzWDjcLkj/93WhaqCkAXgJx
	1WtWb4RL+t8saSq6dVK0gj9viaduRTMIBue115zeY2DbHFVu5chM9a99TiRrAyrzrg3P0bFxaug
	z5JMZjsNIGc1bo5RdB+Ic8EclDBhz97gCmc2YftVCHGkkbSgen/EXYDLpeK6seOMSmRmrI2UvtL
	ng95Ue5SzRCBT8gGTC8cQMBIDk=
X-Received: by 2002:a05:6a00:8c6:b0:845:e440:d0ca with SMTP id d2e1a72fcca58-86b2fe25315mr17990526b3a.8.1789288844473;
        Sun, 13 Sep 2026 01:40:44 -0700 (PDT)
Received: from G6L4RL2QG9 ([2409:8a00:1832:cf0:5137:990:100e:cc7e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29cbb0d3sm3070531b3a.42.2026.09.13.01.40.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 01:40:44 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH 3/6] mm/sparse-vmemmap: drop Device DAX-specific population path
Date: Sun, 13 Sep 2026 16:37:31 +0800
Message-ID: <20260913083734.86802-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260913083734.86802-1-songmuchun@bytedance.com>
References: <20260913083734.86802-1-songmuchun@bytedance.com>
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

The common vmemmap path selects the shared page for optimized mappings
itself, so Device DAX no longer needs vmemmap_populate_compound_pages()
to find a shared tail page and pass its backing PFN through the generic
population helpers.

Remove the Device DAX-specific population path and let section memmap
population always use vmemmap_populate(). The powerpc retains an
architecture-specific compound-page implementation, so select it directly
from radix__vmemmap_populate() for optimizable sections.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c |  3 +
 mm/mm_init.c                             |  2 +-
 mm/sparse-vmemmap.c                      | 71 +-----------------------
 3 files changed, 5 insertions(+), 71 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 9ca28e4a610a..cb72d9ccf747 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1122,7 +1122,10 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	unsigned long pfn = page_to_pfn((struct page *)start);
 
+	if (section_vmemmap_optimizable(__pfn_to_section(pfn)))
+		return vmemmap_populate_compound_pages(pfn, start, end, node, NULL);
 	/*
 	 * If altmap is present, Make sure we align the start vmemmap addr
 	 * to PAGE_SIZE so that we calculate the correct start_pfn in
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 56bb4567a494..1650d6bc1211 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1046,7 +1046,7 @@ static void zone_device_page_init_from_template(struct page *page,
  * initialize is a lot smaller that the total amount of struct pages being
  * mapped. This is a paired / mild layering violation with explicit knowledge
  * of how the sparse_vmemmap internals handle compound pages in the lack
- * of an altmap. See vmemmap_populate_compound_pages().
+ * of an altmap.
  */
 static inline unsigned long compound_nr_pages(unsigned long pfn,
 					      struct dev_pagemap *pgmap)
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index e83821768c12..028f844c90f5 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -454,71 +454,6 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 	return 0;
 }
 
-#ifndef vmemmap_populate_compound_pages
-/*
- * For compound pages bigger than section size (e.g. x86 1G compound
- * pages with 2M subsection size) fill the rest of sections as tail
- * pages.
- *
- * Note that memremap_pages() resets @nr_range value and will increment
- * it after each range successful onlining. Thus the value or @nr_range
- * at section memmap populate corresponds to the in-progress range
- * being onlined here.
- */
-static bool __meminit reuse_compound_section(unsigned long start_pfn,
-					     struct dev_pagemap *pgmap)
-{
-	unsigned long nr_pages = pgmap_vmemmap_nr(pgmap);
-	unsigned long offset = start_pfn -
-		PHYS_PFN(pgmap->ranges[pgmap->nr_range].start);
-
-	return !IS_ALIGNED(offset, nr_pages) && nr_pages > PAGES_PER_SUBSECTION;
-}
-
-static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-						     unsigned long start,
-						     unsigned long end, int node,
-						     struct dev_pagemap *pgmap)
-{
-	unsigned long size, addr;
-	pte_t *pte;
-	int rc;
-	struct page *page;
-	unsigned int order = pfn_to_section_compound_order(start_pfn);
-
-	page = vmemmap_shared_tail_page(order, device_zone(node));
-	if (!page)
-		return -ENOMEM;
-
-	if (reuse_compound_section(start_pfn, pgmap))
-		return vmemmap_populate_range(start, end, node, NULL,
-					      page_to_pfn(page));
-
-	size = min(end - start, (1UL << order) * sizeof(struct page));
-	for (addr = start; addr < end; addr += size) {
-		unsigned long next, last = addr + size;
-
-		/* Populate the head page vmemmap page */
-		pte = vmemmap_populate_address(addr, node, NULL, -1);
-		if (!pte)
-			return -ENOMEM;
-
-		/*
-		 * Reuse the shared page for the rest of tail pages
-		 * See layout diagram in Documentation/mm/vmemmap_dedup.rst
-		 */
-		next = addr + PAGE_SIZE;
-		rc = vmemmap_populate_range(next, last, node, NULL,
-					    page_to_pfn(page));
-		if (rc)
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-
-#endif
-
 struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
@@ -531,11 +466,7 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
-	if (pgmap && section_vmemmap_optimizable(__pfn_to_section(pfn)))
-		r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
-	else
-		r = vmemmap_populate(start, end, nid, altmap);
-
+	r = vmemmap_populate(start, end, nid, altmap);
 	if (r < 0)
 		return NULL;
 
-- 
2.54.0


