Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4081E1A117A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 18:16:39 +1100 (AEDT)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 12:46:36 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 71A8B394006C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:46:34 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0C7GXMt56099002
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:46:33 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0C7GSQo013863
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:46:29 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 25/33] powerpc/mm: Hash linux abstraction for functions
 in pgtable-hash.c
Date: Tue, 12 Jan 2016 12:46:00 +0530
Message-Id: <1452582968-22669-26-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will later make the generic functions do conditial radix or hash
page table access. This patch doesn't do hugepage api update yet.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 15 +++++++++
 arch/powerpc/include/asm/book3s/64/hash.h    | 12 ++++++-
 arch/powerpc/include/asm/book3s/64/pgtable.h | 47 +++++++++++++++++++++++++++-
 arch/powerpc/include/asm/book3s/pgtable.h    |  4 ---
 arch/powerpc/include/asm/nohash/64/pgtable.h |  4 ++-
 arch/powerpc/include/asm/nohash/pgtable.h    | 11 +++++++
 arch/powerpc/include/asm/pgtable.h           | 13 --------
 arch/powerpc/mm/init_64.c                    |  3 --
 arch/powerpc/mm/pgtable-hash64.c             | 34 ++++++++++----------
 9 files changed, 103 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index b53d7504d6f6..6b1859c78719 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -102,6 +102,9 @@ extern unsigned long ioremap_bot;
 #define pte_clear(mm, addr, ptep) \
 	do { pte_update(ptep, ~_PAGE_HASHPTE, 0); } while (0)
 
+extern void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
+		       pte_t pte);
+
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
 #define	pmd_present(pmd)	(pmd_val(pmd) & _PMD_PRESENT_MASK)
@@ -502,6 +505,18 @@ static inline unsigned long ioremap_prot_flags(unsigned long flags)
 	flags &= ~(_PAGE_USER | _PAGE_EXEC);
 	return flags;
 }
+
+/*
+ * This gets called at the end of handling a page fault, when
+ * the kernel has put a new PTE into the page table for the process.
+ * We use it to ensure coherency between the i-cache and d-cache
+ * for the page which has just been mapped in.
+ * On machines which use an MMU hash table, we use this to put a
+ * corresponding HPTE into the hash table ahead of time, instead of
+ * waiting for the inevitable extra hash-table miss exception.
+ */
+extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t *);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /*  _ASM_POWERPC_BOOK3S_32_PGTABLE_H */
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 5d333400c87d..20bb9da200c6 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -600,7 +600,17 @@ static inline void hpte_do_hugepage_flush(struct mm_struct *mm,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-extern int map_kernel_page(unsigned long ea, unsigned long pa, int flags);
+extern int hlmap_kernel_page(unsigned long ea, unsigned long pa, int flags);
+extern void hlpgtable_cache_init(void);
+extern void __meminit hlvmemmap_create_mapping(unsigned long start,
+					       unsigned long page_size,
+					       unsigned long phys);
+extern void hlvmemmap_remove_mapping(unsigned long start,
+				     unsigned long page_size);
+extern void set_hlpte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
+			 pte_t pte);
+extern void hlupdate_mmu_cache(struct vm_area_struct *vma, unsigned long address,
+			       pte_t *ptep);
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index ca2f4364fac2..213cc7b8dac2 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -317,6 +317,12 @@ static inline int pte_present(pte_t pte)
 	return hlpte_present(pte);
 }
 
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pte)
+{
+	return set_hlpte_at(mm, addr, ptep, pte);
+}
+
 static inline void pmd_set(pmd_t *pmdp, unsigned long val)
 {
 	*pmdp = __pmd(val);
@@ -459,7 +465,46 @@ extern struct page *pgd_page(pgd_t pgd);
 	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
-void pgtable_cache_init(void);
+static inline void pgtable_cache_init(void)
+{
+	return hlpgtable_cache_init();
+}
+
+static inline int map_kernel_page(unsigned long ea, unsigned long pa,
+				  unsigned long flags)
+{
+	return hlmap_kernel_page(ea, pa, flags);
+}
+
+static inline void __meminit vmemmap_create_mapping(unsigned long start,
+						    unsigned long page_size,
+						    unsigned long phys)
+{
+	return hlvmemmap_create_mapping(start, page_size, phys);
+}
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline void vmemmap_remove_mapping(unsigned long start,
+					  unsigned long page_size)
+{
+	return hlvmemmap_remove_mapping(start, page_size);
+}
+#endif
+
+/*
+ * This gets called at the end of handling a page fault, when
+ * the kernel has put a new PTE into the page table for the process.
+ * We use it to ensure coherency between the i-cache and d-cache
+ * for the page which has just been mapped in.
+ * On machines which use an MMU hash table, we use this to put a
+ * corresponding HPTE into the hash table ahead of time, instead of
+ * waiting for the inevitable extra hash-table miss exception.
+ */
+static inline void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
+				    pte_t *ptep)
+{
+	return hlupdate_mmu_cache(vma, address, ptep);
+}
 
 struct page *realmode_pfn_to_page(unsigned long pfn);
 
