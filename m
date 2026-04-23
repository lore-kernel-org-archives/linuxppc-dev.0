Return-Path: <linuxppc-dev+bounces-19998-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C7CF99342
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 07:20:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1SCb0jQWz2y8d;
	Thu, 23 Apr 2026 17:19:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776928795;
	cv=none; b=LOsSrFcxTIEvADQJD52OkGb//ps67trLguy91XHlOozLetfN7SxngMEchqC4kDbG9QuXW0KnULtXcSRmr+auv6+P3CrJNvP5AWqYPQpYhMT0kDSKbJ+dT6yR6Bwas0rYKLi9WN9hqjZFep/2WAmmSsVzKORU9ekTy6XkYGolSRRKPVpaQHalSR9Rk+JkCsmYySc+w22i/dpo2eAEGI80G8uIfAXrvK3wq2zeNNwnM9d80eaFE2DHnLDR5poT57l32y/yfZTK5/LXHBn3Vmv3FryT6R1PzgJbGprmljAQKpChHeUC5UxYFV2PEo5IdyGADIILCtuLSdHCojSKSRmTcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776928795; c=relaxed/relaxed;
	bh=+V18KNwF7QBH5+p7vjE1eHKkHO/d1EPWETOYBsNfjQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VPU6HvR5u99u3P+iF3HDHNX8zr2eSqk9Pvr0XVPTYvvp2WlRDCDgd+OnMaSOEUo58RHBElx0E0kTWeZTkCMP+65QapSxTGpJM5Bv9dUJ9GZ2Lt1pD09tho+kYsQcQ2scNxQYRTk0Hiszebm69xxAex5TP2c17WV71OjkXDbOcg8LL6w0Jr6WaVbXfBB1JmsonZBh8lBf+G0nDN1husL90yXj4b373iNCwRSI0a0rE8yiwVS/PUmQwzatrFbHpBe9WMLHbiLkudy8Xo5mZsB5/IJrls6C982Nz3cS91GLY8M3Mm6cFsP0NViVaYodjbqNURnbvYZF4XrRSOq/aLa9lA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=fBvpALa2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=fBvpALa2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1SCZ2Qb4z2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 17:19:54 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso3752485a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 00:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776928792; x=1777533592; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+V18KNwF7QBH5+p7vjE1eHKkHO/d1EPWETOYBsNfjQo=;
        b=fBvpALa22ds1b34KB12N1aVlRzQwVtcVQW5d442pNgSLwcCO2LBnOp5JyJM6NtLTMY
         q9XGrYO5fBy3Sz4UurDobHJx/DMaFVCrduzmBwV51XElwytQWiLqUO/UfQJA+TmLk0bW
         XMReprIBGMQLebcRolh0yphzklJneFjCayrdfjcbOatQdZoBaDUySFFDJr7RWSYRakQM
         rNUgvdzRRZpAZD0dlRUBS6c+eFUQqLAS9n/rvyXsp81ESD8IBrosojxe5ZBOReK/slUQ
         vnq5hj8E9xTPr77eNHRCiIfMT3hboQyuPQD/3nTcFsBdZYgOCak7YMDyM/YfhLQfbJh2
         XFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776928792; x=1777533592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+V18KNwF7QBH5+p7vjE1eHKkHO/d1EPWETOYBsNfjQo=;
        b=nd7MI4MqOArBl5bYUg3/CtiHk6p2ykFa+g3gXaDO1LyYZyqnYHqnjCn7VC/0hxcR3O
         jnvJImxhM2Yn/kBgMd4bal9uwQGj9kbt3PZZTFRMIDUS0p4XZBwwH/r/M68Cy7hQex8X
         ivWoJb4kv+vJo6ITL9MxcZ2JSskFkis7kF5pne4PfM34jX7JTkddFTtvrwq+KjIl+RwB
         +fqq1Tufw4ys9uvlLeOmDMtqqLc0izfz/Mrf6y0PMZHALZNzRbUQXqJsTMlsUh8PG1Ip
         qZ0qKfuPS0ggxerZiXg24bQUHPz4B6CbE7j1aFKgp15w7h4cik9VzNMNCeozSUY1qk+I
         CliA==
