Date: Fri, 14 Jun 2002 16:00:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 40x large page PTEs - Mark IV
Message-ID: <20020614060022.GB1124@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This version of the patch fixes a few compilation problems in the last
version when CONFIG_NOT_COHERENT_CACHE was not set.  I'm running it
now on my TiBook, and it works nicely on the 405GP machine.

iff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/config.in linux-grinch-largepage/arch/ppc/config.in
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/config.in	Fri Jun 14 09:47:07 2002
+++ linux-grinch-largepage/arch/ppc/config.in	Fri Jun 14 10:09:53 2002
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
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/head_4xx.S	Wed Jun 12 15:46:14 2002
+++ linux-grinch-largepage/arch/ppc/kernel/head_4xx.S	Wed Jun 12 15:46:33 2002
@@ -262,10 +262,10 @@
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

@@ -497,33 +497,40 @@
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
@@ -590,32 +597,40 @@
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
@@ -750,25 +765,20 @@
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
@@ -954,10 +964,8 @@
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
+++ linux-grinch-largepage/arch/ppc/mm/pgtable.c	Thu Jun 13 17:53:49 2002
@@ -75,6 +75,12 @@
 #define p_mapped_by_bats(x)	(0UL)
 #endif /* HAVE_BATS */

+#if (_PMD_SIZE == 0) /* No large page PMD support */
+#define 	largepte_mapin_ram()	0UL
+#else
+extern unsigned long largepte_mapin_ram(void);
+#endif
+
 #ifndef CONFIG_PPC_ISERIES
 #ifndef CONFIG_440
 void *
@@ -346,9 +352,12 @@
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
@@ -451,6 +460,8 @@
 	 * tables.......I am actively working on resolving this, but
 	 * can't hold up other stuff.  -- Dan
 	 */
+	pgd_t	*pgd;
+	pmd_t	*pmd;
 	pte_t *pte;
 	struct mm_struct *mm;

@@ -468,10 +479,20 @@
 		mm = &init_mm;

 	pa = 0;
-	if (get_pteptr(mm, addr, &pte))
-		pa = (pte_val(*pte) & PAGE_MASK) | (addr & ~PAGE_MASK);
+	pgd = pgd_offset(mm, addr);
+	if (pgd) {
+		pmd = pmd_offset(pgd, addr);
+		if (pmd_present(*pmd)) {
+			pte = pte_offset(pmd, addr);
+			pa = (pte_val(*pte) & PAGE_MASK) | (addr & ~PAGE_MASK);
+		} else if (pmd_largepage(*pmd)) {
+			unsigned long mask = pmd_largepagemask(*pmd);
+
+			pa = (pmd_val(*pmd) & mask) | (addr & ~mask);
+		}
+	}

-	return(pa);
+	return pa;
 }

 /* This is will find the virtual address for a physical one....
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/pgtable.h linux-grinch-largepage/include/asm-ppc/pgtable.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/pgtable.h	Sat Jun  8 01:53:04 2002
+++ linux-grinch-largepage/include/asm-ppc/pgtable.h	Fri Jun 14 14:56:57 2002
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
@@ -296,7 +288,12 @@
 #define _PAGE_HWWRITE	0x100	/* hardware: Dirty & RW, set in exception */
 #define _PAGE_HWEXEC	0x200	/* hardware: EX permission */
 #define _PAGE_ACCESSED	0x400	/* software: R: page referenced */
-#define _PMD_PRESENT	PAGE_MASK
+
+#define _PMD_PRESENT	0x400	/* PMD points to page of PTEs */
+#define _PMD_SIZE	0x0e0	/* size field, != 0 for large-page PMD entry */
+#define _PMD_SIZE_4M	0x0c0
+#define _PMD_SIZE_16M	0x0e0
+#define PMD_PAGE_SIZE(pmdval)	(1024 << (((pmdval) & _PMD_SIZE) >> 4))

 #elif defined(CONFIG_440)

@@ -398,6 +395,10 @@
 #ifndef _PAGE_EXEC
 #define _PAGE_EXEC	0
 #endif
+#ifndef _PMD_SIZE
+#define _PMD_SIZE	0
+#define PMD_PAGE_SIZE(pmd)	bad_call_to_PMD_PAGE_SIZE()
+#endif

 #define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)

@@ -455,6 +456,10 @@
 #define __S111	PAGE_SHARED_X

 #ifndef __ASSEMBLY__
+/* Make sure we get a link error if PMD_PAGE_SIZE is ever called on a
+ * kernel without large page PMD support */
+extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
+
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
@@ -469,9 +474,12 @@
 #define pte_clear(ptep)		do { set_pte((ptep), __pte(0)); } while (0)

 #define pmd_none(pmd)		(!pmd_val(pmd))
-#define	pmd_bad(pmd)		((pmd_val(pmd) & _PMD_PRESENT) == 0)
+#define	pmd_bad(pmd)		( ((pmd_val(pmd) & _PMD_PRESENT) == 0) && \
+				  ((pmd_val(pmd) & _PMD_SIZE) == 0) )
 #define	pmd_present(pmd)	((pmd_val(pmd) & _PMD_PRESENT) != 0)
 #define	pmd_clear(pmdp)		do { pmd_val(*(pmdp)) = 0; } while (0)
+#define pmd_largepage(pmd)	((pmd_val(pmd) & _PMD_SIZE) != 0)
+#define pmd_largepagemask(pmd)	(~(PMD_PAGE_SIZE(pmd_val(pmd)) - 1))

 #define pte_page(x)		(mem_map+(unsigned long)((pte_val(x)-PPC_MEMSTART) >> PAGE_SHIFT))



--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
