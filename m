Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 55B9B2C02A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 19:01:27 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 20 Jun 2013 18:51:57 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E63FD2CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 19:01:23 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5K91Fsf64618708
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 19:01:15 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5K91N3E001338
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 19:01:23 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V11 06/15] powerpc: Replace find_linux_pte with
 find_linux_pte_or_hugepte
Date: Thu, 20 Jun 2013 14:30:18 +0530
Message-Id: <1371718827-15065-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1371718827-15065-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1371718827-15065-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Replace find_linux_pte with find_linux_pte_or_hugepte and explicitly
document why we don't need to handle transparent hugepages at callsites.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h | 24 ------------------------
 arch/powerpc/kernel/io-workarounds.c     | 11 +++++++++--
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |  2 +-
 arch/powerpc/mm/hash_utils_64.c          |  8 +++++++-
 arch/powerpc/mm/hugetlbpage.c            |  8 ++++++--
 arch/powerpc/mm/tlb_hash64.c             |  9 +++++++--
 arch/powerpc/platforms/pseries/eeh.c     |  7 ++++++-
 7 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 6c9323f..e71bd25 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -344,30 +344,6 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
-
-/*
- * find_linux_pte returns the address of a linux pte for a given
- * effective address and directory.  If not found, it returns zero.
- */
-static inline pte_t *find_linux_pte(pgd_t *pgdir, unsigned long ea)
-{
-	pgd_t *pg;
-	pud_t *pu;
-	pmd_t *pm;
-	pte_t *pt = NULL;
-
-	pg = pgdir + pgd_index(ea);
-	if (!pgd_none(*pg)) {
-		pu = pud_offset(pg, ea);
-		if (!pud_none(*pu)) {
-			pm = pmd_offset(pu, ea);
-			if (pmd_present(*pm))
-				pt = pte_offset_kernel(pm, ea);
-		}
-	}
-	return pt;
-}
-
 #endif /* __ASSEMBLY__ */
 
 /*
diff --git a/arch/powerpc/kernel/io-workarounds.c b/arch/powerpc/kernel/io-workarounds.c
index 50e90b7..fa0b54b 100644
--- a/arch/powerpc/kernel/io-workarounds.c
+++ b/arch/powerpc/kernel/io-workarounds.c
@@ -55,6 +55,7 @@ static struct iowa_bus *iowa_pci_find(unsigned long vaddr, unsigned long paddr)
 
 struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR addr)
 {
+	unsigned hugepage_shift;
 	struct iowa_bus *bus;
 	int token;
 
@@ -70,11 +71,17 @@ struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR addr)
 		if (vaddr < PHB_IO_BASE || vaddr >= PHB_IO_END)
 			return NULL;
 
-		ptep = find_linux_pte(init_mm.pgd, vaddr);
+		ptep = find_linux_pte_or_hugepte(init_mm.pgd, vaddr,
+						 &hugepage_shift);
 		if (ptep == NULL)
 			paddr = 0;
-		else
+		else {
+			/*
+			 * we don't have hugepages backing iomem
+			 */
+			WARN_ON(hugepage_shift);
 			paddr = pte_pfn(*ptep) << PAGE_SHIFT;
+		}
 		bus = iowa_pci_find(vaddr, paddr);
 
 		if (bus == NULL)
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 6dcbb49..dcf892d 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -27,7 +27,7 @@ static void *real_vmalloc_addr(void *x)
 	unsigned long addr = (unsigned long) x;
 	pte_t *p;
 
