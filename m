Date: Thu, 20 Jun 2002 16:35:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: 40x large-page support for 2.5
Message-ID: <20020620063551.GA20689@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I implemented the 40x largepage support for 2.5.  The patch below is
against current linuxppc-2.5.  This patch includes the mapin_ram()
cleanups I sent to you earlier.  I can seperate it out if that would
help.

It works on the Icebox, but is untested on non-40x thus far.

diff -urN /home/dgibson/kernel/linuxppc-2.5/arch/ppc/kernel/head_4xx.S linux-bluefish/arch/ppc/kernel/head_4xx.S
--- /home/dgibson/kernel/linuxppc-2.5/arch/ppc/kernel/head_4xx.S	Thu Jun 20 15:52:36 2002
+++ linux-bluefish/arch/ppc/kernel/head_4xx.S	Thu Jun 20 15:53:46 2002
@@ -555,33 +555,40 @@
 4:
 	tophys(r11, r11)
 	rlwimi	r11, r10, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
-	lwz	r11, 0(r11)		/* Get L1 entry */
-	rlwinm.	r12, r11, 0, 0, 19	/* Extract L2 (pte) base address */
+	lwz	r12, 0(r11)		/* Get L1 entry */
+	andi.	r9, r12, _PMD_PRESENT	/* Check if it points to a PTE page */
 	beq	2f			/* Bail if no table */

 	rlwimi	r12, r10, 22, 20, 29	/* Compute PTE address */
 	lwz	r11, 0(r12)		/* Get Linux PTE */
 	andi.	r9, r11, _PAGE_PRESENT
-	beq	2f
+	beq	5f

 	ori	r11, r11, _PAGE_ACCESSED
 	stw	r11, 0(r12)

-	/* Most of the Linux PTE is ready to load into the TLB LO.
-	 * We set ZSEL, where only the LS-bit determines user access.
-	 * We set execute, because we don't have the granularity to
-	 * properly set this at the page level (Linux problem).
-	 * If shared is set, we cause a zero PID->TID load.
-	 * Many of these bits are software only.  Bits we don't set
-	 * here we (properly should) assume have the appropriate value.
-	 */
-	li	r12, 0x0ce2
-	andc	r11, r11, r12		/* Make sure 20, 21 are zero */
+	/* Create TLB tag.  This is the faulting address plus a static
+	 * set of bits.  These are size, valid, E, U0.
+	*/
+	li	r12, 0x00c0
+	rlwimi	r10, r12, 0, 20, 31

 	b	finish_tlb_load

+2:	/* Check for possible large-page pmd entry */
+	rlwinm.	r9, r12, 2, 22, 24
+	beq	5f
+
+	/* Create TLB tag.  This is the faulting address, plus a static
+	 * set of bits (valid, E, U0) plus the size from the PMD.
+	 */
+	ori	r9, r9, 0x40
+	rlwimi	r10, r9, 0, 20, 31
+	mr	r11, r12

-2:
+	b	finish_tlb_load
+
+5:
 	/* The bailout.  Restore registers to pre-exception conditions
 	 * and call the heavyweights to help us out.
 	 */
@@ -647,55 +654,40 @@
 4:
 	tophys(r11, r11)
 	rlwimi	r11, r10, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
-	lwz	r11, 0(r11)		/* Get L1 entry */
-	rlwinm.	r12, r11, 0, 0, 19	/* Extract L2 (pte) base address */
+	lwz	r12, 0(r11)		/* Get L1 entry */
+	andi.	r9, r12, _PMD_PRESENT	/* Check if it points to a PTE page */
 	beq	2f			/* Bail if no table */

 	rlwimi	r12, r10, 22, 20, 29	/* Compute PTE address */
 	lwz	r11, 0(r12)		/* Get Linux PTE */
 	andi.	r9, r11, _PAGE_PRESENT
-	beq	2f
+	beq	5f

 	ori	r11, r11, _PAGE_ACCESSED
 	stw	r11, 0(r12)

-	/* Most of the Linux PTE is ready to load into the TLB LO.
-	 * We set ZSEL, where only the LS-bit determines user access.
-	 * We set execute, because we don't have the granularity to
-	 * properly set this at the page level (Linux problem).
-	 * If shared is set, we cause a zero PID->TID load.
-	 * Many of these bits are software only.  Bits we don't set
-	 * here we (properly should) assume have the appropriate value.
-	 */
-	li	r12, 0x0ce2
-	andc	r11, r11, r12		/* Make sure 20, 21 are zero */
+	/* Create TLB tag.  This is the faulting address plus a static
+	 * set of bits.  These are size, valid, E, U0.
+	*/
+	li	r12, 0x00c0
+	rlwimi	r10, r12, 0, 20, 31

 	b	finish_tlb_load

