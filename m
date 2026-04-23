Return-Path: <linuxppc-dev+bounces-19997-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A18F99342
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 07:20:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1SCV0GFGz2y8F;
	Thu, 23 Apr 2026 17:19:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776928789;
	cv=none; b=kqSeQCkzBLWbb9lriUDAjSV0C/xek2Qdh7zplVnpIoD8JM9jW1aqrhDWs8IuomgtBgWxQzawcaKarcegCOGlBISn6mDC0BSwPlTUNYwKilrWtJOk0azMs1GNnof6GxaXEtLUEMwpn1JWtTreRXurcb/S7QqHaiyb54nrL23Lrq2c5R/Ao0HlEUxMptia6mkGIpvvuVwVK6HUCcvKHAtQHI7WjGOTUKcia3aJik8eKcWDV4Tr4ODW83wuXdjp1dTeJXzYzWxGqzzlsl89ZFsTKv3swaXi+8NpCWLt4XKdp2VOChusLvtcAwPKuCvyx0sPdCVoGszGAHF/UHDQgqSm2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776928789; c=relaxed/relaxed;
	bh=0E6l7+8OUQ4Tga+WuEBz2tFLFSj0y7aaAPGsd1rn1yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dcjpYvIO6LD6CSg9r8KMEaijI8fJG3+M66d9GRprBXLe5zJ4YUCRqiRwsMJ/iEDNxO5+tkVyQLGSSOjwC7pg7wSMPknmyOFOW4Hhbx0JzDFDLJ88Gfk/mBS68DoXtxuBRipDU/zZVoUjAHgzsbnoFGmhEPtEWLpod2XgM8txf6THCceGiKRGqKQvM4LC89jkLYw+OrFnVZFfYuDo5L0fkoLWGiYBU4iDoCB/+O/BBDVloMVhSY9QbJS9kuV/3zMimK/XJc5qM3S0w/R7j6N9k9cFmdaczlo3/1FNrnTpkQp2JC+9Av13p/bMbvPhBg725/kGPLOIBMSqx8ATGR2LzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=e9vkK1Ez; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=e9vkK1Ez;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1SCT1vjPz2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 17:19:49 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-35fb166b0c6so3681152a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 00:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776928787; x=1777533587; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0E6l7+8OUQ4Tga+WuEBz2tFLFSj0y7aaAPGsd1rn1yk=;
        b=e9vkK1EzlpFBB6p6HCuIi7ByPAphZzhLnrdDB8u4OnFBkomS+/4DW+zuAErfTofG1X
         hRCRisqOKnk7LvfWs9yivBwejLqTYKmnIbTJg0P9st4wORDUtVkTcMZsJ8b2W+jpWP2V
         lf0C2WiXf2gzKYtST3F7ZXCNCl3I+Vsw8XLGRSASEWuKupP2r9YZT6GklaTgj3pw+SHS
         G1YvPEZgNcJn5nwJ4LeqjNq4DGOBhKhAbZy3K87p77thxDiA57AccNLn19u8qBaucTlo
         OsRL7RLLQBm3HVXNmDAyzgdKjeU4UfevX4qVS8BaaYsZ8Soxt66Zgm8dKkXxAiv3h+SB
         dcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776928787; x=1777533587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0E6l7+8OUQ4Tga+WuEBz2tFLFSj0y7aaAPGsd1rn1yk=;
        b=HCep4wagGK8VHeZiRnQcljzURAfW2StECigL2tXlgT8e2/lzNXKHDiweU///py5wcY
         oy5zau9DbQnEfXcJ7dRQM2SDnEPHfRU2CddaFjG852F1oMrUpyIjlWYIP2h9srvitF1H
         pIuEy9GC5dRgEQ54qKawsuYL/hYrdASOYmNcnN3a+ss8gmKB9J3nCvMFRGooHWK9LiVw
         puSnmmj2URJJ35WPfTZ+dqTjHLg7vCs5azxdfIDVlF4Z5WsAlAxdZPai9slj3cJ6MivE
         N9h7aBXvhDdWfxY7ZrtBcdqgKl9ipaCVq1y1O3UXZbJ0pmafybm54pIV/pBKCI+RPGvy
         AjUw==
X-Forwarded-Encrypted: i=1; AFNElJ9TdBn8WwEU7wI4Gy2HR9h9cHbzsERMCYKN0IH7Bdpa9jK5MCidVPrvuMW/ODB6eotwG5ma0h5zeuXCwBA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxeFtHPRBGaqqdSa33nwiknGAplmrCxh3Iow82Zca7O0xnUd9nM
	XM1dd3Hl3/cypR5vJ66lFX1QPAvf0y4egg4LKJDrJBJnDI0mFEKlUT9soM0NgsoIM4M=
