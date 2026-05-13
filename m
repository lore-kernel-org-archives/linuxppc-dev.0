Return-Path: <linuxppc-dev+bounces-20906-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0917DCD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:22:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvJD1jzrz2yx7;
	Wed, 13 May 2026 23:22:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678524;
	cv=none; b=QotYAlxSlqLP6uTe4hSUmLICmcBoir81flizb5Rk4aqu9lHye4aHuM7qk5QDgYeUE+Fku0iUajs4z7pNHPq172mSF6FZupHbKItrjMCDqMzYrUwd5DdV0Ss98YES2tlG9NV9C08Jzvw47aBXw3ln2f9NlEZfRTE9AwbiHM9JJWMjkr7AHdTmnektpDCBpVj71Tk6R9enGYnvlkIDdSN1qe1xt0ApizyVvu0p7vopQ+EB2kFKRhchx5j6WAfQGuQwwycirZoKDpBwYmMKcWqsiy/CxPQaGZe6g1MR9SaPCMpAkO9YZgArD4fjzLGSwCySdrRWu1L4CO6ZyTItzKctHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678524; c=relaxed/relaxed;
	bh=8xAcJFzw5l8sNYVc/df08CWPD7oki7YaxoFEOHbnbjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llXwFqf7KIB7cXLpRPk+B7jAHrVdDwzNdhDbxQYE9wNt5+2PX/Cqdi9yS6NIsk5FsPS5AWyJs7i7b/F8V8ARAx3bPfk33wgwlyxCohN9HJuTqFDPn1XttezrugFgiC3vuWe2ZHqrOJ8JqgIiRuUF02s1JXRTJOLlTvHLhUx9BsDbRmT8UcJ45bxAx28QlDIEQfCUXDQU2WMEA83w+bhUyTeEr04/hljRcHZILAmv2jOgkQvgE/Czxh+u1Ccncn2H44mw0fXtqrYNePEtqNqPOY8LktKU8zEupqXL49OB+rzx/o0VMkFeqQy8ChM6Rh+BtSS+pwD82L22MGHY4uMvTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Nw1Tax7A; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Nw1Tax7A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvJC1xM6z2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:22:03 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-365e20fe3b8so3905613a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678521; x=1779283321; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xAcJFzw5l8sNYVc/df08CWPD7oki7YaxoFEOHbnbjI=;
        b=Nw1Tax7AVpNcEHKg9IBb2HWTqSzXtYhSx4wKLA6NDK9RXuBUV4CaB23mXuqnKvrpUs
         C1xAK83k5alY3xHPEpybZsDC7C73bj7TCqtYFXmO8ZbDceC7+im+8xd/xCtnsEdyryw0
         94oIv2/MHo1YBnBp6TEihESqgd8pA940f7BaclL/G8d1kLuLHZObHFqRqy3ZcEHqQU/6
         V9ZCBs3Ym5EBsTTWnZe8acxGwaKYw0fP1meGqS6PAr/Kvpo30N0rVoYFxw9xaGjzl2Tr
         lCle321t8is/FFVxa0LVuIIMU0/vWoA9RjKqMz5TpD4KV5f4Fh+Ev9t0mzMJABzZ6ImN
         GuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678521; x=1779283321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8xAcJFzw5l8sNYVc/df08CWPD7oki7YaxoFEOHbnbjI=;
        b=qn9OvkhSOe+2Ydmtr0GztTbq6tBVgzRxTLliftuMCkE3SPQa1QcFTopj/vxS00l8DE
         8ww92kjgIYtqRtnvuQQT62m18pGYAysn3ZyKPq4ieKwCS13RvpWFoLhxGlMdW0xnVw7W
         bKf545TfWJ8dkZjpadn6RsN9ZpfUs7X/4rQycafCbpdrhkN1LSXEdi/uWYL2VL7OcIqt
         p5af71HMmLzrIKfsTRHlPPWYmueaCZEptjDK6JlQ0H19JTMrTBBHYzWGJHlp6S90AMWJ
         2STndVrvWI/K+/KasfMYZCohm/uDfy/P2hnOoPSJaS2U9MGDFvoN2HPKWcD4aYxz77j8
         WIew==
X-Forwarded-Encrypted: i=1; AFNElJ/eLDO5xwVkckPvibS77Gr7KzhS1qwbjeXRCx5vS4ljboZ4CXVm18BSC2UhyBSnitQjZWJj1Taf1zGejyQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyQWO4ZC3sd0Lt8Zh/2gXMn0Y54LuPIslwhH/z9T3Gv5NrDQlhH
	RzTl5z9ekeu0mbTG6unLKsIIZ3u2ZmzVnzt1b20Lj9LQ/txzVCggA+QD6VNixdkhm0M=
