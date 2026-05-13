Return-Path: <linuxppc-dev+bounces-20899-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061E4CD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:21:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvHM21JMz2yjq;
	Wed, 13 May 2026 23:21:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678479;
	cv=none; b=mwukz4mgYGzmnMkPBXhw6gyfiLQUz1CXo8LKYuBfztJWjQquyvB4f04ckLaIP58DudOSjEt5hT5/oFLVHJpe5T/xWJWUg91M+z27KuGs3QjjOORzo6IOc+nHirNJSkFU/SgOpzDIR3nZ8ToNz5EsffQT4RcnITZsVsKT9jbmNDbOO4mHjdIEBwVTEDN59KUlsgLCyGzd8EfXZ5tTF4MHV6GkaVWEwcW/7d2f0uhGvt3eRsOGHbUTkkoOoxEc1JaLKJ+kcWUFWC0zP37cEFm8bxzinw4v7KVMU9k/nimNP83NleaIMuHMhQFQRB5rQCt/IaGANCyQdo4Tqbq6uYHHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678479; c=relaxed/relaxed;
	bh=pQsJbUbh8y0BvTtiLUFG2twbapHy6ttd2Doxr7AiD7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+q4Ik6EYncQyS+foz3ybVWNwrGhIXuttWVnx+BWU0AKR5iAQDtcZ8aqd1vTTnIl6zEIQ/OYIM8rtfsIeLy6LwAtorpQXx/8Imus1aHIU4wqXJ+mLSzl7JKRoeG4mMt1MSGg1XgJrtEITHhKg/7yUi6dyi3K4xJrm+KfHNdm5fmVVNovxRATvJRe5ndkMimyB9/lNtng/jNiYTqoTqmsGqNNWspZgzAGux9TThcQsvOCyVOaGLCfZGs/Qsgo1tiXtFtx9ECmtuGDD5qgGPQPT3MmWO4Q0CE8Evy7wirVXWHAR16rYc+Of0kkrX6aoii0xxF2Wfz1KOtDxESL7r5lUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lbaf+pId; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lbaf+pId;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvHL3x6cz2ySN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:21:18 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3664df32e91so5492509a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678477; x=1779283277; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQsJbUbh8y0BvTtiLUFG2twbapHy6ttd2Doxr7AiD7w=;
        b=lbaf+pId0HED9hsFmW0uqu6rId8VkSI3ke+JFgj6hKCReCeBCYtQ/rUQNs4sazVFo2
         QLVUYQVXZ9EM1UCF7gbDUuDqTbQbRUSRDYDnBqqGapsuR2ZbcMwp1Xuvm3S4LDQRuByq
         Tny486IG6iPGGKV0D7AxTJ1zCPjzAyz0JiOByNJgKduuo8p2iJ0Fv8KgcwuKT5U0krlp
         oLsVcgMoRiGtK2jtqruv3jOFFdbDMJeCLX9a18hcVCe9Yz1BwJwpwkMYgiBSaXzhIEyz
         zXbaB05oq/PJH5sjPd0cHzjb0IC5AHy9+sh+DTsxNVoAEuprICqsvJ++vHj2EnxdKFBG
         E1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678477; x=1779283277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQsJbUbh8y0BvTtiLUFG2twbapHy6ttd2Doxr7AiD7w=;
        b=lC3l2pAn8Wf48lDcIWQzEkqqv2UZvxouZZZpqlwca8SZHHwTtURVVnPpAQuYKe4RN7
         0Ug1uYUUsQjz2aYy4iddp4h+KrE2aeJie54gcQT9ddpdB4ZoZQPXCIpTD8ofQDsgL0uB
         iS7vjffQyY9gSNeOng8jtISyFHYqgK2FExtj17zZ3mrn/41JjsN2/gAOLGMTOXvo+8RZ
         P+SOfVhl5eiX3XmocxWpQbbIY5PVErTZi+lqWAdsiP9kUjHwAKtr/DgcNtEOcrFZoxZd
         rYWx9nBPkzYg2YD+4XEiELzFBKavEr0Guxe6I7lCJAYC4dTR64121GnH66yqch1uvf6M
         kLyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8l/VSPakiLyiivp/0Meiwq5qC2xbdKHc408o3l0887xE/K2VdAkxEWqEiM2E5OaX1BDpu8alE73mKiLM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwDZ7WRcPt+j1lLJFtWYVOzidW8GS87Ru9eQkZsauYOcPtfwYSd
	i4by0oupkkgHQBYALIqGqa/h8qDa1Z7otXvl/uSaOd0wmbq3naVa1gMeIsHGNS42q5s=
