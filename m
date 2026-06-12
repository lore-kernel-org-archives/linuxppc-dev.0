Return-Path: <linuxppc-dev+bounces-22541-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2385CD98CC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 04:01:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5QG0rgHz3btR;
	Fri, 12 Jun 2026 14:00:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236821;
	cv=none; b=HwHoPvPoKaQ2zJ4YDbfztirLikIBtb5CxANa7TvnizAcjI7xzc4oXw4SlVNhWJsbYaJmbDDJMI6nuky62/6l5AAJWpeAGt7PlZW44XKoAdLXurvIVjdzG/+n+MZ6hWIHN4+T5hGvvdF/o/KnD0tlXptD+uYOx9zg3CNAh0JpT79lvi+uUVFQJUiXT/NyMHHu8eOONSOF80biIRSoIO6lKzynyBiBk6eRMpUU9JEnzgzi1HDL+GxUN854ASua8v3ALsmlzongtyDUIoF2RVQR+TwMBQ6+rfaNQu5NH+sgwJ4BScINaaJ/H6PZ50ki5dl0AGdsQfnhB+kl7l9Ej765HA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236821; c=relaxed/relaxed;
	bh=K17o2xzrKCCnQsTBiihj6xsLYHSl3LYnDWpfyCRPu3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wh0KAuaLBy/D4zL2OofRNOAOG45TAFdG3Lp8coasccRzTiPizDQuan+J2vCriys47n+A2iKe4QqXWsOIAvdZDXdvVEQP6gQcTypS2FcNvobnk9oO+wPaI56H9TCMvR8L3hHZ7GEO30r++mFsJrwR43tAlQBv3eCy/aCdNl6uvPExQtMzs5K8/+M/4dnjNvWgxGUCEsZueJa73Wcs++HkK2P5ZNdmcyszolSqxi3cgQdMi5WoU+GichTR6pk918+EV9PsJGNHspxLdGUcTa8S5+RBxVV/Mlhe0jRStO8RGXnObBX/SmJ3kGKsnE0/BcTDJYZljDhRjYvi+2eJNozGCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=DEc4hQgV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=DEc4hQgV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5QC2nLfz3bsn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 14:00:19 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-84230ab8857so295430b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 21:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236817; x=1781841617; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K17o2xzrKCCnQsTBiihj6xsLYHSl3LYnDWpfyCRPu3g=;
        b=DEc4hQgVRom3c2K18Ap7FckWLkdStZBTbvudkEVw4cyVaa5knvleZxwFTYqdc1XvXp
         15S1NUdiPdzup0nAQiISgKBLSmVrCS24BenaefVDRTgR1OjVl0nkTSbsNDwETUQv1zNS
         SqcYQCTnAzlxR1AcOgEPN+kZqRIlgQRmNIbOWUlmYo4kQiqBdtqjtO6C78Z5nS5fgY5w
         4acH3lI9IJMHr0LY4OzqhYi+Th6BTXmA5eLPf0wPWOMiHt1JVLDo4ou/iz9ollTtiqd5
         A2xb1JdRjAjsuRAs1XafqqO0onQ3rCv4/eCbou/3T4+9zCk6WWQM90PrtKnBZp7jZ78z
         pmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236817; x=1781841617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K17o2xzrKCCnQsTBiihj6xsLYHSl3LYnDWpfyCRPu3g=;
        b=lQ1hWDHSWqmueQOSTHNGhHfv/Vd9alItevHeSp16do12GlYlHTCtMyN1WD6LUGJxM5
         ipe+nrymDV+pkxy0s8Um5ZeJQRQE12BM5ZXFmPySMpBQn7X3u8fisflAY2Bu3pr/99DV
         VouphPqzYfOC5g1uTU+Q0NQ2SBFzMs9s30/EjVuHXW9s/RjeUBV0NONGUEMp160WHmMj
         oa33fGlx35qaRX7rSKrKksDn7FDPUzGtziqcO5HKCrT0cVaz7LKttN/RzXmHqPvhgrmE
         n+63UUkddG1saOD6AU74tQVYheTjfWsuLreSHTRWISA00GpPxyP1+U67L2MMxU+Qya4e
         B27g==
X-Forwarded-Encrypted: i=1; AFNElJ93+1CKTFfpqcOmu75akDidpHDBT+ZAUMqdXGx8T5ATl+LUDCFJ6QhavJwuQ+MLRFRTi+FttMLtiPaEluk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxZ2IExyYCDUPnyjqHANsQhHgjUPevv6q3zINBGB6BFcwpIaQFV
	4lPcm179YcF6zM2Y5b3iKjKRs0Ee5MlnJ5/zux7TFfwFuFA1JujtCFINSlpb7yFbS00=
