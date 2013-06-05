Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 191282C007A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 01:28:53 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 5 Jun 2013 20:54:14 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B2ABC1258051
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 21:00:54 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r55FSesE9568594
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 20:58:41 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r55FSjVK006831
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Jun 2013 01:28:45 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V10 03/15] powerpc/THP: Implement transparent hugepages for
 ppc64
Date: Wed,  5 Jun 2013 20:58:27 +0530
Message-Id: <1370446119-8837-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We now have pmd entries covering 16MB range and the PMD table double its original size.
We use the second half of the PMD table to deposit the pgtable (PTE page).
The depoisted PTE page is further used to track the HPTE information. The information
include [ secondary group | 3 bit hidx | valid ]. We use one byte per each HPTE entry.
With 16MB hugepage and 64K HPTE we need 256 entries and with 4K HPTE we need
4096 entries. Both will fit in a 4K PTE page. On hugepage invalidate we need to walk
the PTE page and invalidate all valid HPTEs.

This patch implements necessary arch specific functions for THP support and also
hugepage invalidate logic. These PMD related functions are intentionally kept
similar to their PTE counter-part.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h | 200 ++++++++++++++++-
 arch/powerpc/include/asm/pgtable.h       |   4 +
 arch/powerpc/include/asm/tlbflush.h      |   3 +-
 arch/powerpc/mm/pgtable_64.c             | 365 +++++++++++++++++++++++++++++++
 arch/powerpc/mm/tlb_hash64.c             |  27 +++
 arch/powerpc/platforms/Kconfig.cputype   |   1 +
 6 files changed, 598 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index ab84332..d8642fb 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -154,7 +154,7 @@
 #define	pmd_present(pmd)	(pmd_val(pmd) != 0)
 #define	pmd_clear(pmdp)		(pmd_val(*(pmdp)) = 0)
 #define pmd_page_vaddr(pmd)	(pmd_val(pmd) & ~PMD_MASKED_BITS)
-#define pmd_page(pmd)		virt_to_page(pmd_page_vaddr(pmd))
+extern struct page *pmd_page(pmd_t pmd);
 
 #define pud_set(pudp, pudval)	(pud_val(*(pudp)) = (pudval))
 #define pud_none(pud)		(!pud_val(pud))
@@ -382,4 +382,202 @@ static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 
 #endif /* __ASSEMBLY__ */
 
