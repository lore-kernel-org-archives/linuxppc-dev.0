Return-Path: <linuxppc-dev+bounces-20882-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B21CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:11:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv314gfhz2yZc;
	Wed, 13 May 2026 23:10:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677837;
	cv=none; b=Oz7IsRuVplgdkZUucShs5o93YF/gkvIGkz36qfjFIjpK+B7N43wPsuckTZopyMlDT6ZOCylJfsWTdasRYMqk+UrB5NCl/mNPhvMvi/38HBfTJRTH3+NPdR412WqCvPeR+7xAdcQB0pjfkyoh0i1gcbvKEXdSkYQPdaZq7bazbUV+w0P669upQ88VhGoqFnLSG8WQMAiFIFLhJplV/aFxgS5N3Djpa+klu//Du5SEsTWM5Cnmkxtu6wP0YxPAS7YDBrGhzbjwir+beQAio9R5oYU2iNtidp/JIB7mIYdX8LCHxgBA4ZiJp+GzR2maI41S8g+tAD2+L3uqV4srQIVUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677837; c=relaxed/relaxed;
	bh=UOmi79uUam5ycb0mnRYplgXKnDDShon/X8fwxFGausU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvlNEDqFKxSKIY6A7O6T0qPXNlcAJBZyV7b79BYR7H7/Kep4h7LQIJSBF4GvaepFvPpIWD7rd7mzDlnrN1uqfz1eJijNN/q4X6/TD8SwFhNdA4+zv0DueDvqVavRiypEKlxomPLgcvFHSiEkerWgmxcDUuduL1ENpnxluPsd+YzrP1hfYPvh8usU9CbyvwHMI7S64q2aSfYtmGNwJ85/jx4lOarT9bYY9beCYxXMGdBRUnplBKj5EVs/Qdps6A9cBAWAh/ccG3MSqcZhKbnPtFbAyKI8ae+3ssjE7dx1wGL42dCpXiyqWNay8qnrOB7cwI2gpvBpjpNbBryiTtibjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=JJCA3S2g; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=JJCA3S2g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv310Jzyz2yZ6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:10:36 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2ba21d32776so45340205ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677835; x=1779282635; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOmi79uUam5ycb0mnRYplgXKnDDShon/X8fwxFGausU=;
        b=JJCA3S2g22ulFbDmdchBnwRZ0CTs8T8sHUwkUHCugcoaS0zrdDRKppFxkvE2LmzlQl
         S9RoK8adyt3DnH/+HVHmL7DV+a1FdG5WP7ID0T8iUnLz1BB+XVod26Ax63rA5p+f0LeO
         bF4qL9cd/p+dirdgWmD4BEH16+D5d2ei0Bf/IeXbb3WpY9qi/K+6nXlva3BCivNX9D5D
         OoO0oyn0NspPYWgIFpC9yS6j3mGZkVk+4ODi2VaUx7uBjUndu0B3IKCjILXk5D2+rj7i
         9YmtUJNhvA49KPiIrMBIJLQUjMVDqJczurwVIK5ZxBs0Vd7HoK5+7dkCQ7oJz6Ph3d6y
         lwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677835; x=1779282635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UOmi79uUam5ycb0mnRYplgXKnDDShon/X8fwxFGausU=;
        b=iI8eERuBAefGshT2EaA/9HlpCCKr8QeDpcFU/otFxAoBhf19dv0XiGik72VyRhHpbe
         Pst5Qzi2q3fWEacADwwkaEd0nkwK4qVyiZPZKq5IuEeNnI6l8YF4HvY9s7I9J67iL64/
         rvjzMWkCrAQ1lpP+6QPjcL7mvRip53AG3Nc0qVs5iicK37dGEFqdyU7KijmdCBwBuivU
         BrkG1hQ3HbXyIXpbbDHXkf+yQeBzUUVFUYQosGu13kEud07i0FcQiJq38KiMxBZ0A62o
         p55AgKj8LtaEG3btUGGf7AcHfyF9qiHRkaPmwB0pyJwgviavMxUB4uGdD3+Zos7Ab6h+
         fzsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9sU2msMoyPeI/awLaaHRhrG70Btxzy0mMXTE/kPJo72mSWtMgpTrhfQgV/VN9VEzGNhu5FgfNn60LZKIg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwBsaZTO6Kyb+JsRXXOPy+WWrOgWf56VBgZtLbjXbXaHgVYvu/T
	Lr8uYeyDC2chlTf8ZSWbkIvubNScYYuHLUI+L9S8qlc5+lrHnDBA4bTOur2JDHW5m+s=
