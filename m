Return-Path: <linuxppc-dev+bounces-28732-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31A4CA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:10:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx30c14dlz30Tm;
	Fri, 02 Oct 2026 19:10:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790932240;
	cv=none; b=dOSeW4zeuf/HtE6SpKFFST9wq/NzX5yyS/nqp4NSMvhOMlKDJpB09cf2tKrS3WAIxljXBYDas6F0FOE7Bj+QIHdGrl1WjS36lDwA/0WxeD8xq3558uIPidf1RDofzO2rbBJkltuPobO25L9MWZl9Z7Ka9agtUxmVSQQVCyFHSfQsZgrC9s2SpnF1FTnQA+4Of1gMw1Zdx/NP8SVwR4d6bIGRFqp9BCg/U8rICk8N8HEQjbbCoYrGsBN5bgC4litcazq5b81zdTBop/06u+soXcmjBzxdQguTwgKhaKawMeBXdpVkBvwGFXPctYsCkrCGcGyx7XkRNArXeMYDntzAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790932240; c=relaxed/relaxed;
	bh=g+u5Tl/52qc86tZapuAq3nOJxQOQrMAgPsc9gP5V5sE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T3PKEdfK3eVRGzsu8LeUawe8F9PHVNVt4L37ja8uKsdpaeS66DuuMvfmvcbx3VK0t9pyHgAZeNT2efG0xVdjzRRUzZ9VQao79CoIoDIzjrNwUOsjGvibGPGQKGqn/DSwwG5bFnuiH0EF0BLNRiMXbqWXanGakm36jUoZY9gaZWTyuAG4cyhvnYYI9saUGIoCMibxaRqzGo2WqlE2WEjsIIpHGVmEeKAGMcApRc8ghyka7GhD4dHaIaZCvdHFxkYzScUPqU59/ZEdh/OBWKugmWGxziyiA7pqWMkI5kIr4oRI+ipAqdGdgGIVLHway8a1F1dJJjcupF7HM2UbOaL1Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rgd6KH7W; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::25; helo=mail-pj2-x25.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rgd6KH7W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::25; helo=mail-pj2-x25.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x25.google.com (mail-pj2-x25.google.com [IPv6:2607:f8b0:4864:39::25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx30Z58RSz2yDc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 19:10:38 +1000 (AEST)
Received: by mail-pj2-x25.google.com with SMTP id d9443c01a7336-2e2e688de2eso25188525ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 02:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790932237; x=1791537037; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g+u5Tl/52qc86tZapuAq3nOJxQOQrMAgPsc9gP5V5sE=;
        b=rgd6KH7WHX/fo8GaWEAf6Vk2QAg2tylnoZBgFgh3HkdLyNgaYCBG7nxwr999bdyDar
         08FN+7qOb1SkS+Ayv+ZHluzRqho957u0Tk4in0BYpe9PBvRqjNlHvyjmgO2ll1j2mpIF
         +L9X6P9rM0dQFk387Ei4CiB0vG8/GdD4zzqE0yf3Kq7UADfhyGUTs3iuVUnwSuYo11Gh
         IaecvD8niZG+JyPaUwo5E/id+aNYmnkKHMzX+GWJt2vrZYH74m6ydwahjfMQxBzWt7Ld
         +Rm2xO+R0FDdYyev82irnH9vC1mUkQtsTCiQN39YYVgr8aiU51c49fHuOwcr/1XwBWhr
         6Saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932237; x=1791537037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g+u5Tl/52qc86tZapuAq3nOJxQOQrMAgPsc9gP5V5sE=;
        b=Gwtm8DDBqVTG1WuEIQ9/sRbE9G2bXzj0ugvBweW/jWsXuSC7JyiUehHFlS+m9N040T
         j6k5Jm01Ti9+faeEn/9F1mQ1DmtgPzNCCaoBw3EvhWxYOl1uuzD32hmt8f+onMNG9bRk
         9Olv2QDXos+MulDBAR7+DQ9qFwrOAsMEq5zXYzpLKv3DPm8yel4PB1z7YV1XCfGskv5w
         /rwXDeqkuxFTWsmyR7iNoYRwnUDIEZdBePUNVTQT7pRgqMwnVKO8Pj/5NkAv/lDVBeFO
         7yrf41gtZ5Wty/UOrmCVX9JJJAgzesIky9SiEypMqXgduYAGmjxTLGFYzu9qPgsjdIh1
         B40w==
X-Forwarded-Encrypted: i=1; AKwUvBxXqLKNv8sw27tplJwrCft62LxV4kIsQqKJNwq1ixXjdOpMtl8eZBPAWRB4asaN/zfLsOsV6CE/3ChwELI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLXdLl3FVPH55tewvMFPnu41bVKyn/fPy4FinO2b14Di+aZ8BxX
	krXqMsRP2zzTuuvbjt5xH7P6cJ2kjxPu5eqJkzkTFOeBAK2nD1Rtr9oX
X-Gm-Gg: AYBFou36CatMffAgpzWKB0UfZyM5hQphf/kam2gvwUNcum6oSgaxNDuB8Dl5jynBvbi
	Oo8ZrCXntSygrgPzPhAGuUdyc/FFFrqLBONtfnwdhSvT7SG7hmHfmk18hqnqZLIVQDg4sKoqZ6f
	gayH/J25Po8ErbPkenfKl3O9n7tehnmCYYMhle07cRqrzQALSCq57M27DUzOJw/ud4VQrljPQPi
	aBthUkGCBQEdEdBoSYxP+mkZ7YXWlnDdoO9LUuEDl5u1yAzdnnbTt5494chDlIEznztPX27lKNi
	bU6b2J0fj5C89Lk4JyGCrN7HEKbmg/sc5qwIFem8Ftpb0wZLv/p2qHC7BK5Mcxmccb+rBf/+AFg
	2Z+GMGqhArwuip+RrTgRkZw7ELLTFMF23UMV63KtoGcxR9wnxEJqHKAg3J2XXAnmxGYBvGK4L/i
	7sEcnTwAXW1+iB870+vmPQnVmdr3rfa4D+uNCRtPWP6cjsDnyIkvdbFgaArIwaqTCkNsn71ediV
	HYq6dX6X8+Am7UoA9ofUs7QBuZoUpex
X-Received: by 2002:a17:902:dacc:b0:2e2:c03c:f625 with SMTP id d9443c01a7336-2e49b6121eamr18607265ad.13.1790932236632;
        Fri, 02 Oct 2026 02:10:36 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6ab2b9sm5480555ad.36.2026.10.02.02.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:10:36 -0700 (PDT)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
X-Google-Original-From: Wen Jiang <jiangwen6@xiaomi.com>
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
	ryan.roberts@arm.com
Subject: [PATCH v10 07/10] mm/vmalloc: extend page table walk to support larger page_shift sizes and eliminate page table rewalk
Date: Fri,  2 Oct 2026 17:09:44 +0800
Message-Id: <20261002090947.869220-8-jiangwen6@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002090947.869220-1-jiangwen6@xiaomi.com>
References: <20261002090947.869220-1-jiangwen6@xiaomi.com>
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
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 84 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 34 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 72ec1b48a76de..99bd22c086bf8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -558,8 +558,10 @@ void vunmap_range(unsigned long addr, unsigned long end)
 
 static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+		pgtbl_mod_mask *mask, unsigned int shift)
 {
+	unsigned long pfn, size;
+	unsigned int nr_pages;
 	int err = 0;
 	pte_t *pte;
 
@@ -590,9 +592,10 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 			break;
 		}
 
-		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
-		(*nr)++;
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+		pfn = page_to_pfn(page);
+		size = vmap_set_ptes(pte, addr, end, pfn, prot, shift);
+		nr_pages = PFN_DOWN(size);
+	} while (pte += nr_pages, *nr += nr_pages, addr += size, addr != end);
 
 	lazy_mmu_mode_disable();
 	*mask |= PGTBL_PTE_MODIFIED;
@@ -602,60 +605,88 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 
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
+				*nr += 1U << (PMD_SHIFT - PAGE_SHIFT);
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
@@ -670,7 +701,7 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
 		next = pgd_addr_end(addr, end);
 		if (pgd_bad(*pgd))
 			mask |= PGTBL_PGD_MODIFIED;
-		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
+		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask, shift);
 		if (err)
 			break;
 	} while (pgd++, addr = next, addr != end);
@@ -693,27 +724,12 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
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


