Return-Path: <linuxppc-dev+bounces-20915-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB5BCD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:23:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvKJ3Hqtz3cQM;
	Wed, 13 May 2026 23:23:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678580;
	cv=none; b=jFtPuKmtWlb5MT42mhlSFZc+sFKtxNjUm2bbXfGZ6vCeZOZbojEQYa2NAQqfsXJtOAJMjv0gc4h6sBdldW9H6SvAfj+8TqVXSM9q/4IBEK2g+7WoCRRrXybiigH9y9rkTyW+RrehvRsbvv3jmMGdPLPvqtkSF6RFL25/uo9NiNV1fpmMTzIL3IAvDi7YZPz6fuM7AWnSmSpCdWCwv4FEaxH1iAd0EA3gIFtxXLTYle+9hLerjZ0NLzt/oxPKp8O4O/VLp4th3kNNRu+jzGetqPvopwRchApWofahBVGTExQiA5pic9xRhEyMHJQx2Hu08Qg0e0KOdnAgXkOLnrtfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678580; c=relaxed/relaxed;
	bh=PZ/NHdOll26b6UfKrMWj7vaap4nNj6N/arSyoQPAGBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6OvdPbrYFdJvb2ukKpvRToq7BCJV+vyRSzqOotj2XJimVzBaPkQ3Y1/VS3kBQrV2M7x6IXNefVBPmedKKMOaxwzv8bCVLyVNO8ZamgNzAvypzInkqCHCKjKRhFAktALJJnhyQhs2Y0UI/tE3p8snEXYTVl8qXpTtIZhg1OZ7A4fLcaOuxSFjAemfs9ZCBZoB/i9NJa0ZV1RGFRQl9rgDQckLiXX9MJbuy7pA6ir0QVxRHeH77rGTwK0r3t6Tn589qQnnfiujCMTjFKM2iYXez5PUb7V7xtQOIrDYwRi4l+KVFoQoKIOcEyTXu09AFPPJwgPDUu9bN88HISOr4RgiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=IFXPdCka; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=IFXPdCka;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvKH3HM2z2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:22:59 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-365eecc5885so6669572a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678578; x=1779283378; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZ/NHdOll26b6UfKrMWj7vaap4nNj6N/arSyoQPAGBw=;
        b=IFXPdCkaaIInP1LJx/4hcwDakVPVdRyPCIQkT4wD0AlnCswOYHMirEV9cv66hWLtpy
         pJn/2gM5eFqgFAO0twYWq9+JgZraosY+Bxh3RVueDbN2oJg4I5xCT+TWvlO0f7cuEzSj
         Spd1pyWSLhl/9E5z7mX0Yt4a0b74QNrkqEEZjKwFAb0P9HMMAMeFGQwzcplxlprrH1Aq
         5UwzN4vGz1h75tZGKSdPjDuGMAbqzXZsb/OGFO8TLk2Vb2nxm9/Do9Z4kiyyK7gQNLCP
         GikXWKXusT16FS2B55TQSlVXucYme6sGjmX4UQCJGSiuSOanJPo/uaEZZP57+Mlt5mnM
         fdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678578; x=1779283378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PZ/NHdOll26b6UfKrMWj7vaap4nNj6N/arSyoQPAGBw=;
        b=gpgARH83dE0slXhiwQ1Q1qTIjtGtsEvpmGCXlLpwce8bmwN5bAUVyHQUuVc0IP5W+5
         W73gzx8m/imvyMq5vRT/iXelq3JAjrhIyozoZrr5V9T4UEQY5XstLbaxsZIbhafNY0rn
         /LTuZd4wyTXgiHQA/afGH4FSFC+hbTqICgBa49+wgCfMY5tmH4Hj5vhHGbjHahJ7M/xK
         2mzUjD2nlqPnzqmuFwu7SW6/XwkdIU/YzURGy2Md2/yDz9woBeajhMbKZ6KAUG/v+kPK
         CqeO52BwyUDiSCLqZUffrm91aTtth0ANAEmELH6lDqJ4cOA6NyIauqUpqEsYOio7XGiI
         Bs4A==
X-Forwarded-Encrypted: i=1; AFNElJ8oDaAc4yZVyB4sMLdpYQ6dh2gH3rZD3aM06RuN+iIrLLwZ99TJXxKN49nFpzFWAPY8ITVxPc4UUQOO4TI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxNM2rrCrMbCA3nncwBLPuVxqoiDZnw9zsz0u6PafjLj2ENAhIK
	Cno4ppfQc/MbIDkcFsFeNLMNnwuWqWjjry4eNDlonXrenrB4PxnZ3PlR3EKVuZJ/97c=
