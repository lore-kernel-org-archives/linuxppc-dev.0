Return-Path: <linuxppc-dev+bounces-20888-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B2CCD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:12:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv3d71GVz3dL2;
	Wed, 13 May 2026 23:11:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677869;
	cv=none; b=IHH9Q2Qy+ctjTqgcBUTHpU2176SRn3kF5wNAxcmLG+FkyEkpb0sEJBnvt14a9uN3tGV+kZema1RF2AWY9JVFD9DqFNNSFUvZuvVDlMvZvkvTRAtA0ujIsJY2ceSVMkfZtDAJv0IzwUrlr0sg4ALfKWUghNyYKG7p8xnE1uDHPPWYVmjUIYT+d5rZMagdxkMZ8E3Ps4oZCzktvuXGMpUF72DwZmyl9YgNFVp1yb8QAYkj2kyNYzzg2/Sq8QWVrZJQ7IAY3lkXhO8VreBqpeftLOWhm9kzxOhE16a16u70KBjeoio3f/12j+XZyd8P5StBOtexKU5cHp3G3doiDmJGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677869; c=relaxed/relaxed;
	bh=lVy27NFdLuqlZKA5DziPKCwbPsRWePBCMeJ/pOD9y2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRIh6A/mE2es52Suu3YzUebCZsorO00ZjEwZrxt62e4sBXWQmLw08qFmKvr5h4qmmlqN4N8aMJH3wYCBoq7eEwI3oSfLIgrGCvflSbqm2PHExW6TE7dBNQEi94dqvsXxpUi1KZtXwq6CBFzwjzPZcUjPlhPY21bPWfM3WO0Q6IiLtP1T9t+SQAEL8IjGKzmqfoEqoBjmhBqAGnYrUvgR7NXxG4BO4eVJmiEL323or2UGDVaSgOTvR0DIFuxEW+mMlcJSYFrGbxwd5kiVGWLxU9iOozunc0vaE4SnLV46zYv0OZlA4aGcwmyloBr3JCCHlXoM65kQrL6KzuW21ZCqYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=O/ME9Nln; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=O/ME9Nln;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv3d264gz2ygG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:11:09 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2b788a98557so50724235ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677867; x=1779282667; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVy27NFdLuqlZKA5DziPKCwbPsRWePBCMeJ/pOD9y2M=;
        b=O/ME9Nln60w6awItKzhTlD6MJuEB5MaHSJiyTDRUbdIgHw/4WoleFDBrKHBqdzuGMS
         eLuufurH49Zf5WjpTeqnL5OaQy205hsp64PxdYqk7PTzUtiSWbML+a0cIST3gql3Aesf
         Jgtl79IOvyw41ZXuEOmgNd9uFG5kKJHhi1Glmz79HyEtI3fDVdc5M+kX8bvsy+dLHJfH
         Ri/lgiBBWK3TTG3+KtmTt8Z+QEXsUqxgKHT8q3gE9zJ8YHJ1NrwWEZacgWd+65pQFI+3
         C+D+FzrKpYf9S7t755T5IaqzefoiratozGngPx8gYH1YTYBdpHkt5E3FFFflX8m8v3ir
         Hd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677867; x=1779282667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lVy27NFdLuqlZKA5DziPKCwbPsRWePBCMeJ/pOD9y2M=;
        b=MiEG7ZuEn/kb18EUlsY5XjqQynmxcrl6sgHxjB2uscDTYzhy8d1nXXmq/nbz4ZGFPZ
         aun0MFsNmHgqN5hZ6KF6quDa7QhQndMIIm32AIfuuMMX8oQjYxmBtpH3tF8Vgn8cKXAD
         02SuAMIUPXF/oKgL+MbiAOWaoLqXlhSg1HzeELHGTth1X9O7ksTUGneaWQH/IpPMlD5n
         niwx9EzAIS59FjuZt6pe7csguP1HerJxgM4fQ9ACDhxu1V9srWHlzLcrT3+UrgwoKIDD
         tCxkzjdM8BrR9SURuh2ze42E3EPRV+YYmRjT4eg2FueKaBB7fNlL3gK2DI5UCf+8+u3V
         0rOA==
X-Forwarded-Encrypted: i=1; AFNElJ/fTymL0w6HJfcTcKyaSgUA0THUwfWt6DzZEvtKubQXE6cvBLe4CX4FinH+qXtFO0ApVsvqAkZKl6M5yws=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwjfR7IMOMngCZ+glf0BD1CbOqpmSfYTkQq82SuWsOoIjGVtKiF
	mbfJ+n1DoyE261j5JrAx0SHQYp/cOHhI2bfgVX7VXQ3vFw405bzPJy8a5NMFUk/+hLA=
X-Gm-Gg: Acq92OHFZWhyQ1YWVk60dIj7Wy/H6+40A9qfRoQgaiP0GM2IRfuUbAvtZ1+gk2yJoD+
	UuNA1JgieIOLPzBzwov4s+YtjIJ2w1EB8p7vIfZfWjMismVxWapq3K7FWDYr7BSwsYlytmOz6pc
	4kkoym6UB0m8AnmyFaiAD8zeavEJaXRY54rHHRJwHt7NrIPLBwVXFC3FgbnfbRcDRRR0WKr8oiR
	sgtQSoyeR8OUIgwBUBisFyHYlt2NqSbadBw4Bp1a0vUKTljG0wXQCCiW1/zEfsgAypr71OcMdrf
	e4Y9XqHYp0iFEM5xK4fSgdpvVXJ6V2Qpb+Y1vluls26aq51he2sZ8crZet2WoyFM54pQyn9zY5a
	ZLU3Z0d1qzULhkF+iPErFyB+wYNsQAuBtkXC0rDVQuXEpyBVXPVXqsD2cKUc3EBp6QlUkirzYi7
	mbjh7kZR1ZLiial1bou3peW42deIqEmjZvDyf8Jh/yrcEEjC+P+oB6V5RHGRU=
