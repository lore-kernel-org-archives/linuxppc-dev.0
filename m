Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9B2C1A18E1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:45:45 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 3 Nov 2014 01:45:45 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3DE6D2CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:45:43 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sA2FjfNb25231404
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:45:41 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sA2FjgN0023240
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:45:42 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH V3 2/2] powerpc/mm/thp: Use tlbiel if possible
Date: Sun,  2 Nov 2014 21:15:28 +0530
Message-Id: <1414943128-29889-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1414943128-29889-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1414943128-29889-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/tlbflush.h   |  3 ++-
 arch/powerpc/mm/hash_native_64.c      |  4 ++--
 arch/powerpc/mm/hash_utils_64.c       | 28 +++++++++++++++++++++++-----
 arch/powerpc/mm/hugepage-hash64.c     |  2 +-
 arch/powerpc/mm/pgtable_64.c          |  9 +++++++--
 arch/powerpc/platforms/pseries/lpar.c |  2 +-
 7 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 307347f8ddbd..ccc9f9bd1605 100644
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
diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index afe57427ef8e..6a5c1774b32c 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -128,7 +128,8 @@ extern void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize,
 			    int ssize, int local);
 extern void flush_hash_range(unsigned long number, int local);
 extern void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
-				pmd_t *pmdp, unsigned int psize, int ssize);
+				pmd_t *pmdp, unsigned int psize, int ssize,
+				int local);
 
 static inline void local_flush_tlb_mm(struct mm_struct *mm)
 {
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index ae4962a06476..459840d9b7d3 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -419,7 +419,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 static void native_hugepage_invalidate(unsigned long vsid,
 				       unsigned long addr,
 				       unsigned char *hpte_slot_array,
-				       int psize, int ssize)
+				       int psize, int ssize, int local)
 {
 	int i;
 	struct hash_pte *hptep;
@@ -465,7 +465,7 @@ static void native_hugepage_invalidate(unsigned long vsid,
 		 * instruction compares entry_VA in tlb with the VA specified
 		 * here
 		 */
-		tlbie(vpn, psize, actual_psize, ssize, 0);
+		tlbie(vpn, psize, actual_psize, ssize, local);
 	}
 	local_irq_restore(flags);
 }
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 26517ea34970..7a6fa267d1f4 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1317,7 +1317,7 @@ void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
-			 pmd_t *pmdp, unsigned int psize, int ssize)
+			 pmd_t *pmdp, unsigned int psize, int ssize, int local)
 {
 	int i, max_hpte_count, valid;
 	unsigned long s_addr;
@@ -1334,9 +1334,11 @@ void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
 	if (!hpte_slot_array)
 		return;
 
-	if (ppc_md.hugepage_invalidate)
-		return ppc_md.hugepage_invalidate(vsid, s_addr, hpte_slot_array,
-						  psize, ssize);
+	if (ppc_md.hugepage_invalidate) {
+		ppc_md.hugepage_invalidate(vsid, s_addr, hpte_slot_array,
+					   psize, ssize, local);
+		goto tm_abort;
+	}
 	/*
 	 * No bluk hpte removal support, invalidate each entry
 	 */
@@ -1362,8 +1364,24 @@ void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += hidx & _PTEIDX_GROUP_IX;
 		ppc_md.hpte_invalidate(slot, vpn, psize,
-				       MMU_PAGE_16M, ssize, 0);
+				       MMU_PAGE_16M, ssize, local);
+	}
+tm_abort:
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	/* Transactions are not aborted by tlbiel, only tlbie.
+	 * Without, syncing a page back to a block device w/ PIO could pick up
+	 * transactional data (bad!) so we force an abort here.  Before the
+	 * sync the page will be made read-only, which will flush_hash_page.
+	 * BIG ISSUE here: if the kernel uses a page from userspace without
+	 * unmapping it first, it may see the speculated version.
+	 */
+	if (local && cpu_has_feature(CPU_FTR_TM) &&
+	    current->thread.regs &&
+	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
+		tm_enable();
+		tm_abort(TM_CAUSE_TLBI);
 	}
+#endif
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 1b3ad46a71b5..3a648cd363ae 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -95,7 +95,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		 */
 		if ((old_pmd & _PAGE_HASHPTE) && !(old_pmd & _PAGE_COMBO))
 			flush_hash_hugepage(vsid, ea, pmdp, MMU_PAGE_64K,
-					    ssize);
+					    ssize, local);
 	}
 
 	valid = hpte_valid(hpte_slot_array, index);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 62e8010a0c49..f54b0908c55e 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -731,9 +731,10 @@ void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 			    pmd_t *pmdp, unsigned long old_pmd)
 {
-	int ssize;
+	int ssize, local = 0;
 	unsigned int psize;
 	unsigned long vsid;
+	const struct cpumask *tmp;
 
 	/* get the base page size,vsid and segment size */
 #ifdef CONFIG_DEBUG_VM
@@ -754,7 +755,11 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 		ssize = mmu_kernel_ssize;
 	}
 
-	return flush_hash_hugepage(vsid, addr, pmdp, psize, ssize);
+	tmp = cpumask_of(smp_processor_id());
+	if (cpumask_equal(mm_cpumask(mm), tmp))
+		local = 1;
+
+	return flush_hash_hugepage(vsid, addr, pmdp, psize, ssize, local);
 }
 
 static pmd_t pmd_set_protbits(pmd_t pmd, pgprot_t pgprot)
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 8c509d5397c6..0bb4a6461823 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -432,7 +432,7 @@ static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
 static void pSeries_lpar_hugepage_invalidate(unsigned long vsid,
 					     unsigned long addr,
 					     unsigned char *hpte_slot_array,
-					     int psize, int ssize)
+					     int psize, int ssize, int local)
 {
 	int i, index = 0;
 	unsigned long s_addr = addr;
-- 
2.1.0
