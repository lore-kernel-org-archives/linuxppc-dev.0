Return-Path: <linuxppc-dev+bounces-27548-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73122C982C1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 05:41:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hll4R6DhYz2y21;
	Thu, 17 Sep 2026 15:41:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789623034;
	cv=none; b=jZPHP4kWWbVZwefTAzRzXyGkGIBG7X/YkmGll5pUCgJUuBCY0qmO4O6XVhv2Zo/JbaN01ABiNMm3uqDxYfcwupF77AxMS1hPK/IidKoGHjgRxPKkGGl6CC3Jk/u8IuDBkpwJqMegAUTXNVNxygKyMb0fcAUB1a0eJz8juvMbeFTsHYHiRErdtVTL1cQHjv0OBfTDRgIw9hTb5AUd8E3GcVtg1Vq3Oec32ACrc5JjS6I+9sF+tIQkpSWVPLFt6TyVA/cchwBpXg/xSMlJx841HLZWFjfx2RRuMCTeW+rCmNijdCVtnvTsS2AmBORCQTkQ8blA3hxIpACHZD1Eul8P8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789623034; c=relaxed/relaxed;
	bh=XToDi6fIsVYoV27kQlhNobBUYsIv/tm0eptMLl1rq74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LoF6YDll+fKB1mKhc+vLvIW7/MjH6PRYiai0dFGfhw1zbN6Wcb7r5+YcckxBlMqXRlWmpjrVy125I6gfACaoFZLTWdJtr44otYOHrcWkQRIfIUo1ziYXyqkN09/dvzqPMFmHL06xTlpSZnfZmQji9o/PcheRYg4vn5eSb2xeKLZRK3vTr2QDeU3rvp25AlMmKCFbs7eiqa10rbS5Ff6Fe2P26Jn5DNq/gCS9GC31+1A6X5uvpm1wRsF4AmpRFRdaTOpU9KxdsdsHV8MwKErbdmKl9PCWsWq+Rx2nJ4f4eEC2dx9wMHd9XaXV0EmAvx9N+UEgAnPhnSeY1cquT0FhvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ppNa+9H7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ppNa+9H7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlkqY6qjHz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 15:30:33 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2db22383fe8so2719275ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 22:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789623032; x=1790227832; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XToDi6fIsVYoV27kQlhNobBUYsIv/tm0eptMLl1rq74=;
        b=ppNa+9H7MzTPjnEa16AAJ2mqARjIMZNb2ahfgM+723ui+JVKjvK/t3hgWIBsRrPyAo
         +YxDjVITA2BHN1hszeenuMCfjCmyp680v5DBblOOngG6l3CB6C4bZXqziQ4FGIrCTQcD
         lqnnN47YapSCbDESqOVfmO3cNznye6jH70ftFE2MHt6vCOSPneKgnxTa3ilMRY4wtfbf
         MysxBx8Fryktme5UJuuj+q4AtyZ6g13hfrzdLMD27m9kTGZtulG3lno+V7Kx1RJ/oU1x
         azOBCTRWb8xTUopLDB/XktAf5H5Kmpo5geICgc8cFEwSTrED3X3d9/bC8F9AUPXZx7fm
         bubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789623032; x=1790227832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XToDi6fIsVYoV27kQlhNobBUYsIv/tm0eptMLl1rq74=;
        b=ChnQK7fN/sHkMrrjjPRPSHO/939LZpE0jmhOfAXf9t9nZLrK5hDIfts4Sheh+FShMK
         WuWwRvQfvbOuhXkTO4BMD2udt96W9DiPwKXWoGaflsOSExzt8AkVAcatEQZxn8TGOPge
         +UCFCnecVxzfE6+2K19vdsXpsrC/9nP+tec/g+xDFhfXtPwvTpH/tH3w5rv64U0wIoUW
         Ji2q1p0XcgrhKq1vjWgMrA70LcnyXVo54qFgOgnFTh3SXp4kEl1kg1DSSgujKa9fyAa6
         0Cz6KVAnH8ElY8FuHBBKQUFHItnoUULSmVMM4FTPKoEhTF8AwI0ann6xkU/ptD4tRFlW
         kZug==
