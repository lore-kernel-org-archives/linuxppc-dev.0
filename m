Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AC7606A330
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QSlV951Z
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJkz2633qz2xMQ;
	Tue, 03 Nov 2026 21:17:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793701054;
	cv=none; b=A877XnYhzbKiSwXyz8gkXDr5IAUTtuSv2ygUPD3TyIbwZ+u1zJetPqnjcyGQv3CbJd9DmVE1q2tD9Twopx+G056MiPUQaHD1ZL9grE0gKSoIrIbGnJ5PkNHMtPprUxciBzYxip2sOTYvecRln+Dr1zecmv3lQYpJvEqfdcUICGz1BJFQIppv9lHX7Sui913u7ed4qYbV+CU221q94n4I/1NqTuoamVWwC0b/hA5ezUZMWfQsQA4oVXBnCHmbDWb5DVqe0K31k2zSV+jpUbvaxJYpWMqFLBh3ccUDzENM7sDrhKfB0Ut9CCmfczLzs38NkjTGkosMKKH6B921P+hBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793701054; c=relaxed/relaxed;
	bh=vHjbXN5GPOj+3N/hZYmdpYePqr3N047W/AZ1HDpQr5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KFKbg//axxJpXsqm0iQRp+I4/qdw2QU9xfir5yrL1JEYx7OXRH3XlhjLRhjf6pjNfbLO5heC9u46q1hrPPMTL7aQl7Xh1Q3kr0rKNuqY9tZWy7y3Nm7nhSqRlfVIK6zMwMgnA+VgSEjwuZg8kN4bUjRWB1X2N4dOKGFGamievb3tR94b/Z2ux3FnWWoAdL1/KQvFA2Ir15c1mO0meJbcjqLj2oj5F94yzV/VQ4y2x3hzSJb2fU5lAltQbP9qwYVhvWcrZUC5gKAy4n5UaDoMUe98VKV8aLSWQtDWByYqN+hu2ZPHXaPQd5evtYWgFQF20eBhDL812KMZMuDlEaPMUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QSlV951Z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QSlV951Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJkz20YW1z2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 21:17:33 +1100 (AEDT)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-3550c917fd3so5454299eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793701052; x=1794305852; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vHjbXN5GPOj+3N/hZYmdpYePqr3N047W/AZ1HDpQr5U=;
        b=QSlV951ZeefNH5ZkZEKjaYvL03OPkWnJ106UAGB8XnKbNbzJ07N6WTQSZCZwba6ojT
         tTzSsjvvJ23FqfdLqBm4mqvuQld8v+Ldso/IIlWaltIerBG/vTUNppG4lu+9tF1m2vfG
         GVrcSJzrj7dCCCFSMbIbV959rEgn0jg26AWUvLYNIkuisSg7HabkUKKWMclZ70ESW8B0
         yjLk0BvIQP4h2fCudJTbSfUPSPjvPM7jfwUdgdtdRBwqo2sqv3KsuwO6Q8+qbicDCrHW
         In6mt3/aBey8FdXwoVAeL6EKk5dGv384a1Q31Y4AllJK0Pl6BwW/7sOtXfghxFrZFC09
         DkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701052; x=1794305852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vHjbXN5GPOj+3N/hZYmdpYePqr3N047W/AZ1HDpQr5U=;
        b=VmN3HA4okBvjCBtXVcApPioc8EeANMLxTFvituZGxb7ud7bUNFezKCJDqUsz1pq7hV
         fLJaX+8sVmQplq4803KyOBZ6Ev+t/6rjjcat7b6EeGVf0oKtBgjUbTkdqqjI1Mrk9aZf
         EFRLiKKp2IM/HIfkVxsTN0u9y39WRrCAKvx4bo8gkB9CC+AjklfROl/jYRk6p2baafGM
         Mc9Walq+nXx1ktwmt6MmDxGy28QVDp+/oSxR4gAEZ9Q1sb0Q0R8yP6uT4bthzEre/JK4
         W5Ppe7sFHVVb8gdYa4tiBMrvYh1AksLL1GZcxbQseoTtyH8EYjhewYixWEK5OLtk1WQV
         XlRw==
X-Forwarded-Encrypted: i=1; AKwUvBx8KIS7JfwMgUxBB2yikW08/8Uk/sMaj1ScDxmABmfoLsht72dtrfJWD9jv5rL/a6o3SXT6JpOGo/Ioimw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/XPxthfn8VNaboiXol28qZhiY0TMv8cT2mREHZudtLx5rIELpb
	emwfz9RxbhM+U/iGW+JXgYjCrgVEctdesSJATnK6S2JHYeAwT24I0FSA
X-Gm-Gg: AYBFou0gU1cphR0lAcaSq2uIYnnZtnd7ALEi9LvcKLLhxEriJOYq5OBATyzSJMnfI0u
	5cp+JjDaIThz4FuHIFc5K1se39T6dpgSkyK7qSXq6UQ3OWeUT6gFbuD4u6tvC+/1QTkzthYtS5E
	uVgA4Ucwn7WSkaMHfi8PI9Nn073iEZw3vPwSC5EUoCyVw8rWpcwAqqVxZUXu0YtbvI3gMeo/191
	AnyJUQ2d5OBPdxD+bFup5UxSO7OfqA89KV2bFiP1RDvprDZqqKg151ATlNmQ7ge+aVFyE3wcK0b
	mHXCESVm8kEZZ1RjFvK1PTFkyYCfTaiE2xw/M2Pfd43EHHNqJPJEMmKRBaS+X+Ybz7MrzZObZdc
	bDSiXX5WpAFKcgaF9TK1wzS28irZWtS+9VKOwQ5e6XBHkEubhBF286qy0X5bd/WHoZd3a28cnjU
	wKopItjW/lWhBTRIS9iFkS9RqtKlwOiWLgXPUi3jYRChYS2VNXw/tu9q2StRWrdjPMq65RF+hCo
	/5seCSGAwAvG3h3irhYSKP89/450hfYFt2DH3DAUQwhozA98Yhl85AzeJ0LdbbOqRRtpONBDQNf
	SytsGIH0ZvCJE/Afubq9LnzhIgx8FB6nPyunZ53kcWWVmzxAe0E=
X-Received: by 2002:a05:7300:5b89:b0:36a:1732:1e7 with SMTP id 5a478bee46e88-36a424c7b7dmr29521974eec.31.1793701051925;
        Tue, 03 Nov 2026 02:17:31 -0800 (PST)
Received: from 027.. ([2409:8a20:4a5:7150:84fc:ce3c:7b09:dbca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm53145387eec.15.2026.11.03.02.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:17:31 -0800 (PST)
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
Subject: [PATCH v11 03/10] mm/vmalloc: use vmap_pte_set_huge()/vmap_pte_clear_huge() for PTE-level block mappings
Date: Tue,  3 Nov 2026 18:16:51 +0800
Message-Id: <20261103101658.766905-4-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103101658.766905-1-jiangwenxiaomi@gmail.com>
References: <20261103101658.766905-1-jiangwenxiaomi@gmail.com>
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
index 780fe849ff8b..78689941b637 100644
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
+				phys_addr_t phys, pgprot_t prot,
+				unsigned long size)
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
index f7aa4686fe5b..df37c8490ae7 100644
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


