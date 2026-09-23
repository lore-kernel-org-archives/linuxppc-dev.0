Return-Path: <linuxppc-dev+bounces-27968-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02450C982EA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 06:29:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqRrD2JDCz303F;
	Wed, 23 Sep 2026 16:29:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790144940;
	cv=none; b=XwwQMVoHH8axvRKJS0S89/DRMCxIyxNyOjFJOXf20iD3y+HWHE5jPeIQTlZXYmxjV0RMx4BJv4Gh9vNhmE3OXJJR6ulVPvZogL1j7S16kr9w6/kpzxRP/Si5bg/KVBv/WdjQNVAqngXSqBwoJ97J/NgIu3uVuqhJvnPICPw969UfFFfMB0n3EPHSxnLcrr9hm7cksEvCJsbePZkKge3s40XVRjHuH/Kz1wtQv96hjybW0YTvysxs424mobb2/bX++fPfOSkVoVFiSq6y5dWkeeEXgQhFKN63ltJUQA28DJcBQZKBjLvDzt3PE5cM/v+jD9O7iY1Z92vHZVrP5C6qKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790144940; c=relaxed/relaxed;
	bh=aFifGOrpSVWAs42j7AiNSWIOQBImLaH7pX+Uvfxk6V4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dcETFLlQeiy8uAIQN7nb0ziwPG5yr83EwVGss9M1lmYQ6G8D+I2OvK7ynAbcrKQhHBvbRWMTCn0sifp5Hym1s37RdNx4vRUHeB5N4fqVmSWOUj7RB/IbeexUaKvQmqxJT2LyHGpHeA4fJ0HjKspitSPBpi6PZq/zzKXEvUoEJ9IBr/I2vHdM8/SeuDmtIS6+vVAp5XNh75d1Wo2hKsE7XTGb4MIdMBDBjFicl7QJ+Y5jvki6Y8UXKUS+4TrMVqXVY8dyD/M3fpmR9IsMfOETRxP3Xv1SLmb7KdJufUphSF2FyqmbTBo1WK49goVfRL9H7vpIF7z8b6Cbglj2uU2naQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rz+OotHF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rz+OotHF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqRrC2C1tz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 16:28:59 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2dd53691be5so3461905ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 23:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790144937; x=1790749737; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aFifGOrpSVWAs42j7AiNSWIOQBImLaH7pX+Uvfxk6V4=;
        b=rz+OotHF6eFHVcbelZaQkdCvdgelma5r9frdqi9wEva9b6x/nC2pLU+hDwkAhZZ4Eg
         n3jsxwKiq1x8tLv8MSIZlDFWm5mBMqxglTmTQsY9KxNz2Vt3oyVdg9xyIwMNMwd5+kZi
         sAmqHzaLechPn8TTdbIcFrOgqg8XxQbFp9xmliPf+CpTqj8Rg4ySrQK6hg0Wr2EDpNy3
         757e3MBLUEis0A2pAfuYG6VnNZWWhF2pig89iN+DXqpR8fhqNTCS8JPHFNFI7hdj+f8p
         JJdtupG+gvLllUzQxT7FLJgwTmnjKQCXtGX4mZ0vHwl8QKDx743UyJvOwcC+ETvVkun6
         vtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144937; x=1790749737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aFifGOrpSVWAs42j7AiNSWIOQBImLaH7pX+Uvfxk6V4=;
        b=v+eisXhpMigE2IgC5+2FgO/K7+/5vVJ+1ouUY2rAjNQzCYYdu/4gzNRkds2wOdlLW5
         Sfd9Ys2vbe/iq5t3caXHFAs83TNfl8d9y1e0FUCK5uAHa0kbR/ry3R7gT6vdYEagYIkm
         1EMcWkjJvPllG1+5D+bLlX1CCAku/KJYVG/HNtw9NQ0CntkDNpUdFzsyXsSmr7xByGph
         OJOLPE+ocPMHY7B9sOb+o46jd10JNB80VhVZYT89qNvBpmzq4qjfIl7Ehvx8cvLINnSa
         ZQqfBQEK6nEqZ2UEiIR6h28HwzVCjJWqt7g6H7gkzH+Apt0t+h53XPiHOzX+yd0ksBsG
         GICg==
