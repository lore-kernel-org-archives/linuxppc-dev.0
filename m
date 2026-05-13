Return-Path: <linuxppc-dev+bounces-20879-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF913CD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:11:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv2j61fxz2yYd;
	Wed, 13 May 2026 23:10:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677821;
	cv=none; b=GgPKr4ONtNkhxvuIX1gb1wum+O7rlfTSMd03OypdYQZ2B39GbdMzy2EzlLDgwrFFXosUEbKb3St4LQQ9fcMpAlNiN+SN+yHyAaoEAF+8R1F3WNxL58xs694jR/nKj4I+N080Oe0qz8mn/FsHkqpi2qM6G99gOX1N0k6qJjCYGSA1e2yrWC0k3WcbAvY1ZsHRXpb2SnsfBOX4pv4yTkixnHLsYMfddIbLi2qbf6gcLKB9NA4SECUn0R0KFVjCJTHPj3R/WQI90krApctxvvYXlNaqSNOgNQOU8ucpTnaf4+43Tzo0yIMgmDQ4Ainx0vm09jIOtPCqApI9JTILXjdpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677821; c=relaxed/relaxed;
	bh=OR7HeIKD4yKpxE8z6TINwIVqXU1D5zEjTSKwc02PFRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fn06bnrY2W+vhg1Wtr4fSXzUUuwWYRURxqEK8TD1gAeBv74bESo5u1DGwrQNy1FIcBjeOXpLFuimY4bXlpCyTiSsiFrCvb8spJBv5UkYpCHiBZz9yGx5Vei1djvdHqgvlwUgvJSEBpGbAEItI26b5EBiPJ07KP1f1Q53wb/bJnZJpYAtWleE17Z6lH0hPPQDIAuJzTw7s/iGIxwkXEjnqCULmQlKCeuBbTI2Nhnw7vpOCDjEUCplu16pOnjFWqpFpsznVejV9W0D/5sz5/YCHngmXdMzmj7js6Pr5Wwf8tAGS9cvVHejutL0+FGUeR3XgfwtUwCfmRcBMyyHu4hqAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ApQzJ/4T; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ApQzJ/4T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv2h5LWrz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:10:20 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c82471904fcso2969256a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677819; x=1779282619; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OR7HeIKD4yKpxE8z6TINwIVqXU1D5zEjTSKwc02PFRM=;
        b=ApQzJ/4TsuPph72kqqn8d1rJUkhM2DWjqTvwc7gLriwWvdk9cb8+aoghA5wsUQyD0P
         7nK+BSX4fIm16+y8K48SVYicRvOhOhp5rlWiwrZhmYpnFxp13uenw7Q9tKWCeCOc9B0p
         z/QOAfeXaV5IYGg9q9dk+AWNWUVitA1l1NQ6FIIOSsFukXzfIbDuLlD9Ci4H3an8rkdH
         uA4U4hp17mDoWWdTfu2w2o9r47zLc1MNcrlEG1GeWXaSJ/BE/yJL0A382FQuPrWPEleH
         E8nKO9CX5TGAx2kGuDgKrAORsQ6DwaGXqMS8VQH+gWYZdI0smlRKDSvhFUF9zXsCorEH
         rW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677819; x=1779282619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OR7HeIKD4yKpxE8z6TINwIVqXU1D5zEjTSKwc02PFRM=;
        b=AlyD5yeumqlAWdaRilWXq/SLspR4w4XEijROuhm3T+3/PKVpxcU9bzg35OzbvwB/Rw
         4nGCianSgTTb2Pl2KT5tGIsDXKhxTZgYAWzGTAfBJ7R2ERO9DnIpo9AidRB/PxBgCJ/f
         pRAHWqfMrp6BfX10CXKCaGZSBXuGGIvNNRJ+6FCxjOun8oejJvfEaXgIrnB+inNGKpE+
         cgxZQOZp1Fq80Okj1eWLlC9fH9fqr7VfLBGj/BbFRt8dh4qK0ev/CXpos1PWpfxabSTg
         sfAL3z6p3wGmDHnnn5FDe48o+0HSBFFPrW8dV70quFsk3+9CtjK9GvfBnzRfUuVkViY5
         b80w==
