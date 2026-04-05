Return-Path: <linuxppc-dev+bounces-19350-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D17F3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:55:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXWD42bgz2yrg;
	Sun, 05 Apr 2026 22:55:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393736;
	cv=none; b=dq1JkZYfYLxwlDUku9b2onnEMI2z/xzjr8Sg01udeSGlI4bcmRUk9jcV2gdr0HmvZmTrxBKIM22VQxbJ98SAreDZr74GozhxVrKBEj9rBy+J3VE9rQvBPmGKqDMi0AqnP6wOGyIkdMd7DeK7tuGgEotcM5x5dabygcM/sgnRo77bVbywGQZg52Nfxhtj+EfvdrOdAQtOzbu2A/wn9GD3q1TTEtRWddU68wEodmB9niEeCE2FFoOlkjkcm6q1rY/2PRH8p1oUHMO5pD5rhZlaxQWCbnQv3YOfCwON15dFND3bHRwiM8Rj4xNGyfjYJiv+xuUDpiS8prbZ0yjqLfbEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393736; c=relaxed/relaxed;
	bh=kLG7p8wcALm1QMUUetEVr6LzElxTKf6AgyaW2eyLe0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ika7VZxYA4vN7D2qUK3aCSwe/+UmDy2i6zHGM/R0YL6RhmMsT5OgipBbMwLJWCp15LsEeA64aaUPvMFzsgGN0XZaw0MxN3rZeRoGj5BCJ8n0gO+4gtuGjCuR8dc3iOKZBwUha6XORoTPW+rw2Qwg/YOwX3e73hmHgC1E3zVuMBdfSq3mQ74JFRbXfuTBKG56xMEiEig/ySkOvzFw3/2FVDTIYgrlpPPCQEqe2iO8EHq0cJj6XiNjkz9XOOjOL0AodrsIihkBF0fPow1vb/n0IkLG1FVT+wAM1M6yClLQ/TvbO9b5OH5gVPFQBH8yn1TTfYsOI6bKMVqkl+Q/nLV0mQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CuCmXv6o; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CuCmXv6o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXWC6l5Dz2ykf
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:55:35 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-35d96be7c13so1889925a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393734; x=1775998534; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLG7p8wcALm1QMUUetEVr6LzElxTKf6AgyaW2eyLe0w=;
        b=CuCmXv6or77ZIjSCJr8nahawaYhfhJ9IGa0vW36/3IpewYFgelt72flsQSAOeIV2T5
         BxyJrobAIUv+iuwjAWyoRtGWGj5dIR3ngi1bMtePacslq8sO7oLqwrybeI1ReB23+Zgs
         ko14UuDYmOIYSf6hFdBS33YOmwJLo/R+hjh1As/acU2SgrAhfmal/z52eUEqfryAdMqm
         LvveH8GMzOyTDqHX/ALc5Lpn3D2eSbMZxIr86hps/gGtvw22VYhLowsjmnxRac0QZEzE
         Q0r7HvKxt5Zg0iLq3QlM4V3L2Ou1DvcnMdDyMk6ZqeCmqT7D2Y7imbggf1zyF/5U0qpM
         1rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393734; x=1775998534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kLG7p8wcALm1QMUUetEVr6LzElxTKf6AgyaW2eyLe0w=;
        b=kbajPwj9RIVS5im1IofLugoknf+nB/qW4WipIg7+LXkSdud4HXNLTLT6BdfxO+wlpC
         5JyHoeIYrbJZ1bCtB44Az21IU25IzTCvo/LKwOo22V5s9INoM0eabRy3KXjZlMQQR8u5
         bdyTzx0MYh2qY4KmExAUwb0NgSql+2+y4Wcdms43H5GlDN9hHrVx+IRpiqBct1uuRMF1
         oTsAA+pcV05Vdzl/KkiUe7aXEC1D7ngISITMAL2PH6qGadglRF0Hofp8Rd/c/FOeDOFM
         fac207rvKwr9htfoyTcIAMWScHPHs+0sE5QB/5InVcGxHFFbm4GG94LUreukNTZt/f05
         5q+w==
