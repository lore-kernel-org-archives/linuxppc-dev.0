Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 19 Dec 2008 16:13:42 +1100
Subject: [PATCH 6/10] powerpc/mm: Split low level tlb invalidate for nohash
	processors
In-Reply-To: <1229663599.904385.502157196243.qpush@grosgo>
Message-Id: <20081219051447.9CA3EDDF85@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, the various forms of low level TLB invalidations are all
implemented in misc_32.S for 32-bit processors, in a fairly scary
mess of #ifdef's and with interesting duplication such as a whole
bunch of code for FSL _tlbie and _tlbia which are no longer used.

This moves things around such that _tlbie is now defined in
hash_low_32.S and is only used by the 32-bit hash code, and all
nohash CPUs use the various _tlbil_* forms that are now moved to
a new file, tlb_nohash_low.S.

I moved all the definitions for that stuff out of include/asm/tlbflush.h as
they are really internal mm stuff, into mm/mmu_decl.h

The code should have no functional changes. I kept some variants
inline for trivial forms on things like 40x and 8xx. 

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/tlbflush.h |   14 --
 arch/powerpc/kernel/misc_32.S       |  233 ------------------------------------
 arch/powerpc/kvm/powerpc.c          |    2 
 arch/powerpc/mm/Makefile            |    3 
 arch/powerpc/mm/hash_low_32.S       |   76 +++++++++++
 arch/powerpc/mm/mmu_decl.h          |   48 +++++++
 arch/powerpc/mm/tlb_nohash_low.S    |  165 +++++++++++++++++++++++++
 7 files changed, 292 insertions(+), 249 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/tlbflush.h	2008-12-15 15:46:23.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/tlbflush.h	2008-12-15 15:46:56.000000000 +1100
@@ -33,17 +33,6 @@
 
 #define MMU_NO_CONTEXT      	((unsigned int)-1)
 
-extern void _tlbil_all(void);
-extern void _tlbil_pid(unsigned int pid);
-extern void _tlbil_va(unsigned long address, unsigned int pid);
-extern void _tlbivax_bcast(unsigned long address, unsigned int pid);
-
-#if defined(CONFIG_40x) || defined(CONFIG_8xx)
-#define _tlbia()	asm volatile ("tlbia; sync" : : : "memory")
-#else /* CONFIG_44x || CONFIG_FSL_BOOKE */
-extern void _tlbia(void);
-#endif
-
 extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			    unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
