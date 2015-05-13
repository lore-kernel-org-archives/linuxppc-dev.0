Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E0881A0281
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 02:16:55 +1000 (AEST)
Date: Wed, 13 May 2015 18:11:00 +0200
From: Torsten Duwe <duwe@lst.de>
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] ppc64 ftrace: mark data_access callees "notrace" (pt.1)
Message-ID: <20150513161100.GA1619@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to avoid an endless recursion, functions that may get
called from the data access handler must not call into tracing
functions, which may cause data access faults ;-)

Advancing from my previous approach that lavishly compiled whole
subdirs without the profiling switches, this is more fine-grained
(but probably yet incomplete). This patch is necessary albeit not
sufficient for FTRACE_WITH_REGS on ppc64.

Patch is against 3.17; fuzz+force should do no harm.

Signed-off-by: Torsten Duwe <duwe@suse.de>

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index bf44ae9..29ed85f 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -717,7 +717,7 @@ static inline void __switch_to_tm(struct task_struct *prev)
  * don't know which of the checkpointed state and the transactional
  * state to use.
  */
-void restore_tm_state(struct pt_regs *regs)
+notrace void restore_tm_state(struct pt_regs *regs)
 {
 	unsigned long msr_diff;
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index daee7f4..a8e5b8c 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -846,7 +846,7 @@ void early_init_mmu_secondary(void)
 /*
  * Called by asm hashtable.S for doing lazy icache flush
  */
-unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap)
+notrace unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap)
 {
 	struct page *page;
 
@@ -867,7 +867,7 @@ unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap)
 }
 
 #ifdef CONFIG_PPC_MM_SLICES
-unsigned int get_paca_psize(unsigned long addr)
+notrace unsigned int get_paca_psize(unsigned long addr)
 {
 	u64 lpsizes;
 	unsigned char *hpsizes;
@@ -896,7 +896,7 @@ unsigned int get_paca_psize(unsigned long addr)
  * For now this makes the whole process use 4k pages.
  */
 #ifdef CONFIG_PPC_64K_PAGES
-void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
+notrace void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
 {
 	if (get_slice_psize(mm, addr) == MMU_PAGE_4K)
 		return;
@@ -919,7 +919,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
  * Result is 0: full permissions, _PAGE_RW: read-only,
  * _PAGE_USER or _PAGE_USER|_PAGE_RW: no access.
  */
-static int subpage_protection(struct mm_struct *mm, unsigned long ea)
+static notrace int subpage_protection(struct mm_struct *mm, unsigned long ea)
 {
 	struct subpage_prot_table *spt = &mm->context.spt;
 	u32 spp = 0;
@@ -967,7 +967,7 @@ void hash_failure_debug(unsigned long ea, unsigned long access,
 		trap, vsid, ssize, psize, lpsize, pte);
 }
 
-static void check_paca_psize(unsigned long ea, struct mm_struct *mm,
+static notrace void check_paca_psize(unsigned long ea, struct mm_struct *mm,
 			     int psize, bool user_region)
 {
 	if (user_region) {
@@ -989,7 +989,7 @@ static void check_paca_psize(unsigned long ea, struct mm_struct *mm,
  * -1 - critical hash insertion error
  * -2 - access not permitted by subpage protection mechanism
  */
-int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
+notrace int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 {
 	enum ctx_state prev_state = exception_enter();
 	pgd_t *pgdir;
@@ -1269,7 +1269,7 @@ out_exit:
 /* WARNING: This is called from hash_low_64.S, if you change this prototype,
  *          do not forget to update the assembly call site !
  */
-void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
+notrace void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 		     int local)
 {
 	unsigned long hash, index, shift, hidx, slot;
@@ -1343,7 +1343,7 @@ void low_hash_fault(struct pt_regs *regs, unsigned long address, int rc)
 	exception_exit(prev_state);
 }
 
-long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
+notrace long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
 			   unsigned long pa, unsigned long rflags,
 			   unsigned long vflags, int psize, int ssize)
 {
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index a5bcf93..ea911b2 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -18,7 +18,7 @@ extern long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
 				  unsigned long pa, unsigned long rlags,
 				  unsigned long vflags, int psize, int ssize);
 
-int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
+notrace int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		     pte_t *ptep, unsigned long trap, int local, int ssize,
 		     unsigned int shift, unsigned int mmu_psize)
 {
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 7e70ae9..4fe2338 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -905,7 +905,7 @@ static int __init hugetlbpage_init(void)
 #endif
 module_init(hugetlbpage_init);
 
-void flush_dcache_icache_hugepage(struct page *page)
+notrace void flush_dcache_icache_hugepage(struct page *page)
 {
 	int i;
 	void *start;
@@ -936,7 +936,7 @@ void flush_dcache_icache_hugepage(struct page *page)
  * we can follow the address down to the the page and take a ref on it.
  */
 
-pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea, unsigned *shift)
+notrace pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea, unsigned *shift)
 {
 	pgd_t pgd, *pgdp;
 	pud_t pud, *pudp;
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index e0f7a18..05f66b1 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -400,7 +400,7 @@ void flush_dcache_page(struct page *page)
 }
 EXPORT_SYMBOL(flush_dcache_page);
 
-void flush_dcache_icache_page(struct page *page)
+notrace void flush_dcache_icache_page(struct page *page)
 {
 #ifdef CONFIG_HUGETLB_PAGE
 	if (PageCompound(page)) {
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index c8d709a..72bd991 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -444,7 +444,7 @@ static void page_table_free_rcu(void *table)
 	}
 }
 
-void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
+notrace void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
 {
 	unsigned long pgf = (unsigned long)table;
 
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 0399a67..5ccc3c8 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -94,7 +94,7 @@ static inline void create_shadowed_slbe(unsigned long ea, int ssize,
 		     : "memory" );
 }
 
-static void __slb_flush_and_rebolt(void)
+static notrace void __slb_flush_and_rebolt(void)
 {
 	/* If you change this make sure you change SLB_NUM_BOLTED
 	 * and PR KVM appropriately too. */
@@ -134,7 +134,7 @@ static void __slb_flush_and_rebolt(void)
 		     : "memory");
 }
 
-void slb_flush_and_rebolt(void)
+notrace void slb_flush_and_rebolt(void)
 {
 
 	WARN_ON(!irqs_disabled());
@@ -149,7 +149,7 @@ void slb_flush_and_rebolt(void)
 	get_paca()->slb_cache_ptr = 0;
 }
 
-void slb_vmalloc_update(void)
+notrace void slb_vmalloc_update(void)
 {
 	unsigned long vflags;
 
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index b0c75cc..c1efc4c 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -74,8 +74,8 @@ static void slice_print_mask(const char *label, struct slice_mask mask) {}
 
 #endif
 
-static struct slice_mask slice_range_to_mask(unsigned long start,
-					     unsigned long len)
+static notrace struct slice_mask slice_range_to_mask(unsigned long start,
+						     unsigned long len)
 {
 	unsigned long end = start + len - 1;
 	struct slice_mask ret = { 0, 0 };
@@ -564,7 +564,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
 				       current->mm->context.user_psize, 1);
 }
 
-unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
+notrace unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned char *hpsizes;
 	int index, mask_index;
@@ -676,7 +676,7 @@ void slice_set_psize(struct mm_struct *mm, unsigned long address,
 #endif
 }
 
-void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
+notrace void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 			   unsigned long len, unsigned int psize)
 {
 	struct slice_mask mask = slice_range_to_mask(start, len);
