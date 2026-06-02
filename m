Return-Path: <linuxppc-dev+bounces-21881-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF9FCD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:11:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV6705Br7z2ytJ;
	Tue, 02 Jun 2026 20:11:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395084;
	cv=none; b=b8LUjw850w6fvDH5Yd/0GoI7g7DcOfCqsRmJHQVUpr0NLZAp0xnht3MyKk5ri180i8/LZoJfzzYAv1wd0ynSxuAQxD4ztBlUWRhWb1MnKtPmQNg/aarDgZ2De00XtfedFA7qwvGjLN4aJzJ9k3gNxrH/PjYfZdYPtGYLx04lTX5HO7IIFUuZi5HlNMBXLgazisJQA/e/OTt+PWFgkAb8PEzW+HqMGPGjKa0TnIttv5iwV9cUzI4RCO7357dAF1HIp2p7kkuByjephofkhmwIt1LizTgBxYaCyP3qLzPQy13uDflWdm8TObq0bHDBLZNy7jEHuwl9zOCfXKChxBlH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395084; c=relaxed/relaxed;
	bh=m1Kna2jMMM5bJ6rAGniT5H8QaKGxjLzFWpw04bCbO68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBuVcyAALVwwh3PtuWVVTeSUmvY6oY1KPEmsZN4+tv5tBCcm1Sk4BGa7CrwIlYorlDiUd7hKh7l/Dd5h3VUrRfVd7HV7NsVOwaKdFTSwmNva7DZa5CQKD/lCOHn8Kz/XTZ/fxECp/MN2g2v8Vyifcu/KWh/Acj9h0KJx3EBPAJQz8vouR2I3vucD+bNdyiXfMXrqcc7U+S/o0Hw544KPIR/cx0yx/Y/Nf+k0HUq4epKwZrkiCzUY5J4v3NHF0T+TI3uDxdjOSZYQX6kzxf7oO+IQI2+RRMGTmEZ8UK8ASpkVZgXJjhmZ/oMy0WedNDGaUCVwLc3u8HV+5IMDovpVdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=YMFvrEGm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=YMFvrEGm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV66z6qXrz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:11:23 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-8423f52af13so1536652b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395082; x=1780999882; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1Kna2jMMM5bJ6rAGniT5H8QaKGxjLzFWpw04bCbO68=;
        b=YMFvrEGmvUedKK+urZ8Z0o7rrjV4y7XtnhHhhOYrRaKxhEJwec4pM8JmYi2JvBwSC9
         fqPBRkK4RWEQt6G/Z/nDZwpDPJpmti3XILHDOKNU2YCqVZzOWweFaBG6u0pyJX/8gjoF
         QBVh4jY8p+XWeBMX/+3UdwBVcfo4KgFTsSj4Zr+HlvQtE/AnVJGGCBegtpHfHJxhG93+
         z12njU4xnaAh1p3b8b+kroq2yk61OFLUxAsI5ljj0pw38PX81MRxIhWoicAauK5t5P9P
         IkEK0TBWJWahCZFmAmm506meOvjdUGjTxifFeBn/wQ3M19hnkse5whCqPg17KmohVpM5
         iUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395082; x=1780999882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m1Kna2jMMM5bJ6rAGniT5H8QaKGxjLzFWpw04bCbO68=;
        b=XBw7p4GJ+r64W9C6EXOvUlSilzSg8mZ6b0EP1RdxpBq/TagdfkltZFl5BXVlFuxJt2
         gv22EIBCDkoDmk3WT8/6oN9zHck9uX4kr78JXx1YUukpxm9KxFeRnaUHW6ovT6b4Dp7v
         3eFq+g5suZlf1wsUDShtX+nR+yp5txQJqBS4SzPul3iNG/pQMKQ5EAhI9DudFd8GG01r
         +2hkm95i/SZSsoZpTCRsAqvFm5HtesNurT+bUQk3jDoSYblUHkUVZpGgBoY8B6/ubWen
         qVWANLujOrJbX6tqM6U9I/zCEq5jjzBPUP6/+yv3i5jEJRaRb+rcXk3XLTFdw6+WmHFw
         KMWA==
X-Forwarded-Encrypted: i=1; AFNElJ9HPdf9LRG0tIOxLJ/GDhH5gP0fjD2bqi+YSdWNcpmX7qOGHYqo6gQXW5lFZQtm4T0i6LRbqe6d63cDjYU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyvjYaZGJ4HgyJeQr/7vNEfegG0YKIiTuXkzzkiuCyzhEYlQmGZ
	zWRr15Qgu5+4Vsn419ovilrfq/R7jLN6afzb9qtVEPGWrCJ5lJejLmr8uAfECZq33iI=
