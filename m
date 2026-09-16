Return-Path: <linuxppc-dev+bounces-27465-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979E6C88E77
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 06:45:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl8WN5Bpsz2yqf;
	Wed, 16 Sep 2026 16:44:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789541072;
	cv=none; b=n42JFsffFbLKHPXnDt1dC7pc5xqyMm8c6Wo2VhYq3j99DgKsgaPsEA0VjaEsy7B8axtRBKZr1LU7XXBVZUClHS+VpaU89uNREY5r9Ifb7KAagpojSieiklHokEUaYLGNBw8+SDYrt0PfxwHirQPjHEmvZFMMs1B7d7O0AQsEX1BAngs6rCDcj7ct7b+Ixu+HVd48DaVu2Ak67PHOKqN16cYoKPqQUTyO9eBTnD2Q5myJyKZRMQgeAv95bFUDcI6sa5yuDsrXSd5J5fnBtY8vAHoHS6qrAT8yQnO+tNTASqZzxwkJRACr3AAsNdLnAf7HJKm9qzL/nM6dRZTnoZY6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789541072; c=relaxed/relaxed;
	bh=TZbZ6WC7vZbHjIhgnid+8T29mCn5dRvITTk6eMnH6Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRcDytiOYQmIdy4WF35+375ptDwXkX82MM4a2keNp2vkG+zrAd4+C/t1Gj1Bvvo4Fl3wbhqJhz/KfUysoT0luDF7AqqqM6kdnZfLpeKroHAcKRq61i/t7AWuoEqU+V8VhlxnxaDCFJhP36nD3dlG7mxfLtkY3yv9GWRlPxGPrllcIJ7GJHJXLe/pn06YE+1cvEGhiGOU/uWhG4dRVDbfF32R/tdhogNAgTZusHpfc+bhv8E/2+9cusweYulhFVQhCAEsZNaP4T4FfQGVdey9seF0quPkTi6qhFGthCucmQMr8vCSwzGu/ZuWvChn6O4j371Rx9eN1bI1xF/Jt/ZmOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LdqBlZC4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LdqBlZC4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl8WM6f5Wz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:44:31 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2d747ec6185so4279975ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 23:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789541070; x=1790145870; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TZbZ6WC7vZbHjIhgnid+8T29mCn5dRvITTk6eMnH6Vk=;
        b=LdqBlZC4Uo7aEwgNWGixeyRi3YP5ut8asThhdYYzdobd7ljjLJFWGt4PaQ/aUyNbFb
         IVPoY4UxK04aBQSIA9Es3ligwX6QzGU6qKhuaaZHvhBNI90IbUx4iXXnL1j1ArKnMnJQ
         BjG25prEqsYgojDXzVD0S1toXQXeMGX9U18J+yxf+oqzrLS4BvuD8WwbraIWy10QdwVw
         vLPEVordZdRnKtIpy5X73zG5sh/nBBzKCbaOJIJctN4ZhChGmxFwLjxMVXGWcrKaIcoe
         JgizK9gtzDHrCwdaWSun+LRcuRb1RQ7LwlRqSrstxyldrJ6yWODe7r9oD4pFncDXgQ/q
         9K0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541070; x=1790145870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TZbZ6WC7vZbHjIhgnid+8T29mCn5dRvITTk6eMnH6Vk=;
        b=r2y6v7OLNDFZfWyagD/MUa/38ct475d9n3tqviHE1dusyRP9uwY5k6gxFYRL96bI9F
         xSxjFnZPIBUsVo/9dwLErElzH7enKxSIpMXmU2rGLgdRYWfK3q/I/D8pFL1VZLPOj822
         5+u3TUEItRprNZQHkWzqv3Han7/VGCG3n1uD9D85AJ7u3KG7B37poNgV05CIYUROZxRB
         uDXSmnJl60H6w6xKhYJ4lWNbcwDGbp2UCPNa84VmRdtdhqHJi2J570vQ8OWJlbKSYAit
         dlC/wYT8nxcEZsXFGp2hY7ZMWjnl27NOFqRZGKSF2/tE1MrWW2LNY9CNEE9XTr0MbiuI
         ePTw==
X-Forwarded-Encrypted: i=1; AKwUvBxR8MIJZHNoAjSGgVYnZmM4k4JRkgcHDhVQUjw67nRjiPyu+FX8lvi5qx2xABzhmWAvgl5x3+ZvaRfN4r8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lGmwYy5rYZPM1BpxRTPKRFY1yN7LwhsGVJyd8HB+hSSysRwdo+
	tX1M6EqFnwno6hiP66jqHI9Bn4ydXZAMeIG3iK+33430nbnvhYcLtP14w7PanaXftyU=
X-Gm-Gg: AYBFou19HM5L6nMUOZbtF/G+G+Tx26znQ0AbrnXSqAoE8CqBrfJNBHSDW731LSCHc9Z
	yoLfDvi9uvjMgvqQ07fe4JPpQE9x8bmaXRA5e1/j19Rh63bwYmSV4+VfeUwi52sG624ELbjUDf7
	rETQZAehtvwTxfNzfld7xPU5J4x5q/LiRAPWI3KAwPMLR5Opuua9ywCJmUKBTLdFPqRD1D+2ESW
	AfnO3NB/ZHgnh6EgvgGGb694DRxsp0JgvSbWSIvHUk9w/gDu4OblRdc5X1GK+sF1ia/2HbonB1R
	3dj3ruc0TrPLyGdpqMhSr1eJY+oyZ1h4Yovkrq8KF1erWm8Vz78kKYon0UmaEMwK4qZlBIo3hgu
	PCwmCUaCUTs8/QKNEcPs8aGcesZYgH364IE/+VC5LxhY4j8MU5vclxzwitsL11uZQvISV7EVkjy
	Q8rpdfyCnXYvHM/WHp8uKihwtB9tj5+R9on2FPethX3MZuK5IOJNRV036v5i+Ondukt4zOT6+vh
	3xpqdhAhkvcHmv2+5s=
X-Received: by 2002:a17:902:ce8f:b0:2da:e967:7953 with SMTP id d9443c01a7336-2dd8e404066mr28394075ad.12.1789541069935;
        Tue, 15 Sep 2026 23:44:29 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f0592asm6074755ad.62.2026.09.15.23.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:44:29 -0700 (PDT)
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
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 08/11] powerpc/mm: switch device DAX to shared tail vmemmap pages
Date: Wed, 16 Sep 2026 14:43:38 +0800
Message-ID: <20260916064341.1825793-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916064341.1825793-1-songmuchun@bytedance.com>
References: <20260916064341.1825793-1-songmuchun@bytedance.com>
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
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 80 +++---------------------
 1 file changed, 9 insertions(+), 71 deletions(-)

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
-- 
2.54.0


