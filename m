Return-Path: <linuxppc-dev+bounces-20862-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6914ECD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:09:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv0v4gtqz2yGf;
	Wed, 13 May 2026 23:08:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677727;
	cv=none; b=dBAGPdh5viWtSdEj4BmEIUWWuS02KWHNswLIzGoQqSykvaGkScYjLm0yyWR5ShscxuEMdHiMUIZAHrw3O8ZUh/WNxRbJ/PMc9JxZ/vlS5mc0VnS0U9NJKpjYvJTfPcIf+LKdOAhMVty9J96a6JjG8Mtea/IAndwMgn916RbBu97cwBw23RuSjgB7rwHVVRa3qK2vnIyjephfni1OuwPVDJYrJ0dyiocayz/KaQM11GEa4QaW6HxUvpwQIBCzajLSpoDDLDdZw0tQe9/zfm6IXmw/MzNrS7byljZaLfuaHGJY2IlLOkjYQ2cGVc3QJqQQWhigbrH+raFJt56iDbtNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677727; c=relaxed/relaxed;
	bh=8SgGCn4266En8ULwXbiJTViXgAGbT0n5na/Xl2vlhYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4zQQUV4E+YFjBSkE/6ql8NtE7HgAMCYioApSEhDF47IaxVeehZaHvQgC2hytLdhD//tMijI/W4WZML2O8DGwymrxsljLs2/4tZod+a7VvFhXzvBWL31BUXp5HF11G811sXW/cbPzemcmj9VMHKPXYTrL7t6XvMlbQD4J215ozVcBBO+6rPo2kH8DPcYnK/k9Z8apYRD5qTaRfReHZAy6GSe54JLH9NWhVZpuVzSJ90KjNDA1H3HmStN2BXGY1tzZhNzpJSHRSJk9PHP7j+mNNEZbvlQCw2ZzsxeZw1izuFtSBz/8+T7tnb3UNzogfYRgucTXvgNxaho/2y7LlV2Ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=YhETcY9B; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=YhETcY9B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv0t6Hv3z2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:08:46 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2ba4a1a0325so46775635ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677725; x=1779282525; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SgGCn4266En8ULwXbiJTViXgAGbT0n5na/Xl2vlhYU=;
        b=YhETcY9BIX0ap5iLZhjDQnBTwSuJUfwQ9tVXWD/vgZixGltj0dmmLR9KWhd7R0aRek
         kh28omzFQIyhPSXSridtyFcSbUvhMvxo065Pzh62f2f9Q6y9xKTvZXLOszDz8tCsf79p
         8AMWNgr9IMVfs6cC7cfO7mvLK+ygITO2C2PIxyetUdd1XLPtoN8CffO3AK28e7cxvJ4+
         rW1QezGy6g6fZMsmotpVmil1rQiQN91mcdYy/fsCdPsWAO/iWw7QoTyQFWnKvWl3sId3
         Y5kSIhLTq/IwD1HY6OvPODmRxfZ+OtFkeSeZ6y82A14AbElSEWB7mN5jkjxg5JoX3eBG
         21Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677725; x=1779282525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8SgGCn4266En8ULwXbiJTViXgAGbT0n5na/Xl2vlhYU=;
        b=D+39nvUBw7XuYDam0P3KxA1hLE3DnRiUFiULTsIelYUH1A49douxkHd04NnIAr3JS4
         S6SxD7n2+exbPXmJpXhoh6ypnnt6hHolSQ97fGrwAdNfkB8ZKVapqBUEWMgE54avLCwh
         bnunwt6AVQVZuijevdyRuVKrr54OIAqmj0bsotS336GlZFm5ur+NJMWv4LmrhaoR91xM
         /403F1HW84sOp1RKLc02R/tGp3phDh9iSWuU/NgBms5LxyfWAyBNDLzVZjYV3TEm48aR
         MQPgl0o1VTu7jFzyTo03Bb7dIxtovJTwU+kfHB8oDEUN0fKNERvFrQZcHjXVWzRNGym/
         U3VQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MHkk+2NamudaYOWu9Zl+YufeR+dP+pzTYOx79xsHR9wv4Ze9Vq+FLUEj+XQ9LIZKzEsvlIDGCOOlB8JY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy1RtKdG1DjpyclQG9+wHEfA+qq1gR7MmlrGguz3Jd/yDfUid8/
	aor0s1fxFVBpKAK7DrnavKEgjVNE0uquDklpI0L6fqIlqd3MZ3/YyworQQABoaRGiLE=
