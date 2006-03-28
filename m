Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E5FF1679EA
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 18:55:28 +1100 (EST)
Date: Mon, 27 Mar 2006 23:55:25 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] lock PTE before updating it in 440/BookE page fault handler
Message-ID: <20060328075525.GA20801@gate.ebshome.net>
References: <20060302202634.GA14387@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060302202634.GA14387@gate.ebshome.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix 44x and BookE page fault handler to correctly lock PTE before 
trying to pte_update() it, otherwise this PTE might be swapped out 
after pte_present() check but before pte_uptdate() call, resulting in 
corrupted PTE. This can happen with enabled preemption and low memory 
condition.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

---
 arch/ppc/mm/fault.c       |   30 +++++++++++++++++-------------
 arch/ppc/mm/pgtable.c     |    6 ++++--
 include/asm-ppc/pgtable.h |    3 ++-
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/ppc/mm/fault.c b/arch/ppc/mm/fault.c
index 0217188..8e08ca3 100644
--- a/arch/ppc/mm/fault.c
+++ b/arch/ppc/mm/fault.c
@@ -202,6 +202,7 @@ good_area:
 	/* an exec  - 4xx/Book-E allows for per-page execute permission */
 	} else if (TRAP(regs) == 0x400) {
 		pte_t *ptep;
+		pmd_t *pmdp;
 
 #if 0
 		/* It would be nice to actually enforce the VM execute
@@ -215,21 +216,24 @@ good_area:
 		/* Since 4xx/Book-E supports per-page execute permission,
 		 * we lazily flush dcache to icache. */
 		ptep = NULL;
-		if (get_pteptr(mm, address, &ptep) && pte_present(*ptep)) {
-			struct page *page = pte_page(*ptep);
-
-			if (! test_bit(PG_arch_1, &page->flags)) {
-				flush_dcache_icache_page(page);
-				set_bit(PG_arch_1, &page->flags);
+		if (get_pteptr(mm, address, &ptep, &pmdp)) {
+			spinlock_t *ptl = pte_lockptr(mm, pmdp);
+			spin_lock(ptl);
+			if (pte_present(*ptep)) {
+				struct page *page = pte_page(*ptep);
+
+				if (!test_bit(PG_arch_1, &page->flags)) {
+					flush_dcache_icache_page(page);
+					set_bit(PG_arch_1, &page->flags);
+				}
+				pte_update(ptep, 0, _PAGE_HWEXEC);
+				_tlbie(address);
+				pte_unmap_unlock(ptep, ptl);
+				up_read(&mm->mmap_sem);
+				return 0;
 			}
-			pte_update(ptep, 0, _PAGE_HWEXEC);
-			_tlbie(address);
-			pte_unmap(ptep);
-			up_read(&mm->mmap_sem);
-			return 0;
+			pte_unmap_unlock(ptep, ptl);
 		}
-		if (ptep != NULL)
-			pte_unmap(ptep);
 #endif
 	/* a read */
 	} else {
diff --git a/arch/ppc/mm/pgtable.c b/arch/ppc/mm/pgtable.c
index 6ea9185..98a83be 100644
--- a/arch/ppc/mm/pgtable.c
+++ b/arch/ppc/mm/pgtable.c
@@ -368,7 +368,7 @@ void __init io_block_mapping(unsigned lo
  * the PTE pointer is unmodified if PTE is not found.
  */
 int
-get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep)
+get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep, pmd_t **pmdp)
 {
         pgd_t	*pgd;
         pmd_t	*pmd;
@@ -383,6 +383,8 @@ get_pteptr(struct mm_struct *mm, unsigne
                         if (pte) {
 				retval = 1;
 				*ptep = pte;
+				if (pmdp)
+					*pmdp = pmd;
 				/* XXX caller needs to do pte_unmap, yuck */
                         }
                 }
@@ -420,7 +422,7 @@ unsigned long iopa(unsigned long addr)
 		mm = &init_mm;
 
 	pa = 0;
-	if (get_pteptr(mm, addr, &pte)) {
+	if (get_pteptr(mm, addr, &pte, NULL)) {
 		pa = (pte_val(*pte) & PAGE_MASK) | (addr & ~PAGE_MASK);
 		pte_unmap(pte);
 	}
diff --git a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
index e1c62da..570b355 100644
--- a/include/asm-ppc/pgtable.h
+++ b/include/asm-ppc/pgtable.h
@@ -837,7 +837,8 @@ static inline int io_remap_pfn_range(str
  */
 #define pgtable_cache_init()	do { } while (0)
 
-extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep);
+extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep,
+		      pmd_t **pmdp);
 
 #include <asm-generic/pgtable.h>
 
