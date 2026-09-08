Return-Path: <linuxppc-dev+bounces-26711-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B3AC79F9F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 03:05:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hf81W2gT5z2yjp;
	Tue, 08 Sep 2026 13:04:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788836687;
	cv=none; b=gIMViH/kxTw5llKrTDyLS24P26aDfvvqiDrfDeIryBzYm+I8ChzUjSpLoPub8UvvH0qiVzqXbVAzzqsrxy+24eTJiozBxypgglwPhoYIakBQfE5+4YOFpI4UMgVldt21WN2sc9u6ib83dnyRTamSxRB515GNgldVI3xFBBEaLmuiIUWSaTI5ozX5hidmmrKHDpBKs9inNvk75V2wC3qYxgeQkLsqt/U2mm7bAORjjJAHiSIty8s+4rjL4MuTJQjdMWFucpDbFBbwfGbVfXm47hy+5XzSif1xBk/pFFiTaNyxFszJ09g+a2dUbm9y4RbR2NLk1+LST6f+GBkA4d3ZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788836687; c=relaxed/relaxed;
	bh=8Uns/ZJlTRrXsZn1DdaJluablabo4P2O8/HR8HKp5bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQjpjXQVLrlPq8Gq8UgyXHZmTmvKJ3ZCYlMCVdmkR+4RcdDCVaSqTlWeLgLm4NytBYHf0wx9q7CFkhQVsxZUL8R1nYbH/cDrPl2Ld6ZNnpgkDyEcCBfndNvwCbBMPEcHOIhbmplUKfnmK75n6BnOQDTetFGFHMYjcjBU52rqceOWTiBt2QEh4tMcLafoTdncjBxpVui7IbYOKAMeWF8iW4JzqPF7vfBqtOXloItPlGYzeqHBmGGCOez5LD00eU+tvI5DeBFnz11e/Sv+uzkwv1ZQJqitHV/yZ0pibCgCpsBSnsEH/64wP2+Pdw3/I/PugYQrV+jEA+SoUfS32KjrvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PwJp7U2n; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PwJp7U2n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hf81V4ylGz2xq0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 13:04:46 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-8485b358552so3665768b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 20:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788836684; x=1789441484; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Uns/ZJlTRrXsZn1DdaJluablabo4P2O8/HR8HKp5bE=;
        b=PwJp7U2n3u+J6mgIGI9NtFGRU3baLfXzOzAURHpHWSgUFuPvIaXMpqA7OHgo5keoim
         Jpd4mbZnf3qmI4Q0z+ajDX5XhtRHyKq4RHZcs+xBB1F17YHJ3f7G+ojtYpU22NmWLPhE
         kXU3A4d1mpB4GvKMBxa+JDa0YupllFGbfIvCTsgshOcXEg6cgUwO4NNgLvO2mOmLXCUO
         AyntHigEl7HA0zzRuzNch3/mr/SDFQxoW8BjFEZMYEIDLBTOPRSMjkJi3oPiWQCrPeJl
         6YT1FFBKTyHhaagyn7TwJAGp6lmpbWj0PsaAgaOPz2zZWvzfnp9feKGoYMXbcNTpB7j7
         cuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788836684; x=1789441484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Uns/ZJlTRrXsZn1DdaJluablabo4P2O8/HR8HKp5bE=;
        b=ebATiFbqWqFhJhPwE3pwaXEm7KqJNKlgbnoTkd6NLn5w9SFCSDP0SInkep06mzf3OL
         OlcSOyLCjO/LYyTYf9UGFe56geXVqnkMDLtTSvMo+LYjCy2kcFBe/NGEKPkaeBbZVV9A
         QYKKwXuj1NoVEnFx0GlGvh581cYu+elDQX/oL1goHUAcSVs3ptSW2X64PbJYztzQ284W
         zhGL5SPfnU/O1ox2zPrFtP0LYdCux+Mtj0Nj+DiN/EveNq3ktM2DR0L3uKiJvDBnNAQu
         sA7fCwsShAKB5N4LrML5VkkLbh7vF3GqYA6+4B/4mdwbGCTpEBSqzNyFzZt8eBTLPKSY
         tFIg==
