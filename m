Return-Path: <linuxppc-dev+bounces-19360-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54A7F3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:56:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXXT67pkz2yvD;
	Sun, 05 Apr 2026 22:56:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393801;
	cv=none; b=KUb/rHf3AVetqbs7NtnyUwslWhu+HSGwTb0YMUMGHtgc7UzcG0uZBWTwOAXOx1wWriXVFrK5GXqFnHoOSmdJs1qW+cNbtroN5SvVA97UIz55nPhbyaFlqHeH8D7qW7w0m42MU2Q1PlantWh1yCoIwRLw6t03tFPt5471Ra1BrYjvFvIMjL6ff9k5NIJFwol8/qO96HsfTc7uLibBunuNZtLRu/70YnKBtcs+PtWAUwa15wPFqonF4Fx8+dubkrewhsnl7ciOwq7Xw9rTXakLLi50YKPie0cu5ux3/4JOlg8ElKVWIRX+8ubCMqGbeGy9Yz9Y3B+bKT6xnl+cGc4LUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393801; c=relaxed/relaxed;
	bh=MAH/SBWDnTjIq0A4CWltUgbBq7R5GiJqy6Ep8VuXWKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UE4YFXHj5U8Y9mJ6bW4GX0RyYuXZeqwhF8k8Xj5oM5uLqkekYA35mBNClB8tuKud5+CdEITn4T3f2riNNyu21zwLEARNgkKlBz+OmqX6FwiYX5UAIRuJpBRNkQ9P59t+zOAkRAUaXk5DmFDwLKaVHxw7rGIbAJwuuU1MTu1fS8RGVVNEo4jFyIEI1HRAHj4REznd6ButqXulVr6T4HsFP4rzh/QYgOkCI/qKJckrUmupBbsJiGsKbbgmzzS3JqJJGJx0r4lj7Z6/FsirwtU85keLqj3ilZAZ0RkO0IhxWAK1lNE2tUMEBl/gxns+xvpKOFgcMsyTKtnEgfMK1YQ6RA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=NnrrD8zQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=NnrrD8zQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXXT0rMtz2ynH
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:56:41 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so2885667a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393799; x=1775998599; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAH/SBWDnTjIq0A4CWltUgbBq7R5GiJqy6Ep8VuXWKc=;
        b=NnrrD8zQXYX92VlYhVFq0wW8/CE1fTteFcsCcG3phuz5XwQKqHQVvrRKoC7LJah4Nq
         jy196BwqBUEU/3C1uui9HQvUe4QKunKTLSW6Hrk30Fum8owTLDLqdBQ4diwIWZI5/C7n
         g+0IGTPXClUF2NnZNOehoK024FXxEkUPrn/fFnBUYlQ6ku804EsePXNF9uhROtzym/pZ
         0bcMJKi9c8+dFEX1b6LJ5WJco46JXKJcYAnW4h4pAXPjKF9Bc1nejTUsciicXXXnqtOi
         Uabq3lnekyQ6jKQP6gopjlgcUesUsK8gajVuGKUrHN005QhM0sDSZa603Vx3YFxF6pkW
         QkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393799; x=1775998599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MAH/SBWDnTjIq0A4CWltUgbBq7R5GiJqy6Ep8VuXWKc=;
        b=i5L1MqCgcS4RlVOASqH/uJb46N0QADlreJ+SledaJvOiNzTQ6K4qKek/WK9BsOiObq
         25HZAFqNdZQTboLwD1KV/wEr07+udO8+fnwVNAX0R0GVI/R5WVDyVUk2S+ujlSbPuLYz
         BHtwbxlLAEoPS2nzz3/BjAkO2dwMGr7+TPdCNWXFeRIyU8E3DKOEmt7Z9w5E3Qd04w6W
         0g+RWh1+BK4bmbcggj/pD3bx8kMslUulWNLLn039DS2XLKu7PYbk+8LPi68LhWNqe38e
         2ObzeC5K4Ech788DbzSA4uT7H4opHwUJjqSP0rmfPVZUE3w16RZOcOAO28xSzqGjIprs
         CYGA==
X-Forwarded-Encrypted: i=1; AJvYcCWOOHWQNSeq/mbgAp440JqFdN6j1IvLzswC/FeRf0trKg9lMVgLVKuXKeT9IwBMJyny9Kejg21cBGiSU/E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwttJW1xSKAjk8bgFPf48bdE1X5KEi7lE3/0OG3lV64j1vzyoVx
	oEp2306NT0Lj+vVCuBIJmLunCPnIe87afSDPfAXAqykbsuj9TsK8RB9h9zO8U98MUlw=