+/*
+ * THP pages can't be special. So use the _PAGE_SPECIAL
+ */
+#define _PAGE_SPLITTING _PAGE_SPECIAL
+
+/*
+ * We need to differentiate between explicit huge page and THP huge
+ * page, since THP huge page also need to track real subpage details
+ */
+#define _PAGE_THP_HUGE  _PAGE_4K_PFN
+
+/*
+ * set of bits not changed in pmd_modify.
+ */
+#define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS |		\
+			 _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPLITTING | \
+			 _PAGE_THP_HUGE)
+
+#ifndef __ASSEMBLY__
+/*
+ * The linux hugepage PMD now include the pmd entries followed by the address
+ * to the stashed pgtable_t. The stashed pgtable_t contains the hpte bits.
+ * [ 1 bit secondary | 3 bit hidx | 1 bit valid | 000]. We use one byte per
+ * each HPTE entry. With 16MB hugepage and 64K HPTE we need 256 entries and
+ * with 4K HPTE we need 4096 entries. Both will fit in a 4K pgtable_t.
+ *
+ * The last three bits are intentionally left to zero. This memory location
+ * are also used as normal page PTE pointers. So if we have any pointers
+ * left around while we collapse a hugepage, we need to make sure
+ * _PAGE_PRESENT and _PAGE_FILE bits of that are zero when we look at them
+ */
+static inline unsigned int hpte_valid(unsigned char *hpte_slot_array, int index)
+{
+	return (hpte_slot_array[index] >> 3) & 0x1;
+}
+
+static inline unsigned int hpte_hash_index(unsigned char *hpte_slot_array,
+					   int index)
+{
+	return hpte_slot_array[index] >> 4;
+}
+
+static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
+					unsigned int index, unsigned int hidx)
+{
+	hpte_slot_array[index] = hidx << 4 | 0x1 << 3;
+}
+
+extern void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
+				   pmd_t *pmdp);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+extern pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot);
+extern pmd_t mk_pmd(struct page *page, pgprot_t pgprot);
+extern pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot);
+extern void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+		       pmd_t *pmdp, pmd_t pmd);
+extern void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
+				 pmd_t *pmd);
+
+static inline int pmd_trans_huge(pmd_t pmd)
+{
+	/*
+	 * leaf pte for huge page, bottom two bits != 00
+	 */
+	return (pmd_val(pmd) & 0x3) && (pmd_val(pmd) & _PAGE_THP_HUGE);
+}
+
+static inline int pmd_large(pmd_t pmd)
+{
+	/*
+	 * leaf pte for huge page, bottom two bits != 00
+	 */
+	if (pmd_trans_huge(pmd))
+		return pmd_val(pmd) & _PAGE_PRESENT;
+	return 0;
+}
+
+static inline int pmd_trans_splitting(pmd_t pmd)
+{
+	if (pmd_trans_huge(pmd))
+		return pmd_val(pmd) & _PAGE_SPLITTING;
+	return 0;
+}
+
+/* We will enable it in the last patch */
+#define has_transparent_hugepage() 0
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+static inline pte_t pmd_pte(pmd_t pmd)
+{
+	return __pte(pmd_val(pmd));
+}
+
+static inline pmd_t pte_pmd(pte_t pte)
+{
+	return __pmd(pte_val(pte));
+}
+
+static inline pte_t *pmdp_ptep(pmd_t *pmd)
+{
+	return (pte_t *)pmd;
+}
+
+#define pmd_pfn(pmd)		pte_pfn(pmd_pte(pmd))
+#define pmd_young(pmd)		pte_young(pmd_pte(pmd))
+#define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
+#define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
+#define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
+#define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
+#define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
+
+#define __HAVE_ARCH_PMD_WRITE
+#define pmd_write(pmd)		pte_write(pmd_pte(pmd))
+
+static inline pmd_t pmd_mkhuge(pmd_t pmd)
+{
+	/* Do nothing, mk_pmd() does this part.  */
+	return pmd;
+}
+
+static inline pmd_t pmd_mknotpresent(pmd_t pmd)
+{
+	pmd_val(pmd) &= ~_PAGE_PRESENT;
+	return pmd;
+}
+
+static inline pmd_t pmd_mksplitting(pmd_t pmd)
+{
+	pmd_val(pmd) |= _PAGE_SPLITTING;
+	return pmd;
+}
+
+#define __HAVE_ARCH_PMD_SAME
+static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
+{
+	return (((pmd_val(pmd_a) ^ pmd_val(pmd_b)) & ~_PAGE_HPTEFLAGS) == 0);
+}
+
+#define __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
+extern int pmdp_set_access_flags(struct vm_area_struct *vma,
+				 unsigned long address, pmd_t *pmdp,
+				 pmd_t entry, int dirty);
+
+extern unsigned long pmd_hugepage_update(struct mm_struct *mm,
+					 unsigned long addr,
+					 pmd_t *pmdp, unsigned long clr);
+
+static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
+					      unsigned long addr, pmd_t *pmdp)
+{
+	unsigned long old;
+
+	if ((pmd_val(*pmdp) & (_PAGE_ACCESSED | _PAGE_HASHPTE)) == 0)
+		return 0;
+	old = pmd_hugepage_update(mm, addr, pmdp, _PAGE_ACCESSED);
+	return ((old & _PAGE_ACCESSED) != 0);
+}
+
+#define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
+extern int pmdp_test_and_clear_young(struct vm_area_struct *vma,
+				     unsigned long address, pmd_t *pmdp);
+#define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
+extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
+				  unsigned long address, pmd_t *pmdp);
+
+#define __HAVE_ARCH_PMDP_GET_AND_CLEAR
+extern pmd_t pmdp_get_and_clear(struct mm_struct *mm,
+				unsigned long addr, pmd_t *pmdp);
+
+#define __HAVE_ARCH_PMDP_CLEAR_FLUSH
+extern pmd_t pmdp_clear_flush(struct vm_area_struct *vma, unsigned long address,
+			      pmd_t *pmdp);
+
+#define __HAVE_ARCH_PMDP_SET_WRPROTECT
+static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
+				      pmd_t *pmdp)
+{
+
+	if ((pmd_val(*pmdp) & _PAGE_RW) == 0)
+		return;
+
+	pmd_hugepage_update(mm, addr, pmdp, _PAGE_RW);
+}
+
+#define __HAVE_ARCH_PMDP_SPLITTING_FLUSH
+extern void pmdp_splitting_flush(struct vm_area_struct *vma,
+				 unsigned long address, pmd_t *pmdp);
+
+#define __HAVE_ARCH_PGTABLE_DEPOSIT
+extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
+				       pgtable_t pgtable);
+#define __HAVE_ARCH_PGTABLE_WITHDRAW
+extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
+
+#define __HAVE_ARCH_PMDP_INVALIDATE
+extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+			    pmd_t *pmdp);
+#endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_PGTABLE_PPC64_H_ */
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 7aeb955..d53db93 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -220,6 +220,10 @@ extern int gup_hugepd(hugepd_t *hugepd, unsigned pdshift, unsigned long addr,
 
 extern int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		       unsigned long end, int write, struct page **pages, int *nr);