X-Forwarded-Encrypted: i=1; AFNElJ/0ttzKMYsIoMEtsEnNJ4j051SLx9YCCfQdFxR67fzWiv/h0G9IcKTYS7U77XZvQljSDjzkq7T8uoMSBBk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxzyTi1zTymAUgoYYxrMi+kCuVWBzC4fMf9H9m4ZlwL+GEq72zq
	QAQYxRZH9WAojHcbRYD9YJ5SlZvUQsOout6CvbyUPZS2z79Hd6KXGTZ/50P+fxzkqqs=
X-Gm-Gg: Acq92OGADZu+yhap++bM9qG+3c35GmJjvTPuewt3E3GYHck8VNuSEI2JZo/6W2JxrWa
	5Duki7dGwdeLBBs1h8/N0ygvV4P7k5yPvwM5HZRoS2kXLF/JYG0WqEBkpzu4DpfSz5sOIPIcU9G
	izQvLrj2vmGLteTQkWEzGjxbnD7lwAdd+mveZCAuqR1NSlo5P5tViV19HESuDnh+wToXTCWLLIe
	3bITnIk0QEhcX09BTChGnC1NhxwrcWGzMM7GAUMu6y1Lvajrd0A9UWCacGzhPpZH9mPGvVmH7mn
	IV8tAnI0q9WNyhRrZzbjkv9S/WD1spdkZdjGdYApkTXFdfmVUJX7Xl1nAnDTJQNuIx6oPfwdDKF
	OUW+54vs1R24MGQiom5CCR12oIkSu2inv2+TJLAExMQCETysKraEW9NjVC3XkzIG99l0Wp8hnfa
	ruhen5IRvJtjjiOjMcZ9E2G9RNcx8otEYXy53oOunLb8Zv2yVEuEm0RtJa5Wr+Zmqod2wRAQ==
X-Received: by 2002:a17:903:3905:b0:2ba:c453:ed3a with SMTP id d9443c01a7336-2bd2718da07mr36777045ad.16.1778677818683;
        Wed, 13 May 2026 06:10:18 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.10.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:10:18 -0700 (PDT)
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
Subject: [PATCH v2 30/69] mm/hugetlb: Switch HugeTLB to section-based vmemmap optimization
Date: Wed, 13 May 2026 21:04:58 +0800
Message-ID: <20260513130542.35604-31-songmuchun@bytedance.com>
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

HugeTLB bootmem vmemmap optimization still carries its own early setup
path, including pre-populating optimized mappings before the generic
sparse-vmemmap code runs.

Now that section metadata records the compound page order, HugeTLB only
needs to mark the bootmem huge page range with that order.  The generic
sparse-vmemmap population path can then allocate and map the shared tail
vmemmap pages without any HugeTLB-specific early population code.

Do that by setting the section order when a bootmem huge page is
allocated and dropping the dedicated pre-HVO helpers and related
special-casing.

This removes duplicate early setup logic and switches HugeTLB to the
section-based vmemmap optimization path.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |   1 -
 include/linux/mm.h      |   3 -
 include/linux/mmzone.h  |  17 ++++++
 mm/bootmem_info.c       |   5 +-
 mm/hugetlb.c            |  26 ++-------
 mm/hugetlb_vmemmap.c    | 124 ++++++----------------------------------
 mm/hugetlb_vmemmap.h    |  13 ++---
 mm/sparse-vmemmap.c     |  29 ----------
 8 files changed, 45 insertions(+), 173 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index fd901bb3630c..dce8969961ea 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -171,7 +171,6 @@ struct address_space *hugetlb_folio_mapping_lock_write(struct folio *folio);
 
 extern int movable_gigantic_pages __read_mostly;
 extern int sysctl_hugetlb_shm_group __read_mostly;
-extern struct list_head huge_boot_pages[MAX_NUMNODES];
 
 void hugetlb_struct_page_init(void);
 void hugetlb_bootmem_alloc(void);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 31e27ff6a35f..f39f6fca6551 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4864,9 +4864,6 @@ int vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 			       int node, struct vmem_altmap *altmap);
 int vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap);
-int vmemmap_populate_hvo(unsigned long start, unsigned long end,
-			 unsigned int order, struct zone *zone,
-			 unsigned long headsize);
 void vmemmap_wrprotect_hvo(unsigned long start, unsigned long end, int node,
 			  unsigned long headsize);
 void vmemmap_populate_print_last(void);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index bf4c40818b63..d6a5dd042c25 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2264,6 +2264,18 @@ static inline unsigned int section_order(const struct mem_section *section)
 }
 #endif
 
