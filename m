Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E8F31A0D77
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 04:07:57 +1100 (AEDT)
In-Reply-To: <20160125170459.14DB7692CE@newverein.lst.de>
References: <20160125170459.14DB7692CE@newverein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Date: Mon, 25 Jan 2016 16:31:14 +0100
Subject: [PATCH v6 6/9] ppc64 ftrace: disable profiling for some functions
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Message-Id: <20160125170753.D594A692CE@newverein.lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At least POWER7/8 have MMUs that don't completely autoload;
a normal, recoverable memory fault might pass through these functions.
If a dynamic tracer function causes such a fault, any of these functions
being traced with -mprofile-kernel may cause an endless recursion.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 arch/powerpc/kernel/process.c        |  2 +-
 arch/powerpc/mm/fault.c              |  2 +-
 arch/powerpc/mm/hash_utils_64.c      | 18 +++++++++---------
 arch/powerpc/mm/hugetlbpage-hash64.c |  2 +-
 arch/powerpc/mm/hugetlbpage.c        |  4 ++--
 arch/powerpc/mm/mem.c                |  2 +-
 arch/powerpc/mm/pgtable_64.c         |  2 +-
 arch/powerpc/mm/slb.c                |  6 +++---
 arch/powerpc/mm/slice.c              |  8 ++++----
 9 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 646bf4d..5b3c19d 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -733,7 +733,7 @@ static inline void __switch_to_tm(struct task_struct *prev)
  * don't know which of the checkpointed state and the transactional
  * state to use.
  */
-void restore_tm_state(struct pt_regs *regs)
+notrace void restore_tm_state(struct pt_regs *regs)
 {
 	unsigned long msr_diff;
 
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index a67c6d7..125be37 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -205,7 +205,7 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
  * The return value is 0 if the fault was handled, or the signal
  * number if this is a kernel fault that can't be handled here.
  */
-int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
+notrace int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 			    unsigned long error_code)
 {
 	enum ctx_state prev_state = exception_enter();
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 7f9616f..64f5b40 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -849,7 +849,7 @@ void early_init_mmu_secondary(void)
 /*
  * Called by asm hashtable.S for doing lazy icache flush
  */
-unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap)
+notrace unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap)
 {
 	struct page *page;
 
@@ -870,7 +870,7 @@ unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap)
 }
 
 #ifdef CONFIG_PPC_MM_SLICES
