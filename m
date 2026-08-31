Return-Path: <linuxppc-dev+bounces-26247-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B35BC624A5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 07:55:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYLrD02S7z2yFj;
	Mon, 31 Aug 2026 17:55:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788162907;
	cv=none; b=Y3AaXpU7tUrvne54pcYxD+I5zqWZex0BuOTMsYwnIcW/cjbLa60fn8B9g22M+LmseHE6+Uwyhy8JJh6bhSDwdvU0dmHFyeO3A0WXh6OUdQygiUpyJditPEfXgx6imTjxvxnHwzANl3/cOl+ibMyMb+IQI+MZGuwd7dUe5XRbcRYVRLKk6gAKLG3lBXbbNSEnoG+8jLmox5Km8KutFINTV6NCv/i9REhDlvfMfHs6KNSwZ5IDC1skKNLXCcz61qeKW0Z/Py2F5j+QR9zduECl5/PiHQSqkD1WJdTBPrz4RRIJW30txd/gOHGXuEJR+hmZdUSET9fGqFEPcfZj+JjCpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788162907; c=relaxed/relaxed;
	bh=l5VVmQasiv9FjgFp8hyWKR9WL3WpfimdUt+OCxubG2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHNo96asqICoDbHOhsH5Xm3ZloRBzMutbTpoRZCNZ4oAvnR/I5AqeFUBHNZUY0iGW2dTquf3WtFkD0Zc4eCjYMO3KSp+Sitc4Oy9AROEeflaz/W53iWsRi9EVemYkO36fNW8pNZ4BArOCiwTVpYvye4+hKQCKQGu+rTRw4/wUN/TepGvnY/uQwIg0SsesdPywpyjYWwfcVK5h0cWj5bH9z9k3majCWLZIts7yx2dieyCQ17253r3xXTuXVjVY6bWlpHsj+UJobEwR1q5TGfJ76tGNbfNrDtdGtYRoyQYlFxxLRRW0JwJFSQ+2lsaQ1IEsJxElAj3jvn3qP9HxtGfuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CPqmzxkz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CPqmzxkz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYLrC19bdz2yFW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 17:55:07 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-8557c3f270eso2303243b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 00:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788162905; x=1788767705; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l5VVmQasiv9FjgFp8hyWKR9WL3WpfimdUt+OCxubG2c=;
        b=CPqmzxkzDL/hHOW9NppuN7Wq4b2s5ichd6YtdN8ogDDYzhGVndnOj7yY5670iUQBmy
         5fIrfljuZHutt5OxRJGrBsqNLAMNZFZ1mrV68j9fwGkb2nScObg1akB8cTOPymIgmeVN
         KZejmu4d+FiVBhsTBqhJRY+e7NC0HgxZxd+QwSwaKHiQ/UahdiSuRX1bAxBvEYsTTD4h
         W48LOPBKwE/mTRaz3E43F5cB+osnHEw7Vnii38FdLwUSeuM/NXIgH8LY+WIoD17pjlll
         uQqZsURKqZjKoYX8A5aBpPgf5X0iWr/ZspWS2pVhcTHVkvvV/a2Tb5U5xFbDlgb4Mi5C
         XToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788162905; x=1788767705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l5VVmQasiv9FjgFp8hyWKR9WL3WpfimdUt+OCxubG2c=;
        b=sdzoXwBdbF0bTQ66PgzBVsqTsnoKJ4rFfk5xMRhp1lDNkAv6S0e8daPaFT7AArqtuX
         01cw5qNxBkUkSC6ocwPVjpOqKrO6RhhMWe1qZSxRpeYRZW0gBL7nV21TM8ZMRJTPQ/kW
         ysIdsAYoyt82cW+s0qPlqNRTly3gim+4rzIOmUHEr9mxFkbjJY+U43ZMBmp1MCLCVDt4
         4nS6zHOp1bgIQaWkNdWhaUHDgf4PfTLtYaN2FyKhYnC/JM+nTxVEm4UyPmu9IdnC4wGE
         kbfJM+vnMvCDUYiP3ehkrkRLQVvTpTat2g+NNejyCt1vlf/t/LDxzp+iGZYx2/xN5OAm
         ldig==
X-Forwarded-Encrypted: i=1; AHgh+Rr+KxwQ+qlbf7T5kPx4OXe/TCBPONvT5WT2SCdglV+K6C73lpQ128LUD9QB6CcUyr+ERH+Jdb3DlhvRP8A=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ksiErWyRhnmq4WERy57jcA1Vml8WXYPy9VamVNP0X4r1j3JkKH
	VA+reRlwZunwa+IRnep8lTAHuwq2VuwR3GQzfe8+nmSXfqzDr4exa+uqXaWbwJaTj5Y=
X-Gm-Gg: AR+sD13MxmqvyQHwyV3Rqu+PTBcZ076IHPdPXyumt8Kg+SkWkHkkmwzyloAvK64SAhK
	Q3xWau/6ZunLEE9Pc0LB5Tk3Z16pxwN+xpuK98KPg/+BXzPWda/fowD+tQPpAb/FkhtuIIwBa6J
	v7hQ0lV0ZgXLSQuLMsfLOCvMFnlWPIhqrsIP54X5whZgYVAujNW9SBckuQkUfL4tvYAdJohfEa+
	rGrivc97SIgGflNYGnpERcYK3n2bmOvUV5FhdUoyrzoaKGEA8L/3G+SDuBp/rbnr8/FfzUyK4ev
	+bmEaWYAADqJ420BO7OD2GBlHQKCq8Zkk4LuvIQpdJaUD+5rYqqzPuuaEpNMBGK4WmUtQjujQqJ
	tGqFExstHXn7AFe8tYaApqiF+X4lyWMDo9ZmmmDhgV1Tjszaxm2o3J6WGVudT2RFH5heUBu9Ewn
	37jkPgSLcrDC6EUziwpi6dD3ip8WmnBKn7/sz6/Qlfr3fW7CzX2jYplfRt01TUTAv9GDlQFGifo
	un55j3zFN1B6/xwkRnojV1m
X-Received: by 2002:a05:6a00:c4d1:b0:856:30dd:91ba with SMTP id d2e1a72fcca58-85630dd920dmr21751321b3a.2.1788162905187;
        Mon, 31 Aug 2026 00:55:05 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f330f88csm3590256a12.10.2026.08.31.00.55.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 00:55:04 -0700 (PDT)
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
Subject: [PATCH 08/11] powerpc/mm: switch device DAX to shared tail vmemmap pages
Date: Mon, 31 Aug 2026 15:53:39 +0800
Message-ID: <20260831075342.57563-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831075342.57563-1-songmuchun@bytedance.com>
References: <20260831075342.57563-1-songmuchun@bytedance.com>
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
index cf692b2b5f7b..831c231a4a18 100644
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
+	unsigned int order = pfn_to_section_order(start_pfn);
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


