Return-Path: <linuxppc-dev+bounces-19765-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9B1F4198B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 11:14:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwdp401sPz307V;
	Wed, 15 Apr 2026 21:14:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776251675;
	cv=none; b=D/tHACel01Xz2SHhzBZcmPEF7kOVTGQHF42nAWohl4ByYI0bpEoVjZnDH18OeYCEfR0e0iKrs+j/0FaF0Ex+HpFTd6j/0SyjbHeuhaRoW8SA8EBGXzCURu97114vhbueRprWyaOA94Y47KENtLSZ/ZvrtQE5mrT+bL30NHvPcn+97IRbIj0MSGpp6rtnZRPSWEREsYVlDbp9Pey72b6SW6R1X7OpzbqhFhyegDCwizXlRbVd6XT+lU5ijsiyoGdQyRs2wCE2tpqgYPUXYycbYLHMdqa/0m+CCYj+OFUlDN33Wf5wi3QuJiERH20F6WzSLN36a0XeiznMrpxiO6ykgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776251675; c=relaxed/relaxed;
	bh=z5+/wr28ovMeZQg9qKyb97SWC0411ZRUTOfCSyd/WG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GGqTVEyrNeF2Dx1Gi0eHJdiQd5dabnE63nbNRckFyLMncg1fDiXeBKYs7YaPOSMid+zoJqcOaq9KbqslXCOgBXUrq0TCoigCF2gDPzLMgiFZAqX5ah9tTkhv96nN4QM9aSuPKzkip0IZU2cbKxYmycI1E10HuAKXIRlm6NQRRBoOhHiOsGg/HPY9Zpgaxeak4z9b/e8SjgqF8sF5hzYeNPq/BE1HPbNJW7K8ssEYuHJrCopWNbZwbF+RfPIy+W857T6sHAsM0oARONNjrxl/BjvUo3MjYi9IIVfbM7uogjmQLtSgPs2eSke4DuTQJK8UaKW2iRTZiRY1WeklcDRKTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=DISZ2Yb9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=DISZ2Yb9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwdp30J3yz2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 21:14:34 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-c76b9efc299so2547008a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 04:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776251673; x=1776856473; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5+/wr28ovMeZQg9qKyb97SWC0411ZRUTOfCSyd/WG0=;
        b=DISZ2Yb91FXF9AQj2naSJLmFGWfj17ErSWT/v1Fi9ZCtcCZ934Q3yVDW0LGcWavqIa
         vHirpxF0C94iAgXNLJXTdVk+BSs+ruoSDbWim40tBO2zEqWCv9+mWWhm5NEr9ILGKkQe
         2EcRgKZWkHWANcaquTosnoBoVxPibsh2aDLH5OPOH346xORocUAMASGhGrVb9Ro4joLZ
         BZjfml8E5R969PNKndeLZj4FaM3EpRkY7RJymI5vBHefEKOqdJw6/pzALP5jD6npuCCm
         TgUIk0mdJrHssqYfnm/udQjark2pjgvpeeu3vrDa43hR6jT4gIqTVSYWiwdVkkwnkIud
         LFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251673; x=1776856473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5+/wr28ovMeZQg9qKyb97SWC0411ZRUTOfCSyd/WG0=;
        b=Z8RJHR1L30yJdRjfR3tbuoydtH2QirVI+VV/2e9UUV55KGDIHm3CBmPb2/E9ie/e44
         Spq7XsZZlg5W6wOR0geLeJ6SqCGerT187ij/pNQtsc1WlGPvnF8kE0YA4QEKR9nEPULQ
         Owq4Cua4fKEK6s223B5pbSnXoZRvFN1sv8kzcOszhzMWQNaWaaBbm/rZXve59Fy3h/Cl
         NaSOo2x5+cYHMlUXoRSdAPHKi+1vbC6dqHLEIioO2v6pV7/QoGvj2z/KAhglwCrNgiY4
         sFF0tKyJR8pkn0sjEI9S6Ot6GameZQ7pHMz0zbsoUoRyHm5kOVg64Z3FWqZA7joxRYZb
         N1ag==