X-Gm-Gg: Acq92OEuwXcUkASGGVkFawHSDc6JiYlQ6vlfxBilJqf94nrVN/cSPAQJ0UY/v4HrvWl
	wKvb7D8M1cXeMi8RDI/EjxhJ6RLJJw5aj03LGqyctGvM/YLnT9YSwPBGIPrWmtYRV+39RbwUzTJ
	MkE1v59gqWiFr34Cd+L1XWC1CjBxAOMbGwGIL5dBBU1lHuCsbvP09go+fdfWMzOw50qw3vkvBK/
	Vvovb8UnX3gN+7WJ9Ff4W6JJi+PTnuZBjwYDEU8IXbAyVgwJE5LXl2W951bbkRT1G+CbTIHclPJ
	ksaeXAPr9z9xMD9LbK5lU1muc1BhnCPkL4p075lxqwfvCBEGAqLtBo0g3+T7/m+JwaypkSSfE9w
	MHOkgrzrVdhfao5PQ/yoyXt3BD0MaeAaoOH4VGQ1n68En6spTCByL2BM9MxheDQTRI0ZZ5isC0s
	yEG9DihdYfKbk8TFB0Hu7TZAoCOiJnyk3zW62dv3+q9KoTRFjHYcAlo8c=
X-Received: by 2002:a05:6a00:4087:b0:842:708f:39a0 with SMTP id d2e1a72fcca58-842708f49cemr2632750b3a.8.1780395081825;
        Tue, 02 Jun 2026 03:11:21 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:11:21 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 06/19] mm/sparse: Panic on memmap and usemap allocation failure
Date: Tue,  2 Jun 2026 18:10:26 +0800
Message-ID: <20260602101039.1867613-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602101039.1867613-1-songmuchun@bytedance.com>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
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

When vmemmap or usemap allocation fails, sparse_init_nid() currently
marks the section non-present and continues. Later boot-time code can
still walk PFNs in that section without checking for this partial setup,
which leads to invalid accesses. subsection_map_init() can also touch an
unallocated usemap.

Auditing and fixing all early PFN walkers for this case is not worth the
complexity. These allocation failures are expected to be fatal anyway,
and other memory models already treat them that way.

Make memmap and usemap allocation failures panic immediately instead of
trying to recover and crashing later in less obvious ways. This is also
consistent with how other memory model configurations handle memmap
allocation failures.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
v2->v3:
- collect Acked-by from Oscar Salvador
---
 mm/sparse.c | 44 +++++++++-----------------------------------
 1 file changed, 9 insertions(+), 35 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 16ac6df3c89f..c92bbc3f3aa3 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -239,15 +239,8 @@ struct page __init *__populate_section_memmap(unsigned long pfn,
 		struct dev_pagemap *pgmap)
 {
 	unsigned long size = section_map_size();
-	struct page *map;
-	phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
 
-	map = memmap_alloc(size, size, addr, nid, false);
-	if (!map)
-		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%pa\n",
-		      __func__, size, PAGE_SIZE, nid, &addr);
-
-	return map;
+	return memmap_alloc(size, size, __pa(MAX_DMA_ADDRESS), nid, false);
 }
 #endif /* !CONFIG_SPARSEMEM_VMEMMAP */
 
@@ -300,17 +293,14 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 				   unsigned long map_count)
 {
 	unsigned long pnum;
-	struct page *map;
-	struct mem_section *ms;
 
-	if (sparse_usage_init(nid, map_count)) {
-		pr_err("%s: node[%d] usemap allocation failed", __func__, nid);
-		goto failed;
-	}
+	if (sparse_usage_init(nid, map_count))
+		panic("Failed to allocate usemap for node %d\n", nid);
 
 	sparse_vmemmap_init_nid_early(nid);
 
 	for_each_present_section_nr(pnum_begin, pnum) {
+		struct mem_section *ms;
 		unsigned long pfn = section_nr_to_pfn(pnum);
 
 		if (pnum >= pnum_end)
@@ -318,34 +308,18 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 
 		ms = __nr_to_section(pnum);
 		if (!preinited_vmemmap_section(ms)) {
+			struct page *map;
+
 			map = __populate_section_memmap(pfn, PAGES_PER_SECTION,
-					nid, NULL, NULL);
-			if (!map) {
-				pr_err("%s: node[%d] memory map backing failed. Some memory will not be available.",
-				       __func__, nid);
-				pnum_begin = pnum;
-				sparse_usage_fini();
-				goto failed;
-			}
+							nid, NULL, NULL);
+			if (!map)
+				panic("Failed to allocate memmap for section %lu\n", pnum);
 			memmap_boot_pages_add(DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
 							   PAGE_SIZE));
 			sparse_init_early_section(nid, map, pnum, 0);
 		}
 	}
 	sparse_usage_fini();
-	return;
-failed:
-	/*
-	 * We failed to allocate, mark all the following pnums as not present,
-	 * except the ones already initialized earlier.
-	 */
-	for_each_present_section_nr(pnum_begin, pnum) {
-		if (pnum >= pnum_end)
-			break;
-		ms = __nr_to_section(pnum);
-		if (!preinited_vmemmap_section(ms))
-			ms->section_mem_map = 0;
-	}
 }
 
 /*
-- 
2.54.0


