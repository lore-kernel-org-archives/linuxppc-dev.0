Return-Path: <linuxppc-dev+bounces-27458-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977E2C982C4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 06:44:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl8Vm1RlRz2yYf;
	Wed, 16 Sep 2026 16:44:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789541040;
	cv=none; b=LUsygJMT8edXQwh2hBoj9sCJRxMnUgWkfAjcsahcgKLLAA4zaYJAiDwd7PdKJbhQqPtwyz9sprqIhXSKvPH4i3nH6/oq0W+ZcfnBOyp5ZeEnh5fDvc/4vcCyg9IXbwPrfEWPzZs8jeC9UCdoWxhUAJBAFu16eG2seIkkNTR/pcKGiiN9xuoIlPuK/Owt8+NO3nHV33CJYtguEzPXQXuwMZEk2RYkl9L/eLYddUje6IwK/7K6Y0jGd5n5ZCBlQcEsUz06jsvBdJvPouitPNT1YOjk2foSNe5gRwXdBURhPFq+MXYUHNk/vIPBMbdvKNA26l4smboejrZrPSamQVUuHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789541040; c=relaxed/relaxed;
	bh=1OKh9ewKICcZ4B1bMy6j7dzmXfE4aXD+pSJoYMr6des=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDC3TNHqN4RU52BeVQLBeXO8D1PzsiM0z8DNARXnDndo0QGqwIfN8MWT2ooNKWU3kwKPX9Edh0hPmPhjWJQIWNdX8TDdLPqrSOQfPe+dwoTGR8xl4AZz+ug9XHs97QYJcURvLPD23bA7hnp1Hx+EFpjTQAu7Qa6FZ1riYiSycCUE4nqVjUcnneMBUFoRnCvmhQZYjPYys8lSYADLavW/2MaMsoIVbYjpWpXtNt7OKTB7as8LfLhRc55Fy0vkttyOiCEB/gyds+OkOnb99SwrHVVMedWjZXLcZhcV4Bn5E0yzyaFU5lguD88StgRHvcqNIVFHOYpshA6x/b9JzOXagw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KVOdfqk+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KVOdfqk+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com [IPv6:2607:f8b0:4864:39::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl8Vj6m8rz2y2Q
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:43:56 +1000 (AEST)
Received: by mail-pj2-x0f.google.com with SMTP id d9443c01a7336-2d90ba1d807so6831705ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 23:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789541034; x=1790145834; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1OKh9ewKICcZ4B1bMy6j7dzmXfE4aXD+pSJoYMr6des=;
        b=KVOdfqk+EhAQJdz/hQb3gYnIknroVX/qwgGUFTUxM5pP+uBeTlFaky6D+hJOOTVTtO
         2eJ0TZZ0Gf/PtsSaNn9MAFBlU/7x33ZJ/Rx+/o9w4EQVv/VvMRj4FNjiJG5eh/wYdvnu
         YtRrxaHufWxD1zVZKreGuWU6murxgZEPxc6eQmJi1G2mk/lUOJYoJ/fV5DjoImjwApC8
         tDZbQPZpsRjN6EAfQsfOWDX2iwF7T2Hn0xnLgEAKKhFnNW9oJXUEUAnzBoV74RgopHx2
         YTWqwBbMws7+cXsrKD9DAOdKrfuwu6NBbkO7OS+RVhHgV8mvMQCmiD4azj8DNNUh+pSr
         KTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541034; x=1790145834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1OKh9ewKICcZ4B1bMy6j7dzmXfE4aXD+pSJoYMr6des=;
        b=lkMGc2zvdiC9Re5VwxHS+wkp2k1Y9lj1TKMi27lgVA7YAO+NRX4OMmjyh4s6U58wFS
         slFC3Ea4hkSonaF4xmPp+Bzmhb0R3OuYbfO+rLs+073HNWwRyEchAHmy5zxUHODxWL+C
         gSoOLMs+0m3/ZEf0eQoFkvFv5CrG0tmlZLxvylMtHTIi0/d4SgFIrHBTeNwFvNQSRHIZ
         qmq09LhQr6r1L7GKGcsssgKP7UnrFZeMkPCo1omeKUOAi0rQKWtrNpMEdxZF1w1gdwBK
         nKwI0Sn5bLNvHaq6y6omaJo5JH7qdKSedMjYD3iswz/3iStamhC3YNkEAPfDfFTaJHck
         oljA==
X-Forwarded-Encrypted: i=1; AKwUvBwOtl04R6E85M2cMOtGRQjmbrNGXh06Dzw+0TSn27qy5gv4YWrNDBLpo7ZOCgYgDlpi8y1uEJBBFMfM23Q=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n/uo2h/VC+Oh3DPQnhx+TMHFKgw41Lu8+OOZU72nxy6X/Xs7Cx
	C89DWFEj+4iULGX4QrtRGXIcRa8qW5mJgWWf2Wq5fKWe+TKaFc5bTsuvD6VJ0FOGMBM=
X-Gm-Gg: AYBFou0fdGfICklpXrkERi/zHnaZng9wCjueVDtEpOiNusbPapVlp3DYkRZo/8LTMhh
	utoWv1SXdYW9x1VeMmi6io75KBgW2Ilhj1MfM0VSod1o1bMNzUv7PTYpwQ7SZMZmknyRDGqrE7i
	hkb/N7Tis2cdQdgs5q61O6SqJl+xVWmFHgvCdeES97OmpUt8WSUXNiUFqIi++P6oFFTzhy+zkSw
	SLozu5gCXbZpgTyTjl8M9psQjBcFDkWx8yWF0VgcH2wF80i1blddciNBbnRJ19jz9h/po3so1yu
	1CgR8MiQQOansAXYgU2rVSSjpWFCOOT/MwGMsTBBTKkzEB/NSFXSQgAYDn9cSFFd9zjEHK1Af7D
	lo2KJfkXJZfET5S9aCqyWquxXSQV1zxjqsCjg8YeVPWPu6ZcNGNGTA6+x5cdKQryH5AP4dJ+XND
	eiJ/K+0cpNzzsnTEPD3hiFPWqO9+WXLRL0gH+y5fPqab8mRufQnNdTd6vQVOKeLIZq/3OEn0fNH
	aYDVUs5X1ORkttMJZiHeGYO/YBwdA==
X-Received: by 2002:a17:903:1983:b0:2d9:4871:393d with SMTP id d9443c01a7336-2dd8e77e51fmr32018845ad.21.1789541034351;
        Tue, 15 Sep 2026 23:43:54 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f0592asm6074755ad.62.2026.09.15.23.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:43:53 -0700 (PDT)
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
Subject: [PATCH v4 01/11] mm/sparse-vmemmap: introduce CONFIG_VMEMMAP_OPTIMIZATION
Date: Wed, 16 Sep 2026 14:43:31 +0800
Message-ID: <20260916064341.1825793-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916064341.1825793-1-songmuchun@bytedance.com>
References: <20260916064341.1825793-1-songmuchun@bytedance.com>
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

The section-based vmemmap optimization infrastructure is still guarded by
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP, but it also can be used by device
DAX. Introduce CONFIG_VMEMMAP_OPTIMIZATION as a common config for the
shared infrastructure.

Select the new option from HUGETLB_PAGE_OPTIMIZE_VMEMMAP and from
DEV_DAX when the architecture opts in to DAX vmemmap optimization, and
use it to guard the generic sparse-vmemmap state and helpers.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
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
 drivers/dax/Kconfig                           |  2 ++
 fs/Kconfig                                    |  1 +
 include/linux/mm.h                            |  3 +++
 include/linux/mmzone.h                        | 13 +++++++------
 include/linux/page-flags.h                    |  5 ++---
 mm/Kconfig                                    |  4 ++++
 mm/sparse.h                                   |  4 ++--
 8 files changed, 22 insertions(+), 12 deletions(-)

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
 
diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index 602f9a0839a9..f50c6b32d826 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -8,6 +8,8 @@ if DAX
 config DEV_DAX
 	tristate "Device DAX: direct access mapping device"
 	depends on TRANSPARENT_HUGEPAGE
+	depends on ZONE_DEVICE
+	select VMEMMAP_OPTIMIZATION if ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 	help
 	  Support raw access to differentiated (persistence, bandwidth,
 	  latency...) memory via an mmap(2) capable character
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
index acd94cecc0d3..56403841e887 100644
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
@@ -116,7 +116,8 @@
 #define __VMEMMAP_OPTIMIZATION_NR_ORDERS	\
 	(MAX_FOLIO_ORDER - VMEMMAP_OPTIMIZATION_MIN_ORDER + 1)
 #define VMEMMAP_OPTIMIZATION_NR_ORDERS		\
-	(__VMEMMAP_OPTIMIZATION_NR_ORDERS > 0 ? __VMEMMAP_OPTIMIZATION_NR_ORDERS : 0)
+	((__VMEMMAP_OPTIMIZATION_NR_ORDERS > 0 &&	\
+	  IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION)) ? __VMEMMAP_OPTIMIZATION_NR_ORDERS : 0)
 
 enum migratetype {
 	MIGRATE_UNMOVABLE,
@@ -1155,7 +1156,7 @@ struct zone {
 	/* Zone statistics */
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
 	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+#ifdef CONFIG_VMEMMAP_OPTIMIZATION
 	struct page *vmemmap_tails[VMEMMAP_OPTIMIZATION_NR_ORDERS];
 #endif
 } ____cacheline_internodealigned_in_smp;
@@ -2019,7 +2020,7 @@ struct mem_section {
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
index bc7befafb47b..0fa2eb76e4f2 100644
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
diff --git a/mm/sparse.h b/mm/sparse.h
index d3a71ef4fad0..d8c08a388e4e 100644
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
-- 
2.54.0


