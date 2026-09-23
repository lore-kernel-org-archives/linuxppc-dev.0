Return-Path: <linuxppc-dev+bounces-27972-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69038C98302
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 06:29:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqRrh2lZ7z2yr0;
	Wed, 23 Sep 2026 16:29:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::1c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790144964;
	cv=none; b=EObYuEh6gTR7Pe6E7uPYGUCAFRxxPwRV6/LIs8cOAIQUMNtUVRnn1OgFBdeNFZjTLF38bm3YiajvdcaXCiWg/SUBXisloBQh462j96ujY11tYoq/LIUTkdTyCMK2pvamaRwPOlXZgmWPptitFWJ7DMSrVEtek6DJEle9zyG/7LCFDVfSPgaHATNl6I1j1f2xq+NEe8O4BgVLUEu0VhSBvnkIvBFYuK4yWbhFzwubyeRNTyNKUUxpgj5hbCdR92FfolK7NQ+ZICtBQdKd/YKCe7Ny4/OPUgHTI3kJ5qJX1pbyNPglc7BNymWKqzl08mgphRkk3UpjTCezX1HhUgENhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790144964; c=relaxed/relaxed;
	bh=+a2Rdy8KxrMJDsvufLYSYTpVzrgqa1a95U57Pa83CJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j60fyHzYL2oDgi81nT96DfzveUW00j1kvWfJwIHPVOdFtRWqezVoH96P1dyGL6ySO7bBKeU8sk0fG4TzGR/1nEkKUSiu7yiNxqg73OiUAnYztET08R5Dbg1fNkPXHGmQCLNVJa/1fYP3Uuhf2cgMmJhBptToPlPw0CNZS104yK5ZqXooBbgcdwpuM1xuIKPTvs1TABCSpI6FNoaFIwREHZFuNtKsPfe8QkNKs3xGk6JD7M4VDmZe3Kkwe2sSPT3uwn7RmC6f+NphNHVL3md6dFbb2BKAzDtVT0sbwBeOfk792p79bHi+CrVnQqdXeKGg8NV928ae6T0N4FUxphOT/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hiVZ+GYd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::1c; helo=mail-pz2-x1c.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hiVZ+GYd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::1c; helo=mail-pz2-x1c.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x1c.google.com (mail-pz2-x1c.google.com [IPv6:2607:f8b0:4864:3b::1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqRrg4GWKz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 16:29:23 +1000 (AEST)
Received: by mail-pz2-x1c.google.com with SMTP id 41be03b00d2f7-cc745abb731so355082a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 23:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790144961; x=1790749761; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+a2Rdy8KxrMJDsvufLYSYTpVzrgqa1a95U57Pa83CJI=;
        b=hiVZ+GYdexM7RLE0wEhYDbJbR9/xZwZOaxNsVvSY50xiQ75OxBkdQuO93rMv7smWWF
         TTGlMf0aA0+mJsuzA/CEb4BbspSeLRFChT9hn8tbXx7QsZOnFWEBYmbX/da3bHjKgr1I
         2bbnbfreZvuZUZbdNeIHh+3TzsUd7yYwfLywV5gmS/pGevnA2kveQ+a5jcRXY7Bub/Oj
         k5wFbM6U6OwytT8Jxx7GlEGoQMdL0GAz/+BZRFCO/zrzjYOBMnW0xcN4h5c82r/5gYac
         jfOEVMh4sMxA5RrVWsvYmGZRrThfhRdFWmVySE0VftwYcwPWHv0ZHh6u+ColGzNM8U2Q
         Ni4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144961; x=1790749761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+a2Rdy8KxrMJDsvufLYSYTpVzrgqa1a95U57Pa83CJI=;
        b=unLOGkSs5S/q2i4U6OOVZMigNRLzMfd07mw0BtxUIXXYUwHS+VH9L1qRDJ0/pXgPf/
         jJyUiLFAWdXh0wLQFYXWe1w4D/gV/4bu9vJ2vY37fhhXSSzV28ZNYrnM8jhnjoiaoNj0
         O7F3qo1qu42RUgNBPmYF3/Dix/ypwLvaTX9ecvGf3GZ8eKIhkIYvqYcHJVzf8xWIlSgY
         W0SXZakh/2Bt+lZoA9tkD/nYljYSfhtNJlcftHZMDKIhyJVNh/+NuiBDMWQvVyVWwUsJ
         X1w2UdFaDqel2gV+XB50yQe/tSDs9Ioawunj2CQzI2v19QATRiGigkCwAeJBB845hy4a
         Je1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxMzChxChlAFQh4PjSOSGCPU3qsPHrqNdta9BAJCmtYthKIlhBqDWcMXseis+UCsFD4sVdKDAEhPizWufc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l3mE8X1rs/V8IJ58sXi3b/G38LafTiU0XDrQnTDUBQRL32Bmfe
	UY3TNumR+RWYF2xLso0HhW90b7Sol6N60HJuiUn0Lm+TNdc5fh/2lsjj
X-Gm-Gg: AYBFou0Bw8XKQ7onQWMerGhmMfVjkEu5LM9PkofEpbrVeUkgJK/mroueLa6nUNBBEIA
	o/Jvg1WxAMbiW1ePjfWFZB0XV6vy1cAxrN49+bcRJ18myCpie4jQmZ7XNJ+Wsa6eOl67yofPX1W
	S5445qrM/RAZTBZUZeq/QlWClooPPEvDGhrOF3TJDM3GtNJO70XcT+qga787KC8oNRzf7Z1e6ej
	baBMP9u9pBCzWN3pL921ctXHb2Rg+hyOpxsWktB/twN0Q+/8MSCuo31DlorMVdGfSpo5P9G7MLh
	PcGgR+638bKBqQ7cq2gQL3kT6dX3Q+hAsLryZaL+ohWiE01pcV0FOQpeq0FhBxN9zimOntIU389
	U8bmAsAcyahAeKH5NySY1h1rpBqavw/84bjIQvvc71jd48T/rtIM5Fc1pw3tLRj2D//N4Ar5A6Z
	zGVFBwsj8PDdaPGdL8LQLuBpjHUg+/zspG6WCpV6vKj6ffz+sDaWHAiTu1ONkd6iJ0xX2ONNDi0
	GQgiNCE4ZTVgtgmWTXUNA==
X-Received: by 2002:a17:903:390d:b0:2d6:df31:5bd0 with SMTP id d9443c01a7336-2df69d22254mr17039015ad.10.1790144961284;
        Tue, 22 Sep 2026 23:29:21 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a516bfdsm5620465ad.5.2026.09.22.23.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:29:20 -0700 (PDT)
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
Subject: [PATCH v9 07/10] mm/vmalloc: extend page table walk to support larger page_shift sizes and eliminate page table rewalk
Date: Wed, 23 Sep 2026 14:28:29 +0800
Message-Id: <20260923062832.479455-8-jiangwen6@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923062832.479455-1-jiangwen6@xiaomi.com>
References: <20260923062832.479455-1-jiangwen6@xiaomi.com>
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
index d475e52110e4a..6e0dec73107a7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -558,8 +558,10 @@ void vunmap_range(unsigned long addr, unsigned long end)
 
 static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+		pgtbl_mod_mask *mask, unsigned int shift)
 {
+	unsigned long pfn, size;
+	unsigned int steps;
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
+		steps = PFN_DOWN(size);
+	} while (pte += steps, *nr += steps, addr += size, addr != end);
 
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