diff --git a/arch/powerpc/include/asm/book3s/pgtable.h b/arch/powerpc/include/asm/book3s/pgtable.h
index 8b0f4a29259a..620f8b6e1ba2 100644
--- a/arch/powerpc/include/asm/book3s/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/pgtable.h
@@ -12,10 +12,6 @@
 /* Insert a PTE, top-level function is out of line. It uses an inline
  * low level function in the respective pgtable-* files
  */
-extern void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
-		       pte_t pte);
-
-
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 				 pte_t *ptep, pte_t entry, int dirty);
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index a68e809d7739..7010d95cbedf 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -360,7 +360,9 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
 extern int map_kernel_page(unsigned long ea, unsigned long pa, int flags);
-
+extern void __meminit vmemmap_create_mapping(unsigned long start,
+					     unsigned long page_size,
+					     unsigned long phys);
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_NOHASH_64_PGTABLE_H */
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 8861ec146985..43adffe8842f 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -283,5 +283,16 @@ static inline int pgd_huge(pgd_t pgd)
 #define is_hugepd(hpd)		(hugepd_ok(hpd))
 #endif
 
+/*
+ * This gets called at the end of handling a page fault, when
+ * the kernel has put a new PTE into the page table for the process.
+ * We use it to ensure coherency between the i-cache and d-cache
+ * for the page which has just been mapped in.
+ * On machines which use an MMU hash table, we use this to put a
+ * corresponding HPTE into the hash table ahead of time, instead of
+ * waiting for the inevitable extra hash-table miss exception.
+ */
+extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t *);
+
 #endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index ac9fb114e25d..dcd2b0d85d48 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -47,19 +47,6 @@ extern void paging_init(void);
 #define kern_addr_valid(addr)	(1)
 
 #include <asm-generic/pgtable.h>
-
-
-/*
- * This gets called at the end of handling a page fault, when
- * the kernel has put a new PTE into the page table for the process.
- * We use it to ensure coherency between the i-cache and d-cache
- * for the page which has just been mapped in.
- * On machines which use an MMU hash table, we use this to put a
- * corresponding HPTE into the hash table ahead of time, instead of
- * waiting for the inevitable extra hash-table miss exception.
- */
-extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t *);
-
 extern int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		       unsigned long end, int write,
 		       struct page **pages, int *nr);
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 05b025a0efe6..b3dd5ad68e53 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -194,9 +194,6 @@ static __meminit void vmemmap_list_populate(unsigned long phys,
 	vmemmap_list = vmem_back;
 }
 
-extern void __meminit vmemmap_create_mapping(unsigned long start,
-					     unsigned long page_size,
-					     unsigned long phys);
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 {
 	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index 2f9348e24633..885764bdc022 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -52,7 +52,7 @@ static void pmd_ctor(void *addr)
 }
 
 