X-Gm-Gg: Acq92OEIhvY9sISO3JzGNCBlp+xLO4B648IPVCuwbGirFomeExb/cYU3AnhzkSjqsEQ
	Y48oRqxry6BtcseLyGnjlJQJOWj7DcZ241hDfPry1UgREEfR2+haEhiUuUmIxnQLPpLFixqqwjg
	dNL5ATlm27oTpI1zoxf3n0mZLHiop9pYCoUETULgyUIaTFxPKiDKG3yWPKMgn8HUEoTSHZikejl
	1aO5KsmS4apbzbHHO/iN4aQuB15boxjz+2YqyfvCSdr0kjQdLWRnmqqxTKyiYqP00+pEhVpBlYS
	vxfo3OyxMubm+yq8SwIjOFQZJ2RHMP8C8kOd8Spe6kqwfaSFFi1zwlueLuAArva9o6s3FLYhIko
	f2sAbKOtMRkd24XLH88VMzsDRVlU+HhyrpNedqpeW3Gx4Op39ZL7ase9odnCd1k6vPK95xrb3EX
	YDasF6beA47CQoH11kgeM25m4teR+Kf8yq8mvz0muA1+9phywmyTNh5hIWUVkzD9bg1OLwe1I=
X-Received: by 2002:a17:90a:617:b0:368:f7a7:daee with SMTP id 98e67ed59e1d1-368f7a7df06mr1739782a91.8.1778678520875;
        Wed, 13 May 2026 06:22:00 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.21.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:22:00 -0700 (PDT)
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
Subject: [PATCH v2 57/69] mm/sparse-vmemmap: Consolidate HVO enable checks
Date: Wed, 13 May 2026 21:20:22 +0800
Message-ID: <20260513132044.41690-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513132044.41690-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513132044.41690-1-songmuchun@bytedance.com>
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

HVO depends on build-time conditions that are not fully expressible in
Kconfig, including whether sizeof(struct page) is a power of two and
whether the supported folio order range can use the optimized layout.

Those checks are currently duplicated in several places. Define
SPARSEMEM_VMEMMAP_OPTIMIZATION in bounds.c when the build-time
requirements are met, and use that generated constant to guard the
generic HVO code.

This centralizes the build-time checks instead of repeating them
throughout the HVO paths.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/entry/vdso/vdso32/fake_32bit_build.h |  1 -
 drivers/dax/Kconfig                           |  2 +-
 fs/Kconfig                                    |  2 +-
 include/linux/mm_types.h                      |  3 +-
 include/linux/mmzone.h                        | 38 ++++++++-----------
 include/linux/page-flags-layout.h             |  2 +
 include/linux/page-flags.h                    | 28 ++------------
 kernel/bounds.c                               |  5 +++
 mm/Kconfig                                    |  2 +-
 mm/hugetlb_vmemmap.c                          |  2 +
 mm/hugetlb_vmemmap.h                          |  4 +-
 mm/internal.h                                 |  3 --
 mm/sparse.c                                   |  6 +--
 mm/util.c                                     |  2 +-
 14 files changed, 38 insertions(+), 62 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32/fake_32bit_build.h b/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
index 5f8424eade2b..db1b15f686e3 100644
--- a/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
+++ b/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
@@ -11,7 +11,6 @@
 #undef CONFIG_PGTABLE_LEVELS
 #undef CONFIG_ILLEGAL_POINTER_VALUE
 #undef CONFIG_SPARSEMEM_VMEMMAP
-#undef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
 #undef CONFIG_NR_CPUS
 #undef CONFIG_PARAVIRT_XXL
 
diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index 60cb05dce53d..cb7710c29885 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -8,7 +8,7 @@ if DAX
 config DEV_DAX
 	tristate "Device DAX: direct access mapping device"
 	depends on TRANSPARENT_HUGEPAGE
-	select SPARSEMEM_VMEMMAP_OPTIMIZATION if ARCH_WANT_OPTIMIZE_DAX_VMEMMAP && SPARSEMEM_VMEMMAP
+	select SPARSEMEM_VMEMMAP_OPTIMIZATION_ENABLE if ARCH_WANT_OPTIMIZE_DAX_VMEMMAP && SPARSEMEM_VMEMMAP
 	help
 	  Support raw access to differentiated (persistence, bandwidth,
 	  latency...) memory via an mmap(2) capable character
diff --git a/fs/Kconfig b/fs/Kconfig
index 496cfa2379e5..ab3937abe07f 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -278,7 +278,7 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	def_bool HUGETLB_PAGE
 	depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	depends on SPARSEMEM_VMEMMAP
-	select SPARSEMEM_VMEMMAP_OPTIMIZATION
+	select SPARSEMEM_VMEMMAP_OPTIMIZATION_ENABLE
 
 config HUGETLB_PMD_PAGE_TABLE_SHARING
 	def_bool HUGETLB_PAGE
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a308e2c23b82..9a7cd7575f3a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -546,6 +546,7 @@ FOLIO_MATCH(flags, _flags_3);
 FOLIO_MATCH(compound_info, _head_3);
 #undef FOLIO_MATCH
 