X-Gm-Gg: Acq92OGkwX5iz9jc3b8/W8LfXmaZxTQY4rLiqjd2HmVVKK1wzr+Tjhpq5g9+1I7/cfw
	cdidmcvgxndkNKlaVAsSOKLQVTO8NzSh82C7QVY7tJJQry3VMBs5HtE/cTfJCQv9UGZ+X6U1f27
	94IGce7rCnz0NhoTad69inBPZV7pRbq2ST45Nw7PLfi+zPeudEfLZLV3813gBhE2FsOQ6JTnJUm
	NQ4d7+wFgaeYt0tRJJ2YiZCVkxMJgsZkw7TIn6S2oBcu4W/H3HaOInyJmN8M3YCNw97DcyC3TZy
	JdQW4hRLH9AMFRbRvqx16GMwJSSu67Ytxej3RhMv0t4xMbdYDR90UFVSZXL0knGxJGYb3+zg76c
	Bvwwbxe1eoHw+kL23wVs0nU6YIZwTQnoAi0gUniVf9voJ+6wIQmgtmYMktKvPduxxiFHNkxiozr
	4nzxgjQQvZhu4rTJbaY0+V4rZL+i+198rIP4TUyyFNzfQPVDv4P2XmKwuDY+eu
X-Received: by 2002:a17:90b:3f86:b0:366:33a6:9921 with SMTP id 98e67ed59e1d1-368f3a909b4mr3549334a91.4.1778678476572;
        Wed, 13 May 2026 06:21:16 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.21.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:21:16 -0700 (PDT)
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
Subject: [PATCH v2 50/69] mm/sparse: Simplify section_nr_vmemmap_pages()
Date: Wed, 13 May 2026 21:20:15 +0800
Message-ID: <20260513132044.41690-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513132044.41690-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513132044.41690-1-songmuchun@bytedance.com>
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

section_nr_vmemmap_pages() no longer needs altmap- or pgmap-specific
state to decide whether a section uses the optimized vmemmap layout.

Now that the optimization state is recorded in struct mem_section, use
section_vmemmap_optimizable() and section_order() directly and drop the
redundant arguments from the helper and its callers.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/internal.h       |  3 +--
 mm/sparse-vmemmap.c |  7 +++----
 mm/sparse.c         | 19 ++++++-------------
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 18276cd15622..06022074ebcb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -997,8 +997,7 @@ static inline void __section_mark_present(struct mem_section *ms,
 	ms->section_mem_map |= SECTION_MARKED_PRESENT;
 }
 
-int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
+int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages);
 #else
 static inline void sparse_memblocks_present(void) {}
 static inline void sparse_init(void) {}
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index ce1cf5cdf613..793fd4ce1393 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -468,7 +468,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
 						      pgmap);
 
-	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
+	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages));
 
 	return page;
 }
@@ -479,7 +479,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
+	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages));
 	vmemmap_free(start, end, altmap);
 }
 
@@ -489,8 +489,7 @@ static void free_map_bootmem(struct page *memmap)
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
 	unsigned long pfn = page_to_pfn(memmap);
 
-	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
-							NULL, NULL));
+	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION));
 	vmemmap_free(start, end, NULL);
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 6878f8941b4c..3390cb82f114 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -237,32 +237,26 @@ void __weak __meminit vmemmap_populate_print_last(void)
 {
 }
 
-int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages)
 {
-	const struct mem_section *ms = __pfn_to_section(pfn);
-	const unsigned int order = pgmap ? pgmap->vmemmap_shift : section_order(ms);
+	const unsigned int order = pfn_to_section_order(pfn);
 	const unsigned long pages_per_compound = 1UL << order;
-	unsigned int vmemmap_pages = OPTIMIZED_FOLIO_VMEMMAP_PAGES;
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION));
 	VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
 
-	if (vmemmap_can_optimize(altmap, pgmap))
-		vmemmap_pages = VMEMMAP_RESERVE_NR;
-
-	if (!section_vmemmap_optimizable(ms))
+	if (!order_vmemmap_optimizable(order))
 		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
 
 	if (order < PFN_SECTION_SHIFT) {
 		VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_compound));
-		return vmemmap_pages * nr_pages / pages_per_compound;
+		return OPTIMIZED_FOLIO_VMEMMAP_PAGES * nr_pages / pages_per_compound;
 	}
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
 
 	if (IS_ALIGNED(pfn, pages_per_compound))
-		return vmemmap_pages;
+		return OPTIMIZED_FOLIO_VMEMMAP_PAGES;
 
 	return 0;
 }
@@ -294,8 +288,7 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 						nid, NULL, NULL);
 		if (!map)
 			panic("Failed to allocate memmap for section %lu\n", pnum);
-		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
-							       NULL, NULL));
+		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION));
 		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
 					SECTION_IS_EARLY);
 		usage = (void *)usage + mem_section_usage_size();
-- 
2.54.0


