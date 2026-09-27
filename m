Return-Path: <linuxppc-dev+bounces-28297-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7A9C9833E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 02:55:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hspvp0QYtz3bf8;
	Sun, 27 Sep 2026 12:55:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790477718;
	cv=none; b=e6EyWVOB6Sbvk9mhb2Mn4QiXDRbun/h26mgWXUWns0+JCAgfDOE7ywCXwM0/TXp/LLzo8Otg+CIqYJzzjqYKQ+YxcvsHrnhUW8rFMYYYgEkQhUXRlJM/JpQY5ivg6eOiIGUHA+GijxBy+hEbzTumfXR8l4FQHB4+mT0IcvNnO7qvepNIqpuAeb2ssVNbFbA7cjs1s6ilwbmxmRK+49Qc292wQtMiPyqHuXEpAaV/ImfgyE0eTF2V3d9HB1LN8S0ZvSWXaSDbKmgYI+83dq8ajwKy3f99gbXQZoMxl4yJdaOKIiu1R6CxBc/ZRN5MzOEpBa75laPlAN8oJVYxkY8VOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790477718; c=relaxed/relaxed;
	bh=LUj4I6qYRPvWCdYjNQvAZHgpJ85hBpDlWBdY9AxEym4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Do0UJeLD63OzWzWVs0tkdBcv3TXWNPF68GM/1Wetn83t9TXArup3GFbLQ+3zAivKpP8sIBGVa1wY41yIMrHI8JNCn0/GCFAb+OVK9GrwMshVZsnOWzJDElEA390rOrAL1xBoKb5UyOOzx2HAeDDWD4E5GlzwKDdQt+Ux3RV+G5FZ33IgRp3JvRT5OV98b2Mw+FeBitH65PQoj8izXHs+uUN3dMAIdxHlJ4yUJZNyvi5lokvQgFrXvgvZfpPixjIJdThNBe6JY7tVtK40RtKGmIjq8bQgQyAtGCJ5E2L39cIoRZn3lmnKIlrjkT8RvdH9xBge7ERerLwVjpbKeKfLNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=OtPasdGy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=OtPasdGy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com [IPv6:2607:f8b0:4864:39::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hspvn2W47z30Vn
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 12:55:17 +1000 (AEST)
Received: by mail-pj2-x0f.google.com with SMTP id 98e67ed59e1d1-3a0b0fa2055so1174513a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 19:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790477716; x=1791082516; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LUj4I6qYRPvWCdYjNQvAZHgpJ85hBpDlWBdY9AxEym4=;
        b=OtPasdGyOxrVRJ6kg9FVzbKhAwhK37NJGrM5XW8piwit5hris2TutEanjm03SfC5tr
         XKrJqssHql7DwEHFO+qjtGw6T11B6K++w6vC8ucNPPusGIXflAS9U+k1L21NKG5cj5EI
         yflDsIgN9wT76FzzPlw7fldHp89Ei14/4e9xC4vnjjVhWU/eKC76rPFN2/zYaQv+0FB5
         Nc8SolvQrXI9nGFmC9a0otvPa1oP59ZXJgr0+7VXnk9BygdlE5AzIWO5N0fLcEuN98vK
         cq92t5EE/LGmrLWaedcYjp+9TFiEzj80HKeAQs7SXABfBdUSGKwjkADseJ0XH6PnRH/9
         dKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790477716; x=1791082516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LUj4I6qYRPvWCdYjNQvAZHgpJ85hBpDlWBdY9AxEym4=;
        b=Yddrct00MIF01mcT14xCIjYIPv3cdbxGzM3eqn8TlbetINMHzbOIXoZyBqVdTC3j7v
         l1tg5qcnBKO94sTQmgt0xLEmmM6f2SJ/wHNB+nj5vWOorupoAVzNmc5FsrKpHyGHa8PW
         ei/pA7O2aTbbgVn5PYQr41nxJ1DH7jk98Himy3mMVV2nPX5WsZHHyNSrjtwyGTUyFauR
         NnMxHRY+XdNq5iDMTBlZgRfIQiKomqvyJQ5SjTPZT+wB/YX28pPdGJhDsg2WA7LmySkp
         QF3pUtCOhWEBnLwIw/bYYoc7K047MzyHsWdLJvKXdYLKHpe/kkmX4ucV21hjfaGJXkZj
         YXKg==
X-Forwarded-Encrypted: i=1; AKwUvByy5rlnWZ/JkESXUajSdloCXR6YFRnjIeQukrsSt2NRF96JlaAtygUMvC8JUBEKDkaYw/Rwlke84Q26hBc=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJcmRWdpGTCnk2Ej+0NFKYTn1nkXYTW5O4BIVPGJpywdsx/mtS3
	kXWU3htrkOKLW8yPPmw9imlWVsYQcf6ReaJl1fxysjCxvOhPZIesaX+cX3ueJxJjeN4=
X-Gm-Gg: AYBFou3lioTlfja2tSSV29SKg6Bnngj2mVxC1YWrE8yyDikUWfy41mxWiDmGeBEkpiK
	OXrwm+3aTSj3wlUpz1Dj2/p7XD32KDEXrIKcbLDkaiTqZnKnQeZcOL+qWA3akURrNAL/Y2R/i45
	/3zi60RUvBszEjlQHNi6i3ea8xHC6Jf0FUj3MlZ7dG22xH51ji3SaKRiTZwzJ92VbPGVCKXG+ho
	f1ifCZZvdObCgaoXWMuKoPKdYYGKHPqefLs5HQNZKlHDrxzA639El4gLhJsmKP3vZA1nGrltcFZ
	fARTVc+5ac2BOP4DPFCpC8JDqMgXq+8bRppLxhTymV6fvi/W27rEwhCn7SUxicojdRuP8k4NYVu
	W0t31H8v5eFUqjzWXP1uWY+rObIkWox6E+LljmttV5Las7VLhLf0hOjTBgrTctip6y2gjxj0Ahr
	Sj6yS5x6xK0zQ/3gkq0tt0Kk2DFtfN056xN4GDWx9wcj28ywwhlSFtMFLPFpuyOlKRLstlf6Yzk
	hZVnGbuYI07lAcOmBBSfw==
X-Received: by 2002:a17:90b:3888:b0:3a0:cc33:2287 with SMTP id 98e67ed59e1d1-3a0cc3324ccmr4179593a91.6.1790477715477;
        Sat, 26 Sep 2026 19:55:15 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm13461377a91.1.2026.09.26.19.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 19:55:15 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v5 05/12] mm/sparse-vmemmap: prepare DAX vmemmap population for compound page orders