-	p = find_linux_pte(swapper_pg_dir, addr);
+	p = find_linux_pte_or_hugepte(swapper_pg_dir, addr, NULL);
 	if (!p || !pte_present(*p))
 		return NULL;
 	/* assume we don't have huge pages in vmalloc space... */
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 2f47080..e8434ca 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1145,6 +1145,7 @@ EXPORT_SYMBOL_GPL(hash_page);
 void hash_preload(struct mm_struct *mm, unsigned long ea,
 		  unsigned long access, unsigned long trap)
 {
+	int hugepage_shift;
 	unsigned long vsid;
 	pgd_t *pgdir;
 	pte_t *ptep;
@@ -1166,10 +1167,15 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	pgdir = mm->pgd;
 	if (pgdir == NULL)
 		return;
-	ptep = find_linux_pte(pgdir, ea);
+	/*
+	 * THP pages use update_mmu_cache_pmd. We don't do
+	 * hash preload there. Hence can ignore THP here
+	 */
+	ptep = find_linux_pte_or_hugepte(pgdir, ea, &hugepage_shift);
 	if (!ptep)
 		return;
 
+	WARN_ON(hugepage_shift);
 #ifdef CONFIG_PPC_64K_PAGES
 	/* If either _PAGE_4K_PFN or _PAGE_NO_CACHE is set (and we are on
 	 * a 64K kernel), then we don't preload, hash_page() will take
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 4928204..8add580 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -105,6 +105,7 @@ int pgd_huge(pgd_t pgd)
 
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
+	/* Only called for hugetlbfs pages, hence can ignore THP */
 	return find_linux_pte_or_hugepte(mm->pgd, addr, NULL);
 }
 
@@ -673,11 +674,14 @@ follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
 	struct page *page;
 	unsigned shift;
 	unsigned long mask;
-
+	/*
+	 * Transparent hugepages are handled by generic code. We can skip them
+	 * here.
+	 */
 	ptep = find_linux_pte_or_hugepte(mm->pgd, address, &shift);
 
 	/* Verify it is a huge page else bail. */
-	if (!ptep || !shift)
+	if (!ptep || !shift || pmd_trans_huge(*(pmd_t *)ptep))
 		return ERR_PTR(-EINVAL);
 
 	mask = (1UL << shift) - 1;
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index 48bf63e..313c85c 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -189,6 +189,7 @@ void tlb_flush(struct mmu_gather *tlb)
 void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 			      unsigned long end)
 {
+	int hugepage_shift;
 	unsigned long flags;
 
 	start = _ALIGN_DOWN(start, PAGE_SIZE);
@@ -206,7 +207,8 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 	local_irq_save(flags);
 	arch_enter_lazy_mmu_mode();
 	for (; start < end; start += PAGE_SIZE) {
-		pte_t *ptep = find_linux_pte(mm->pgd, start);
+		pte_t *ptep = find_linux_pte_or_hugepte(mm->pgd, start,
+							&hugepage_shift);
 		unsigned long pte;
 
 		if (ptep == NULL)
@@ -214,7 +216,10 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 		pte = pte_val(*ptep);
 		if (!(pte & _PAGE_HASHPTE))
 			continue;
-		hpte_need_flush(mm, start, ptep, pte, 0);
+		if (unlikely(hugepage_shift && pmd_trans_huge(*(pmd_t *)pte)))
+			hpte_do_hugepage_flush(mm, start, (pmd_t *)pte);
+		else
+			hpte_need_flush(mm, start, ptep, pte, 0);
 	}
 	arch_leave_lazy_mmu_mode();
 	local_irq_restore(flags);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 6b73d6c..7e2700d 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -260,10 +260,15 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
 {
 	pte_t *ptep;
 	unsigned long pa;
+	int hugepage_shift;
 
-	ptep = find_linux_pte(init_mm.pgd, token);
+	/*
+	 * We won't find hugepages here, iomem
+	 */
+	ptep = find_linux_pte_or_hugepte(init_mm.pgd, token, &hugepage_shift);
 	if (!ptep)
 		return token;
+	WARN_ON(hugepage_shift);
 	pa = pte_pfn(*ptep) << PAGE_SHIFT;
 
 	return pa | (token & (PAGE_SIZE-1));
-- 
1.8.1.2
