Date: Fri, 31 May 2002 14:21:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Paul Mackerras <paulus@samba.org>
Subject: First cut at large page support on 40x
Message-ID: <20020531042153.GD16537@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The patch below (against 2_4_devel) implements using large parge TLB
entries to map kernel pages on the 40x.  paulus did the basic design,
and I tweaked and degubbed it. It's a bit ugly in places (particularly
the handling of iopa()) and will need cleaning up, but it does seem to
work.

It works as follows: 40x now uses an explicit _PMD_PRESENT bit, rather
than just checking if the high bits are non-zero.  If this bit is set
in a PMD entry it means that it contains a valid pointer to a page of
PTEs.

If _PMD_PRESENT is not set, but any of bits 24-26 are non-zero, then
it is a large-page PTE.  Bits 24-26 give the size (and are shifted
into place by the TLB miss handler).  The remaining bits have the same
meaning as in a normal PTE.

Theoretically the entry can represent any of the 40x's allowed page
sizes, except size 0 (1k), but in practice only 4M and 16MB pages are
likely to be useful - since each PMD entry corresponds to a 4MB
region, using a smaller page size would lead to that page mapping
being repeated across that 4MB region.  To use 16MB pages 4 adjacent
PMD entries must all be filled with the same PTE value.

The only large-page PTEs used are created in mapin_ram() for the
kernel mapping of system RAM.

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/head_4xx.S linux-grinch-largepage/arch/ppc/kernel/head_4xx.S
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/head_4xx.S	Thu May 30 18:15:28 2002
+++ linux-grinch-largepage/arch/ppc/kernel/head_4xx.S	Fri May 31 10:54:30 2002
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
@@ -749,7 +764,14 @@
 	 * EPN is already in the TLB.
 	 */
 	tlbsx.	r23, 0, r20
-	beq	6f
+	bne	8f
+	lwz	r22,9f@l(0)
+	addi	r22,r22,1
+	stw	r22,9f@l(0)
+	b	6f
+tlb_miss_hit:
+9:	.long	0
+8:

 	/* load the next available TLB index.
 	*/
@@ -766,14 +788,16 @@
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
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/pgtable.c linux-grinch-largepage/arch/ppc/mm/pgtable.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/pgtable.c	Mon Apr  8 10:29:07 2002
+++ linux-grinch-largepage/arch/ppc/mm/pgtable.c	Fri May 31 13:51:48 2002
@@ -348,7 +348,38 @@

 	v = KERNELBASE;
 	p = PPC_MEMSTART;
-	for (s = 0; s < total_lowmem; s += PAGE_SIZE) {
+	s = 0;
+#if defined(CONFIG_40x)
+	for (; s <= (total_lowmem - 16*1024*1024); s += 16*1024*1024) {
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
+		v += 16*1024*1024;
+		p += 16*1024*1024;
+	}
+
+	for(; s <= (total_lowmem - 4*1024*1024); s += 4*1024*1024) {
+		pmd_t *pmdp;
+		unsigned long val = p | _PMD_SIZE_4M | _PAGE_HWEXEC | _PAGE_HWWRITE;
+
+		spin_lock(&init_mm.page_table_lock);
+		pmdp = pmd_offset(pgd_offset_k(v), v);
+		pmd_val(*pmdp) = val;
+		spin_unlock(&init_mm.page_table_lock);
+
+		v += 4*1024*1024;
+		p += 4*1024*1024;
+	}
+#endif
+	for (; s < total_lowmem; s += PAGE_SIZE) {
 		/* On the MPC8xx, we want the page shared so we
 		 * don't get ASID compares on kernel space.
 		 */
@@ -468,8 +499,33 @@
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
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/pgtable.h	Wed Apr 17 10:26:01 2002
+++ linux-grinch-largepage/include/asm-ppc/pgtable.h	Fri May 31 13:50:13 2002
@@ -285,8 +285,8 @@
      is cleared in the TLB miss handler before the TLB entry is loaded.
    - All other bits of the PTE are loaded into TLBLO without
      modification, leaving us only the bits 20, 21, 24, 25, 26, 30 for
-     software PTE bits.  We actually use use bits 21, 24, 25, 26, and
-     30 respectively for the software bits: ACCESSED, DIRTY, RW, EXEC,
+     software PTE bits.  We actually use use bits 21, 24, 25, and
+     30 respectively for the software bits: ACCESSED, DIRTY, RW, and
      PRESENT.
 */

@@ -301,8 +301,12 @@
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
@@ -357,9 +361,10 @@
 #define _PAGE_HWWRITE	0x0100	/* h/w write enable: never set in Linux PTE */
 #define _PAGE_USER	0x0800	/* One of the PP bits, the other is USER&~RW */

-#define _PMD_PRESENT	PAGE_MASK
+#define _PMD_PRESENT	0x0001
 #define _PMD_PAGE_MASK	0x000c
 #define _PMD_PAGE_8M	0x000c
+#define _PMD_BAD	0x0ff0

 #else /* CONFIG_6xx */
 /* Definitions for 60x, 740/750, etc. */
@@ -374,7 +379,9 @@
 #define _PAGE_ACCESSED	0x100	/* R: page referenced */
 #define _PAGE_EXEC	0x200	/* software: i-cache coherency required */
 #define _PAGE_RW	0x400	/* software: user write access allowed */
-#define _PMD_PRESENT	PAGE_MASK
+
+#define _PMD_PRESENT	0x800
+#define _PMD_BAD	0x7ff
 #endif

 /* The non-standard PowerPC MMUs, which includes the 4xx and 8xx (and
@@ -474,7 +481,7 @@
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
