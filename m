Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWMBS6psZzDrLC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 18:53:52 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id b79so9737025pfk.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 23:53:52 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v2 7/7] powerpc/64s/radix: Improve TLB flushing for page table
 freeing
Date: Tue,  7 Nov 2017 18:53:09 +1100
Message-Id: <20171107075309.20500-8-npiggin@gmail.com>
In-Reply-To: <20171107075309.20500-1-npiggin@gmail.com>
References: <20171107075309.20500-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unmaps that free page tables always flush the entire PID, which is
sub-optimal. Provide TLB range flushing with an additional PWC flush
that can be use for va range invalidations with PWC flush.

     Time to munmap N pages of memory including last level page table
     teardown (after mmap, touch), local invalidate:
     N           1       2      4      8     16     32     64
     vanilla  3.2us  3.3us  3.4us  3.6us  4.1us  5.2us  7.2us
     patched  1.4us  1.5us  1.7us  1.9us  2.6us  3.7us  6.2us

     Global invalidate:
     N           1       2      4      8     16      32     64
     vanilla  2.2us  2.3us  2.4us  2.6us  3.2us   4.1us  6.2us
     patched  2.1us  2.5us  3.4us  5.2us  8.7us  15.7us  6.2us

Local invalidates get much better across the board. Global ones have
the same issue where multiple tlbies for va flush do get slower than
the single tlbie to invalidate the PID. None of this test captures
the TLB benefits of avoiding killing everything.

Global gets worse, but it is brought in to line with global invalidate
for munmap()s that do not free page tables.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/tlb-radix.c | 90 ++++++++++++++++++++++++++++++---------------
 1 file changed, 61 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 5842c98fbe48..078f7da11ce1 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -39,6 +39,20 @@ static inline void __tlbiel_pid(unsigned long pid, int set,
 	trace_tlbie(0, 1, rb, rs, ric, prs, r);
 }
 
+static inline void __tlbie_pid(unsigned long pid, unsigned long ric)
+{
+	unsigned long rb,rs,prs,r;
+
+	rb = PPC_BIT(53); /* IS = 1 */
+	rs = pid << PPC_BITLSHIFT(31);
+	prs = 1; /* process scoped */
+	r = 1;   /* raidx format */
+
+	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+	trace_tlbie(0, 0, rb, rs, ric, prs, r);
+}
+
 /*
  * We use 128 set in radix mode and 256 set in hpt mode.
  */
