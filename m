Return-Path: <linuxppc-dev+bounces-26245-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3051CC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 07:55:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYLr25mbNz2yDD;
	Mon, 31 Aug 2026 17:54:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788162898;
	cv=none; b=fY+nvuJYM3P+38M1zQP8GKztH87kpWbMJBzsp8EpwrtJKMfA+cxLRQjFvdCTrz+S7PieY3/ek0SdoMzyKzJnOhlUyVWEZu3UvZDxE2ALlnqcNzYGcoTP2snr2JHMGzIsxwIQVSTLQ1IMXsfbjlSH856mU5RgjVAkuHBvQj8E4KbGeUCQsJFENQ9yVbxr0EA0qlVrUpFqBY1jUp9+NNmKyNaXuTOrmKzjLBMB7KSbC/L2pCOKFGl/ykK7Ia0MvGHl9uPAOz79AORgxtCT/oMmp6eeRZNyvNR9q9CKcqax9dts8YtLVe4C637NFwmOZPcbr/eohbfydgDQKPGKbAP1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788162898; c=relaxed/relaxed;
	bh=RFw62PZ7fKSG6PmMZYyDraeWannjZPtyw6lLCfcFAXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpbucXfaQBrGbRUOchZwW0LPNp0rAQ9D/PpeuRa/1O0RCM6iMiaNHVD2SgBPG7a6tsDfi6ZMFMAb3QdUnhp5yVEjdzeTpo+2POjvxTQWWz/6e1GigqCqNUJB008vEF3v/UAA5AnkwHkhXFGH8dqX2eAnY92SrIzaU1Dh2IFLLac26Jnmu/hFcpCzSFTVlywkxj9mzCNQt2/fSZu3C/8WogDYp/OLagXD8Dgen5rnNotBWraTwNNk4Pvte8yQ8Jkc3zQJny6Cw+m32zWSfnGfKnvFcexKMuKssIfFUSVznASL+oyTRCHrQOgAMpmSc7CGQRjMX65i1izh8zIeHho1Ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BHJPT2on; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BHJPT2on;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYLr208Srz2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 17:54:57 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-8518b3ff3e9so3196944b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 00:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788162896; x=1788767696; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RFw62PZ7fKSG6PmMZYyDraeWannjZPtyw6lLCfcFAXM=;
        b=BHJPT2onp0Kdc7i49si1n9yP7PNkmnjAlK4TOQtqL3JV6fV0KHyrPngGH1XiK/bltt
         9jLYgougQY3vAVYBlgucvCUdGQ3JV2ZtLkHoP6ByycuP+vyUbpJ2UXJFlki3RmIL4ISo
         qE8An9hnkphE3GS1sYNEmLxi5q9ckeMNWHvngqJgMXps38nhItqEOn7kL5Fmhc+l8t7P
         5vat2vNHuoy6A+H9QbHLmc/aMFkz1QqcdyUZ9TONRn2X+f9dElsg8esaltNbKwJS0Jfg
         zez2zV2KYNsqrB3CX3GT1o+oJIstv2nqr/LwbodiFMMqaboaLeZecTC7gKnpRUbvPXEY
         PmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788162896; x=1788767696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RFw62PZ7fKSG6PmMZYyDraeWannjZPtyw6lLCfcFAXM=;
        b=MTgSxzDuL7IX7f5oywV5KCOwjxlzIqLwScCsgtV4tlK7n01SBbQjdSC8CkTm3Tqp9c
         tzM/UipETkxY60qULR2D+bGwtc4IVB/t7nR9dozshGfSVKIaJQZypBvc1oil+3KuDlgL
         DvK1s0IUNZUsj+DeIcju9MneGyTVPJsyS0xodJmeIdpmOthn2XtT3h9KBsOxdX9sWN4o
         dFPGV+5tIH4Jpce858py4AQVK8oV+hA9oybuojskfvi8M+W+v9nAnQKsu2yzDDtomN4z
         w27N1JnjB6I26cKeJvlxumiACa2XKvzJQUqNrm5T87Gcx4mWtI7A9RDBXkV24vFFi6X+
         dCNA==
