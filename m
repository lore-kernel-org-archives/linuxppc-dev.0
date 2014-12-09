Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 52E831A0C78
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:38:46 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 9 Dec 2014 23:08:43 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 9B5DCE003F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 23:09:14 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB9HdGJv4194686
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 23:09:17 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB9HccEM027044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 23:08:39 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH] powerpc: Fix compile errors with STRICT_MM_TYPECHECKS enabled
Date: Tue,  9 Dec 2014 23:08:36 +0530
Message-Id: <1418146716-13806-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/kvm_book3s_64.h | 12 +++++++-----
 arch/powerpc/include/asm/page.h          |  2 +-
 arch/powerpc/include/asm/pgtable.h       |  4 ++--
 arch/powerpc/mm/fsl_booke_mmu.c          |  2 +-
 arch/powerpc/mm/pgtable_64.c             |  2 +-
 arch/powerpc/mm/tlb_hash64.c             |  2 +-
 6 files changed, 13 insertions(+), 11 deletions(-)

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
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 26fe1ae15212..cc62ab9644b6 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -278,7 +278,7 @@ extern long long virt_phys_offset;
 
 #ifndef __ASSEMBLY__
 
-#undef STRICT_MM_TYPECHECKS
+#define STRICT_MM_TYPECHECKS 1
 
 #ifdef STRICT_MM_TYPECHECKS
 /* These are used to make use of C type-checking. */
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