X-Gm-Gg: Acq92OH0RGdDKoeVCfmilr5uM1RtPw2YCAa8e4bIROvrM3g1T4jdRILAyHrAHECqWWY
	QOFB58iEMCgXb9MmU7JyPSzp3NeMt+t+83H0V2G3pVYaBMls0MbnDQ8yCQRZ0Cjk5S7S7zOeA2A
	YKmbjc7ptft8WAlh1ui++mSf/xvq7aFnu1SkBGgjf6gYAH7JwH1tYLyWu8uq6f+RlNora/7Escm
	WBKVcfq9wtiInFN6L2AnhUwWzOs/j8+7mcQYRnTeSBra9A2Evt5j1qaUmD0r6fHFbbDjNAq60u6
	yOrlVf7RrrgMZaOzimTYC19D4rp+HSpfXtJrP753zH39jRYApHiS/gvX7m2Kd7b78ilADYX5HTz
	951nprkaPGJrd457wNbI6qmv9FX01FAOU512ogQdsLm0Hh0EVYDjhN7RZKpdmVNQ8q8G31GkyWz
	d460VldQFW3n4/QLsmYdeQCOe/jLQOvhp8De1NQhkNWDyJzOu376MV+W6nUpE=
X-Received: by 2002:a17:903:8cf:b0:2ae:ba5f:3ac3 with SMTP id d9443c01a7336-2bd27133c5fmr20492895ad.2.1778677834864;
        Wed, 13 May 2026 06:10:34 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.10.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:10:34 -0700 (PDT)
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
Subject: [PATCH v2 33/69] mm/sparse: Remove SPARSEMEM_VMEMMAP_PREINIT
Date: Wed, 13 May 2026 21:05:01 +0800
Message-ID: <20260513130542.35604-34-songmuchun@bytedance.com>
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

SPARSEMEM_VMEMMAP_PREINIT was only there to support HugeTLB's early
vmemmap optimization setup.

Now that HugeTLB bootmem vmemmap optimization uses the common
section-based sparse-vmemmap path, sparsemem no longer needs a separate
pre-initialization mechanism.

Remove the Kconfig symbols, section flag, and empty sparse-vmemmap early
hook, and always initialize present sections through the normal sparse
setup path.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/Kconfig       |  1 -
 fs/Kconfig             |  1 -
 include/linux/mmzone.h | 25 -------------------------
 mm/Kconfig             |  5 -----
 mm/sparse-vmemmap.c    | 13 -------------
 mm/sparse.c            | 23 ++++++++---------------
 6 files changed, 8 insertions(+), 60 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f24810015234..ed2aa0e4c472 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -148,7 +148,6 @@ config X86
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP	if X86_64
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
-	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
diff --git a/fs/Kconfig b/fs/Kconfig
index cf6ae64776e6..ccb9dd480523 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -278,7 +278,6 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	def_bool HUGETLB_PAGE
 	depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	depends on SPARSEMEM_VMEMMAP
-	select SPARSEMEM_VMEMMAP_PREINIT if ARCH_WANT_HUGETLB_VMEMMAP_PREINIT
 
 config HUGETLB_PMD_PAGE_TABLE_SHARING
 	def_bool HUGETLB_PAGE
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d6a5dd042c25..b9baef8cca91 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2092,9 +2092,6 @@ enum {
 	SECTION_IS_EARLY_BIT,
 #ifdef CONFIG_ZONE_DEVICE
 	SECTION_TAINT_ZONE_DEVICE_BIT,
-#endif
-#ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
-	SECTION_IS_VMEMMAP_PREINIT_BIT,
 #endif
 	SECTION_MAP_LAST_BIT,
 };
