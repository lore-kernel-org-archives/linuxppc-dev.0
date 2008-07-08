Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 08 Jul 2008 15:54:40 +1000
Subject: [PATCH] powerpc: rework 4xx PTE access and TLB miss
Message-Id: <20080708055449.EDFDADDEF5@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is some preliminary work to improve TLB management on SW loaded
TLB powerpc platforms. This introduce support for non-atomic PTE
operations in pgtable-ppc32.h and removes write back to the PTE from
the TLB miss handlers. In addition, the DSI interrupt code no longer
tries to fixup write permission, this is left to generic code, and
_PAGE_HWWRITE is gone.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This is a first step, plan is to do the same for FSL BookE, 405 and
possibly 8xx too. From there, I want to rework a bit the execute
permission handling to avoid multiple faults, add support for
_PAGE_EXEC (no executable mappings), for prefaulting (especially
for kmap) and proper SMP support for future SMP capable BookE
platforms.

v2. This version fixes a couple of typos, add a few comments and
change use of flush_instruction_cache() to flush_icache_range()
which will be more appropriate if there is ever an SMP variant.

v3. Relying on the generic code to fixup _PAGE_ACCESSED doesn't
work for exec faults because our cache coherency code in
do_page_fault() will never go all the way to the generic code
for these. We fix it up by always setting _PAGE_ACCESSED when
setting _PAGE_HWEXEC in there.
This version of the patch is rebased on top of -next

 arch/powerpc/kernel/head_44x.S      |  286 ++++++++++++------------------------
 arch/powerpc/kernel/head_booke.h    |    8 +
 arch/powerpc/mm/44x_mmu.c           |   29 +++
 arch/powerpc/mm/fault.c             |    3 
 include/asm-powerpc/pgtable-ppc32.h |   61 +++++--
 5 files changed, 180 insertions(+), 207 deletions(-)

--- linux-work-next.orig/arch/powerpc/kernel/head_44x.S	2008-07-07 14:27:30.000000000 +1000
+++ linux-work-next/arch/powerpc/kernel/head_44x.S	2008-07-08 11:30:54.000000000 +1000
@@ -293,119 +293,9 @@ interrupt_base:
 	MCHECK_EXCEPTION(0x0210, MachineCheckA, machine_check_exception)
 
 	/* Data Storage Interrupt */
