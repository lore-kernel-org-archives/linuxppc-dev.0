Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF8991A018F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 16:48:25 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 5 Aug 2014 12:18:21 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5CB5E125801B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 12:18:21 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s756oPns64487604
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Aug 2014 12:20:25 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s756mHdE032449
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Aug 2014 12:18:18 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH] powerpc: thp: Use tlbiel wherever possible
Date: Tue,  5 Aug 2014 12:18:09 +0530
Message-Id: <1407221289-19390-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we know that user address space has never executed on other cpus
we could use tlbiel.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h    |  2 +-
 arch/powerpc/mm/hash_native_64.c      |  4 ++--
 arch/powerpc/mm/hugepage-hash64.c     | 10 ++++++----
 arch/powerpc/mm/pgtable_64.c          | 11 ++++++++---
 arch/powerpc/platforms/pseries/lpar.c |  2 +-
 5 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 8dcb721d03d8..fe7a11ae9d9c 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -60,7 +60,7 @@ struct machdep_calls {
 	void		(*hugepage_invalidate)(unsigned long vsid,
 					       unsigned long addr,
 					       unsigned char *hpte_slot_array,
-					       int psize, int ssize);
+					       int psize, int ssize, int local);
 	/* special for kexec, to be called in real mode, linear mapping is
 	 * destroyed as well */
 	void		(*hpte_clear_all)(void);
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index afc0a8295f84..88de8a869c98 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -415,7 +415,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 static void native_hugepage_invalidate(unsigned long vsid,
 				       unsigned long addr,
 				       unsigned char *hpte_slot_array,
-				       int psize, int ssize)
+				       int psize, int ssize, int local)
 {
 	int i;
 	struct hash_pte *hptep;
@@ -461,7 +461,7 @@ static void native_hugepage_invalidate(unsigned long vsid,
 		 * instruction compares entry_VA in tlb with the VA specified
 		 * here
 		 */
-		tlbie(vpn, psize, actual_psize, ssize, 0);
+		tlbie(vpn, psize, actual_psize, ssize, local);
 	}
 	local_irq_restore(flags);
 }
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 5f5e6328c21c..3e87005cfb79 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -19,7 +19,8 @@
 #include <asm/machdep.h>
 
 static void invalidate_old_hpte(unsigned long vsid, unsigned long addr,
-				pmd_t *pmdp, unsigned int psize, int ssize)
+				pmd_t *pmdp, unsigned int psize,
+				int ssize, int local)
 {
 	int i, max_hpte_count, valid;
 	unsigned long s_addr;
@@ -38,7 +39,7 @@ static void invalidate_old_hpte(unsigned long vsid, unsigned long addr,
 
 	if (ppc_md.hugepage_invalidate)
 		return ppc_md.hugepage_invalidate(vsid, s_addr, hpte_slot_array,
-						  psize, ssize);
+						  psize, ssize, local);
 	/*
 	 * No bluk hpte removal support, invalidate each entry
 	 */
@@ -64,7 +65,7 @@ static void invalidate_old_hpte(unsigned long vsid, unsigned long addr,
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += hidx & _PTEIDX_GROUP_IX;
 		ppc_md.hpte_invalidate(slot, vpn, psize,
-				       MMU_PAGE_16M, ssize, 0);
+				       MMU_PAGE_16M, ssize, local);
 	}
 }
 
@@ -145,7 +146,8 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * hash page table entries.
 		 */
 		if ((old_pmd & _PAGE_HASHPTE) && !(old_pmd & _PAGE_COMBO))
-			invalidate_old_hpte(vsid, ea, pmdp, MMU_PAGE_64K, ssize);
+			invalidate_old_hpte(vsid, ea, pmdp, MMU_PAGE_64K,
+					    ssize, local);
 	}
 
 	valid = hpte_valid(hpte_slot_array, index);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index ecc4079ca56c..b1ea87b34f79 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -731,10 +731,11 @@ void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 			    pmd_t *pmdp, unsigned long old_pmd)
 {
-	int ssize, i;
+	int ssize, i, local = 0;
 	unsigned long s_addr;
 	int max_hpte_count;
 	unsigned int psize, valid;
+	const struct cpumask *tmp;
 	unsigned char *hpte_slot_array;
 	unsigned long hidx, vpn, vsid, hash, shift, slot;
 
@@ -770,10 +771,14 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 		ssize = mmu_kernel_ssize;
 	}
 
+	tmp = cpumask_of(smp_processor_id());
+	if (cpumask_equal(mm_cpumask(mm), tmp))
+		local = 1;
+
 	if (ppc_md.hugepage_invalidate)
 		return ppc_md.hugepage_invalidate(vsid, s_addr,
 						  hpte_slot_array,
-						  psize, ssize);
+						  psize, ssize, local);
 	/*
 	 * No bluk hpte removal support, invalidate each entry
 	 */
@@ -799,7 +804,7 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += hidx & _PTEIDX_GROUP_IX;
 		ppc_md.hpte_invalidate(slot, vpn, psize,
-				       MMU_PAGE_16M, ssize, 0);
+				       MMU_PAGE_16M, ssize, local);
 	}
 }
 
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index ccf6f162f69c..c543c20ffabb 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -433,7 +433,7 @@ static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
 static void pSeries_lpar_hugepage_invalidate(unsigned long vsid,
 					     unsigned long addr,
 					     unsigned char *hpte_slot_array,
-					     int psize, int ssize)
+					     int psize, int ssize, int local)
 {
 	int i, index = 0;
 	unsigned long s_addr = addr;
-- 
1.9.1