X-Gm-Gg: Acq92OE9WKKqpy/tuE55MerP23DGhpZJg2blrP82o5Hm3i46umbwcRWfQCVnG4PdebN
	LxixBjLgHSwVcV0tvHPMpbhSMYRzYbXtGvfHk8bmEmzgous2OJR2aC/WMMuVf9gDLkGbEDmK6Ud
	s1VxSy7+WCXtckKLVDox8LkdGnU9lD7cyMXsHE8SusIbzGtc2zO2KCLf4fyVjcVUw7ruLH61o9Q
	HkLOo1rtwX06YfHMae4qav64kccoCUYvT3/kjSbjq8wv94m+WiNdiZdgwSstICOx4BVpDfRNRpW
	Ml4AsMYfLXIBj03ClNGAjQB2RSM2HQtLLTeoU+2AWkXuECjZTa36Dbc9u9N8dVH9+QTERF59Bxv
	mEZQn+6u9798HgONqIwRYL3/6RzlRSuuy5nQ3SxnW0nGeEDx6Gl9uctl6g+jIAmrQb3Y1FCkmLy
	OAoRb5bKlacK8FXT0yAt2Jb9U1aIZobj1FJJ3Q3Lw+hLE=
X-Received: by 2002:a05:6a00:2e13:b0:835:3949:3c22 with SMTP id d2e1a72fcca58-8434cf17aabmr1096032b3a.27.1781236817042;
        Thu, 11 Jun 2026 21:00:17 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.21.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:00:16 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 13/19] mm/hugetlb: Refactor early boot gigantic hugepage allocation
Date: Fri, 12 Jun 2026 11:58:57 +0800
Message-ID: <20260612035903.2468601-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612035903.2468601-1-songmuchun@bytedance.com>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
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

The early boot gigantic hugepage allocation helpers currently mix
allocation with huge_bootmem_page setup, and leave part of the
initialization flow in architecture code.

Refactor the interface to return the allocated huge page pointer and
move the huge_bootmem_page setup into the generic hugetlb code. This
makes the architecture-specific paths focus only on finding memory,
while the common code handles node placement and early page metadata
setup in one place.

This also lets powerpc benefit from memblock_reserved_mark_noinit(),
which it did not enable before.

In addition, upcoming cross-zone validation for boot-time gigantic
hugetlb reservation is common logic. With this refactoring, that logic
can stay in the generic code instead of being duplicated in
architecture-specific paths.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Oscar Salvador (SUSE) <osalvador@suse.de>
---
 arch/powerpc/mm/hugetlbpage.c | 13 ++---
 include/linux/hugetlb.h       | 18 ++-----
 mm/hugetlb.c                  | 95 ++++++++++++++---------------------
 mm/hugetlb_cma.c              | 13 ++---
 mm/hugetlb_cma.h              |  8 ++-
 mm/internal.h                 |  9 ++++
 6 files changed, 64 insertions(+), 92 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 558fafb82b8a..a298746dc143 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -104,17 +104,14 @@ void __init pseries_add_gpage(u64 addr, u64 page_size, unsigned long number_of_p
 	}
 }
 
-static int __init pseries_alloc_bootmem_huge_page(struct hstate *hstate)
+static __init void *pseries_alloc_bootmem_huge_page(struct hstate *hstate)
 {
-	struct huge_bootmem_page *m;
+	void *m;
 	if (nr_gpages == 0)
-		return 0;
+		return NULL;
 	m = phys_to_virt(gpage_freearray[--nr_gpages]);
 	gpage_freearray[nr_gpages] = 0;
-	list_add(&m->list, &huge_boot_pages[0]);
-	m->hstate = hstate;
-	m->flags = 0;
-	return 1;
+	return m;
 }
 
 bool __init hugetlb_node_alloc_supported(void)
@@ -124,7 +121,7 @@ bool __init hugetlb_node_alloc_supported(void)
 #endif
 
 