X-Forwarded-Encrypted: i=1; AKwUvBypnZZ2Ye2bSngq8lqsQDYCvyF4CPYbm3ZjKEtbyM08aY8GjXPq16/RCv/XnitzhLkV0BXVnPcfqb41e1c=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mjc6cBJZx+uRsQEkkRJqar4OcckH7Dg68pBgluR3jj7l0SOEw1
	ou4wRlaVLV9AoCvYr9Ik72vyIXiUpqJht4N6KnI3hYfIS+1nLMiAzflP
X-Gm-Gg: AYBFou3qfo8Rne/DerKLoarhzuBZ5HsGES37hagpt2B0+qiZghiYlHYZSoYtDZkwPnz
	j1JiLFWS62F+9ZVzLoicLTeVf5PFFqCtSlxhEvXrL6Ddy8x2SEEtS8eDazzzsrvpp9sMTrKsREB
	uQ+YVP2hWr9IHYce6SMtil15Taj29QHyFxuyAhWBUM1FRaAR8M6O3dWs6aTGI3BDAVHGHy8dvIo
	o4tbp57IA+2q3hQjtnlKsM1UCDj6pF8HszeZGJ9/BRDsOMBCi1TSpLkIVAiYP6qCL0fpj4Gv5z+
	Kse+1eWtzqy50WdLYveR3ONAdVX9vdxx7n4n8zG9hsuUZb6M1szwRqDfPoQe6ZXes0MZzwVE4zA
	Al1OtQIbzY5sHi/ZZAA9ediobGDFzRH5icJZu4En7IXqOJLfVs9mcRyQkWfK832LVzlbGKSrPSz
	0SWwLXreQcpEtq3BCsRuG2Xo8kD7i6MxBr29X7vhKB8UomPG7oH33jf5fW3hiZR9Tl1Pnw/GZwv
	9j0t81zaMUg/iqeVE4tofhDfpE=
X-Received: by 2002:a17:90b:4a51:b0:39d:ee20:1e28 with SMTP id 98e67ed59e1d1-39e1e510f73mr15610978a91.21.1789623031887;
        Wed, 16 Sep 2026 22:30:31 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3abada87sm1955836a91.14.2026.09.16.22.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:30:31 -0700 (PDT)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
To: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	linux-mm@kvack.org,
	urezki@gmail.com,
	will@kernel.org
Cc: Xueyuan.chen21@gmail.com,
	ajd@linux.ibm.com,
	anshuman.khandual@arm.com,
	baohua@kernel.org,
	chleroy@kernel.org,
	david@kernel.org,
	dev.jain@arm.com,
	jiangwen6@xiaomi.com,
	leo.yan@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	Xueyuan Chen <xueyuan.chen21@gmail.com>
Subject: [PATCH v8 07/10] mm/vmalloc: extend page table walk to support larger page_shift sizes and eliminate page table rewalk
Date: Thu, 17 Sep 2026 13:29:30 +0800
Message-Id: <20260917052933.188679-8-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917052933.188679-1-jiangwenxiaomi@gmail.com>
References: <20260917052933.188679-1-jiangwenxiaomi@gmail.com>
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

From: "Barry Song (Xiaomi)" <baohua@kernel.org>

vmap_pages_range_noflush_walk() (formerly vmap_small_pages_range_noflush())
provides a clean interface by taking struct page **pages and mapping them
via direct PTE iteration. This avoids the page table rewalk seen when
using vmap_range_noflush() for page_shift values other than PAGE_SHIFT.

Extend it to support larger page_shift values, and add PMD- and
contiguous-PTE mappings as well.

Rename it to vmap_pages_range_noflush_walk() since it now handles
more than just small pages.

For vmalloc() allocations with VM_ALLOW_HUGE_VMAP, we no longer need to
iterate over pages one by one via vmap_range_noflush(), which would
otherwise lead to page table rewalk. The code is now unified with the
PAGE_SHIFT case by simply calling vmap_pages_range_noflush_walk().

Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
---
 mm/vmalloc.c | 84 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 34 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a0508bdb7d36f..cf1daf931a6f6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -535,8 +535,10 @@ void vunmap_range(unsigned long addr, unsigned long end)
 
 static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+		pgtbl_mod_mask *mask, unsigned int shift)
 {
+	unsigned long pfn, size;
+	unsigned int steps;
 	int err = 0;
 	pte_t *pte;
 
@@ -567,9 +569,10 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 			break;
 		}
 
