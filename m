Return-Path: <linuxppc-dev+bounces-28098-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B565FC98314
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 07:58:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr5mf6dxlz2y24;
	Thu, 24 Sep 2026 17:58:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::2b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790236690;
	cv=none; b=hzgARe6D1tBxSppWeLhGVUF8UVpypF6kFATYsOjd7dpZBFEO/ePbhYcCnTfgPZvEhiZ8EAaXfSVbF9N5TR3rp6JMhcwciTO6JBh8oTJj4k1V5tV9Hl9Ezbp5XBTsh1zuIvotPo9lhb8LJWBqhFElcy0EQAmmj2TDo0aTWGAb8M1GXuVqTEHzsWTTrWHklO1QgOHqUEc/cNZLAvtc1+06p4ieOSj8WtfpuV4gaE7E0Namd7S+Mw+J5nELuPsyJTkLBdqI2I1bJBapCqx0Df8j+L6c8cR3YiNgQGFH+YbIsQcmZyezkntiZMBQu1wwPDqeImHAm0IdErVxCEgdSshNDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790236690; c=relaxed/relaxed;
	bh=VgA5dgb5izhCu2j+FaX7Ht7UUGMfz5OynkoaMbINRFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3B2xa0muON6NSOOv6GX0TOlpAgbypFi9D0NLBhbVJpp9/zWT+AxUeTcEnRn5016Jk6NEvN/qPsCXacTntLcAGdL7HalT2ezn2T169luJ0/BRsg00rpibWprQ9lV8SfhcNTfeCl2W2MsOcoFLhouc29nYZrv2F/H2NlFFXXmJHNvB72xQu0u2fT3P5scGrEY0v4+wR6k8NWHWP59NOifUgs2OzFz71AgxIDE1FsYHkNVa4TfGWrTbHVWfLX8KzGELQyWBGZPDND0/wVAaK61weOzn4NWO/OUdTV/kfsshoL7bOxKrbxGFKBzIRU4W6tDTd7xO+9OwdNiFoxMFOWKQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Djpt21dx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::2b; helo=mail-pz2-x2b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Djpt21dx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:3b::2b; helo=mail-pz2-x2b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x2b.google.com (mail-pz2-x2b.google.com [IPv6:2607:f8b0:4864:3b::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr5md2rmhz30TL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 17:58:08 +1000 (AEST)
Received: by mail-pz2-x2b.google.com with SMTP id 41be03b00d2f7-cc515bef69dso854803a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 00:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790236687; x=1790841487; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VgA5dgb5izhCu2j+FaX7Ht7UUGMfz5OynkoaMbINRFs=;
        b=Djpt21dxDNcWTLfqLCqwFFsddsMPSAMDwbl/0R1SVeJKx3LNQci8rIKWFPQEN49Ea8
         dB7xDOAj6vY50ovqhob79tB6CpTOXa0I3H3Yf3eSlWTs4T9GUfhiMyV73cmrIf7jLfcB
         kpDap2r59tYEAzcloqGZkx66TWJhmS2bqGjXTWUrEIuW6BPvd3vdK7uQKWHn3p8CTErH
         yi3VWOjIw0gPP3PoJBNBSS2vhy/rXT73MuzCJlW05BvFc5J6JL3OEM7zN4iOpVEiS2xy
         6QRpTe9a+AK72FPvdSXiHkzbwrA2xgma/PnZYOrKLSz2IcCJ9VIGt+mytQ4Wa9rdaJxu
         2LqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790236687; x=1790841487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VgA5dgb5izhCu2j+FaX7Ht7UUGMfz5OynkoaMbINRFs=;
        b=YM8N5huAMAY6f9YmSda30OBh+9vPpUqznEfbxIAB370ErPo3DR+a5KDFxFCTZgU4qL
         x8UZpJmDF06P3Sa83lF0iAIvq+J5Zn4uMz+NG0sd4cIbryphsXAgGArB9Q5qN57Wfekt
         y9wCsz7Q2dth04eefy/8E4d/cn1+1SV3dwwpVxoLP8sg0p6XoVdnnS+ld+XsKhIv/KRA
         24eSwNb3sBo7s/7u+g8jZALvmuBbj0pkWMg+pVnBNyN50tMxVmh3n5tos65vdYVEQW4+
         OPcs2mCZ8RxuSqe8X1BUoxpglYANMAMyZVHg3+oS6xOOUIBdQZOVC4G+1Qun4K8bBQti
         6mfA==
X-Forwarded-Encrypted: i=1; AKwUvBwrwHLNoKyNgzvKbbV5iqvFAKKT1eNI2wQch8gGmnkJT6yvMXkWuGVGVQb3nd1YT7C7iq6oZlmCJJhqVk8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nWJdZ3uVN3Uu4EidRyp8fI7xyzfxi8MVJFav4J+pHsIoeIe3lu
	ImSOjRmmPZJwy4sWnhol9fpH3NbKIcfkP4Hrj+PqmFnGmdm6mWSbBe+mfY6FMw58rBE=
X-Gm-Gg: AYBFou0LOQyqGJ8nEmDvNsnUkpPcsYrRaCCa6t2UscnZaflojtRdCwBSVBWGNNYEK7j
	1jO/oMwrLhlx9em2W1DI+Xn4OnM8SHbNM8hK396VIBr9nz+1SrpMjxXE3S18fSisWYI1ndqPBzL
	AkY44YBrr5Ixim8wzBRklfNBDu4PFeGRuoReX7deCyzDZTacNDIkKSaRlhvmDGhA//547wTfWro
	72xGBmxb1INEuGMt0JNaAxfShr17CgQyrWTSUIHBQz25IXHDaDvU0hpkJCxC71uF7duo5jO4UdS
	Q/AMZtN99fwdEWvJ/k487+Js37B5KPuOpauC3+7DoROt5aEvR4/PexHpV71F49t50icbstz+/JR
	SPPIBxvO7fxvDbLdoEvrTEGdS8E0kJVTYdoIrUCqLGSBLZTEQZ9fjkve3PG0lSlHM+ZGh0K8wal
	rlgIVgYWUYvd7PniAgCjfFJDpA5J6/ju7Vy6OlPL30OIwty+Rx1DGZS1I9hScmn/oCHJwxHcoZV
	QjP3zIgk3b0JXM5SkmKfgQqyd567w==
X-Received: by 2002:a17:90b:4d07:b0:39d:fcbe:fdcf with SMTP id 98e67ed59e1d1-3a0985700c8mr1539659a91.1.1790236686989;
        Thu, 24 Sep 2026 00:58:06 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972eec92sm3575622a91.7.2026.09.24.00.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:58:06 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v2 1/6] mm/sparse-vmemmap: drop VMEMMAP_POPULATE_DAX
Date: Thu, 24 Sep 2026 15:52:54 +0800
Message-ID: <20260924075259.2013039-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260924075259.2013039-1-songmuchun@bytedance.com>
References: <20260924075259.2013039-1-songmuchun@bytedance.com>
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

VMEMMAP_POPULATE_DAX currently distinguishes DAX vmemmap population in
two places: it keeps allocations on the normal path and takes a reference
when a backing page is supplied for reuse.

After Device DAX switched to the common per-zone shared tail page, both
conditions can be determined locally. DAX supplies ptpfn for every shared
tail mapping and requests an allocation only for compound head mappings,
whose PFNs are not optimizable. Therefore, vmemmap_optimizable_pfn() alone
selects the correct allocation path.

When ptpfn is supplied, the caller is reusing an existing backing page.
Once the slab allocator is available, take a reference for each reused
mapping to balance the release performed by vmemmap_free(). Although the
buddy allocator is available before slab, no vmemmap population occurs in
that interval. Earlier mappings are backed by memblock/reserved memory and
do not need page reference accounting.

Remove VMEMMAP_POPULATE_DAX and the flags argument from the vmemmap
population helpers.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v2:
- Explain why the buddy-to-slab initialization gap is safe (suggested by
  Qi Zheng)
- Collect Acked-by from Qi Zheng
---
 mm/sparse-vmemmap.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 3267f9362c68..919c94a36346 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -32,12 +32,6 @@
 #include <asm/dma.h>
 #include <asm/tlbflush.h>
 
-/*
- * Flags for vmemmap_populate_range and friends.
- */
-/* Vmemmap population for ZONE_DEVICE compound pages */
-#define VMEMMAP_POPULATE_DAX		0x0001
-
 #include "internal.h"
 #include "mm_init.h"
 #include "sparse.h"
@@ -208,7 +202,7 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 }
 
 static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