X-Gm-Gg: Acq92OFa3sO4HDlYAh/RtvlbomzKmkgIGoKndyb9YXg99V558Ql8BqkJIs9XIgcQTpB
	nOBB7i55JWwXF5tWvOTAAui3DOfmNlT7niLkSxLVahUBKuWsl0paTFppIw/E+GrKYnognlD674e
	4l19R5yfWPwbYAqbFra/y0deOClsnd27cTMBCZISx/Ls13R9OdNTOs/5dmk4n3RLaigRoRQHIhK
	kWxuY4DnG76YmfgPXqfB+jUry4SMTmwfPvCSKLxky6mdVsNWX08EMtMcLHxE9tPu7BgTZgFUE52
	dzwzyb/kMPVitFrSiGcQxuDinFCkHSNbUY9Atzsy/ZaLtZ/2zUX1U+Ed7/mPMCDUFHpFMrANLyt
	d2WZUVK9Q13svbNFg4sJ0D1dAtjikcSVgg/R3jlMusXIe4a6+LcFGnw0+MOEQYyyaIM92wcUpI/
	n6OTSQhcly69ZldhqxxZM3XJEBPeUFztVookEcAcXAnE2yivndn/gy1160/jB8
X-Received: by 2002:a17:90a:dfc4:b0:366:5c38:fd61 with SMTP id 98e67ed59e1d1-368f3ac4a7fmr3960604a91.12.1778678577410;
        Wed, 13 May 2026 06:22:57 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.22.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:22:56 -0700 (PDT)
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
Subject: [PATCH v2 66/69] mm/cma: Move CMA pageblock initialization into cma_activate_area()
Date: Wed, 13 May 2026 21:20:31 +0800
Message-ID: <20260513132044.41690-20-songmuchun@bytedance.com>
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

Move CMA pageblock initialization for early-reserved pages into
cma_activate_area() so CMA pageblock setup is handled in one place.

This keeps init_cma_pageblock() in the CMA core instead of pushing
special handling for early CMA allocations into its callers.

As a side effect, this also fixes the zone->cma_pages accounting race for
early-reserved HugeTLB CMA pages. The accounting is no longer updated from
parallel hugetlb_struct_page_init() workers and is instead performed
serially from cma_activate_area().

Fixes: d2d786714080 ("mm/hugetlb: enable bootmem allocation from CMA areas")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/cma.c     | 7 +++++--
 mm/hugetlb.c | 8 +++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 0369f04c7ba5..c1896c0db63d 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -162,6 +162,10 @@ static void __init cma_activate_area(struct cma *cma)
 			count = early_pfn[r] - cmr->base_pfn;
 			bitmap_count = cma_bitmap_pages_to_bits(cma, count);
 			bitmap_set(cmr->bitmap, 0, bitmap_count);
+
+			for (pfn = cmr->base_pfn; pfn < early_pfn[r];
+			     pfn += pageblock_nr_pages)
+				init_cma_pageblock(pfn_to_page(pfn));
 		}
 
 		WARN_ON_ONCE(!pfn_valid(cmr->base_pfn));
@@ -1098,8 +1102,7 @@ bool cma_intersects(struct cma *cma, unsigned long start, unsigned long end)
  *
  * The caller is responsible for initializing the page structures
  * in the area properly, since this just points to memblock-allocated
- * memory. The caller should subsequently use init_cma_pageblock to
- * set the migrate type and CMA stats  the pageblocks that were reserved.
+ * memory.
  *
  * If the CMA area fails to activate later, memory obtained through
  * this interface is not handed to the page allocator, this is
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7e9f49882395..df798f9386d6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3136,9 +3136,7 @@ static void __init hugetlb_bootmem_init_migratetype(struct folio *folio,
 	WARN_ON_ONCE(!pageblock_aligned(folio_pfn(folio)));
 
 	for (i = 0; i < nr_pages; i += pageblock_nr_pages) {
-		if (folio_test_hugetlb_cma(folio))
-			init_cma_pageblock(folio_page(folio, i));
-		else
+		if (!folio_test_hugetlb_cma(folio))
 			init_pageblock_migratetype(folio_page(folio, i),
 					  MIGRATE_MOVABLE, false);
 	}
@@ -3206,8 +3204,8 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 		 * in order to fix confusing memory reports from free(1) and
 		 * other side-effects, like CommitLimit going negative.
 		 *
-		 * For CMA pages, this is done in init_cma_pageblock
-		 * (via hugetlb_bootmem_init_migratetype), so skip it here.
+		 * For CMA pages, this is done in cma_activate_area(), so skip
+		 * it here.
 		 */
 		if (!folio_test_hugetlb_cma(folio))
 			adjust_managed_page_count(page, nr_pages);
-- 
2.54.0


