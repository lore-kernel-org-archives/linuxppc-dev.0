Return-Path: <linuxppc-dev+bounces-27544-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D88C982C1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 05:41:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hll3y1QGYz2yCr;
	Thu, 17 Sep 2026 15:41:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789623007;
	cv=none; b=T9Diz1x5wfvnKkG/1TBQIoZIRSxira3KmFhP3BMTjH+qitBolziSLVXZDl3Asr0cy4sMy0PaYI0CDbt0vFrLCmV2qNEUQVgErDe17vShjgy0LRWq3opc/it+Tg+H0R9tn4rqZQMRhDTu4We+gw+byQkaNdg8hQ8VYOZZXvQf4mSclSRs18EgvXv/nP1zmEuI6OnTW1oZeAkj+baBfy+p4Yqjo7lozaZHpg1xnm7Zae5uvMPYovBr5olY2di8KaS5gQKgPPXYsuUOsUtodToQvgqZiMxcSllKc9UNStGC94AV0s07r5R3DPMaIN15hLWRIeZ0Sz+AFh8XkTcXe4AXwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789623007; c=relaxed/relaxed;
	bh=/iHoeiOn8M1Js0lz6hY05jc0JjGSYBNXCmk3v6q8ZOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=em7cwAcpIJlU1GyFDt3dWC4idSI4tAIR6Lcw5DZeVUGuKpgrGgvylATDGiYsHS2d+VyQ7lanZCM7/iL/558OcpBHs4m/WbRznBqLZlrJbzXVsocoy1RxqLUObRyosAT5LXro58DuxxQHCCN6ivy2P3hOI1OOdbOjsMBQUhCK7YUGjoPOpH0bDYgXFbyrWuBtkmrf0hpALyA4r6FBZry6LDu3nten0FrqLCJOF8LA5otX6agUKPhzdNWqlUemwzmTRzv+kRBubI7u6ZFo/We1IZDG93d/Y5coovEIbw+5fz/it6dUkeqV32ab9zB26mUuAs6GvoCaGGqJSD8m8D/RMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VxAoc9g5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VxAoc9g5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlkq24QgLz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 15:30:06 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2dd77300816so1079625ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 22:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789623004; x=1790227804; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/iHoeiOn8M1Js0lz6hY05jc0JjGSYBNXCmk3v6q8ZOE=;
        b=VxAoc9g5GwsyxGYbIhL8eA66sYCadJ4RQAqAsna3bDWKXLmkZFEwiavVJh0kGjyyNj
         vz4GrloRsJPXiIZnaOdgF8DjIVOW1dzJtf6Cd10awHEjSeos11YHhAKKtdXSsDGGQsJZ
         6iVgT3SAncYmRXCodROgxdgWQg6RRDMPo+ezLYSxeqp8y8tu8mFC4/5pz7/EJRqfz7K7
         Uimky2uc9ZixcTVV2D5+oKubPY8xOd+D/C97gSG25ewSQms4/2jMrDWtrJ5fuVfjr6T/
         yI4LhOpbDE3dN81jBkVvb+HH9DMex79lm79N6E5p+uVPU5AbYpjIDvlwHGmlSMYDrXQd
         Q5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789623004; x=1790227804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/iHoeiOn8M1Js0lz6hY05jc0JjGSYBNXCmk3v6q8ZOE=;
        b=BxY8dDCVFbOkfxKzY8mIQxJt8owwRl+w6qWdLY0EnenYOBPwvnsBU/KfXyCIF4hzMp
         Xs+/g8ZkBRskxeVPGpnrwLCfokQnTAQfZc9dqJPFNF9iSQ0jnHlurQHkILNQKE8GmdQx
         PPssKuk5FOAMUKDT+RQEd8ZFxfr3POiFK3dyuKn/lbjSHPpPGf0VLJOO5U1d3Dl6dAgS
         WTqQEo+9TmdPOjnQ3mIxk27cZhKSLOskzy88qIabWcPAVIutXI4XQTSNlCGfetVO2fFB
         h+Q1IQ4LoyCAtzSIUurKn20fMPXjYgtncNa2RP8YxaQI/6Ny7eMkq0gJLjB9X3zdKNEN
         FMSg==
X-Forwarded-Encrypted: i=1; AKwUvBytcljRsjR59iPaMIPPQ9w1ZEbBGZNFQuVwWkDSwoMIdKlbrOawljHiXxJF/aqYcXkLgusFLAcqDuKaKTg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k1rkYj8ti58xKvlCtNOQrA8He0rIRFD4LZ0FvrPZP6eH/VmaqT
	haZSuXen1z3UOfqx8YdxIZInVn77E9ZBBtp8w3BNfqMAxE2wVSQedzRv
X-Gm-Gg: AYBFou1LkjApTvxRqXps0saW9SvqOhenmUGTQZ37/7CEW7M9BW3UKbahbkEBFMN6TLv
	7dKnr/cubNJSOqvLCgxIhIcoBKZTmpRZnxHHs2nEIm4skJWeMcu9BLoQTJdxxPh3HGadqsnz4fU
	L756spZDQAYSPQdiuXqm3Ffm4eYSILs06oMThKQeT5IvX0q/hZEiG6EEaOVELbjbN00AkykxO12
	BRlE4fHYymhMnhg0qlu6d8R/Fq5DG90bQvse+dRyrnGxOYeUTMl6OIKd/FlY9Lhxt1wDhn4Qyae
	iIPMulMxHCht8nmYSY2nVKubbfks7+u8fPS7uPufJK8Y5rdtAk2PrOO5qOI8Nke7VaKIEci2aaJ
	F7D/YieoOktVDzTUQSMexPDxNkIzobTfabwd7Ejh2fM8j53wfgaQ9G8A1XOlXr6sNS4ubdYvdJg
	J8Lb1vDEvPuzkqrneloaPgezJBvKpexVLFkFHRk1rJrfDZx0z4CyLvDY7gxVPiyVfzvXHWxugGY
	UqRo7tEbVbi3ecPpYy8CAQ1KfE=
X-Received: by 2002:a17:90b:5484:b0:39d:b57e:b47d with SMTP id 98e67ed59e1d1-39e35f809c5mr2777472a91.8.1789623004300;
        Wed, 16 Sep 2026 22:30:04 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3abada87sm1955836a91.14.2026.09.16.22.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:30:03 -0700 (PDT)
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
	ryan.roberts@arm.com
Subject: [PATCH v8 03/10] mm/vmalloc: use pte_set_huge()/pte_clear_huge() for PTE-level block mappings
Date: Thu, 17 Sep 2026 13:29:26 +0800
Message-Id: <20260917052933.188679-4-jiangwenxiaomi@gmail.com>
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

From: Wen Jiang <jiangwen6@xiaomi.com>

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
which requires an arch implementation. WARN_ON_ONCE() makes that
explicit rather than silently doing nothing.

Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
---
 include/linux/pgtable.h | 29 +++++++++++++++++++++++++++++
 mm/vmalloc.c            | 19 ++++++-------------
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index cdd68ed3ae1a9..349ced999f959 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -2134,6 +2134,35 @@ static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
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
+	WARN_ON_ONCE(1);
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
+	WARN_ON_ONCE(1);
+	return __pte(0);
+}
+#endif
+
 #ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bb6ae08d18f58..025b3a848d564 100644
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
@@ -98,7 +97,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pte_t *pte;
 	u64 pfn;
 	struct page *page;
-	unsigned long size = PAGE_SIZE;
+	unsigned long size;
 
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
 		return -EINVAL;
@@ -119,17 +118,12 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
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
@@ -368,25 +362,24 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
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


