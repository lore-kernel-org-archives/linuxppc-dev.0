Return-Path: <linuxppc-dev+bounces-21894-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698BECD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:13:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV68S4Vssz3brV;
	Tue, 02 Jun 2026 20:12:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395160;
	cv=none; b=CFHpyhgV/9rkm7PcVEq/J0T4vXVj1VoBvgFC0inBaUjct7YjGUohamv1I7K1b3eh5GePdf6Ze5skE5OGNQEA/23j81rvPbQMMH+CEk8a9m+c+gcwlovo7tZ5LBlQa2DAbqvtZFF9grFtv4S3UkOpNHprHNXxcKrQOqAfbS8lB5DmuywNOqGVz/TR/FwexNN0PYHRXcfSUibkGLlDdg1vvQdXr7QWUocKJ0NMkQq5wNr4o4DvYf0PmwIssn6C95/e9nipWphAa5imNZ+Vq8Qe62jRnRdkpR+QgHyMCrSvMQPJgw/4pcciz0krecU+wNW9U3K03U8hGMwfoXWfRtT04A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395160; c=relaxed/relaxed;
	bh=J5Q2gGk4UZAL2GpP2RnQJwNvQrGN9WYj/IZDEx+Kuy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inJHV3KJI0kmmMaeWS7tpbZAeFG21UDJ8ZKOdQSBJRAEju196ufcIWMk/9lQA5dpsjBvEA67hfvOMvVA1DLk8CCAWTxgvAfb6LsGItJ6+OglVF6yDLLKZlUhz3sVl9q5G7Bw19YmkwTXxRzsebZiQgN7cYvwJn1n1IxZ5A7bCXRE5wdjDi7cwdJbinQl12BmndgIVyDyPQ6EnzP5bMTUP/11dS+fsaLaDCP9mulSgSlTztMPk8qFnJ4e95WqFLIlTIOfOYKlpgvDU7PioIC0qOVHm32BvPAcGwsfIS6mVDqSUdTvDAosBe8hurDfU/66ChtnRDk+y0UuBgVGyY1eIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PqX1uNak; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PqX1uNak;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV68S0Gt1z2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:12:39 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-842319576d5so1215807b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395158; x=1780999958; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5Q2gGk4UZAL2GpP2RnQJwNvQrGN9WYj/IZDEx+Kuy0=;
        b=PqX1uNakaxJklxPiHADlD7MNySAdFxCR6CKx0omYRd5wUG6jzggYmAkVQVFKONloRy
         wmrUjoxK5URuUAginoauyVGyVqgE0ID+x19NsgZzlhQ7maNHjg376vEQm22uoozTNfMe
         vC1gUwUJYb2hG9wvDoWIRlm/J09Ggo1s8nGLe0Zruq1DU+dsU6a3uk2nxybPtdOHBk6D
         9T0VMYLQd9n6hOHhbG0mzZHcZA3j2mMXnFHZP4wamSSMT795s3P0S1d7gcMaAQE6IQo8
         WcWlpUYkmGKS/i/25Qr067FtzZ8ZN1PJ7XMn4CtRVyqpVFYVbVF9Sr0kuAKvjjo9H5kq
         E7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395158; x=1780999958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J5Q2gGk4UZAL2GpP2RnQJwNvQrGN9WYj/IZDEx+Kuy0=;
        b=J2L3b4R0y4oDlmrUsgVJTTuJAJzJCDqCCwy/leV5CQrABKxVrGpTN0QZ9SAAJa1Ao9
         /xgI9DeXXPq9YMb7gFBGK0kzwF0PfNM/wxmXr90OAnpBZsTvnMbZCbPa5MVVM/8G/LPf
         4datty8Fh7ckNzlm7lmPMNjUwkzMSIYwK6ghRnAruAuzOQQOoDvzAeQQRzt3I983J2Qb
         V18U5tmCMoD1DqfQPGbGrtxBbAzI4mppQYkABEbphoVdnjdr6723iFZqJEEmN1eaw869
         MLWKr9OeN63aO5r6s73J9ggXn2yw1hBcn59L1Tl0MefoFpZmo0OBEW2dmnf+H6pNOf+g
         n9QQ==
X-Forwarded-Encrypted: i=1; AFNElJ/mnVLZVHlQWXMixqwVimM0V+arzf37QsstTLlMvYMn3IZm+iBm53Acg33za1Lsmp/Ylsv4vrQwMsSBfUo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwDl+cYxi6GEcpB/nKiM7M+2m424tyZFtRkJmIgdTjTr1EYYyHI
	wS98eoM8mpduY2OIbsiz8GcWVmeTTycbzbf2jrZLuyur01lqfmgyR1WiYn3RJ/wt/dI=