-		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
-		(*nr)++;
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+		pfn = page_to_pfn(page);
+		size = vmap_set_ptes(pte, addr, end, pfn, prot, shift);
+		steps = PFN_DOWN(size);
+	} while (pte += steps, *nr += steps, addr += size, addr != end);
 
 	lazy_mmu_mode_disable();
 	*mask |= PGTBL_PTE_MODIFIED;
@@ -579,60 +582,88 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 
 static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+		pgtbl_mod_mask *mask, unsigned int shift)
 {
 	pmd_t *pmd;
 	unsigned long next;
+	int err;
 
 	pmd = pmd_alloc_track(&init_mm, pud, addr, mask);
 	if (!pmd)
 		return -ENOMEM;
 	do {
 		next = pmd_addr_end(addr, end);
-		if (vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask))
-			return -ENOMEM;
+
+		if (shift >= PMD_SHIFT) {
+			struct page *page = pages[*nr];
+			phys_addr_t phys_addr;
+
+			if (WARN_ON(!page))
+				return -ENOMEM;
+			if (WARN_ON(!pfn_valid(page_to_pfn(page))))
+				return -EINVAL;
+
+			phys_addr = page_to_phys(page);
+
+			if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot, shift)) {
+				*mask |= PGTBL_PMD_MODIFIED;
+				*nr += 1 << (PMD_SHIFT - PAGE_SHIFT);
+				continue;
+			}
+		}
+		err = vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask, shift);
+		if (err)
+			return err;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
 
 static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+		pgtbl_mod_mask *mask, unsigned int shift)
 {
 	pud_t *pud;
 	unsigned long next;
+	int err;
 
 	pud = pud_alloc_track(&init_mm, p4d, addr, mask);
 	if (!pud)
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
-		if (vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask))
-			return -ENOMEM;
+		err = vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask, shift);
+		if (err)
+			return err;
 	} while (pud++, addr = next, addr != end);
 	return 0;
 }
 
 static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+		pgtbl_mod_mask *mask, unsigned int shift)
 {
 	p4d_t *p4d;
 	unsigned long next;
+	int err;
 
 	p4d = p4d_alloc_track(&init_mm, pgd, addr, mask);
 	if (!p4d)
 		return -ENOMEM;
 	do {
 		next = p4d_addr_end(addr, end);
-		if (vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask))
-			return -ENOMEM;
+		err = vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask, shift);
+		if (err)
+			return err;
 	} while (p4d++, addr = next, addr != end);
 	return 0;
 }
 
-static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
-		pgprot_t prot, struct page **pages)
+/*
+ * It can take an array of pages which are not all contiguous, but it
+ * may have contiguous chunks, as hinted by @shift.
+ */
+static int vmap_pages_range_noflush_walk(unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, unsigned int shift)
 {
 	unsigned long start = addr;
 	pgd_t *pgd;
@@ -647,7 +678,7 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
 		next = pgd_addr_end(addr, end);
 		if (pgd_bad(*pgd))
 			mask |= PGTBL_PGD_MODIFIED;
-		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
+		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask, shift);
 		if (err)
 			break;
 	} while (pgd++, addr = next, addr != end);
@@ -670,27 +701,12 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
 int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
-	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
-
 	WARN_ON(page_shift < PAGE_SHIFT);
 
-	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
-			page_shift == PAGE_SHIFT)
-		return vmap_small_pages_range_noflush(addr, end, prot, pages);
+	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC))
+		page_shift = PAGE_SHIFT;
 
-	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
-		int err;
-
-		err = vmap_range_noflush(addr, addr + (1UL << page_shift),
-					page_to_phys(pages[i]), prot,
-					page_shift);
-		if (err)
-			return err;
-
-		addr += 1UL << page_shift;
-	}
-
-	return 0;
+	return vmap_pages_range_noflush_walk(addr, end, prot, pages, page_shift);
 }
 
 int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-- 
2.34.1


