Date: Tue, 11 Jun 2002 17:33:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Second cut at large PTEs on 40x
Message-ID: <20020611073304.GA25800@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here's the next version of large page support for the 40x.  Changes
from the last patch are:
	- the patch now removes the CONFIG_PIN_TLB option
	- mapin_ram() is much cleaner.  This can be made even neater
in 2.5, but there are some technical problems doing that in 2.4

iopa() is still a horrible hack and will need to be cleaned up before
I commit this.

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/config.in linux-grinch-largepage/arch/ppc/config.in
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/config.in	Tue Jun 11 10:12:43 2002
+++ linux-grinch-largepage/arch/ppc/config.in	Tue Jun 11 17:10:15 2002
@@ -357,9 +357,6 @@
   if [ "$CONFIG_8xx" = "y" ]; then
     bool "Pinned Kernel TLBs (860 ONLY)" CONFIG_PIN_TLB
   fi
-  if [ "$CONFIG_40x" = "y" ]; then
-    bool "Pinned Kernel TLBs" CONFIG_PIN_TLB
-  fi
 fi

 if [ "$CONFIG_ALL_PPC" = "y" ]; then
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/head_4xx.S linux-grinch-largepage/arch/ppc/kernel/head_4xx.S
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/head_4xx.S	Wed Jun  5 13:11:27 2002
+++ linux-grinch-largepage/arch/ppc/kernel/head_4xx.S	Tue Jun 11 17:15:45 2002
@@ -261,10 +261,10 @@
 	tophys(r21, r21)
 	rlwimi	r21, r20, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
 	lwz	r21, 0(r21)		/* Get L1 entry */
-	rlwinm.	r22, r21, 0, 0, 19	/* Extract L2 (pte) base address */
+	andi.	r22, r21, _PMD_PRESENT	/* Check if it points to a PTE page */
 	beq	2f			/* Bail if no table */

-	tophys(r22, r22)
+	tophys(r22, r21)
 	rlwimi	r22, r20, 22, 20, 29	/* Compute PTE address */
 	lwz	r21, 0(r22)		/* Get Linux PTE */

@@ -495,33 +495,40 @@
 	tophys(r21, r21)
 	rlwimi	r21, r20, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
 	lwz	r21, 0(r21)		/* Get L1 entry */
-	rlwinm.	r22, r21, 0, 0, 19	/* Extract L2 (pte) base address */
+	andi.	r22, r21, _PMD_PRESENT	/* check if it points to pte page */
 	beq	2f			/* Bail if no table */

-	tophys(r22, r22)
+	tophys(r22, r21)
 	rlwimi	r22, r20, 22, 20, 29	/* Compute PTE address */
 	lwz	r21, 0(r22)		/* Get Linux PTE */
 	andi.	r23, r21, _PAGE_PRESENT
-	beq	2f
+	beq	5f

 	ori	r21, r21, _PAGE_ACCESSED
 	stw	r21, 0(r22)

-	/* Most of the Linux PTE is ready to load into the TLB LO.
-	 * We set ZSEL, where only the LS-bit determines user access.
-	 * We set execute, because we don't have the granularity to
-	 * properly set this at the page level (Linux problem).
-	 * If shared is set, we cause a zero PID->TID load.
-	 * Many of these bits are software only.  Bits we don't set
-	 * here we (properly should) assume have the appropriate value.
+	/* Create TLB tag.  This is the faulting address plus a static
+	 * set of bits.  These are size, valid, E, U0.
 	 */
-	li	r22, 0x0ce2
-	andc	r21, r21, r22		/* Make sure 20, 21 are zero */
+	li	r22, 0x00c0
+	rlwimi	r20, r22, 0, 20, 31

 	b	finish_tlb_load

-
+	/* Check for possible large-page pmd entry */
 2:
+	rlwinm.	r22,r21,2,22,24		/* size != 0 means large-page */
+	beq	5f
+
+	/* Create EPN.  This is the faulting address plus a static
+	 * set of bits (valid, E, U0) plus the size from the PMD.
+	 */
+	ori	r22,r22,0x40
+	rlwimi	r20, r22, 0, 20, 31
+
+	b	finish_tlb_load
+
+5:
 	/* The bailout.  Restore registers to pre-exception conditions
 	 * and call the heavyweights to help us out.
 	 */
@@ -588,32 +595,40 @@
 	tophys(r21, r21)
 	rlwimi	r21, r20, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
 	lwz	r21, 0(r21)		/* Get L1 entry */
-	rlwinm.	r22, r21, 0, 0, 19	/* Extract L2 (pte) base address */
+	andi.	r22, r21, _PMD_PRESENT	/* check if it points to pte page */
 	beq	2f			/* Bail if no table */

-	tophys(r22, r22)
+	tophys(r22, r21)
 	rlwimi	r22, r20, 22, 20, 29	/* Compute PTE address */
 	lwz	r21, 0(r22)		/* Get Linux PTE */
 	andi.	r23, r21, _PAGE_PRESENT
-	beq	2f
+	beq	5f

 	ori	r21, r21, _PAGE_ACCESSED
 	stw	r21, 0(r22)

-	/* Most of the Linux PTE is ready to load into the TLB LO.
-	 * We set ZSEL, where only the LS-bit determines user access.
-	 * We set execute, because we don't have the granularity to
-	 * properly set this at the page level (Linux problem).
-	 * If shared is set, we cause a zero PID->TID load.
-	 * Many of these bits are software only.  Bits we don't set
-	 * here we (properly should) assume have the appropriate value.
+	/* Create EPN.  This is the faulting address plus a static
+	 * set of bits.  These are size, valid, E, U0.
 	 */
-	li	r22, 0x0ce2
-	andc	r21, r21, r22		/* Make sure 20, 21 are zero */
+	li	r22, 0x00c0
+	rlwimi	r20, r22, 0, 20, 31

 	b	finish_tlb_load

+	/* Check for possible large-page pmd entry */
 2:
+	rlwinm.	r22,r21,2,22,24		/* size != 0 means large-page */
+	beq	5f
+
+	/* Create EPN.  This is the faulting address plus a static
+	 * set of bits (valid=1, E=0, U0=0) plus the size from the PMD.
+	 */
+	ori	r22,r22,0x40
+	rlwimi	r20, r22, 0, 20, 31
+
+	b	finish_tlb_load
+
+5:
 	/* The bailout.  Restore registers to pre-exception conditions
 	 * and call the heavyweights to help us out.
 	 */
@@ -747,25 +762,20 @@
 	*/
 	lwz	r23, tlb_4xx_index@l(0)
 	addi	r23, r23, 1
-#ifdef CONFIG_PIN_TLB
-	cmpwi	0, r23, 61		/* reserve entries 62, 63 for kernel */
-	ble	7f
-	li	r23, 0
-7:
-#else
 	andi.	r23, r23, (PPC4XX_TLB_SIZE-1)
-#endif
 	stw	r23, tlb_4xx_index@l(0)

 6:
+	/*
+	 * Clear out the software-only bits in the PTE to generate the
+	 * TLB_DATA value.  These are the bottom 2 bits of RPN, the
+	 * top 3 bits of the zone field, and M.
+	 */
+	li	r22, 0x0ce2
+	andc	r21, r21, r22		/* Make sure 20, 21 are zero */
+
 	tlbwe	r21, r23, TLB_DATA		/* Load TLB LO */

-	/* Create EPN.  This is the faulting address plus a static
-	 * set of bits.  These are size, valid, E, U0, and ensure
-	 * bits 20 and 21 are zero.
-	 */
-	li	r22, 0x00c0
-	rlwimi	r20, r22, 0, 20, 31
 	tlbwe	r20, r23, TLB_TAG		/* Load TLB HI */

 	/* Done...restore registers and get out of here.
@@ -946,10 +956,8 @@
 /* Load up the kernel context */
 2:
 	SYNC			/* Force all PTE updates to finish */