+#ifndef CONFIG_TRANSPARENT_HUGEPAGE
+#define pmd_large(pmd)		0
+#define has_transparent_hugepage() 0
+#endif
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index 61a5927..2def01ed 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -165,7 +165,8 @@ static inline void flush_tlb_kernel_range(unsigned long start,
 /* Private function for use by PCI IO mapping code */
 extern void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 				     unsigned long end);
-
+extern void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd,
+				unsigned long addr);
 #else
 #error Unsupported MMU type
 #endif
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index a854096..90fa2a8 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -338,6 +338,19 @@ EXPORT_SYMBOL(iounmap);
 EXPORT_SYMBOL(__iounmap);
 EXPORT_SYMBOL(__iounmap_at);
 
+/*
+ * For hugepage we have pfn in the pmd, we use PTE_RPN_SHIFT bits for flags
+ * For PTE page, we have a PTE_FRAG_SIZE (4K) aligned virtual address.
+ */
+struct page *pmd_page(pmd_t pmd)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (pmd_trans_huge(pmd))
+		return pfn_to_page(pmd_pfn(pmd));
+#endif
+	return virt_to_page(pmd_page_vaddr(pmd));
+}
+
 #ifdef CONFIG_PPC_64K_PAGES
 static pte_t *get_from_cache(struct mm_struct *mm)
 {
@@ -455,3 +468,355 @@ void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
 }
 #endif
 #endif /* CONFIG_PPC_64K_PAGES */
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+
+/*
+ * This is called when relaxing access to a hugepage. It's also called in the page
+ * fault path when we don't hit any of the major fault cases, ie, a minor
+ * update of _PAGE_ACCESSED, _PAGE_DIRTY, etc... The generic code will have
+ * handled those two for us, we additionally deal with missing execute
+ * permission here on some processors
+ */
+int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
+			  pmd_t *pmdp, pmd_t entry, int dirty)
+{
+	int changed;
+#ifdef CONFIG_DEBUG_VM
+	WARN_ON(!pmd_trans_huge(*pmdp));
+	assert_spin_locked(&vma->vm_mm->page_table_lock);
+#endif
+	changed = !pmd_same(*(pmdp), entry);
+	if (changed) {
+		__ptep_set_access_flags(pmdp_ptep(pmdp), pmd_pte(entry));
+		/*
+		 * Since we are not supporting SW TLB systems, we don't
+		 * have any thing similar to flush_tlb_page_nohash()
+		 */
+	}
+	return changed;
+}
+
+unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
+				  pmd_t *pmdp, unsigned long clr)
+{
+
+	unsigned long old, tmp;
+
+#ifdef CONFIG_DEBUG_VM
+	WARN_ON(!pmd_trans_huge(*pmdp));
+	assert_spin_locked(&mm->page_table_lock);
+#endif
+
+#ifdef PTE_ATOMIC_UPDATES
+	__asm__ __volatile__(
+	"1:	ldarx	%0,0,%3\n\
+		andi.	%1,%0,%6\n\
+		bne-	1b \n\
+		andc	%1,%0,%4 \n\
+		stdcx.	%1,0,%3 \n\
+		bne-	1b"
+	: "=&r" (old), "=&r" (tmp), "=m" (*pmdp)
+	: "r" (pmdp), "r" (clr), "m" (*pmdp), "i" (_PAGE_BUSY)
+	: "cc" );
+#else
+	old = pmd_val(*pmdp);
+	*pmdp = __pmd(old & ~clr);
+#endif
+	if (old & _PAGE_HASHPTE)
+		hpte_do_hugepage_flush(mm, addr, pmdp);
+	return old;
+}
+
+pmd_t pmdp_clear_flush(struct vm_area_struct *vma, unsigned long address,
+		       pmd_t *pmdp)
+{
+	pmd_t pmd;
+
+	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
+	if (pmd_trans_huge(*pmdp)) {
+		pmd = pmdp_get_and_clear(vma->vm_mm, address, pmdp);
+	} else {
+		/*
+		 * khugepaged calls this for normal pmd
+		 */
+		pmd = *pmdp;
+		pmd_clear(pmdp);
+		/*
+		 * Now invalidate the hpte entries in the range
+		 * covered by pmd. This make sure we take a
+		 * fault and will find the pmd as none, which will
+		 * result in a major fault which takes mmap_sem and
+		 * hence wait for collapse to complete. Without this
+		 * the __collapse_huge_page_copy can result in copying
+		 * the old content.
+		 */
+		flush_tlb_pmd_range(vma->vm_mm, &pmd, address);
+	}
+	return pmd;
+}
+
+int pmdp_test_and_clear_young(struct vm_area_struct *vma,
+			      unsigned long address, pmd_t *pmdp)
+{
+	return __pmdp_test_and_clear_young(vma->vm_mm, address, pmdp);
+}
+
+/*
+ * We currently remove entries from the hashtable regardless of whether
+ * the entry was young or dirty. The generic routines only flush if the
+ * entry was young or dirty which is not good enough.
+ *
+ * We should be more intelligent about this but for the moment we override
+ * these functions and force a tlb flush unconditionally
+ */
+int pmdp_clear_flush_young(struct vm_area_struct *vma,
+				  unsigned long address, pmd_t *pmdp)
+{
+	return __pmdp_test_and_clear_young(vma->vm_mm, address, pmdp);
+}
+
+/*
+ * We mark the pmd splitting and invalidate all the hpte
+ * entries for this hugepage.
+ */
+void pmdp_splitting_flush(struct vm_area_struct *vma,
+			  unsigned long address, pmd_t *pmdp)
+{
+	unsigned long old, tmp;
+
+	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
+
+#ifdef CONFIG_DEBUG_VM
+	WARN_ON(!pmd_trans_huge(*pmdp));
+	assert_spin_locked(&vma->vm_mm->page_table_lock);
+#endif
+
+#ifdef PTE_ATOMIC_UPDATES
+
+	__asm__ __volatile__(
+	"1:	ldarx	%0,0,%3\n\
+		andi.	%1,%0,%6\n\
+		bne-	1b \n\
+		ori	%1,%0,%4 \n\
+		stdcx.	%1,0,%3 \n\
+		bne-	1b"
+	: "=&r" (old), "=&r" (tmp), "=m" (*pmdp)
+	: "r" (pmdp), "i" (_PAGE_SPLITTING), "m" (*pmdp), "i" (_PAGE_BUSY)
+	: "cc" );
+#else
+	old = pmd_val(*pmdp);
+	*pmdp = __pmd(old | _PAGE_SPLITTING);
+#endif
+	/*
+	 * If we didn't had the splitting flag set, go and flush the
+	 * HPTE entries.
+	 */
+	if (!(old & _PAGE_SPLITTING)) {
+		/* We need to flush the hpte */
+		if (old & _PAGE_HASHPTE)
+			hpte_do_hugepage_flush(vma->vm_mm, address, pmdp);
+	}
+}
+
+/*
+ * We want to put the pgtable in pmd and use pgtable for tracking
+ * the base page size hptes
+ */
+void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
+				pgtable_t pgtable)
+{
+	pgtable_t *pgtable_slot;
+	assert_spin_locked(&mm->page_table_lock);
+	/*
+	 * we store the pgtable in the second half of PMD
+	 */
+	pgtable_slot = (pgtable_t *)pmdp + PTRS_PER_PMD;
+	*pgtable_slot = pgtable;
+	/*
+	 * expose the deposited pgtable to other cpus.
+	 * before we set the hugepage PTE at pmd level
+	 * hash fault code looks at the deposted pgtable
+	 * to store hash index values.
+	 */
+	smp_wmb();
+}
+
+pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
+{
+	pgtable_t pgtable;
+	pgtable_t *pgtable_slot;
+
+	assert_spin_locked(&mm->page_table_lock);
+	pgtable_slot = (pgtable_t *)pmdp + PTRS_PER_PMD;
+	pgtable = *pgtable_slot;
+	/*
+	 * Once we withdraw, mark the entry NULL.
+	 */
+	*pgtable_slot = NULL;
+	/*
+	 * We store HPTE information in the deposited PTE fragment.
+	 * zero out the content on withdraw.
+	 */
+	memset(pgtable, 0, PTE_FRAG_SIZE);
+	return pgtable;
+}
+
+/*
+ * set a new huge pmd. We should not be called for updating
+ * an existing pmd entry. That should go via pmd_hugepage_update.
+ */
+void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+		pmd_t *pmdp, pmd_t pmd)
+{
+#ifdef CONFIG_DEBUG_VM
+	WARN_ON(!pmd_none(*pmdp));
+	assert_spin_locked(&mm->page_table_lock);
+	WARN_ON(!pmd_trans_huge(pmd));
+#endif
+	return set_pte_at(mm, addr, pmdp_ptep(pmdp), pmd_pte(pmd));
+}
+
+void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+		     pmd_t *pmdp)
+{
+	pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT);
+}
+
+/*
+ * A linux hugepage PMD was changed and the corresponding hash table entries
+ * neesd to be flushed.
+ */
+void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
+			    pmd_t *pmdp)
+{
+	int ssize, i;
+	unsigned long s_addr;
+	unsigned int psize, valid;
+	unsigned char *hpte_slot_array;
+	unsigned long hidx, vpn, vsid, hash, shift, slot;
+
+	/*
+	 * Flush all the hptes mapping this hugepage
+	 */
+	s_addr = addr & HPAGE_PMD_MASK;
+	/*
+	 * The hpte hindex are stored in the pgtable whose address is in the
+	 * second half of the PMD
+	 */
+	hpte_slot_array = *(char **)(pmdp + PTRS_PER_PMD);
+	/*
+	 * IF we try to do a HUGE PTE update after a withdraw is done.
+	 * we will find the below NULL. This happens when we do
+	 * split_huge_page_pmd
+	 */
+	if (!hpte_slot_array)
+		return;
+
+	/* get the base page size */
+	psize = get_slice_psize(mm, s_addr);
+	shift = mmu_psize_defs[psize].shift;
+
+	for (i = 0; i < (HPAGE_PMD_SIZE >> shift); i++) {
+		/*
+		 * 8 bits per each hpte entries
+		 * 000| [ secondary group (one bit) | hidx (3 bits) | valid bit]
+		 */
+		valid = hpte_valid(hpte_slot_array, i);
+		if (!valid)
+			continue;
+		hidx =  hpte_hash_index(hpte_slot_array, i);
+
+		/* get the vpn */
+		addr = s_addr + (i * (1ul << shift));
+		if (!is_kernel_addr(addr)) {
+			ssize = user_segment_size(addr);
+			vsid = get_vsid(mm->context.id, addr, ssize);
+			WARN_ON(vsid == 0);
+		} else {
+			vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
+			ssize = mmu_kernel_ssize;
+		}
+
+		vpn = hpt_vpn(addr, vsid, ssize);
+		hash = hpt_hash(vpn, shift, ssize);
+		if (hidx & _PTEIDX_SECONDARY)
+			hash = ~hash;
+
+		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+		slot += hidx & _PTEIDX_GROUP_IX;
+		ppc_md.hpte_invalidate(slot, vpn, psize,
+				       MMU_PAGE_16M, ssize, 0);
+	}
+}
+
+static pmd_t pmd_set_protbits(pmd_t pmd, pgprot_t pgprot)
+{
+	pmd_val(pmd) |= pgprot_val(pgprot);
+	return pmd;
+}
+
+pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot)
+{
+	pmd_t pmd;
+	/*
+	 * For a valid pte, we would have _PAGE_PRESENT or _PAGE_FILE always
+	 * set. We use this to check THP page at pmd level.
+	 * leaf pte for huge page, bottom two bits != 00
+	 */
+	pmd_val(pmd) = pfn << PTE_RPN_SHIFT;
+	pmd_val(pmd) |= _PAGE_THP_HUGE;
+	pmd = pmd_set_protbits(pmd, pgprot);
+	return pmd;
+}
+
+pmd_t mk_pmd(struct page *page, pgprot_t pgprot)
+{
+	return pfn_pmd(page_to_pfn(page), pgprot);
+}
+
+pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
+{
+
+	pmd_val(pmd) &= _HPAGE_CHG_MASK;
+	pmd = pmd_set_protbits(pmd, newprot);
+	return pmd;
+}
+
+/*
+ * This is called at the end of handling a user page fault, when the
+ * fault has been handled by updating a HUGE PMD entry in the linux page tables.
+ * We use it to preload an HPTE into the hash table corresponding to
+ * the updated linux HUGE PMD entry.
+ */
+void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
+			  pmd_t *pmd)
+{
+	return;
+}
+
+pmd_t pmdp_get_and_clear(struct mm_struct *mm,
+			 unsigned long addr, pmd_t *pmdp)
+{
+	pmd_t old_pmd;
+	pgtable_t pgtable;
+	unsigned long old;
+	pgtable_t *pgtable_slot;
+
+	old = pmd_hugepage_update(mm, addr, pmdp, ~0UL);
+	old_pmd = __pmd(old);
+	/*
+	 * We have pmd == none and we are holding page_table_lock.
+	 * So we can safely go and clear the pgtable hash
+	 * index info.
+	 */
+	pgtable_slot = (pgtable_t *)pmdp + PTRS_PER_PMD;
+	pgtable = *pgtable_slot;
+	/*
+	 * Let's zero out old valid and hash index details
+	 * hash fault look at them.
+	 */
+	memset(pgtable, 0, PTE_FRAG_SIZE);
+	return old_pmd;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index 023ec8a..48bf63e 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -219,3 +219,30 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 	arch_leave_lazy_mmu_mode();
 	local_irq_restore(flags);
 }
