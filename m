Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 25096B7CD7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 19:15:39 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 24 Jul 2009 19:15:24 +1000
Subject: [PATCH 8/20] powerpc/mm: Make low level TLB flush ops on BookE take
	additional args (v2)
In-Reply-To: <1248426902.401617.944220131651.qpush@grosgo>
Message-Id: <20090724091539.15CCCDDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to pass down whether the page is direct or indirect and we'll
need to pass the page size to _tlbil_va and _tlbivax_bcast

We also add a new low level _tlbil_pid_noind() which does a TLB flush
by PID but avoids flushing indirect entries if possible

This implements those new prototypes but defines them with inlines
or macros so that no additional arguments are actually passed on current
processors.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2. __tlbil_va() declaration had the wrong number of arguments
    also remove a stray trailing semicolon

 arch/powerpc/include/asm/tlbflush.h |   11 +++++++--
 arch/powerpc/mm/mmu_decl.h          |   16 +++++++++++--
 arch/powerpc/mm/tlb_nohash.c        |   42 ++++++++++++++++++++++++++----------
 arch/powerpc/mm/tlb_nohash_low.S    |    6 ++---
 4 files changed, 56 insertions(+), 19 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/tlbflush.h	2009-07-24 16:24:08.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/tlbflush.h	2009-07-24 16:24:12.000000000 +1000
@@ -6,7 +6,7 @@
  *
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
  *  - flush_tlb_page(vma, vmaddr) flushes one page
- *  - local_flush_tlb_mm(mm) flushes the specified mm context on
+ *  - local_flush_tlb_mm(mm, full) flushes the specified mm context on
  *                           the local processor
  *  - local_flush_tlb_page(vma, vmaddr) flushes one page on the local processor
  *  - flush_tlb_page_nohash(vma, vmaddr) flushes one page if SW loaded TLB
@@ -29,7 +29,8 @@
  * specific tlbie's
  */
 
-#include <linux/mm.h>
+struct vm_area_struct;
+struct mm_struct;
 
 #define MMU_NO_CONTEXT      	((unsigned int)-1)
 
@@ -40,12 +41,18 @@ extern void flush_tlb_kernel_range(unsig
 extern void local_flush_tlb_mm(struct mm_struct *mm);
 extern void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 
+extern void __local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
+				   int tsize, int ind);
+
 #ifdef CONFIG_SMP
 extern void flush_tlb_mm(struct mm_struct *mm);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
+extern void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
+			     int tsize, int ind);
 #else
 #define flush_tlb_mm(mm)		local_flush_tlb_mm(mm)
 #define flush_tlb_page(vma,addr)	local_flush_tlb_page(vma,addr)
+#define __flush_tlb_page(mm,addr,p,i)	__local_flush_tlb_page(mm,addr,p,i)
 #endif
 #define flush_tlb_page_nohash(vma,addr)	flush_tlb_page(vma,addr)
 
Index: linux-work/arch/powerpc/mm/mmu_decl.h
===================================================================
--- linux-work.orig/arch/powerpc/mm/mmu_decl.h	2009-07-24 16:24:08.000000000 +1000
+++ linux-work/arch/powerpc/mm/mmu_decl.h	2009-07-24 17:04:57.000000000 +1000
@@ -36,21 +36,30 @@ static inline void _tlbil_pid(unsigned i
 {
 	asm volatile ("sync; tlbia; isync" : : : "memory");
 }
+#define _tlbil_pid_noind(pid)	_tlbil_pid(pid)
+
 #else /* CONFIG_40x || CONFIG_8xx */
 extern void _tlbil_all(void);
 extern void _tlbil_pid(unsigned int pid);
+#define _tlbil_pid_noind(pid)	_tlbil_pid(pid)
 #endif /* !(CONFIG_40x || CONFIG_8xx) */
 
 /*
  * On 8xx, we directly inline tlbie, on others, it's extern
  */
 #ifdef CONFIG_8xx
-static inline void _tlbil_va(unsigned long address, unsigned int pid)
+static inline void _tlbil_va(unsigned long address, unsigned int pid,
+			     unsigned int tsize, unsigned int ind)
 {
 	asm volatile ("tlbie %0; sync" : : "r" (address) : "memory");
 }
 #else /* CONFIG_8xx */
-extern void _tlbil_va(unsigned long address, unsigned int pid);
+extern void __tlbil_va(unsigned long address, unsigned int pid);
+static inline void _tlbil_va(unsigned long address, unsigned int pid,
+			     unsigned int tsize, unsigned int ind)
+{
+	__tlbil_va(address, pid);
+}
 #endif /* CONIFG_8xx */
 
 /*
@@ -58,7 +67,8 @@ extern void _tlbil_va(unsigned long addr
  * implementation. When that becomes the case, this will be
  * an extern.
  */
-static inline void _tlbivax_bcast(unsigned long address, unsigned int pid)
+static inline void _tlbivax_bcast(unsigned long address, unsigned int pid,
+				   unsigned int tsize, unsigned int ind)
 {
 	BUG();
 }
Index: linux-work/arch/powerpc/mm/tlb_nohash.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/tlb_nohash.c	2009-07-24 16:24:08.000000000 +1000
+++ linux-work/arch/powerpc/mm/tlb_nohash.c	2009-07-24 17:41:33.000000000 +1000
@@ -67,18 +67,24 @@ void local_flush_tlb_mm(struct mm_struct
 }
 EXPORT_SYMBOL(local_flush_tlb_mm);
 
-void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+void __local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
+			    int tsize, int ind)
 {
 	unsigned int pid;
 
 	preempt_disable();
-	pid = vma ? vma->vm_mm->context.id : 0;
+	pid = mm ? mm->context.id : 0;
 	if (pid != MMU_NO_CONTEXT)
-		_tlbil_va(vmaddr, pid);
+		_tlbil_va(vmaddr, pid, tsize, ind);
 	preempt_enable();
 }