@@ -2106,9 +2103,6 @@ enum {
 #ifdef CONFIG_ZONE_DEVICE
 #define SECTION_TAINT_ZONE_DEVICE	BIT(SECTION_TAINT_ZONE_DEVICE_BIT)
 #endif
-#ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
-#define SECTION_IS_VMEMMAP_PREINIT	BIT(SECTION_IS_VMEMMAP_PREINIT_BIT)
-#endif
 #define SECTION_MAP_MASK		(~(BIT(SECTION_MAP_LAST_BIT) - 1))
 #define SECTION_NID_SHIFT		SECTION_MAP_LAST_BIT
 
@@ -2163,24 +2157,6 @@ static inline int online_device_section(const struct mem_section *section)
 }
 #endif
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
-static inline int preinited_vmemmap_section(const struct mem_section *section)
-{
-	return (section &&
-		(section->section_mem_map & SECTION_IS_VMEMMAP_PREINIT));
-}
-
-void sparse_vmemmap_init_nid_early(int nid);
-#else
-static inline int preinited_vmemmap_section(const struct mem_section *section)
-{
-	return 0;
-}
-static inline void sparse_vmemmap_init_nid_early(int nid)
-{
-}
-#endif
-
 static inline int online_section_nr(unsigned long nr)
 {
 	return online_section(__nr_to_section(nr));
@@ -2427,7 +2403,6 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
 #endif
 
 #else
-#define sparse_vmemmap_init_nid_early(_nid) do {} while (0)
 #define pfn_in_present_section pfn_valid
 static inline void section_set_order_range(unsigned long pfn, unsigned long nr_pages,
 					   unsigned int order)
diff --git a/mm/Kconfig b/mm/Kconfig
index bb0202cf8b15..c26d2d2050d5 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -410,8 +410,6 @@ config SPARSEMEM_VMEMMAP
 	  pfn_to_page and page_to_pfn operations.  This is the most
 	  efficient option when sufficient kernel resources are available.
 
-config SPARSEMEM_VMEMMAP_PREINIT
-	bool
 #
 # Select this config option from the architecture Kconfig, if it is preferred
 # to enable the feature of HugeTLB/dev_dax vmemmap optimization.
@@ -422,9 +420,6 @@ config ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 config ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	bool
 
-config ARCH_WANT_HUGETLB_VMEMMAP_PREINIT
-	bool
-
 config HAVE_MEMBLOCK_PHYS_MAP
 	bool
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index f1c3b2d0f23c..dde4486195ad 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -548,19 +548,6 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 	return pfn_to_page(pfn);
 }
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
-/*
- * This is called just before initializing sections for a NUMA node.
- * Any special initialization that needs to be done before the
- * generic initialization can be done from here. Sections that
- * are initialized in hooks called from here will be skipped by
- * the generic initialization.
- */
-void __init sparse_vmemmap_init_nid_early(int nid)
-{
-}
-#endif
-
 static void subsection_mask_set(unsigned long *map, unsigned long pfn,
 		unsigned long nr_pages)
 {
diff --git a/mm/sparse.c b/mm/sparse.c
index 47349f6f463f..eab37504819d 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -316,27 +316,20 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 	if (sparse_usage_init(nid, map_count))
 		panic("Failed to allocate usemap for node %d\n", nid);
 
-	sparse_vmemmap_init_nid_early(nid);
-
 	for_each_present_section_nr(pnum_begin, pnum) {
-		struct mem_section *ms;
 		unsigned long pfn = section_nr_to_pfn(pnum);
+		struct page *map;
 
 		if (pnum >= pnum_end)
 			break;
 
-		ms = __nr_to_section(pnum);
-		if (!preinited_vmemmap_section(ms)) {
-			struct page *map;
-
-			map = __populate_section_memmap(pfn, PAGES_PER_SECTION,
-							nid, NULL, NULL);
-			if (!map)
-				panic("Failed to allocate memmap for section %lu\n", pnum);
-			memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
-								       NULL, NULL));
-			sparse_init_early_section(nid, map, pnum, 0);
-		}
+		map = __populate_section_memmap(pfn, PAGES_PER_SECTION,
+						nid, NULL, NULL);
+		if (!map)
+			panic("Failed to allocate memmap for section %lu\n", pnum);
+		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
+							       NULL, NULL));
+		sparse_init_early_section(nid, map, pnum, 0);
 	}
 	sparse_usage_fini();
 }
-- 
2.54.0