X-Forwarded-Encrypted: i=1; AKwUvBz7oOtvTxJ2ioOl5uiuSGs0E+vvobmV0nLs8slBacqXFZuNrtk2kATzuPjcYmkOUufIByFNhiuJ2iWOs4M=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kRKW4CxJzGm7fq1sWwcvDjL9yJp3+HFcghIXWZU7L6NkTzlVNw
	0yJ5TUZTZhulLYZMDtJvbVyqHiNHgBujOpJjqmqKIMInQU5nEQ3laxwd
X-Gm-Gg: AYBFou3Xz+bHOLy9saK3Qj8UCo0+iqeFsFZPmoEtWXuuZ4IQCd36VQhjsSGLqFN0/Cn
	wN8Nw2E9MAk1kE7rMHdr2z077eXRnKgM1La+mZzsu1pYF+2wmm3wRLCwVgmfbBAI7RTWPjuVBR/
	IR28cR4rU4Foty8mHJms3zVX5SLZfUkvX+yOYtyMrMa8XPJB8ghf+2XZl3Lp8+xs8iqrHCRNWvn
	CYhmRB3lmaEmThAtKpdY/E5uvGfaiAC3tgeHWS/oGgERbc0cZrKUratry88wYWxFA1SCX5PjnBY
	1AZu91bYE3nfCN/NRMGxGE+itraoSabKRv0iplDrXMo9Kfv8Y0ItUnm4PwQT+XjLAOkbYNG517F
	OQFB9E0lgcZCWeADK7OLNGcaNtREfpou+AllWlSJwoo3Bl69bW1AiImS+NKlMC9lms6HdHWdb4B
	jMcwOTGaZ+5GQgd2uCBYjfR84L0RmVbGaQZmiGmBqTLcwotU8mV3rYDXSXfDp4bjcltf/8Vtmjb
	52MTaubsHyfFU9arpyzXVXiNl73yGDB
X-Received: by 2002:a17:903:3904:b0:2dd:c100:9435 with SMTP id d9443c01a7336-2df69e02500mr15989755ad.51.1790144936998;
        Tue, 22 Sep 2026 23:28:56 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a516bfdsm5620465ad.5.2026.09.22.23.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:28:56 -0700 (PDT)
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
Subject: [PATCH v9 03/10] mm/vmalloc: use pte_set_huge()/pte_clear_huge() for PTE-level block mappings
Date: Wed, 23 Sep 2026 14:28:25 +0800
Message-Id: <20260923062832.479455-4-jiangwen6@xiaomi.com>
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

vmap installs PTE-level block mappings by reusing set_huge_pte_at() and
huge_ptep_get_and_clear() under #ifdef CONFIG_HUGETLB_PAGE. This makes
the feature silently unavailable on CONFIG_HUGETLB_PAGE=n kernels and
couples mm/vmalloc.c to HugeTLB internals it does not otherwise need.

Now that arm64 and powerpc/8xx provide pte_set_huge() and
pte_clear_huge(), add the generic fallbacks next to the existing
pmd/pud_set_huge() family and convert vmap_pte_range() and
vunmap_pte_range() to the new helpers. The CONFIG_HUGETLB_PAGE guards
around the block-mapping paths are dropped, so PTE-level block mappings
now also work on CONFIG_HUGETLB_PAGE=n kernels, and mm/vmalloc.c no
longer includes <linux/hugetlb.h>.

