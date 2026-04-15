Return-Path: <linuxppc-dev+bounces-19767-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0F3F41991
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 11:14:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwdpL38HLz2yvh;
	Wed, 15 Apr 2026 21:14:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776251690;
	cv=none; b=aCLQ2CcEad3liqWo+PsRq8/YGyzuadAsnTXcw59q4QmkimjlhrlKvI+qCACztz+7PBryaDXtMY3mueLG+d5al7R4WCNY4UloHbxUWZ8mRFY2jRng0txrigowJLgsKSWltw+3/XdP5MpX9UUKLlnuJ76vCmxtsCOGCPowM5gu3iYl1l7xQjHBsmn4mFb9jGMj8USq0y1sWZ5a5hKjHojFeZzTDK6BLzLe1L7GjrC6DIh+4/9A5yKWS0PVXEhkG83WXBWA2YgRo3TDoJQsy7K4IPseKPiUw//O/sG5kLT6A5J/AmFciYHspsaTUbQ8NVm5LiMIllr8PKobHs1g7+8h2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776251690; c=relaxed/relaxed;
	bh=3Df1XnTLx+FlR5iv38FY01xmyEBUedrertPqH9E0HLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XhdwOYhrmzKFYnTO8wNwh+WNS4F6d+Yle5bvqEVYJbP4B5SyPdAbBYcPS5uEe2+FU4E6Hu1/W2L5BVETeTXXKv5OIvTHcWQ+04weCAW0WACIB+N7Kh6nxgAuEJdG60PWq5Y7yQUTGopE4zF0cunpFzNOmzKKHJSWO82nqurYvwPWN8z3/8nJvrAB/JZBh4sCwLl8nFAKSaziuSwjzKKzi2vTLZeXUKjmL9z3ICKgpP5znw4rQ3LhxDgfWTgnJEPewz/iYBtHbXy2h4C+DPRD5pfNtaaPG2yoxc5wwhKQHIOxZVZI6RegsOcwV0gaORy52S50rJSA+YD6trzWSuqxSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=G/qJUtxb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=G/qJUtxb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwdpK4PtPz2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 21:14:49 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2adff872068so33764285ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 04:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776251687; x=1776856487; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Df1XnTLx+FlR5iv38FY01xmyEBUedrertPqH9E0HLA=;
        b=G/qJUtxb+zEfs0acBtuWG6hvfAOja8gJuKLcNewZA5BS5qPDMWl/6uzgpz9PbQHuWB
         x8VYkWvMVg96AyEIPZ1eN1DUz/H7gEqwIk8JsBj2sNEBnqj57Wh+QxqYMGa5ZU/4bdQb
         ctP3TfG7NP8rkpzuW+xKpmb5Fj239w2GMcJ0b5dWHTFhSTdXZYcqKCr5tWsCnKBPsE1y
         OWUQSt0PVOG2MgNO3JwcIJ5tviHcijLs48h9xMNxiaIMBoIZELB7G126+G/aYN1rSTow
         Vuq+YqbUyWOxpVkPJeo76+PAPrHlqS8PB84hPbqesiPTaFSdYDGKql8iUTwdk70uWtfK
         h/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251687; x=1776856487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Df1XnTLx+FlR5iv38FY01xmyEBUedrertPqH9E0HLA=;
        b=bh00wLTU6NkhL3yjZQwEJabp8uIWv2LgAXsc64NwwcPnOKO5NDW/4aVEYQ8uzjrx00
         yk7l0hUrbomNwNDfgeKBrpwEopy3KaZzzOCwbo8jNvUMUbSus+UtFu9DTMKr28mysPLX
         yzMxTgCOcfIg5RbiV2xcCcPknvDjzWOBjPJrzNj27oOfyt+tO4tV2g4iipuc7XkROa9z
         7zzT8VB67HeIRdvgg6PwUE9L7arDAcOcaYrEaWZP1I4q539n3+ajNRHM/Q0jV7XXxtpI
         aVihw0NHOvtxKDMpjVq4YnuUS5/Ham6n6hHsnF4/JT/+MHcWSKMHRGzt80vOioUudTlf
         Z+3A==
