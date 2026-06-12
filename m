Return-Path: <linuxppc-dev+bounces-22533-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC4ECD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 04:00:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5PR5BlFz3bs0;
	Fri, 12 Jun 2026 13:59:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236779;
	cv=none; b=hsSMNmiri9xeH4ThsFrkUtLNioljVlJlZW8uv9lgDuVinauXWe1u9eFoqExKmUZ2vHlojLgfx8JiUC9c/Jwx5XrJ1dk99FpF1FX7FRAV04xoNg/ExnAaIiPikQotKxOM3erc8+GwzJhuhfoEDb2rrH7uqIZTGObEjQ7oOhOe4Pw1V0odoG54xWsvk7Q8dF6iagp2g8FrtNC0m+gqjYjv6EdsmqqmpFrZkgIokW2q30Hjjd0l7MBFGCMHRU2iSpkFQruVwrcvs1MOwHLl4S6Ma1tLQ8GH9EPUin7krLUp7+krCeMfREaz+v7UMv/30eXQxfCR6KNDQS28XfO2BsOOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236779; c=relaxed/relaxed;
	bh=TPNP/s8YQi9s7EHLxOTbc3dEJlnMSCHwNqhJjmE6eW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iohb6GddBOZzPVsH21M9uKr3m703wzZsuJq3LsvSdhgwOclHh6036h7BoGMHOibNGVJ4saEuGGiwylQPtxLQ6ze82WL//905g4aHj5z1MS3TtMtwkRsIicXE5FHafqEeirarugOi3HisQB8g+AtWlF7BJwM3Fung5Veap3WGSr88PJf7D5JwEld6pKDmVSSy+PFaCTDlMBQcUfhSz1emAcsh7YOlr7yFFaKN/mj5FBPmxa38/IIiezgWH2T25SBeA2X47XMjIfhYaxGCERRIH0HgrXmqBGuwBjQDPxvYDiKdOs/xxFtH1i12emvgGaQfGZ5QP8ZbqH3v0cBr0u+Qkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Mdcxelcb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Mdcxelcb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5PR0m9vz3brx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 13:59:39 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-84229481d44so308107b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 20:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236777; x=1781841577; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPNP/s8YQi9s7EHLxOTbc3dEJlnMSCHwNqhJjmE6eW0=;
        b=Mdcxelcb5ePHMIVn20Wzc7yN+F1B5xTG+x7OLnls+CmUXtfwESGrxzg8z7ThR53V8b
         Qg+7nZb4ZTm/Zv0UF8opz16y7qNMEPv/u18f8iL0aGaPhO0u2je+sTpmwVb6MGeo7oza
         FTFzSYKrvdDT9G6i2PF3ZohcvlTfOoMUpl2Ir1VWy4qn+A0s04jgqS0ao0pn+swLQT5S
         JScvGGvUQq9yq4AiuB6uL/La7gYLsV0UIubkxARqso24PrAzDyAsmRkEiTnC+SCiiktj
         LW2fMpGvkbOZhpsq4ZEVNTjKrv/3dtGvQM4MSLr5VMHRwtf8yOPLnZawtJLpwp3nDeIf
         Al1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236777; x=1781841577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TPNP/s8YQi9s7EHLxOTbc3dEJlnMSCHwNqhJjmE6eW0=;
        b=iIAMfRPYGhVOjnTtb9RQyKMX/JO8026C1uzrHNQ32luTl8/RfYdKD/0G4PXLO2r62x
         cs2PziUr/jheUDynIwmv35d9gVJXYDkzClF8Nt7XQwwOiie/NI4VZY3wueIu4qBeICJx
         c+DxxzFkZ0YzkdrTcT+Wc6LvAAQqdaszavGSK1bO0hpo2dLhVg00H1sY7eQ1Yc+8BEcp
         GTVD4lUPRZroblU6DXPMi+F8bIFUXc9wV4VUyCjJfWEVyVGJd7DimZ9mVxaYHGhi4/tj
         tbLaEvdsw8gAuS8jPsIMPail9443zRxon5rJpcBvWZFZQLXuJd/BnoDmKidTaGoA9vVW
         qZwg==
X-Forwarded-Encrypted: i=1; AFNElJ9E12/HZlazeGLRNwEiW+JM7XMAjEJHZNOgefI4eRThdaFk6uFksJrbXhheqriE7CC6CTOZxhkRTn6Y9ms=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzs+4t9LVqELpKOFJk/BHsUTujJ6DySlHsnmC9c94l6Y3kV+p7K
	J8fOPzlWGqxEICVo+Ud7V+PzYONtB8p0uJWMwbCrvcu92Sx8HMdBoP9jJMS3LyAMHV4=
X-Gm-Gg: Acq92OF7toUkaq83/Io1RXP/GCls3sXSpXa/VqLXiiaXHgZ5YeeY3/dpSpx0iNb8VXz
	qLe9u6ZGFbz/aIUOeNMzX0xTUSzm4T8Nqv8vAA2IG1EvbL1n9UCt5+Bk/1Taedie/TEvWzktfCl
	13JyW0319hFk17tqfPspglfAxvlb4HC5ZYIA+15IHLi6N3siXKHz6y3eDUVrjfNTSl2BhAuAFkJ
	XxRCdDRBpODd1mG1kdEPlzLKbCuBHET8zuyIu46TUuUxxx+PmsTSgHjWukn+FmE5xD/lYpa25F9
	IDgc2Cl+8secvKJpeMnqBTVi9k3w+lBK4+CjdbZ7Fg/ukM2czHgoDacmXQz4sGHJLhQcVYQmegU
	VoE+CIclZHHm9NG4LcuStvuKO181ESjUYl6m/RAV/E5YCRDiJHgnef3H170WavzFSPnKS10l5wY
	UslUwOi2pzKjvOlbDyQRzfx/u160UjD76tkdfXB7VZgNY=
X-Received: by 2002:a05:6a00:148d:b0:842:6a3b:60d8 with SMTP id d2e1a72fcca58-8434ce0d4b4mr1113011b3a.30.1781236776918;
        Thu, 11 Jun 2026 20:59:36 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.20.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:59:36 -0700 (PDT)
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
Subject: [PATCH v4 05/19] mm/mm_init: Simplify deferred_free_pages() migratetype init
Date: Fri, 12 Jun 2026 11:58:49 +0800
Message-ID: <20260612035903.2468601-6-songmuchun@bytedance.com>
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

deferred_free_pages() open-codes two loops to initialize the pageblock
migratetype for a range of pages.

Replace them with pageblock_migratetype_init_range() to remove the
duplication and make the code clearer (Note that deferred_free_pages()
may be called from atomic context).

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
 mm/mm_init.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 92e88fca717f..5c7359693ba2 100644
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
@@ -1981,12 +1981,12 @@ static void __init deferred_free_pages(unsigned long pfn,
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
@@ -1994,11 +1994,8 @@ static void __init deferred_free_pages(unsigned long pfn,
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