X-Gm-Gg: AeBDieu9L7ehfvR8t1IGjoQ1FOyvaA5Cv+SSajY6ffT5ItsCpXOMIJ4wi3ZmjexCesf
	ZqqZiPi2LRAwM0HKvh+v/fqBnFikf8XtBWw0QwX0ulp/GEZuX+cB7TIM8fnRpNGjhOKrZi1Yi98
	UqzHNaI7bu3agusHUun63THZJKOB2Y2Xv2HiL9x9QgWas67m8r2d3tHuBbdCWS4Iv6aNLuYZP8q
	SUt/zeILl5O06NXFfH+MZ12taZNjLdbpRiR8drU/fwbi0IdvH8CroAarR/JBAzobC8gXAhdkWim
	cun54JASqNiNMDHJfDeKhUSfBpMd7Wl0mMy3GiBqZ3bfWaqO/n6X9GwFn/dLJqNlHK4PBv9EeXX
	ZjXcbfUIUeIKDqprIz2t62FsyWjiSV3EgqAmk14lsBJPF/l322UIAxFrq7Y/xX4QvlmMq5ah2/C
	J999QOmCRH9O3QhpP6UL1vfRlEchfBBl8eJfBY4O8k834voKJMLP1RZg==
X-Received: by 2002:a17:90b:3ec5:b0:35f:b4c1:91ea with SMTP id 98e67ed59e1d1-361402ee818mr20270410a91.13.1776928787371;
        Thu, 23 Apr 2026 00:19:47 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fbd970fsm7092372a91.14.2026.04.23.00.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 00:19:46 -0700 (PDT)
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
Subject: [PATCH v5 v5 5/6] mm/mm_init: Fix pageblock migratetype for ZONE_DEVICE compound pages
Date: Thu, 23 Apr 2026 15:19:10 +0800
Message-Id: <20260423071911.1962859-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260423071911.1962859-1-songmuchun@bytedance.com>
References: <20260423071911.1962859-1-songmuchun@bytedance.com>
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

The memmap_init_zone_device() function only initializes the migratetype
of the first pageblock of a compound page. If the compound page size
exceeds pageblock_nr_pages (e.g., 1GB hugepages with 2MB pageblocks),
subsequent pageblocks in the compound page remain uninitialized.

Move the migratetype initialization out of __init_zone_device_page()
and into a separate pageblock_migratetype_init_range() function. This
iterates over the entire PFN range of the memory, ensuring that all
pageblocks are correctly initialized.

Also remove the stale confusing comment about MEMINIT_HOTPLUG above
the migratetype setting since it is an obsolete relic from commit
966cf44f637e ("mm: defer ZONE_DEVICE page initialization to the point
where we init pgmap") and no longer makes sense here.

Fixes: c4386bd8ee3a ("mm/memremap: add ZONE_DEVICE support for compound pages")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/mm_init.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..cfc76953e249 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -674,6 +674,20 @@ static inline void fixup_hashdist(void)
 static inline void fixup_hashdist(void) {}
 #endif /* CONFIG_NUMA */
 
+#ifdef CONFIG_ZONE_DEVICE
+static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
+		unsigned long nr_pages, int migratetype)
+{
+	const unsigned long end = pfn + nr_pages;
+
+	for (pfn = pageblock_align(pfn); pfn < end; pfn += pageblock_nr_pages) {
+		init_pageblock_migratetype(pfn_to_page(pfn), migratetype, false);
+		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
+			cond_resched();
+	}
+}
+#endif
+
 /*
  * Initialize a reserved page unconditionally, finding its zone first.
  */
@@ -1011,21 +1025,6 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	page_folio(page)->pgmap = pgmap;
 	page->zone_device_data = NULL;
 
-	/*
-	 * Mark the block movable so that blocks are reserved for
-	 * movable at startup. This will force kernel allocations
-	 * to reserve their blocks rather than leaking throughout
-	 * the address space during boot when many long-lived
-	 * kernel allocations are made.
-	 *
-	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
-	 * because this is done early in section_activate()
-	 */
-	if (pageblock_aligned(pfn)) {
-		init_pageblock_migratetype(page, MIGRATE_MOVABLE, false);
-		cond_resched();
-	}
-
 	/*
 	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
 	 * directly to the driver page allocator which will set the page count
@@ -1122,6 +1121,9 @@ void __ref memmap_init_zone_device(struct zone *zone,
 
 		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
 
+		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
+			cond_resched();
+
 		if (pfns_per_compound == 1)
 			continue;
 
@@ -1129,6 +1131,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				     compound_nr_pages(altmap, pgmap));
 	}
 
+	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
+
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
 		nr_pages, jiffies_to_msecs(jiffies - start));
 }
-- 
2.20.1


