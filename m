Return-Path: <linuxppc-dev+bounces-28295-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280C6C9833E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 02:55:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hspvd0xt0z30Wd;
	Sun, 27 Sep 2026 12:55:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::2b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790477709;
	cv=none; b=L5byv+8ku7H7q5CxgLDvcLQ8wxI7Y0OIfwNM476Q3+L/Lxq+kTzGyrANwDFwCjrKQFQzQTbEkEWx9IFiooQVoNuFXAVwaQoO7jXCjeetn9J4ooGJp6GKW4G6ghpZgqSujap7DFOs2O/KOXASZ12EumdLB5cTdJoSx+pN7e4ZlteCtS87miDJVEvWnYoKXZIeprTfMvemJomn8TSYHu+AABtjqH60gDFZf/2/a/f0mwi9SJJ9x3bL/z1in3lL6jRPfCppfwsnM2KlURoCp6KaXH4XVQuKKbKs1/a9SJH/LwEQXAN4VAt/VKoKmZd7a3UPXXMQN7p3l06sCz1hNSLeiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790477709; c=relaxed/relaxed;
	bh=BS5o+gJrZMstILSVwOeeCwCCqKRIe2kUlRPqsjqyE2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuJEptjjYuJzE6zTHq3clsxzPn/OACyJnSE3zc3tqCPQ1/3wtx/q+MqHTkUxph/n782mVa32sS+TjlKq26DhrXHWcdJWJJbIF9GUQofxebLCk9QuQkUZeJL+9opJ2+9zV/ibfw8sFXrmUSGhc31h9AlaynZopDGGW7UrZmdLOFWB90I6mysp6E6zNgR0iZ7tNgFaf5X3Xv+OQeHyBBcrH0BpEd+mW0lyMzVufhkh68xbE3pfcMTELt8Il20Gxk1lPGtrEcY2fE/bnCRf6h+ibrhuvY+j05jVOAT8BUR/5Ls1Jlt5yqEb6tbymcXdprmmWvd1nhqEsoQp6wOHw7FvEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LoFrOzt/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::2b; helo=mail-pz2-x2b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LoFrOzt/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:3b::2b; helo=mail-pz2-x2b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x2b.google.com (mail-pz2-x2b.google.com [IPv6:2607:f8b0:4864:3b::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hspvc2Xj1z30Vs
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 12:55:08 +1000 (AEST)
Received: by mail-pz2-x2b.google.com with SMTP id d2e1a72fcca58-88098dbba5fso250399b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 19:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790477706; x=1791082506; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BS5o+gJrZMstILSVwOeeCwCCqKRIe2kUlRPqsjqyE2w=;
        b=LoFrOzt/hOdHYPhDKKF3EF/mseoj08eK4agO7KHp0eSyogeZ1OMgQ//EQDLdvQy4o+
         mZxLzVHt3I2CLmWuicCWN0Szd9wrh5yV2o+UE9JNQgDa9eLMZVocBlPG/RIl6y6fsnaS
         WYT7bZLzMabcJpnWZ+mxbiS3D9P2w6US/qse01YXwCgHX0Ka+DDaIthR/cbVgjBcrpOR
         0DhIGnQf4v3N9x2L8i01GOghxxD257yEVwPL1IMZGl/f9ASubuhs7s3rn064SFi3ZZ7g
         3gGwbmbaJJtjVkoaJJOTLQOBnnbA6eMeB5g4aOgPhwBr5pcx4wquBygTaSh9UX1EGC/k
         5yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790477706; x=1791082506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BS5o+gJrZMstILSVwOeeCwCCqKRIe2kUlRPqsjqyE2w=;
        b=wWe8gujql2+OJehTenFrzje2Qu9V9EcUwhbBLuBux3cSqAgyylPQ6wxus3vyCweYJX
         Nx/0dqiyU7h+cCdRoODNczsQteLrMqW0gTbifLyYEeOlBx2t/6AOKkSts0wrQg/biyyl
         Th8OVVVd1EfMICGQ4fNik8YYLPDQn9xZZa1N3+sYoXMRr/deUiHuaOIkd0Q4V+cQGgs3
         TeO7Jlv7o5aoPvh5W3HH6OcZXJfbDcMAEUM5HQCt1TjJUI1c5EaDpwTj5M5P+HsycTdG
         GZn78upBIwU+7lab9Jvn2wiUPVJAFT3OX9ZiopjgpdE7EOJsTYodvT8cYkeSQ0yejvA7
         KMxg==
X-Forwarded-Encrypted: i=1; AKwUvBy3UGUG04tKqadI1APpsbOWQXphV5Myq8J8aX2c3bLW8nxEp9wyREZqwA2KdoREIQfn9t2uvwA1ful/FB4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL4lc1HOmxkds0cDgikDV+N5Zv60XQuuOg0clE2sgIxRF91bR3v
	nP+SfyrcpSAWZbNyXWh678sYYUAdpi0jtrs9JsLpyeQ+mGAjdr0kY/dA8XWZC87aMoQ=
X-Gm-Gg: AYBFou0Uuzgf22zc3Tp5qzD/2n0lkgonzLD2fSIaumQB38dDtfxr4vllmivDPam86kk
	P7ksA9jxCGXTk3lMiEGIG0esYw4X1ouUIVFQ6QrQ2N516SQkvrTRNMAQCBg5eq8AIR31bPn0nuk
	RstsGHiFqbHRgDi2xnIYQcHCtb5hKvmVd3H78uF7rRA0GRm4eBCE+erl8Ekd0nCjvETZDeQcN7b
	KIQBgcW7wFbGhVJINKLTTShr9+SPh82IifFrgM2pN+09fG/d3wkwp2f6hfyq0PTa0wlJT/NfO6w
	ADSoy+sVReqmqbA2BUxru0LphHE3St7iNxrBV2xodaMqI8hnK3Yrv2b9kG3vhtcPYPlFwMHu41e
	fsViNUTXnp4GDFu3ZD1xy5y2VYQdK1oLsR6RYVPX+Fw3Lb3RLTsMvea0JnEEZ1nL+BrFji1puxy
	QdDHH2ltPDPcNn1XwokcAdWkF1OQ47XYDnAVumQRnNVYREGhRc8inZujovUzxmOCwTeXvIWfNB7
	tGgvyOOqWIvbfw/FZx3
X-Received: by 2002:a17:90b:2809:b0:39e:4c7e:bc3 with SMTP id 98e67ed59e1d1-3a0986a46b9mr6089057a91.17.1790477706208;
        Sat, 26 Sep 2026 19:55:06 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm13461377a91.1.2026.09.26.19.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 19:55:05 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v5 03/12] mm/sparse-vmemmap: introduce CONFIG_VMEMMAP_OPTIMIZATION
Date: Sun, 27 Sep 2026 10:54:32 +0800
Message-ID: <20260927025441.741633-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260927025441.741633-1-songmuchun@bytedance.com>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
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

The section-based vmemmap optimization infrastructure is guarded by
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP, but it can also be used by
ZONE_DEVICE users that set dev_pagemap::vmemmap_shift. Introduce
CONFIG_VMEMMAP_OPTIMIZATION as a common config for the shared
infrastructure.

Select the new option from HUGETLB_PAGE_OPTIMIZE_VMEMMAP and from
ZONE_DEVICE when the architecture opts in to DAX vmemmap optimization,
and use it to guard the generic sparse-vmemmap state and helpers.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
v5:
- Move this patch after the shared tail-page factoring.
- Select VMEMMAP_OPTIMIZATION from ZONE_DEVICE instead of DEV_DAX,
  covering all users of dev_pagemap::vmemmap_shift, reported by
  Sashiko.

v4:
- Rename SPARSEMEM_VMEMMAP_OPTIMIZATION to VMEMMAP_OPTIMIZATION
  (suggested by Mike Rapoport)
- Collect Acked-by from Mike Rapoport

v2:
- Fix SPARSEMEM_VMEMMAP_OPTIMIZATION being selected without SPARSEMEM_VMEMMAP
  reported by Sashiko.
- Add an explicit DEV_DAX dependency on ZONE_DEVICE
- Collect Acked-by from Qi Zheng
---
 arch/x86/entry/vdso/vdso32/fake_32bit_build.h |  2 +-
 fs/Kconfig                                    |  1 +
 include/linux/mm.h                            |  3 +++
 include/linux/mmzone.h                        | 10 +++++-----
 include/linux/page-flags.h                    |  5 ++---
 mm/Kconfig                                    |  5 +++++
 mm/sparse-vmemmap.c                           |  2 +-
 mm/sparse.h                                   |  6 +++---
 8 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32/fake_32bit_build.h b/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
index bc3e549795c3..72a92cb9b53d 100644
--- a/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
+++ b/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
@@ -11,7 +11,7 @@
 #undef CONFIG_PGTABLE_LEVELS
 #undef CONFIG_ILLEGAL_POINTER_VALUE
 #undef CONFIG_SPARSEMEM_VMEMMAP
-#undef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+#undef CONFIG_VMEMMAP_OPTIMIZATION
 #undef CONFIG_NR_CPUS
 #undef CONFIG_PARAVIRT_XXL
 
diff --git a/fs/Kconfig b/fs/Kconfig
index d1c210c6508f..1454b7fe9641 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -278,6 +278,7 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	def_bool HUGETLB_PAGE
 	depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	depends on SPARSEMEM_VMEMMAP
+	select VMEMMAP_OPTIMIZATION
 
 config HUGETLB_PMD_PAGE_TABLE_SHARING
 	def_bool HUGETLB_PAGE
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c49ef99b4413..070ce27e9cd3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5175,6 +5175,9 @@ static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
 	unsigned long nr_pages;
 	unsigned long nr_vmemmap_pages;
 
+	if (!IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION))
+		return false;
+
 	if (!pgmap || !is_power_of_2(sizeof(struct page)))
 		return false;
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 68807ff7f946..ee9cbaaa63f4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -102,9 +102,9 @@
  *
  * HVO which is only active if the size of struct page is a power of 2.
  */
