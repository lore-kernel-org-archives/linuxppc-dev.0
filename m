Return-Path: <linuxppc-dev+bounces-22547-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B57CD98CC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 04:01:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5Qp2VGqz3cZ4;
	Fri, 12 Jun 2026 14:00:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236850;
	cv=none; b=J0OiMImDgt2LkN4DKbgjk4OZb7bzxRpUUBTAC/IpuIX1O+f6g5tMmccUlm6lum7Urz/8fjW9nVGf8RXX5lELQCsDqeC5tqlsyaStso7IIl9jDGagH4U2IIKKyKBDoYarquWyKtzmDxi3lmy5Zs8+dsZ/1DWvSqrmkfoDLKwkX1SOawHHU7+isceFOBC0MZ4qJy/g28JlffJKf8v7m2jaaalj8UfIEPUyhsQFZ/29nBDJqg8ba7D1nYKd2CfNukohiJQ2ezm2RMnLJaOKBZWG/c9EqepxJ0885rost8AKd8kw/3RWU2ng/seC3uiCRagBWvwisuD7eaTU+6nIBy33EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236850; c=relaxed/relaxed;
	bh=idHdbNQvIYMC7O/PUhqtBCVSyqTiFPMkYhoG6e6axFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpyTGG/anXsd/oE8nqGltFZ3FEmuZHTzD6MY/SzBKK0xYofND3qGvxV2nNv2eUo5Wk5tbzxf/REqVYaNsT2940bFiJA2s2JDTsv1jDAbxUOD7/86TeZ2SKb7soTCx3LOqxeuhbza/UBAi8iO27J6wRd5SPMm7OkSeCZPFQ+vmkBiab8vcV7kNtNBdHYpoDYhvv30f00k2QSw5WQ5YR1+2asThZh1tPtIQDKbf5IQlnQvgGhPnZpv9MiZLiQ6oKb2wMKh0sQZDVx6TJhDmYQp0/QG1sQ5viqsFqOhKbe6aNmh+1q6q0oMkC0DPX3ZsJus2ORVBHQr8u1vUuy3gZCAyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=O5cYAWiF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=O5cYAWiF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5Qn33Nvz3cZd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 14:00:49 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-8422f148dfcso349669b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 21:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236847; x=1781841647; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idHdbNQvIYMC7O/PUhqtBCVSyqTiFPMkYhoG6e6axFo=;
        b=O5cYAWiF2p2h3KelzwQmqViXqhHQrqKkHq9LzYPOfu1hMriNzmc2SF7R0tJbIzsG6W
         8ttgZk1ZWXJvARyO89muOMbGLqoIeqxoyWOnQyWt5XSVWqi0Lt1guJ8PwppocN3Ic5SZ
         I3a1ZTRrsp+1Wznfa0UxMPpS2o8ZSoibj316/QFoMdOKy3odsZFeKimipu73kbtZnzOJ
         w3dZKTCyevgwqPO4O6kBL5V3yTj1iR0KsAOuRRAVFBQEzq6YmyM+5RVCPOqN8UUEql/x
         AyvfvxB8l3SAbUi/Azx2Yurlc3NMiq6LOLTOT8ulxvVijRdSMZPXfEAFG08XZoK0uX8p
         aPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236847; x=1781841647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=idHdbNQvIYMC7O/PUhqtBCVSyqTiFPMkYhoG6e6axFo=;
        b=AFtxIDNpcF4P+T/TvOJ9km/VM70Fm/r7Ie93XKcg3swWPDiraAHLpLrzDebNzX5WNo
         kSWvsup3dUpFm07S5r1Qh7UUnpw/an6e9vT+S+PZXew2flwy0U24nh1uAnGsG6XnmoJl
         53p2fblhlEWKneobhXhEkdZ+Fe4PgUgdp3q98pvCodPIvU1/8shsShEsP2sM+C8ZgiGT
         iBUPrbp8P5Pxe1eBE7hY7ppy1QaeaTAq6SemHDKH8+pQc4hXF3ddT1wYNMfs/eB4f3Ke
         +XcRlu8kVs939asmhE4D08xkfCqMLaIlxzVTJzDtXby7srTubJpDgvI3oyCsMIDYss4O
         Y+og==
X-Forwarded-Encrypted: i=1; AFNElJ/J2Lb0b7z/ZjCp6TEFczBnIMjH7iAGESelN5U8sBhuURJNmKdUsMgrPSkfvIRNBVI2XZFP8YdQUZpaLV0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzEfeogp3DUbzbM1cX0JK06UwmzdVD4u4Qk2k5RsrGfbaB89X1V
	0a0PAopwQQhT2bK3USw3BcG8JYVAP3wj/uAMoTJx4rHhy7yStI9Z1BYsCmAddLAJJdY=
X-Gm-Gg: Acq92OFygrRkpnTDeLG3e9OB+IL5HAFmWvovQiRFSMxCiObLWvHK7OY9upMM1gVEVTo
	tVNRQSiUqgWzHYy63DCPsD/o+BoTWz56ugsKRyRlGqrkU8VcUH3c10FgNBCRrbOhQ3PBf5LkkIk
	ar26dRIOeOOndhJfq3aiwqj9JfTHCcANc7AfBB7ZyKd5GcmzzOAZXTa0C7zwSU6Bt32aM32IhmZ
	LZA1pjnJRDAIg8MTcPkdMs7bRF0PHVH4P6hDUyhAuaomQH062T9upppxzl0paIyA1ME4GHQKJwh
	4b7rvKAUL5LXqZCG2A213NWnDOFdVepf4jnD+3bIxBBOeSVaskptoTlG/lvZcNArd6RL0Kco1GY
	FcmXWXKItSUM6lBy1WYCMhLYS2QfeKSoijE4eYWp+04dxzVOeamQ9Iu7ffmOXpccT91dcgVct38
	oP71ZrOilYNG/Pwi1eiJFlZn4bj2ZhHDTxVuTt6sMv4fs=
X-Received: by 2002:a05:6a00:238c:b0:835:41f3:f440 with SMTP id d2e1a72fcca58-8434cdfe0ffmr1116771b3a.14.1781236846941;
        Thu, 11 Jun 2026 21:00:46 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.21.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:00:46 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 19/19] mm/mm_init: Fold __init_page_from_nid() into __init_deferred_page()
Date: Fri, 12 Jun 2026 11:59:03 +0800
Message-ID: <20260612035903.2468601-20-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612035903.2468601-1-songmuchun@bytedance.com>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
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
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

---
v3->v4:
- Initialize pgdat at declaration line in __init_deferred_page()
  (suggested by Mike Rapoport)
- Collect Reviewed-by from Mike Rapoport
---
 mm/internal.h |  1 -
 mm/mm_init.c  | 42 ++++++++++++++++--------------------------
 2 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 39c9564fba0e..dc10291f14bb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1760,7 +1760,6 @@ static inline bool pte_needs_soft_dirty_wp(struct vm_area_struct *vma, pte_t pte
 
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid);
-void __meminit __init_page_from_nid(unsigned long pfn, int nid);
 
 /* shrinker related functions */
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
diff --git a/mm/mm_init.c b/mm/mm_init.c
index c76498b7abd1..4026b084bd4b 100644
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
@@ -771,10 +746,25 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 
 static void __meminit __init_deferred_page(unsigned long pfn, int nid)
 {
+	pg_data_t *pgdat = NODE_DATA(nid);
+	int zid;
+
 	if (early_page_initialised(pfn, nid))
 		return;
 
-	__init_page_from_nid(pfn, nid);
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


