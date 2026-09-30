Return-Path: <linuxppc-dev+bounces-28563-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79B7CA5FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 14:07:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvxhK1mmhz30DH;
	Thu, 01 Oct 2026 00:07:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790777265;
	cv=none; b=L/HDb6VZj4C/76bFYvkjiIpxwGgSxeJsm1+OB5PUrRLnWLWsxVj+o+0UKLeKoWVxPYJwY952mSq2w01ZIwb9lmAzL7gIZ/eLy5uaB0rWb/BqFbeumkyY9uHv/KL5qgX6pgxoTT0RViDT6I4qRp+9ewjY6SXJUJIgl0uj7sLISQir4IghVe31asGO9aLWPqwHr6EfOaHDBFt5ddxas7LgP6SGt1tsf3kZ+PiIYY57WaHHlCTFT80vPXm+Twcs+2tddRdyQ1iulV1WeNKYWo0L/DIuQD9J1cg65mUdTaJyIARW1tvYp1KgqsXewHg/KYmWwQ6wDnhDfODAtwh59WT4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790777265; c=relaxed/relaxed;
	bh=LYQdJhIScJUHBWMaKSahvl3m7trT5SiIAd3TYhaGkKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbq4s8c16x2LKhrJX7+dHwG8A/ZfpHWW/a0mB4AtKQEgxlUX2IYjwgjJMmEkfBQdi8yPX8OOWny60QBZ+YATJmr9oQaQnzsyZ5yHO4OzfjHzhdWqNu9bZmIdOrSJvqHFGfriPlJWUakc3qNfU8xhPTDZQJ95aEJDT/IuRsLe8cnGfPJV5TRn62xhkNNOsXCCmo5lES3QP2abEooH4mWk8fEb/Y9rnoN2NDsQn61c5/BHMXldvKSZWaqy8dEkvSluKQRZM7elQRww0jinX1rtjHYqCdgVxlPbKl58sIhnFPvcJxe6QbfrZTNV6RcCi2I0itbttqcABOLJBm3zHiqFeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=E8Y3e9c+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::e; helo=mail-pj2-x0e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=E8Y3e9c+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::e; helo=mail-pj2-x0e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0e.google.com (mail-pj2-x0e.google.com [IPv6:2607:f8b0:4864:39::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvxhJ3qJLz308f
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:07:44 +1000 (AEST)
Received: by mail-pj2-x0e.google.com with SMTP id 98e67ed59e1d1-396ccda24afso2790409a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790777262; x=1791382062; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LYQdJhIScJUHBWMaKSahvl3m7trT5SiIAd3TYhaGkKU=;
        b=E8Y3e9c+sPqMFNaeFH55sErl29pIlpxMY4LrfUTwNBgK+eJu0J4UauFowLdIJ7zGqY
         OWtlzKd2jPclApnWBl3O8iBZyyeIpAy/4RWNgkvsi9AtSkPvUQbcx1pDrDGghWbkG74V
         79cy2ranEVO1nV0zLVJTOgPcKPIg5bA4uSZEA3ikv1lp3CfP5krogKlhPLlU5IIMzsrD
         WaCd8hwGuvDeL3qVe5IjhaqAaHTqrsShQcRx6f2w+L0SJU4Cks5kP/Mt9mV4Qn989WMs
         wj9PBQaZDEfnhge8WyjvShYJ3gae5Q1olUuhi7sO2VRjpYYA3iutVKt0kpGLNaZhwIMB
         H+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777262; x=1791382062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LYQdJhIScJUHBWMaKSahvl3m7trT5SiIAd3TYhaGkKU=;
        b=JLGb8aOPXv/6S3nisP6Ks35eHMklOJ8UtMClf21aI1w1wJlWhOOjDTfSDSHR0TTA6l
         QMF6p2m6GHzVmG24So/IVGuRicoWuoLFvJC41+Odheros69RREsweVNtOpm/mcW1A0i8
         62q7byjkPB5uTWX8Il9waxO+6dNxzoOyiUvcr6gBN9nji1VIkxrwR85eS+B6ED6U7vuV
         h1MUe8vTLT9rt9UQ/rcBY6rWtP4dv2TpSEec529JHhf/Agx6daHg0NoKiH2a1FdEhdCB
         kpaT7o8R/UGhfZpO5kZiWfrevHcM5PVu3gEperilTJjIlhAlWdGsv8d4HGPkEeCymkAY
         nTOg==
X-Forwarded-Encrypted: i=1; AKwUvByDgNRI6ilxjxFZTvxXtwMuDri9DpqC5wqZLwAnlEfqhVzXx1LnhiGkToAjlkhcEehGDeKxEuk4VKX8IVo=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI6yThTl8TSk7KSbYIyykVFQawKNvXdTa2JsdvhBEOoxw9lrULs
	L3QGS3KCaZvlApB2Bvoh+mhtZnXclAqbkPhoAaDeujhc+9CodplqfNul5d54iDUR/qk=
X-Gm-Gg: AYBFou0LxQ17eIX6AwWRZXYIJTzxgZPj/ZsZEd4ygitxabm1e/UyixtPFKcQohr28E0
	5CJEBrtciOUoHudvSC/u2K7ZaueH5z/C6aYWeqCt6ohok6Q6gYRqu/zA2fsLHEmXg6BQD9LzjJl
	puE6/Dv8NhZtJ4cUOTJV+giXCaCr3dc9OYSvQZbTYXcH48yIJUX8xjkdUrwFVmwSjBjGPRqUXbA
	7WYhwRWioRKndqLBWnLHpcQMJ7YZBBJqKLdwr7BWyUi1KEoYF2ZA+INNEIOoP+PA00Jj3IGUtF8
	uhMkGvS80MpG2cOpzlnlm4y+Qvm2nWvP/84T4Q42KWTFvzupRzKCwmimkCi5jvQdsBp29phgt9D
	0+fxODyW45mMwbOusfp6suzr3xIETI2kkxe5u3dHmjVhyGTCECsDvKTQGLjfIoBOY8RCbM5rErs
	PF2ulnVddZgqu3wqxbWZFM+O2AxrSoyNggNKlWcY2jywEh49sQZxwMb2oAoottTYod3VCPM8DXQ
	d/Brp0vJItZhg==
X-Received: by 2002:a17:90b:574b:b0:39e:6c68:1550 with SMTP id 98e67ed59e1d1-3a4d152ef8dmr727985a91.24.1790777262347;
        Wed, 30 Sep 2026 07:07:42 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4e60ea12csm639509a91.1.2026.09.30.07.07.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 07:07:41 -0700 (PDT)
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
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v6 03/12] mm/sparse-vmemmap: introduce CONFIG_VMEMMAP_OPTIMIZATION
Date: Wed, 30 Sep 2026 22:06:18 +0800
Message-ID: <20260930140627.57431-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930140627.57431-1-songmuchun@bytedance.com>
References: <20260930140627.57431-1-songmuchun@bytedance.com>
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
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
v6:
- Collect Acked-by from David Hildenbrand

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
index 0ace48268095..6916a3690778 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -169,7 +169,7 @@ static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
 	return p;
 }
 
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+#ifdef CONFIG_VMEMMAP_OPTIMIZATION
 #define VMEMMAP_OPTIMIZATION_NR_ORDERS	(MAX_FOLIO_ORDER - VMEMMAP_OPTIMIZATION_MIN_ORDER + 1)
 
 static __ref struct page **vmemmap_tails(struct zone *zone)
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


