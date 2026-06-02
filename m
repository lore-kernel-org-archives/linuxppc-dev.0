Return-Path: <linuxppc-dev+bounces-21880-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1374CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:11:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV66t1RnKz3bp7;
	Tue, 02 Jun 2026 20:11:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395078;
	cv=none; b=UymHj6TKB6s/kznyEW5dJmLzkMVTAyjK4SQPDMAS6+rYNyTXkwge6E+01KdSmGj/7v92oSP2ErrBrGRBWARcM2pxvPRYotnFm/8Aev9aGzk1B9EFISzk1kvPZEkSgB9YEAzZGhd4E7ZUZ/ZrS8tFK/bd2prFK2OcS1Gek5H3S1iJw4xq8oNkpTgrOeXGpXtU32EfGIZTdLUC5P0YWaQLbB1ZwHtVt28gE1NLvLT7PBzC8yvK+Q1zVbU3+jwwhonMh8pbIOtORPl+YSz4aabLCL6UxMahX13dHK3Xtx8DP3anF2g6RuOA+fyMQ/Lg9xfyqGK0JZqHX8l7YFBxwv4Lpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395078; c=relaxed/relaxed;
	bh=Btf8iCCXb7pZCMHTCvc15KHxJTAr77nR7rRKFiPgBRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifa3MjmOvIB1ROnhzF727kBvl2wkmGX6jzbfs/kiNqPhqG8tcbSvUsdlYREFOelvrj/v8iH2HKqpxGoMcauvihhHYp02T+1dRLoRU+k78yI821f5Nk+2oDXSA3vDWQkS+5Z3u5tEXDzGXh/qziGezDx7EE4kSvccMxqwEjC5N6BWPuqqH8mNyxKNTDBKX2S4//ny8kFpWJCq3iVrx0ouVNMVfRZrS58C+i+Qoco8ID730e32KJC7yOGuSlWAx5jYFnqKzkVxlVHDe4YEvb6VszX7NDOtu7gh1FHuvzTJodsr+BcJ817Os54c5DK4Hpt3aNvBoeBRUTqEXLlBRk/NAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=UOzzMhkm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=UOzzMhkm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV66s3mSwz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:11:17 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-842307473b5so1903141b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395076; x=1780999876; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Btf8iCCXb7pZCMHTCvc15KHxJTAr77nR7rRKFiPgBRM=;
        b=UOzzMhkmwUI8tWFU3C6Gz9rbN0fB+ibztdS1skOOzCOW6d4Iwwxjf0Bngrg9ufsTPx
         tZk+TGUQo7KtggizkChlPxsxnRidHZJtRlJ0TpAugVAejLPzFFQee51sMe9rhW4AT4ID
         plLiYIxGNLSDi6HGZ7L9OT9pYk1TMiW9OjsVzVKd8VPHAvDa4Dtfyddtd68LTlt/Wk74
         od+SGE9/o0s+0xeGfvcfrhpElOe0WAcBReH1KVDaOP7mFnjLts+ZJ6yHqnXUo7zpUVnd
         Z+S3l7kPwXj/jZwIk0hX1JPR6d9mFQsQ7DorIwKjG8e3jP7B6Vrza1RNj3ybdlyp6OF5
         P+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395076; x=1780999876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Btf8iCCXb7pZCMHTCvc15KHxJTAr77nR7rRKFiPgBRM=;
        b=QuEyeAWYuKy/Noa5wv9wy9fEeSh/j58DyF5pthYE42w4rJUlSIgIezGKN3vLiFDqQP
         8UZyRWUXlHJIeGfN2xnKpItQ4tp2upNIUuGghn0Zi27OK25IolFYKZodk67H9YkBPJ/M
         tJK/xeLKI5sXTMy0duMgwUROBQO/FptBXs9mJYy7GRkhil5sjsypInHbz0KQc+2ekBan
         nu7NzMPNRBrAOEF+WpKjZAFvMUwVukdRPKoFcr2HXJrxIK4CmzIn5MShiHK546k7jXvA
         /Lr1kkrNL10TlmipSoKEF1vb7L18LQU2fiF+uXYlpztm8lFR3kyIbsTV/cxpuMPTDE2X
         jUiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/RrR63zPNAlPx97vFAbquJ1RA9trFoi0EHgpQR/JPiVpFkfDuhbPod5hzd9AfyewCMNZhJL8n8F91paug=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwFRv7fAwLQy6XX9e2G6OhtzyUPBIG+W77aUEoLAYpGpKtNfmfc
	mcXIJrHKZ84oP4UAKWP5Z06hVhRFOJfTER2fzxk+1QZ2nBCEyIgvuP01uUae1B+7TmcjCYU+/rZ
	wfwjZP1U=