X-Forwarded-Encrypted: i=1; AFNElJ8W17rD09U6SHcVYodKVoDa4y9zz+x5FtSKAuFlQ7crugDc/3w6Fe2TAAKtpxQyFL7TfQAoxJz/z8+midY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxqr5ZjAYZ3jO88XQ+5YnBeM6+Uk2Iv+BnbaWWyiC6FxWk+/TJk
	LomV5bLT5BmpiyqM3QrFs6KqeCQ7krj4SjDqbyKXQTQfeQw1yAXG8VFdJCQTwvrMxs8=
X-Gm-Gg: AeBDiev25gBKz5xJLh8u30WDZX+WwTIyqiBhMkGYFY3TSi5E+zniBHcKXeoWghsQFhP
	I1TuxXtd9w98uzc3jAI3F2WP9EHsIVKRA8u2KF/OjMf4/6W/r+/yEwN1bL5wgvHl5uZrHxRmd6J
	rkXqNQaNcGUSmzduYInoVpWHXdTQhOhGB7tUJozfn/sBbzT4pm2jdiTQmZXYXUUB+wP+tUK0hCB
	OGIBwKZ0cgfAiPRglw0Q46DjPvYzz1jGtUCpWWrwEfgt7Tx4RDwr7e1BtYpGgO9TCxnMLA6kkMi
	VEgEUiYIRHS+YcOzPzv5BJl9oMnahDAG0Yc2dIkGa80GIW96tulNNcXNmTK8FTZCvmQAoZk/vGS
	87ABAkGr7MMy5GeqLXB5iIiWJIbvD7d8GpkteP9Vl3MCevZanRgqfrHoX8xcLYVcVI49wnXt7a7
	MGn0OV6dQsuYz1Gb7ewRzW7he8islv2uhmQY5PQb4todU=
X-Received: by 2002:a17:902:c3c1:b0:2b0:6d33:e7c0 with SMTP id d9443c01a7336-2b2d59766c2mr159851625ad.1.1776251672541;
        Wed, 15 Apr 2026 04:14:32 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b477fd3724sm19509485ad.0.2026.04.15.04.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:14:31 -0700 (PDT)
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
Subject: [PATCH v2 2/6] mm/sparse-vmemmap: Pass @pgmap argument to memory deactivation paths
Date: Wed, 15 Apr 2026 19:14:08 +0800
Message-Id: <20260415111412.1003526-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260415111412.1003526-1-songmuchun@bytedance.com>
References: <20260415111412.1003526-1-songmuchun@bytedance.com>
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

Currently, the memory hot-remove call chain -- arch_remove_memory(),
__remove_pages(), sparse_remove_section() and section_deactivate() --
does not carry the struct dev_pagemap pointer. This prevents the lower
levels from knowing whether the section was originally populated with
vmemmap optimizations (e.g., DAX with vmemmap optimization enabled).

Without this information, we cannot call vmemmap_can_optimize() to
determine if the vmemmap pages were optimized. As a result, the vmemmap
page accounting during teardown will mistakenly assume a non-optimized
allocation, leading to incorrect memmap statistics.

To lay the groundwork for fixing the vmemmap page accounting, we need
to pass the @pgmap pointer down to the deactivation location. Plumb the
@pgmap argument through the APIs of arch_remove_memory(), __remove_pages()
and sparse_remove_section(), mirroring the corresponding *_activate()
paths.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/arm64/mm/mmu.c            |  5 +++--
 arch/loongarch/mm/init.c       |  5 +++--
 arch/powerpc/mm/mem.c          |  5 +++--
 arch/riscv/mm/init.c           |  5 +++--
 arch/s390/mm/init.c            |  5 +++--
 arch/x86/mm/init_64.c          |  5 +++--
 include/linux/memory_hotplug.h |  8 +++++---
 mm/memory_hotplug.c            | 12 ++++++------
 mm/memremap.c                  |  4 ++--
 mm/sparse-vmemmap.c            | 17 +++++++++--------
 10 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index dd85e093ffdb..e5a42b7a0160 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -2024,12 +2024,13 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	return ret;
 }
 