X-Forwarded-Encrypted: i=1; AJvYcCXUWcWR7KoogIDWsuPeF3/3y38L9iexsZKDtNE8MWFdHfpAi8nz439iHgFFGG7TsGo6RfoZ1B1kZNDdqgI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyuXQQVXjcnWPK7ZzmTnD2AxR8qf4RBE6r6wl9dlT7ug/PFcGrG
	CUVWAG7M3CT/8r7SgCLErsCUoq/+yf8w/2WOQ20J9SS8A3XX0cWp5aBH0hR8nHZKDzQ=
X-Gm-Gg: AeBDietK88yzPHcHmSySYry0aT0Kn/Wag74a/gTVj0QyOkKxtWWIQXgSvdo/1DDzA5r
	2EOJzhzG3Jt3KKGXiN5n74/T2s6vW7F4TGEtJFD5xy/R8izzhrcS07CmXNUUXtgFaRDe2WBr254
	xv+l1MxBOrRTeKNw9Dih/kdxoY+Z+sOQitF7NyKb5Rswa/J6AkctGDG+VQDzEgTpbZaFxrwk1lW
	QIsOZbNQqqNsHFVMQKa7rhfE/ts0I4X9Q6S2zPTDWkDXRl8wz4gEY89XywrchBlRdMwmE/CG/Y6
	0nuAmLFxl7wdj4W3hmAyLd7l5vNLjp3YfsmXbaXHpfFaEaU5WyLEgvJGJUJj1FIUUIUCpsQlMnM
	UHcqhzVcVYiWKNaeeMF4zyqZVltBQtJ05e0Gs8xL6VjxVW1m7C/ZUL3StvV3Fftg3v00yL9+Ldy
	VaIuPAYhBUSy47ITf3MgvbAKjNQlFRbAoR4JkZDOM9dic=
X-Received: by 2002:a17:90b:1e49:b0:35d:9d5d:10bb with SMTP id 98e67ed59e1d1-35de57b10a3mr7106976a91.0.1775393733924;
        Sun, 05 Apr 2026 05:55:33 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:55:33 -0700 (PDT)
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
Subject: [PATCH 20/49] mm: rename vmemmap optimization macros to generic names
Date: Sun,  5 Apr 2026 20:52:11 +0800
Message-Id: <20260405125240.2558577-21-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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

In preparation for unifying the vmemmap optimization paths for both
DAX and HugeTLB, rename the existing vmemmap tail page macros to
more generic, semantic-based names.

The original names (e.g., VMEMMAP_TAIL_MIN_ORDER) fail to clearly express
the actual requirement: it represents the minimum order of a folio that
can satisfy the vmemmap optimization. To provide a broader and clearer
abstraction for other users like DAX, replace them with newly introduced
macros like OPTIMIZABLE_FOLIO_MIN_ORDER and NR_OPTIMIZABLE_FOLIO_SIZES.

These new macros, along with OPTIMIZED_FOLIO_VMEMMAP_PAGES,
OPTIMIZED_FOLIO_VMEMMAP_SIZE, and OPTIMIZED_FOLIO_VMEMMAP_PAGE_STRUCTS,
are explicitly bound to the 'folio' concept. This systematic naming
makes it clearer to describe the properties of a vmemmap-optimized
folio rather than just raw pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h | 18 ++++++++++--------
 mm/hugetlb_vmemmap.c   |  6 +++---
 mm/sparse-vmemmap.c    |  4 ++--
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8ee9dc60120a..378feaf4e4ed 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -107,13 +107,15 @@
 	 is_power_of_2(sizeof(struct page)) ? \
 	 MAX_FOLIO_NR_PAGES * sizeof(struct page) : 0)
 