+static inline void section_set_order_range(unsigned long pfn, unsigned long nr_pages,
+					   unsigned int order)
+{
+	unsigned long section_nr = pfn_to_section_nr(pfn);
+
+	if (!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION))
+		return;
+
+	for (unsigned long i = 0; i < nr_pages / PAGES_PER_SECTION; i++)
+		section_set_order(__nr_to_section(section_nr + i), order);
+}
+
 static inline unsigned int pfn_to_section_order(unsigned long pfn)
 {
 	return section_order(__pfn_to_section(pfn));
@@ -2417,6 +2429,11 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
 #else
 #define sparse_vmemmap_init_nid_early(_nid) do {} while (0)
 #define pfn_in_present_section pfn_valid
+static inline void section_set_order_range(unsigned long pfn, unsigned long nr_pages,
+					   unsigned int order)
+{
+}
+
 static inline unsigned int pfn_to_section_order(unsigned long pfn)
 {
 	return 0;
diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index 3d7675a3ae04..24f45d86ffb3 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -51,9 +51,8 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
 	section_nr = pfn_to_section_nr(start_pfn);
 	ms = __nr_to_section(section_nr);
 
-	if (!preinited_vmemmap_section(ms))
-		register_page_bootmem_memmap(section_nr, pfn_to_page(start_pfn),
-					     PAGES_PER_SECTION);
+	register_page_bootmem_memmap(section_nr, pfn_to_page(start_pfn),
+				     PAGES_PER_SECTION);
 
 	usage = ms->usage;
 	page = virt_to_page(usage);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8debe5c5abce..080f130017e3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -57,7 +57,7 @@ unsigned int default_hstate_idx;
 struct hstate hstates[HUGE_MAX_HSTATE];
 
 __initdata nodemask_t hugetlb_bootmem_nodes;
-__initdata struct list_head huge_boot_pages[MAX_NUMNODES];
+static __initdata struct list_head huge_boot_pages[MAX_NUMNODES];
 
 /*
  * Due to ordering constraints across the init code for various
@@ -3111,6 +3111,7 @@ static bool __init alloc_bootmem_huge_page(struct hstate *h, int nid)
 	} else {
 		list_add_tail(&m->list, &huge_boot_pages[nid]);
 		m->flags |= HUGE_BOOTMEM_ZONES_VALID;
+		hugetlb_vmemmap_optimize_bootmem_page(m);
 		/*
 		 * Only initialize the head struct page in memmap_init_reserved_pages,
 		 * rest of the struct pages will be initialized by the HugeTLB
@@ -3264,13 +3265,15 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 					   OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES);
 		init_new_hugetlb_folio(folio);
 
-		if (hugetlb_bootmem_page_prehvo(m))
+		if (hugetlb_bootmem_page_prehvo(m)) {
 			/*
 			 * If pre-HVO was done, just set the
 			 * flag, the HVO code will then skip
 			 * this folio.
 			 */
 			folio_set_hugetlb_vmemmap_optimized(folio);
+			section_set_order_range(folio_pfn(folio), folio_nr_pages(folio), 0);
+		}
 
 		if (hugetlb_bootmem_page_earlycma(m))
 			folio_set_hugetlb_cma(folio);
@@ -3314,25 +3317,6 @@ void __init hugetlb_struct_page_init(void)
 		.max_threads	= num_node_state(N_MEMORY),
 		.numa_aware	= true,
 	};
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-	struct zone *zone;
-
-	for_each_zone(zone) {
-		for (int i = 0; i < NR_OPTIMIZABLE_FOLIO_ORDERS; i++) {
-			struct page *tail, *p;
-			unsigned int order;
-
-			tail = zone->vmemmap_tails[i];
-			if (!tail)
-				continue;
-
-			order = i + OPTIMIZABLE_FOLIO_MIN_ORDER;
-			p = page_to_virt(tail);
-			for (int j = 0; j < PAGE_SIZE / sizeof(struct page); j++)
-				init_compound_tail(p + j, NULL, order, zone);
-		}
-	}
-#endif
 
 	padata_do_multithreaded(&job);
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4367118f8f57..730190390ba9 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -16,6 +16,7 @@
 #include <linux/mmdebug.h>
 #include <linux/pagewalk.h>
 #include <linux/pgalloc.h>