The fallbacks exist only to keep the build working on architectures
without PTE-level block mapping support. They are unreachable there:
the callers only run when arch_vmap_pte_range_map_size() or
arch_vmap_pte_range_unmap_size() return a size other than PAGE_SIZE,
which requires an arch implementation. BUILD_BUG() makes that
explicit rather than silently doing nothing.

Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
---
 include/linux/pgtable.h | 29 +++++++++++++++++++++++++++++
 mm/vmalloc.c            | 19 ++++++-------------
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8c093c119e5a8..a7fd51fec8a17 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -2204,6 +2204,35 @@ static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 }
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
+/*
+ * PTE-level block mappings for vmap.
+ *
+ * pte_set_huge() only has to be implemented by architectures whose
+ * arch_vmap_pte_range_map_size() can return a size other than PAGE_SIZE.
+ */
+#ifndef __HAVE_ARCH_PTE_SET_HUGE
+static inline void pte_set_huge(pte_t *ptep, unsigned long addr,
+				phys_addr_t phys, pgprot_t prot,
+				unsigned long size)
+{
+	BUILD_BUG();
+}
+#endif
+
+/*
+ * Likewise, pte_clear_huge() only has to be implemented by architectures
+ * whose arch_vmap_pte_range_unmap_size() can return a size other than
+ * PAGE_SIZE.
+ */
+#ifndef __HAVE_ARCH_PTE_CLEAR_HUGE
+static inline pte_t pte_clear_huge(pte_t *ptep, unsigned long addr,
+				   unsigned long size)
+{
+	BUILD_BUG();
+	return __pte(0);
+}
+#endif
+
 #ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bea9f76ed7e74..fb757d95bde25 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -38,7 +38,6 @@
 #include <linux/rbtree_augmented.h>
 #include <linux/overflow.h>
 #include <linux/pgtable.h>
-#include <linux/hugetlb.h>
 #include <linux/sched/mm.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
@@ -100,7 +99,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pte_t *pte;
 	u64 pfn;
 	struct page *page;
-	unsigned long size = PAGE_SIZE;
+	unsigned long size;
 
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
 		return -EINVAL;
@@ -121,17 +120,12 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			BUG();
 		}
 
-#ifdef CONFIG_HUGETLB_PAGE
 		size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
 		if (size != PAGE_SIZE) {
-			pte_t entry = pfn_pte(pfn, prot);
-
-			entry = arch_make_huge_pte(entry, ilog2(size), 0);
-			set_huge_pte_at(&init_mm, addr, pte, entry, size);
+			pte_set_huge(pte, addr, PFN_PHYS(pfn), prot, size);
 			pfn += PFN_DOWN(size);
 			continue;
 		}
-#endif
 		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
 		pfn++;
 	} while (pte += PFN_DOWN(size), addr += size, addr != end);
@@ -391,25 +385,24 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 {
 	pte_t *pte;
 	pte_t ptent;
-	unsigned long size = PAGE_SIZE;
+	unsigned long size;
 
 	pte = pte_offset_kernel(pmd, addr);
 	lazy_mmu_mode_enable();
 
 	do {
-#ifdef CONFIG_HUGETLB_PAGE
 		size = arch_vmap_pte_range_unmap_size(addr, pte);
 		if (size != PAGE_SIZE) {
 			if (WARN_ON(!IS_ALIGNED(addr, size))) {
 				addr = ALIGN_DOWN(addr, size);
 				pte = PTR_ALIGN_DOWN(pte, sizeof(*pte) * (size >> PAGE_SHIFT));
 			}
-			ptent = huge_ptep_get_and_clear(&init_mm, addr, pte, size);
+			ptent = pte_clear_huge(pte, addr, size);
 			if (WARN_ON(end - addr < size))
 				size = end - addr;
-		} else
-#endif
+		} else {
 			ptent = ptep_get_and_clear(&init_mm, addr, pte);
+		}
 		WARN_ON(!pte_none(ptent) && !pte_present(ptent));
 	} while (pte += (size >> PAGE_SHIFT), addr += size, addr != end);
 
-- 
2.34.1