X-Forwarded-Encrypted: i=1; AFNElJ+dMdcVTVwW9sxrz2hYSs1ppjdBVN9HhXIUy0ouQhFvopLvYolVXLXdpt+7fl3rbjZO0jiAh2zj0MBoTBc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzVelWkZ8AQj6v8ksfZy7mXyGqmAVxV4247jCEZrr4/uYL2Gdwt
	EnzMz9TlxHP/Ui7I+lsHoHtIAgb1x4hUo1EbCX0PXgVYFDDL1rVNRd1yJYiaw5F7578=
X-Gm-Gg: AeBDieuGFyVnKFQ3TAM/mULg+Ct82RUyMOu2/bhlj6dtDQ+1gWtn7vwFZBPHx65I0L2
	+GxyX7oV0OnHZKabCi/wZPrAvpWoLS23osMIWmkgPtS/RPX9RKOodgpGErM9v8k3nyfOPgU4w93
	8ysNhjZGYuIf0DBaaGcGAQoCXw8ShVCbeQAih59BS35RaCST355t8nicXt2ilOMPokyFm58Zqa8
	FlkdLdT/8YUzxd7ph0Z56VqLHIoy/Tb/xpgerOGomFAC9VzgmKvW+HyF1mh7qc+9LspZdvm8WCV
	+2iw0qMqTuN8gq7H4VfSZlbzIn49J/4YH6LJI/jZ63Mtbhysia0h9X9bfPj3+hDcwkg8kil4Qhr
	pHnNETD1mLEn1JcSlJnMPrQ3TnnW6VxbT8wFTqwNNPUmQq50SFa0NRHpCvjEDd0QDehJ+o5YVyn
	LDg42OQSVYYR6Tt9W9l2kOFEJy9toXoAa+WiZOmuG3bjc=
X-Received: by 2002:a17:902:db0f:b0:2b2:67ca:5ff1 with SMTP id d9443c01a7336-2b2d5a6a36cmr226277565ad.31.1776251685742;
        Wed, 15 Apr 2026 04:14:45 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b477fd3724sm19509485ad.0.2026.04.15.04.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:14:45 -0700 (PDT)
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
Subject: [PATCH v2 4/6] mm/sparse-vmemmap: Pass @pgmap argument to arch vmemmap_populate()
Date: Wed, 15 Apr 2026 19:14:10 +0800
Message-Id: <20260415111412.1003526-5-songmuchun@bytedance.com>
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

Add the struct dev_pagemap pointer as a parameter to the architecture
specific vmemmap_populate(), vmemmap_populate_hugepages() and
vmemmap_populate_basepages() functions.

Currently, the vmemmap optimization for DAX is handled mostly in an
architecture-agnostic way via vmemmap_populate_compound_pages().
However, this approach skips crucial architecture-specific initialization
steps. For example, the x86 path must call sync_global_pgds() after
populating the vmemmap, which is currently being bypassed.

To lay the groundwork for fixing the vmemmap optimization in the arch
level, we need to pass the @pgmap pointer down to the arch specific
vmemmap_populate() location. Plumb the @pgmap argument through the APIs
of vmemmap_populate(), vmemmap_populate_hugepages() and
vmemmap_populate_basepages().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/arm64/mm/mmu.c                        |  6 +++---
 arch/loongarch/mm/init.c                   |  7 ++++---
 arch/powerpc/include/asm/book3s/64/radix.h |  3 ++-
 arch/powerpc/mm/book3s64/radix_pgtable.c   |  2 +-
 arch/powerpc/mm/init_64.c                  |  4 ++--
 arch/riscv/mm/init.c                       |  4 ++--
 arch/s390/mm/vmem.c                        |  2 +-
 arch/sparc/mm/init_64.c                    |  5 +++--
 arch/x86/mm/init_64.c                      |  8 ++++----
 include/linux/mm.h                         |  8 +++++---
 mm/hugetlb_vmemmap.c                       |  4 ++--
 mm/sparse-vmemmap.c                        | 10 ++++++----
 12 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e5a42b7a0160..11227e104c48 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1790,7 +1790,7 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
 }
 
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
-		struct vmem_altmap *altmap)
+		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
 	/* [start, end] should be within one section */
@@ -1798,9 +1798,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 
 	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) ||
 	    (end - start < PAGES_PER_SECTION * sizeof(struct page)))
