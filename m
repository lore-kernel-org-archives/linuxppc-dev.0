Return-Path: <linuxppc-dev+bounces-19335-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA29BF3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:54:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXTJ505Gz2ynH;
	Sun, 05 Apr 2026 22:53:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393636;
	cv=none; b=K7PXEpds9xa5+BvfbQ03b1UJ3MoYc674WOkGpdvV3TDu955CqQ6ekOk8EuXaMc9oPgw5XlW5HpyTVQj8rmqE28LifyB3R9UbvuGvNfjntAHEx0/iqxt+yaHA4HIB3PBRPM7P3mRkKWaQmkhCqF6Cc6Ojn4tJu2TGBLxARRrgyUjg7atFoK1Qpd5PxvFs4Jd6zTS4r3v9h8xe8jZ2kr2cj6XihtZuNXLLVTLHH8nmpHXiWVGUJctssJCdlXCW1uFzSud2DYAQ7HmDYxXMMHNg0FnVEQvODKgxiEF2Kpb6H4toI8Xn6QZ5b3D3n3joMtqlfxV13fSuFbz0ml0zs+UZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393636; c=relaxed/relaxed;
	bh=UXznDGdcvbijOjbb/LymBNzIqLALuLwKxylcqGtnQjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DJ8BxqV5XcD2YMCGTPGnh7EoxaoNeswXNlWYOF4g0pLL+rdo3zcS96KFX4TK5XZL45enK8azOXigAA9RI/iQkSsvtRXzjnO89vdalc03XLvOto9cUgTGaokLWve6HNJiQT8dIoS8rq5xJpli24lPdeGrQtOWNsL2mmfmlHckLjdrzfWIixKxncFGdKjRWyvQF8ULEVWVqzlDFMxNQkkZGSn0Nfs1BoyTjDGwS5EcE1NXDrWCexGyDtUT6vZKk8ZQwcENsybop6EKndTPp44V9+UF6D13uGAaYlLfWwhL/yf0Of0RDhO0RQRokDFamavLq72WJUuTYw/LOXnZrQpFTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lc2jdC6A; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lc2jdC6A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXTJ0F6wz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:53:55 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso2001156a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393634; x=1775998434; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXznDGdcvbijOjbb/LymBNzIqLALuLwKxylcqGtnQjA=;
        b=lc2jdC6AlHJJHdQzvDyeWlHFXnG7eCLvfj39pYObyOEZnetVOKc5H+bqyAmUkvDAwU
         AEX5SjnsHhS/zPxmnC3an1PqK3i8g+WiELpLKc6jQ7BWafnd+iJXdNOuA/VXvMzp7ngY
         KfEKStB5pZ+SrGJ1jnAuj0GzaDF8whW/OxhcMHKbf9j4zo3rozW6BUduPQv2dWE3CUyh
         hYl0tA1kbSAGeU00JGrJBY9AbWUU17ROW209yZvamPUxOzO70cdCnEJuNfY/ZjfNF1m7
         45+rOrObK1lVWRWLqNIEYYCZm7+rpdBEoe9a4repBueInjy8tgI57KqFMw4MVCenBdiO
         SfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393634; x=1775998434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UXznDGdcvbijOjbb/LymBNzIqLALuLwKxylcqGtnQjA=;
        b=svQWdNce4dWMWF1AY+UVdI+UkkMgcMaE3N9MvidSTLA9lyI+gJhu15ixxtOiZZs1vq
         WEIM1NfADS506+rZmle0D+AlprdWFvzV1bveWwGIFT7ollRXFnJ+gmCks1prGkGTSDQI
         kEGm++2ti12B/OCktbfjs5Ac3KiidUUyf3FSEYb1ycoWAULZbubr/aZX6BI0o2qBSoXJ
         AXck064YkY5oPA3JqBxmWNAf8k/toiSQH83f2t7MvPvLw06t0dfhPK4xzLcGISJ9mALQ
         E0mPeoUpewnLPhUTtF94mJIW+y0eUkVcUvOfc0KawsWtQe/hag0/mYPhPRQOOqbEyYDk
         66jw==