+#ifndef __GENERATING_BOUNDS_H
 /**
  * struct ptdesc -    Memory descriptor for page tables.
  * @pt_flags: enum pt_flags plus zone/node/section.
@@ -1990,5 +1991,5 @@ static inline unsigned long mmf_init_legacy_flags(unsigned long flags)
 			   (1UL << MMF_HAS_MDWE_NO_INHERIT));
 	return flags & MMF_INIT_LEGACY_MASK;
 }
-
+#endif /* __GENERATING_BOUNDS_H */
 #endif /* _LINUX_MM_TYPES_H */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index efb37f2ffec4..0d49d6e163ff 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -3,8 +3,6 @@
 #define _LINUX_MMZONE_H
 
 #ifndef __ASSEMBLY__
-#ifndef __GENERATING_BOUNDS_H
-
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/list_nulls.h>
@@ -96,33 +94,32 @@
 
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
 #define OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES	(OPTIMIZED_FOLIO_VMEMMAP_SIZE / sizeof(struct page))
 #define OPTIMIZABLE_FOLIO_MIN_ORDER		(ilog2(OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES) + 1)
 
-#define __NR_OPTIMIZABLE_FOLIO_ORDERS		(MAX_FOLIO_ORDER - OPTIMIZABLE_FOLIO_MIN_ORDER + 1)
-#define NR_OPTIMIZABLE_FOLIO_ORDERS		\
-	((__NR_OPTIMIZABLE_FOLIO_ORDERS > 0 &&	\
-	  IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION)) ? __NR_OPTIMIZABLE_FOLIO_ORDERS : 0)
+#ifdef SPARSEMEM_VMEMMAP_OPTIMIZATION
+/*
+ * Hugepage Vmemmap Optimization (HVO) requires the struct page of the head page
+ * to be naturally aligned with regard to the vmemmap size of the maximal folio.
+ */
+#define MAX_FOLIO_VMEMMAP_ALIGN			(MAX_FOLIO_NR_PAGES * sizeof(struct page))
+#define NR_OPTIMIZABLE_FOLIO_ORDERS		(MAX_FOLIO_ORDER - OPTIMIZABLE_FOLIO_MIN_ORDER + 1)
+#else
+#define MAX_FOLIO_VMEMMAP_ALIGN			0
+#define NR_OPTIMIZABLE_FOLIO_ORDERS		0
+#endif
 
 static inline bool order_vmemmap_optimizable(unsigned int order)
 {
+	if (!IS_ENABLED(SPARSEMEM_VMEMMAP_OPTIMIZATION))
+		return false;
 	return order >= OPTIMIZABLE_FOLIO_MIN_ORDER;
 }
 
