Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18FF91A0171
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 20:12:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/6] powerpc: Fix compile errors with STRICT_MM_TYPECHECKS
 enabled
Date: Wed, 25 Mar 2015 20:11:57 +1100
Message-Id: <1427274719-25890-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1427274719-25890-1-git-send-email-mpe@ellerman.id.au>
References: <1427274719-25890-1-git-send-email-mpe@ellerman.id.au>
Cc: aneesh.kumar@in.ibm.com, linux-kernel@vger.kernel.org,
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
[mpe: Fix the 32-bit code also]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/kvm_book3s_64.h | 12 +++++++-----
 arch/powerpc/mm/dma-noncoherent.c        |  2 +-
 arch/powerpc/mm/fsl_booke_mmu.c          |  2 +-
 arch/powerpc/mm/hugepage-hash64.c        |  2 +-
 arch/powerpc/mm/hugetlbpage.c            |  4 ++--
 arch/powerpc/mm/pgtable_32.c             |  4 ++--
 arch/powerpc/mm/pgtable_64.c             |  2 +-
 arch/powerpc/mm/tlb_hash64.c             |  2 +-
 8 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 2d81e202bdcc..cc073a7ac2b7 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -290,11 +290,11 @@ static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing,
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
@@ -305,16 +305,18 @@ static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing,
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
diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index d85e86aac7fb..169aba446a74 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -228,7 +228,7 @@ __dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t
 		do {
 			SetPageReserved(page);
 			map_page(vaddr, page_to_phys(page),
-				 pgprot_noncached(PAGE_KERNEL));
+				 pgprot_val(pgprot_noncached(PAGE_KERNEL)));
 			page++;
 			vaddr += PAGE_SIZE;
 		} while (size -= PAGE_SIZE);
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index b46912fee7cd..9c90e66cffb6 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -181,7 +181,7 @@ static unsigned long map_mem_in_cams_addr(phys_addr_t phys, unsigned long virt,
 		unsigned long cam_sz;
 
 		cam_sz = calc_cam_sz(ram, virt, phys);
-		settlbcam(i, virt, phys, cam_sz, PAGE_KERNEL_X, 0);
+		settlbcam(i, virt, phys, cam_sz, pgprot_val(PAGE_KERNEL_X), 0);
 
 		ram -= cam_sz;
 		amount_mapped += cam_sz;
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 86686514ae13..43dafb9d6a46 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -33,7 +33,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 	 * atomically mark the linux large page PMD busy and dirty
 	 */
 	do {
-		pmd_t pmd = ACCESS_ONCE(*pmdp);
+		pmd_t pmd = READ_ONCE(*pmdp);
 
 		old_pmd = pmd_val(pmd);
 		/* If PMD busy, retry the access */
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 7e408bfc7948..fa9d5c238d22 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -964,7 +964,7 @@ pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea, unsigned *shift
 		*shift = 0;
 
 	pgdp = pgdir + pgd_index(ea);
-	pgd  = ACCESS_ONCE(*pgdp);
+	pgd  = READ_ONCE(*pgdp);
 	/*
 	 * Always operate on the local stack value. This make sure the
 	 * value don't get updated by a parallel THP split/collapse,
@@ -1045,7 +1045,7 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	if (pte_end < end)
 		end = pte_end;
 
-	pte = ACCESS_ONCE(*ptep);
+	pte = READ_ONCE(*ptep);
 	mask = _PAGE_PRESENT | _PAGE_USER;
 	if (write)
 		mask |= _PAGE_RW;
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 72555ab145cd..ecc503cb78ed 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -189,7 +189,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 
 	/* Make sure we have the base flags */
 	if ((flags & _PAGE_PRESENT) == 0)
-		flags |= PAGE_KERNEL;
+		flags |= pgprot_val(PAGE_KERNEL);
 
 	/* Non-cacheable page cannot be coherent */
 	if (flags & _PAGE_NO_CACHE)
@@ -324,7 +324,7 @@ void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 	p = memstart_addr + s;
 	for (; s < top; s += PAGE_SIZE) {
 		ktext = ((char *) v >= _stext && (char *) v < etext);
-		f = ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL;
+		f = ktext ? pgprot_val(PAGE_KERNEL_TEXT) : pgprot_val(PAGE_KERNEL);
 		map_page(v, p, f);
 #ifdef CONFIG_PPC_STD_MMU_32
 		if (ktext)
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 6957cc1ca0a7..3ac3a0a1edfb 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -723,7 +723,7 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
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
