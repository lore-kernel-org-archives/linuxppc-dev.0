Return-Path: <linuxppc-dev+bounces-22538-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA956CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 04:00:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5Px3Vwjz3bsM;
	Fri, 12 Jun 2026 14:00:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236805;
	cv=none; b=HsHGAcRGhGbJTvuwu7xwm8HqbTPQoJqlff++Iff5ejdIBMTDADWXHuU0eA4A9qeSvNuzyybPXTZiJ4fg/EnZZUZKAr5xAaVBzNbGwmN5J0Z18qOu93F8UCWmQIqVcTwEx1byTE9wdHxQPRwukNkWlnDawqj6MTuzKPUjnELEUIOWweFI1jXDjcvBGp1usp3ubGDxPCJQ3g9JY4RF2rRILikzMRxQybdIDyhNeLL3xtMpYy+Cp98kzAtPGQbsFJm2mpfZ0oSJpq0omgdPMWcAhigm7VMt5g89wBJfTHvocNbMFP02ye7Kzo3J5f9vM1CNtQcfCkBOKsvTs+PjyNk8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236805; c=relaxed/relaxed;
	bh=yo9t8lKmmaXZlPvADJP1ElnBLtvvFqj3ytBwR1urti0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyeBMCtqpcfRczvgIzBZnHmrJFoN9W1tIa4oos86CeDL/hx7nZmPEGR+/BFDkgh2r793G3Ju9CWXA/mqkog4pQvf7oKuvCvjV4TgvXqfe3P6DMPOMvwnQOo4axDg4uMlBJgRquhswzDC5eDKYxDhIrJ6A5j2b7hrEP1n6xp0vD+e7snfmKBydkdW/dnfjP33sdeAmQLUbJhDrtebq1+NoztkWR3q8LJM6X392OrQqXoCFhIPb6mbw9zjmyKkVZc7wJIa+6dfbBwQNu4nzsdk50JpMKdmKQBRu5dJGHt4yDCRIY+a1QIut5AYjTk7UtMLlRIPdFBaN7YKHLegREPmbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=AWXBiynd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=AWXBiynd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5Pv4rqFz3bsQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 14:00:03 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-842307473b5so455063b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 21:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236802; x=1781841602; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yo9t8lKmmaXZlPvADJP1ElnBLtvvFqj3ytBwR1urti0=;
        b=AWXBiyndlSIJIqklcZA+K2zAxwPMPM9sDnkpyNgxEzmHfCo+TmrIpMBhnLuLUMqHX4
         +Qdm6tplS+yTFjo3etwQ3WH3IW5mFwB7XXWstmyzt1JCt91IS9s/TlX+YyaE7kELJK3b
         G1ZIpOfHazBMVCDV5CwAfqvmXWqihaZxPMDTTv1WCsh68siaUpQog56poo3BCF+j3D+J
         vX1rTFxjR/ZQU7ioe9oXMEsZuoi31UV7KLI/EmRL2/V2FWYoFroqhB2TlGQyEXd6WRAu
         x0MnUtzpod89JAY+aD/JrN2WjL3Pcy70zpwPgIfGc55klUZNKSwlMwsTgvuk4N1ZIpks
         mDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236802; x=1781841602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yo9t8lKmmaXZlPvADJP1ElnBLtvvFqj3ytBwR1urti0=;
        b=qdjmLC4GunK3bI8btrMVS0OBDdUThJqpneRnw6gakT3eOd/ZvFAdZueMjnlBU+kuWp
         /kUWt19SVWtH0d3n7u+kNjy+Y37eEIku/M1ELur8weF86HIJq4RNZq6mB6Rd6IcBQuPZ
         RbbkBegsroPSj2XeYSXXEul46r9DQKL1m8AwPD9Soq2+zsWe0XLhlESJ+r9Pu8V6pZ9I
         bLbIbD4M+EowrYc4CGPooKyx3mydfpZ/oBD3RtPh+QlZMrT7AfoU7+aCva7W51njbxag
         My38Y+/xmT2CqNUGmLQCgg+oh5gGQxf1OtihxWIL5QEdaU/u0SP2kQPnrVNVlOWS8Hmb
         5TnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/mT32PM2mSxhea41i8GeD/GmEnO3ijgK/VBksY44eK85AyUkNOVofvUHJUDNE1AXE53sl/8m94S2UJ2Jk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YymZvoJpRNoJejchK7fj8wv4y94clTnxznd+oBionBQykdwEN/b
	U1mzJGrlVJflUW/nDZ1FPyMiAxCiWO2BwjbVTjPHt7o6biuFBPxeJrQN42Lmg7EtZP4=
