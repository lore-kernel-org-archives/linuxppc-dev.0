Return-Path: <linuxppc-dev+bounces-20916-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB469CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:23:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvKQ5FFLz2yXj;
	Wed, 13 May 2026 23:23:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678586;
	cv=none; b=OnkteeuPbiCU1d1cJrALlARZEiD8vjgaOl83V4JvthY4WPJ1C5qprBRubwfEbyNx0YoimXefYXAA/ozmhtSvjIwP6LOQ3eMM4GLeCkcxgF70ZQa5+OdmI2AOEYQgN4SBlpy5rEmJCRIsDLWDPEl2ig5FrvJlVFfHu8o31m08MpWLnlfH0vPhC9rB2X6SQA3RWQfpadilYaOtMRIGzwGMmzdogDaabqycRirpvN5+l4Z+2P4/6gqxsofeP80LQKQ/jxEkNnxeolMtwA/42VVc2nNj7k3WWEJaxliZKQAscLjbsi7qiyEhLmqg9LPS9H8OjM25UYKb+tEbnINCy/gTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678586; c=relaxed/relaxed;
	bh=KmWs7Z/HY7dnLOeYCdnqk/zbv31syyn+Ltp9gTVRyME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9byK46iYYpyT9nfX9iSQGOP3BW6KdY2Vq7g+fMnUnQ2TCiOtklQCCXWuZN46KwjJBhHxCehHaOVXIqt+gXeSos3jt6lgTzUPgytgMS1Wa75kqDcekG73rDOh4PvwIJR7KfgJ1oGF+XFBMuXxp8uTY97SL50z61KSvhQ+oiRLjq2G9TG6o+7h/XJsj4BTT3Op7s8+H/MfSXWH2KTKu664/QK3GlssDbeeiAVZGFPMAsocE7iXWhu1w3d3CHzdQsRekO4u6M/pxqBkA9GhJX8a9tZgvJ63QyKK8VLlfHmmZ0r1QR5lMRY0GFKlLudIyiGyLqrHSt52fiPFUUqFQWbOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=D5jx5m6k; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=D5jx5m6k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvKP5rKNz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:23:05 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so4153320a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678584; x=1779283384; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmWs7Z/HY7dnLOeYCdnqk/zbv31syyn+Ltp9gTVRyME=;
        b=D5jx5m6kK2UCIabgBKpYaCy18srcWLcHhlRaHJORz5rGbJA6eyu+kqKzfXCupMAwQO
         Z2GX7NwDn/dbRd0GtSZLNdWXwwVdbOo+1J91lIGr0Quux22grD99xUgSbdEMKMU5Xl+g
         V5KkNKhTqhRYlutPsMxL4NPZwRZE53qiQzVoDQT+GNiolsoi2KQ3J8beIBvkr+CwdHa2
         DewN71hl4En8S3iE2Pgnk0LHr9+g+O7iDjChrxd2dbcl3NhFEUt9/p8c5B7ir1M/Y0Vy
         qEpQVtO/eQ420i4DjYamMSpMpHhI4SgmyBEPaThEZ8CoBQxCmLld9RFn8l6aHQNOu2Sl
         zzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678584; x=1779283384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KmWs7Z/HY7dnLOeYCdnqk/zbv31syyn+Ltp9gTVRyME=;
        b=cb7Y+3QqHlnEyGiOTHRqM2k7hpzMKLlzqvd0Bh44lyJsRP3b37uXrlRV6XAsI1JXq0
         R7T1SBiL14EW6GeoQrwOfukvsclR/DMjM/1pUhTPHCrn+9INwdzM7iAYPUaNB2XFoy1U
         wfaboKBj0CnUFf0/FbQvEfm8NQ91yuHQLz3djceiTEuFIFBciycKA10hwE3UCThztwDc
         TMYO/K0g6r9ehO9UbKFZ6a//nswuea7DaYH/U8L/tCjhrvFZ/QD5PgLfao7yEZgEJ8rJ
         2Rnbq6fXRjxTBTyxhgjwfiaI7qyqasj4Z6HqTxe7AjwlvyBznGCZq6pgxe7T9D3j6A2+
         vJ8Q==
X-Forwarded-Encrypted: i=1; AFNElJ86/F0BtW0EPcmrTLnV6QRU5qLU4IlAncbmT/aFxYy5QLLTSwGU9+wg8gWJT1dbk7m/ZFDySHtB27dvGgA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxYSq9/GcddZf8YMhBdXhjNwS8XRLhjCWSX8P+r4UvhqEwd1iJs
	hulQLVs/4QcIEZ/Rc0SnKG1ioPMxKD2S42Uu/aBgWYLKt91rumwhh+CqUWqe68RwNdA=