@@ -65,9 +54,6 @@ extern void flush_tlb_page(struct vm_are
 /*
  * TLB flushing for "classic" hash-MMU 32-bit CPUs, 6xx, 7xx, 7xxx
  */
-extern void _tlbie(unsigned long address);
-extern void _tlbia(void);
-
 extern void flush_tlb_mm(struct mm_struct *mm);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 extern void flush_tlb_page_nohash(struct vm_area_struct *vma, unsigned long addr);
Index: linux-work/arch/powerpc/mm/mmu_decl.h
===================================================================
--- linux-work.orig/arch/powerpc/mm/mmu_decl.h	2008-12-15 15:46:23.000000000 +1100
+++ linux-work/arch/powerpc/mm/mmu_decl.h	2008-12-15 15:46:56.000000000 +1100
@@ -22,10 +22,58 @@
 #include <asm/tlbflush.h>
 #include <asm/mmu.h>
 
+#ifdef CONFIG_PPC_MMU_NOHASH
+
+/*
+ * On 40x and 8xx, we directly inline tlbia and tlbivax
+ */
+#if defined(CONFIG_40x) || defined(CONFIG_8xx)
+static inline void _tlbil_all(void)
+{
+	asm volatile ("sync; tlbia; isync" : : : "memory")
+}
+static inline void _tlbil_pid(unsigned int pid)
+{
+	asm volatile ("sync; tlbia; isync" : : : "memory")
+}
+#else /* CONFIG_40x || CONFIG_8xx */
+extern void _tlbil_all(void);
+extern void _tlbil_pid(unsigned int pid);
+#endif /* !(CONFIG_40x || CONFIG_8xx) */
+
+/*
+ * On 8xx, we directly inline tlbie, on others, it's extern
+ */
+#ifdef CONFIG_8xx
+static inline void _tlbil_va(unsigned long address, unsigned int pid)
+{
+	asm volatile ("tlbie %0; sync" : : "r" (address) : "memory")
+}
+#else /* CONFIG_8xx */
+extern void _tlbil_va(unsigned long address, unsigned int pid);
+#endif /* CONIFG_8xx */
+
+/*
+ * As of today, we don't support tlbivax broadcast on any
+ * implementation. When that becomes the case, this will be
+ * an extern.
+ */
+static inline void _tlbivax_bcast(unsigned long address, unsigned int pid)
+{
+	BUG();
+}
+
+#else /* CONFIG_PPC_MMU_NOHASH */
+
 extern void hash_preload(struct mm_struct *mm, unsigned long ea,
 			 unsigned long access, unsigned long trap);
 
 
+extern void _tlbie(unsigned long address);
+extern void _tlbia(void);
+
+#endif /* CONFIG_PPC_MMU_NOHASH */
+
 #ifdef CONFIG_PPC32
 extern void mapin_ram(void);
 extern int map_page(unsigned long va, phys_addr_t pa, int flags);
Index: linux-work/arch/powerpc/mm/tlb_nohash_low.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/mm/tlb_nohash_low.S	2008-12-15 15:47:57.000000000 +1100
@@ -0,0 +1,165 @@
+/*
+ * This file contains low-level functions for performing various
+ * types of TLB invalidations on various processors with no hash
+ * table.
+ *
+ * This file implements the following functions for all no-hash
+ * processors. Some aren't implemented for some variants. Some
+ * are inline in tlbflush.h
+ *
+ *	- tlbil_va
+ *	- tlbil_pid
+ *	- tlbil_all
+ *	- tlbivax_bcast (not yet)
+ *
+ * Code mostly moved over from misc_32.S
+ *
+ *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
+ *
+ * Partially rewritten by Cort Dougan (cort@cs.nmt.edu)
+ * Paul Mackerras, Kumar Gala and Benjamin Herrenschmidt.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <asm/reg.h>
+#include <asm/page.h>
+#include <asm/cputable.h>
+#include <asm/mmu.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/processor.h>
+
+#if defined(CONFIG_40x)
+
+/*
+ * 40x implementation needs only tlbil_va
+ */
+_GLOBAL(_tlbil_va)
+	/* We run the search with interrupts disabled because we have to change
+	 * the PID and I don't want to preempt when that happens.
+	 */
+	mfmsr	r5
+	mfspr	r6,SPRN_PID
+	wrteei	0
+	mtspr	SPRN_PID,r4
+	tlbsx.	r3, 0, r3
+	mtspr	SPRN_PID,r6
+	wrtee	r5
+	bne	1f
+	sync
+	/* There are only 64 TLB entries, so r3 < 64, which means bit 25 is
+	 * clear. Since 25 is the V bit in the TLB_TAG, loading this value
+	 * will invalidate the TLB entry. */
+	tlbwe	r3, r3, TLB_TAG
+	isync
+1:	blr
+
+#elif defined(CONFIG_8xx)
+
+/*
+ * Nothing to do for 8xx, everything is inline
+ */
+
+#elif defined(CONFIG_44x)
+
+/*
+ * 440 implementation uses tlbsx/we for tlbil_va and a full sweep
+ * of the TLB for everything else.
+ */
+_GLOBAL(_tlbil_va)
+	mfspr	r5,SPRN_MMUCR
+	rlwimi	r5,r4,0,24,31			/* Set TID */
+
+	/* We have to run the search with interrupts disabled, even critical
+	 * and debug interrupts (in fact the only critical exceptions we have
+	 * are debug and machine check).  Otherwise  an interrupt which causes
+	 * a TLB miss can clobber the MMUCR between the mtspr and the tlbsx. */
+	mfmsr	r4
+	lis	r6,(MSR_EE|MSR_CE|MSR_ME|MSR_DE)@ha
+	addi	r6,r6,(MSR_EE|MSR_CE|MSR_ME|MSR_DE)@l
+	andc	r6,r4,r6
+	mtmsr	r6
+	mtspr	SPRN_MMUCR,r5
+	tlbsx.	r3, 0, r3
+	mtmsr	r4
+	bne	1f
+	sync
+	/* There are only 64 TLB entries, so r3 < 64,
+	 * which means bit 22, is clear.  Since 22 is
+	 * the V bit in the TLB_PAGEID, loading this
+	 * value will invalidate the TLB entry.
+	 */
+	tlbwe	r3, r3, PPC44x_TLB_PAGEID
+	isync
+1:	blr
+
+_GLOBAL(_tlbil_all)
+_GLOBAL(_tlbil_pid)
+	li	r3,0
+	sync
+
+	/* Load high watermark */
+	lis	r4,tlb_44x_hwater@ha
+	lwz	r5,tlb_44x_hwater@l(r4)
+
+1:	tlbwe	r3,r3,PPC44x_TLB_PAGEID
+	addi	r3,r3,1
+	cmpw	0,r3,r5
+	ble	1b
+
+	isync
+	blr
+
+#elif defined(CONFIG_FSL_BOOKE)
+/*
+ * FSL BookE implementations. Currently _pid and _all are the
+ * same. This will change when tlbilx is actually supported and
+ * performs invalidate-by-PID. This change will be driven by
+ * mmu_features conditional
+ */
+
+/*
+ * Flush MMU TLB on the local processor
+ */
+_GLOBAL(_tlbil_pid)
+_GLOBAL(_tlbil_all)
+#define MMUCSR0_TLBFI	(MMUCSR0_TLB0FI | MMUCSR0_TLB1FI | \
+			 MMUCSR0_TLB2FI | MMUCSR0_TLB3FI)
+	li	r3,(MMUCSR0_TLBFI)@l
+	mtspr	SPRN_MMUCSR0, r3
+1:
+	mfspr	r3,SPRN_MMUCSR0
+	andi.	r3,r3,MMUCSR0_TLBFI@l
+	bne	1b
+	msync
+	isync
+	blr
+
+/*
+ * Flush MMU TLB for a particular address, but only on the local processor
+ * (no broadcast)
+ */
+_GLOBAL(_tlbil_va)
+	mfmsr	r10
+	wrteei	0
+	slwi	r4,r4,16
+	mtspr	SPRN_MAS6,r4		/* assume AS=0 for now */
+	tlbsx	0,r3
+	mfspr	r4,SPRN_MAS1		/* check valid */
+	andis.	r3,r4,MAS1_VALID@h
+	beqlr
+	rlwinm	r4,r4,0,1,31
+	mtspr	SPRN_MAS1,r4
+	tlbwe
+	msync
+	isync
+	wrtee	r10
+	blr
+#elif
+#error Unsupported processor type !
+#endif
Index: linux-work/arch/powerpc/kernel/misc_32.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/misc_32.S	2008-12-15 15:46:24.000000000 +1100
+++ linux-work/arch/powerpc/kernel/misc_32.S	2008-12-15 15:46:56.000000000 +1100
@@ -272,239 +272,6 @@ _GLOBAL(real_writeb)
 
 #endif /* CONFIG_40x */
 