X-Forwarded-Encrypted: i=1; AKwUvBxII6ELU84iVGLc1PMPmy9lZGysW80P4Li+jnEbX8ts7rKjVGKKzMilAs6SNsq5NtRVqIwzbu+8RFETqbo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lLeN8dT7A2Wht+7nCkGRa6KoPCcx2tAQ38KzQb7jtwgtj7fkJh
	dIz3MzUleJCCxsptygHLKP5HGcV0mu9sM5TKma0WR+1jjfT/wUdQ8QQyIPHwK3sqHWo=
X-Gm-Gg: AYBFou2THNQn4hPl0FxdoQsH//EXe6rFWugJY017wTFnFqP/9zgIyoVnOnVt5I7Viaj
	0HM1z2KOEWzdBHe9EY6hOeNZjVuA5QujZvbYJMgiX/S9MZDYGn1oJaW+UeCM3nGbxqVPAsQhypF
	kuXPHLHJnjakRAQ7BVhgiCV+qsaysfOxaCKLRGhH2HgjYW51793TkbM2gtk0pPGkbbOp79Y+xXz
	gIRhPp8fdwdYb9jbZo6X53kNVIleRUEwGz7x1u/gK9CFWHpZECnLfrdf9LExbnD7qBaBkywBkm6
	PHRT9rdNYRu2N1F9oY64xus90eTTIxsBpfros9zKC7b+GpovDPj7ZZcZvWk3XxFurNyG/HYiAM3
	Pn5ZVssTHIgdBO3xOdmosFspCyVGJaJ/KJX7ObO3K3T4YaKCcp5hdKNzZgXwZ9cvlQzl2rbqJe7
	xdU4h8+w1M/PJPtO4zxSH+NYl7/LW3l+r5z2dFcMoCzDSYsJIEOjRZgJHsN2L6vkuHIMxsQmho/
	gV9HFDMwo4XY797wIjoiC5MUw==
X-Received: by 2002:a05:6a00:3494:b0:857:726d:2e95 with SMTP id d2e1a72fcca58-8616a96c426mr38438397b3a.18.1788836684381;
        Mon, 07 Sep 2026 20:04:44 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152a358a2sm4868234b3a.29.2026.09.07.20.04.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 20:04:43 -0700 (PDT)
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
Subject: [PATCH v2 10/11] mm/sparse-vmemmap: drop unused section_nr_vmemmap_pages() arguments
Date: Tue,  8 Sep 2026 11:03:34 +0800
Message-ID: <20260908030335.96549-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260908030335.96549-1-songmuchun@bytedance.com>
References: <20260908030335.96549-1-songmuchun@bytedance.com>
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

section_nr_vmemmap_pages() no longer uses the altmap or pgmap
arguments, so drop them from the helper and its callers.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 10 ++++------
 mm/sparse.c         |  3 +--
 mm/sparse.h         |  6 ++----
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index e655d9d1348f..4950ac2a1c01 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -131,8 +131,7 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 			start, end - 1);
 }
 
-int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages)
 {
 	const struct mem_section *ms = __pfn_to_section(pfn);
 	const int order = section_order(ms);
@@ -637,7 +636,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
 						      pgmap);
 
-	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
+	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages));
 
 	return page;
 }
@@ -648,7 +647,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
+	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages));
 	vmemmap_free(start, end, altmap);
 }
 
@@ -658,8 +657,7 @@ static void free_map_bootmem(struct page *memmap)
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
 	unsigned long pfn = page_to_pfn(memmap);
 
-	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
-							NULL, NULL));
+	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION));
 	vmemmap_free(start, end, NULL);
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 9349ed6326c0..adf057f54c0f 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -251,8 +251,7 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 						nid, NULL, NULL);
 		if (!map)
 			panic("Failed to allocate memmap for section %lu\n", pnum);
-		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
-							       NULL, NULL));
+		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION));
 		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
 					SECTION_IS_EARLY);
 		usage = (void *)usage + mem_section_usage_size();
diff --git a/mm/sparse.h b/mm/sparse.h
index e511d99fc26b..5d0f407bde7e 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -70,12 +70,10 @@ static inline void sparse_sections_init(void) {}
  */
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 void sparse_init_subsection_map(void);
-int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
+int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages);
 #else
 static inline void sparse_init_subsection_map(void) {}
-static inline int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+static inline int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages)
 {
 	return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
 }
-- 
2.54.0


