Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 672ED1A0549
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:44:21 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 10 Dec 2014 03:44:21 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 359922CE8058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:44:18 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB9HiIDs42926164
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:44:18 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB9HiHpZ030917
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:44:17 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH V2] powerpc: Fix compile errors with STRICT_MM_TYPECHECKS
 enabled
Date: Tue,  9 Dec 2014 23:14:03 +0530
Message-Id: <1418147043-15461-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from V1
   * Don't enable STRICT_MM_TYPECHECK for upstream

 arch/powerpc/include/asm/kvm_book3s_64.h | 12 +++++++-----
 arch/powerpc/include/asm/pgtable.h       |  4 ++--
 arch/powerpc/mm/fsl_booke_mmu.c          |  2 +-
 arch/powerpc/mm/pgtable_64.c             |  2 +-
 arch/powerpc/mm/tlb_hash64.c             |  2 +-
 5 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 0aa817933e6a..cd0ff37aea9f 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -291,11 +291,11 @@ static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing,
 	pte_t old_pte, new_pte = __pte(0);
 
 	while (1) {
-		old_pte = pte_val(*ptep);
+		old_pte = *ptep;
 		/*
 		 * wait until _PAGE_BUSY is clear then set it atomically
 		 */
-		if (unlikely(old_pte & _PAGE_BUSY)) {
+		if (unlikely(pte_val(old_pte) & _PAGE_BUSY)) {
 			cpu_relax();
 			continue;
 		}
@@ -306,16 +306,18 @@ static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing,
 			return __pte(0);
 #endif
 		/* If pte is not present return None */
-		if (unlikely(!(old_pte & _PAGE_PRESENT)))
+		if (unlikely(!(pte_val(old_pte) & _PAGE_PRESENT)))
 			return __pte(0);
 
 		new_pte = pte_mkyoung(old_pte);
 		if (writing && pte_write(old_pte))
 			new_pte = pte_mkdirty(new_pte);
 
-		if (old_pte == __cmpxchg_u64((unsigned long *)ptep, old_pte,
-					     new_pte))
+		if (pte_val(old_pte) == __cmpxchg_u64((unsigned long *)ptep,
+						      pte_val(old_pte),
+						      pte_val(new_pte))) {
 			break;
+		}
 	}
 	return new_pte;
 }
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 316f9a5da173..3e290888ed37 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -77,8 +77,8 @@ static inline void pmdp_set_numa(struct mm_struct *mm, unsigned long addr,
  * which was inherited from x86. For the purposes of powerpc pte_basic_t and
  * pmd_t are equivalent
  */
-#define pteval_t pte_basic_t
-#define pmdval_t pmd_t
+typedef unsigned long pteval_t;
+typedef unsigned long pmdval_t;
 static inline pteval_t ptenuma_flags(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_NUMA_MASK;
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 94cd728166d3..a7a1b9b45eeb 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -183,7 +183,7 @@ static unsigned long map_mem_in_cams_addr(phys_addr_t phys, unsigned long virt,
 		unsigned long cam_sz;
 
 		cam_sz = calc_cam_sz(ram, virt, phys);
-		settlbcam(i, virt, phys, cam_sz, PAGE_KERNEL_X, 0);
+		settlbcam(i, virt, phys, cam_sz, pgprot_val(PAGE_KERNEL_X), 0);
 
 		ram -= cam_sz;
 		amount_mapped += cam_sz;
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index c8d709ab489d..5162936c0c34 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -714,7 +714,7 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	assert_spin_locked(&mm->page_table_lock);
 	WARN_ON(!pmd_trans_huge(pmd));
 #endif
-	trace_hugepage_set_pmd(addr, pmd);
+	trace_hugepage_set_pmd(addr, pmd_val(pmd));
 	return set_pte_at(mm, addr, pmdp_ptep(pmdp), pmd_pte(pmd));
 }
 
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index d2a94b85dbc2..c522969f012d 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -216,7 +216,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 			continue;
 		pte = pte_val(*ptep);
 		if (hugepage_shift)
-			trace_hugepage_invalidate(start, pte_val(pte));
+			trace_hugepage_invalidate(start, pte);
 		if (!(pte & _PAGE_HASHPTE))
 			continue;
 		if (unlikely(hugepage_shift && pmd_trans_huge(*(pmd_t *)pte)))
-- 
2.1.0