X-Forwarded-Encrypted: i=1; AFNElJ9jVg5aM0B4knin+x1+3K3mLd54vvtwOBWr2bAC84gUQnMTjLkW+NLGdGs3LJbb28v/7YFLpNs5GRpmgk0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzsuIeIB5E8Q+bdiyQTtr01UNjMLU47aI7gkxyjoPo7/wDNaC8l
	uqFpJLJuzrv0Wrrg9Nz7Nfkzu3PJyiCEcurJkDf4QRnEKnu8NrWW5mjARB+ysfxWA5k=
X-Gm-Gg: AeBDieulcSuWI6BLXfBeqkV07he7v9iNVSE+MZujqB/dWJ1lC7rQNQxIUtVmqLmQisJ
	4kJrghUfktnpB8hxxXteBnCOm7z/GRbpGPkGnEjyDdhkFvRUgGmHQwxmsJHbPsSB370HcMa89Kx
	F2+CgLwo+meOTAqnttrbcMS6BK7pA4SrbGzD9Eqj4KK90tK3RM0t7sipQs/7B8jK9/PcrCqptHZ
	8NKukDLqO/q8qUGgu3K1bFrw1gqd7jYrBsJ44AmpasNYPZqidUqbs2Rgv90/v6DT48H9JKOCRuH
	k+hJysaqiMwkgPmnwJup0QQLxRQc92rRrZXhaY4qpAD8q+PeDjdPoV/0S0go4WdYyco1dqajg5G
	lkQ66Hf1oujKVFKIHitnRjslBdyghGLsfygT52WlTxe+pwB+LogQ6MiQlPGBkDsayBTax6q59ln
	hvuoQUMESRoIWM76wIhwCHBt692rS9mU3NWl3Clm0yf+Mi0ri5Lv1JSg==
X-Received: by 2002:a17:90a:d40d:b0:35b:e5ce:73bb with SMTP id 98e67ed59e1d1-361403d61d5mr25963174a91.1.1776928792148;
        Thu, 23 Apr 2026 00:19:52 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fbd970fsm7092372a91.14.2026.04.23.00.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 00:19:51 -0700 (PDT)
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
Subject: [PATCH v5 v5 6/6] mm/mm_init: Fix uninitialized struct pages for ZONE_DEVICE
Date: Thu, 23 Apr 2026 15:19:11 +0800
Message-Id: <20260423071911.1962859-7-songmuchun@bytedance.com>
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

If DAX memory is hotplugged into an unoccupied subsection of an early
section, section_activate() reuses the unoptimized boot memmap.
However, compound_nr_pages() still assumes that vmemmap optimization is
in effect and initializes only the reduced number of struct pages. As a
result, the remaining tail struct pages are left uninitialized, which
can later lead to unexpected behavior or crashes.

Fix this by treating early sections as unoptimized when calculating how
many struct pages to initialize.

Fixes: 6fd3620b3428 ("mm/page_alloc: reuse tail struct pages for compound devmaps")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mm_init.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index cfc76953e249..bd466a3c10c8 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1055,10 +1055,17 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
  * of how the sparse_vmemmap internals handle compound pages in the lack
  * of an altmap. See vmemmap_populate_compound_pages().
  */
-static inline unsigned long compound_nr_pages(struct vmem_altmap *altmap,
+static inline unsigned long compound_nr_pages(unsigned long pfn,
+					      struct vmem_altmap *altmap,
 					      struct dev_pagemap *pgmap)
 {
-	if (!vmemmap_can_optimize(altmap, pgmap))
+	/*
+	 * If DAX memory is hot-plugged into an unoccupied subsection
+	 * of an early section, the unoptimized boot memmap is reused.
+	 * See section_activate().
+	 */
+	if (early_section(__pfn_to_section(pfn)) ||
+	    !vmemmap_can_optimize(altmap, pgmap))
 		return pgmap_vmemmap_nr(pgmap);
 
 	return VMEMMAP_RESERVE_NR * (PAGE_SIZE / sizeof(struct page));
@@ -1128,7 +1135,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(altmap, pgmap));
+				     compound_nr_pages(pfn, altmap, pgmap));
 	}
 
 	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
-- 
2.20.1