-		struct vmem_altmap *altmap, unsigned long flags)
+		struct vmem_altmap *altmap)
 {
 	struct zone *zone;
 	struct page *page;
@@ -218,7 +212,7 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 	 * Device DAX still relies on vmemmap_populate_compound_pages() for
 	 * head/first-tail allocation and tail-page reuse.
 	 */
-	if (!vmemmap_optimizable_pfn(pfn) || flags & VMEMMAP_POPULATE_DAX)
+	if (!vmemmap_optimizable_pfn(pfn))
 		return vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
 
 	zone = pfn_to_zone(pfn, node);
@@ -230,8 +224,7 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 }
 
 static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-				       struct vmem_altmap *altmap,
-				       unsigned long ptpfn, unsigned long flags)
+		struct vmem_altmap *altmap, unsigned long ptpfn)
 {
 	pte_t *pte = pte_offset_kernel(pmd, addr);
 	unsigned long pfn = page_to_pfn((struct page *)addr);
@@ -240,7 +233,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 		pte_t entry;
 
 		if (ptpfn == (unsigned long)-1) {
-			void *p = vmemmap_alloc_pte(pfn, node, altmap, flags);
+			void *p = vmemmap_alloc_pte(pfn, node, altmap);
 
 			if (!p)
 				return NULL;
@@ -255,7 +248,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 			 * and through vmemmap_populate_compound_pages() when
 			 * slab is available.
 			 */
-			if (flags & VMEMMAP_POPULATE_DAX)
+			if (slab_is_available())
 				get_page(pfn_to_page(ptpfn));
 		}
 		entry = pfn_pte(ptpfn, PAGE_KERNEL);
@@ -318,8 +311,7 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 
 static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 					      struct vmem_altmap *altmap,
-					      unsigned long ptpfn,
-					      unsigned long flags)
+					      unsigned long ptpfn)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -339,7 +331,7 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd = vmemmap_pmd_populate(pud, addr, node);
 	if (!pmd)
 		return NULL;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn, flags);
