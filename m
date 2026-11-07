Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB949606A32C
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UT4fUpmy
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMHVm4DT0z2xwM;
	Sun, 08 Nov 2026 00:50:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794059424;
	cv=none; b=mM20GldUmMDQoH1aVu5jICQPR7BqSrRvj96f7K9RmW5e7ipNUkVUqcelBISZDstkybyQKw3dYXB0ebMu+SYjfnxkL6D/o2K5qmIjXluUeb9hTxjlE1KrYK+vzKc0bMjZAV2L6Xt9osmDkEbn1R8UieYr6y1FQRR4NH5X46fQPVoiLAovw0Dt7q1M3WHvP4je4rNlGS+egolU064TKlOoBvLGiagpS4IQmzg7b+Uq/KEkSi9cXKn+7rsBdmmsxpSoqmv6iMlXTP15fmLbnXQSsb6NoBizvyuO/a2nzAMlm6bOFqPTZO1WmpybTga8hD419AaMJE9PW7gxR6/DmZ9OFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794059424; c=relaxed/relaxed;
	bh=0tSO75+dLoTbxUTsccW1GH3+P5H454b2/ssDfpBt7oM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DVUX3Xh10zZ3V4CdPgCwfie3RaCA1djKZqV4K/WSCtI2aLj8KZxxzlBI7Troo2psFWfIJAuOHWpDY7N3P+LavtOtOmvz4HjYtDoPZscJfSKh+sDFFxIjlEL9T9NyaQCdZJ57AEJCKeL+KCExXtBpMXGyMg4yMLzkwwY47K0DRyYuq/TZPMjVffSQQfTqps0IUTFWX4PfcZu3R2YlUftmQv9fAUylMNIJzDQNRl72O4JiDF8J8e0GhBC8+qXGl774kqkrJ0mE/4LsEkNYG+UssxoB8+Ai2s2Qv2o4F8tCUpOITL3Xc51eX5SSpXw+aOFHTPn+zF9LE7FwufjtiWuu8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UT4fUpmy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UT4fUpmy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMHVl6JWWz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 00:50:23 +1100 (AEDT)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-36ff9c9da34so2075490eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 05:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794059422; x=1794664222; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0tSO75+dLoTbxUTsccW1GH3+P5H454b2/ssDfpBt7oM=;
        b=UT4fUpmyMj1UZbBIxLKL1I4l9dTnLhD4YSxetGZE7kzpZljfGotWHY0QrDK753GN6H
         qscuFu1EsZBaUdMAU6yOXVEsTNwv0P+Cp4IE0lwpeeEbI8CKEmFRhqMnpveLUcUeH/1H
         +uorYqgGfE7SLqELsWd9NrsEvHFvqFgzepKIqvixZYHeyajYTOZvVolIFE1vx7+w4VPD
         RTmem8t8y927UvCrxYhkpOkXTzB7YRGSV1hR/EMV/RAlACIGFHKk/+cxYvGUIvDOWYQb
         3arvcByByXKeAZggdElDgPNvLLnJwF4fXHmDysuIv5u5PizkhG9AS+GUzi0BFgwjOjU/
         YhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794059422; x=1794664222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0tSO75+dLoTbxUTsccW1GH3+P5H454b2/ssDfpBt7oM=;
        b=Qhnr904OQr2e5QDhO8NDYNXb9Z0F/biIoCHQFYPt/lfS+FhzIz1qQXnK2GnR3UyeJM
         o3CJ5On5XuEbcO7BcVNjY5XwE+auvhslnVg55AxH86CxhZcxxb/UYGRWd/ZMmTybNoXg
         9i42RM4JILMcyE3ZhtOCvtnkvrrF7I5xnKgpOMJQGfRNAZHO7RrkMpU2tNJ6pqiBGa1Y
         p3GWRzDw5HBosRxuPW+cG6udVK0CN2yRDwCNOAD7PUD/9L3uRP8vSqBPt8TdwAuacE6S
         t/FO1iYp3BGAFINoWdFdRvm2PqswzuAc/8LMcHuO3X9gcjV/aklF8bZBz2GeWnGFIKBE
         CE/A==
X-Forwarded-Encrypted: i=1; AL+hErFOTXCH+l5V7vl/J93utkmlDppikd01zzKxBG/Bzq4TYHGS+GIT1TL6pkaZLD1WGF/u5MPUI/plCQ3ps2E=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8nzjPUb3fSs0IOcCLk/RiIzFCGyvbDUvjH6eSLfJVFmWep6FD9
	NUR/m3o+4lioouE1ZwHGJcD5pTIvNVQQnYY2zX4xgDrK2tpBBBuol/Rb