-	/* Done...restore registers and get out of here.
-	*/
-#ifdef CONFIG_403GCX
-	lwz     r12, 12(r0)
-	lwz     r11, 8(r0)
-	mtspr   SPRN_PID, r12
-	mtcr    r11
-	lwz     r9, 4(r0)
-	lwz     r12, 0(r0)
-#else
-	mfspr	r12, SPRG6
-	mfspr	r11, SPRG7
-	mtspr	SPRN_PID, r12
-	mtcr	r11
-	mfspr	r9, SPRG5
-	mfspr	r12, SPRG4
-#endif
-	mfspr	r11, SPRG1
-	mfspr	r10, SPRG0
-	PPC405_ERR77_SYNC
-	rfi			/* Should sync shadow TLBs */
-	b	.		/* prevent prefetch past rfi */
+2:	/* Check for possible large-page pmd entry */
+	rlwinm.	r9, r12, 2, 22, 24
+	beq	5f
+
+	/* Create TLB tag.  This is the faulting address, plus a static
+	 * set of bits (valid, E, U0) plus the size from the PMD.
+	 */
+	ori	r9, r9, 0x40
+	rlwimi	r10, r9, 0, 20, 31
+	mr	r11, r12

-2:
+	b	finish_tlb_load
+
+5:
 	/* The bailout.  Restore registers to pre-exception conditions
 	 * and call the heavyweights to help us out.
 	 */
@@ -818,8 +810,8 @@
 	/* Damn, I came up one instruction too many to fit into the
 	 * exception space :-).  Both the instruction and data TLB
 	 * miss get to this point to load the TLB.
-	 * 	r10 - EA of fault
-	 * 	r11 - TLB LO (info from Linux PTE)
+	 * 	r10 - TLB_TAG value
+	 * 	r11 - Linux PTE
 	 *	r12, r9 - avilable to use
 	 *	PID - loaded with proper value when we get here
 	 *	Upon exit, we reload everything and RFI.
@@ -833,21 +825,19 @@
 	*/
 	lwz	r9, tlb_4xx_index@l(0)
 	addi	r9, r9, 1
-	cmpwi	0, r9, 61		/* reserve entries 62, 63 for kernel */
-	ble	7f
-	li	r9, 0
-7:
+	andi.	r9, r9, (PPC4XX_TLB_SIZE-1)
 	stw	r9, tlb_4xx_index@l(0)

 6:
-	tlbwe	r11, r9, TLB_DATA		/* Load TLB LO */
-
-	/* Create EPN.  This is the faulting address plus a static
-	 * set of bits.  These are size, valid, E, U0, and ensure
-	 * bits 20 and 21 are zero.
+	/*
+	 * Clear out the software-only bits in the PTE to generate the
+	 * TLB_DATA value.  These are the bottom 2 bits of the RPM, the
+	 * top 3 bits of the zone field, and M.
 	 */
-	li	r12, 0x00c0
-	rlwimi	r10, r12, 0, 20, 31
+	li	r12, 0x0ce2
+	andc	r11, r11, r12
+
+	tlbwe	r11, r9, TLB_DATA		/* Load TLB LO */
 	tlbwe	r10, r9, TLB_TAG		/* Load TLB HI */

 	/* Done...restore registers and get out of here.
@@ -929,7 +919,9 @@

 /* Load up the kernel context */
 2:
-	SYNC			/* Force all PTE updates to finish */
+	sync			/* Flush to memory before changing TLB */
+	tlbia
+	isync			/* Flush shadow TLBs */

 	/* set up the PTE pointers for the Abatron bdiGDB.
 	*/
@@ -956,7 +948,7 @@
  */
 initial_mmu:
 	tlbia			/* Invalidate all TLB entries */
-	sync
+	isync

 	/* We should still be executing code at physical address 0x0000xxxx
 	 * at this point. However, start_here is at virtual address
@@ -985,18 +977,10 @@
 	clrrwi	r3,r3,10		/* Mask off the effective page number */
 	ori	r3,r3,(TLB_VALID | TLB_PAGESZ(PAGESZ_16M))