-	START_EXCEPTION(DataStorage)
-	mtspr	SPRN_SPRG0, r10		/* Save some working registers */
-	mtspr	SPRN_SPRG1, r11
-	mtspr	SPRN_SPRG4W, r12
-	mtspr	SPRN_SPRG5W, r13
-	mfcr	r11
-	mtspr	SPRN_SPRG7W, r11
-
-	/*
-	 * Check if it was a store fault, if not then bail
-	 * because a user tried to access a kernel or
-	 * read-protected page.  Otherwise, get the
-	 * offending address and handle it.
-	 */
-	mfspr	r10, SPRN_ESR
-	andis.	r10, r10, ESR_ST@h
-	beq	2f
-
-	mfspr	r10, SPRN_DEAR		/* Get faulting address */
-
-	/* If we are faulting a kernel address, we have to use the
-	 * kernel page tables.
-	 */
-	lis	r11, PAGE_OFFSET@h
-	cmplw	r10, r11
-	blt+	3f
-	lis	r11, swapper_pg_dir@h
-	ori	r11, r11, swapper_pg_dir@l
-
-	mfspr   r12,SPRN_MMUCR
-	rlwinm	r12,r12,0,0,23		/* Clear TID */
-
-	b	4f
-
-	/* Get the PGD for the current thread */
-3:
-	mfspr	r11,SPRN_SPRG3
-	lwz	r11,PGDIR(r11)
-
-	/* Load PID into MMUCR TID */
-	mfspr	r12,SPRN_MMUCR		/* Get MMUCR */
-	mfspr   r13,SPRN_PID		/* Get PID */
-	rlwimi	r12,r13,0,24,31		/* Set TID */
-
-4:
-	mtspr   SPRN_MMUCR,r12
-
-	rlwinm  r12, r10, 13, 19, 29    /* Compute pgdir/pmd offset */
-	lwzx    r11, r12, r11           /* Get pgd/pmd entry */
-	rlwinm. r12, r11, 0, 0, 20      /* Extract pt base address */
-	beq     2f                      /* Bail if no table */
-
-	rlwimi  r12, r10, 23, 20, 28    /* Compute pte address */
-	lwz     r11, 4(r12)             /* Get pte entry */
-
-	andi.	r13, r11, _PAGE_RW	/* Is it writeable? */
-	beq	2f			/* Bail if not */
-
-	/* Update 'changed'.
-	*/
-	ori	r11, r11, _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE
-	stw	r11, 4(r12)		/* Update Linux page table */
-
-	li	r13, PPC44x_TLB_SR@l	/* Set SR */
-	rlwimi	r13, r11, 29, 29, 29	/* SX = _PAGE_HWEXEC */
-	rlwimi	r13, r11, 0, 30, 30	/* SW = _PAGE_RW */
-	rlwimi	r13, r11, 29, 28, 28	/* UR = _PAGE_USER */
-	rlwimi	r12, r11, 31, 26, 26	/* (_PAGE_USER>>1)->r12 */
-	rlwimi	r12, r11, 29, 30, 30	/* (_PAGE_USER>>3)->r12 */
-	and	r12, r12, r11		/* HWEXEC/RW & USER */
-	rlwimi	r13, r12, 0, 26, 26	/* UX = HWEXEC & USER */
-	rlwimi	r13, r12, 3, 27, 27	/* UW = RW & USER */
-
-	rlwimi	r11,r13,0,26,31		/* Insert static perms */
-
-	/*
-	 * Clear U0-U3 and WL1 IL1I IL1D IL2I IL2D bits which are added
-	 * on newer 440 cores like the 440x6 used on AMCC 460EX/460GT (see
-	 * include/asm-powerpc/pgtable-ppc32.h for details).
-	 */
-	rlwinm	r11,r11,0,20,10
-
-	/* find the TLB index that caused the fault.  It has to be here. */
-	tlbsx	r10, 0, r10
-
-	tlbwe	r11, r10, PPC44x_TLB_ATTRIB	/* Write ATTRIB */
-
-	/* Done...restore registers and get out of here.
-	*/
-	mfspr	r11, SPRN_SPRG7R
-	mtcr	r11
-	mfspr	r13, SPRN_SPRG5R
-	mfspr	r12, SPRN_SPRG4R
+	DATA_STORAGE_EXCEPTION
 
-	mfspr	r11, SPRN_SPRG1
-	mfspr	r10, SPRN_SPRG0
-	rfi			/* Force context change */
-
-2:
-	/*
-	 * The bailout.  Restore registers to pre-exception conditions
-	 * and call the heavyweights to help us out.
-	 */
-	mfspr	r11, SPRN_SPRG7R
-	mtcr	r11
-	mfspr	r13, SPRN_SPRG5R
-	mfspr	r12, SPRN_SPRG4R
-
-	mfspr	r11, SPRN_SPRG1
-	mfspr	r10, SPRN_SPRG0
-	b	data_access
-
-	/* Instruction Storage Interrupt */
+		/* Instruction Storage Interrupt */
 	INSTRUCTION_STORAGE_EXCEPTION
 
 	/* External Input Interrupt */
@@ -423,7 +313,6 @@ interrupt_base:
 #else
 	EXCEPTION(0x2010, FloatingPointUnavailable, unknown_exception, EXC_XFER_EE)
 #endif
-
 	/* System Call Interrupt */
 	START_EXCEPTION(SystemCall)
 	NORMAL_EXCEPTION_PROLOG
@@ -484,18 +373,57 @@ interrupt_base:
 4:
 	mtspr	SPRN_MMUCR,r12
 
+	/* Mask of required permission bits. Note that while we
+	 * do copy ESR:ST to _PAGE_RW position as trying to write
+	 * to an RO page is pretty common, we don't do it with
+	 * _PAGE_DIRTY. We could do it, but it's a fairly rare
+	 * event so I'd rather take the overhead when it happens
+	 * rather than adding an instruction here. We should measure
+	 * whether the whole thing is worth it in the first place
+	 * as we could avoid loading SPRN_ESR completely in the first
+	 * place...
+	 *
+	 * TODO: Is it worth doing that mfspr & rlwimi in the first
+	 *       place or can we save a couple of instructions here ?
+	 */
+	mfspr	r12,SPRN_ESR
+	li	r13,_PAGE_PRESENT|_PAGE_ACCESSED
+	rlwimi	r13,r12,10,30,30
+
+	/* Load the PTE */
 	rlwinm 	r12, r10, 13, 19, 29	/* Compute pgdir/pmd offset */
 	lwzx	r11, r12, r11		/* Get pgd/pmd entry */
 	rlwinm.	r12, r11, 0, 0, 20	/* Extract pt base address */
 	beq	2f			/* Bail if no table */
 
 	rlwimi	r12, r10, 23, 20, 28	/* Compute pte address */
