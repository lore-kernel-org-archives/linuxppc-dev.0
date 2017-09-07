Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xp3Mc5STtzDrXs
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 00:52:28 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id m9so5058072pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Sep 2017 07:52:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
Subject: [RFC PATCH 4/8] powerpc/64s/radix: Implement _tlbie(l)_va_range flush
 functions
Date: Fri,  8 Sep 2017 00:51:44 +1000
Message-Id: <20170907145148.24398-5-npiggin@gmail.com>
In-Reply-To: <20170907145148.24398-1-npiggin@gmail.com>
References: <20170907145148.24398-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the barriers and range iteration down into the _tlbie* level,
which improves readability.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/tlb-radix.c | 70 ++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index c30f3faf5356..1d3cbc01596d 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -85,7 +85,7 @@ static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
 }
 
 static inline void __tlbiel_va(unsigned long va, unsigned long pid,
-			      unsigned long ap, unsigned long ric)
+			       unsigned long ap, unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
 
@@ -101,13 +101,28 @@ static inline void __tlbiel_va(unsigned long va, unsigned long pid,
 }
 
 static inline void _tlbiel_va(unsigned long va, unsigned long pid,
-			      unsigned long ap, unsigned long ric)
+			      unsigned long psize, unsigned long ric)
 {
+	unsigned long ap = mmu_get_ap(psize);
+
 	asm volatile("ptesync": : :"memory");
 	__tlbiel_va(va, pid, ap, ric);
 	asm volatile("ptesync": : :"memory");
 }
 
+static inline void _tlbiel_va_range(unsigned long start, unsigned long end,
+				    unsigned long pid, unsigned long page_size,
+				    unsigned long psize)
+{
+	unsigned long addr;
+	unsigned long ap = mmu_get_ap(psize);
+
+	asm volatile("ptesync": : :"memory");
+	for (addr = start; addr < end; addr += page_size)
+		__tlbiel_va(addr, pid, ap, RIC_FLUSH_TLB);
+	asm volatile("ptesync": : :"memory");
+}
+
 static inline void __tlbie_va(unsigned long va, unsigned long pid,
 			     unsigned long ap, unsigned long ric)
 {
@@ -125,13 +140,27 @@ static inline void __tlbie_va(unsigned long va, unsigned long pid,
 }
 
 static inline void _tlbie_va(unsigned long va, unsigned long pid,
-			     unsigned long ap, unsigned long ric)
+			      unsigned long psize, unsigned long ric)
 {
+	unsigned long ap = mmu_get_ap(psize);
+
 	asm volatile("ptesync": : :"memory");
 	__tlbie_va(va, pid, ap, ric);
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
+static inline void _tlbie_va_range(unsigned long start, unsigned long end,
+				    unsigned long pid, unsigned long page_size,
+				    unsigned long psize)
+{
+	unsigned long addr;
+	unsigned long ap = mmu_get_ap(psize);
+
+	asm volatile("ptesync": : :"memory");
+	for (addr = start; addr < end; addr += page_size)
+		__tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
+	asm volatile("eieio; tlbsync; ptesync": : :"memory");
+}
 
 /*
  * Base TLB flushing operations:
@@ -173,12 +202,11 @@ void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmadd
 				       int psize)
 {
 	unsigned long pid;
-	unsigned long ap = mmu_get_ap(psize);
 
 	preempt_disable();
 	pid = mm ? mm->context.id : 0;
 	if (pid != MMU_NO_CONTEXT)
-		_tlbiel_va(vmaddr, pid, ap, RIC_FLUSH_TLB);
+		_tlbiel_va(vmaddr, pid, psize, RIC_FLUSH_TLB);
 	preempt_enable();
 }
 
@@ -238,16 +266,15 @@ void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
 				 int psize)
 {
 	unsigned long pid;
-	unsigned long ap = mmu_get_ap(psize);
 
 	pid = mm ? mm->context.id : 0;
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		return;
 	preempt_disable();
 	if (!mm_is_thread_local(mm))
-		_tlbie_va(vmaddr, pid, ap, RIC_FLUSH_TLB);
+		_tlbie_va(vmaddr, pid, psize, RIC_FLUSH_TLB);
 	else
-		_tlbiel_va(vmaddr, pid, ap, RIC_FLUSH_TLB);
+		_tlbiel_va(vmaddr, pid, psize, RIC_FLUSH_TLB);
 	preempt_enable();
 }
 
@@ -331,9 +358,7 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 				  unsigned long end, int psize)
 {
 	unsigned long pid;
-	unsigned long addr;
 	bool local;
-	unsigned long ap = mmu_get_ap(psize);
 	unsigned long page_size = 1UL << mmu_psize_defs[psize].shift;
 
 	pid = mm ? mm->context.id : 0;
@@ -350,18 +375,10 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 			_tlbie_pid(pid, RIC_FLUSH_TLB);
 
 	} else {
-		asm volatile("ptesync": : :"memory");
-		for (addr = start; addr < end; addr += page_size) {
-
-			if (local)
-				__tlbiel_va(addr, pid, ap, RIC_FLUSH_TLB);
-			else
-				__tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
-		}
 		if (local)
-			asm volatile("ptesync": : :"memory");
+			_tlbiel_va_range(start, end, pid, page_size, psize);
 		else
-			asm volatile("eieio; tlbsync; ptesync": : :"memory");
+			_tlbie_va_range(start, end, pid, page_size, psize);
 	}
 	preempt_enable();
 }
@@ -369,7 +386,6 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 {
-	unsigned long ap = mmu_get_ap(mmu_virtual_psize);
 	unsigned long pid, end;
 	bool local;
 
@@ -392,18 +408,12 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 		_tlbie_pid(pid, RIC_FLUSH_PWC);
 
 	/* Then iterate the pages */
-	asm volatile("ptesync": : :"memory");
 	end = addr + HPAGE_PMD_SIZE;
-	for (; addr < end; addr += PAGE_SIZE) {
-		if (local)
-			_tlbiel_va(addr, pid, ap, RIC_FLUSH_TLB);
-		else
-			_tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
-	}
+
 	if (local)
-		asm volatile("ptesync": : :"memory");
+		_tlbiel_va_range(addr, end, pid, PAGE_SIZE, mmu_virtual_psize);
 	else
-		asm volatile("eieio; tlbsync; ptesync": : :"memory");
+		_tlbie_va_range(addr, end, pid, PAGE_SIZE, mmu_virtual_psize);
 	preempt_enable();
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
2.13.3
