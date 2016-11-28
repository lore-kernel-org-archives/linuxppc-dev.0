Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tRxKy3QLszDvg0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 17:17:26 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAS6DbLV023132
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 01:17:24 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2702n98cnu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 01:17:24 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Nov 2016 23:17:22 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v7 3/7] powerpc/mm: Introduce _PAGE_LARGE software pte bits
Date: Mon, 28 Nov 2016 11:47:00 +0530
In-Reply-To: <20161128061704.4914-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161128061704.4914-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20161128061704.4914-4-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a new software defined pte bit. We use the reserved
fields of ISA 3.0 pte definition since we will only be using this
on DD1 code paths. We can possibly look at removing this code later.

The software bit will be used to differentiate between 64K/4K and 2M ptes.
This helps in finding the page size mapping by a pte so that we can do efficient
tlb flush.

We don't support 1G hugetlb pages yet. So we add a DEBUG WARN_ON to catch
wrong usage.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hugetlb.h | 20 ++++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h |  9 +++++++++
 arch/powerpc/include/asm/book3s/64/radix.h   |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index d9c283f95e05..c62f14d0bec1 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -30,4 +30,24 @@ static inline int hstate_get_psize(struct hstate *hstate)
 		return mmu_virtual_psize;
 	}
 }
+
+#define arch_make_huge_pte arch_make_huge_pte
+static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
+				       struct page *page, int writable)
+{
+	unsigned long page_shift;
+
+	if (!cpu_has_feature(CPU_FTR_POWER9_DD1))
+		return entry;
+
+	page_shift = huge_page_shift(hstate_vma(vma));
+	/*
+	 * We don't support 1G hugetlb pages yet.
+	 */
+	VM_WARN_ON(page_shift == mmu_psize_defs[MMU_PAGE_1G].shift);
+	if (page_shift == mmu_psize_defs[MMU_PAGE_2M].shift)
+		return __pte(pte_val(entry) | _PAGE_LARGE);
+	else
+		return entry;
+}
 #endif
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 86870c11917b..6f39b9d134a2 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -26,6 +26,11 @@
 #define _RPAGE_SW1		0x00800
 #define _RPAGE_SW2		0x00400
 #define _RPAGE_SW3		0x00200
+#define _RPAGE_RSV1		0x1000000000000000UL
+#define _RPAGE_RSV2		0x0800000000000000UL
+#define _RPAGE_RSV3		0x0400000000000000UL
+#define _RPAGE_RSV4		0x0200000000000000UL
+
 #ifdef CONFIG_MEM_SOFT_DIRTY
 #define _PAGE_SOFT_DIRTY	_RPAGE_SW3 /* software: software dirty tracking */
 #else
@@ -34,6 +39,10 @@
 #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
 #define _PAGE_DEVMAP		_RPAGE_SW1
 #define __HAVE_ARCH_PTE_DEVMAP
+/*
+ * For DD1 only, we need to track whether the pte huge
+ */
+#define _PAGE_LARGE	_RPAGE_RSV1
 
 
 #define _PAGE_PTE		(1ul << 62)	/* distinguishes PTEs from pointers */
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 2a46dea8e1b1..d2c5c064e266 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -243,6 +243,8 @@ static inline int radix__pmd_trans_huge(pmd_t pmd)
 
 static inline pmd_t radix__pmd_mkhuge(pmd_t pmd)
 {
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+		return __pmd(pmd_val(pmd) | _PAGE_PTE | _PAGE_LARGE);
 	return __pmd(pmd_val(pmd) | _PAGE_PTE);
 }
 static inline void radix__pmdp_huge_split_prepare(struct vm_area_struct *vma,
-- 
2.10.2