X-Gm-Gg: AeBDieto2XKDYvbpL3T+rRVpuvVI6yJOx1RA4RaTetAfM4rY5gDE454cmdrCuEHooLM
	rTGJ4fC7jUBgS4/Enpww0Sq27B+R3TfhzFzT6pMeSDF4gdo08TlupUFDSHp32AFM5xA6W++SSLA
	EOiJCUjV9120OFFYTY2bqhPm/MsxTOvJl3vObDKUpacvlN30AjJyMhWk4raMNOqhJDqI9UCKLke
	Is5/bl7woBKkSmoVgYDY+vYF+mOHqppUAb8+dJaNRzhlxfZJZl9pk3/GRcMk5pK44oyseIgpLVJ
	pyWqmZcQypZT8X+1i/+cBwTV+kz3IM7rX8zdbpoaUQ9jk4dcQIGyeeKmpdXV0NiXpCqinLsYNId
	/t/58zbR/nFwoWamfBQxQ+cHo2+8BcnKfICtmRKvTJhr/uycSttNf162r+LiOEB1FXDoo0uT01a
	FyoXJ+aXsn/PlZ1ZPTcFDPstOS1+pFx1Btr9nls62xJnf1cVGXhJ1jJQ==
X-Received: by 2002:a17:90b:3c85:b0:359:9014:99e7 with SMTP id 98e67ed59e1d1-35de69b84bamr8528565a91.29.1775393799189;
        Sun, 05 Apr 2026 05:56:39 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:56:38 -0700 (PDT)
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
Subject: [PATCH 30/49] mm/sparse-vmemmap: remove unused SPARSEMEM_VMEMMAP_PREINIT feature
Date: Sun,  5 Apr 2026 20:52:21 +0800
Message-Id: <20260405125240.2558577-31-songmuchun@bytedance.com>
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

Since the bootmem vmemmap optimization has been reimplemented to use
the new early compound vmemmap infrastructure, the old
SPARSEMEM_VMEMMAP_PREINIT feature and its related code (e.g.,
sparse_vmemmap_init_nid_early(), preinited_vmemmap_section()) are no
longer used.

Remove them to clean up the code.

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
index 99bb5217649a..f19625648f0f 100644
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
index 43cb06de297f..e70aa5f0429a 100644
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
index 0bd20efac427..75425407e0c4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2078,9 +2078,6 @@ enum {
 	SECTION_IS_EARLY_BIT,
 #ifdef CONFIG_ZONE_DEVICE
 	SECTION_TAINT_ZONE_DEVICE_BIT,
-#endif
-#ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
-	SECTION_IS_VMEMMAP_PREINIT_BIT,
 #endif
 	SECTION_MAP_LAST_BIT,
 };
@@ -2092,9 +2089,6 @@ enum {
 #ifdef CONFIG_ZONE_DEVICE
 #define SECTION_TAINT_ZONE_DEVICE	BIT(SECTION_TAINT_ZONE_DEVICE_BIT)
 #endif
-#ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
-#define SECTION_IS_VMEMMAP_PREINIT	BIT(SECTION_IS_VMEMMAP_PREINIT_BIT)
-#endif
 #define SECTION_MAP_MASK		(~(BIT(SECTION_MAP_LAST_BIT) - 1))
 #define SECTION_NID_SHIFT		SECTION_MAP_LAST_BIT
 
@@ -2149,24 +2143,6 @@ static inline int online_device_section(const struct mem_section *section)
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
@@ -2407,7 +2383,6 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
 #endif
 
 #else
-#define sparse_vmemmap_init_nid_early(_nid) do {} while (0)
 #define pfn_in_present_section pfn_valid
 #endif /* CONFIG_SPARSEMEM */
 
diff --git a/mm/Kconfig b/mm/Kconfig
index e8bf1e9e6ad9..3cce862088f1 100644
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
index 9da49b0d03f0..c35d912a1fef 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -543,19 +543,6 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
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
index 7779554c5a0c..04c641b97325 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -385,27 +385,20 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 		panic("The node[%d] usemap allocation failed\n", nid);
 	sparse_buffer_init(map_count * section_map_size(), nid);
 
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
-				panic("Populate section (%ld) on node[%d] failed\n", pnum, nid);
-			memmap_boot_pages_add(section_vmemmap_pages(pfn, PAGES_PER_SECTION,
-								    NULL, NULL));
-			sparse_init_early_section(nid, map, pnum, 0);
-		}
+		map = __populate_section_memmap(pfn, PAGES_PER_SECTION,
+						nid, NULL, NULL);
+		if (!map)
+			panic("Populate section (%ld) on node[%d] failed\n", pnum, nid);
+		memmap_boot_pages_add(section_vmemmap_pages(pfn, PAGES_PER_SECTION,
+							    NULL, NULL));
+		sparse_init_early_section(nid, map, pnum, 0);
 	}
 	sparse_usage_fini();
 	sparse_buffer_fini();
-- 
2.20.1


