Return-Path: <linuxppc-dev+bounces-20883-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775C8CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:11:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv36741kz2yZ6;
	Wed, 13 May 2026 23:10:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677842;
	cv=none; b=CLSmIopyWNwLQMJSG2FpE2d3vZLcClMZVPMDv97SOOLlV8P2N913Aey35RCD4OtvbBC25CWt5wHZOcm5jAVEMreu24i6QQnq1K2TqmGt/6BW9wiGnDMiw268UoSMc4R895xezs2c5+s3oelRIG6V8Yd/PnQQ+n+JuD+2T5apgFao+0HyzgXuU2FV9GHy/qsoEDpUBbnXR5Pmi6EN2yZ52/cGUkC8wyfYBKpYYi3eDzzs4wfW/33nPjcQlJFrIxdLe0MsnsJswc/FN40Z0sQrP3vgXiE2ztqMO+/VE2zzV2Rg7DlaRAly7SBALAYx91X3UujIYSuyv0BRkYbIX5diSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677842; c=relaxed/relaxed;
	bh=LjpGKbpR87QdpAXzElJEcltafcXUZyW4c5xpVY2ebxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MuO+h2auuwRU81Ca8HzCcnMr0IfNXsxeUBfkRL+UPwoPDG6fqqssO83KQr7flUsfvs3lnSx3E/wi8yOL0kbbFrVGm4vTw30r6dMJNkpecXIa3GkyDge21rdEYSv/VQr6wAAW87eJDGH7Jf1M5A2RIi25hHGhn1dMmxNCs2zilAlRxWRz8ft19YteyX14NEYZnGPN5qAl4Y070Ey6ockaX7I9RjVgFO48MSbG2yBp9Swd7XadFJugdgn26JHEZMmr04ALZGt/eXQLIJczrbRcKBezO73XsxZkT21m1iaSRg8xNbLP2tdeqV6R3z9FqywunBuqdY0L9HKxN7IPKLuZRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lHcDCZRH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lHcDCZRH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv362R8jz2yCL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:10:42 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2bc763e2ba8so21663805ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677840; x=1779282640; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjpGKbpR87QdpAXzElJEcltafcXUZyW4c5xpVY2ebxg=;
        b=lHcDCZRHTBlitEYvtPTFj0gQ2fKVSYsNK+eUgH2SmNqLdHgAaRXP6EAVDSkeynrpNY
         P/evUY/DrTQCj1BzymiLsSUfa6l8ml+XpgjeKu6Et2duxPLfl9B72pjVT0zWbaRrgcdu
         8sJcaOqsF90CMNtbqhwvRbmGqSj8RZZGzg0Wxw9IymE3dQh4idMRHnZTc2RSdxgrlDII
         RuSi5De1X0bsr0+1lP09DqVNGgCEZh/t6ZrGAXqWAxTa8aeoiBKRwJUwok3gCiepXc0A
         A0YyQXveGs9G2w14X+9Xsib/13/16jn7R6qk6LA06hZp8WZpYm9CbQQXfZ2k5BXuEj8P
         HLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677840; x=1779282640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LjpGKbpR87QdpAXzElJEcltafcXUZyW4c5xpVY2ebxg=;
        b=ZCeMsr1co2gm6FKshEclWLK4ANwWHa4unjJDNMfaC2UiVs9B3MIRY6e/sdoYNhv3mv
         2tzgXWjYAZFAi8GFnIQjUK5DqXeZH0XuYrGsDnACD34UyMHyJZ+ARiHcypx6dBAZTDF8
         mYO8d3Bh49yyyrRXgf8wPkgjOycGNA89O+j2gxnoVDoJAABj59AO7hIFMPEwg7LwkcjQ
         c7y8BuG/svtEDwBXSejWnTNVbm/jkeRmQVrXhknrAfGaoqQwWBmpw9JXCKpXJmLqY8Tx
         ClI8MbaFY55TmZShIUm8cmEZJDr9jKZnserVTweuic8kDZ4XeIpr+8qx5FdB9VkIaV3x
         sjIA==
X-Forwarded-Encrypted: i=1; AFNElJ8sfIYYZhJeFtbHhCCZK6njgMSHjTR8J70wVKY0rhkbxJEDYGCFy9AnRoFAjxoxsEraNowqJ2yQHQvYbVI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxdeF/4zG7aZZCcTmwbR/Muehn1mRi/czN6u3+KTbOgdCtfF1SG
	dECV0WQKLRlQzl9arN+m0KmU1Tc2o88MI21hSqTS/Tr5ohR9Ox9O7fqdDUQXJ3eZNkE=