+#ifndef __GENERATING_BOUNDS_H
 enum migratetype {
 	MIGRATE_UNMOVABLE,
 	MIGRATE_MOVABLE,
@@ -2044,7 +2041,7 @@ struct mem_section {
 	 */
 	struct page_ext *page_ext;
 #endif
-#ifdef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
+#ifdef SPARSEMEM_VMEMMAP_OPTIMIZATION
 	/*
 	 * The order of compound pages in this section. Typically, the section
 	 * holds compound pages of this order; a larger compound page will span
@@ -2236,7 +2233,7 @@ static inline bool pfn_section_first_valid(struct mem_section *ms, unsigned long
 }
 #endif
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
+#ifdef SPARSEMEM_VMEMMAP_OPTIMIZATION
 static inline void section_set_order(struct mem_section *section, unsigned int order)
 {
 	VM_WARN_ON(section->order && order && section->order != order);
@@ -2277,9 +2274,6 @@ static inline unsigned int pfn_to_section_order(unsigned long pfn)
 
 static inline bool section_vmemmap_optimizable(const struct mem_section *section)
 {
-	if (!is_power_of_2(sizeof(struct page)))
-		return false;
-
 	return order_vmemmap_optimizable(section_order(section));
 }
 
diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
index 760006b1c480..6a7e7f3dbb93 100644
--- a/include/linux/page-flags-layout.h
+++ b/include/linux/page-flags-layout.h
@@ -2,6 +2,7 @@
 #ifndef PAGE_FLAGS_LAYOUT_H
 #define PAGE_FLAGS_LAYOUT_H
 
+#ifndef __GENERATING_BOUNDS_H
 #include <linux/numa.h>
 #include <generated/bounds.h>
 
@@ -121,4 +122,5 @@
 				(NR_NON_PAGEFLAG_BITS + NR_PAGEFLAGS))
 
 #endif
+#endif /* __GENERATING_BOUNDS_H */
 #endif /* _LINUX_PAGE_FLAGS_LAYOUT */
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 12665b34586c..df7f6dea2e5b 100644
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
+	if (!IS_ENABLED(SPARSEMEM_VMEMMAP_OPTIMIZATION)) {
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
+	if (!IS_ENABLED(SPARSEMEM_VMEMMAP_OPTIMIZATION)) {
 		WRITE_ONCE(tail->compound_info, (unsigned long)head | 1);
 		return;
 	}
diff --git a/kernel/bounds.c b/kernel/bounds.c
index 02b619eb6106..9638260d67f8 100644
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
@@ -30,6 +31,10 @@ int main(void)
 	DEFINE(LRU_GEN_WIDTH, 0);
 	DEFINE(__LRU_REFS_WIDTH, 0);
 #endif
+	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION_ENABLE) &&
+	    is_power_of_2(sizeof(struct page)) &&
+	    MAX_FOLIO_ORDER >= OPTIMIZABLE_FOLIO_MIN_ORDER)
+		DEFINE(SPARSEMEM_VMEMMAP_OPTIMIZATION, 1);
 	/* End of constants */
 
 	return 0;
diff --git a/mm/Kconfig b/mm/Kconfig
index c85ed7d7f37d..52d9d69a95ff 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -410,7 +410,7 @@ config SPARSEMEM_VMEMMAP
 	  pfn_to_page and page_to_pfn operations.  This is the most
 	  efficient option when sufficient kernel resources are available.
 
-config SPARSEMEM_VMEMMAP_OPTIMIZATION
+config SPARSEMEM_VMEMMAP_OPTIMIZATION_ENABLE
 	bool
 	depends on SPARSEMEM_VMEMMAP
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 6f6f1740f540..1305bee1195a 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -22,6 +22,7 @@
 #include "hugetlb_vmemmap.h"
 #include "internal.h"
 
+#ifdef SPARSEMEM_VMEMMAP_OPTIMIZATION
 /**
  * struct vmemmap_remap_walk - walk vmemmap page table
  *
@@ -693,3 +694,4 @@ static int __init hugetlb_vmemmap_init(void)
 	return 0;
 }
 late_initcall(hugetlb_vmemmap_init);
+#endif
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index b4d0ba27b42c..dfd48be6b231 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -10,7 +10,7 @@
 #define _LINUX_HUGETLB_VMEMMAP_H
 #include <linux/hugetlb.h>
 
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+#if defined(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP) && defined(SPARSEMEM_VMEMMAP_OPTIMIZATION)
 int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio);
 long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 					struct list_head *folio_list,
@@ -32,8 +32,6 @@ static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate
 {
 	int size = hugetlb_vmemmap_size(h) - OPTIMIZED_FOLIO_VMEMMAP_SIZE;
 
-	if (!is_power_of_2(sizeof(struct page)))
-		return 0;
 	return size > 0 ? size : 0;
 }
 #else
diff --git a/mm/internal.h b/mm/internal.h
index 9597a703bc73..afdae79640b5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1023,9 +1023,6 @@ static inline bool vmemmap_page_optimizable(const struct page *page)
 	unsigned long pfn = page_to_pfn(page);
 	unsigned long nr_pages = 1UL << pfn_to_section_order(pfn);
 
-	if (!is_power_of_2(sizeof(struct page)))
-		return false;
-
 	return (pfn & (nr_pages - 1)) >= OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES;
 }
 #else
diff --git a/mm/sparse.c b/mm/sparse.c
index bdf23709a1c7..598da1651e49 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -301,10 +301,8 @@ void __init sparse_init(void)
 	unsigned long pnum_end, pnum_begin, map_count = 1;
 	int nid_begin;
 
-	if (compound_info_has_mask()) {
-		VM_WARN_ON_ONCE(!IS_ALIGNED((unsigned long) pfn_to_page(0),
-				    MAX_FOLIO_VMEMMAP_ALIGN));
-	}
+	VM_WARN_ON(IS_ENABLED(SPARSEMEM_VMEMMAP_OPTIMIZATION) &&
+		   !IS_ALIGNED((unsigned long)pfn_to_page(0), MAX_FOLIO_VMEMMAP_ALIGN));
 
 	pnum_begin = first_present_section_nr();
 	nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
diff --git a/mm/util.c b/mm/util.c
index 3cc949a0b7ed..4543f2b6ffa1 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1338,7 +1338,7 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
 		foliop = (struct folio *)page;
 	} else {
 		/* See compound_head() */
-		if (compound_info_has_mask()) {
+		if (IS_ENABLED(SPARSEMEM_VMEMMAP_OPTIMIZATION)) {
 			unsigned long p = (unsigned long)page;
 
 			foliop = (struct folio *)(p & info);
-- 
2.54.0