@@ -70,18 +84,9 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 
 static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
 {
-	unsigned long rb,rs,prs,r;
-
-	rb = PPC_BIT(53); /* IS = 1 */
-	rs = pid << PPC_BITLSHIFT(31);
-	prs = 1; /* process scoped */
-	r = 1;   /* raidx format */
-
 	asm volatile("ptesync": : :"memory");
-	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
-		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+	__tlbie_pid(pid, ric);
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
-	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
 static inline void __tlbiel_va(unsigned long va, unsigned long pid,
@@ -123,9 +128,11 @@ static inline void _tlbiel_va(unsigned long va, unsigned long pid,
 
 static inline void _tlbiel_va_range(unsigned long start, unsigned long end,
 				    unsigned long pid, unsigned long page_size,
-				    unsigned long psize)
+				    unsigned long psize, bool also_pwc)
 {
 	asm volatile("ptesync": : :"memory");
+	if (also_pwc)
+		__tlbiel_pid(pid, 0, RIC_FLUSH_PWC);
 	__tlbiel_va_range(start, end, pid, page_size, psize);
 	asm volatile("ptesync": : :"memory");
 }
@@ -169,9 +176,11 @@ static inline void _tlbie_va(unsigned long va, unsigned long pid,
 
 static inline void _tlbie_va_range(unsigned long start, unsigned long end,
 				    unsigned long pid, unsigned long page_size,
-				    unsigned long psize)
+				    unsigned long psize, bool also_pwc)
 {
 	asm volatile("ptesync": : :"memory");
+	if (also_pwc)
+		__tlbie_pid(pid, RIC_FLUSH_PWC);
 	__tlbie_va_range(start, end, pid, page_size, psize);
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
@@ -411,13 +420,15 @@ static int radix_get_mmu_psize(int page_size)
 	return psize;
 }
 
+static void radix__flush_tlb_pwc_range_psize(struct mm_struct *mm, unsigned long start,
+				  unsigned long end, int psize);
+
 void radix__tlb_flush(struct mmu_gather *tlb)
 {
 	int psize = 0;
 	struct mm_struct *mm = tlb->mm;
 	int page_size = tlb->page_size;
 
-	psize = radix_get_mmu_psize(page_size);
 	/*
 	 * if page size is not something we understand, do a full mm flush
 	 *
@@ -425,17 +436,28 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 	 * that flushes the process table entry cache upon process teardown.
 	 * See the comment for radix in arch_exit_mmap().
 	 */
-	if (psize != -1 && !tlb->fullmm && !tlb->need_flush_all)
-		radix__flush_tlb_range_psize(mm, tlb->start, tlb->end, psize);
-	else if (tlb->fullmm || tlb->need_flush_all) {
-		tlb->need_flush_all = 0;
+	if (tlb->fullmm) {
 		radix__flush_all_mm(mm);
-	} else
-		radix__flush_tlb_mm(mm);
+	} else if ( (psize = radix_get_mmu_psize(page_size)) == -1) {
+		if (!tlb->need_flush_all)
+			radix__flush_tlb_mm(mm);
+		else
+			radix__flush_all_mm(mm);
+	} else {
+		unsigned long start = tlb->start;
+		unsigned long end = tlb->end;
+
+		if (!tlb->need_flush_all)
+			radix__flush_tlb_range_psize(mm, start, end, psize);
+		else
+			radix__flush_tlb_pwc_range_psize(mm, start, end, psize);
+	}
+	tlb->need_flush_all = 0;
 }
 
-void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
-				  unsigned long end, int psize)
+static inline void __radix__flush_tlb_range_psize(struct mm_struct *mm,
+				unsigned long start, unsigned long end,
+				int psize, bool also_pwc)
 {
 	unsigned long pid;
 	unsigned int page_shift = mmu_psize_defs[psize].shift;
@@ -461,19 +483,31 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 
 	if (full) {
 		if (local)
-			_tlbiel_pid(pid, RIC_FLUSH_TLB);
+			_tlbiel_pid(pid, also_pwc ? RIC_FLUSH_ALL : RIC_FLUSH_TLB);
 		else
-			_tlbie_pid(pid, RIC_FLUSH_TLB);
+			_tlbie_pid(pid, also_pwc ? RIC_FLUSH_ALL: RIC_FLUSH_TLB);
 	} else {
 		if (local)
-			_tlbiel_va_range(start, end, pid, page_size, psize);
+			_tlbiel_va_range(start, end, pid, page_size, psize, also_pwc);
 		else
-			_tlbie_va_range(start, end, pid, page_size, psize);
+			_tlbie_va_range(start, end, pid, page_size, psize, also_pwc);
 	}
 
 	preempt_enable();
 }
 
+void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
+				  unsigned long end, int psize)
+{
+	return __radix__flush_tlb_range_psize(mm, start, end, psize, false);
+}
+
+static void radix__flush_tlb_pwc_range_psize(struct mm_struct *mm, unsigned long start,
+				  unsigned long end, int psize)
+{
+	__radix__flush_tlb_range_psize(mm, start, end, psize, true);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 {
@@ -494,11 +528,9 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 	/* Otherwise first do the PWC, then iterate the pages. */
 	preempt_disable();
 	if (mm_is_thread_local(mm)) {
-		_tlbiel_pid(pid, RIC_FLUSH_PWC);
-		_tlbiel_va_range(addr, end, pid, PAGE_SIZE, mmu_virtual_psize);
+		_tlbiel_va_range(addr, end, pid, PAGE_SIZE, mmu_virtual_psize, true);
 	} else {
-		_tlbie_pid(pid, RIC_FLUSH_PWC);
-		_tlbie_va_range(addr, end, pid, PAGE_SIZE, mmu_virtual_psize);
+		_tlbie_va_range(addr, end, pid, PAGE_SIZE, mmu_virtual_psize, true);
 	}
 	preempt_enable();
 }
-- 
2.15.0