-		return vmemmap_populate_basepages(start, end, node, altmap);
+		return vmemmap_populate_basepages(start, end, node, altmap, pgmap);
 	else
-		return vmemmap_populate_hugepages(start, end, node, altmap);
+		return vmemmap_populate_hugepages(start, end, node, altmap, pgmap);
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index c9c57f08fa2c..d61c2e09caae 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -123,12 +123,13 @@ int __meminit vmemmap_check_pmd(pmd_t *pmd, int node,
 }
 
 int __meminit vmemmap_populate(unsigned long start, unsigned long end,
-			       int node, struct vmem_altmap *altmap)
+			       int node, struct vmem_altmap *altmap,
+			       struct dev_pagemap *pgmap)
 {
 #if CONFIG_PGTABLE_LEVELS == 2
-	return vmemmap_populate_basepages(start, end, node, NULL);
+	return vmemmap_populate_basepages(start, end, node, NULL, pgmap);
 #else
-	return vmemmap_populate_hugepages(start, end, node, NULL);
+	return vmemmap_populate_hugepages(start, end, node, NULL, pgmap);
 #endif
 }
 
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index da954e779744..bde07c6f900f 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -321,7 +321,8 @@ extern int __meminit radix__vmemmap_create_mapping(unsigned long start,
 					     unsigned long page_size,
 					     unsigned long phys);
 int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end,
-				      int node, struct vmem_altmap *altmap);
+				      int node, struct vmem_altmap *altmap,
+				      struct dev_pagemap *pgmap);
 void __ref radix__vmemmap_free(unsigned long start, unsigned long end,
 			       struct vmem_altmap *altmap);
 extern void radix__vmemmap_remove_mapping(unsigned long start,
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 10aced261cff..568500343e5f 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1112,7 +1112,7 @@ static inline pte_t *vmemmap_pte_alloc(pmd_t *pmdp, int node,
 
 
 int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, int node,
-				      struct vmem_altmap *altmap)
+				      struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	unsigned long addr;
 	unsigned long next;
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index b6f3ae03ca9e..8f4aa5b32186 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -275,12 +275,12 @@ static int __meminit __vmemmap_populate(unsigned long start, unsigned long end,
 }
 
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
-			       struct vmem_altmap *altmap)
+			       struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (radix_enabled())
-		return radix__vmemmap_populate(start, end, node, altmap);
+		return radix__vmemmap_populate(start, end, node, altmap, pgmap);
 #endif
 
 	return __vmemmap_populate(start, end, node, altmap);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b0092fb842a3..a04ae9727cbe 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1348,7 +1348,7 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
 }
 
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
-			       struct vmem_altmap *altmap)
+			       struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
 
@@ -1358,7 +1358,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	 * memory hotplug, we are not able to update all the page tables with
 	 * the new PMDs.
 	 */
-	return vmemmap_populate_hugepages(start, end, node, altmap);
+	return vmemmap_populate_hugepages(start, end, node, altmap, pgmap);
 }
 #endif
 
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index eeadff45e0e1..a7bf8d3d5601 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -506,7 +506,7 @@ static void vmem_remove_range(unsigned long start, unsigned long size)
  * Add a backed mem_map array to the virtual mem_map array.
  */
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
-			       struct vmem_altmap *altmap)
+			       struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	int ret;
 
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 367c269305e5..f870ca330f9e 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2591,9 +2591,10 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
 }
 
 int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
-			       int node, struct vmem_altmap *altmap)
+			       int node, struct vmem_altmap *altmap,
+			       struct dev_pagemap *pgmap)
 {
-	return vmemmap_populate_hugepages(vstart, vend, node, NULL);
+	return vmemmap_populate_hugepages(vstart, vend, node, NULL, pgmap);
 }
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 77b889b71cf3..e18cc81a30b4 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1557,7 +1557,7 @@ int __meminit vmemmap_check_pmd(pmd_t *pmd, int node,
 }
 
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
-		struct vmem_altmap *altmap)
+		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	int err;
 
@@ -1565,15 +1565,15 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	VM_BUG_ON(!PAGE_ALIGNED(end));
 
 	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
