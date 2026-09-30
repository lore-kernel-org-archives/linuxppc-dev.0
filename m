Return-Path: <linuxppc-dev+bounces-28569-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20111CA5FC7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 14:08:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvxjG5pKfz30V1;
	Thu, 01 Oct 2026 00:08:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::29"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790777314;
	cv=none; b=M5Ag6UTC70jLoNVA62SHttwjI/T+e3g7gy0pvfi/rbZ1Vh23xNMvhQaL9S/eee4S5LLjzhvuhLN+UvtF74YwLhsw01R2OiP0+NU/rZocdMf8hHLoZ8oTej7FlWCGIa01DpgenJNyyOvPn3ZUBK0VfPdm5MJ+g6zsTntSO0/5OdCiQ9RaBUxB6ChyWdLpBkgEEB0jIH+w5aF8Y7Fap4+M7DF4XB4qQyDSDB7YEjKILutA2EdvMRNtF73kZUSLjoKmxdp34+BuDkc2LKAeGU4ZzwpbayyOsPWoRbBiKks93PtqHSBl20+XASZRiDeAnSvf+wFRUvVQEKrbRnGBJZaw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790777314; c=relaxed/relaxed;
	bh=Z9xel/71txHnw7brYLWC7OAspVaWnOG/eiO9DEfyBSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvwabYdRDez7QjboqLC3ziGkCyCnQen8RoLrQuu7qTKw1X9ja/RCYhCwdk5DE3xCwagesjGgkGI48QRwbZGczx32Ly2w+I44K2uhmX6/FEwN8BobdCCygtfssJuWlHl+xvMLB0XZeEBTs7kCpil6s34nqqki3ISK9CRdXtQJF8BjlHp86bioR5ue9NeswPUFrbb/w50fgwyfnbiHdliAz42RFf0cmc73fkINSlmNo6am82LDlFNyk4IQuwCk2IDP74DdUq50/n0dV7LZCcR8yjQZbFpWx4siot1mghnKjatGluFUhJXgGbea229x1h225GW5a966IPDayL1tsARkHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=OLPfUPlM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::29; helo=mail-pz2-x29.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=OLPfUPlM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:3b::29; helo=mail-pz2-x29.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x29.google.com (mail-pz2-x29.google.com [IPv6:2607:f8b0:4864:3b::29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvxjG09pHz3bxf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:08:34 +1000 (AEST)
Received: by mail-pz2-x29.google.com with SMTP id 41be03b00d2f7-cc7c4c92477so1257935a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 07:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790777312; x=1791382112; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z9xel/71txHnw7brYLWC7OAspVaWnOG/eiO9DEfyBSY=;
        b=OLPfUPlMMs4HoaoYU/Zj/GTmNsU5erM3F1UVKe9deYrIjCxZiRpvmj8dVsvDgCUz5c
         qY0gdAD+hhykuqNXN8kR0osvDiZImLktqAr1k1kaVEn6wa054L93Lx+p6JJdBcZhVzG8
         hk+u/kIMh0jw6acqpBEWFV4UqK9vxWSjM1XCxHShA0gWiwr/raRr6h++Z3N4DaLN3+U2
         iCMUgf0VAh1Q8M8sKgGD3/uQHojCsNghCcxPEbAapX4mH9slDV4iIqRVHe02oLn9VY4L
         bQGk1Eish42hWXNa70yBIVx6IGBo4YEgi7nMBGXQ/HhGrfMG5o2su/ADIEEzLQ98zHS8
         eROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777312; x=1791382112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z9xel/71txHnw7brYLWC7OAspVaWnOG/eiO9DEfyBSY=;
        b=Mi5/v3n7w2nwOD1BdiniyhYLeVXgCvcNTTXHPfnZZEUfHc8NrAYQq5vtb+MQTK4uKr
         BsEIEOhphoMVOm+XMZJ5QovoQ4f+m53Tv4hrz1aWqtlxu2Ng8tcJfOrv+x/8btkc2Vqe
         jWZPriH7hpnNnQVMVD+jZzBiYQPPHs2Qm3mUYQHVEgkcEyZjAQUD7q7zhu9bEQongYJ+
         vRMLEw1p5zGenVbvbAYKoYZkKbUR5e7VowDH74eDjzMfbTYN/cBnVO7N/nJVmRHi0g+Q
         usrzu6yFEdaFXyGXZ8Hgs9d3QooSfCk832EH72jAbT6SFyXjZRQif7po4r4aNEYfVpjv
         UEFw==
X-Forwarded-Encrypted: i=1; AKwUvBwcXLGwnmXhRPfpt/FxpEL4wTp+v7zjO4h39aLH5eeFGhKFM2mcxq4xPH6ZqJ0yUAilgrQA1fs4dzFVOOg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI6m+vcwPTESjuCRTuVVY5GCvgLQOBIK4a8lzZlBF5QnB8vIlbJ
	WdE2mg6ZY/rUgndnEijIoeTswwGMxx8whW5MW7gF05zGLgPii6rQaJ8GjnGeM7Odc18=
X-Gm-Gg: AYBFou2Ib7ll8oqZWlK28qvEIJoT9hCMTMa9x7Xt/bx/3Krw1dMUNowAxnN9r6icfmt
	WVCavq4BoPRWmOBjbdl7ImdfqNS3nJ4k/KQoWt3JoeFjgEkqzzJ7eMQtygcipEQILRolYtbfjZo
	HvpMGPJYXNrlW28GjQ5uoRIarhA/EwKCKZJRA/z6q133r94Uo+XQaXgG4P1cga7CAzeqZoYS9mI
	sUrYaA1QpCgH2lydEPAR/JqDu7rc/qie1yUdh2Vh9Q24FaoJdC9xNUGo/eovctRD4Pk55S9Fk88
	ERRIo12AYgqfduOlhMg1apkiBJjY1+WCjGmNQ+8Xwv7iKc1nTgzTRJCqhjYQIsrKB3clzo+gxCg
	eoua2IGRPkrkreR65xDXYlvDpuDwB3PPNXbeZJoERZ/kReOg22zPYUiSzyPvL1BF3i0ky3vCny3
	LhfsxZJmygokJj+0kLowm9V9AZm7MTLSKjm4tmw9jS2UwA/fHZN61SWQTtdBQgpHDlKb6xKB1R+
	fk8tGbw1JIsPgSH7NgMlMY8
X-Received: by 2002:a17:90b:2e42:b0:3a0:f2c8:9ad6 with SMTP id 98e67ed59e1d1-3a4d193d340mr1404438a91.64.1790777312124;
        Wed, 30 Sep 2026 07:08:32 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4e60ea12csm639509a91.1.2026.09.30.07.08.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 07:08:31 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v6 09/12] powerpc/mm: switch device DAX to shared tail vmemmap pages
Date: Wed, 30 Sep 2026 22:06:24 +0800
Message-ID: <20260930140627.57431-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930140627.57431-1-songmuchun@bytedance.com>
References: <20260930140627.57431-1-songmuchun@bytedance.com>
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

The powerpc radix compound vmemmap population path still finds a reusable
tail page by walking the vmemmap page tables.

Switch it to the common vmemmap_shared_tail_page() helper instead, so it
can use the shared vmemmap page directly to simplify the code.

This removes the powerpc-specific tail-page lookup and its fallback path
and aligns the device DAX vmemmap optimization path with HugeTLB.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
v6:
- Collect Acked-by from David Hildenbrand
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 80 +++---------------------
 include/linux/vmemmap-optimization.h     |  6 ++
 mm/sparse-vmemmap.c                      |  6 --
 3 files changed, 15 insertions(+), 77 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index cf692b2b5f7b..ee068f24a79f 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -19,6 +19,7 @@
 #include <linux/string_helpers.h>
 #include <linux/memory.h>
 #include <linux/kfence.h>
+#include <linux/vmemmap-optimization.h>
 
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
@@ -1250,59 +1251,6 @@ static pte_t * __meminit radix__vmemmap_populate_address(unsigned long addr, int
 	return pte;
 }
 
-static pte_t * __meminit vmemmap_compound_tail_page(unsigned long addr,
-						    unsigned long pfn_offset, int node)
-{
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	unsigned long map_addr;
-
-	/* the second vmemmap page which we use for duplication */
-	map_addr = addr - pfn_offset * sizeof(struct page) + PAGE_SIZE;
-	pgd = pgd_offset_k(map_addr);
-	p4d = p4d_offset(pgd, map_addr);
-	pud = vmemmap_pud_alloc(p4d, node, map_addr);
-	if (!pud)
-		return NULL;
-	pmd = vmemmap_pmd_alloc(pud, node, map_addr);
-	if (!pmd)
-		return NULL;
-	if (pmd_leaf(*pmd))
-		/*
-		 * The second page is mapped as a hugepage due to a nearby request.
-		 * Force our mapping to page size without deduplication
-		 */
-		return NULL;
-	pte = vmemmap_pte_alloc(pmd, node, map_addr);
-	if (!pte)
-		return NULL;
-	/*
-	 * Check if there exist a mapping to the left
-	 */
-	if (pte_none(*pte)) {
-		/*
-		 * Populate the head page vmemmap page.
-		 * It can fall in different pmd, hence
-		 * vmemmap_populate_address()
-		 */
-		pte = radix__vmemmap_populate_address(map_addr - PAGE_SIZE, node, NULL, NULL);
-		if (!pte)
-			return NULL;
-		/*
-		 * Populate the tail pages vmemmap page
-		 */
-		pte = radix__vmemmap_pte_populate(pmd, map_addr, node, NULL, NULL);
-		if (!pte)
-			return NULL;
-		vmemmap_verify(pte, node, map_addr, map_addr + PAGE_SIZE);
-		return pte;
-	}
-	return pte;
-}
-
 int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 					      unsigned long start,
 					      unsigned long end, int node,
@@ -1320,6 +1268,12 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	struct page *tail_page;
+	unsigned int order = pfn_to_section_compound_order(start_pfn);
+
+	tail_page = vmemmap_shared_tail_page(order, device_zone(node));
+	if (!tail_page)
+		return -ENOMEM;
 
 	for (addr = start; addr < end; addr = next) {
 
@@ -1349,10 +1303,9 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 			next = addr + PAGE_SIZE;
 			continue;
 		} else {
-			unsigned long nr_pages = pgmap_vmemmap_nr(pgmap);
+			unsigned long nr_pages = 1UL << order;
 			unsigned long addr_pfn = page_to_pfn((struct page *)addr);
 			unsigned long pfn_offset = addr_pfn - ALIGN_DOWN(addr_pfn, nr_pages);
-			pte_t *tail_page_pte;
 
 			/*
 			 * if the address is aligned to huge page size it is the
@@ -1377,23 +1330,8 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 				next = addr + 2 * PAGE_SIZE;
 				continue;
 			}
-			/*
-			 * get the 2nd mapping details
-			 * Also create it if that doesn't exist
-			 */
-			tail_page_pte = vmemmap_compound_tail_page(addr, pfn_offset, node);
-			if (!tail_page_pte) {
-
-				pte = radix__vmemmap_pte_populate(pmd, addr, node, NULL, NULL);
-				if (!pte)
-					return -ENOMEM;
-				vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
-
-				next = addr + PAGE_SIZE;
-				continue;
-			}
 
-			pte = radix__vmemmap_pte_populate(pmd, addr, node, NULL, pte_page(*tail_page_pte));
+			pte = radix__vmemmap_pte_populate(pmd, addr, node, NULL, tail_page);
 			if (!pte)
 				return -ENOMEM;
 			vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
diff --git a/include/linux/vmemmap-optimization.h b/include/linux/vmemmap-optimization.h
index bd0974b262a4..fa9e9abd6656 100644
--- a/include/linux/vmemmap-optimization.h
+++ b/include/linux/vmemmap-optimization.h
@@ -83,6 +83,12 @@ static inline unsigned int pfn_to_section_compound_order(unsigned long pfn)
 {
 	return 0;
 }
+
+static inline struct page *vmemmap_shared_tail_page(unsigned int order,
+						    struct zone *zone)
+{
+	return NULL;
+}
 #endif /* CONFIG_VMEMMAP_OPTIMIZATION */
 
 static inline bool vmemmap_optimizable_pfn(unsigned long pfn)
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index d40a2f5b5fca..e1f8a03e3d49 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -240,12 +240,6 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 
 	return page;
 }
-#else
-static inline struct page *vmemmap_shared_tail_page(unsigned int order,
-						    struct zone *zone)
-{
-	return NULL;
-}
 #endif
 
 static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
-- 
2.54.0