-int __init alloc_bootmem_huge_page(struct hstate *h, int nid)
+void *__init arch_alloc_bootmem_huge_page(struct hstate *h, int nid)
 {
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3700c0a1f6ff..09f28dd773b7 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -674,19 +674,11 @@ struct hstate {
 	char name[HSTATE_NAME_LEN];
 };
 
-struct cma;
-
-struct huge_bootmem_page {
-	struct list_head list;
-	struct hstate *hstate;
-	unsigned long flags;
-	struct cma *cma;
-};
-
 #define HUGE_BOOTMEM_HVO		0x0001
 #define HUGE_BOOTMEM_ZONES_VALID	0x0002
 #define HUGE_BOOTMEM_CMA		0x0004
 
+struct huge_bootmem_page;
 bool hugetlb_bootmem_page_zones_valid(int nid, struct huge_bootmem_page *m);
 
 int isolate_or_dissolve_huge_folio(struct folio *folio, struct list_head *list);
@@ -706,8 +698,8 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address, struct folio *folio);
 
 /* arch callback */
-int __init __alloc_bootmem_huge_page(struct hstate *h, int nid);
-int __init alloc_bootmem_huge_page(struct hstate *h, int nid);
+void *__init __alloc_bootmem_huge_page(struct hstate *h, int nid);
+void *__init arch_alloc_bootmem_huge_page(struct hstate *h, int nid);
 bool __init hugetlb_node_alloc_supported(void);
 
 void __init hugetlb_add_hstate(unsigned order);
@@ -1138,9 +1130,9 @@ alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 	return NULL;
 }
 
