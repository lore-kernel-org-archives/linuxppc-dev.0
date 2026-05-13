Return-Path: <linuxppc-dev+bounces-20855-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BD7CD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:08:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv085Z0qz2xvH;
	Wed, 13 May 2026 23:08:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677688;
	cv=none; b=H6iNUqfSYvFWeaA2KywecUPG7Uq1q9p2jwC6HfgHmq3A0Aua0552UyRma35XadxwCF60V8KVlz+keV9N/mpVF9N7ivmhL83T59VgG0IwplAoPdI4IrNkYk+6V4DI71Na3w8KggDBYP9zvVLeuwvMhoU1wdTF+b6pRZW5Bg1gygvJF6kjiyEdt9rGkVMtoNtPQy1u12eQw7hsusAFs8JUkKXK69FG6ce+VHxS7I5v/9F0txwXHhWdef8sRj7YGevS+mWRblwR4v8i1pHmGUlp3W9tlQC+AjkiRwpyBZWZWA5HzPBriYnPPK2VNt7j/Q9ZkUZtcx6SZzKazcptrdyQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677688; c=relaxed/relaxed;
	bh=4FGAY5sLEWcL6nfZSRVARbstApRC9v1d8J6Ir2cANyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5hiHdvakgIywwJbEmq9vhga8+XUf58pIUOTCtObOlX8JiQvX3JtYqJ5P880C8CqB6JLFf1L8jP9XFgt6ICg1dDFHbuJ7P0BcdPC938VrPq3Cd3Qdd0jRzEyUaDHa3eMspEiNPrBjpcLjgYzZf9TWU3kTSlmuBBjWdJQ8TiPvBmVkL9dEPAHxyyMOxgbdK4J1GYXCeikPIbxWVwKcu6xjfWU3tgYMyj5j04UZMNRE7+taez9CS51Olwqi0V263/EshUS3m7CYzdcsbRLZwP906Qf2V0Q6/soeUU7fEJyxrMb51pXHS7PWFKK67CFCYdxhJVWLmIDirziGLa5w5lSsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=flKYATqE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=flKYATqE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv0800Kmz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:08:07 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2bc85eda6b6so20766745ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677686; x=1779282486; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FGAY5sLEWcL6nfZSRVARbstApRC9v1d8J6Ir2cANyU=;
        b=flKYATqExUc4VZXroNw6x7AtkWcP3hv6SraXTtup6u24Wj55d7Wp+VP4VJMJr3zzOD
         gkmFTalonCdkC/XBbx6vMJ589XU6tstWTrMh0RbfrMs5uiXRO6sxqrRwuLGfmgTT/xO/
         aDiF6Od/ets4gJr2exxi5eWEAcdvHZK6nXezcYRxYlYZBzs6RJ7xG68BV6x5LeTORW3P
         iHVaKP8iYyCCm8OqocAVTsIWKMaXa29lgSpr8wLIGPrz8V7DYVJm0ts+mQjW25/5x8mP
         5xX7dTXtJI4T6IHyYHob4GjtV82H4uMzPD8mOCvbjSbJrqqCf7jrA5Wp0rAO/F4oOS7Z
         e9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677686; x=1779282486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4FGAY5sLEWcL6nfZSRVARbstApRC9v1d8J6Ir2cANyU=;
        b=McTk+EDD3sfjDkfEdkA17udaecvs5gaYbkfxkF6Fziu6/KWw6l/x4lG0v8T7p+vgo6
         VNun4D7l7Bx0FbV2AXV+Ydn0pK/6pAeqO1qCG5W7LWIP784N9GEGJecMZcCtYIkOgcO4
         rVjtTLb94837vEIIKdke/nOgzwieYoY+4EVaAC1TIWeCm0Z8qazQQfKLpWfZNFtdwqr7
         LxSCxYE+0oDftjp8xdYSO9NKTSQOw2TLEOTKRI1ZdY99HyxbBiHEIStzfy/JQZ3EuTRL
         MOpxLd0qWVWaHy2F+qnpl2S0hTByMlDT22Tb4q4oZ3qA1OF8Dd0qjP1GkUG2/lISyl+r
         6GQQ==
X-Forwarded-Encrypted: i=1; AFNElJ81KAuMsXCNiQxHSQT7AmhHz3BJwuiD88L/Q+0VCNYo0VpNfkjjMBmX7ADaprPCzXYpnV6hpQfHXjIIUWA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzFF1HeG2qaVgi7n6Afpp+XCqbvcEKvTzQgalZWfiLeZxGP+C9r
	AAPGiue9vShUnDWVtQ+J3uFbV0byhk06KbSqNviHRl6G0p+5KPgGYZKusMNayn9BK6U=
X-Gm-Gg: Acq92OHp+ek7lCg+tLLOxK3FoYt0EfjDPfocJ54AeuVlsAo/FqMMkR2WkGuRiY99m5r
	nK1Jp+fHanv1gGc1k1P/ueLPcswItZmrb9IOoOnwmKUIWrHOXRMrZUCNNIwVigtmTHlRWfKK3p2
	+e6RZe8E+Hft06LMHJrxH42cF2Arl0bXhfbD/cr+QW/5ksD0uW0vZmS4t/1dw9jx917w6XKCMPO
	6EPWDINs0t2XR0huAyN2ZxrvPpLQ/FqCToQAtx4KNBBxnzRun1EM5XTFAi3fOPV04CMCocbSNjA
	lKKyAX7OjwTnmKgl0utvQN/Pv41byqiRGJnE/c3IEgmnoPcxUwWosxbwR0/84SEiee9fU9cuOQ9
	NS91qmv0smPBZXP1/JFImKMA0RTUmG6qJzjeFjgI/DTWyKKGtVluhjLy2YJaD9rIKxhR2I1GqSM
	D+CzGIbx9bUApcQ0ZphwtPQ/6mcaawBANqG6GMBnAOKsvzRHtVCHMDkr3zkaQ=
X-Received: by 2002:a17:903:bca:b0:2b0:ac1e:9737 with SMTP id d9443c01a7336-2bd27121cc3mr28132885ad.12.1778677685927;
        Wed, 13 May 2026 06:08:05 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.08.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:08:05 -0700 (PDT)
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
Subject: [PATCH v2 06/69] mm/sparse: Panic on memmap and usemap allocation failure
Date: Wed, 13 May 2026 21:04:34 +0800
Message-ID: <20260513130542.35604-7-songmuchun@bytedance.com>
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
---
v1->v2:
- Add Acked-by from Mike Rapoport
- I refrained from adding panic() to memmap_alloc() as it wouldn't simplify
  the code. However, panic() is still required in sparse_init_nid() because
  the architecture-specific vmemmap_populate() bypasses memmap_alloc().
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


