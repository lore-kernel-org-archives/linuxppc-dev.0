Return-Path: <benh@kernel.crashing.org>
Subject: [PATCH/RFC] powerpc: Pass PID argument to _tlbie (WAS: Apparent
	kernel bug with GDB on ppc405)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Mackall <mpm@selenic.com>
In-Reply-To: <1193448653.18243.9.camel@pasglop>
References: <20071024194640.GB19691@waste.org>
	<1193363202.7018.36.camel@pasglop>
	<fa686aa40710251945l51604c5vdf0b49b03b9a1a57@mail.gmail.com>
	<1193369005.7018.46.camel@pasglop> <20071026144134.GW19691@waste.org>
	<1193448653.18243.9.camel@pasglop>
Content-Type: text/plain
Date: Sat, 27 Oct 2007 17:32:02 +1000
Message-Id: <1193470322.18243.63.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Josh Boyer <jdub@us.ibm.com>,
	Kumar Gala <galak@gate.crashing.org>, linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allright, so Matt, let me know if that fixes your problem with gdb, and
I'll clean the patch up a bit and submit it. I want to double check if
something similar may be needed for freescale booke.

Basically, the problem is that things like get_user_pages() can cause
COW operations which in turn call _tlbie() to be called for translations
that aren't in the current address space.

The current 40x and 44x implementation of _tlbie doesn't handle that
properly as it only invalidates entries in the current PID.

This is an attempt at fixing it. Untested, I just checked it builds for
arch/powerpc and arch/ppc. I also haven't looked whether the freescale
BookE _tlbie needs similar treatement (it will get passed the pid in r4
with that patch, so if it needs to do something with it, it can). Kumar,
can you have a look ?

Index: linux-work/arch/powerpc/mm/fault.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/fault.c	2007-10-27 14:44:05.000000000 +1000
+++ linux-work/arch/powerpc/mm/fault.c	2007-10-27 16:57:50.000000000 +1000
@@ -309,7 +309,7 @@ good_area:
 					set_bit(PG_arch_1, &page->flags);
 				}
 				pte_update(ptep, 0, _PAGE_HWEXEC);
-				_tlbie(address);
+				_tlbie(address, mm->context.id);
 				pte_unmap_unlock(ptep, ptl);
 				up_read(&mm->mmap_sem);
 				return 0;
Index: linux-work/include/asm-powerpc/tlbflush.h
===================================================================
--- linux-work.orig/include/asm-powerpc/tlbflush.h	2007-10-27 14:44:19.000000000 +1000
+++ linux-work/include/asm-powerpc/tlbflush.h	2007-10-27 16:57:50.000000000 +1000
@@ -1,5 +1,8 @@
 #ifndef _ASM_POWERPC_TLBFLUSH_H
 #define _ASM_POWERPC_TLBFLUSH_H
+
+#include <linux/mm.h>
+
 /*
  * TLB flushing:
  *
@@ -16,9 +19,6 @@
  */
 #ifdef __KERNEL__
 
-struct mm_struct;
-struct vm_area_struct;
-
 #if defined(CONFIG_4xx) || defined(CONFIG_8xx) || defined(CONFIG_FSL_BOOKE)
 /*
  * TLB flushing for software loaded TLB chips
@@ -28,7 +28,7 @@ struct vm_area_struct;
  * specific tlbie's
  */
 
-extern void _tlbie(unsigned long address);
+extern void _tlbie(unsigned long address, unsigned int pid);
 
 #if defined(CONFIG_40x) || defined(CONFIG_8xx)
 #define _tlbia()	asm volatile ("tlbia; sync" : : : "memory")
