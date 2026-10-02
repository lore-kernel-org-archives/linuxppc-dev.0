Return-Path: <linuxppc-dev+bounces-28728-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70B7CA5FE0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:10:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx309748Tz30Cj;
	Fri, 02 Oct 2026 19:10:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790932217;
	cv=none; b=caG/zilRAy6Gy+7iXWnxXOqjlhbqH6smSBxxfXHh6DgjjMIT2i8eEnO9NLvla9dVwWmovT5iUXTbGI5bqSngT3n3d44DpYoTaMtG2/kBig2X5xB9Y/VK8OOmSNAiaYZI5VIirs0rGhkYguxYHeoVArOkDYkiFrcvaxQX2hLd5NfmmKq+dqojuOSumpXXxoIyxUxaNZ7AgFNMFZ90mBHZz350UtVuxyqmEhScwUpJ/taKZTDRKGLWtF8D0OyPu2RZolZJCiSEOpsQEvHhMhXmzyu4KbO5EQK6GCR1W0VqvvtiGxIsMHd2FwqcczGYz/PO/QhhcIBSs//Gska+9v/qUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790932217; c=relaxed/relaxed;
	bh=ACN8gkcsm61w/Jlh0ZvQ88AVu95ak6D5T7q+jQbcfkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AUBLr/oOYgZdyz4DXq8h7ybDcoWm8vW5sPEynri56Llwyje3Qx07s27fREXS21Z0x9zy+my/b+0I7cn71CaXSi2QH932ko9Epf2FAWryyxVqyY8z+CStZLBWu08PjYFYrQ/YUSb8ZpYe7XN18sUJjIpv0TDD7V5nnYjXCVigNwpRJFzhfcluE7aOFXJpNKWVjKuk+FXv4dlnsGf7UT8srWAIhnVgrLU5boqzDManmnX4JOYHmHpkGF5qwXoguQY97WBS32Dz0fHsS9SPm7DJxOoQv3VcQyIHLoq4oulcFLdmedw/HOx6Zz6VDmBNMWkhSJvBahGNcWIvFC1qMZU+rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OW7TDShC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::c; helo=mail-pj2-x0c.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OW7TDShC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::c; helo=mail-pj2-x0c.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0c.google.com (mail-pj2-x0c.google.com [IPv6:2607:f8b0:4864:39::c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx3083vqmz2yDc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 19:10:16 +1000 (AEST)
Received: by mail-pj2-x0c.google.com with SMTP id d9443c01a7336-2e494adf48dso5937275ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 02:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790932214; x=1791537014; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ACN8gkcsm61w/Jlh0ZvQ88AVu95ak6D5T7q+jQbcfkQ=;
        b=OW7TDShCF71Y+2Dtv0DT6VhRaIK8eD+5cX4yDXGgIHYJ+9IIJkKGMQ4I4MuR2y/Z1Y
         WRO86WikriAkI2sLpSwzNxFVOjvRO9P43yVji0x8CzWx9qZUZQu7V+6otvUxyJkjGzSB
         jWB7azzG+jSC2C74lKyf4rfBiNVefj/KiXi54FIj0wcNr7vBrwE3R7hY/MIrJqAcYzX9
         jO95GNo0ROYVzTUmCjIKUcCTB03YYbDUeG1PevUB0Y0/Qc27qBVc3TCe1Vnba4oChZKu
         owaZJzozHDRwBb8GPpUS0402iYsSdQNLQq70ubq8sIWw9o5eZBvGJoSqsL28WRMOyr5S
         z6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932214; x=1791537014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ACN8gkcsm61w/Jlh0ZvQ88AVu95ak6D5T7q+jQbcfkQ=;
        b=BJCH/KJEb6JO6iFnUVmCQ54bV1lE4C1OZ9bwFrw60TY+LqorA2ACaLSBPj7hf+xmI9
         GLBWCxKu2cDqOcyUjHeOUEZZjdMvcG20MBZFhu1c9rSGezKIZu36sbLXZ+Jq6oMCWxI6
         tNBXCtGVNI2cq3P7CxRTa3ray111WYXYEEcyhVIc7gQVxX343ibLKNIxWcDNGWa29UnS
         XkWN5txoMkoB4tVvtHP9NY8lgKovjj0oN//UI9fpyib74kQRi+ZJUcQLLZaqBh4QlMns
         S5/suONBSXLLZcqDsBgE97XeiQUs4e6rmkC/58YtoahaZazGeaeLiVBtSPi8H21zo4li
         30Yw==
X-Forwarded-Encrypted: i=1; AKwUvByx0GOhFoeHWJ8b4lwr4QcxYKH95AhFBxfEzwhP7TVShAZV7vJXTsFD+NcDN6Hp6bOFuFVuqt8eHKpPZEo=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKBg3/x9aeDrG9Ab244hTfIwI2iUmAQUldWmnq7pv4Dix3wBoPO
	uGcyNYhe53Ipew4wABcSCL850Ui/X4tEohAY7BQYSh/UFnTe4OjYwpOZ
X-Gm-Gg: AYBFou3Gk7ecA/e8LDoyqb6Ea68AKuDH3xBTkqFK8OrSpLzzo/FPU5Tut6tueQTiShi
	k8NOcB/7fpW1K/lI+sC8Nb0ruto0R1a6ZUFG2ORmX31hfEQXKbGCRAxnDE3jwbMgU1rsM38qyGR
	Pm+QxeU+dZaymjTzralY0EVk72V1dWB4MqyjhPGfsIc7Kenfv45xtwLWQXHvXnjnyX6h8Kc9NmD
	FnWsjoTv7JNTtsKEkUc5Xa5OE/zkGKOenlBXBJnzO6xjqeFnA4xX+E9tPsO/yBXrVltAn5Y+pT6
	9NzduQKmx2EwiHry6Gnlaq2vbsNL/PY8Rue2ES+ZcfdlnGEPsCzwDXw0zNT6avny75tdq4sTJQs
	uWczbQ+ySSr+3DFt9BEC4/e7Yfii7vynGnXMpdeFw9KyLfVq1mKTRSpKMfXNYQkADjevmEIcYxk
	s54vTQkT81KLxYBeB+uUe2zZlYyf/cGbPDVF+eGx2oXFks7Opc7Vgz7+WVmoPAFMBPJHEalQ58i
	Kln4TkfCAAFBUJFIUAxKA==
X-Received: by 2002:a17:902:d98c:b0:2dd:ad73:c987 with SMTP id d9443c01a7336-2e49b609901mr19907135ad.31.1790932213843;
        Fri, 02 Oct 2026 02:10:13 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6ab2b9sm5480555ad.36.2026.10.02.02.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:10:13 -0700 (PDT)
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
Subject: [PATCH v10 03/10] mm/vmalloc: use pte_set_huge()/pte_clear_huge() for PTE-level block mappings
Date: Fri,  2 Oct 2026 17:09:40 +0800
Message-Id: <20261002090947.869220-4-jiangwen6@xiaomi.com>
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
Reviewed-by: Barry Song <baohua@kernel.org>
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