+	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn);
 	if (!pte)
 		return NULL;
 	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
@@ -350,15 +342,14 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 static int __meminit vmemmap_populate_range(unsigned long start,
 					    unsigned long end, int node,
 					    struct vmem_altmap *altmap,
-					    unsigned long ptpfn,
-					    unsigned long flags)
+					    unsigned long ptpfn)
 {
 	unsigned long addr = start;
 	pte_t *pte;
 
 	for (; addr < end; addr += PAGE_SIZE) {
 		pte = vmemmap_populate_address(addr, node, altmap,
-					       ptpfn, flags);
+					       ptpfn);
 		if (!pte)
 			return -ENOMEM;
 	}
@@ -369,7 +360,7 @@ static int __meminit vmemmap_populate_range(unsigned long start,
 int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 					 int node, struct vmem_altmap *altmap)
 {
-	return vmemmap_populate_range(start, end, node, altmap, -1, 0);
+	return vmemmap_populate_range(start, end, node, altmap, -1);
 }
 
 /*
@@ -498,7 +489,6 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	unsigned long size, addr;
 	pte_t *pte;
 	int rc;
-	unsigned long flags = VMEMMAP_POPULATE_DAX;
 	struct page *page;
 	unsigned int order = pfn_to_section_compound_order(start_pfn);
 
@@ -508,14 +498,14 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 
 	if (reuse_compound_section(start_pfn, pgmap))
 		return vmemmap_populate_range(start, end, node, NULL,
-					      page_to_pfn(page), flags);
+					      page_to_pfn(page));
 
 	size = min(end - start, (1UL << order) * sizeof(struct page));
 	for (addr = start; addr < end; addr += size) {
 		unsigned long next, last = addr + size;
 
 		/* Populate the head page vmemmap page */
-		pte = vmemmap_populate_address(addr, node, NULL, -1, flags);
+		pte = vmemmap_populate_address(addr, node, NULL, -1);
 		if (!pte)
 			return -ENOMEM;
 
@@ -525,7 +515,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		 */
 		next = addr + PAGE_SIZE;
 		rc = vmemmap_populate_range(next, last, node, NULL,
-					    page_to_pfn(page), flags);
+					    page_to_pfn(page));
 		if (rc)
 			return -ENOMEM;
 	}
-- 
2.54.0