-#define MAX_FOLIO_VMEMMAP_ALIGN \
-	(IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP) && \
-	 is_power_of_2(sizeof(struct page)) ? \
+#define MAX_FOLIO_VMEMMAP_ALIGN					\
+	(IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION) &&		\
+	 is_power_of_2(sizeof(struct page)) ?			\
 	 MAX_FOLIO_NR_PAGES * sizeof(struct page) : 0)
 
 /* The number of retained vmemmap pages with HVO enabled. */
@@ -1150,7 +1150,7 @@ struct zone {
 	/* Zone statistics */
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
 	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+#ifdef CONFIG_VMEMMAP_OPTIMIZATION
 	struct page **vmemmap_tails;
 #endif
 } ____cacheline_internodealigned_in_smp;
@@ -2014,7 +2014,7 @@ struct mem_section {
 	unsigned long section_mem_map;
 
 	struct mem_section_usage *usage;
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+#ifdef CONFIG_VMEMMAP_OPTIMIZATION
 	/*
 	 * Normally, sections hold regular (order-0) pages. However, for
 	 * sections with HVO enabled, this tracks the compound page order
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 86dd0470da11..7080a6a1a79e 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -208,14 +208,13 @@ enum pageflags {
 static __always_inline bool compound_info_has_mask(void)
 {
 	/*
-	 * Limit mask usage to HugeTLB vmemmap optimization (HVO) where it
-	 * makes a difference.
+	 * Limit mask usage to HVO where it makes a difference.
 	 *
 	 * The approach with mask would work in the wider set of conditions,
 	 * but it requires validating that struct pages are naturally aligned
 	 * for all orders up to the MAX_FOLIO_ORDER, which can be tricky.
 	 */
-	if (!IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP))
+	if (!IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION))
 		return false;
 
 	return is_power_of_2(sizeof(struct page));