Date: Sun, 27 Sep 2026 10:54:34 +0800
Message-ID: <20260927025441.741633-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260927025441.741633-1-songmuchun@bytedance.com>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
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
index e4dae98ba7f8..2457ea2c6dca 100644
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
@@ -243,13 +243,17 @@ static inline struct page *vmemmap_shared_tail_page(unsigned int order,
 #endif
 
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
@@ -271,7 +275,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 		pte_t entry;
 
 		if (ptpfn == (unsigned long)-1) {
-			void *p = vmemmap_alloc_pte(pfn, node, altmap);
+			void *p = vmemmap_alloc_pte(pfn, node, altmap, flags);
 
 			if (!p)
 				return NULL;
@@ -286,7 +290,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 			 * and through vmemmap_populate_compound_pages() when
 			 * slab is available.
 			 */
-			if (flags & VMEMMAP_POPULATE_PAGEREF)
+			if (flags & VMEMMAP_POPULATE_DAX)
 				get_page(pfn_to_page(ptpfn));
 		}
 		entry = pfn_pte(ptpfn, PAGE_KERNEL);
@@ -546,6 +550,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	unsigned long size, addr;
 	pte_t *pte;
 	int rc;
+	unsigned long flags = VMEMMAP_POPULATE_DAX;
 
 	if (reuse_compound_section(start_pfn, pgmap)) {
 		pte = compound_section_tail_page(start);
@@ -557,8 +562,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		 * with just tail struct pages.
 		 */
 		return vmemmap_populate_range(start, end, node, NULL,
-					      pte_pfn(ptep_get(pte)),
-					      VMEMMAP_POPULATE_PAGEREF);
+					      pte_pfn(ptep_get(pte)), flags);
 	}
 
 	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
@@ -566,13 +570,13 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
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
 
@@ -582,8 +586,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
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


