Return-Path: <linuxppc-dev+bounces-18862-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6604310AB83C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:16:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhklp4KLjz2xmX;
	Fri, 27 Mar 2026 13:16:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::ae"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577782;
	cv=none; b=kIbgK/rINBpa5fCO8W8kcJIa9jSKZW5SJXV5uPqFeNSbhNwRE3kieEBei9OKHSwMwMP4ie2Xage0ntghfPuVhqA5p2jKuY6+JJiJ3pFGr48a3xZoGsonElWYZYg83Z9EaSPOOAcjr99tEt7f7lcyTJJhDzbbmXXsMslrp0uzvHNVIB0obAjkk0uA6O3jWmzg10J4IBof0a0hbHo1AhrhO4roruMujOGJbRBeV8ihgBBmuxVQypuYv9bVAiP3TPbuYpfJZDJhGqp0rXta6OAymOmC4eu7ikP0axjUDJTENzY5cpz8ZhDUgRaiz2T4JeCXtLxRlnAlixTVLtv15Sq0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577782; c=relaxed/relaxed;
	bh=sRAVBAAGLIHNuPxenAu6Zv4mVQpIwOINutBDBMSDYBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDlH6XL4/eY2qIvbxEjqFwnhDZ28dnzBH5Zmi5rBklj1fGJ64noxsvu3iSoTuNnafVKwTlfsCsoVcS870ApJJcorsOBNKCUfzRMQ8gkbxslV0+aaAuVW++0TixDJ3oXh6EXTBNrXVrfdjAvOrRQkxP2DDYdDSPjUd2vKFNrfEj4DV34vYuKzKyKfRJv9Ng5IIHU90szSQZyBeZMzY/4J6qVBwnL9BnXpVdEVB9KQ2Dp+zmYBZ/QNQXpKsZ1iwOjNC3h+G1Ql4WmWj7i7XrA7iJlivCnxwsEs+wfAC3imyCFdZrOLUpVbbL72wwwSfOWHC11yp35N547/Aq/oi+1aRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DjzOCy7C; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::ae; helo=out-174.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DjzOCy7C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::ae; helo=out-174.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ae])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhkln6nyXz2yqt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:16:21 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sRAVBAAGLIHNuPxenAu6Zv4mVQpIwOINutBDBMSDYBI=;
	b=DjzOCy7CYYN46My00Xi1fs3rAUMoskKmV/KpehE3GWn6mX4MPqoLYrTNgfZYBGEzLR8iqX
	SjzK869MdpGpt78ig/FnB50pdDMBRhVufNL3A3S6FY7A6Fna4cqbAKf1pwbFNITcjpiouQ
	IsF7YtJduydG7B8wGDwJ7Ww4Rl22lmg=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	willy@infradead.org,
	linux-mm@kvack.org
Cc: fvdl@google.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kas@kernel.org,
	baohua@kernel.org,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	Usama Arif <usama.arif@linux.dev>
Subject: [v3 19/24] mm: thp: add THP_SPLIT_PMD_FAILED counter
Date: Thu, 26 Mar 2026 19:09:01 -0700
Message-ID: <20260327021403.214713-20-usama.arif@linux.dev>
In-Reply-To: <20260327021403.214713-1-usama.arif@linux.dev>
References: <20260327021403.214713-1-usama.arif@linux.dev>
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
X-Migadu-Flow: FLOW_OUT

Add a vmstat counter to track PTE allocation failures during PMD split.
This enables monitoring of split failures due to memory pressure after
the lazy PTE page table allocation change.

The counter is incremented in three places:
- __split_huge_pmd(): Main entry point for splitting a PMD
- try_to_unmap_one(): When reclaim needs to split a PMD-mapped THP
- try_to_migrate_one(): When migration needs to split a PMD-mapped THP

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 include/linux/vm_event_item.h | 1 +
 mm/huge_memory.c              | 1 +
 mm/rmap.c                     | 7 +++++++
 mm/vmstat.c                   | 1 +
 4 files changed, 10 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 03fe95f5a0201..ce696cf7d6321 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -98,6 +98,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_DEFERRED_SPLIT_PAGE,
 		THP_UNDERUSED_SPLIT_PAGE,
 		THP_SPLIT_PMD,
+		THP_SPLIT_PMD_FAILED,
 		THP_SCAN_EXCEED_NONE_PTE,
 		THP_SCAN_EXCEED_SWAP_PTE,
 		THP_SCAN_EXCEED_SHARED_PTE,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 48c4884a6f386..b93718931e729 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3347,6 +3347,7 @@ int __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	if (vma_is_anonymous(vma) && !arch_needs_pgtable_deposit()) {
 		pgtable = pte_alloc_one(vma->vm_mm);
 		if (!pgtable) {
+			count_vm_event(THP_SPLIT_PMD_FAILED);
 			mmu_notifier_invalidate_range_end(&range);
 			return -ENOMEM;
 		}
diff --git a/mm/rmap.c b/mm/rmap.c
index efbcdd3b32632..a0180f62d9f69 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2087,8 +2087,12 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				pgtable_t pgtable = prealloc_pte;
 
 				prealloc_pte = NULL;
+
 				if (!arch_needs_pgtable_deposit() && !pgtable &&
 				    vma_is_anonymous(vma)) {
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE)
+					count_vm_event(THP_SPLIT_PMD_FAILED);
+#endif
 					page_vma_mapped_walk_done(&pvmw);
 					ret = false;
 					break;
@@ -2491,6 +2495,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				prealloc_pte = NULL;
 				if (!arch_needs_pgtable_deposit() && !pgtable &&
 				    vma_is_anonymous(vma)) {
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE)
+					count_vm_event(THP_SPLIT_PMD_FAILED);
+#endif
 					page_vma_mapped_walk_done(&pvmw);
 					ret = false;
 					break;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 2370c6fb1fcd6..b8df9c7296d8a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1409,6 +1409,7 @@ const char * const vmstat_text[] = {
 	[I(THP_DEFERRED_SPLIT_PAGE)]		= "thp_deferred_split_page",
 	[I(THP_UNDERUSED_SPLIT_PAGE)]		= "thp_underused_split_page",
 	[I(THP_SPLIT_PMD)]			= "thp_split_pmd",
+	[I(THP_SPLIT_PMD_FAILED)]		= "thp_split_pmd_failed",
 	[I(THP_SCAN_EXCEED_NONE_PTE)]		= "thp_scan_exceed_none_pte",
 	[I(THP_SCAN_EXCEED_SWAP_PTE)]		= "thp_scan_exceed_swap_pte",
 	[I(THP_SCAN_EXCEED_SHARED_PTE)]		= "thp_scan_exceed_share_pte",
-- 
2.52.0