-void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
+			struct dev_pagemap *pgmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
-	__remove_pages(start_pfn, nr_pages, altmap);
+	__remove_pages(start_pfn, nr_pages, altmap, pgmap);
 	__remove_pgd_mapping(swapper_pg_dir, __phys_to_virt(start), size);
 }
 
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 00f3822b6e47..c9c57f08fa2c 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -86,7 +86,8 @@ int arch_add_memory(int nid, u64 start, u64 size, struct mhp_params *params)
 	return ret;
 }
 
-void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
+			struct dev_pagemap *pgmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
@@ -95,7 +96,7 @@ void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 	/* With altmap the first mapped page is offset from @start */
 	if (altmap)
 		page += vmem_altmap_offset(altmap);
-	__remove_pages(start_pfn, nr_pages, altmap);
+	__remove_pages(start_pfn, nr_pages, altmap, pgmap);
 }
 #endif
 
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 648d0c5602ec..4c1afab91996 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -158,12 +158,13 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
 	return rc;
 }
 
-void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
+			      struct dev_pagemap *pgmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
-	__remove_pages(start_pfn, nr_pages, altmap);
+	__remove_pages(start_pfn, nr_pages, altmap, pgmap);
 	arch_remove_linear_mapping(start, size);
 }
 #endif
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index decd7df40fa4..b0092fb842a3 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1717,9 +1717,10 @@ int __ref arch_add_memory(int nid, u64 start, u64 size, struct mhp_params *param
 	return ret;
 }
 
-void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
+			      struct dev_pagemap *pgmap)
 {
-	__remove_pages(start >> PAGE_SHIFT, size >> PAGE_SHIFT, altmap);
+	__remove_pages(start >> PAGE_SHIFT, size >> PAGE_SHIFT, altmap, pgmap);
 	remove_linear_mapping(start, size);
 	flush_tlb_all();
 }
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 1f72efc2a579..11a689423440 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -276,12 +276,13 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	return rc;
 }
 
-void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
+			struct dev_pagemap *pgmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
-	__remove_pages(start_pfn, nr_pages, altmap);
+	__remove_pages(start_pfn, nr_pages, altmap, pgmap);
 	vmem_remove_mapping(start, size);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index df2261fa4f98..77b889b71cf3 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1288,12 +1288,13 @@ kernel_physical_mapping_remove(unsigned long start, unsigned long end)
 	remove_pagetable(start, end, true, NULL);
 }
 
-void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
+			      struct dev_pagemap *pgmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
-	__remove_pages(start_pfn, nr_pages, altmap);
+	__remove_pages(start_pfn, nr_pages, altmap, pgmap);
 	kernel_physical_mapping_remove(start, start + size);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 815e908c4135..7c9d66729c60 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -135,9 +135,10 @@ static inline bool movable_node_is_enabled(void)
 	return movable_node_enabled;
 }
 
-extern void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap);
+extern void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
+			       struct dev_pagemap *pgmap);
 extern void __remove_pages(unsigned long start_pfn, unsigned long nr_pages,
-			   struct vmem_altmap *altmap);
+			   struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
 
 /* reasonably generic interface to expand the physical pages */
 extern int __add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
@@ -307,7 +308,8 @@ extern int sparse_add_section(int nid, unsigned long pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap);
 extern void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
-				  struct vmem_altmap *altmap);
+				  struct vmem_altmap *altmap,
+				  struct dev_pagemap *pgmap);
 extern struct zone *zone_for_pfn_range(enum mmop online_type,
 		int nid, struct memory_group *group, unsigned long start_pfn,
 		unsigned long nr_pages);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2a943ec57c85..6a9e2dc751d2 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -583,7 +583,7 @@ void remove_pfn_range_from_zone(struct zone *zone,
  * calling offline_pages().
  */
 void __remove_pages(unsigned long pfn, unsigned long nr_pages,
-		    struct vmem_altmap *altmap)
+		    struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	const unsigned long end_pfn = pfn + nr_pages;
 	unsigned long cur_nr_pages;
@@ -598,7 +598,7 @@ void __remove_pages(unsigned long pfn, unsigned long nr_pages,
 		/* Select all remaining pages up to the next section boundary */
 		cur_nr_pages = min(end_pfn - pfn,
 				   SECTION_ALIGN_UP(pfn + 1) - pfn);
-		sparse_remove_section(pfn, cur_nr_pages, altmap);
+		sparse_remove_section(pfn, cur_nr_pages, altmap, pgmap);
 	}
 }
 