X-Received: by 2002:a17:903:8c8:b0:2b4:65ab:57cd with SMTP id d9443c01a7336-2bd275c0c48mr35313305ad.36.1778677867293;
        Wed, 13 May 2026 06:11:07 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.11.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:11:06 -0700 (PDT)
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
Subject: [PATCH v2 39/69] mm/sparse-vmemmap: Switch DAX to vmemmap_shared_tail_page()
Date: Wed, 13 May 2026 21:05:07 +0800
Message-ID: <20260513130542.35604-40-songmuchun@bytedance.com>
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

DAX compound vmemmap population still has its own way to find a reusable
tail page by walking the previous section's PTEs.

Switch it to the common vmemmap_shared_tail_page() helper instead, so
DAX uses the same per-zone shared tail page as the other vmemmap
optimization users.  This removes the PTE walk and lets both the section
reuse path and the populate path use the same shared page directly.

When the target zone is ZONE_DEVICE, mark the shared tail page entries
PG_reserved as well, so they match the initialization requirements for
device pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h | 10 +++++++++
 mm/memory_hotplug.c    |  9 ++++++--
 mm/sparse-vmemmap.c    | 48 ++++++++++++++----------------------------
 3 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 5285d53b0c53..7484e7be7b6d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1693,11 +1693,21 @@ static inline bool zone_is_zone_device(const struct zone *zone)
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
index 462d8dcd636d..9ff830703785 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -551,8 +551,13 @@ void remove_pfn_range_from_zone(struct zone *zone,
 		/* Select all remaining pages up to the next section boundary */
 		cur_nr_pages =
 			min(end_pfn - pfn, SECTION_ALIGN_UP(pfn + 1) - pfn);
-		page_init_poison(pfn_to_page(pfn),
-				 sizeof(struct page) * cur_nr_pages);
+		/*
+		 * This is a temporary workaround to prevent the shared vmemmap
+		 * page from being overwritten; it will be removed later.
+		 */
+		if (!zone_is_zone_device(zone))
+			page_init_poison(pfn_to_page(pfn),
+					 sizeof(struct page) * cur_nr_pages);
 	}
 
 	/*
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 53a341fcde74..0c0b54e94c07 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -329,8 +329,12 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 	if (!addr)
 		return NULL;
 
-	for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++)
-		init_compound_tail((struct page *)addr + i, NULL, order, zone);
+	for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++) {
+		page = (struct page *)addr + i;
+		if (zone_is_zone_device(zone))
+			__SetPageReserved(page);
+		init_compound_tail(page, NULL, order, zone);
+	}
 
 	page = virt_to_page(addr);
 	if (cmpxchg(&zone->vmemmap_tails[idx], NULL, page) != NULL) {
@@ -442,23 +446,6 @@ static bool __meminit reuse_compound_section(unsigned long start_pfn,
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
@@ -467,19 +454,15 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	unsigned long size, addr;
 	pte_t *pte;
 	int rc;
+	struct page *page;
 
-	if (reuse_compound_section(start_pfn, pgmap)) {
-		pte = compound_section_tail_page(start);
-		if (!pte)
-			return -ENOMEM;
+	page = vmemmap_shared_tail_page(pgmap->vmemmap_shift, device_zone(node));
+	if (!page)
+		return -ENOMEM;
 
-		/*
-		 * Reuse the page that was populated in the prior iteration
-		 * with just tail struct pages.
-		 */
+	if (reuse_compound_section(start_pfn, pgmap))
 		return vmemmap_populate_range(start, end, node, NULL,
-					      pte_pfn(ptep_get(pte)));
-	}
+					      page_to_pfn(page));
 
 	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
 	for (addr = start; addr < end; addr += size) {
@@ -497,12 +480,12 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 			return -ENOMEM;
 
 		/*
-		 * Reuse the previous page for the rest of tail pages
+		 * Reuse the shared page for the rest of tail pages
 		 * See layout diagram in Documentation/mm/vmemmap_dedup.rst
 		 */
 		next += PAGE_SIZE;
 		rc = vmemmap_populate_range(next, last, node, NULL,
-					    pte_pfn(ptep_get(pte)));
+					    page_to_pfn(page));
 		if (rc)
 			return -ENOMEM;
 	}
@@ -828,7 +811,8 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	 * Poison uninitialized struct pages in order to catch invalid flags
 	 * combinations.
 	 */
-	page_init_poison(memmap, sizeof(struct page) * nr_pages);
+	if (!vmemmap_can_optimize(altmap, pgmap))
+		page_init_poison(memmap, sizeof(struct page) * nr_pages);
 
 	ms = __nr_to_section(section_nr);
 	__section_mark_present(ms, section_nr);
-- 
2.54.0