-	lwz	r11, 4(r12)		/* Get pte entry */
-	andi.	r13, r11, _PAGE_PRESENT	/* Is the page present? */
-	beq	2f			/* Bail if not present */
+	lwz	r11, 0(r12)		/* Get high word of pte entry */
+	lwz	r12, 4(r12)		/* Get low word of pte entry */
+
+	lis	r10,tlb_44x_index@ha
+
+	andc.	r13,r13,r12		/* Check permission */
+
+	/* Load the next available TLB index */
+	lwz	r13,tlb_44x_index@l(r10)
 
-	ori	r11, r11, _PAGE_ACCESSED
-	stw	r11, 4(r12)
+	bne	2f			/* Bail if permission mismach */
+
+	/* Increment, rollover, and store TLB index */
+	addi	r13,r13,1
+
+	/* Compare with watermark (instruction gets patched) */
+	.globl tlb_44x_patch_hwater_D
+tlb_44x_patch_hwater_D:
+	cmpwi	0,r13,1			/* reserve entries */
+	ble	5f
+	li	r13,0
+5:
+	/* Store the next available TLB index */
+	stw	r13,tlb_44x_index@l(r10)
+
+	/* Re-load the faulting address */
+	mfspr	r10,SPRN_DEAR
 
 	 /* Jump to common tlb load */
 	b	finish_tlb_load
@@ -510,7 +438,7 @@ interrupt_base:
 	mfspr	r12, SPRN_SPRG4R
 	mfspr	r11, SPRN_SPRG1
 	mfspr	r10, SPRN_SPRG0
-	b	data_access
+	b	DataStorage
 
 	/* Instruction TLB Error Interrupt */
 	/*
@@ -554,18 +482,42 @@ interrupt_base:
 4:
 	mtspr	SPRN_MMUCR,r12
 
+	/* Make up the required permissions */
+	li	r13,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_HWEXEC
+
 	rlwinm	r12, r10, 13, 19, 29	/* Compute pgdir/pmd offset */
 	lwzx	r11, r12, r11		/* Get pgd/pmd entry */
 	rlwinm.	r12, r11, 0, 0, 20	/* Extract pt base address */
 	beq	2f			/* Bail if no table */
 
 	rlwimi	r12, r10, 23, 20, 28	/* Compute pte address */
-	lwz	r11, 4(r12)		/* Get pte entry */
-	andi.	r13, r11, _PAGE_PRESENT	/* Is the page present? */
-	beq	2f			/* Bail if not present */
+	lwz	r11, 0(r12)		/* Get high word of pte entry */
+	lwz	r12, 4(r12)		/* Get low word of pte entry */
 
-	ori	r11, r11, _PAGE_ACCESSED
-	stw	r11, 4(r12)
+	lis	r10,tlb_44x_index@ha
+
+	andc.	r13,r13,r12		/* Check permission */
+
+	/* Load the next available TLB index */
+	lwz	r13,tlb_44x_index@l(r10)
+
+	bne	2f			/* Bail if permission mismach */
+
+	/* Increment, rollover, and store TLB index */
+	addi	r13,r13,1
+
+	/* Compare with watermark (instruction gets patched) */
+	.globl tlb_44x_patch_hwater_I
+tlb_44x_patch_hwater_I:
+	cmpwi	0,r13,1			/* reserve entries */
+	ble	5f
+	li	r13,0
+5:
+	/* Store the next available TLB index */
+	stw	r13,tlb_44x_index@l(r10)
+
+	/* Re-load the faulting address */
+	mfspr	r10,SPRN_SRR0
 
 	/* Jump to common TLB load point */
 	b	finish_tlb_load