@@ -1425,7 +1425,7 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
 
 		remove_memory_block_devices(cur_start, memblock_size);
 
-		arch_remove_memory(cur_start, memblock_size, altmap);
+		arch_remove_memory(cur_start, memblock_size, altmap, NULL);
 
 		/* Verify that all vmemmap pages have actually been freed. */
 		WARN(altmap->alloc, "Altmap not fully unmapped");
@@ -1468,7 +1468,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 		ret = create_memory_block_devices(cur_start, memblock_size, nid,
 						  params.altmap, group);
 		if (ret) {
-			arch_remove_memory(cur_start, memblock_size, NULL);
+			arch_remove_memory(cur_start, memblock_size, NULL, NULL);
 			kfree(params.altmap);
 			goto out;
 		}
@@ -1554,7 +1554,7 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		/* create memory block devices after memory was added */
 		ret = create_memory_block_devices(start, size, nid, NULL, group);
 		if (ret) {
-			arch_remove_memory(start, size, params.altmap);
+			arch_remove_memory(start, size, params.altmap, NULL);
 			goto error;
 		}
 	}
@@ -2266,7 +2266,7 @@ static int try_remove_memory(u64 start, u64 size)
 		 * No altmaps present, do the removal directly
 		 */
 		remove_memory_block_devices(start, size);
-		arch_remove_memory(start, size, NULL);
+		arch_remove_memory(start, size, NULL, NULL);
 	} else {
 		/* all memblocks in the range have altmaps */
 		remove_memory_blocks_and_altmaps(start, size);
diff --git a/mm/memremap.c b/mm/memremap.c
index ac7be07e3361..c45b90f334ea 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -97,10 +97,10 @@ static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
 				   PHYS_PFN(range_len(range)));
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
 		__remove_pages(PHYS_PFN(range->start),
-			       PHYS_PFN(range_len(range)), NULL);
+			       PHYS_PFN(range_len(range)), NULL, pgmap);
 	} else {
 		arch_remove_memory(range->start, range_len(range),
-				pgmap_altmap(pgmap));
+				pgmap_altmap(pgmap), pgmap);
 		kasan_remove_zero_shadow(__va(range->start), range_len(range));
 	}
 	mem_hotplug_done();
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index a7b11248b989..40290fbc1db4 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -665,7 +665,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 }
 
 static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap)
+		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
@@ -674,7 +674,8 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	vmemmap_free(start, end, altmap);
 }
 
-static void free_map_bootmem(struct page *memmap)
+static void free_map_bootmem(struct page *memmap, struct vmem_altmap *altmap,
+		struct dev_pagemap *pgmap)
 {
 	unsigned long start = (unsigned long)memmap;
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
@@ -746,7 +747,7 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
  * usage map, but still need to free the vmemmap range.
  */
 static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap)
+		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	struct mem_section *ms = __pfn_to_section(pfn);
 	bool section_is_early = early_section(ms);
@@ -784,9 +785,9 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	 * section_activate() and pfn_valid() .
 	 */
 	if (!section_is_early)
-		depopulate_section_memmap(pfn, nr_pages, altmap);
+		depopulate_section_memmap(pfn, nr_pages, altmap, pgmap);
 	else if (memmap)
-		free_map_bootmem(memmap);
+		free_map_bootmem(memmap, altmap, pgmap);
 
 	if (empty)
 		ms->section_mem_map = (unsigned long)NULL;
@@ -828,7 +829,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 
 	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
 	if (!memmap) {
-		section_deactivate(pfn, nr_pages, altmap);
+		section_deactivate(pfn, nr_pages, altmap, pgmap);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -889,13 +890,13 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 }
 
 void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
-			   struct vmem_altmap *altmap)
+			   struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	struct mem_section *ms = __pfn_to_section(pfn);
 
 	if (WARN_ON_ONCE(!valid_section(ms)))
 		return;
 
-	section_deactivate(pfn, nr_pages, altmap);
+	section_deactivate(pfn, nr_pages, altmap, pgmap);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
-- 
2.20.1


