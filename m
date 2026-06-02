Return-Path: <linuxppc-dev+bounces-21888-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7D3CD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:12:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV67r48V2z3bqM;
	Tue, 02 Jun 2026 20:12:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395128;
	cv=none; b=jsbsEkhLbYDm8q/DbmObf69Vm2fHEXpcpmufHWuEI3aetWa90yisgF5PiN0AQIK9lNvkXBy33DIhyNgh/zQuzCgT5WjABx2LkOv8sjDXai/a/eFe5L0ojgrR0TcvJ9LbCN2Ru95nFZvGFmYmwGtO4XuoElQ+BomaBjz45n72nQm0HvI5iw1FK+9ur9aSgv0N1pf4jrg85mmGajNg4TUFOKUDVAC7K7WjZjJ98HdYjEh5qE7fyVJ+NF7VnCB+6t4H33NdcFmk7THSY/L7lNSc71/I884iSPFdsAuCZduWxWbf4m/M9gGEbRDCoHL7n3DJU2e/qWN3IbDBpaRQ/ccRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395128; c=relaxed/relaxed;
	bh=izaqgnnNIWyz1SuOc+YrUva6s2Nz3vC7JJgyPQLHyJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPrANkIwz0TOsKvCpv3jn7Khe6H935EUUHP7a7gsBtNxs9ktsjpBd9YDKVKf27fWnM2TEEdiEVSAYifPl+F2DSrX3eVJsGXa4NbQ5YoPTiphIdX+kB41w8C/KfEgMSDI8hsxtOyiMb5YndyMR64etn7O7CgVb49m7X5oP5jdGKIpGH2jcMPUo3trapXnNSMhBjRhDof6Z602II5GIZxnsFNHILLMjwfgNDNOjS5GeYWo8j0nkoQCqogKu4Gci+hdb0WX6a/2H3Dke847T0d8W4azKnX43x6QXaC3aM65g65CLB5iWqARjStc9ftfQ5NfBHCpiJBupXcQKV9VabCIIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BNU15DNl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BNU15DNl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV67q5TV5z3bps
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:12:07 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-8422524cb38so916667b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395126; x=1780999926; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izaqgnnNIWyz1SuOc+YrUva6s2Nz3vC7JJgyPQLHyJ8=;
        b=BNU15DNlmqXLf8pqLxoFkCfR80vkycPKHNWaX6lDcCEv+BCU5WA00HCeQ2MPXZEFU8
         nNItes5M9JKjSJg/gZofjAsWTmnDwWRcN5wX/niiFSqm/9mF+EGxs3lwbbSvrh+VRm7I
         z55xaI6xSDrYlS9y/fhe49uwKXgyT5nXyP2c39bLhOeXyCsKwT/5ORbsOTJLyA7Ukz1A
         qCkaedmuXA8EU9h2JVRPe2LkknWtY2jM40K/hR5boKpHGuY4CFUGqaKdJIP4GD26cdAY
         LMCKq7HRnF9t+SxFDyWzBeXNi8WwnW8HN5jDsjP62xrtHrpY2e3mw5yzoTjzcDCwr9+b
         A1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395126; x=1780999926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=izaqgnnNIWyz1SuOc+YrUva6s2Nz3vC7JJgyPQLHyJ8=;
        b=XQAQyB0OE6zVxVdfEJ47AZgWZzt6WaoNeyX3J82OTmqURkGRjljkrnsTWy3/OEw+lP
         ux9vtKB4EIrNBQe/Rsss4PvNYqjtZWP210W3C4x3K50Em7FFFMnRFLWk+y8e9b30C/6u
         qSfmOSxWI/tkf8b8UZgfxB57CyMvU52LbPFFICnrmyzj5gFa28BUUld7he9MS/EgvDYu
         tZjK8uKqXQBrS5qDTipaFIz6o7gxQimZpX8AZNSuEyBQVVjCFUqjoH5SOutdJUKDUwVW
         rU5MYMQNAdEQX9MpCNJeMeeHuU3pY1138Kd7dOBR8lk9G5shr0vuvk4maAPqimQ4Yxf5
         y+eg==
X-Forwarded-Encrypted: i=1; AFNElJ94w04jnHUIUx5qEu2yGDIq31V9pdk7960HThDtHJ4Plal/If1mtKl/PeFdNF6DydKBXSLKlF2qwzJqPWg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxYiTAK8eRkUs1PAmcFJbebVKp7ypDbLyia/8cqTvfGdvMsMJ0Q
	29wpDX0CCNtgVlXyXIGkXcwAE/munCUrvyIbYcj88au3aLshXnSetj0LfwwGTUx6CV0=
X-Gm-Gg: Acq92OFiXqPt+5MLcnyyzs1U6FqUI2+z+TMFwguRKbFHauBDQrlluhuH7iDtXB2K6FZ
	FhYPPoLbbe0RX2SXuZ6HJdMMC+Lj0xf/oVUGiBsutxkwBufCf6GpsTDtw0UZcr7OwTYPFHBbdNK
	fJmsW0xYpS+5jZvINGCbXfAjbG/PGT1LmXwn5Q16gjgC6az/bq9o+uAQ37NVvUoTFSDsqKA6LOS
	p107tHP9dv5FGHx26cb8C1faB3QkFejWl+8DKIVGokuc2CCK0dFFOhSf9hlvSF6wBqz6jj5Ews5
	F2oiMOSgUeqj+su6EkZ3/rognPWUXPI7+Y/lklsNB2pR8B0l+XYzgjsLvdewCR7dfqaRBquc2NV
	blGNDwA7xJm/5eYwwlJIr/mXYfhGN5lL1JGMr13jf0IVbXoSXtmLJdCOk8ovxPwgQNad4+4TX98
	b/AZrGsFiKl4x9imvf+OoZ/B19Btl2yggzeRuU8CTU3pquUHNKdcCSlZ3RTg07GeDstw==
X-Received: by 2002:a05:6a00:744c:b0:842:3aee:12c1 with SMTP id d2e1a72fcca58-8423aee321dmr9318619b3a.18.1780395125556;
        Tue, 02 Jun 2026 03:12:05 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:12:05 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 13/19] mm/hugetlb: Refactor early boot gigantic hugepage allocation
Date: Tue,  2 Jun 2026 18:10:33 +0800
Message-ID: <20260602101039.1867613-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602101039.1867613-1-songmuchun@bytedance.com>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
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
v2->v3:
- keep powerpc code independent of struct huge_bootmem_page by switching
  it to void * (per Mike Rapoport)
- move huge_bootmem_page internals out of include/linux/hugetlb.h and keep
  them in mm-private scope so the arch code does not need to see the type
  (per Mike Rapoport, echoed by Oscar Salvador)
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
index 004a3f1d5006..6b9802460a7c 100644
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