diff --git a/mm/Kconfig b/mm/Kconfig
index bc7befafb47b..30170a936f1f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -461,6 +461,10 @@ config SPARSEMEM_VMEMMAP
 	  pfn_to_page and page_to_pfn operations.  This is the most
 	  efficient option when sufficient kernel resources are available.
 
+config VMEMMAP_OPTIMIZATION
+	bool
+	depends on SPARSEMEM_VMEMMAP
+
 #
 # Select this config option from the architecture Kconfig, if it is preferred
 # to enable the feature of HugeTLB/dev_dax vmemmap optimization.
@@ -1220,6 +1224,7 @@ config ZONE_DMA32
 config ZONE_DEVICE
 	bool "Device memory (pmem, HMM, etc...) hotplug support"
 	depends on MEMORY_HOTREMOVE
+	select VMEMMAP_OPTIMIZATION if ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 	select XARRAY_MULTI
 
 	help
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 46d9a25b3275..38c36399f53e 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -169,7 +169,7 @@ static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
 	return p;
 }
 
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+#ifdef CONFIG_VMEMMAP_OPTIMIZATION
 #define VMEMMAP_OPTIMIZATION_NR_ORDERS	(MAX_FOLIO_ORDER - VMEMMAP_OPTIMIZATION_MIN_ORDER + 1)
 
 static __ref struct page **vmemmap_tails_alloc(struct zone *zone)
diff --git a/mm/sparse.h b/mm/sparse.h
index 6e7aaeaa5594..326ad43bb5c3 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -10,7 +10,7 @@
 
 #include <linux/mmzone.h>
 
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+#ifdef CONFIG_VMEMMAP_OPTIMIZATION
 static inline unsigned int section_compound_order(const struct mem_section *section)
 {
 	return section->compound_page_order;
@@ -75,7 +75,7 @@ static inline bool vmemmap_optimizable_pfn(unsigned long pfn)
 
 static inline bool vmemmap_optimizable_order(unsigned int order)
 {
-	if (!IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP))
+	if (!IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION))
 		return false;
 
 	if (!is_power_of_2(sizeof(struct page)))
@@ -142,7 +142,7 @@ static inline void sparse_sections_init(void) {}
  * mm/sparse-vmemmap.c
  */
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+#ifdef CONFIG_VMEMMAP_OPTIMIZATION
 struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
 #endif
 void sparse_init_subsection_map(void);
-- 
2.54.0