X-Gm-Gg: Acq92OEgtQrIt0u4+rqktpVfnQQNCUpvR67BOCK4jsL6rOlbJmYkKf14bPZ6GQIcnjl
	aVkSnv+cZH2Zc99cENGzZBMM4gCIlBt/khinZVXEti6oBiLzCZXnMD/ruKrOzzsR0X7jLOtix6k
	NUorBw0PDroAcayV5EQ4IXGuTkc/PQzzMVxxCg5SAkHxbWTa1jKFxljE/IIbrQb/XbHBEgEP/J8
	PhDmhipeTAHtIMY3A5LK8StHlgcSjqTNGQQrV9suLJi+0ouopLbDGJnZkfOKs5q/504aZrD62hC
	rx0qUP7KJv/X1Yyq4hoiQeftlXo+h/n9aKMomKL3CjBI6FvSWJXIMSeY98GDTK29jVb7q9g1i+D
	qTUT7HoHfeya1//tvt3KG2mTQ/YBc5oV2LLpxABSatwOoWDpPfRebWKwOqCeX6fe257xfhvf66n
	uF5peRdGFtlN/DsoqvdgGvV16J+Q9SYxc2aQja4xnjP8ofVkLMaqnZcsymM8rgA1DV4WJIew==
X-Received: by 2002:a17:903:4b03:b0:2ba:99a2:c44e with SMTP id d9443c01a7336-2bd275c6b33mr34992375ad.21.1778677840351;
        Wed, 13 May 2026 06:10:40 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.10.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:10:40 -0700 (PDT)
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
Subject: [PATCH v2 34/69] mm/sparse: Inline usemap allocation into sparse_init_nid()
Date: Wed, 13 May 2026 21:05:02 +0800
Message-ID: <20260513130542.35604-35-songmuchun@bytedance.com>
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

After removing SPARSEMEM_VMEMMAP_PREINIT, sparse_init_nid() no longer
needs the transient sparse_usagebuf state and its helper wrappers.

Allocate the usemap buffer directly in sparse_init_nid(), pass it to
sparse_init_one_section(), and drop sparse_usage_init(),
sparse_usage_fini(), and sparse_init_early_section().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h |  3 ---
 mm/sparse.c            | 46 +++++++-----------------------------------
 2 files changed, 7 insertions(+), 42 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b9baef8cca91..a60fd5785fa5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2265,9 +2265,6 @@ static inline bool section_vmemmap_optimizable(const struct mem_section *section
 	return section_order(section) >= OPTIMIZABLE_FOLIO_MIN_ORDER;
 }
 
-void sparse_init_early_section(int nid, struct page *map, unsigned long pnum,
-			       unsigned long flags);
-
 #ifndef CONFIG_HAVE_ARCH_PFN_VALID
 /**
  * pfn_valid - check if there is a valid memory map entry for a PFN
diff --git a/mm/sparse.c b/mm/sparse.c
index eab37504819d..54c38ea08190 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -237,42 +237,6 @@ void __weak __meminit vmemmap_populate_print_last(void)
 {
 }
 
-static void *sparse_usagebuf __meminitdata;
-static void *sparse_usagebuf_end __meminitdata;
-
-/*
- * Helper function that is used for generic section initialization, and
- * can also be used by any hooks added above.
- */
-void __init sparse_init_early_section(int nid, struct page *map,
-				      unsigned long pnum, unsigned long flags)
-{
-	BUG_ON(!sparse_usagebuf || sparse_usagebuf >= sparse_usagebuf_end);
-	sparse_init_one_section(__nr_to_section(pnum), pnum, map,
-			sparse_usagebuf, SECTION_IS_EARLY | flags);
-	sparse_usagebuf = (void *)sparse_usagebuf + mem_section_usage_size();
-}
-
-static int __init sparse_usage_init(int nid, unsigned long map_count)
-{
-	unsigned long size;
-
-	size = mem_section_usage_size() * map_count;
-	sparse_usagebuf = memblock_alloc_node(size, SMP_CACHE_BYTES, nid);
-	if (!sparse_usagebuf) {
-		sparse_usagebuf_end = NULL;
-		return -ENOMEM;
-	}
-
-	sparse_usagebuf_end = sparse_usagebuf + size;
-	return 0;
-}
-
-static void __init sparse_usage_fini(void)
-{
-	sparse_usagebuf = sparse_usagebuf_end = NULL;
-}
-
 int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
@@ -312,8 +276,11 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 				   unsigned long map_count)
 {
 	unsigned long pnum;
+	struct mem_section_usage *usage;
 
-	if (sparse_usage_init(nid, map_count))
+	usage = memblock_alloc_node(map_count * mem_section_usage_size(),
+				    SMP_CACHE_BYTES, nid);
+	if (!usage)
 		panic("Failed to allocate usemap for node %d\n", nid);
 
 	for_each_present_section_nr(pnum_begin, pnum) {
@@ -329,9 +296,10 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 			panic("Failed to allocate memmap for section %lu\n", pnum);
 		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
 							       NULL, NULL));
-		sparse_init_early_section(nid, map, pnum, 0);
+		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
+					SECTION_IS_EARLY);
+		usage = (void *)usage + mem_section_usage_size();
 	}
-	sparse_usage_fini();
 }
 
 /*
-- 
2.54.0