X-Gm-Gg: Acq92OH7/nRnmk/g2rwMeJFsWx+uYGrVFhLC9EJTiZuzvng0z5YFMZTjC199KwyE1/c
	zoI8+qPo0BZ+gS+MfUfE4ShLX0tFCCceH9u2/99DkgqTXuBwhEUokiXhvj9Vpnf52NMKqYCvjIW
	/RTcjhAzvNFlw19rEovPY62sOWV+Yw03LF+ICPrtWRHpOhPJeq9StXtgcZJ/m3vBQeP1NPF17nW
	MVjXMx21aIYMCyZykpokt1H/JNJmHOe00Jvp3UE/RoCGQDPWLHsN2EGG9refBJgYf0YbGSXL9Tu
	X1mQIFWWsE0MqTPCm9tRgpXLE0UTGx6YBH66kYEYWLcVLBpfVPyMhlSst40xIY590rFCA8n15aT
	hYu1SwI5pZreYKAdOm7M+Kkv7d2HBhC59xwtZeewB72stS6+tRb8nfF9hqLIByDZUHlflD65n6S
	vNFNmPmTOdlC0kK59gVhnj8EtPqFconCSJX16s9Ts0PX9+smrjsxHSoPyv38E=
X-Received: by 2002:a17:903:138a:b0:2bc:eea4:83c3 with SMTP id d9443c01a7336-2bd276f5ce9mr42050215ad.25.1778677724547;
        Wed, 13 May 2026 06:08:44 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.08.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:08:44 -0700 (PDT)
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
Subject: [PATCH v2 13/69] mm/hugetlb: Refactor early boot gigantic hugepage allocation
Date: Wed, 13 May 2026 21:04:41 +0800
Message-ID: <20260513130542.35604-14-songmuchun@bytedance.com>
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
---
 arch/powerpc/mm/hugetlbpage.c | 11 ++--
 include/linux/hugetlb.h       |  8 +--
 mm/hugetlb.c                  | 95 ++++++++++++++---------------------
 mm/hugetlb_cma.c              | 12 ++---
 mm/hugetlb_cma.h              |  4 +-
 5 files changed, 52 insertions(+), 78 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 558fafb82b8a..ff8c5ec831bb 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -104,17 +104,14 @@ void __init pseries_add_gpage(u64 addr, u64 page_size, unsigned long number_of_p
 	}
 }
 
-static int __init pseries_alloc_bootmem_huge_page(struct hstate *hstate)
+static __init void *pseries_alloc_bootmem_huge_page(struct hstate *hstate)
 {
 	struct huge_bootmem_page *m;
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
index 52a2c30f866c..9a65271d167c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -720,8 +720,8 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address, struct folio *folio);
 
 /* arch callback */
-int __init __alloc_bootmem_huge_page(struct hstate *h, int nid);
-int __init alloc_bootmem_huge_page(struct hstate *h, int nid);
+void *__init __alloc_bootmem_huge_page(struct hstate *h, int nid);
+void *__init arch_alloc_bootmem_huge_page(struct hstate *h, int nid);
 bool __init hugetlb_node_alloc_supported(void);
 
 void __init hugetlb_add_hstate(unsigned order);
@@ -1152,9 +1152,9 @@ alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
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
index b4999653a156..e9ba0be2eb17 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3044,79 +3044,58 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
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
@@ -3128,7 +3107,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	memblock_reserved_mark_noinit(__pa((void *)m + PAGE_SIZE),
 		huge_page_size(h) - PAGE_SIZE);
 
-	return 1;
+	return true;
 }
 
 /* Initialize [start_page:end_page_number] tail struct pages of a hugepage */
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index 57a7b3acc758..6b5c2aec4449 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -57,13 +57,13 @@ struct folio *hugetlb_cma_alloc_frozen_folio(int order, gfp_t gfp_mask,
 }
 
 struct huge_bootmem_page * __init
-hugetlb_cma_alloc_bootmem(struct hstate *h, int *nid, bool node_exact)
+hugetlb_cma_alloc_bootmem(struct hstate *h, int nid, bool node_exact)
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
@@ -71,13 +71,11 @@ hugetlb_cma_alloc_bootmem(struct hstate *h, int *nid, bool node_exact)
 
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
index c619c394b1ae..057852c792bd 100644
--- a/mm/hugetlb_cma.h
+++ b/mm/hugetlb_cma.h
@@ -6,7 +6,7 @@
 void hugetlb_cma_free_frozen_folio(struct folio *folio);
 struct folio *hugetlb_cma_alloc_frozen_folio(int order, gfp_t gfp_mask,
 				      int nid, nodemask_t *nodemask);
-struct huge_bootmem_page *hugetlb_cma_alloc_bootmem(struct hstate *h, int *nid,
+struct huge_bootmem_page *hugetlb_cma_alloc_bootmem(struct hstate *h, int nid,
 						    bool node_exact);
 bool hugetlb_cma_exclusive_alloc(void);
 unsigned long hugetlb_cma_total_size(void);
@@ -24,7 +24,7 @@ static inline struct folio *hugetlb_cma_alloc_frozen_folio(int order,
 }
 
 static inline
-struct huge_bootmem_page *hugetlb_cma_alloc_bootmem(struct hstate *h, int *nid,
+struct huge_bootmem_page *hugetlb_cma_alloc_bootmem(struct hstate *h, int nid,
 						    bool node_exact)
 {
 	return NULL;
-- 
2.54.0


