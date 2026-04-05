Return-Path: <linuxppc-dev+bounces-19372-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320F7EEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:58:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXZ919DLz300F;
	Sun, 05 Apr 2026 22:58:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393889;
	cv=none; b=LY0a2l1KXadz6Yxk/q5ZKV7dPNFfxTFRS4LtKX5c6hs+URga9z/4ZprHmkgyBsEUV8faNnkl/ikhUK3SMSHuMQu8Bdc8FrCQHPZRrMUS+/HlZTtc6rGQ0iSCVlVbD9zsoBBLfqe+NONVNxbchFzOU0/jvxslq/DrtUkYCWZRS9+GBVyNJQixPyiAM+uRfyRcevLltwZyW2MNR/yzGTZT2nJ5nmc2XH64lj8ajnXQnAgM9xMsPnnygx/NA4jx+hjxEyf0T/zMPcpAy3tnqZLeTYOUxAv1v5jJSTI9U5Bk7MnxWOh6TRZtOcl7YIIqDgvYotYqlgNiwxS5CUzlhtQgsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393889; c=relaxed/relaxed;
	bh=KkFZynHuznCOlBtjfU13B+G62bbJJ2w/QApOyapvamc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UA+oiFAa30cd1tmqxt9tlwvNq/RYaZau+hCveBknVeLjcUI4J4GtaSWAG8Nv7ISWPWhSV6WDGC3uv54twSwTpPYQ3BHutfjIhRMFNkfEwyQt6qJhbwBwY+vYHk8l/FiE50VYIcpWCCttB2hSbzk2DGKcqj4QF2N0pQair0HbbAlYbPJPKEIFR/ojDRCOo2B0F03v+CgLqixbJK688QRh1+M1xcCqCBnRShivTSGR/Rj/Gw5OCN3B+BGsBkQn4IGYdXXx6cgazVcJwBX4VY2vOp9nRRUztlCrSmD7qWxcuz2FwtUCjBMmyIzIRMmcPVWm1VpGvNEXcnTYkChjimUz2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=AJI2KW/L; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=AJI2KW/L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXZ82ZCKz2ypV
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:58:08 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-35d9c7bf9a1so2805834a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393886; x=1775998686; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkFZynHuznCOlBtjfU13B+G62bbJJ2w/QApOyapvamc=;
        b=AJI2KW/LWDN5jIavZh8mPVBm88mQ+SluYKtV++9n9a+12hO70fS0wc9qrluSqip2xO
         n29mt8txA0oDMhDprU1yQIGRh/XSjKfjihzhOKtXqIUf9dTYQ6xlgq/9okZ9aVt6ITL3
         N2z6iK2T18fbKHepq71KcvdCjgNdN1pKAq+BeW4kCLlsg+Zw8FNdC2a0EAH869giAPQe
         r2WLajEfZqJMGBUZ4P6R1TaRbUm53MOGWdnWFh7r78hF1XgrNIlykglpF6m6t86HBo9O
         u5O4CDlBy5gA7LG5J2wbOmnlAfSWCWBV2bqAxgwulurdHGZeIz9K2mmiW0UevGLdlFij
         f3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393886; x=1775998686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KkFZynHuznCOlBtjfU13B+G62bbJJ2w/QApOyapvamc=;
        b=HtjR4Oiq/u4v256+eaaCP3Eyx6+ft4ngPSsedYHjdiSUYj+kX76bwobI+awwvYLuBs
         Qj9H7QgpTBPrLoG3ME5dTccR/Bn6orUREmhKvm7DUPf1MkueBPIwjL33g1IpZ1TCHLTR
         51XztnrH8TNRSd8WRUOa6HZlPw+Dc34BmKnJoFD0x3zojToYQObLGG6ubYMyN9FioPl3
         QsjBE57Iv4PlO1OWDOkoMbbQQJjKmTpGIjs9LhBp9K788voNAaL2uzqWVulMoKPl1x2+
         zCV6NcZmoAwPOubUeM+bizYNlt64nVg7xhp3Vxq/+XUW3mxfuBecS4kSxi0H3t7OupB0
         BLaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbwNe+6RaBCqaz6WtTAN3ektckdswM1UUVEjFoERfc71oEcVLAkL5xlj2CygNzgjSCirg2h+ITz3UBV4w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzwTA70l5lrJUd/YdwcTm5BaEslUXeyy7q1oTVv/Ioj5ZzcSndm
	IvaENme05Kkx7K1AzZ1VOlLQzoOAWAAizi4OfKN50gjtE7FozSH+MIchjhIVUBiBnww=
X-Gm-Gg: AeBDievNBXYubYvIOngwuXrwweWXnjHLmmQr78yc18M5af/85J55LrkzqNcXgfC7oQQ
	RHTNS6yJH989Hk/rj9qNawJiP8lzhqBCf9DDdU3i2SXSLJXJVxHStdra9ayvdwd76UiiyH2/+Rx
	PonEPtZrzH5AOGH+wxCDJSNanvPXugyL67mRz03OoZZZ9wN7+BOeuojXe/xmx7gQnnOpdc3xuS8
	RDyu4tvEVnrdh+7iQ2yMJykG0ceIl0nTp13sKU70pyqN7Smy/HvBTZ2hsPn4lKaHon+i7ISwfM1
	A6uUG/fBnWdU0LuBSXuBHyQbk1UlnAM9AHn9tN73ENnnyz8hoz5Dc8EwGbz+17rRQxNQehVoQKZ
	/OU+EH4FAXPm3J7Fatv0998/NVa2L8l2S5cTLHIsbm7ATz1q+7Zgox6pTHVCcYq13mk4A6QKcDN
	yvGOdAD/OAcHn+Tm5ITQXW75NY3TijvXkDPz9QbGchMss=