+
+void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
+{
+	pte_t *pte;
+	pte_t *start_pte;
+	unsigned long flags;
+
+	addr = _ALIGN_DOWN(addr, PMD_SIZE);
+	/* Note: Normally, we should only ever use a batch within a
+	 * PTE locked section. This violates the rule, but will work
+	 * since we don't actually modify the PTEs, we just flush the
+	 * hash while leaving the PTEs intact (including their reference
+	 * to being hashed). This is not the most performance oriented
+	 * way to do things but is fine for our needs here.
+	 */
+	local_irq_save(flags);
+	arch_enter_lazy_mmu_mode();
+	start_pte = pte_offset_map(pmd, addr);
+	for (pte = start_pte; pte < start_pte + PTRS_PER_PTE; pte++) {
+		unsigned long pteval = pte_val(*pte);
+		if (pteval & _PAGE_HASHPTE)
+			hpte_need_flush(mm, addr, pte, pteval, 0);
+		addr += PAGE_SIZE;
+	}
+	arch_leave_lazy_mmu_mode();
+	local_irq_restore(flags);
+}
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 54f3936..ae0aaea 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -71,6 +71,7 @@ config PPC_BOOK3S_64
 	select PPC_FPU
 	select PPC_HAVE_PMU_SUPPORT
 	select SYS_SUPPORTS_HUGETLBFS
+	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if PPC_64K_PAGES
 
 config PPC_BOOK3E_64
 	bool "Embedded processors"
-- 
1.8.1.2