X-Gm-Gg: Acq92OGMmL25uX1EnIZZ6lyFNNm8/Sm3I47OZkOZAaCDhcw/WQCjTb8BiZASGaB3mu0
	ngNDiVZUAZoBM0QDi/hWhEz5/KPV77X7ZUK9Deyuf5zreRxurHtbBmCGT7ugafM+pzQrX0PrR0w
	Q1zf9RuAAhqhujSGKP67l+mTM2zHZYLObYJtgYZ1VthBa474GYW/Ak6dz/cjYd+8At+SXxi5jdQ
	tH0nBChyWoTIDzLTa+0WWvcHur3R3MQ+3TOseIap9KSJ9MEFO3vPKB8sSt7vaLOwkGmJUhdwZJM
	aGcNva57S6eFE4Ui41R4/P2dCnlc3AP3aUhehIr20KDIGFE6ulecmJCG+7p5a22kqSzNTB1t5YK
	QTKfD49C0wyEoqZDWUXZcUuDjvm/zL1gU0xE0Ji0DQbl1wU5+xFsKF0IOBKfiS7XMPSwD+PmmDT
	5eVm+LJtnwkOf04wIEj9YiT/WMwZqHvzP3DnQ2qhsqeRHAzwJts4eLj/s=
X-Received: by 2002:a05:6a00:8d96:b0:835:366f:5da2 with SMTP id d2e1a72fcca58-842254980a1mr14651687b3a.37.1780395158008;
        Tue, 02 Jun 2026 03:12:38 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:12:37 -0700 (PDT)
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
Subject: [PATCH v3 19/19] mm/mm_init: Fold __init_page_from_nid() into __init_deferred_page()
Date: Tue,  2 Jun 2026 18:10:39 +0800
Message-ID: <20260602101039.1867613-20-songmuchun@bytedance.com>
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

__init_page_from_nid() no longer has external users and is only used
locally in mm/mm_init.c under CONFIG_DEFERRED_STRUCT_PAGE_INIT.

Fold it into its sole caller __init_deferred_page() and remove the
separate helper declaration.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2->v3:
- fold __init_page_from_nid() into __init_deferred_page() since it
  only has a single caller (suggested by Mike Rapoport)
---
 mm/internal.h |  1 -
 mm/mm_init.c  | 44 ++++++++++++++++++--------------------------
 2 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 8497673d0ac3..b33fc87e4555 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1760,7 +1760,6 @@ static inline bool pte_needs_soft_dirty_wp(struct vm_area_struct *vma, pte_t pte
 
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid);
-void __meminit __init_page_from_nid(unsigned long pfn, int nid);
 
 /* shrinker related functions */
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 41b83dd18c01..f1bbf3b9a321 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -688,31 +688,6 @@ static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
 }
 #endif
 
-/*
- * Initialize a reserved page unconditionally, finding its zone first.
- */
-void __meminit __init_page_from_nid(unsigned long pfn, int nid)
-{
-	pg_data_t *pgdat;
-	int zid;
-
-	pgdat = NODE_DATA(nid);
-
-	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
-		struct zone *zone = &pgdat->node_zones[zid];
-
-		if (zone_spans_pfn(zone, pfn))
-			break;
-	}
-	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
-
-	if (pageblock_aligned(pfn)) {
-		enum migratetype mt =
-			kho_scratch_migratetype(pfn, MIGRATE_MOVABLE);
-		init_pageblock_migratetype(pfn_to_page(pfn), mt, false);
-	}
-}
-
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 static inline void pgdat_set_deferred_range(pg_data_t *pgdat)
 {
@@ -771,10 +746,27 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 
 static void __meminit __init_deferred_page(unsigned long pfn, int nid)
 {
+	pg_data_t *pgdat;
+	int zid;
+
 	if (early_page_initialised(pfn, nid))
 		return;
 
-	__init_page_from_nid(pfn, nid);
+	pgdat = NODE_DATA(nid);
+
+	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
+		struct zone *zone = &pgdat->node_zones[zid];
+
+		if (zone_spans_pfn(zone, pfn))
+			break;
+	}
+	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
+
+	if (pageblock_aligned(pfn)) {
+		enum migratetype mt =
+			kho_scratch_migratetype(pfn, MIGRATE_MOVABLE);
+		init_pageblock_migratetype(pfn_to_page(pfn), mt, false);
+	}
 }
 #else
 static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
-- 
2.54.0


