Return-Path: <linuxppc-dev+bounces-19379-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0BDF3D5E1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:59:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXb84Kxnz3093;
	Sun, 05 Apr 2026 22:59:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393940;
	cv=none; b=kOQpC0+FNBQt0iA5IEf2eYGbo0vF8q7yGIN58ubs0PuAeyJJNoO5ItrBqcK71TzLugmbu57BfEN+dDwoR423x0Oxo92Q8aqh91td4BOsxYLGodY6ut1LHtEF0JgCDb+pfUJLGGWQH5iB5nRVUGNcSXd3P1ni8Hb+40oC+/i1UA3msaQCo6t9OKm/yXbrOhk6sL3bF5qQT3n36A4jUJhKxc7iaxsd5jsrdwrw1AcfoRdbc6GS3h8wRH2q9cM+bdte7FX9EzENQuVm2mTFAQJdynz8luOEYy9z/7kcE1ctNqRvrL7pVJta9pXEO1U71oEj6ixNHeCOPZ79791aMzLp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393940; c=relaxed/relaxed;
	bh=5OTMoz77Yb7VHAB553cXlMYhsYoA1Jus+1lDf2tDpdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9mSWS8SYioPqLBhrWLKuWdqngqYOpCcA1Gx8YMGhZktbY8EHYqgqO7yXikLbP6B3piYXE7j/WnpvEdYiD6t5sQ+b3MSAEzMPdseUu2VNSoOkyr2e9cUBYXpuWHNJLmIvRR2E8wJ8pUR3X+Ki49hGzokWosWtKsUcaPSmvM6aVIBQEvmW5tbnlWnNcCN0YLaevihdBnO7NzKWBnFYCYsZfViWn9NzyN0S354NWmPDLgq8j1tZQcdhbzgwREU3j0SQ+zG0B4iMvZnmPA3lmZQfADG0cTG0+VXP9FH4W8xbPWG9VZHiYcGm3CvT9mar626yabMvOMwzNDWFpqFvvB75A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Ztpm31+s; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Ztpm31+s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXb759Hqz3069
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:58:59 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so2064940a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393938; x=1775998738; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OTMoz77Yb7VHAB553cXlMYhsYoA1Jus+1lDf2tDpdk=;
        b=Ztpm31+smr6/8ppB7M3Y5ScID2YptBeEwyyySnoBS1fslL0v+bMjLjDLqxQgYexaps
         s2sriB7Z7yxrhzXxw0LXdY7CZK77ZFu0rOkZs5KtrE22aq9+yHOQkW5rjw3lK52gGrkr
         MF6RT1C+13qEjwVMq5r8BN5mpxxodWpIw6VSeiKOFTumDE2MxWbMYIpE1edDDMyWyVri
         2XMyjRZyVnmqpoxGjX59FzRp1baMPjyUSfsirPsE0JFCdfkXRWffgwYFI1Pt6D1S5684
         rbeh9aZ/ix3AVVuoBLX5IMTsnAMLCkvRz3tFB/GL3j+GAcxUhlYbQ/kv/Jfq5tyfM2Ut
         jmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393938; x=1775998738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5OTMoz77Yb7VHAB553cXlMYhsYoA1Jus+1lDf2tDpdk=;
        b=ckVIPHUeDZjFPZNL14E93jg95K5YkP923xi2lXppW6Hb/5kOXCYU7ogKo3taagxdwS
         Lulr0pckzkkm05Jb4uIqmbq27w82ZXwuYL4/ajTX0JdJbHMv6Ffy/fGjHxGsLnuSommA
         5Ql4icQQr/XeGKNrNGOPfB1gpGTY36cT45+i1sShmnBrqcvNG/vc8e7YU53O5PxW3dmu
         pEKOTUnlWfQ582fYqeEVUVz/y+6LTKXFa9dujfoWMVF3DxAq3si6BBzirsGR4AdhJ35a
         utiKaSITs5aG5/SH41zzYGWbvT2SffksDn4anahEMi2K4yf01i2XPoHOkZLKPhcBMqlx
         0vYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU84zIvC5TzeybVE4ew3oO9cZAqC9OR2YZ8kYNwQdg1dEwuFC6AQfK63UfWWvFAi+Kfwi8RuPyZOjqiicU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwOpmc3DiB9HodeNwvyuFOs28z8u54TPMxX1LD0Nu0LEs5hNYvB
	8QnojppVRJHE+2OaesVEXXuObEAST4cK8MJ6BSq5Hk2VRGuSHqxQR5gTHpgNml/3824=