-EXPORT_SYMBOL(local_flush_tlb_page);
 
+void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+{
+	__local_flush_tlb_page(vma ? vma->vm_mm : NULL, vmaddr,
+			       0 /* tsize unused for now */, 0);
+}
+EXPORT_SYMBOL(local_flush_tlb_page);
 
 /*
  * And here are the SMP non-local implementations
@@ -96,6 +102,8 @@ static int mm_is_core_local(struct mm_st
 struct tlb_flush_param {
 	unsigned long addr;
 	unsigned int pid;
+	unsigned int tsize;
+	unsigned int ind;
 };
 
 static void do_flush_tlb_mm_ipi(void *param)
@@ -109,7 +117,7 @@ static void do_flush_tlb_page_ipi(void *
 {
 	struct tlb_flush_param *p = param;
 
-	_tlbil_va(p->addr, p->pid);
+	_tlbil_va(p->addr, p->pid, p->tsize, p->ind);
 }
 
 
@@ -149,37 +157,49 @@ void flush_tlb_mm(struct mm_struct *mm)
 }
 EXPORT_SYMBOL(flush_tlb_mm);
 
-void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
+		      int tsize, int ind)
 {
 	struct cpumask *cpu_mask;
 	unsigned int pid;
 
 	preempt_disable();
-	pid = vma ? vma->vm_mm->context.id : 0;
+	pid = mm ? mm->context.id : 0;
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto bail;
-	cpu_mask = mm_cpumask(vma->vm_mm);
+	cpu_mask = mm_cpumask(mm);
 	if (!mm_is_core_local(mm)) {
 		/* If broadcast tlbivax is supported, use it */
 		if (mmu_has_feature(MMU_FTR_USE_TLBIVAX_BCAST)) {
 			int lock = mmu_has_feature(MMU_FTR_LOCK_BCAST_INVAL);
 			if (lock)
 				spin_lock(&tlbivax_lock);
-			_tlbivax_bcast(vmaddr, pid);
+			_tlbivax_bcast(vmaddr, pid, tsize, ind);
 			if (lock)
 				spin_unlock(&tlbivax_lock);
 			goto bail;
 		} else {
-			struct tlb_flush_param p = { .pid = pid, .addr = vmaddr };
+			struct tlb_flush_param p = {
+				.pid = pid,
+				.addr = vmaddr,
+				.tsize = tsize,
+				.ind = ind,
+			};
 			/* Ignores smp_processor_id() even if set in cpu_mask */
 			smp_call_function_many(cpu_mask,
 					       do_flush_tlb_page_ipi, &p, 1);
 		}
 	}
-	_tlbil_va(vmaddr, pid);
+	_tlbil_va(vmaddr, pid, tsize, ind);
  bail:
 	preempt_enable();
 }
+
+void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+{
+	__flush_tlb_page(vma ? vma->vm_mm : NULL, vmaddr,
+			 0 /* tsize unused for now */, 0);
+}
 EXPORT_SYMBOL(flush_tlb_page);
 
 #endif /* CONFIG_SMP */
Index: linux-work/arch/powerpc/mm/tlb_nohash_low.S
===================================================================
--- linux-work.orig/arch/powerpc/mm/tlb_nohash_low.S	2009-07-24 16:24:08.000000000 +1000
+++ linux-work/arch/powerpc/mm/tlb_nohash_low.S	2009-07-24 17:04:57.000000000 +1000
@@ -39,7 +39,7 @@
 /*
  * 40x implementation needs only tlbil_va
  */
-_GLOBAL(_tlbil_va)
+_GLOBAL(__tlbil_va)
 	/* We run the search with interrupts disabled because we have to change
 	 * the PID and I don't want to preempt when that happens.
 	 */
@@ -71,7 +71,7 @@ _GLOBAL(_tlbil_va)
  * 440 implementation uses tlbsx/we for tlbil_va and a full sweep
  * of the TLB for everything else.
  */
-_GLOBAL(_tlbil_va)
+_GLOBAL(__tlbil_va)
 	mfspr	r5,SPRN_MMUCR
 	rlwimi	r5,r4,0,24,31			/* Set TID */
 
@@ -170,7 +170,7 @@ ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_US
  * Flush MMU TLB for a particular address, but only on the local processor
  * (no broadcast)
  */
-_GLOBAL(_tlbil_va)
+_GLOBAL(__tlbil_va)
 	mfmsr	r10
 	wrteei	0
 	slwi	r4,r4,16
