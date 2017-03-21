Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnfw75nG6zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 04:30:15 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2LHTEAq015805
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 13:30:13 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29b532bvf1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 13:30:13 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 13:30:11 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3 01/10] powerpc/mm/nohash: MM_SLICE is only used by book3s 64
Date: Tue, 21 Mar 2017 22:59:51 +0530
Message-Id: <1490117400-9891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

BOOKE code is dead code as per the Kconfig details. So make it simpler
by enabling MM_SLICE only for book3s_64. The changes w.r.t nohash is just
removing deadcode. W.r.t ppc64, 4k without hugetlb will now enable MM_SLICE.
But that is good, because we reduce one extra variant which probably is not
getting tested much.

Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-book3e.h        | 5 -----
 arch/powerpc/include/asm/nohash/64/pgtable.h | 5 -----
 arch/powerpc/mm/hugetlbpage-book3e.c         | 7 -------
 arch/powerpc/mm/mmu_context_nohash.c         | 5 -----
 arch/powerpc/platforms/Kconfig.cputype       | 2 +-
 5 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index b62a8d43a06c..7ca8d8e80ffa 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -229,11 +229,6 @@ typedef struct {
 	unsigned int	id;
 	unsigned int	active;
 	unsigned long	vdso_base;
-#ifdef CONFIG_PPC_MM_SLICES
-	u64 low_slices_psize;   /* SLB page size encodings */
-	u64 high_slices_psize;  /* 4 bits per slice for now */
-	u16 user_psize;         /* page size index */
-#endif
 #ifdef CONFIG_PPC_64K_PAGES
 	/* for 4K PTE fragment support */
 	void *pte_frag;
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index c7f927e67d14..f0ff384d4ca5 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -88,11 +88,6 @@
 #include <asm/nohash/pte-book3e.h>
 #include <asm/pte-common.h>
 
-#ifdef CONFIG_PPC_MM_SLICES
-#define HAVE_ARCH_UNMAPPED_AREA
-#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
-#endif /* CONFIG_PPC_MM_SLICES */
-
 #ifndef __ASSEMBLY__
 /* pte_clear moved to later in this file */
 
diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c b/arch/powerpc/mm/hugetlbpage-book3e.c
index 83a8be791e06..bfe4e8526b2d 100644
--- a/arch/powerpc/mm/hugetlbpage-book3e.c
+++ b/arch/powerpc/mm/hugetlbpage-book3e.c
@@ -148,16 +148,9 @@ void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
 
 	mm = vma->vm_mm;
 
-#ifdef CONFIG_PPC_MM_SLICES
-	psize = get_slice_psize(mm, ea);
-	tsize = mmu_get_tsize(psize);
-	shift = mmu_psize_defs[psize].shift;
-#else
 	psize = vma_mmu_pagesize(vma);
 	shift = __ilog2(psize);
 	tsize = shift - 10;
-#endif
-
 	/*
 	 * We can't be interrupted while we're setting up the MAS
 	 * regusters or after we've confirmed that no tlb exists.
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index c491f2c8f2b9..4554d6527682 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -333,11 +333,6 @@ int init_new_context(struct task_struct *t, struct mm_struct *mm)
 
 	mm->context.id = MMU_NO_CONTEXT;
 	mm->context.active = 0;
-
-#ifdef CONFIG_PPC_MM_SLICES
-	slice_set_user_psize(mm, mmu_virtual_psize);
-#endif
-
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 99b0ae8acb78..a7c0c1fafe68 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -359,7 +359,7 @@ config PPC_BOOK3E_MMU
 
 config PPC_MM_SLICES
 	bool
-	default y if (!PPC_FSL_BOOK3E && PPC64 && HUGETLB_PAGE) || (PPC_STD_MMU_64 && PPC_64K_PAGES)
+	default y if PPC_STD_MMU_64
 	default n
 
 config PPC_HAVE_PMU_SUPPORT
-- 
2.7.4