-        li      r0,62                    /* TLB slot 62 */
+        li      r0,63                    /* TLB slot 63 */

 	tlbwe	r4,r0,TLB_DATA		/* Load the data portion of the entry */
 	tlbwe	r3,r0,TLB_TAG		/* Load the tag portion of the entry */
-
-	addis	r4, r4, 0x0100		/* Map next 16 M entries */
-	addis	r3, r3, 0x0100
-
-        li      r0,63                    /* TLB slot 63 */
-
-	tlbwe	r4,r0,TLB_DATA
-	tlbwe	r3,r0,TLB_TAG

 #if defined(CONFIG_SERIAL_TEXT_DEBUG) && defined(SERIAL_DEBUG_IO_BASE)

diff -urN /home/dgibson/kernel/linuxppc-2.5/arch/ppc/kernel/misc.S linux-bluefish/arch/ppc/kernel/misc.S
--- /home/dgibson/kernel/linuxppc-2.5/arch/ppc/kernel/misc.S	Mon May 27 15:55:39 2002
+++ linux-bluefish/arch/ppc/kernel/misc.S	Thu Jun 20 13:59:07 2002
@@ -355,18 +355,9 @@
  */
 _GLOBAL(_tlbia)
 #if defined(CONFIG_40x)
-	/* This needs to be coordinated with other pinning functions since
-	 * we don't keep a memory location of number of entries to reduce
-	 * cache pollution during these operations.
-	 */
-	lis	r3, 0
-	sync
-1:
-	tlbwe	r3, r3, TLB_TAG		/* just ensure V is clear */
-	addi	r3, r3, 1		/*   so r3 works fine for that */
-	cmpwi	0, r3, 61		/* reserve last two entries */
-	ble	1b
-	isync
+	sync			/* Flush to memory before changing mapping */
+	tlbia
+	isync			/* Flush shadow TLB */
 #else /* ! defined(CONFIG_40x) */
 #if defined(CONFIG_SMP)
 	rlwinm	r8,r1,0,0,18
diff -urN /home/dgibson/kernel/linuxppc-2.5/arch/ppc/mm/4xx_mmu.c linux-bluefish/arch/ppc/mm/4xx_mmu.c
--- /home/dgibson/kernel/linuxppc-2.5/arch/ppc/mm/4xx_mmu.c	Thu Jun  6 13:52:47 2002
+++ linux-bluefish/arch/ppc/mm/4xx_mmu.c	Thu Jun 20 15:09:34 2002
@@ -53,6 +53,7 @@
 #include <asm/bootx.h>
 #include <asm/machdep.h>
 #include <asm/setup.h>
+#include "mmu_decl.h"

 /*
  * MMU_init_hw does the chip-specific initialization of the MMU hardware.
@@ -90,4 +91,50 @@

         mtspr(SPRN_DCCR, 0xF0000000);	/* 512 MB of data space at 0x0. */
         mtspr(SPRN_ICCR, 0xF0000000);	/* 512 MB of instr. space at 0x0. */
+}
+
+#define LARGE_PAGE_SIZE_16M	(1<<24)
+#define LARGE_PAGE_SIZE_4M	(1<<22)
+
+unsigned long __init mmu_mapin_ram(void)
+{
+	unsigned long v, s;
+	phys_addr_t p;
+
+	v = KERNELBASE;
+	p = PPC_MEMSTART;
+	s = 0;
+
+	while (s <= (total_lowmem - LARGE_PAGE_SIZE_16M)) {
+		pmd_t *pmdp;
+		unsigned long val = p | _PMD_SIZE_16M | _PAGE_HWEXEC | _PAGE_HWWRITE;
+
+		spin_lock(&init_mm.page_table_lock);
+		pmdp = pmd_offset(pgd_offset_k(v), v);
+		pmd_val(*pmdp++) = val;
+		pmd_val(*pmdp++) = val;
+		pmd_val(*pmdp++) = val;
+		pmd_val(*pmdp++) = val;
+		spin_unlock(&init_mm.page_table_lock);
+
+		v += LARGE_PAGE_SIZE_16M;
+		p += LARGE_PAGE_SIZE_16M;
+		s += LARGE_PAGE_SIZE_16M;
+	}
+
+	while (s <= (total_lowmem - LARGE_PAGE_SIZE_4M)) {
+		pmd_t *pmdp;
+		unsigned long val = p | _PMD_SIZE_4M | _PAGE_HWEXEC | _PAGE_HWWRITE;
+
+		spin_lock(&init_mm.page_table_lock);
+		pmdp = pmd_offset(pgd_offset_k(v), v);
+		pmd_val(*pmdp) = val;
+		spin_unlock(&init_mm.page_table_lock);
+
+		v += LARGE_PAGE_SIZE_4M;
+		p += LARGE_PAGE_SIZE_4M;
+		s += LARGE_PAGE_SIZE_4M;
+	}
+
+	return s;
 }