X-Forwarded-Encrypted: i=1; AJvYcCUemVXmQ15f76yl43Y5M6djqvbnjUN7dg11YVCClH9WCQ/kWophR+B/lAvnRmdF4vDUWnMOaGDAPCVN/O0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzznPyZ9Oyf8eL0VDDhipsaKGEMrjlqoka56aFz5gFANMSTnWFe
	4s+0kXvcJ7M2mOULCn5QfaIyGgIF+yPp7OMxl9E7aCm/q+06nsp1o6lII/3tKf/UafM=
X-Gm-Gg: AeBDieuZHuFHnyTkL/3qTURazkywCAtSs/G+ScfbFSPexwlcwpouuT01Xef/uoQlof9
	MYi13fkk1VPXzydtvqzdBUS8UVfWSzJTSXB8Re2lRTOfUqDjr6RxQm4eJJBrwTIfVlWZqSGeKMF
	5MCTeZSqMpNuQNSgGtBEQ9QtegO44drWdhl/hsgn+Z19yA9x4mF1Jmmrj2jFSExb/AG2N7xoko2
	NjNt0frAI4IDf/AjmDx5FFHCcEa2EH7xjCKi4FJcZZWT3H+Xg1A6tplQJSD+7XOX+C7LZa4//tc
	P2aEgGKfsQlcTAx/JY9MxRq+mVKItcNIKKCr7hJc1PMRZSr2gyVo5Ek/44yLyisFVY5hvxPL6kv
	DOQwmOHKM7jfBONRlK9qeaPN3SM/aTJbJa/wdBUIwJ5254ib0YAqOVXLys3z4Dz4cviXPZqkdgs
	gxhIm3sIStiLg8k9RO0/7wIt1sI3h9P+T10mVKSOhgi2yQSUbC84Ws9w==
X-Received: by 2002:a17:90a:e70f:b0:35b:e52a:6fe5 with SMTP id 98e67ed59e1d1-35de683b19amr9190466a91.5.1775393634044;
        Sun, 05 Apr 2026 05:53:54 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:53:53 -0700 (PDT)
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
Subject: [PATCH 05/49] mm/sparse: fix missing architecture-specific page table sync for HVO DAX
Date: Sun,  5 Apr 2026 20:51:56 +0800
Message-Id: <20260405125240.2558577-6-songmuchun@bytedance.com>
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

On x86-64, vmemmap_populate() normally calls sync_global_pgds() to
keep the page tables in sync; however, when DAX HVO is enabled,
vmemmap_populate_compound_pages() skips this architecture-specific
step, so omitting the sync on x86-64 can later trigger vmemmap-access
faults.

Fix this by delegating the HVO DAX decision to the architecture:

- Architectures that do not use the generic vmemmap_populate_basepages()
  or vmemmap_populate_hugepages() paths (e.g. powerpc) can implement
  HVO DAX directly in their own vmemmap_populate().

- Architectures that rely on the generic helpers implicitly inherit
  the correct operation logic and therefore enable HVO DAX safely
  without extra work in generic vmemmap_populate_basepages() or
  vmemmap_populate_hugepages().

This prevents the x86-64 sync issue.

Fixes: 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory savings for compound devmaps")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h |  6 ------
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 15 +++++++++-----
 mm/sparse-vmemmap.c                        | 24 +++++++++++-----------
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index bde07c6f900f..2600defa2dc2 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -357,11 +357,5 @@ int radix__remove_section_mapping(unsigned long start, unsigned long end);
 #define vmemmap_can_optimize vmemmap_can_optimize
 bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
 #endif