-#ifndef CONFIG_PIN_TLB
 	tlbia			/* Clear all TLB entries */
 	sync			/* wait for tlbia/tlbie to finish */
-#endif

 	/* set up the PTE pointers for the Abatron bdiGDB.
 	*/
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/misc.S linux-grinch-largepage/arch/ppc/kernel/misc.S
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/misc.S	Fri May 24 12:16:25 2002
+++ linux-grinch-largepage/arch/ppc/kernel/misc.S	Tue Jun 11 17:08:35 2002
@@ -354,18 +354,8 @@
  * Flush MMU TLB
  */
 _GLOBAL(_tlbia)
-#if defined(CONFIG_40x) && defined(CONFIG_PIN_TLB)
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
+#if defined(CONFIG_40x)
+	tlbia
 	isync
 #elif defined(CONFIG_440)
 	lis	r3,0
@@ -376,7 +366,7 @@
 	cmpwi	0,r3,61
 	ble	1b
 	isync
-#else
+#else /* !defined(CONFIG_40x) && !defined(CONFIG_440) */
 #if defined(CONFIG_SMP)
 	mfmsr	r10
 	SYNC
@@ -410,7 +400,7 @@
 #else /* CONFIG_SMP */
 	sync
 #endif /* CONFIG_SMP */
-#endif /* defined(CONFIG_40x) && defined(CONFIG_PIN_TLB) */
+#endif /* ! defined(CONFIG_40x) && ! defined(CONFIG_440) */
 	blr

 /*
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/4xx_mmu.c linux-grinch-largepage/arch/ppc/mm/4xx_mmu.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/4xx_mmu.c	Thu May 30 18:15:28 2002
+++ linux-grinch-largepage/arch/ppc/mm/4xx_mmu.c	Tue Jun 11 17:21:06 2002
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
+unsigned long __init largepte_mapin_ram(void)
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
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/pgtable.c linux-grinch-largepage/arch/ppc/mm/pgtable.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/pgtable.c	Mon Apr  8 10:29:07 2002
+++ linux-grinch-largepage/arch/ppc/mm/pgtable.c	Tue Jun 11 17:27:18 2002
@@ -75,6 +75,14 @@
 #define p_mapped_by_bats(x)	(0UL)
 #endif /* HAVE_BATS */

+#if defined(CONFIG_40x)
+#define HAVE_LARGE_PTE	1
+#endif
+
+#ifndef HAVE_LARGE_PTE
+#define 	largepte_mapin_ram()	0UL
+#endif
+
 #ifndef CONFIG_PPC_ISERIES
 #ifndef CONFIG_440
 void *
@@ -346,9 +354,12 @@
 		bat_mapin_ram(__bat2, __bat3);
 #endif /* HAVE_BATS */