diff -urN /home/dgibson/kernel/linuxppc-2.5/arch/ppc/mm/mmu_decl.h linux-bluefish/arch/ppc/mm/mmu_decl.h
--- /home/dgibson/kernel/linuxppc-2.5/arch/ppc/mm/mmu_decl.h	Mon Apr  8 17:49:04 2002
+++ linux-bluefish/arch/ppc/mm/mmu_decl.h	Wed Jun 12 17:09:40 2002
@@ -25,7 +25,7 @@
 #include <asm/tlbflush.h>

 extern void mapin_ram(void);
-extern void bat_mapin_ram(void);
+extern unsigned long mmu_mapin_ram(void);
 extern int map_page(unsigned long va, unsigned long pa, int flags);
 extern void setbat(int index, unsigned long virt, unsigned long phys,
 		   unsigned int size, int flags);
diff -urN /home/dgibson/kernel/linuxppc-2.5/arch/ppc/mm/pgtable.c linux-bluefish/arch/ppc/mm/pgtable.c
--- /home/dgibson/kernel/linuxppc-2.5/arch/ppc/mm/pgtable.c	Mon May  6 10:20:06 2002
+++ linux-bluefish/arch/ppc/mm/pgtable.c	Thu Jun 20 15:13:09 2002
@@ -42,6 +42,9 @@

 #if defined(CONFIG_6xx) || defined(CONFIG_POWER3)
 #define HAVE_BATS	1
+#define HAVE_MMU_MAPIN_RAM	1
+#elif defined(CONFIG_40x)
+#define HAVE_MMU_MAPIN_RAM	1
 #endif

 extern char etext[], _stext[];
@@ -57,6 +60,10 @@
 #define p_mapped_by_bats(x)	(0UL)
 #endif /* HAVE_BATS */