X-Received: by 2002:a17:90a:d403:b0:359:3426:c60a with SMTP id 98e67ed59e1d1-35de67da841mr8355420a91.4.1775393886516;
        Sun, 05 Apr 2026 05:58:06 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:58:06 -0700 (PDT)
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
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 42/49] mm/sparse-vmemmap: introduce section_vmemmap_page_structs()
Date: Sun,  5 Apr 2026 20:52:33 +0800
Message-Id: <20260405125240.2558577-43-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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

The function compound_nr_pages() in mm_init.c was introduced to determine
how many unique struct pages need to be initialized when vmemmap optimization
is enabled. However, it exposes sparse_vmemmap internals to mm_init.c.

Now that DAX and HugeTLB vmemmap optimizations are unified and simplified,
we can expose a cleaner API from sparse.c to calculate the exact number
of struct page structures needed.

Introduce section_vmemmap_page_structs() which returns the number of
page structs that require initialization, rather than the number of physical
vmemmap pages to allocate. This perfectly aligns with the requirements
of memmap_init_zone_device().

As a result:
1. compound_nr_pages() is removed entirely.
2. The internal section_vmemmap_pages() in sparse.c is rewritten as
   a simple wrapper that calculates the number of physical pages based
   on section_vmemmap_page_structs().
3. A restrictive VM_BUG_ON spanning sections is removed, safely allowing
   compound pages (like 1G DAX pages) to cross section boundaries during
   device memory initialization.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/internal.h |  8 +++++++-
 mm/mm_init.c  | 21 +--------------------
 mm/sparse.c   |  9 ++++-----
 3 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 7f0731e5c84f..02064f21bfe1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -998,7 +998,13 @@ static inline void __section_mark_present(struct mem_section *ms,
 	ms->section_mem_map |= SECTION_MARKED_PRESENT;
 }
 
-int section_vmemmap_pages(unsigned long pfn, unsigned long nr_pages);
+int section_vmemmap_page_structs(unsigned long pfn, unsigned long nr_pages);
+
+static inline int section_vmemmap_pages(unsigned long pfn, unsigned long nr_pages)
+{
+	return DIV_ROUND_UP(section_vmemmap_page_structs(pfn, nr_pages) *
+			    sizeof(struct page), PAGE_SIZE);
+}
 #else
 static inline void memblocks_present(void) {}
 static inline void sparse_init(void) {}
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 6b23b5f02544..74ccc556bf6e 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1060,24 +1060,6 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	}
 }
 
-/*
- * With compound page geometry and when struct pages are stored in ram most
- * tail pages are reused. Consequently, the amount of unique struct pages to
- * initialize is a lot smaller that the total amount of struct pages being
- * mapped. This is a paired / mild layering violation with explicit knowledge
- * of how the sparse_vmemmap internals handle compound pages in the lack
- * of an altmap.
- */
-static inline unsigned long compound_nr_pages(struct vmem_altmap *altmap,
-					      struct dev_pagemap *pgmap,
-					      const struct mem_section *ms)
-{
-	if (!section_vmemmap_optimizable(ms))
-		return pgmap_vmemmap_nr(pgmap);
-
-	return VMEMMAP_RESERVE_NR * (PAGE_SIZE / sizeof(struct page));
-}
-
 static void __ref memmap_init_compound(struct page *head,
 				       unsigned long head_pfn,
 				       unsigned long zone_idx, int nid,
@@ -1141,8 +1123,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(altmap, pgmap,
-						       __pfn_to_section(pfn)));
+				     section_vmemmap_page_structs(pfn, pfns_per_compound));
 	}
 
 	/*
diff --git a/mm/sparse.c b/mm/sparse.c
index 163bb17bba96..400542302ad4 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -345,23 +345,22 @@ static void __init sparse_usage_fini(void)
 	sparse_usagebuf = sparse_usagebuf_end = NULL;
 }
 
-int __meminit section_vmemmap_pages(unsigned long pfn, unsigned long nr_pages)
+int __meminit section_vmemmap_page_structs(unsigned long pfn, unsigned long nr_pages)
 {
 	const struct mem_section *ms = __pfn_to_section(pfn);
 	unsigned int order = section_order(ms);
 	unsigned long pages_per_compound = 1L << order;
 
 	VM_BUG_ON(!IS_ALIGNED(pfn | nr_pages, min(pages_per_compound, PAGES_PER_SECTION)));
-	VM_BUG_ON(pfn_to_section_nr(pfn) != pfn_to_section_nr(pfn + nr_pages - 1));
 
 	if (!section_vmemmap_optimizable(ms))
-		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
+		return nr_pages;
 
 	if (order < PFN_SECTION_SHIFT)
-		return OPTIMIZED_FOLIO_VMEMMAP_PAGES * nr_pages / pages_per_compound;
+		return OPTIMIZED_FOLIO_VMEMMAP_PAGE_STRUCTS * nr_pages / pages_per_compound;
 
 	if (IS_ALIGNED(pfn, pages_per_compound))
-		return OPTIMIZED_FOLIO_VMEMMAP_PAGES;
+		return OPTIMIZED_FOLIO_VMEMMAP_PAGE_STRUCTS;
 
 	return 0;
 }
-- 
2.20.1