-	v = KERNELBASE;
-	p = PPC_MEMSTART;
-	for (s = 0; s < total_lowmem; s += PAGE_SIZE) {
+	s = largepte_mapin_ram();
+
+	v = KERNELBASE + s;
+	p = PPC_MEMSTART + s;
+
+	for (; s < total_lowmem; s += PAGE_SIZE) {
 		/* On the MPC8xx, we want the page shared so we
 		 * don't get ASID compares on kernel space.
 		 */
@@ -468,8 +479,33 @@
 		mm = &init_mm;

 	pa = 0;
+#ifdef CONFIG_40x
+	{
+		pgd_t	*pgd;
+		pmd_t	*pmd;
+		const unsigned long large_page_mask[] = {
+			0xfffff800, 0xffffe000, 0xffff8000, 0xfffe0000,
+			0xfff80000, 0xffe00000, 0xff800000, 0xfe000000
+		};
+
+		pgd = pgd_offset(mm, addr & PAGE_MASK);
+		if (pgd) {
+			pmd = pmd_offset(pgd, addr & PAGE_MASK);
+			if (pmd_present(*pmd)) {
+				pte = pte_offset(pmd, addr & PAGE_MASK);
+				pa = (pte_val(*pte) & PAGE_MASK) | (addr & ~PAGE_MASK);
+			} else if (pmd_val(*pmd) & _PMD_SIZE) {
+				unsigned long mask =
+					large_page_mask[(pmd_val(*pmd) & _PMD_SIZE) >> 5];
+				pa = (pmd_val(*pmd) & mask) | (addr & ~mask);
+			}
+		}
+	}
+
+#else
 	if (get_pteptr(mm, addr, &pte))
 		pa = (pte_val(*pte) & PAGE_MASK) | (addr & ~PAGE_MASK);
+#endif

 	return(pa);
 }
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/pgtable.h linux-grinch-largepage/include/asm-ppc/pgtable.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/pgtable.h	Sat Jun  8 01:53:04 2002
+++ linux-grinch-largepage/include/asm-ppc/pgtable.h	Tue Jun 11 17:13:32 2002
@@ -18,15 +18,7 @@
 extern void _tlbia(void);

 #ifdef CONFIG_4xx
-#ifdef CONFIG_PIN_TLB
-/* When pinning entries on the 4xx, we have to use a software function
- * to ensure we don't remove them since there isn't any hardware support
- * for this.
- */
-#define __tlbia()	_tlbia()
-#else
 #define __tlbia()	asm volatile ("tlbia; sync" : : : "memory")
-#endif

 static inline void local_flush_tlb_all(void)
 	{ __tlbia(); }
@@ -296,8 +288,12 @@
 #define _PAGE_HWWRITE	0x100	/* hardware: Dirty & RW, set in exception */
 #define _PAGE_HWEXEC	0x200	/* hardware: EX permission */
 #define _PAGE_ACCESSED	0x400	/* software: R: page referenced */
-#define _PMD_PRESENT	PAGE_MASK

+#define _PMD_PRESENT	0x400	/* PMD points to page of PTEs */
+#define _PMD_SIZE	0x0e0	/* size field, != 0 for large-page PMD entry */
+#define _PMD_SIZE_4M	0x0c0
+#define _PMD_SIZE_16M	0x0e0
+#define _PMD_BAD	0x802
 #elif defined(CONFIG_440)

 /*
@@ -352,9 +348,10 @@
 #define _PAGE_HWWRITE	0x0100	/* h/w write enable: never set in Linux PTE */
 #define _PAGE_USER	0x0800	/* One of the PP bits, the other is USER&~RW */

-#define _PMD_PRESENT	PAGE_MASK
+#define _PMD_PRESENT	0x0001
 #define _PMD_PAGE_MASK	0x000c
 #define _PMD_PAGE_8M	0x000c
+#define _PMD_BAD	0x0ff0

 #else /* CONFIG_6xx */
 /* Definitions for 60x, 740/750, etc. */
@@ -369,7 +366,9 @@
 #define _PAGE_ACCESSED	0x100	/* R: page referenced */
 #define _PAGE_EXEC	0x200	/* software: i-cache coherency required */
 #define _PAGE_RW	0x400	/* software: user write access allowed */
-#define _PMD_PRESENT	PAGE_MASK
+
+#define _PMD_PRESENT	0x800
+#define _PMD_BAD	0x7ff
 #endif

 /* The non-standard PowerPC MMUs, which includes the 4xx and 8xx (and
@@ -469,7 +468,7 @@
 #define pte_clear(ptep)		do { set_pte((ptep), __pte(0)); } while (0)

 #define pmd_none(pmd)		(!pmd_val(pmd))
-#define	pmd_bad(pmd)		((pmd_val(pmd) & _PMD_PRESENT) == 0)
+#define	pmd_bad(pmd)		((pmd_val(pmd) & _PMD_BAD) != 0)
 #define	pmd_present(pmd)	((pmd_val(pmd) & _PMD_PRESENT) != 0)
 #define	pmd_clear(pmdp)		do { pmd_val(*(pmdp)) = 0; } while (0)

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
