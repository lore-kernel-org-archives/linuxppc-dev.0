Return-Path: <linuxppc-dev+bounces-26707-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE57CC79FAA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 03:04:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hf8186ymjz2yjw;
	Tue, 08 Sep 2026 13:04:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788836668;
	cv=none; b=SKCtenfAwI6bxvWBUKtoKgFcoGpBh5ndfshNJqGEjDwB0rS4lRpPNnwnLuLdKhUT62bchLxn8AAD1bUNnO4sFr+iznNoUQoYFm7U8KaJW/kM2zDtrPqvrP4CncMC8Ow8LzdandylzNCISt2/iOhyG/bWSwftwl1eGPJdgl1CqE1KZ7og15BnhDXw680Ey60qLTGEeg1yWOdNTaqC7V9skhxQ1idmZLPfKVIPRr3WjS3YtW+AG4LgnH1X1XkWZ087Ee+yGnYHMDTsTjFfftRkTgPcfgWpEUizHPEiWn3XL2onj56f4aVQUT/EVBRLUJApPHVLlmBAC6bNtk4H2lga2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788836668; c=relaxed/relaxed;
	bh=uEGgQCKJvggw1Narb1WaslYNRsxnnnRwg14YCHWkvvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkI3t6bnv8JGq7X2jTXqzWOvG6kH7KlukdMT99aD8YwkhnPnoj3SZh0e7YYzWGHdMsqz0Z51ox9H2C+ACGR6jLidD1YYRbOdzj+mv4A8kixpWtvcCbm0KCWCvoHbZwDtQHojEhMA7nCWIdXJ8MrjGUQ8udvTv7BZy4L+VBKoOinb4cKUqMZkYLY0ACpgdiG3dB9xab5iHwhn9eoY37O1spfVdJGq+Sk4o1jNNAE4EEal14oMn0MdrSM/JFDFPwH/LQ5c6Bt4a8F1jVZ49i+bH4r1Inb/Qfzus33UhSuUdyK4pkixWrwSsjdliBzxU++VOnLzKurk+G/JvYbv/0+CeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=aK/0f6b6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=aK/0f6b6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hf8181Q1Zz2xq0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 13:04:28 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id d2e1a72fcca58-85469d28035so250944b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 20:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788836666; x=1789441466; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uEGgQCKJvggw1Narb1WaslYNRsxnnnRwg14YCHWkvvU=;
        b=aK/0f6b6ntU3ZikbjBtzS5jOJBphVcit6n8Z1ip5+W9XVaCJR+sNY6leFIlonCnAU4
         qiAve10QLp7OOHZRfm0bWX6ccBfQTyfboKlRsWFI8+qi1EbqJRlw7Qg0Zwo83t1pgNRe
         od4ZPHHHveELYT3RuCEEwANXlzdABI9JDg7j8244HFClA6BeJPN4tB74pkS/ry6Rnhtl
         J1svJ950ot98mynewpCPlQ3lWf363EdjrlLpkBL8r96h1OSzS8kveqJbTbmdk61dTwg6
         1U5vO4LaEDA9Z2NPb6FtS0cMCQmRvz/OXLcGVdowESzku24yXWYBqwnNh1+D8m0V6Mjs
         /Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788836666; x=1789441466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uEGgQCKJvggw1Narb1WaslYNRsxnnnRwg14YCHWkvvU=;
        b=WfPZN2ze16lytS4mrVkOemomTTHdIfXr3IePhLB6TO7n63kEOtZRmOjWVV4/drK/3M
         wWnjBdFqufhYis/BT9W//WjBmnovKlzqMUBvv/yfrMkkW3y8b17STbnLiPangm33N3mK
         uvNcZMPhyRYZkYMnqZofCrOCudCQ7OI7kE4TsR89LlR8lVMN25UgfJcKgNCtBltQAwOK
         UJlCn3H8QfwaSSjb/eJP2xrBXHetcTwSHqBiHP2zAyeRPoI3ycY7c5TQeAO0ULowgyws
         A+ZmZg1X0NbX6x0u3lXPrb8z0f2TWAI6djiherj3mp4S8hisuPXCIEL3n6A791gO5zbc
         6ZQg==
X-Forwarded-Encrypted: i=1; AKwUvBz92JUeyoVveCnGlzCY+pztUOQ/fzlq5ira9n39Z7/NNibKcmuUe64CvmzOhEmN9v6QBlnp9djT2XzJHtE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nipAaRacY3VnVJOvk4s0/4Fw4qT6iWfu83NNCtBuV6Sg60djSV
	iJ2YxXmAkcagqCcgEQ8IMdRedjsnraYmLN+vV1YvgNfsjMxUTAYj5quLAT/xNUrMdTU=
X-Gm-Gg: AYBFou3KnmJzqDzBZfLudgGfy6OI8GjcG6sR9IL7hnzbvF6VvRjysXxQFi+XTx7He0e
	R6r3r/fMsuSYMMc6i5uWLpOP4To3slSCp/T7BqsbtKQnDE/Rsq3IXSp/jfprRCLdbx4MWGdHkrD
	zp2eUqtzi2ZLkqiXIXmmNTCQUgNAf/O/Zi/Cm2fAOfg154GXoc1ySiYM8U+Pdpr6B4sC7s19r0D
	liGMxaNpKH1gR9zAdpkZh/+8WqP9uhvNsoxsDo+HoH7Ff7YfhmYgEUdVrJZ7u2v9uiQyz7uUNwp
	TIElgKLSX8wMzCWxawbil6xtH1iIndOJxt51vBeeLpnGCmiRD/rG5bmLk72pS8Wa+3+1M/bgL21
	xCTZokfqpmALiGoK/O7dEWr5wNbBdznrJJFM32orno6UHxNiLHLPHR+kK1d8yGKxif2kNdJIkEc
	0CAeMI5aN9i1yQn8lxQAfs1FYrEMNvkaUDFR5TNd7EpkxASEQ6mbq69Jc0EYAXX1SmL5JtPeFKZ
	5emisHzplvsTBncbd9ga42C6epgkE/tv28=
X-Received: by 2002:a05:6a00:1d9a:b0:847:852f:c28a with SMTP id d2e1a72fcca58-86698ee5c1bmr4207907b3a.5.1788836666149;
        Mon, 07 Sep 2026 20:04:26 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152a358a2sm4868234b3a.29.2026.09.07.20.04.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 20:04:25 -0700 (PDT)
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
Subject: [PATCH v2 06/11] mm/sparse-vmemmap: switch device DAX to shared tail vmemmap pages
Date: Tue,  8 Sep 2026 11:03:30 +0800
Message-ID: <20260908030335.96549-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260908030335.96549-1-songmuchun@bytedance.com>
References: <20260908030335.96549-1-songmuchun@bytedance.com>
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

The optimization is enabled only for DEV-DAX through pgmap->vmemmap_shift,
which is assigned when a DEV-DAX device is initialized. Unlike FS-DAX,
DEV-DAX does not modify tail struct pages, so sharing them is safe.

Since the shared tail page can now back ZONE_DEVICE vmemmap mappings,
initialize its entries with PG_reserved for device zones. Also skip
poisoning vmemmap-optimizable sections while their struct pages may be
shared.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
- Explain why sharing tail vmemmap pages is safe for DEV-DAX
  (suggested by Qi Zheng)
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
index b428da66d279..0db0379826df 100644
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