X-Gm-Gg: AeBDieu0k93F8buQxKmROBKmrger8/bim6l0YARhjdWjLe9enr4MuI4QJMXnN2RTtyy
	DWm1PkVzYCnoOO9143FFAd7gLtUSDZlCNCT6how/UrxUBiDDxGtwyxqMfyIVN1irucyQmRMYd3T
	WwV3oc+K4MMKDEvWYzRSD7CyZ4KTv80/oSLOYhtDt64+10lKj1YbSdLS8H0NL5wmukrakduavNr
	On1DOk8xBT9lyvZNmFhraz2IpfkzYUN2ivZMywPvK6IXRHlWge5U3cdmt+B6RKsC1jegNc4b7R3
	JnViOM+fyg3VTrg6ml8wR+krVlX63CjAtxhmLIOmZ9JxUjC1j6UyuO4tRRpizW+eUIte5z0IQq2
	B1yxJSf4Ho6weOxHPVXzhmxsdjgr5gTXuFUBpT1JPF8troDsbG9HOCQRMVzkloMGeWGYJ+wx0nQ
	2DQCRyUA6/WzaFjsBk67dEY45PgUeoPWRy3+oRZig7RdI=
X-Received: by 2002:a17:90b:2b4e:b0:356:35a5:4a64 with SMTP id 98e67ed59e1d1-35de6842dc2mr8500150a91.4.1775393937697;
        Sun, 05 Apr 2026 05:58:57 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:58:57 -0700 (PDT)
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
Subject: [PATCH 49/49] mm: consolidate struct page power-of-2 size checks for HVO
Date: Sun,  5 Apr 2026 20:52:40 +0800
Message-Id: <20260405125240.2558577-50-songmuchun@bytedance.com>
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

The Hugepage Vmemmap Optimization (HVO) requires that struct page
size is a power of two. This size is evaluated by the C compiler
and currently cannot be natively evaluated by Kconfig. Therefore,
the condition is_power_of_2(sizeof(struct page)) was scattered
across several macros and static inline functions.

Extract the check into a preprocessor macro
STRUCT_PAGE_SIZE_IS_POWER_OF_2 evaluated during the Kbuild process.

Define SPARSEMEM_VMEMMAP_OPTIMIZATION_ENABLED as a master toggle
that is 1 only if both Kconfig CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
and the power of 2 size check are true.

This allows us to completely remove all scattered sizeof(struct page)
checks, making the code much cleaner and eliminating redundant logic.

Additionally, mm/hugetlb_vmemmap.c and its corresponding header are now
guarded by SPARSEMEM_VMEMMAP_OPTIMIZATION_ENABLED. This brings an added
benefit: when struct page size is not a power of 2, the compiler can
entirely optimize away the unused functions in mm/hugetlb_vmemmap.c,
reducing kernel image size.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm_types.h      |  2 ++
 include/linux/mm_types_task.h |  4 ++++
 include/linux/mmzone.h        | 32 +++++++++++++++-----------------
 include/linux/page-flags.h    | 28 ++++------------------------
 kernel/bounds.c               |  2 ++
 mm/hugetlb_vmemmap.c          |  2 ++
 mm/hugetlb_vmemmap.h          |  4 +---
 mm/internal.h                 |  3 ---
 mm/sparse.c                   |  6 ++----
 mm/util.c                     |  2 +-
 10 files changed, 33 insertions(+), 52 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a308e2c23b82..6de6c0c20f8b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -15,7 +15,9 @@
 #include <linux/cpumask.h>
 #include <linux/uprobes.h>
 #include <linux/rcupdate.h>
+#ifndef __GENERATING_BOUNDS_H
 #include <linux/page-flags-layout.h>
+#endif
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
 #include <linux/percpu_counter.h>
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index 11bf319d78ec..09e5039fff97 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -17,7 +17,11 @@
 #include <asm/tlbbatch.h>
 #endif
 
+#ifndef __GENERATING_BOUNDS_H
 #define ALLOC_SPLIT_PTLOCKS	(SPINLOCK_SIZE > BITS_PER_LONG/8)
+#else
+#define ALLOC_SPLIT_PTLOCKS	0
+#endif
 
 /*
  * When updating this, please also update struct resident_page_types[] in
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a6900f585f9b..3a46cb0bfaaa 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -96,27 +96,26 @@
 
 #define MAX_FOLIO_NR_PAGES	(1UL << MAX_FOLIO_ORDER)
 
-/*
- * Hugepage Vmemmap Optimization (HVO) requires struct pages of the head page to
- * be naturally aligned with regard to the folio size.
- *
- * HVO which is only active if the size of struct page is a power of 2.
- */
-#define MAX_FOLIO_VMEMMAP_ALIGN					\
-	(IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION) &&	\
-	 is_power_of_2(sizeof(struct page)) ?			\
-	 MAX_FOLIO_NR_PAGES * sizeof(struct page) : 0)
-
 /* The number of vmemmap pages required by a vmemmap-optimized folio. */
 #define OPTIMIZED_FOLIO_VMEMMAP_PAGES		1
 #define OPTIMIZED_FOLIO_VMEMMAP_SIZE		(OPTIMIZED_FOLIO_VMEMMAP_PAGES * PAGE_SIZE)
 #define OPTIMIZED_FOLIO_VMEMMAP_PAGE_STRUCTS	(OPTIMIZED_FOLIO_VMEMMAP_SIZE / sizeof(struct page))
 #define OPTIMIZABLE_FOLIO_MIN_ORDER		(ilog2(OPTIMIZED_FOLIO_VMEMMAP_PAGE_STRUCTS) + 1)
 