-
-#define vmemmap_populate_compound_pages vmemmap_populate_compound_pages
-int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-					      unsigned long start,
-					      unsigned long end, int node,
-					      struct dev_pagemap *pgmap);
 #endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 568500343e5f..dfa2f7dc7e15 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1109,7 +1109,10 @@ static inline pte_t *vmemmap_pte_alloc(pmd_t *pmdp, int node,
 	return pte_offset_kernel(pmdp, address);
 }
 
-
+static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
+						    unsigned long start,
+						    unsigned long end, int node,
+						    struct dev_pagemap *pgmap);
 
 int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, int node,
 				      struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
@@ -1122,6 +1125,8 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	pmd_t *pmd;
 	pte_t *pte;
 
+	if (vmemmap_can_optimize(altmap, pgmap))
+		return vmemmap_populate_compound_pages(page_to_pfn((struct page *)start), start, end, node, pgmap);
 	/*
 	 * If altmap is present, Make sure we align the start vmemmap addr
 	 * to PAGE_SIZE so that we calculate the correct start_pfn in
@@ -1303,10 +1308,10 @@ static pte_t * __meminit vmemmap_compound_tail_page(unsigned long addr,
 	return pte;
 }
 
-int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-					      unsigned long start,
-					      unsigned long end, int node,
-					      struct dev_pagemap *pgmap)
+static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
+						     unsigned long start,
+						     unsigned long end, int node,
+						     struct dev_pagemap *pgmap)
 {
 	/*
 	 * we want to map things as base page size mapping so that
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 387337bba05e..d3096de04cc6 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -296,10 +296,16 @@ static int __meminit vmemmap_populate_range(unsigned long start,
 	return 0;
 }
 
+static int __meminit vmemmap_populate_compound_pages(unsigned long start,
+						     unsigned long end, int node,
+						     struct dev_pagemap *pgmap);
+
 int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 					 int node, struct vmem_altmap *altmap,
 					 struct dev_pagemap *pgmap)
 {
+	if (vmemmap_can_optimize(altmap, pgmap))
+		return vmemmap_populate_compound_pages(start, end, node, pgmap);
 	return vmemmap_populate_range(start, end, node, altmap, -1, 0);
 }
 
@@ -411,6 +417,9 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 	pud_t *pud;
 	pmd_t *pmd;
 
+	if (vmemmap_can_optimize(altmap, pgmap))
+		return vmemmap_populate_compound_pages(start, end, node, pgmap);
+
 	for (addr = start; addr < end; addr = next) {
 		next = pmd_addr_end(addr, end);
 
@@ -453,7 +462,6 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 	return 0;
 }
 
-#ifndef vmemmap_populate_compound_pages
 /*
  * For compound pages bigger than section size (e.g. x86 1G compound
  * pages with 2M subsection size) fill the rest of sections as tail
@@ -491,14 +499,14 @@ static pte_t * __meminit compound_section_tail_page(unsigned long addr)
 	return pte;
 }
 
-static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-						     unsigned long start,
+static int __meminit vmemmap_populate_compound_pages(unsigned long start,
 						     unsigned long end, int node,
 						     struct dev_pagemap *pgmap)
 {
 	unsigned long size, addr;
 	pte_t *pte;
 	int rc;
+	unsigned long start_pfn = page_to_pfn((struct page *)start);
 
 	if (reuse_compound_section(start_pfn, pgmap)) {
 		pte = compound_section_tail_page(start);
@@ -544,26 +552,18 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	return 0;
 }
 
-#endif
-
 struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
 {
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
-	int r;
 
 	if (WARN_ON_ONCE(!IS_ALIGNED(pfn, PAGES_PER_SUBSECTION) ||
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
-	if (vmemmap_can_optimize(altmap, pgmap))
-		r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
-	else
-		r = vmemmap_populate(start, end, nid, altmap, pgmap);
-
-	if (r < 0)
+	if (vmemmap_populate(start, end, nid, altmap, pgmap))
 		return NULL;
 
 	return pfn_to_page(pfn);
-- 
2.20.1