X-Forwarded-Encrypted: i=1; AHgh+RprBtvkvbBAKsthF3ONChCFHvoJ6lTQmQPWlN6Q/JMNXUsYPL8lhf6VYHPMJ2WwQKLljQvvmDa62DK70SY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nZXhFXtvWw0DUDjDN35MbrCdqQR1AxZuyFBb+c9p7dyShPgldZ
	/hV9gRiuFMp6gv4z2lpBqx3X7sfoCliBvcjpXlstzsm83zVG/RnADlPJSjHSrZBVPJQ=
X-Gm-Gg: AR+sD10iiZa2Exo4BXKtmj+axd8IqpMyNcMo4jLXbI2XhEgX5YKnHQx53VMS+hw/i/u
	KV0E5fZqsyA47HybSn9I2q0uWrEjsK5sTM/znvlygb++jq+2H8YDAdYtXazncbIBm0PwdwdIaWD
	mSXW/+bOI8k64uyUE87Xs76dHzKLyxuL7rZnqUN0DP+ga4pUNLIcAzxw/ARnBWvkoAM1DanYXeZ
	4DtiIW/vbiqTorUp7DAZCTi+6P0pUxu5vkGD6nFOuHFkQIWoLh9AuRpJG/r4Ee8HpKi7dzGPnuA
	+JrGfwTGwa+3XPvSdeHfIuXfTeI2cIiXTMNxT1PPEQZVZEeywEBM/BYpGmO1xmu7IAxSkKFEQmv
	7OU3au+tkVN83tpZgF35bQXY1UQs1P4bKPoJ5DcAhu0+1Iyn+S/vhd72FNzsx2iKu/PmV4BalW+
	e6H9PCb2Xs5ZI6vCiK77WRPzaJlLWZT7YhnSI88MhBymgPDaVk+SnVKZJetnUMryRMV+zjjvadS
	2gaO9udcKtzAfTVUCNGwaItqflu+qCuU/k=
X-Received: by 2002:aa7:888a:0:b0:84f:dd30:1890 with SMTP id d2e1a72fcca58-85adb7bdb1dmr2240316b3a.15.1788162896019;
        Mon, 31 Aug 2026 00:54:56 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f330f88csm3590256a12.10.2026.08.31.00.54.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 00:54:55 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 06/11] mm/sparse-vmemmap: switch device DAX to shared tail vmemmap pages
Date: Mon, 31 Aug 2026 15:53:37 +0800
Message-ID: <20260831075342.57563-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831075342.57563-1-songmuchun@bytedance.com>
References: <20260831075342.57563-1-songmuchun@bytedance.com>
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

HugeTLB vmemmap optimization now uses per-zone shared tail vmemmap pages.
Device DAX has not been switched to that mechanism yet.

Switch device DAX to vmemmap_shared_tail_page() as well. This aligns DAX
with HugeTLB by using the common per-zone shared tail vmemmap page.

Since the shared tail page can now back ZONE_DEVICE vmemmap mappings,
initialize its entries with PG_reserved for device zones. Also skip
poisoning vmemmap-optimizable sections while their struct pages may be
shared.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h | 10 +++++++++
 mm/memory_hotplug.c    |  5 +++--
 mm/sparse-vmemmap.c    | 47 ++++++++++++++----------------------------
 3 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d3778ba976a5..03ed9232f186 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1686,11 +1686,21 @@ static inline bool zone_is_zone_device(const struct zone *zone)
 {
 	return zone_idx(zone) == ZONE_DEVICE;
 }
+
+static inline struct zone *device_zone(int nid)
+{
+	return &NODE_DATA(nid)->node_zones[ZONE_DEVICE];
+}
 #else
 static inline bool zone_is_zone_device(const struct zone *zone)
 {
 	return false;
 }