-/*
- * vmemmap optimization (like HVO) is only possible for page orders that fill
- * two or more pages with struct pages.
- */
-#define VMEMMAP_TAIL_MIN_ORDER (ilog2(2 * PAGE_SIZE / sizeof(struct page)))
-#define __NR_VMEMMAP_TAILS (MAX_FOLIO_ORDER - VMEMMAP_TAIL_MIN_ORDER + 1)
-#define NR_VMEMMAP_TAILS (__NR_VMEMMAP_TAILS > 0 ? __NR_VMEMMAP_TAILS : 0)
+/* The number of vmemmap pages required by a vmemmap-optimized folio. */
+#define OPTIMIZED_FOLIO_VMEMMAP_PAGES		1
+#define OPTIMIZED_FOLIO_VMEMMAP_SIZE		(OPTIMIZED_FOLIO_VMEMMAP_PAGES * PAGE_SIZE)
+#define OPTIMIZED_FOLIO_VMEMMAP_PAGE_STRUCTS	(OPTIMIZED_FOLIO_VMEMMAP_SIZE / sizeof(struct page))
+#define OPTIMIZABLE_FOLIO_MIN_ORDER		(ilog2(OPTIMIZED_FOLIO_VMEMMAP_PAGE_STRUCTS) + 1)
+
+#define __NR_OPTIMIZABLE_FOLIO_SIZES		(MAX_FOLIO_ORDER - OPTIMIZABLE_FOLIO_MIN_ORDER + 1)
+#define NR_OPTIMIZABLE_FOLIO_SIZES		\
+	(__NR_OPTIMIZABLE_FOLIO_SIZES > 0 ? __NR_OPTIMIZABLE_FOLIO_SIZES : 0)
 
 enum migratetype {
 	MIGRATE_UNMOVABLE,
@@ -1144,7 +1146,7 @@ struct zone {
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
 	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-	struct page *vmemmap_tails[NR_VMEMMAP_TAILS];
+	struct page *vmemmap_tails[NR_OPTIMIZABLE_FOLIO_SIZES];
 #endif
 } ____cacheline_internodealigned_in_smp;
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 535f0369a496..d6dd47c232e0 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -495,7 +495,7 @@ static bool vmemmap_should_optimize_folio(const struct hstate *h, struct folio *
 
 static struct page *vmemmap_get_tail(unsigned int order, struct zone *zone)
 {
-	const unsigned int idx = order - VMEMMAP_TAIL_MIN_ORDER;
+	const unsigned int idx = order - OPTIMIZABLE_FOLIO_MIN_ORDER;
 	struct page *tail, *p;
 	int node = zone_to_nid(zone);
 
@@ -828,7 +828,7 @@ static int __init hugetlb_vmemmap_init(void)
 	BUILD_BUG_ON(__NR_USED_SUBPAGE > HUGETLB_VMEMMAP_RESERVE_PAGES);
 
 	for_each_zone(zone) {
-		for (int i = 0; i < NR_VMEMMAP_TAILS; i++) {
+		for (int i = 0; i < NR_OPTIMIZABLE_FOLIO_SIZES; i++) {
 			struct page *tail, *p;
 			unsigned int order;
 
@@ -836,7 +836,7 @@ static int __init hugetlb_vmemmap_init(void)
 			if (!tail)
 				continue;
 
-			order = i + VMEMMAP_TAIL_MIN_ORDER;
+			order = i + OPTIMIZABLE_FOLIO_MIN_ORDER;
 			p = page_to_virt(tail);
 			for (int j = 0; j < PAGE_SIZE / sizeof(struct page); j++)
 				init_compound_tail(p + j, NULL, order, zone);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 3fdb6808e8ab..9f70559df4e8 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -330,12 +330,12 @@ static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *
 	unsigned int idx;
 	int node = zone_to_nid(zone);
 
-	if (WARN_ON_ONCE(order < VMEMMAP_TAIL_MIN_ORDER))
+	if (WARN_ON_ONCE(order < OPTIMIZABLE_FOLIO_MIN_ORDER))
 		return NULL;
 	if (WARN_ON_ONCE(order > MAX_FOLIO_ORDER))
 		return NULL;
 
-	idx = order - VMEMMAP_TAIL_MIN_ORDER;
+	idx = order - OPTIMIZABLE_FOLIO_MIN_ORDER;
 	tail = zone->vmemmap_tails[idx];
 	if (tail)
 		return tail;
-- 
2.20.1