X-Gm-Gg: AYBFou2if8YXerFirAGHpLPVN7mCY2We4x9SUFGGtJCMi8g67gAg8sQbzVg7ru922zP
	4t4ZIjBny0Oi+ozUWWhWWeJkFNMVkf0g4SSCRPG9er/sA81IYPV2osLYDydsQR975DQPlTewThR
	ABxkDGy4/oGVposkzGXDFWMO4BkjnVOvU0l85En5UwaXQYFLCZzfgyie/dDdjMH+wiNu7qqyw8D
	RqUJ4dqUGpmf/AyqFxl/hZnwaM1APlvktsi7vSgaIu1TbeurB2l3HQBZc0Paycr+w6vbq6MhcDE
	SJ+5fsudLPJSksl83LqaqhqJRbqwQ9lUvJCtO4ywdBcogWt/b3+BYwPNbjnbf5KZvolhLWJlniE
	EOco+4HkcPQ9lVCk3WZFQ8wBY/X4hKUWCkuNAkCxmMbq21BfRVMuUciRoHIlHTYWude4Sswicpc
	1nnyGX/uFCv9EXAKvtk+JQQ+wewhcGLYNu5V7FkR/sQkN5nxeCe/a8bFtsBbo/9dtslblKgEq0h
	qERqFePYdjzeDVbNzpQYCFo/yYNdlasIp/k6HDZ4GVY7zEkTy3tpSTSNCelgdFpt3KCkM6JEvF7
	/dRGUzCHGL+vYNuuJ0nAHLTOLEW5FQlGXgN6eCQT0bTCHVHmYQngvaLffQ==
X-Received: by 2002:a05:7300:c8c2:b0:36a:2289:c599 with SMTP id 5a478bee46e88-36f76522120mr8195640eec.29.1794059421478;
        Sat, 07 Nov 2026 05:50:21 -0800 (PST)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922c6c7sm21280820eec.10.2026.11.07.05.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:50:21 -0800 (PST)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
To: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	urezki@gmail.com,
	linux-mm@kvack.org
Cc: baohua@kernel.org,
	dev.jain@arm.com,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	david@kernel.org,
	rppt@kernel.org,
	leo.yan@arm.com,
	xueyuan.chen21@gmail.com,
	chleroy@kernel.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	ajd@linux.ibm.com,
	jiangwen6@xiaomi.com,
	jiangwenxiaomi@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 03/10] mm/vmalloc: use vmap_pte_set_huge()/vmap_pte_clear_huge() for PTE-level block mappings
Date: Sat,  7 Nov 2026 21:49:46 +0800
Message-Id: <20261107134953.748622-4-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
References: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wen Jiang <jiangwen6@xiaomi.com>

vmap installs PTE-level block mappings by reusing set_huge_pte_at() and
huge_ptep_get_and_clear() under #ifdef CONFIG_HUGETLB_PAGE. This makes
the feature silently unavailable on CONFIG_HUGETLB_PAGE=n kernels and
couples mm/vmalloc.c to HugeTLB internals it does not otherwise need.

Now that arm64 and powerpc/8xx provide vmap_pte_set_huge() and
vmap_pte_clear_huge(), add the generic fallbacks next to the existing
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
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/pgtable.h | 29 +++++++++++++++++++++++++++++
 mm/vmalloc.c            | 19 ++++++-------------
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 780fe849ff8b7..7e62479db5df7 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -2204,6 +2204,35 @@ static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 }
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
+/*
+ * PTE-level block mappings for vmap.
+ *
+ * vmap_pte_set_huge() only has to be implemented by architectures whose
+ * arch_vmap_pte_range_map_size() can return a size other than PAGE_SIZE.
+ */
+#ifndef __HAVE_ARCH_VMAP_PTE_SET_HUGE
+static inline void vmap_pte_set_huge(pte_t *ptep, unsigned long addr,
+				     phys_addr_t phys, pgprot_t prot,
+				     unsigned long size)
+{
+	BUILD_BUG();
+}
+#endif
+
+/*
+ * Likewise, vmap_pte_clear_huge() only has to be implemented by architectures
+ * whose arch_vmap_pte_range_unmap_size() can return a size other than
+ * PAGE_SIZE.
+ */
+#ifndef __HAVE_ARCH_VMAP_PTE_CLEAR_HUGE
+static inline pte_t vmap_pte_clear_huge(pte_t *ptep, unsigned long addr,
+					unsigned long size)
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
index f7aa4686fe5b9..df37c8490ae7e 100644
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
+			vmap_pte_set_huge(pte, addr, PFN_PHYS(pfn), prot, size);
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
+			ptent = vmap_pte_clear_huge(pte, addr, size);
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