-static inline int __alloc_bootmem_huge_page(struct hstate *h)
+static inline void *__alloc_bootmem_huge_page(struct hstate *h, int nid)
 {
-	return 0;
+	return NULL;
 }
 
 static inline struct hstate *hstate_file(struct file *f)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2bf9fe16abb9..5e557c05d80a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3027,79 +3027,58 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 static __init void *alloc_bootmem(struct hstate *h, int nid, bool node_exact)
 {
-	struct huge_bootmem_page *m;
-	int listnode = nid;
-
 	if (hugetlb_early_cma(h))
-		m = hugetlb_cma_alloc_bootmem(h, &listnode, node_exact);
-	else {
-		if (node_exact)
-			m = memblock_alloc_exact_nid_raw(huge_page_size(h),
+		return hugetlb_cma_alloc_bootmem(h, nid, node_exact);
+
+	if (node_exact)
+		return memblock_alloc_exact_nid_raw(huge_page_size(h),
 				huge_page_size(h), 0,
 				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
-		else {
-			m = memblock_alloc_try_nid_raw(huge_page_size(h),
+
+	return memblock_alloc_try_nid_raw(huge_page_size(h),
 				huge_page_size(h), 0,
 				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
-			/*
-			 * For pre-HVO to work correctly, pages need to be on
-			 * the list for the node they were actually allocated
-			 * from. That node may be different in the case of
-			 * fallback by memblock_alloc_try_nid_raw. So,
-			 * extract the actual node first.
-			 */
-			if (m)
-				listnode = early_pfn_to_nid(PHYS_PFN(__pa(m)));
-		}
-
-		if (m) {
-			m->flags = 0;
-			m->cma = NULL;
-		}
-	}
-
-	if (m) {
-		/*
-		 * Use the beginning of the huge page to store the
-		 * huge_bootmem_page struct (until gather_bootmem
-		 * puts them into the mem_map).
-		 *
-		 * Put them into a private list first because mem_map
-		 * is not up yet.
-		 */
-		INIT_LIST_HEAD(&m->list);
-		list_add(&m->list, &huge_boot_pages[listnode]);
-		m->hstate = h;
-	}
-
-	return m;
 }
 
-int alloc_bootmem_huge_page(struct hstate *h, int nid)
+void *__init arch_alloc_bootmem_huge_page(struct hstate *h, int nid)
 	__attribute__ ((weak, alias("__alloc_bootmem_huge_page")));
-int __alloc_bootmem_huge_page(struct hstate *h, int nid)
+void *__init __alloc_bootmem_huge_page(struct hstate *h, int nid)
 {
-	struct huge_bootmem_page *m = NULL; /* initialize for clang */
 	int nr_nodes, node = nid;
 
 	/* do node specific alloc */
-	if (nid != NUMA_NO_NODE) {
-		m = alloc_bootmem(h, node, true);
-		if (!m)
-			return 0;
-		goto found;
-	}
+	if (nid != NUMA_NO_NODE)
+		return alloc_bootmem(h, node, true);
 
 	/* allocate from next node when distributing huge pages */
 	for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node,
-				    &hugetlb_bootmem_nodes) {
-		m = alloc_bootmem(h, node, false);
-		if (!m)
-			return 0;
-		goto found;
-	}
+				    &hugetlb_bootmem_nodes)
+		return alloc_bootmem(h, node, false);
 
-found:
+	return NULL;
+}
+
+static bool __init alloc_bootmem_huge_page(struct hstate *h, int nid)
+{
+	struct huge_bootmem_page *m = arch_alloc_bootmem_huge_page(h, nid);
+
+	if (!m)
+		return false;
+
+	nid = early_pfn_to_nid(PHYS_PFN(__pa(m)));
+	/*
+	 * Use the beginning of the huge page to store the huge_bootmem_page
+	 * struct (until gather_bootmem puts them into the mem_map).
+	 *
+	 * Put them into a private list first because mem_map is not up yet.
+	 */
+	INIT_LIST_HEAD(&m->list);
+	list_add(&m->list, &huge_boot_pages[nid]);
+	m->hstate = h;
+	if (!hugetlb_early_cma(h)) {
+		m->cma = NULL;
+		m->flags = 0;
+	}
 
 	/*
 	 * Only initialize the head struct page in memmap_init_reserved_pages,
@@ -3111,7 +3090,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	memblock_reserved_mark_noinit(__pa((void *)m + PAGE_SIZE),
 		huge_page_size(h) - PAGE_SIZE);
 
-	return 1;
+	return true;
 }
 
 /* Initialize [start_page:end_page_number] tail struct pages of a hugepage */
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index ce999391cc14..e487d0ffffc0 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -56,14 +56,13 @@ struct folio *hugetlb_cma_alloc_frozen_folio(int order, gfp_t gfp_mask,
 	return folio;
 }
 
-struct huge_bootmem_page * __init
-hugetlb_cma_alloc_bootmem(struct hstate *h, int *nid, bool node_exact)
+void * __init hugetlb_cma_alloc_bootmem(struct hstate *h, int nid, bool node_exact)
 {
 	struct cma *cma;
 	struct huge_bootmem_page *m;
-	int node = *nid;
+	int node;
 
-	cma = hugetlb_cma[*nid];
+	cma = hugetlb_cma[nid];
 	m = cma_reserve_early(cma, huge_page_size(h));
 	if (!m) {
 		if (node_exact)
@@ -71,13 +70,11 @@ hugetlb_cma_alloc_bootmem(struct hstate *h, int *nid, bool node_exact)
 
 		for_each_node_mask(node, hugetlb_bootmem_nodes) {
 			cma = hugetlb_cma[node];
-			if (!cma || node == *nid)
+			if (!cma || node == nid)
 				continue;
 			m = cma_reserve_early(cma, huge_page_size(h));
-			if (m) {
-				*nid = node;
+			if (m)
 				break;
-			}
 		}
 	}
 
diff --git a/mm/hugetlb_cma.h b/mm/hugetlb_cma.h
index c619c394b1ae..3aa483573d17 100644
--- a/mm/hugetlb_cma.h
+++ b/mm/hugetlb_cma.h
@@ -6,8 +6,7 @@
 void hugetlb_cma_free_frozen_folio(struct folio *folio);
 struct folio *hugetlb_cma_alloc_frozen_folio(int order, gfp_t gfp_mask,
 				      int nid, nodemask_t *nodemask);
-struct huge_bootmem_page *hugetlb_cma_alloc_bootmem(struct hstate *h, int *nid,
-						    bool node_exact);
+void *hugetlb_cma_alloc_bootmem(struct hstate *h, int nid, bool node_exact);
 bool hugetlb_cma_exclusive_alloc(void);
 unsigned long hugetlb_cma_total_size(void);
 void hugetlb_cma_validate_params(void);
@@ -23,9 +22,8 @@ static inline struct folio *hugetlb_cma_alloc_frozen_folio(int order,
 	return NULL;
 }
 
-static inline
-struct huge_bootmem_page *hugetlb_cma_alloc_bootmem(struct hstate *h, int *nid,
-						    bool node_exact)
+static inline void *hugetlb_cma_alloc_bootmem(struct hstate *h, int nid,
+					      bool node_exact)
 {
 	return NULL;
 }
diff --git a/mm/internal.h b/mm/internal.h
index 09efb9f4d126..3401759924d9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -23,6 +23,15 @@
 #include "vma.h"
 
 struct folio_batch;
+struct hstate;
+struct cma;
+
+struct huge_bootmem_page {
+	struct list_head list;
+	struct hstate *hstate;
+	unsigned long flags;
+	struct cma *cma;
+};
 
 /*
  * Maintains state across a page table move. The operation assumes both source
-- 
2.54.0


