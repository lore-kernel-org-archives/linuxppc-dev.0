Return-Path: <linuxppc-dev+bounces-28303-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EBCC9832A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 02:56:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hspwN0V6sz30gY;
	Sun, 27 Sep 2026 12:55:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790477748;
	cv=none; b=dWl4IGWTh888lUORZkWVgwGZrFSDvjAzihxssMZviRi7PcA0BD02hx6/EADkvdVqwZjd9mUyHEfkpwPo+VcxfxE/0XdeXIOMQVUhEfe1TO5cn7j93WPpXUao1EluqmFumj6+uMQPSg/e5GEtBJiIT9AYCxmAwPB883cFcQghOaLfaNzyEUNVdaDGyc4mY8Y6fpzpav42psZFZmHGfRcbnmejRm45CDXzeGW8+fel0B/jXP9DuC5f1nshF0qYtvduqDobUNMuK4B9np2/69LMUwWOuTJKCGVOMjB2OO6DUxg0Kaai0oEedPhlTMRm177IpeR1qguBQjfEE55+i+2LGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790477748; c=relaxed/relaxed;
	bh=2CIuL28jJc9rBcE3veHd1eORcVK0n34BpltfpMfOrf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/hy0kmRZ98u2NGnGd/wO70fI7BKoLvHYmCbf4+R2P80Z9UA8ISZCZD0o9NGN7d4NAf7FGbOal4EzM7T8/tIcesgsGf6Fd0TQdBAgvx43Kfy5t2RBAl9NgsfzNL1uOaUHTheCHkUXUvY2dhHmlIZEJcJ4CHOsjyrbOFSaG1kea+ch/gk723ZnNCBqX5XcKHXEYiL0rNxE2zGHITUMKynvk2OT2mwlsFl9caPT/ZbyiTzWSFO8mZm9crY+csJqY23lDnQZgePo6ngWoIef62BXuDOvvwZDbhuSs8bsRklHLowiJs9m6aGVBCQP/t2Vk9Z9tAHOi1I2q0R+152glHAYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KdEP/ZEC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KdEP/ZEC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com [IPv6:2607:f8b0:4864:39::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hspwM2dxHz3048
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 12:55:47 +1000 (AEST)
Received: by mail-pj2-x0f.google.com with SMTP id 98e67ed59e1d1-396ccafb752so1038161a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 19:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790477746; x=1791082546; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2CIuL28jJc9rBcE3veHd1eORcVK0n34BpltfpMfOrf4=;
        b=KdEP/ZEC19hvTkisU0nChIeB224kvM0DoQkflL7rB4PuLgFHwCi9IhfMnA/pqAXacP
         WL6PkaI4MiBFVM8S1YJNrtwGJHL3tFqwJcHg5jjnFqS5pWMaj/3mEhTD3huWvmVabMDp
         PGesMheevy8e9Emujh26CFo/PESh9Gz3+ipC+z/JbfPPnoREH2TkEhd6QjKYnuBq/9Hx
         ONCV00OmKsLLTvVrTQagYX9O9+tf0k+kFOKWzMSU4cSSqTPxisBdiXy5z6DKhoGRaEm9
         GDp+Guy6VSBOLQajT4+52aewvGJyZzNG8Fc3lfQWEyObni1EH5Gr9XV1rxlkrVXItSd+
         Iq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790477746; x=1791082546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2CIuL28jJc9rBcE3veHd1eORcVK0n34BpltfpMfOrf4=;
        b=SkXUrvR6rZZJgaSx8DkPdf6pMn0gct9t2geFxmH9JzB02o5nXoWDPyFfhxLhvDkOX/
         YFQ1WChrec2iVxCaO3C8FPsoVCPqyCbJqCxs4BqZ2rdSSekGTV3VllmNJQhP1aI5yehf
         oL0IljNOiE9relQeK7KybhmNadLFN8UwcWtPrWRtQ2Pa65+9f0ZF91JtlHKjcJb7ebXZ
         4EatCYR6lDpNMoKoB8WMQ+Yv6CBFoH99FTixNz5SF178pFu6GjMi0vRNcSgfnNL1hoaF
         wE/40iaPqaiBDB4G55carImdUmJDOTbfWgrB1Chu6BZaHfCvQB/wLagvoBiy1gBsbx0a
         MaCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzrBXogWNyhsw9IbcTIncXw5H4D7TQX1EUr80zfCP6MnaTTt36fgXiakhvQPB8SI1cDrREkA+wbj0pl8Vg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJMatmB5Nwfk293imhN8YBguRtbnwWAap2erd7o9NKZnMRgSNbO
	PFQ0Xdi7AD/AUCSKoPp8H+5Iaxz5ipLWHoft2RLGNSie/3TYzJqCgs7I2yCBXsMETdD91lHCIQR
	CXOZ+
X-Gm-Gg: AYBFou3j03OwChGORGBL1ze3QE4a/mhEFZetcEfLsqbm6rvpvrl6a3tT7d1bYRhOxL/
	Gmv1s7zZWLEQCcnPJdd/9HsVdxse2Liak2SKc0n9a7GCo7ts2YBAhzLMtY+nnY2178j8ck8XeAq
	hoih8oGsxE3PGpVFk812utjxXgxeFMe0cpS0+h0AMMbfpopAfxQGwOWmqkiQ0eu96M1ROv7qfGi
	xoQX6DT+7dnwR+pOLle0/nLqSwtlQeLqXJv7IjJOvABO6Qkq85x4kgkfRbuBB3YBKikJvXouD9X
	2ONdzLYmCv4S9DOPr7TYANwuX0wJt3Kqk8BL8tuBy5wS7w7E29MnA5rl/jay3bN4bJII+hg2ePE
	k0jnYTLJ0ncJVEtm7mIFi/LFur7aMjWxc+ZgtdVAL6dM6DYIQqu7hu0JETFoeyLoBy2nxZyOfJP
	5vOxymY74zaR6xXaxvMaRjLR+v8jvSwp0/yDPAsx0JHBBo/z2XiiO1rcsSGdlAZYvtFeWwSNN5t
	sOd5LAP09o3RkBT9nwvCD1yJ6j1rdA=
X-Received: by 2002:a17:90b:380a:b0:3a0:be2d:3853 with SMTP id 98e67ed59e1d1-3a0be2d3c4emr5473938a91.8.1790477745543;
        Sat, 26 Sep 2026 19:55:45 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm13461377a91.1.2026.09.26.19.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 19:55:45 -0700 (PDT)
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
Subject: [PATCH v5 11/12] mm/sparse-vmemmap: drop unused section_nr_vmemmap_pages() arguments
Date: Sun, 27 Sep 2026 10:54:40 +0800
Message-ID: <20260927025441.741633-12-songmuchun@bytedance.com>
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

section_nr_vmemmap_pages() no longer uses the altmap or pgmap
arguments, so drop them from the helper and its callers.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v3:
- Collect Acked-by from Qi Zheng
---
 mm/sparse-vmemmap.c | 10 ++++------
 mm/sparse.c         |  3 +--
 mm/sparse.h         |  6 ++----
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index b6378826b9a2..b617ff1b985d 100644
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
 	const int order = section_compound_order(ms);
@@ -666,7 +665,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
 						      pgmap);
 
-	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
+	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages));
 
 	return page;
 }
@@ -677,7 +676,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
+	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages));
 	vmemmap_free(start, end, altmap);
 }
 
@@ -687,8 +686,7 @@ static void free_map_bootmem(struct page *memmap)
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
 	unsigned long pfn = page_to_pfn(memmap);
 
-	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
-							NULL, NULL));
+	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION));
 	vmemmap_free(start, end, NULL);
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index cc28bb41fdb1..b75921c622ed 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -250,8 +250,7 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
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
index a5111087ee3a..530692cdd516 100644
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