X-Gm-Gg: Acq92OEiPvs6htCFdeuz64flZNN+kSh8CIHAf9dp5wSDEBernToinKSRtT0tecIBKdp
	PPbEMchO/2qCGQGaaw3sQhoo/r1j3wJFrOk5UHYyNQSHo7W4bT0Xj8G0bFh9YKmQWhWCw/zFxXL
	N0jLCCmQzBof4L3dT4qTInaF5p4VCZ7xcQRwcATyn4qccnMPDZ1KDHx4eAdiIxQmF79TQXUhaUi
	sdaDEPcYqMgiPkDAI0Y5rMUPicu4Yl4rAFwXxyT+46V+hVj+v2dI7E/LBJcGVKTs8Mpub5cCQAR
	u71bndxxz+GMeqPpo+M0wSEWm+MDeI2sSGoiWLDb0jRvYZYyxs8pd8d7JxKmy0zt1Fsr9iqx1Gd
	zfANSfFG1T3yayHlIPzOtv8KiNkWaxNdVfStb8vaVo/Np4CUOUas1dJzYHQb0AL7pnTi2uf8Y8f
	paqH9gYh9364uqheNXISsnlC2rz+jiDYgL4YUF2mm67YVIvlT6zjd2YVQ=
X-Received: by 2002:a05:6a00:3e0f:b0:842:4f49:71bc with SMTP id d2e1a72fcca58-8424f4972femr8017729b3a.46.1780395075647;
        Tue, 02 Jun 2026 03:11:15 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:11:15 -0700 (PDT)
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
Subject: [PATCH v3 05/19] mm/mm_init: Simplify deferred_free_pages() migratetype init
Date: Tue,  2 Jun 2026 18:10:25 +0800
Message-ID: <20260602101039.1867613-6-songmuchun@bytedance.com>
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

deferred_free_pages() open-codes two loops to initialize the pageblock
migratetype for a range of pages.

Replace them with pageblock_migratetype_init_range() to remove the
duplication and make the code clearer (Note that deferred_free_pages()
may be called from atomic context).

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
v2->v3:
- collect Acked-by from Oscar Salvador
---
 mm/mm_init.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 1890bda948b8..be652b6990a2 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -674,15 +674,15 @@ static inline void fixup_hashdist(void)
 static inline void fixup_hashdist(void) {}
 #endif /* CONFIG_NUMA */
 
-#ifdef CONFIG_ZONE_DEVICE
+#if defined(CONFIG_ZONE_DEVICE) || defined(CONFIG_DEFERRED_STRUCT_PAGE_INIT)
 static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
-		unsigned long nr_pages, int migratetype)
+		unsigned long nr_pages, int migratetype, bool atomic)
 {
 	const unsigned long end = pfn + nr_pages;
 
 	for (pfn = pageblock_align(pfn); pfn < end; pfn += pageblock_nr_pages) {
 		init_pageblock_migratetype(pfn_to_page(pfn), migratetype, false);
-		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
+		if (!atomic && IS_ALIGNED(pfn, PAGES_PER_SECTION))
 			cond_resched();
 	}
 }
@@ -1142,7 +1142,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				     compound_nr_pages(pfn, altmap, pgmap));
 	}
 
-	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
+	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE, false);
 
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
 		nr_pages, jiffies_to_msecs(jiffies - start));
@@ -1996,12 +1996,12 @@ static void __init deferred_free_pages(unsigned long pfn,
 	if (!nr_pages)
 		return;
 
+	pageblock_migratetype_init_range(pfn, nr_pages, mt, true);
+
 	page = pfn_to_page(pfn);
 
 	/* Free a large naturally-aligned chunk if possible */
 	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
-		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
-			init_pageblock_migratetype(page + i, mt, false);
 		__free_pages_core(page, MAX_PAGE_ORDER, MEMINIT_EARLY);
 		return;
 	}
@@ -2009,11 +2009,8 @@ static void __init deferred_free_pages(unsigned long pfn,
 	/* Accept chunks smaller than MAX_PAGE_ORDER upfront */
 	accept_memory(PFN_PHYS(pfn), nr_pages * PAGE_SIZE);
 
-	for (i = 0; i < nr_pages; i++, page++, pfn++) {
-		if (pageblock_aligned(pfn))
-			init_pageblock_migratetype(page, mt, false);
-		__free_pages_core(page, 0, MEMINIT_EARLY);
-	}
+	for (i = 0; i < nr_pages; i++)
+		__free_pages_core(page + i, 0, MEMINIT_EARLY);
 }
 
 /* Completion tracking for deferred_init_memmap() threads */
-- 
2.54.0