+#ifndef HAVE_MMU_MAPIN_RAM
+#define mmu_mapin_ram()	(0UL)
+#endif
+
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *ret;
@@ -252,31 +259,14 @@
 {
 	unsigned long v, p, s, f;

-#ifdef HAVE_BATS
-	if (!__map_without_bats)
-		bat_mapin_ram();
-#endif /* HAVE_BATS */
-
-	v = KERNELBASE;
-	p = PPC_MEMSTART;
-	for (s = 0; s < total_lowmem; s += PAGE_SIZE) {
-		/* On the MPC8xx, we want the page shared so we
-		 * don't get ASID compares on kernel space.
-		 */
-		f = _PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_SHARED | _PAGE_HWEXEC;
-#if defined(CONFIG_KGDB) || defined(CONFIG_XMON)
-		/* Allows stub to set breakpoints everywhere */
-		f |= _PAGE_WRENABLE;
-#else	/* !CONFIG_KGDB && !CONFIG_XMON */
-		if ((char *) v < _stext || (char *) v >= etext)
-			f |= _PAGE_WRENABLE;
-#ifdef CONFIG_PPC_STD_MMU
+	s = mmu_mapin_ram();
+	v = KERNELBASE + s;
+	p = PPC_MEMSTART + s;
+	for (; s < total_lowmem; s += PAGE_SIZE) {
+		if ((char *) v >= _stext && (char *) v < etext)
+			f = _PAGE_RAM_TEXT;
 		else
-			/* On the powerpc (not all), no user access
-			   forces R/W kernel access */
-			f |= _PAGE_USER;
-#endif /* CONFIG_PPC_STD_MMU */
-#endif /* CONFIG_KGDB || CONFIG_XMON */
+			f = _PAGE_RAM;
 		map_page(v, p, f);
 		v += PAGE_SIZE;
 		p += PAGE_SIZE;
diff -urN /home/dgibson/kernel/linuxppc-2.5/arch/ppc/mm/ppc_mmu.c linux-bluefish/arch/ppc/mm/ppc_mmu.c
--- /home/dgibson/kernel/linuxppc-2.5/arch/ppc/mm/ppc_mmu.c	Sat Mar  2 20:45:45 2002
+++ linux-bluefish/arch/ppc/mm/ppc_mmu.c	Wed Jun 12 17:16:45 2002
@@ -87,12 +87,15 @@
 	return 0;
 }

-void __init bat_mapin_ram(void)
+unsigned long __init mmu_mapin_ram(void)
 {
 	unsigned long tot, bl, done;
 	unsigned long max_size = (256<<20);
 	unsigned long align;

+	if (__map_without_bats)
+		return 0;
+
 	/* Set up BAT2 and if necessary BAT3 to cover RAM. */

 	/* Make sure we don't map a block larger than the
@@ -119,7 +122,10 @@
 				break;
 		setbat(3, KERNELBASE+done, PPC_MEMSTART+done, bl,
 		       _PAGE_KERNEL);
+		done = (unsigned long)bat_addrs[3].limit - KERNELBASE + 1;
 	}
+
+	return done;
 }

 /*
diff -urN /home/dgibson/kernel/linuxppc-2.5/include/asm-ppc/pgalloc.h linux-bluefish/include/asm-ppc/pgalloc.h
--- /home/dgibson/kernel/linuxppc-2.5/include/asm-ppc/pgalloc.h	Mon May 27 11:37:21 2002
+++ linux-bluefish/include/asm-ppc/pgalloc.h	Thu Jun 20 14:58:45 2002
@@ -23,10 +23,19 @@
 #define pmd_free_tlb(tlb,x)		do { } while (0)
 #define pgd_populate(mm, pmd, pte)      BUG()

-#define pmd_populate_kernel(mm, pmd, pte)	\
-		(pmd_val(*(pmd)) = __pa(pte))
-#define pmd_populate(mm, pmd, pte)	\
-		(pmd_val(*(pmd)) = ((pte) - mem_map) << PAGE_SHIFT)
+extern __inline__ void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
+{
+	pmd_val(*pmd) = __pa(pte);
+	if (_PMD_PRESENT != PAGE_MASK)
+		pmd_val(*pmd) |= _PMD_PRESENT;
+
+}
+extern __inline__ void pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *ptepage)
+{
+	pmd_val(*(pmd)) = (ptepage - mem_map) << PAGE_SHIFT;
+	if (_PMD_PRESENT != PAGE_MASK)
+		pmd_val(*pmd) |= _PMD_PRESENT;
+}

 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
 extern struct page *pte_alloc_one(struct mm_struct *mm, unsigned long addr);
diff -urN /home/dgibson/kernel/linuxppc-2.5/include/asm-ppc/pgtable.h linux-bluefish/include/asm-ppc/pgtable.h
--- /home/dgibson/kernel/linuxppc-2.5/include/asm-ppc/pgtable.h	Mon Jun  3 14:14:27 2002
+++ linux-bluefish/include/asm-ppc/pgtable.h	Thu Jun 20 13:24:07 2002
@@ -148,8 +148,8 @@
      is cleared in the TLB miss handler before the TLB entry is loaded.
    - All other bits of the PTE are loaded into TLBLO without
      modification, leaving us only the bits 20, 21, 24, 25, 26, 30 for
-     software PTE bits.  We actually use use bits 21, 24, 25, 26, and
-     30 respectively for the software bits: ACCESSED, DIRTY, RW, EXEC,
+     software PTE bits.  We actually use use bits 21, 24, 25, and
+     30 respectively for the software bits: ACCESSED, DIRTY, RW, and
      PRESENT.
 */

@@ -165,6 +165,12 @@
 #define _PAGE_HWEXEC	0x200	/* hardware: EX permission */
 #define _PAGE_ACCESSED	0x400	/* software: R: page referenced */

+#define _PMD_PRESENT	0x400	/* PMD points to page of PTEs */
+#define _PMD_SIZE	0x0e0	/* size field, != 0 for large-page PMD entry */
+#define _PMD_SIZE_4M	0x0c0
+#define _PMD_SIZE_16M	0x0e0
+#define PMD_PAGE_SIZE(pmdval)	(1024 << (((pmdval) & _PMD_SIZE) >> 4))
+
 #elif defined(CONFIG_8xx)
 /* Definitions for 8xx embedded chips. */
 #define _PAGE_PRESENT	0x0001	/* Page is valid */
@@ -231,6 +237,13 @@
 #ifndef _PAGE_EXEC
 #define _PAGE_EXEC	0
 #endif
+#ifndef _PMD_PRESENT
+#define _PMD_PRESENT	(0xffffffffUL)
+#endif
+#ifndef _PMD_SIZE
+#define _PMD_SIZE	0
+#define PMD_PAGE_SIZE(pmd)	bad_call_to_PMD_PAGE_SIZE()
+#endif

 #define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)

@@ -246,6 +259,23 @@
 #define _PAGE_KERNEL	_PAGE_BASE | _PAGE_WRENABLE | _PAGE_SHARED | _PAGE_HWEXEC
 #define _PAGE_IO	_PAGE_KERNEL | _PAGE_NO_CACHE | _PAGE_GUARDED

+#define _PAGE_RAM	_PAGE_KERNEL
+
+#if defined(CONFIG_KGDB) || defined(CONFIG_XMON)
+/* We want the debuggers to be able to set breakpoints anywhere, so
+ * don't write protect the kernel text */
+#define _PAGE_RAM_TEXT	_PAGE_RAM
+#else
+#ifdef CONFIG_PPC_STD_MMU
+/* On standard PPC MMU, no user access implies kernel read/write
+ * access, so to write-protect the kernel text we must turn on user
+ * access */
+#define _PAGE_RAM_TEXT	(_PAGE_RAM & ~_PAGE_WRENABLE) | _PAGE_USER
+#else
+#define _PAGE_RAM_TEXT	(_PAGE_RAM & ~_PAGE_WRENABLE)
+#endif
+#endif
+
 #define PAGE_NONE	__pgprot(_PAGE_BASE)
 #define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
 #define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
@@ -283,6 +313,10 @@
 #define __S111	PAGE_SHARED_X

 #ifndef __ASSEMBLY__
+/* Make sure we get a link error if PMD_PAGE_SIZE is ever called on a
+ * kernel without large page PMD support */
+extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
+
 /*
  * Conversions between PTE values and page frame numbers.
  */
@@ -307,9 +341,12 @@
 #define pte_clear(ptep)		do { set_pte((ptep), __pte(0)); } while (0)

 #define pmd_none(pmd)		(!pmd_val(pmd))
-#define	pmd_bad(pmd)		(0)
-#define	pmd_present(pmd)	(pmd_val(pmd) != 0)
+#define	pmd_bad(pmd)		( ((pmd_val(pmd) & _PMD_PRESENT) == 0) && \
+				  ((pmd_val(pmd) & _PMD_SIZE) == 0) )
+#define	pmd_present(pmd)	((pmd_val(pmd) & _PMD_PRESENT) != 0)
 #define	pmd_clear(pmdp)		do { pmd_val(*(pmdp)) = 0; } while (0)
+#define pmd_largepage(pmd)	((pmd_val(pmd) & _PMD_SIZE) != 0)
+#define pmd_largepagemask(pmd)	(~(PMD_PAGE_SIZE(pmd_val(pmd)) - 1))

 #ifndef __ASSEMBLY__
 /*
diff -urN /home/dgibson/kernel/linuxppc-2.5/include/asm-ppc/tlbflush.h linux-bluefish/include/asm-ppc/tlbflush.h
--- /home/dgibson/kernel/linuxppc-2.5/include/asm-ppc/tlbflush.h	Mon May 27 11:37:21 2002
+++ linux-bluefish/include/asm-ppc/tlbflush.h	Thu Jun 20 13:21:47 2002
@@ -22,19 +22,21 @@

 #if defined(CONFIG_4xx)

+#define __tlbia()	asm volatile ("tlbia; isync" : : : "memory")
+
 static inline void flush_tlb_all(void)
-	{ _tlbia(); }
+	{ __tlbia(); }
 static inline void flush_tlb_mm(struct mm_struct *mm)
-	{ _tlbia(); }
+	{ __tlbia(); }
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				unsigned long vmaddr)
 	{ _tlbie(vmaddr); }
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				unsigned long start, unsigned long end)
-	{ _tlbia(); }
+	{ __tlbia(); }
 static inline void flush_tlb_kernel_range(unsigned long start,
 				unsigned long end)
-	{ _tlbia(); }
+	{ __tlbia(); }
 #define update_mmu_cache(vma, addr, pte)	do { } while (0)

 #elif defined(CONFIG_8xx)


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