@@ -44,13 +44,13 @@ static inline void flush_tlb_mm(struct m
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				  unsigned long vmaddr)
 {
-	_tlbie(vmaddr);
+	_tlbie(vmaddr, vma->vm_mm->context.id);
 }
 
 static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
 					 unsigned long vmaddr)
 {
-	_tlbie(vmaddr);
+	_tlbie(vmaddr, vma->vm_mm->context.id);
 }
 
 static inline void flush_tlb_range(struct vm_area_struct *vma,
Index: linux-work/arch/powerpc/kernel/misc_32.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/misc_32.S	2007-10-27 16:58:33.000000000 +1000
+++ linux-work/arch/powerpc/kernel/misc_32.S	2007-10-27 17:08:32.000000000 +1000
@@ -288,7 +288,16 @@ _GLOBAL(_tlbia)
  */
 _GLOBAL(_tlbie)
 #if defined(CONFIG_40x)
+	/* We run the search with interrupts disabled because we have to change
+	 * the PID and I don't want to preempt when that happens.
+	 */
+	mfmsr	r5
+	mfspr	r6,SPRN_PID
+	wrteei	0
+	mtspr	SPRN_PID,r4
 	tlbsx.	r3, 0, r3
+	mtspr	SPRN_PID,r6
+	wrtee	r5
 	bne	10f
 	sync
 	/* There are only 64 TLB entries, so r3 < 64, which means bit 25 is clear.
@@ -297,23 +306,23 @@ _GLOBAL(_tlbie)
 	tlbwe	r3, r3, TLB_TAG
 	isync
 10:
+
 #elif defined(CONFIG_44x)
-	mfspr	r4,SPRN_MMUCR
-	mfspr	r5,SPRN_PID			/* Get PID */
-	rlwimi	r4,r5,0,24,31			/* Set TID */
+	mfspr	r5,SPRN_MMUCR
+	rlwimi	r5,r4,0,24,31			/* Set TID */
 
 	/* We have to run the search with interrupts disabled, even critical
 	 * and debug interrupts (in fact the only critical exceptions we have
 	 * are debug and machine check).  Otherwise  an interrupt which causes
 	 * a TLB miss can clobber the MMUCR between the mtspr and the tlbsx. */
-	mfmsr	r5
+	mfmsr	r4
 	lis	r6,(MSR_EE|MSR_CE|MSR_ME|MSR_DE)@ha
 	addi	r6,r6,(MSR_EE|MSR_CE|MSR_ME|MSR_DE)@l
-	andc	r6,r5,r6
+	andc	r6,r4,r6
 	mtmsr	r6
-	mtspr	SPRN_MMUCR,r4
+	mtspr	SPRN_MMUCR,r5
 	tlbsx.	r3, 0, r3
-	mtmsr	r5
+	mtmsr	r4
 	bne	10f
 	sync
 	/* There are only 64 TLB entries, so r3 < 64,
Index: linux-work/arch/powerpc/mm/mmu_decl.h
===================================================================
--- linux-work.orig/arch/powerpc/mm/mmu_decl.h	2007-10-27 17:11:33.000000000 +1000
+++ linux-work/arch/powerpc/mm/mmu_decl.h	2007-10-27 17:11:58.000000000 +1000
@@ -61,12 +61,12 @@ extern unsigned long total_lowmem;
 #define mmu_mapin_ram()		(0UL)
 
 #elif defined(CONFIG_4xx)
-#define flush_HPTE(X, va, pg)	_tlbie(va)
+#define flush_HPTE(pid, va, pg)	_tlbie(va, pid)
 extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(void);
 
 #elif defined(CONFIG_FSL_BOOKE)
-#define flush_HPTE(X, va, pg)	_tlbie(va)
+#define flush_HPTE(pid, va, pg)	_tlbie(va, pid)
 extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(void);
 extern void adjust_total_lowmem(void);
Index: linux-work/arch/ppc/kernel/misc.S
===================================================================
--- linux-work.orig/arch/ppc/kernel/misc.S	2007-10-27 17:15:25.000000000 +1000
+++ linux-work/arch/ppc/kernel/misc.S	2007-10-27 17:15:59.000000000 +1000
@@ -224,7 +224,16 @@ _GLOBAL(_tlbia)
  */
 _GLOBAL(_tlbie)
 #if defined(CONFIG_40x)
+	/* We run the search with interrupts disabled because we have to change
+	 * the PID and I don't want to preempt when that happens.
+	 */
+	mfmsr	r5
+	mfspr	r6,SPRN_PID
+	wrteei	0
+	mtspr	SPRN_PID,r4
 	tlbsx.	r3, 0, r3
+	mtspr	SPRN_PID,r6
+	wrtee	r5
 	bne	10f
 	sync
 	/* There are only 64 TLB entries, so r3 < 64, which means bit 25 is clear.
@@ -234,22 +243,21 @@ _GLOBAL(_tlbie)
 	isync
 10:
 #elif defined(CONFIG_44x)
-	mfspr	r4,SPRN_MMUCR
-	mfspr	r5,SPRN_PID			/* Get PID */
-	rlwimi	r4,r5,0,24,31			/* Set TID */
+	mfspr	r5,SPRN_MMUCR
+	rlwimi	r5,r4,0,24,31			/* Set TID */
 
 	/* We have to run the search with interrupts disabled, even critical
 	 * and debug interrupts (in fact the only critical exceptions we have
 	 * are debug and machine check).  Otherwise  an interrupt which causes
 	 * a TLB miss can clobber the MMUCR between the mtspr and the tlbsx. */
-	mfmsr	r5
+	mfmsr	r4
 	lis	r6,(MSR_EE|MSR_CE|MSR_ME|MSR_DE)@ha
 	addi	r6,r6,(MSR_EE|MSR_CE|MSR_ME|MSR_DE)@l
-	andc	r6,r5,r6
+	andc	r6,r4,r6
 	mtmsr	r6
-	mtspr	SPRN_MMUCR,r4
+	mtspr	SPRN_MMUCR,r5
 	tlbsx.	r3, 0, r3
-	mtmsr	r5
+	mtmsr	r4
 	bne	10f
 	sync
 	/* There are only 64 TLB entries, so r3 < 64,
Index: linux-work/arch/ppc/mm/fault.c
===================================================================
--- linux-work.orig/arch/ppc/mm/fault.c	2007-10-27 17:14:09.000000000 +1000
+++ linux-work/arch/ppc/mm/fault.c	2007-10-27 17:14:13.000000000 +1000
@@ -227,7 +227,7 @@ good_area:
 					set_bit(PG_arch_1, &page->flags);
 				}
 				pte_update(ptep, 0, _PAGE_HWEXEC);
-				_tlbie(address);
+				_tlbie(address, mm->context.id);
 				pte_unmap_unlock(ptep, ptl);
 				up_read(&mm->mmap_sem);
 				return 0;
Index: linux-work/arch/ppc/mm/mmu_decl.h
===================================================================
--- linux-work.orig/arch/ppc/mm/mmu_decl.h	2007-10-27 17:14:43.000000000 +1000
+++ linux-work/arch/ppc/mm/mmu_decl.h	2007-10-27 17:14:54.000000000 +1000
@@ -54,12 +54,12 @@ extern unsigned int num_tlbcam_entries;
 #define mmu_mapin_ram()		(0UL)
 
 #elif defined(CONFIG_4xx)
-#define flush_HPTE(X, va, pg)	_tlbie(va)
+#define flush_HPTE(pid, va, pg)	_tlbie(va, pid)
 extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(void);
 
 #elif defined(CONFIG_FSL_BOOKE)
-#define flush_HPTE(X, va, pg)	_tlbie(va)
+#define flush_HPTE(pid, va, pg)	_tlbie(va, pid)
 extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(void);
 extern void adjust_total_lowmem(void);
Index: linux-work/arch/ppc/platforms/4xx/ebony.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/4xx/ebony.c	2007-10-27 17:13:38.000000000 +1000
+++ linux-work/arch/ppc/platforms/4xx/ebony.c	2007-10-27 17:13:40.000000000 +1000
@@ -236,7 +236,7 @@ ebony_early_serial_map(void)
 	gen550_init(0, &port);
 
 	/* Purge TLB entry added in head_44x.S for early serial access */
-	_tlbie(UART0_IO_BASE);
+	_tlbie(UART0_IO_BASE, 0);
 #endif
 
 	port.membase = ioremap64(PPC440GP_UART1_ADDR, 8);
Index: linux-work/arch/ppc/platforms/4xx/ocotea.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/4xx/ocotea.c	2007-10-27 17:13:26.000000000 +1000
+++ linux-work/arch/ppc/platforms/4xx/ocotea.c	2007-10-27 17:13:28.000000000 +1000
@@ -259,7 +259,7 @@ ocotea_early_serial_map(void)
 	gen550_init(0, &port);
 
 	/* Purge TLB entry added in head_44x.S for early serial access */
-	_tlbie(UART0_IO_BASE);
+	_tlbie(UART0_IO_BASE, 0);
 #endif
 
 	port.membase = ioremap64(PPC440GX_UART1_ADDR, 8);
Index: linux-work/arch/ppc/platforms/4xx/taishan.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/4xx/taishan.c	2007-10-27 17:13:47.000000000 +1000
+++ linux-work/arch/ppc/platforms/4xx/taishan.c	2007-10-27 17:13:50.000000000 +1000
@@ -316,7 +316,7 @@ taishan_early_serial_map(void)
 	gen550_init(0, &port);
 
 	/* Purge TLB entry added in head_44x.S for early serial access */
-	_tlbie(UART0_IO_BASE);
+	_tlbie(UART0_IO_BASE, 0);
 #endif
 
 	port.membase = ioremap64(PPC440GX_UART1_ADDR, 8);