-void pgtable_cache_init(void)
+void hlpgtable_cache_init(void)
 {
 	pgtable_cache_add(H_PGD_INDEX_SIZE, pgd_ctor);
 	pgtable_cache_add(H_PMD_CACHE_INDEX, pmd_ctor);
@@ -75,9 +75,9 @@ void pgtable_cache_init(void)
  * On hash-based CPUs, the vmemmap is bolted in the hash table.
  *
  */
-void __meminit vmemmap_create_mapping(unsigned long start,
-				      unsigned long page_size,
-				      unsigned long phys)
+void __meminit hlvmemmap_create_mapping(unsigned long start,
+					unsigned long page_size,
+					unsigned long phys)
 {
 	int  mapped = htab_bolt_mapping(start, start + page_size, phys,
 					pgprot_val(H_PAGE_KERNEL),
@@ -87,8 +87,8 @@ void __meminit vmemmap_create_mapping(unsigned long start,
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-void vmemmap_remove_mapping(unsigned long start,
-			    unsigned long page_size)
+void hlvmemmap_remove_mapping(unsigned long start,
+			      unsigned long page_size)
 {
 	int mapped = htab_remove_mapping(start, start + page_size,
 					 mmu_vmemmap_psize,
@@ -98,8 +98,8 @@ void vmemmap_remove_mapping(unsigned long start,
 #endif
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
-		      pte_t *ptep)
+void hlupdate_mmu_cache(struct vm_area_struct *vma, unsigned long address,
+			pte_t *ptep)
 {
 	/*
 	 * We don't need to worry about _PAGE_PRESENT here because we are
@@ -133,7 +133,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
  * map_kernel_page adds an entry to the ioremap page table
  * and adds an entry to the HPT, possibly bolting it
  */
-int map_kernel_page(unsigned long ea, unsigned long pa, int flags)
+int hlmap_kernel_page(unsigned long ea, unsigned long pa, int flags)
 {
 	pgd_t *pgdp;
 	pud_t *pudp;
@@ -178,7 +178,7 @@ int map_kernel_page(unsigned long ea, unsigned long pa, int flags)
  * and we avoid _PAGE_SPECIAL and _PAGE_NO_CACHE. We also only do that
  * on userspace PTEs
  */
-static inline int pte_looks_normal(pte_t pte)
+static inline int hlpte_looks_normal(pte_t pte)
 {
 	return (pte_val(pte) & (H_PAGE_PRESENT | H_PAGE_SPECIAL |
 					H_PAGE_NO_CACHE | H_PAGE_USER)) ==
@@ -203,11 +203,11 @@ static struct page *maybe_pte_to_page(pte_t pte)
  * flush the cache for valid PTEs in set_pte. Embedded CPU without HW exec
  * support falls into the same category.
  */
-static pte_t set_pte_filter(pte_t pte)
+static pte_t set_hlpte_filter(pte_t pte)
 {
 	pte = __pte(pte_val(pte) & ~H_PAGE_HPTEFLAGS);
-	if (pte_looks_normal(pte) && !(cpu_has_feature(CPU_FTR_COHERENT_ICACHE) ||
-				       cpu_has_feature(CPU_FTR_NOEXECUTE))) {
+	if (hlpte_looks_normal(pte) && !(cpu_has_feature(CPU_FTR_COHERENT_ICACHE) ||
+					 cpu_has_feature(CPU_FTR_NOEXECUTE))) {
 		struct page *pg = maybe_pte_to_page(pte);
 		if (!pg)
 			return pte;
@@ -222,8 +222,8 @@ static pte_t set_pte_filter(pte_t pte)
 /*
  * set_pte stores a linux PTE into the linux page table.
  */
-void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
-		pte_t pte)
+void set_hlpte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
+		  pte_t pte)
 {
 	/*
 	 * When handling numa faults, we already have the pte marked
@@ -242,10 +242,10 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 	 * this context might not have been activated yet when this
 	 * is called.
 	 */
-	pte = set_pte_filter(pte);
+	pte = set_hlpte_filter(pte);
 
 	/* Perform the setting of the PTE */
-	__set_pte_at(mm, addr, ptep, pte, 0);
+	__set_hlpte_at(mm, addr, ptep, pte, 0);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-- 
2.5.0