-		err = vmemmap_populate_basepages(start, end, node, NULL);
+		err = vmemmap_populate_basepages(start, end, node, NULL, pgmap);
 	else if (boot_cpu_has(X86_FEATURE_PSE))
-		err = vmemmap_populate_hugepages(start, end, node, altmap);
+		err = vmemmap_populate_hugepages(start, end, node, altmap, pgmap);
 	else if (altmap) {
 		pr_err_once("%s: no cpu support for altmap allocations\n",
 				__func__);
 		err = -ENOMEM;
 	} else
-		err = vmemmap_populate_basepages(start, end, node, NULL);
+		err = vmemmap_populate_basepages(start, end, node, NULL, pgmap);
 	if (!err)
 		sync_global_pgds(start, end - 1);
 	return err;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0b776907152e..bebc5f892f81 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4877,11 +4877,13 @@ void vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 int vmemmap_check_pmd(pmd_t *pmd, int node,
 		      unsigned long addr, unsigned long next);
 int vmemmap_populate_basepages(unsigned long start, unsigned long end,
-			       int node, struct vmem_altmap *altmap);
+			       int node, struct vmem_altmap *altmap,
+			       struct dev_pagemap *pgmap);
 int vmemmap_populate_hugepages(unsigned long start, unsigned long end,
-			       int node, struct vmem_altmap *altmap);
+			       int node, struct vmem_altmap *altmap,
+			       struct dev_pagemap *pgmap);
 int vmemmap_populate(unsigned long start, unsigned long end, int node,
-		struct vmem_altmap *altmap);
+		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
 int vmemmap_populate_hvo(unsigned long start, unsigned long end,
 			 unsigned int order, struct zone *zone,
 			 unsigned long headsize);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4a077d231d3a..50b7123f3bdd 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -829,7 +829,7 @@ void __init hugetlb_vmemmap_init_late(int nid)
 			 */
 			list_del(&m->list);
 
-			vmemmap_populate(start, end, nid, NULL);
+			vmemmap_populate(start, end, nid, NULL, NULL);
 			nr_mmap = end - start;
 			memmap_boot_pages_add(DIV_ROUND_UP(nr_mmap, PAGE_SIZE));
 
@@ -845,7 +845,7 @@ void __init hugetlb_vmemmap_init_late(int nid)
 		if (vmemmap_populate_hvo(start, end, huge_page_order(h), zone,
 					 HUGETLB_VMEMMAP_RESERVE_SIZE) < 0) {
 			/* Fallback if HVO population fails */
-			vmemmap_populate(start, end, nid, NULL);
+			vmemmap_populate(start, end, nid, NULL, NULL);
 			nr_mmap = end - start;
 		} else {
 			m->flags |= HUGE_BOOTMEM_ZONES_VALID;
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 05e3e2b94e32..f5245647afee 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -297,7 +297,8 @@ static int __meminit vmemmap_populate_range(unsigned long start,
 }
 
 int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
-					 int node, struct vmem_altmap *altmap)
+					 int node, struct vmem_altmap *altmap,
+					 struct dev_pagemap *pgmap)
 {
 	return vmemmap_populate_range(start, end, node, altmap, -1, 0);
 }
@@ -400,7 +401,8 @@ int __weak __meminit vmemmap_check_pmd(pmd_t *pmd, int node,
 }
 
 int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
-					 int node, struct vmem_altmap *altmap)
+					 int node, struct vmem_altmap *altmap,
+					 struct dev_pagemap *pgmap)
 {
 	unsigned long addr;
 	unsigned long next;
@@ -445,7 +447,7 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 			}
 		} else if (vmemmap_check_pmd(pmd, node, addr, next))
 			continue;
-		if (vmemmap_populate_basepages(addr, next, node, altmap))
+		if (vmemmap_populate_basepages(addr, next, node, altmap, pgmap))
 			return -ENOMEM;
 	}
 	return 0;
@@ -559,7 +561,7 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 	if (vmemmap_can_optimize(altmap, pgmap))
 		r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
 	else
-		r = vmemmap_populate(start, end, nid, altmap);
+		r = vmemmap_populate(start, end, nid, altmap, pgmap);
 
 	if (r < 0)
 		return NULL;
-- 
2.20.1