-/*
- * Flush MMU TLB
- */
-#ifndef CONFIG_FSL_BOOKE
-_GLOBAL(_tlbil_all)
-_GLOBAL(_tlbil_pid)
-#endif
-_GLOBAL(_tlbia)
-#if defined(CONFIG_40x)
-	sync			/* Flush to memory before changing mapping */
-	tlbia
-	isync			/* Flush shadow TLB */
-#elif defined(CONFIG_44x)
-	li	r3,0
-	sync
-
-	/* Load high watermark */
-	lis	r4,tlb_44x_hwater@ha
-	lwz	r5,tlb_44x_hwater@l(r4)
-
-1:	tlbwe	r3,r3,PPC44x_TLB_PAGEID
-	addi	r3,r3,1
-	cmpw	0,r3,r5
-	ble	1b
-
-	isync
-#elif defined(CONFIG_FSL_BOOKE)
-	/* Invalidate all entries in TLB0 */
-	li	r3, 0x04
-	tlbivax	0,3
-	/* Invalidate all entries in TLB1 */
-	li	r3, 0x0c
-	tlbivax	0,3
-	msync
-#ifdef CONFIG_SMP
-	tlbsync
-#endif /* CONFIG_SMP */
-#else /* !(CONFIG_40x || CONFIG_44x || CONFIG_FSL_BOOKE) */
-#if defined(CONFIG_SMP)
-	rlwinm	r8,r1,0,0,(31-THREAD_SHIFT)
-	lwz	r8,TI_CPU(r8)
-	oris	r8,r8,10
-	mfmsr	r10
-	SYNC
-	rlwinm	r0,r10,0,17,15		/* clear bit 16 (MSR_EE) */
-	rlwinm	r0,r0,0,28,26		/* clear DR */
-	mtmsr	r0
-	SYNC_601
-	isync
-	lis	r9,mmu_hash_lock@h
-	ori	r9,r9,mmu_hash_lock@l
-	tophys(r9,r9)
-10:	lwarx	r7,0,r9
-	cmpwi	0,r7,0
-	bne-	10b
-	stwcx.	r8,0,r9
-	bne-	10b
-	sync
-	tlbia
-	sync
-	TLBSYNC
-	li	r0,0
-	stw	r0,0(r9)		/* clear mmu_hash_lock */
-	mtmsr	r10
-	SYNC_601
-	isync
-#else /* CONFIG_SMP */
-	sync
-	tlbia
-	sync
-#endif /* CONFIG_SMP */
-#endif /* ! defined(CONFIG_40x) */
-	blr
-
-/*
- * Flush MMU TLB for a particular address
- */
-#ifndef CONFIG_FSL_BOOKE
-_GLOBAL(_tlbil_va)
-#endif
-_GLOBAL(_tlbie)
-#if defined(CONFIG_40x)
-	/* We run the search with interrupts disabled because we have to change
-	 * the PID and I don't want to preempt when that happens.
-	 */
-	mfmsr	r5
-	mfspr	r6,SPRN_PID
-	wrteei	0
-	mtspr	SPRN_PID,r4
-	tlbsx.	r3, 0, r3
-	mtspr	SPRN_PID,r6
-	wrtee	r5
-	bne	10f
-	sync
-	/* There are only 64 TLB entries, so r3 < 64, which means bit 25 is clear.
-	 * Since 25 is the V bit in the TLB_TAG, loading this value will invalidate
-	 * the TLB entry. */
-	tlbwe	r3, r3, TLB_TAG
-	isync
-10:
-
-#elif defined(CONFIG_44x)
-	mfspr	r5,SPRN_MMUCR
-	rlwimi	r5,r4,0,24,31			/* Set TID */
-
-	/* We have to run the search with interrupts disabled, even critical
-	 * and debug interrupts (in fact the only critical exceptions we have
-	 * are debug and machine check).  Otherwise  an interrupt which causes
-	 * a TLB miss can clobber the MMUCR between the mtspr and the tlbsx. */
-	mfmsr	r4
-	lis	r6,(MSR_EE|MSR_CE|MSR_ME|MSR_DE)@ha
-	addi	r6,r6,(MSR_EE|MSR_CE|MSR_ME|MSR_DE)@l
-	andc	r6,r4,r6
-	mtmsr	r6
-	mtspr	SPRN_MMUCR,r5
-	tlbsx.	r3, 0, r3
-	mtmsr	r4
-	bne	10f
-	sync
-	/* There are only 64 TLB entries, so r3 < 64,
-	 * which means bit 22, is clear.  Since 22 is
-	 * the V bit in the TLB_PAGEID, loading this
-	 * value will invalidate the TLB entry.
-	 */
-	tlbwe	r3, r3, PPC44x_TLB_PAGEID
-	isync
-10:
-#elif defined(CONFIG_FSL_BOOKE)
-	rlwinm	r4, r3, 0, 0, 19
-	ori	r5, r4, 0x08	/* TLBSEL = 1 */
-	tlbivax	0, r4
-	tlbivax	0, r5
-	msync
-#if defined(CONFIG_SMP)
-	tlbsync
-#endif /* CONFIG_SMP */
-#else /* !(CONFIG_40x || CONFIG_44x || CONFIG_FSL_BOOKE) */
-#if defined(CONFIG_SMP)
-	rlwinm	r8,r1,0,0,(31-THREAD_SHIFT)
-	lwz	r8,TI_CPU(r8)
-	oris	r8,r8,11
-	mfmsr	r10
-	SYNC
-	rlwinm	r0,r10,0,17,15		/* clear bit 16 (MSR_EE) */
-	rlwinm	r0,r0,0,28,26		/* clear DR */
-	mtmsr	r0
-	SYNC_601
-	isync
-	lis	r9,mmu_hash_lock@h
-	ori	r9,r9,mmu_hash_lock@l
-	tophys(r9,r9)
-10:	lwarx	r7,0,r9
-	cmpwi	0,r7,0
-	bne-	10b
-	stwcx.	r8,0,r9
-	bne-	10b
-	eieio
-	tlbie	r3
-	sync
-	TLBSYNC
-	li	r0,0
-	stw	r0,0(r9)		/* clear mmu_hash_lock */
-	mtmsr	r10
-	SYNC_601
-	isync
-#else /* CONFIG_SMP */
-	tlbie	r3
-	sync
-#endif /* CONFIG_SMP */
-#endif /* ! CONFIG_40x */
-	blr
-
-#if defined(CONFIG_FSL_BOOKE)
-/*
- * Flush MMU TLB, but only on the local processor (no broadcast)
- */
-_GLOBAL(_tlbil_all)
-#define MMUCSR0_TLBFI	(MMUCSR0_TLB0FI | MMUCSR0_TLB1FI | \
-			 MMUCSR0_TLB2FI | MMUCSR0_TLB3FI)
-	li	r3,(MMUCSR0_TLBFI)@l
-	mtspr	SPRN_MMUCSR0, r3
-1:
-	mfspr	r3,SPRN_MMUCSR0
-	andi.	r3,r3,MMUCSR0_TLBFI@l
-	bne	1b
-	blr
-
-/*
- * Flush MMU TLB for a particular process id, but only on the local processor
- * (no broadcast)
- */
-_GLOBAL(_tlbil_pid)
-/* we currently do an invalidate all since we don't have per pid invalidate */
-	li	r3,(MMUCSR0_TLBFI)@l
-	mtspr	SPRN_MMUCSR0, r3
-1:
-	mfspr	r3,SPRN_MMUCSR0
-	andi.	r3,r3,MMUCSR0_TLBFI@l
-	bne	1b
-	msync
-	isync
-	blr
-
-/*
- * Flush MMU TLB for a particular address, but only on the local processor
- * (no broadcast)
- */
-_GLOBAL(_tlbil_va)
-	mfmsr	r10
-	wrteei	0
-	slwi	r4,r4,16
-	mtspr	SPRN_MAS6,r4		/* assume AS=0 for now */
-	tlbsx	0,r3
-	mfspr	r4,SPRN_MAS1		/* check valid */
-	andis.	r3,r4,MAS1_VALID@h
-	beqlr
-	rlwinm	r4,r4,0,1,31
-	mtspr	SPRN_MAS1,r4
-	tlbwe
-	msync
-	isync
-	wrtee	r10
-	blr
-#endif /* CONFIG_FSL_BOOKE */
-
-/*
- * Nobody implements this yet
- */
-_GLOBAL(_tlbivax_bcast)
-1:	trap
-	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0;
-	blr
-
 
 /*
  * Flush instruction cache.
Index: linux-work/arch/powerpc/mm/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/mm/Makefile	2008-12-15 15:46:23.000000000 +1100
+++ linux-work/arch/powerpc/mm/Makefile	2008-12-15 15:46:56.000000000 +1100
@@ -9,7 +9,8 @@ endif
 obj-y				:= fault.o mem.o pgtable.o \
 				   init_$(CONFIG_WORD_SIZE).o \
 				   pgtable_$(CONFIG_WORD_SIZE).o
-obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o
+obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
+				   tlb_nohash_low.o
 hash-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC64)		+= hash_utils_64.o \
 				   slb_low.o slb.o stab.o \
Index: linux-work/arch/powerpc/mm/hash_low_32.S
===================================================================
--- linux-work.orig/arch/powerpc/mm/hash_low_32.S	2008-12-15 15:46:24.000000000 +1100
+++ linux-work/arch/powerpc/mm/hash_low_32.S	2008-12-15 15:46:56.000000000 +1100
@@ -633,3 +633,79 @@ _GLOBAL(flush_hash_patch_B)
 	SYNC_601
 	isync
 	blr
+
+/*
+ * Flush an entry from the TLB
+ */
+_GLOBAL(_tlbie)
+#ifdef CONFIG_SMP
+	rlwinm	r8,r1,0,0,(31-THREAD_SHIFT)
+	lwz	r8,TI_CPU(r8)
+	oris	r8,r8,11
+	mfmsr	r10
+	SYNC
+	rlwinm	r0,r10,0,17,15		/* clear bit 16 (MSR_EE) */
+	rlwinm	r0,r0,0,28,26		/* clear DR */
+	mtmsr	r0
+	SYNC_601
+	isync
+	lis	r9,mmu_hash_lock@h
+	ori	r9,r9,mmu_hash_lock@l
+	tophys(r9,r9)
+10:	lwarx	r7,0,r9
+	cmpwi	0,r7,0
+	bne-	10b
+	stwcx.	r8,0,r9
+	bne-	10b
+	eieio
+	tlbie	r3
+	sync
+	TLBSYNC
+	li	r0,0
+	stw	r0,0(r9)		/* clear mmu_hash_lock */
+	mtmsr	r10
+	SYNC_601
+	isync
+#else /* CONFIG_SMP */
+	tlbie	r3
+	sync
+#endif /* CONFIG_SMP */
+	blr
+
+/*
+ * Flush the entire TLB. 603/603e only
+ */
+_GLOBAL(_tlbia)
+#if defined(CONFIG_SMP)
+	rlwinm	r8,r1,0,0,(31-THREAD_SHIFT)
+	lwz	r8,TI_CPU(r8)
+	oris	r8,r8,10
+	mfmsr	r10
+	SYNC
+	rlwinm	r0,r10,0,17,15		/* clear bit 16 (MSR_EE) */
+	rlwinm	r0,r0,0,28,26		/* clear DR */
+	mtmsr	r0
+	SYNC_601
+	isync
+	lis	r9,mmu_hash_lock@h
+	ori	r9,r9,mmu_hash_lock@l
+	tophys(r9,r9)
+10:	lwarx	r7,0,r9
+	cmpwi	0,r7,0
+	bne-	10b
+	stwcx.	r8,0,r9
+	bne-	10b
+	sync
+	tlbia
+	sync
+	TLBSYNC
+	li	r0,0
+	stw	r0,0(r9)		/* clear mmu_hash_lock */
+	mtmsr	r10
+	SYNC_601
+	isync
+#else /* CONFIG_SMP */
+	sync
+	tlbia
+	sync
+#endif /* CONFIG_SMP */
Index: linux-work/arch/powerpc/kvm/powerpc.c
===================================================================
--- linux-work.orig/arch/powerpc/kvm/powerpc.c	2008-12-15 15:46:24.000000000 +1100
+++ linux-work/arch/powerpc/kvm/powerpc.c	2008-12-15 15:46:56.000000000 +1100
@@ -330,7 +330,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *
 	/* XXX It would be nice to differentiate between heavyweight exit and
 	 * sched_out here, since we could avoid the TLB flush for heavyweight
 	 * exits. */
-	_tlbia();
+	_tlbil_all();
 }
 
 int kvm_arch_vcpu_ioctl_debug_guest(struct kvm_vcpu *vcpu,