+#if defined(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION) && STRUCT_PAGE_SIZE_IS_POWER_OF_2
+#define SPARSEMEM_VMEMMAP_OPTIMIZATION_ENABLED	1
+/*
+ * Hugepage Vmemmap Optimization (HVO) requires struct pages of the head page to
+ * be naturally aligned with regard to the folio size.
+ */
+#define MAX_FOLIO_VMEMMAP_ALIGN			(MAX_FOLIO_NR_PAGES * sizeof(struct page))
 #define __NR_OPTIMIZABLE_FOLIO_SIZES		(MAX_FOLIO_ORDER - OPTIMIZABLE_FOLIO_MIN_ORDER + 1)
 #define NR_OPTIMIZABLE_FOLIO_SIZES		\
-	((__NR_OPTIMIZABLE_FOLIO_SIZES > 0 &&	\
-	  IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION)) ? __NR_OPTIMIZABLE_FOLIO_SIZES : 0)
+	(__NR_OPTIMIZABLE_FOLIO_SIZES > 0 ? __NR_OPTIMIZABLE_FOLIO_SIZES : 0)
+#else
+#define MAX_FOLIO_VMEMMAP_ALIGN			0
+#define NR_OPTIMIZABLE_FOLIO_SIZES		0
+#endif
 
 enum migratetype {
 	MIGRATE_UNMOVABLE,
@@ -2015,7 +2014,7 @@ struct mem_section {
 	 */
 	struct page_ext *page_ext;
 #endif
-#ifdef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
+#ifdef SPARSEMEM_VMEMMAP_OPTIMIZATION_ENABLED
 	/*
 	 * The order of compound pages in this section. Typically, the section
 	 * holds compound pages of this order; a larger compound page will span
@@ -2208,7 +2207,7 @@ static inline bool pfn_section_first_valid(struct mem_section *ms, unsigned long
 }
 #endif
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
+#ifdef SPARSEMEM_VMEMMAP_OPTIMIZATION_ENABLED
 static inline void section_set_order(struct mem_section *section, unsigned int order)
 {
 	VM_BUG_ON(section->order && order && section->order != order);
@@ -2267,8 +2266,7 @@ static inline void section_set_compound_range(unsigned long pfn,
 
 static inline bool section_vmemmap_optimizable(const struct mem_section *section)
 {
-	return is_power_of_2(sizeof(struct page)) &&
-	       section_order(section) >= OPTIMIZABLE_FOLIO_MIN_ORDER;
+	return section_order(section) >= OPTIMIZABLE_FOLIO_MIN_ORDER;
 }
 
 void sparse_init_early_section(int nid, struct page *map, unsigned long pnum,
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 12665b34586c..bea934d49750 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -198,32 +198,12 @@ enum pageflags {
 
 #ifndef __GENERATING_BOUNDS_H
 
-/*
- * For tail pages, if the size of struct page is power-of-2 ->compound_info
- * encodes the mask that converts the address of the tail page address to
- * the head page address.
- *
- * Otherwise, ->compound_info has direct pointer to head pages.
- */
-static __always_inline bool compound_info_has_mask(void)
-{
-	/*
-	 * The approach with mask would work in the wider set of conditions,
-	 * but it requires validating that struct pages are naturally aligned
-	 * for all orders up to the MAX_FOLIO_ORDER, which can be tricky.
-	 */
-	if (!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION))
-		return false;
-
-	return is_power_of_2(sizeof(struct page));
-}
-
 static __always_inline unsigned long _compound_head(const struct page *page)
 {
 	unsigned long info = READ_ONCE(page->compound_info);
 	unsigned long mask;
 
-	if (!compound_info_has_mask()) {
+	if (!IS_ENABLED(SPARSEMEM_VMEMMAP_OPTIMIZATION_ENABLED)) {
 		/* Bit 0 encodes PageTail() */
 		if (info & 1)
 			return info - 1;
@@ -232,8 +212,8 @@ static __always_inline unsigned long _compound_head(const struct page *page)
 	}
 
 	/*
-	 * If compound_info_has_mask() is true the rest of the info encodes
-	 * the mask that converts the address of the tail page to the head page.
+	 * If HVO is enabled the rest of the info encodes the mask that converts
+	 * the address of the tail page to the head page.
 	 *
 	 * No need to clear bit 0 in the mask as 'page' always has it clear.
 	 *
@@ -257,7 +237,7 @@ static __always_inline void set_compound_head(struct page *tail,
 	unsigned int shift;
 	unsigned long mask;
 
-	if (!compound_info_has_mask()) {
+	if (!IS_ENABLED(SPARSEMEM_VMEMMAP_OPTIMIZATION_ENABLED)) {
 		WRITE_ONCE(tail->compound_info, (unsigned long)head | 1);
 		return;
 	}
diff --git a/kernel/bounds.c b/kernel/bounds.c
index 02b619eb6106..ff2ec3834d32 100644
--- a/kernel/bounds.c
+++ b/kernel/bounds.c
@@ -8,6 +8,7 @@
 #define __GENERATING_BOUNDS_H
 #define COMPILE_OFFSETS
 /* Include headers that define the enum constants of interest */
+#include <linux/mm_types.h>
 #include <linux/page-flags.h>
 #include <linux/mmzone.h>
 #include <linux/kbuild.h>
@@ -30,6 +31,7 @@ int main(void)
 	DEFINE(LRU_GEN_WIDTH, 0);
 	DEFINE(__LRU_REFS_WIDTH, 0);
 #endif
+	DEFINE(STRUCT_PAGE_SIZE_IS_POWER_OF_2, is_power_of_2(sizeof(struct page)));
 	/* End of constants */
 
 	return 0;
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index d595ef759bc2..0347341be156 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -21,6 +21,7 @@
 #include "hugetlb_vmemmap.h"
 #include "internal.h"
 
+#ifdef SPARSEMEM_VMEMMAP_OPTIMIZATION_ENABLED
 /**
  * struct vmemmap_remap_walk - walk vmemmap page table
  *
@@ -693,3 +694,4 @@ static int __init hugetlb_vmemmap_init(void)
 	return 0;
 }
 late_initcall(hugetlb_vmemmap_init);
+#endif
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 0022f9c5a101..bd576ef41ee7 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -12,7 +12,7 @@
 #include <linux/io.h>
 #include <linux/memblock.h>
 
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+#if defined(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP) && defined(SPARSEMEM_VMEMMAP_OPTIMIZATION_ENABLED)
 int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio);
 long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 					struct list_head *folio_list,
@@ -34,8 +34,6 @@ static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate
 {
 	int size = hugetlb_vmemmap_size(h) - OPTIMIZED_FOLIO_VMEMMAP_SIZE;
 
-	if (!is_power_of_2(sizeof(struct page)))
-		return 0;
 	return size > 0 ? size : 0;
 }
 #else
diff --git a/mm/internal.h b/mm/internal.h
index 02064f21bfe1..121c9076f09a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1026,9 +1026,6 @@ static inline bool vmemmap_page_optimizable(const struct page *page)
 	unsigned long pfn = page_to_pfn(page);
 	unsigned int order = section_order(__pfn_to_section(pfn));
 
-	if (!is_power_of_2(sizeof(struct page)))
-		return false;
-
 	return (pfn & ((1L << order) - 1)) >= OPTIMIZED_FOLIO_VMEMMAP_PAGE_STRUCTS;
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 77bb0113bac5..7375f66a58d5 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -404,10 +404,8 @@ void __init sparse_init(void)
 	unsigned long pnum_end, pnum_begin, map_count = 1;
 	int nid_begin;
 
-	if (compound_info_has_mask()) {
-		VM_WARN_ON_ONCE(!IS_ALIGNED((unsigned long) pfn_to_page(0),
-				    MAX_FOLIO_VMEMMAP_ALIGN));
-	}
+	VM_WARN_ON_ONCE(IS_ENABLED(SPARSEMEM_VMEMMAP_OPTIMIZATION_ENABLED) &&
+			!IS_ALIGNED((unsigned long)pfn_to_page(0), MAX_FOLIO_VMEMMAP_ALIGN));
 
 	pnum_begin = first_present_section_nr();
 	nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
diff --git a/mm/util.c b/mm/util.c
index f063fd4de1e8..783b2081ea74 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1348,7 +1348,7 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
 		foliop = (struct folio *)page;
 	} else {
 		/* See compound_head() */
-		if (compound_info_has_mask()) {
+		if (IS_ENABLED(SPARSEMEM_VMEMMAP_OPTIMIZATION_ENABLED)) {
 			unsigned long p = (unsigned long)page;
 
 			foliop = (struct folio *)(p & info);
-- 
2.20.1