@@ -587,86 +539,40 @@ interrupt_base:
 
 /*
  * Local functions
- */
-	/*
-	 * Data TLB exceptions will bail out to this point
-	 * if they can't resolve the lightweight TLB fault.
-	 */
-data_access:
-	NORMAL_EXCEPTION_PROLOG
-	mfspr	r5,SPRN_ESR		/* Grab the ESR, save it, pass arg3 */
-	stw	r5,_ESR(r11)
-	mfspr	r4,SPRN_DEAR		/* Grab the DEAR, save it, pass arg2 */
-	EXC_XFER_EE_LITE(0x0300, handle_page_fault)
+  */
 
 /*
 
  * Both the instruction and data TLB miss get to this
  * point to load the TLB.
  * 	r10 - EA of fault
- * 	r11 - available to use
- *	r12 - Pointer to the 64-bit PTE
- *	r13 - available to use
+ * 	r11 - PTE high word value
+ *	r12 - PTE low word value
+ *	r13 - TLB index
  *	MMUCR - loaded with proper value when we get here
  *	Upon exit, we reload everything and RFI.
  */
 finish_tlb_load:
-	/*
-	 * We set execute, because we don't have the granularity to
-	 * properly set this at the page level (Linux problem).
-	 * If shared is set, we cause a zero PID->TID load.
-	 * Many of these bits are software only.  Bits we don't set
-	 * here we (properly should) assume have the appropriate value.
-	 */
-
-	/* Load the next available TLB index */
-	lis	r13, tlb_44x_index@ha
-	lwz	r13, tlb_44x_index@l(r13)
-	/* Load the TLB high watermark */
-	lis	r11, tlb_44x_hwater@ha
-	lwz	r11, tlb_44x_hwater@l(r11)
-
-	/* Increment, rollover, and store TLB index */
-	addi	r13, r13, 1
-	cmpw	0, r13, r11			/* reserve entries */
-	ble	7f
-	li	r13, 0
-7:
-	/* Store the next available TLB index */
-	lis	r11, tlb_44x_index@ha
-	stw	r13, tlb_44x_index@l(r11)
-
-	lwz	r11, 0(r12)			/* Get MS word of PTE */
-	lwz	r12, 4(r12)			/* Get LS word of PTE */
-	rlwimi	r11, r12, 0, 0 , 19		/* Insert RPN */
-	tlbwe	r11, r13, PPC44x_TLB_XLAT	/* Write XLAT */
+	/* Combine RPN & ERPN an write WS 0 */
+	rlwimi	r11,r12,0,0,19
+	tlbwe	r11,r13,PPC44x_TLB_XLAT
 
 	/*
-	 * Create PAGEID. This is the faulting address,
+	 * Create WS1. This is the faulting address (EPN),
 	 * page size, and valid flag.
 	 */
-	li	r11, PPC44x_TLB_VALID | PPC44x_TLB_4K
-	rlwimi	r10, r11, 0, 20, 31		/* Insert valid and page size */
-	tlbwe	r10, r13, PPC44x_TLB_PAGEID	/* Write PAGEID */
-
-	li	r10, PPC44x_TLB_SR@l		/* Set SR */
-	rlwimi	r10, r12, 0, 30, 30		/* Set SW = _PAGE_RW */
-	rlwimi	r10, r12, 29, 29, 29		/* SX = _PAGE_HWEXEC */
-	rlwimi	r10, r12, 29, 28, 28		/* UR = _PAGE_USER */
-	rlwimi	r11, r12, 31, 26, 26		/* (_PAGE_USER>>1)->r12 */
-	and	r11, r12, r11			/* HWEXEC & USER */
-	rlwimi	r10, r11, 0, 26, 26		/* UX = HWEXEC & USER */
-
-	rlwimi	r12, r10, 0, 26, 31		/* Insert static perms */
-
-	/*
-	 * Clear U0-U3 and WL1 IL1I IL1D IL2I IL2D bits which are added
-	 * on newer 440 cores like the 440x6 used on AMCC 460EX/460GT (see
-	 * include/asm-powerpc/pgtable-ppc32.h for details).
-	 */
-	rlwinm	r12, r12, 0, 20, 10
-
-	tlbwe	r12, r13, PPC44x_TLB_ATTRIB	/* Write ATTRIB */
+	li	r11,PPC44x_TLB_VALID | PPC44x_TLB_4K
+	rlwimi	r10,r11,0,20,31			/* Insert valid and page size*/
+	tlbwe	r10,r13,PPC44x_TLB_PAGEID	/* Write PAGEID */
+
+	/* And WS 2 */
+	li	r10,0xf85			/* Mask to apply from PTE */
+	rlwimi	r10,r12,29,30,30		/* DIRTY -> SW position */
+	and	r11,r12,r10			/* Mask PTE bits to keep */
+	andi.	r10,r12,_PAGE_USER		/* User page ? */
+	beq	1f				/* nope, leave U bits empty */
+	rlwimi	r11,r11,3,26,28			/* yes, copy S bits to U */
+1:	tlbwe	r11,r13,PPC44x_TLB_ATTRIB	/* Write ATTRIB */
 
 	/* Done...restore registers and get out of here.
 	*/