X-Gm-Gg: Acq92OEh9LBstVl+TV1LYpCxqXWIUvAFF1djue1lfSVKWbQKazGd49PSeEjHYqmAj4B
	2QzXZ61qUzGgi+8EBG1vQzFSa97RrQg+pLn55rrc5OiDtHj5bIcG2YdNntjOq9OlYCnG9kVb5Tz
	uy0hFYcGRWQuYDKrcfgsQ+zs6hJMZWTbCtJFyoGwk7PbzK5b4Hngijy7nulYctED7ZRPFFa9li+
	Hva5YzY8SnaGSu0TNDXxx/jJTIjIExdZd0uSvqkcjjtN4LWY3EaUMPcme7MY7hBPU297pG9gvSd
	RFh5tBz/bY4FPDPpJFceHZ/63Vc6c917feRaWDumj9rVopE0YXuBRsJEbGx2SYocUOYCPNURTkd
	LfbFkXonhuI5sZE0zwsEd141685dybZAM+97jFzN1UBW1zNlORJ1nW09SIS19CF/veh9bxuepEs
	e6IFnug+6mwGnWmndmSMTdvFcwhOU8pXkvyK07QL+OAGI1n1spj1IGKMc3x//y
X-Received: by 2002:a17:90b:38cb:b0:368:ed92:6f6 with SMTP id 98e67ed59e1d1-368f77c8a81mr2774547a91.1.1778678583622;
        Wed, 13 May 2026 06:23:03 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.22.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:23:03 -0700 (PDT)
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
Subject: [PATCH v2 67/69] mm/cma: Move init_cma_pageblock() into cma.c
Date: Wed, 13 May 2026 21:20:32 +0800
Message-ID: <20260513132044.41690-21-songmuchun@bytedance.com>
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

Move init_cma_pageblock() from mm_init.c into cma.c so it lives
alongside the CMA code that uses it.

No functional change intended.
---
 mm/cma.c      | 8 ++++++++
 mm/internal.h | 4 ----
 mm/mm_init.c  | 9 ---------
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index c1896c0db63d..2843c4f59c4e 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -30,6 +30,7 @@
 #include <linux/io.h>
 #include <linux/kmemleak.h>
 #include <trace/events/cma.h>
+#include <linux/page-isolation.h>
 
 #include "internal.h"
 #include "cma.h"
@@ -137,6 +138,13 @@ bool cma_validate_zones(struct cma *cma)
 	return true;
 }
 
+static void __init init_cma_pageblock(struct page *page)
+{
+	init_pageblock_migratetype(page, MIGRATE_CMA, false);
+	adjust_managed_page_count(page, pageblock_nr_pages);
+	page_zone(page)->cma_pages += pageblock_nr_pages;
+}
+
 static void __init cma_activate_area(struct cma *cma)
 {
 	unsigned long pfn, end_pfn, early_pfn[CMA_MAX_RANGES];
diff --git a/mm/internal.h b/mm/internal.h
index 80b9ab594dc5..25b6e767cea0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1126,7 +1126,6 @@ struct cma;
 #ifdef CONFIG_CMA
 bool cma_validate_zones(struct cma *cma);
 void *cma_reserve_early(struct cma *cma, unsigned long size);
-void init_cma_pageblock(struct page *page);
 #else
 static inline bool cma_validate_zones(struct cma *cma)
 {
@@ -1136,9 +1135,6 @@ static inline void *cma_reserve_early(struct cma *cma, unsigned long size)
 {
 	return NULL;
 }
-static inline void init_cma_pageblock(struct page *page)
-{
-}
 #endif
 
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 1e11fd683292..ff6e9fb468bd 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2200,15 +2200,6 @@ void __init init_cma_reserved_pageblock(struct page *page)
 	adjust_managed_page_count(page, pageblock_nr_pages);
 	page_zone(page)->cma_pages += pageblock_nr_pages;
 }
-/*
- * Similar to above, but only set the migrate type and stats.
- */
-void __init init_cma_pageblock(struct page *page)
-{
-	init_pageblock_migratetype(page, MIGRATE_CMA, false);
-	adjust_managed_page_count(page, pageblock_nr_pages);
-	page_zone(page)->cma_pages += pageblock_nr_pages;
-}
 #endif
 
 void set_zone_contiguous(struct zone *zone)
-- 
2.54.0