+#include <linux/io.h>
 
 #include <asm/tlbflush.h>
 #include "hugetlb_vmemmap.h"
@@ -478,12 +479,8 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 	return ret;
 }
 
-/* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
-static bool vmemmap_should_optimize_folio(const struct hstate *h, struct folio *folio)
+static inline bool vmemmap_should_optimize(const struct hstate *h)
 {
-	if (folio_test_hugetlb_vmemmap_optimized(folio))
-		return false;
-
 	if (!READ_ONCE(vmemmap_optimize_enabled))
 		return false;
 
@@ -493,6 +490,15 @@ static bool vmemmap_should_optimize_folio(const struct hstate *h, struct folio *
 	return true;
 }
 
+/* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
+static bool vmemmap_should_optimize_folio(const struct hstate *h, struct folio *folio)
+{
+	if (folio_test_hugetlb_vmemmap_optimized(folio))
+		return false;
+
+	return vmemmap_should_optimize(h);
+}
+
 static struct page *vmemmap_get_tail(unsigned int order, struct zone *zone)
 {
 	const unsigned int idx = order - OPTIMIZABLE_FOLIO_MIN_ORDER;
@@ -638,9 +644,6 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 			epfn = spfn + hugetlb_vmemmap_size(h);
 			vmemmap_wrprotect_hvo(spfn, epfn, folio_nid(folio),
 					OPTIMIZED_FOLIO_VMEMMAP_SIZE);
-			register_page_bootmem_memmap(pfn_to_section_nr(folio_pfn(folio)),
-					&folio->page,
-					OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES);
 			continue;
 		}
 
@@ -706,111 +709,18 @@ void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h, struct list_head
 	__hugetlb_vmemmap_optimize_folios(h, folio_list, true);
 }
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
-
-/* Return true of a bootmem allocated HugeTLB page should be pre-HVO-ed */
-static bool vmemmap_should_optimize_bootmem_page(struct huge_bootmem_page *m)
-{
-	unsigned long section_size, psize, pmd_vmemmap_size;
-	phys_addr_t paddr;
-
-	if (!READ_ONCE(vmemmap_optimize_enabled))
-		return false;
-
-	if (!hugetlb_vmemmap_optimizable(m->hstate))
-		return false;
-
-	psize = huge_page_size(m->hstate);
-	paddr = virt_to_phys(m);
-
-	/*
-	 * Pre-HVO only works if the bootmem huge page
-	 * is aligned to the section size.
-	 */
-	section_size = (1UL << PA_SECTION_SHIFT);
-	if (!IS_ALIGNED(paddr, section_size) ||
-	    !IS_ALIGNED(psize, section_size))
-		return false;
-
-	/*
-	 * The pre-HVO code does not deal with splitting PMDS,
-	 * so the bootmem page must be aligned to the number
-	 * of base pages that can be mapped with one vmemmap PMD.
-	 */
-	pmd_vmemmap_size = (PMD_SIZE / (sizeof(struct page))) << PAGE_SHIFT;
-	if (!IS_ALIGNED(paddr, pmd_vmemmap_size) ||
-	    !IS_ALIGNED(psize, pmd_vmemmap_size))
-		return false;
-
-	return true;
-}
-
-static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn);
-
-/*
- * Initialize memmap section for a gigantic page, HVO-style.
- */
-void __init hugetlb_vmemmap_init_early(int nid)
+void __init hugetlb_vmemmap_optimize_bootmem_page(struct huge_bootmem_page *m)
 {
-	unsigned long psize, paddr, section_size;
-	unsigned long ns, i, pnum, pfn, nr_pages;
-	unsigned long start, end;
-	struct huge_bootmem_page *m = NULL;
-	void *map;
+	struct hstate *h = m->hstate;
+	unsigned long pfn = PHYS_PFN(__pa(m));
 
-	if (!READ_ONCE(vmemmap_optimize_enabled))
+	if (!vmemmap_should_optimize(h))
 		return;
 
-	section_size = (1UL << PA_SECTION_SHIFT);
-
-	list_for_each_entry(m, &huge_boot_pages[nid], list) {
-		struct zone *zone;
-
-		if (!vmemmap_should_optimize_bootmem_page(m))
-			continue;
-
-		nr_pages = pages_per_huge_page(m->hstate);
-		psize = nr_pages << PAGE_SHIFT;
-		paddr = virt_to_phys(m);
-		pfn = PHYS_PFN(paddr);
-		map = pfn_to_page(pfn);
-		start = (unsigned long)map;
-		end = start + hugetlb_vmemmap_size(m->hstate);
-		zone = pfn_to_zone(nid, pfn);
-
-		if (vmemmap_populate_hvo(start, end, huge_page_order(m->hstate),
-					 zone, OPTIMIZED_FOLIO_VMEMMAP_SIZE))
-			panic("Failed to allocate memmap for HugeTLB page\n");
-		memmap_boot_pages_add(OPTIMIZED_FOLIO_VMEMMAP_PAGES);
-
-		pnum = pfn_to_section_nr(pfn);
-		ns = psize / section_size;
-
-		for (i = 0; i < ns; i++) {
-			sparse_init_early_section(nid, map, pnum,
-					SECTION_IS_VMEMMAP_PREINIT);
-			map += section_map_size();
-			pnum++;
-		}
-
+	section_set_order_range(pfn, pages_per_huge_page(h), huge_page_order(h));
+	if (section_vmemmap_optimizable(__pfn_to_section(pfn)))
 		m->flags |= HUGE_BOOTMEM_HVO;
-	}
-}
-
-static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn)
-{
-	struct zone *zone;
-	enum zone_type zone_type;
-
-	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
-		zone = &NODE_DATA(nid)->node_zones[zone_type];
-		if (zone_spans_pfn(zone, pfn))
-			return zone;
-	}
-
-	return NULL;
 }