X-Gm-Gg: Acq92OFYnMzgeMoMBakWE0mu2VqF/YgJvi3KISiCBVwc6Fazc3h2IVC8g8kLwpKrDNQ
	FMEQhCfmNbvgtmZpR7hvJTqPiFKGTfBZWhzwD98v2dmFMIlx1Y+zVF76x0s7M7jk4DFttcMkrbf
	MMhqKnq0J19lMSg3FQJQw6LkYHtDhj326Cic9aFh+t8y8n/9k08glM1hJc8DaPVWcoKUUd2pYn/
	iv2O/nFwO9OCDNJ1Qjmi7OiqEiDf46CW3sCsy4ZoC0LcssOHy8+AN02Fo6/WOmPrUSRUCwTpIZn
	KoxuNVN/XpKxcI2YGXDltq6BADsC9fgXo1pKStKZ1UmVEEh8IEKj+TvTEpp3gpMdSR9IaCp/gAO
	fbUwv9l49d7y6yj8RthVM3FbfwrjrPtNZKE4U2vFuQUpCQzffdLCxflfo6GatxhijT7yd3oJjcL
	fqoh7dUEcuXmR8NXREegxWzPNUB+sANaMS4ynKvUoDj8A=
X-Received: by 2002:a05:6a00:2396:b0:842:68d3:e29d with SMTP id d2e1a72fcca58-8434ce8a80dmr1047898b3a.36.1781236801769;
        Thu, 11 Jun 2026 21:00:01 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.20.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:00:01 -0700 (PDT)
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
Subject: [PATCH v4 10/19] mm/mm_init: Remove set_pageblock_order() call from sparse_init()
Date: Fri, 12 Jun 2026 11:58:54 +0800
Message-ID: <20260612035903.2468601-11-songmuchun@bytedance.com>
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

free_area_init() already sets pageblock_order before sparse_init() runs
for CONFIG_HUGETLB_PAGE_SIZE_VARIABLE, so sparse_init() does not need to
call set_pageblock_order() again.

With that call removed, set_pageblock_order() is only used in mm/mm_init.c.
Make it static.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador (SUSE) <osalvador@suse.de>
---
 mm/internal.h | 1 -
 mm/mm_init.c  | 4 ++--
 mm/sparse.c   | 3 ---
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index dccd4727de46..09efb9f4d126 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1435,7 +1435,6 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long,
         unsigned long, unsigned long);
 
-extern void set_pageblock_order(void);
 unsigned long reclaim_pages(struct list_head *folio_list);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index ccf494fa7586..a0eb61f9f55a 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1496,7 +1496,7 @@ static inline void setup_usemap(struct zone *zone) {}
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
 
 /* Initialise the number of pages represented by NR_PAGEBLOCK_BITS */
-void __init set_pageblock_order(void)
+static void __init set_pageblock_order(void)
 {
 	unsigned int order = PAGE_BLOCK_MAX_ORDER;
 
@@ -1522,7 +1522,7 @@ void __init set_pageblock_order(void)
  * include/linux/pageblock-flags.h for the values of pageblock_order based on
  * the kernel config
  */
-void __init set_pageblock_order(void)
+static inline void __init set_pageblock_order(void)
 {
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 85557ef387c7..324213d8bdcb 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -343,9 +343,6 @@ void __init sparse_init(void)
 	pnum_begin = first_present_section_nr();
 	nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
 
-	/* Setup pageblock_order for HUGETLB_PAGE_SIZE_VARIABLE */
-	set_pageblock_order();
-
 	for_each_present_section_nr(pnum_begin + 1, pnum_end) {
 		int nid = sparse_early_nid(__nr_to_section(pnum_end));
 
-- 
2.54.0