-static unsigned int get_paca_psize(unsigned long addr)
+static notrace unsigned int get_paca_psize(unsigned long addr)
 {
 	u64 lpsizes;
 	unsigned char *hpsizes;
@@ -899,7 +899,7 @@ unsigned int get_paca_psize(unsigned long addr)
  * For now this makes the whole process use 4k pages.
  */
 #ifdef CONFIG_PPC_64K_PAGES
-void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
+notrace void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
 {
 	if (get_slice_psize(mm, addr) == MMU_PAGE_4K)
 		return;
@@ -920,7 +920,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
  * Result is 0: full permissions, _PAGE_RW: read-only,
  * _PAGE_USER or _PAGE_USER|_PAGE_RW: no access.
  */
-static int subpage_protection(struct mm_struct *mm, unsigned long ea)
+static notrace int subpage_protection(struct mm_struct *mm, unsigned long ea)
 {
 	struct subpage_prot_table *spt = &mm->context.spt;
 	u32 spp = 0;
@@ -968,7 +968,7 @@ void hash_failure_debug(unsigned long ea, unsigned long access,
 		trap, vsid, ssize, psize, lpsize, pte);
 }
 
-static void check_paca_psize(unsigned long ea, struct mm_struct *mm,
+static notrace void check_paca_psize(unsigned long ea, struct mm_struct *mm,
 			     int psize, bool user_region)
 {
 	if (user_region) {
@@ -990,7 +990,7 @@ static void check_paca_psize(unsigned long ea, struct mm_struct *mm,
  * -1 - critical hash insertion error
  * -2 - access not permitted by subpage protection mechanism
  */
-int hash_page_mm(struct mm_struct *mm, unsigned long ea,
+notrace int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 		 unsigned long access, unsigned long trap,
 		 unsigned long flags)
 {
@@ -1187,7 +1187,7 @@ bail:
 }
 EXPORT_SYMBOL_GPL(hash_page_mm);
 
-int hash_page(unsigned long ea, unsigned long access, unsigned long trap,
+notrace int hash_page(unsigned long ea, unsigned long access, unsigned long trap,
 	      unsigned long dsisr)
 {
 	unsigned long flags = 0;
@@ -1289,7 +1289,7 @@ out_exit:
 /* WARNING: This is called from hash_low_64.S, if you change this prototype,
  *          do not forget to update the assembly call site !
  */
-void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
+notrace void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 		     unsigned long flags)
 {
 	unsigned long hash, index, shift, hidx, slot;
@@ -1437,7 +1437,7 @@ void low_hash_fault(struct pt_regs *regs, unsigned long address, int rc)
 	exception_exit(prev_state);
 }
 
-long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
+notrace long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
 			   unsigned long pa, unsigned long rflags,
 			   unsigned long vflags, int psize, int ssize)
 {
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index d94b1af..50b8c6f 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -18,7 +18,7 @@ extern long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
 				  unsigned long pa, unsigned long rlags,
 				  unsigned long vflags, int psize, int ssize);
 
-int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
+notrace int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		     pte_t *ptep, unsigned long trap, unsigned long flags,
 		     int ssize, unsigned int shift, unsigned int mmu_psize)
 {
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 9833fee..00c4b03 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -942,7 +942,7 @@ static int __init hugetlbpage_init(void)
 #endif
 arch_initcall(hugetlbpage_init);
 
-void flush_dcache_icache_hugepage(struct page *page)
+notrace void flush_dcache_icache_hugepage(struct page *page)
 {
 	int i;
 	void *start;
@@ -975,7 +975,7 @@ void flush_dcache_icache_hugepage(struct page *page)
  * when we have MSR[EE] = 0 but the paca->soft_enabled = 1
  */
 
-pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
+notrace pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 				   bool *is_thp, unsigned *shift)
 {
 	pgd_t pgd, *pgdp;
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 22d94c3..f690e8a 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -406,7 +406,7 @@ void flush_dcache_page(struct page *page)
 }
 EXPORT_SYMBOL(flush_dcache_page);
 
-void flush_dcache_icache_page(struct page *page)
+notrace void flush_dcache_icache_page(struct page *page)
 {
 #ifdef CONFIG_HUGETLB_PAGE
 	if (PageCompound(page)) {
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index e92cb21..c74050b 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -442,7 +442,7 @@ static void page_table_free_rcu(void *table)
 	}
 }
 
-void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
+notrace void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
 {
 	unsigned long pgf = (unsigned long)table;
 
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 515730e..3e9be5d 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -96,7 +96,7 @@ static inline void create_shadowed_slbe(unsigned long ea, int ssize,
 		     : "memory" );
 }
 
-static void __slb_flush_and_rebolt(void)
+static notrace void __slb_flush_and_rebolt(void)
 {
 	/* If you change this make sure you change SLB_NUM_BOLTED
 	 * and PR KVM appropriately too. */
@@ -136,7 +136,7 @@ static void __slb_flush_and_rebolt(void)
 		     : "memory");
 }
 
-void slb_flush_and_rebolt(void)
+notrace void slb_flush_and_rebolt(void)
 {
 
 	WARN_ON(!irqs_disabled());
@@ -151,7 +151,7 @@ void slb_flush_and_rebolt(void)
 	get_paca()->slb_cache_ptr = 0;
 }
 
-void slb_vmalloc_update(void)
+notrace void slb_vmalloc_update(void)
 {
 	unsigned long vflags;
 
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 0f432a7..f92f0f0 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -76,8 +76,8 @@ static void slice_print_mask(const char *label, struct slice_mask mask) {}
 
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
@@ -645,7 +645,7 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 }
 
-void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
+notrace void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 			   unsigned long len, unsigned int psize)
 {
 	struct slice_mask mask = slice_range_to_mask(start, len);
-- 
1.8.5.6