-#endif
 
 static const struct ctl_table hugetlb_vmemmap_sysctls[] = {
 	{
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 66e11893d076..0d8c88997066 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -9,8 +9,6 @@
 #ifndef _LINUX_HUGETLB_VMEMMAP_H
 #define _LINUX_HUGETLB_VMEMMAP_H
 #include <linux/hugetlb.h>
-#include <linux/io.h>
-#include <linux/memblock.h>
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio);
@@ -20,10 +18,7 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h, struct list_head *folio_list);
-#ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
-void hugetlb_vmemmap_init_early(int nid);
-#endif
-
+void hugetlb_vmemmap_optimize_bootmem_page(struct huge_bootmem_page *m);
 
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
 {
@@ -69,13 +64,13 @@ static inline void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h,
 {
 }
 
-static inline void hugetlb_vmemmap_init_early(int nid)
+static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
+	return 0;
 }
 
-static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
+static inline void hugetlb_vmemmap_optimize_bootmem_page(struct huge_bootmem_page *m)
 {
-	return 0;
 }
 #endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 69ae40692e41..b86634903fc0 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -32,7 +32,6 @@
 #include <asm/dma.h>
 #include <asm/tlbflush.h>
 
-#include "hugetlb_vmemmap.h"
 #include "internal.h"
 
 /*
@@ -372,33 +371,6 @@ static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *
 	return tail;
 }
 
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-int __meminit vmemmap_populate_hvo(unsigned long addr, unsigned long end,
-				       unsigned int order, struct zone *zone,
-				       unsigned long headsize)
-{
-	unsigned long maddr;
-	struct page *tail;
-	pte_t *pte;
-	int node = zone_to_nid(zone);
-
-	tail = vmemmap_get_tail(order, zone);
-	if (!tail)
-		return -ENOMEM;
-
-	for (maddr = addr; maddr < addr + headsize; maddr += PAGE_SIZE) {
-		pte = vmemmap_populate_address(maddr, node, NULL, -1);
-		if (!pte)
-			return -ENOMEM;
-	}
-
-	/*
-	 * Reuse the last page struct page mapped above for the rest.
-	 */
-	return vmemmap_populate_range(maddr, end, node, NULL, page_to_pfn(tail));
-}
-#endif
-
 void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 				      unsigned long addr, unsigned long next)
 {
@@ -600,7 +572,6 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
  */
 void __init sparse_vmemmap_init_nid_early(int nid)
 {
-	hugetlb_vmemmap_init_early(nid);
 }
 #endif
 
-- 
2.54.0


