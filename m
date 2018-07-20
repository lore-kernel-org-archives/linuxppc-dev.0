Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41X4pD6qRbzDqGS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 19:09:40 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6K949bN106339
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 05:09:38 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kb8h0jhcp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 05:09:38 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 20 Jul 2018 05:09:37 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH 4/4] powerpc/mm:book3s: Enable THP migration support
Date: Fri, 20 Jul 2018 14:39:14 +0530
In-Reply-To: <20180720090914.17471-1-aneesh.kumar@linux.ibm.com>
References: <20180720090914.17471-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180720090914.17471-4-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 5 +++++
 arch/powerpc/platforms/Kconfig.cputype       | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index fce9ce8781a0..f619f3215c05 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -734,6 +734,8 @@ static inline bool pte_user(pte_t pte)
  */
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val((pte)) & ~_PAGE_PTE })
 #define __swp_entry_to_pte(x)	__pte((x).val | _PAGE_PTE)
+#define __pmd_to_swp_entry(pmd)	(__pte_to_swp_entry(pmd_pte(pmd)))
+#define __swp_entry_to_pmd(x)	(pte_pmd(__swp_entry_to_pte(x)))
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
 #define _PAGE_SWP_SOFT_DIRTY   (1UL << (SWP_TYPE_BITS + _PAGE_BIT_SWAP_TYPE))
@@ -1079,6 +1081,9 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
 #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
 #define pmd_mk_savedwrite(pmd)	pte_pmd(pte_mk_savedwrite(pmd_pte(pmd)))
 #define pmd_clear_savedwrite(pmd)	pte_pmd(pte_clear_savedwrite(pmd_pte(pmd)))
+#define pmd_swp_mksoft_dirty(pmd)	pte_pmd(pte_swp_mksoft_dirty(pmd_pte(pmd)))
+#define pmd_swp_soft_dirty(pmd)		pte_swp_soft_dirty(pmd_pte(pmd))
+#define pmd_swp_clear_soft_dirty(pmd)	pte_pmd(pte_swp_clear_soft_dirty(pmd_pte(pmd)))
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 #define pmd_soft_dirty(pmd)    pte_soft_dirty(pmd_pte(pmd))
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index e6a1de521319..2e8ee6a33587 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -72,6 +72,7 @@ config PPC_BOOK3S_64
 	select PPC_HAVE_PMU_SUPPORT
 	select SYS_SUPPORTS_HUGETLBFS
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
+	select ARCH_ENABLE_THP_MIGRATION
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select IRQ_WORK
 	select HAVE_KERNEL_XZ
-- 
2.17.1