+
+static inline struct zone *device_zone(int nid)
+{
+	return NULL;
+}
 #endif
 
 /*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 226ab9cb078a..d28bafb6fd53 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -554,8 +554,9 @@ void remove_pfn_range_from_zone(struct zone *zone,
 		/* Select all remaining pages up to the next section boundary */
 		cur_nr_pages =
 			min(end_pfn - pfn, SECTION_ALIGN_UP(pfn + 1) - pfn);
-		page_init_poison(pfn_to_page(pfn),
-				 sizeof(struct page) * cur_nr_pages);
+		if (!section_vmemmap_optimizable(__pfn_to_section(pfn)))
+			page_init_poison(pfn_to_page(pfn),
+					 sizeof(struct page) * cur_nr_pages);
 	}
 
 	/*
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index aed1e7429daa..0201877a7f80 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -193,6 +193,8 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 		set_page_node(page, zone_to_nid(zone));
 		set_page_zone(page, zone_idx(zone));
 		prep_compound_tail(page, NULL, order);
+		if (zone_is_zone_device(zone))
+			__SetPageReserved(page);
 	}
 
 	page = virt_to_page(addr);
@@ -490,23 +492,6 @@ static bool __meminit reuse_compound_section(unsigned long start_pfn,
 	return !IS_ALIGNED(offset, nr_pages) && nr_pages > PAGES_PER_SUBSECTION;
 }
 
-static pte_t * __meminit compound_section_tail_page(unsigned long addr)
-{
-	pte_t *pte;
-
-	addr -= PAGE_SIZE;
-
-	/*
-	 * Assuming sections are populated sequentially, the previous section's
-	 * page data can be reused.
-	 */
-	pte = pte_offset_kernel(pmd_off_k(addr), addr);
-	if (!pte)
-		return NULL;
-
-	return pte;
-}
-
 static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 						     unsigned long start,
 						     unsigned long end, int node,
@@ -516,21 +501,18 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	pte_t *pte;
 	int rc;
 	unsigned long flags = VMEMMAP_POPULATE_DAX;
+	struct page *page;
+	unsigned int order = pfn_to_section_order(start_pfn);
 
-	if (reuse_compound_section(start_pfn, pgmap)) {
-		pte = compound_section_tail_page(start);
-		if (!pte)
-			return -ENOMEM;
+	page = vmemmap_shared_tail_page(order, device_zone(node));
+	if (!page)
+		return -ENOMEM;
 
-		/*
-		 * Reuse the page that was populated in the prior iteration
-		 * with just tail struct pages.
-		 */
+	if (reuse_compound_section(start_pfn, pgmap))
 		return vmemmap_populate_range(start, end, node, NULL,
-					      pte_pfn(ptep_get(pte)), flags);
-	}
+					      page_to_pfn(page), flags);
 
-	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
+	size = min(end - start, (1UL << order) * sizeof(struct page));
 	for (addr = start; addr < end; addr += size) {
 		unsigned long next, last = addr + size;
 
@@ -546,12 +528,12 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 			return -ENOMEM;
 
 		/*
-		 * Reuse the previous page for the rest of tail pages
+		 * Reuse the shared page for the rest of tail pages
 		 * See layout diagram in Documentation/mm/vmemmap_dedup.rst
 		 */
 		next += PAGE_SIZE;
 		rc = vmemmap_populate_range(next, last, node, NULL,
-					    pte_pfn(ptep_get(pte)), flags);
+					    page_to_pfn(page), flags);
 		if (rc)
 			return -ENOMEM;
 	}
@@ -883,13 +865,14 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	if (IS_ERR(memmap))
 		return PTR_ERR(memmap);
 
+	ms = __nr_to_section(section_nr);
 	/*
 	 * Poison uninitialized struct pages in order to catch invalid flags
 	 * combinations.
 	 */
-	page_init_poison(memmap, sizeof(struct page) * nr_pages);
+	if (!section_vmemmap_optimizable(ms))
+		page_init_poison(memmap, sizeof(struct page) * nr_pages);
 
-	ms = __nr_to_section(section_nr);
 	__section_mark_present(ms, section_nr);
 
 	/* Align memmap to section boundary in the subsection case */
-- 
2.54.0