Index: linux-work-next/arch/powerpc/mm/44x_mmu.c
===================================================================
--- linux-work-next.orig/arch/powerpc/mm/44x_mmu.c	2008-07-07 13:45:04.000000000 +1000
+++ linux-work-next/arch/powerpc/mm/44x_mmu.c	2008-07-08 11:29:55.000000000 +1000
@@ -27,6 +27,7 @@
 #include <asm/mmu.h>
 #include <asm/system.h>
 #include <asm/page.h>
+#include <asm/cacheflush.h>
 
 #include "mmu_decl.h"
 
@@ -37,11 +38,35 @@ unsigned int tlb_44x_index; /* = 0 */
 unsigned int tlb_44x_hwater = PPC44x_TLB_SIZE - 1 - PPC44x_EARLY_TLBS;
 int icache_44x_need_flush;
 
+static void __init ppc44x_update_tlb_hwater(void)
+{
+	extern unsigned int tlb_44x_patch_hwater_D[];
+	extern unsigned int tlb_44x_patch_hwater_I[];
+
+	/* The TLB miss handlers hard codes the watermark in a cmpli
+	 * instruction to improve performances rather than loading it
+	 * from the global variable. Thus, we patch the instructions
+	 * in the 2 TLB miss handlers when updating the value
+	 */
+	tlb_44x_patch_hwater_D[0] = (tlb_44x_patch_hwater_D[0] & 0xffff0000) |
+		tlb_44x_hwater;
+	flush_icache_range((unsigned long)&tlb_44x_patch_hwater_D[0],
+			   (unsigned long)&tlb_44x_patch_hwater_D[1]);
+	tlb_44x_patch_hwater_I[0] = (tlb_44x_patch_hwater_I[0] & 0xffff0000) |
+		tlb_44x_hwater;
+	flush_icache_range((unsigned long)&tlb_44x_patch_hwater_I[0],
+			   (unsigned long)&tlb_44x_patch_hwater_I[1]);
+}
+
 /*
  * "Pins" a 256MB TLB entry in AS0 for kernel lowmem
  */
 static void __init ppc44x_pin_tlb(unsigned int virt, unsigned int phys)
 {
+	unsigned int entry = tlb_44x_hwater--;
+
+	ppc44x_update_tlb_hwater();
+
 	__asm__ __volatile__(
 		"tlbwe	%2,%3,%4\n"
 		"tlbwe	%1,%3,%5\n"
@@ -50,7 +75,7 @@ static void __init ppc44x_pin_tlb(unsign
 	: "r" (PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_SX | PPC44x_TLB_G),
 	  "r" (phys),
 	  "r" (virt | PPC44x_TLB_VALID | PPC44x_TLB_256M),
-	  "r" (tlb_44x_hwater--), /* slot for this TLB entry */
+	  "r" (entry),
 	  "i" (PPC44x_TLB_PAGEID),
 	  "i" (PPC44x_TLB_XLAT),
 	  "i" (PPC44x_TLB_ATTRIB));
@@ -58,6 +83,8 @@ static void __init ppc44x_pin_tlb(unsign
 
 void __init MMU_init_hw(void)
 {
+	ppc44x_update_tlb_hwater();
+
 	flush_instruction_cache();
 }
 
Index: linux-work-next/include/asm-powerpc/pgtable-ppc32.h
===================================================================
--- linux-work-next.orig/include/asm-powerpc/pgtable-ppc32.h	2008-07-07 14:27:30.000000000 +1000
+++ linux-work-next/include/asm-powerpc/pgtable-ppc32.h	2008-07-08 11:29:55.000000000 +1000
@@ -182,6 +182,9 @@ extern int icache_44x_need_flush;
 #define _PMD_SIZE_16M	0x0e0
 #define PMD_PAGE_SIZE(pmdval)	(1024 << (((pmdval) & _PMD_SIZE) >> 4))
 
+/* Until my rework is finished, 40x still needs atomic PTE updates */
+#define PTE_ATOMIC_UPDATES	1
+
 #elif defined(CONFIG_44x)
 /*
  * Definitions for PPC440
@@ -253,17 +256,17 @@ extern int icache_44x_need_flush;
  */
 
 #define _PAGE_PRESENT	0x00000001		/* S: PTE valid */
-#define	_PAGE_RW	0x00000002		/* S: Write permission */
+#define _PAGE_RW	0x00000002		/* S: Write permission */
 #define _PAGE_FILE	0x00000004		/* S: nonlinear file mapping */
+#define _PAGE_HWEXEC	0x00000004		/* H: Execute permission */
 #define _PAGE_ACCESSED	0x00000008		/* S: Page referenced */
-#define _PAGE_HWWRITE	0x00000010		/* H: Dirty & RW */
-#define _PAGE_HWEXEC	0x00000020		/* H: Execute permission */
-#define	_PAGE_USER	0x00000040		/* S: User page */
-#define	_PAGE_ENDIAN	0x00000080		/* H: E bit */
-#define	_PAGE_GUARDED	0x00000100		/* H: G bit */
-#define	_PAGE_DIRTY	0x00000200		/* S: Page dirty */
-#define	_PAGE_NO_CACHE	0x00000400		/* H: I bit */
-#define	_PAGE_WRITETHRU	0x00000800		/* H: W bit */
+#define _PAGE_DIRTY	0x00000010		/* S: Page dirty */
+#define _PAGE_USER	0x00000040		/* S: User page */
+#define _PAGE_ENDIAN	0x00000080		/* H: E bit */
+#define _PAGE_GUARDED	0x00000100		/* H: G bit */
+#define _PAGE_COHERENT	0x00000200		/* H: M bit */
+#define _PAGE_NO_CACHE	0x00000400		/* H: I bit */
+#define _PAGE_WRITETHRU	0x00000800		/* H: W bit */
 
 /* TODO: Add large page lowmem mapping support */
 #define _PMD_PRESENT	0
@@ -273,6 +276,7 @@ extern int icache_44x_need_flush;
 /* ERPN in a PTE never gets cleared, ignore it */
 #define _PTE_NONE_MASK	0xffffffff00000000ULL
 
+
 #elif defined(CONFIG_FSL_BOOKE)
 /*
    MMU Assist Register 3:
@@ -315,6 +319,9 @@ extern int icache_44x_need_flush;
 #define _PMD_PRESENT_MASK (PAGE_MASK)
 #define _PMD_BAD	(~PAGE_MASK)
 
+/* Until my rework is finished, FSL BookE still needs atomic PTE updates */
+#define PTE_ATOMIC_UPDATES	1
+
 #elif defined(CONFIG_8xx)
 /* Definitions for 8xx embedded chips. */
 #define _PAGE_PRESENT	0x0001	/* Page is valid */
@@ -345,6 +352,9 @@ extern int icache_44x_need_flush;
 
 #define _PTE_NONE_MASK _PAGE_ACCESSED
 
+/* Until my rework is finished, 8xx still needs atomic PTE updates */
+#define PTE_ATOMIC_UPDATES	1
+
 #else /* CONFIG_6xx */
 /* Definitions for 60x, 740/750, etc. */
 #define _PAGE_PRESENT	0x001	/* software: pte contains a translation */
@@ -365,6 +375,10 @@ extern int icache_44x_need_flush;
 #define _PMD_PRESENT	0
 #define _PMD_PRESENT_MASK (PAGE_MASK)
 #define _PMD_BAD	(~PAGE_MASK)
+
+/* Hash table based platforms need atomic updates of the linux PTE */
+#define PTE_ATOMIC_UPDATES	1
+
 #endif
 
 /*
@@ -557,9 +571,11 @@ extern void add_hash_page(unsigned conte
  * low PTE word since we expect ALL flag bits to be there
  */
 #ifndef CONFIG_PTE_64BIT
-static inline unsigned long pte_update(pte_t *p, unsigned long clr,
+static inline unsigned long pte_update(pte_t *p,
+				       unsigned long clr,
 				       unsigned long set)
 {
+#ifdef PTE_ATOMIC_UPDATES
 	unsigned long old, tmp;
 
 	__asm__ __volatile__("\
@@ -572,16 +588,26 @@ static inline unsigned long pte_update(p
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
 	: "r" (p), "r" (clr), "r" (set), "m" (*p)
 	: "cc" );
+#else /* PTE_ATOMIC_UPDATES */
+	unsigned long old = pte_val(*p);
+	*p = __pte((old & ~clr) | set);
+#endif /* !PTE_ATOMIC_UPDATES */
+
 #ifdef CONFIG_44x
 	if ((old & _PAGE_USER) && (old & _PAGE_HWEXEC))
 		icache_44x_need_flush = 1;
 #endif
 	return old;
 }
-#else
-static inline unsigned long long pte_update(pte_t *p, unsigned long clr,
-				       unsigned long set)
+#else /* CONFIG_PTE_64BIT */
+/* TODO: Change that to only modify the low word and move set_pte_at()
+ * out of line
+ */
+static inline unsigned long long pte_update(pte_t *p,
+					    unsigned long clr,
+					    unsigned long set)
 {
+#ifdef PTE_ATOMIC_UPDATES
 	unsigned long long old;
 	unsigned long tmp;
 
@@ -596,13 +622,18 @@ static inline unsigned long long pte_upd
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
 	: "r" (p), "r" ((unsigned long)(p) + 4), "r" (clr), "r" (set), "m" (*p)
 	: "cc" );
+#else /* PTE_ATOMIC_UPDATES */
+	unsigned long long old = pte_val(*p);
+	*p = __pte((old & ~clr) | set);
+#endif /* !PTE_ATOMIC_UPDATES */
+
 #ifdef CONFIG_44x
 	if ((old & _PAGE_USER) && (old & _PAGE_HWEXEC))
 		icache_44x_need_flush = 1;
 #endif
 	return old;
 }
-#endif
+#endif /* CONFIG_PTE_64BIT */
 
 /*
  * set_pte stores a linux PTE into the linux page table.
@@ -671,7 +702,7 @@ static inline void __ptep_set_access_fla
 ({									   \
 	int __changed = !pte_same(*(__ptep), __entry);			   \
 	if (__changed) {						   \
-		__ptep_set_access_flags(__ptep, __entry, __dirty);    	   \
+		__ptep_set_access_flags(__ptep, __entry, __dirty);         \
 		flush_tlb_page_nohash(__vma, __address);		   \
 	}								   \
 	__changed;							   \
Index: linux-work-next/arch/powerpc/kernel/head_booke.h
===================================================================
--- linux-work-next.orig/arch/powerpc/kernel/head_booke.h	2008-07-07 14:27:30.000000000 +1000
+++ linux-work-next/arch/powerpc/kernel/head_booke.h	2008-07-08 11:29:55.000000000 +1000
@@ -340,6 +340,14 @@ label:
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
 	EXC_XFER_TEMPLATE(DebugException, 0x2002, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
 
+#define DATA_STORAGE_EXCEPTION						      \
+	START_EXCEPTION(DataStorage)					      \
+	NORMAL_EXCEPTION_PROLOG;					      \
+	mfspr	r5,SPRN_ESR;		/* Grab the ESR and save it */	      \
+	stw	r5,_ESR(r11);						      \
+	mfspr	r4,SPRN_DEAR;		/* Grab the DEAR */		      \
+	EXC_XFER_EE_LITE(0x0300, handle_page_fault)
+
 #define INSTRUCTION_STORAGE_EXCEPTION					      \
 	START_EXCEPTION(InstructionStorage)				      \
 	NORMAL_EXCEPTION_PROLOG;					      \
Index: linux-work-next/arch/powerpc/mm/fault.c
===================================================================
--- linux-work-next.orig/arch/powerpc/mm/fault.c	2008-07-08 15:50:29.000000000 +1000
+++ linux-work-next/arch/powerpc/mm/fault.c	2008-07-08 15:51:09.000000000 +1000
@@ -306,7 +306,8 @@ good_area:
 					flush_dcache_icache_page(page);
 					set_bit(PG_arch_1, &page->flags);
 				}
-				pte_update(ptep, 0, _PAGE_HWEXEC);
+				pte_update(ptep, 0, _PAGE_HWEXEC |
+					   _PAGE_ACCESSED);
 				_tlbie(address, mm->context.id);
 				pte_unmap_unlock(ptep, ptl);
 				up_read(&mm->mmap_sem);
