Date: Tue, 11 Sep 2001 09:17:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Another fix for xmon on non-standard MMU machines
Message-ID: <20010911091748.M4823@zax>
References: <20010910194730.J4823@zax> <20010910160600.21153@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010910160600.21153@smtp.adsl.oleane.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Sep 10, 2001 at 06:06:00PM +0200, Benjamin Herrenschmidt wrote:
> >This patch stops xmon from attempting to print the segment registers
> >on machines where CONFIG_PPC_STD_MMU is not set.  This prevents xmon
> >from causing an exception when the 'S' command is used on the 4xx (and
> >others).
>
> BTW, Did you figure out that userland stack problem ? Looks like we are
> both having the same issue, but I can't yet tell where it comes from...

Not entirely, but I've made progress.  Turns out the TLB miss handler
was broken in that:
    a) it set the TLB writable bit based only the _PAGE_DIRTY bit, but
a page can be dirty but still write-protected - in particular this
happens during the COW of the stack, so the two processes were sharing
their stack.
    b) it wasn't touching the _PAGE_ACCESSED bit.

The following patch is still buggy and needs a lot of cleaning up, but
it gets things slightly further:

diff -urN ../linuxppc_2_4_devel/arch/ppc/kernel/head_4xx.S linux-bungo/arch/ppc/kernel/head_4xx.S
--- ../linuxppc_2_4_devel/arch/ppc/kernel/head_4xx.S	Mon Sep 10 11:11:43 2001
+++ linux-bungo/arch/ppc/kernel/head_4xx.S	Mon Sep 10 19:27:13 2001
@@ -234,6 +234,8 @@
 	 */
 	andis.	r21, r20, 0x8000
 	beq	3f
+	li	r22, 0
+	mtspr	SPRN_PID, r22		/* TLB will have 0 TID */
 	lis	r21, swapper_pg_dir@h
 	ori	r21, r21, swapper_pg_dir@l
 	b	4f
@@ -270,11 +272,6 @@
 	 * Many of these bits are software only.  Bits we don't set
 	 * here we (properly should) assume have the appropriate value.
 	 */
-	andi.	r22, r21, _PAGE_SHARED
-	beq	5f
-	li	r22, 0
-	mtspr	SPRN_PID, r22		/* TLB will have 0 TID */
-5:
 	li	r22, 0x0c00
 	andc	r21, r21, r22		/* Make sure 20, 21 are zero */
 	ori	r21, r21, 0x02e0	/* TLB LO ready to go */
@@ -429,6 +426,7 @@
  * load TLB entries from the page table if they exist.
  */
 	START_EXCEPTION(0x1100,	DTLBMiss)
+	b	data_tlb_miss
 	mtspr	SPRG0, r20		/* Save some working registers */
 	mtspr	SPRG1, r21
 	mtspr	SPRG4, r22
@@ -444,6 +442,8 @@
 	 */
 	andis.	r21, r20, 0x8000
 	beq	3f
+	li	r22, 0
+	mtspr	SPRN_PID, r22		/* TLB will have 0 TID */
 	lis	r21, swapper_pg_dir@h
 	ori	r21, r21, swapper_pg_dir@l
 	b	4f
@@ -451,6 +451,13 @@
 	/* Get the PGD for the current thread.
 	 */
 3:
+	/* hack, hack, hack */
+	mfspr	r22, SPRN_PID
+	cmpwi	cr0,r22,0
+	bne	999f
+	/* Oh dear, we're attemping to access user addresses from the kernel when we oughtn't */
+	b	Trap_13
+999:
 	mfspr	r21,SPRG3
 	lwz	r21,PGDIR(r21)
 4:
@@ -474,11 +481,6 @@
 	 * Many of these bits are software only.  Bits we don't set
 	 * here we (properly should) assume have the appropriate value.
 	 */
-	andi.	r22, r21, _PAGE_SHARED
-	beq	5f
-	li	r22, 0
-	mtspr	SPRN_PID, r22		/* TLB will have 0 TID */
-5:
 	li	r22, 0x0c00
 	andc	r21, r21, r22		/* Make sure 20, 21 are zero */
 	ori	r21, r21, 0x02e0	/* TLB LO ready to go */
@@ -505,6 +507,7 @@
  * registers and bailout to a different point.
  */
 	START_EXCEPTION(0x1200,	ITLBMiss)
+	b	instruction_tlb_miss
 	mtspr	SPRG0, r20		/* Save some working registers */
 	mtspr	SPRG1, r21
 	mtspr	SPRG4, r22
@@ -520,6 +523,8 @@
 	 */
 	andis.	r21, r20, 0x8000
 	beq	3f
+	li	r22, 0
+	mtspr	SPRN_PID, r22		/* TLB will have 0 TID */
 	lis	r21, swapper_pg_dir@h
 	ori	r21, r21, swapper_pg_dir@l
 	b	4f
@@ -550,11 +555,6 @@
 	 * Many of these bits are software only.  Bits we don't set
 	 * here we (properly should) assume have the appropriate value.
 	 */
-	andi.	r22, r21, _PAGE_SHARED
-	beq	5f
-	li	r22, 0
-	mtspr	SPRN_PID, r22		/* TLB will have 0 TID */
-5:
 	li	r22, 0x0c00
 	andc	r21, r21, r22		/* Make sure 20, 21 are zero */
 	ori	r21, r21, 0x02e0	/* TLB LO ready to go */
@@ -672,6 +672,238 @@
  * reserved.
  */

+data_tlb_miss:
+	mtspr	SPRG0, r20		/* Save some working registers */
+	mtspr	SPRG1, r21
+	mtspr	SPRG4, r22
+	mtspr	SPRG5, r23
+	mfcr	r21
+	mfspr	r22, SPRN_PID
+	mtspr	SPRG7, r21
+	mtspr	SPRG6, r22
+
+	mfspr	r20, SPRN_DEAR		/* Get faulting address */
+	li	r23, _PAGE_PRESENT	/* permission mask */
+	mfspr	r22, SPRN_ESR		/* Is this a write access? */
+	rlwimi	r23, r22, 16, 24, 24	/* insert _PAGE_RW if necessary */
+
+	/* If we are faulting a kernel address, we have to use the
+	 * kernel page tables.
+	 */
+	andis.	r21, r20, 0x8000
+	beq	3f
+
+	/* kernel address */
+	li	r22, 0
+	mtspr	SPRN_PID, r22		/* TLB will have 0 TID */
+	lis	r21, swapper_pg_dir@h
+	ori	r21, r21, swapper_pg_dir@l
+	mfspr	r22, SPRN_SRR1		/* Get the MSR */
+	rlwimi	r23, r22, 22, 27, 27	/* _PAGE_USER if it's a userland access */
+	b	4f
+
+	/* Get the PGD for the current thread.
+	 */
+3:
+	ori	r23, r23, _PAGE_USER		/* always need _PAGE_USER for user addresses */
+	mfspr	r21,SPRG3
+	lwz	r21,PGDIR(r21)
+4:
+	tophys(r21, r21)
+	rlwimi	r21, r20, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
+	lwz	r21, 0(r21)		/* Get L1 entry */
+	rlwinm.	r22, r21, 0, 0, 19	/* Extract L2 (pte) base address */
+	beq	2f			/* Bail if no table */
+
+	tophys(r22, r22)
+	rlwimi	r22, r20, 22, 20, 29	/* Compute PTE address */
+	lwz	r21, 0(r22)		/* Get Linux PTE */
+
+	andc.	r20, r23, r21		/* Do we have permission? */
+	bne	2f			/* If not, page fault */
+
+
+	rlwinm	r23, r23, 1, 23, 25	/* Make the mask to update the PTE */
+	or	r20, r21, r23		/* Update ACCESSED and maybe DIRTY */
+	stw	r20, 0(r22)		/* Write back to the PTE */
+
+	mfspr	r20, SPRN_DEAR		/* and restore the faulting address */
+
+	/* Most of the Linux PTE is ready to load into the TLB LO.
+	 * We set ZSEL, where only the LS-bit determines user access.
+	 * Many of these bits are software only.  Bits we don't set
+	 * here we (properly should) assume have the appropriate value.
+	 */
+	li	r22, 0x0c00
+	andc	r21, r21, r22		/* Make sure 20, 21 are zero */
+	ori	r21, r21, 0x00e0	/* TLB LO ready to go */
+
+	/* Since it has a unified TLB, and we can take data faults on
+	 * instruction pages by copying data, we have to check if the
+	 * EPN is already in the TLB.
+	 */
+	tlbsx.	r23, 0, r20
+	beq	6f
+
+	/* load the next available TLB index.
+	*/
+	lis	r22, tlb_4xx_index@h
+	ori	r22, r22, tlb_4xx_index@l
+	tophys(r22, r22)
+	lwz	r23, 0(r22)
+	addi	r23, r23, 1
+	andi.	r23, r23, (PPC4XX_TLB_SIZE-1)
+	stw	r23, 0(r22)
+
+6:
+	tlbwe	r21, r23, TLB_DATA		/* Load TLB LO */
+
+	/* Create EPN.  This is the faulting address plus a static
+	 * set of bits.  These are size, valid, E, U0, and ensure
+	 * bits 20 and 21 are zero.
+	 */
+	li	r22, 0x00c0
+	rlwimi	r20, r22, 0, 20, 31
+	tlbwe	r20, r23, TLB_TAG		/* Load TLB HI */
+
+	/* Done...restore registers and get out of here.
+	*/
+	mfspr	r22, SPRG6
+	mfspr	r21, SPRG7
+	mtspr	SPRN_PID, r22
+	mtcr	r21
+	mfspr	r23, SPRG5
+	mfspr	r22, SPRG4
+	mfspr	r21, SPRG1
+	mfspr	r20, SPRG0
+	rfi
+2:
+	/* The bailout.  Restore registers to pre-exception conditions
+	 * and call the heavyweights to help us out.
+	 */
+	mfspr	r22, SPRG6
+	mfspr	r21, SPRG7
+	mtspr	SPRN_PID, r22
+	mtcr	r21
+	mfspr	r23, SPRG5
+	mfspr	r22, SPRG4
+	mfspr	r21, SPRG1
+	mfspr	r20, SPRG0
+	b	DataAccess
+
+instruction_tlb_miss:
+	mtspr	SPRG0, r20		/* Save some working registers */
+	mtspr	SPRG1, r21
+	mtspr	SPRG4, r22
+	mtspr	SPRG5, r23
+	mfcr	r21
+	mfspr	r22, SPRN_PID
+	mtspr	SPRG7, r21
+	mtspr	SPRG6, r22
+
+	mfspr	r20, SPRN_SRR0		/* Get faulting address */
+	li	r23, _PAGE_PRESENT | _PAGE_EXEC	/* permission mask */
+
+	/* If we are faulting a kernel address, we have to use the
+	 * kernel page tables.
+	 */
+	andis.	r21, r20, 0x8000
+	beq	3f
+
+	/* kernel address */
+	li	r22, 0
+	mtspr	SPRN_PID, r22		/* TLB will have 0 TID */
+	lis	r21, swapper_pg_dir@h
+	ori	r21, r21, swapper_pg_dir@l
+	mfspr	r22, SPRN_SRR1		/* Get the MSR */
+	rlwimi	r23, r22, 22, 27, 27	/* _PAGE_USER if it's a userland access */
+	b	4f
+
+	/* Get the PGD for the current thread.
+	 */
+3:
+	ori	r23, r23, _PAGE_USER		/* always need _PAGE_USER for user addresses */
+	mfspr	r21,SPRG3
+	lwz	r21,PGDIR(r21)
+4:
+	tophys(r21, r21)
+	rlwimi	r21, r20, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
+	lwz	r21, 0(r21)		/* Get L1 entry */
+	rlwinm.	r22, r21, 0, 0, 19	/* Extract L2 (pte) base address */
+	beq	2f			/* Bail if no table */
+
+	tophys(r22, r22)
+	rlwimi	r22, r20, 22, 20, 29	/* Compute PTE address */
+	lwz	r21, 0(r22)		/* Get Linux PTE */
+
+	andc.	r23, r23, r21		/* Do we have permission? */
+	bne	2f			/* If not, page fault */
+
+	ori	r23, r21, _PAGE_ACCESSED	/* Update ACCESSED and maybe DIRTY */
+	stw	r23, 0(r22)		/* Write back to the PTE */
+
+	/* Most of the Linux PTE is ready to load into the TLB LO.
+	 * We set ZSEL, where only the LS-bit determines user access.
+	 * Many of these bits are software only.  Bits we don't set
+	 * here we (properly should) assume have the appropriate value.
+	 */
+	li	r22, 0x0c00
+	andc	r21, r21, r22		/* Make sure 20, 21 are zero */
+	ori	r21, r21, 0x00e0	/* TLB LO ready to go */
+
+	/* Since it has a unified TLB, and we can take data faults on
+	 * instruction pages by copying data, we have to check if the
+	 * EPN is already in the TLB.
+	 */
+	tlbsx.	r23, 0, r20
+	beq	6f
+
+	/* load the next available TLB index.
+	*/
+	lis	r22, tlb_4xx_index@h
+	ori	r22, r22, tlb_4xx_index@l
+	tophys(r22, r22)
+	lwz	r23, 0(r22)
+	addi	r23, r23, 1
+	andi.	r23, r23, (PPC4XX_TLB_SIZE-1)
+	stw	r23, 0(r22)
+
+6:
+	tlbwe	r21, r23, TLB_DATA		/* Load TLB LO */
+
+	/* Create EPN.  This is the faulting address plus a static
+	 * set of bits.  These are size, valid, E, U0, and ensure
+	 * bits 20 and 21 are zero.
+	 */
+	li	r22, 0x00c0
+	rlwimi	r20, r22, 0, 20, 31
+	tlbwe	r20, r23, TLB_TAG		/* Load TLB HI */
+
+	/* Done...restore registers and get out of here.
+	*/
+	mfspr	r22, SPRG6
+	mfspr	r21, SPRG7
+	mtspr	SPRN_PID, r22
+	mtcr	r21
+	mfspr	r23, SPRG5
+	mfspr	r22, SPRG4
+	mfspr	r21, SPRG1
+	mfspr	r20, SPRG0
+	rfi
+2:
+	/* The bailout.  Restore registers to pre-exception conditions
+	 * and call the heavyweights to help us out.
+	 */
+	mfspr	r22, SPRG6
+	mfspr	r21, SPRG7
+	mtspr	SPRN_PID, r22
+	mtcr	r21
+	mfspr	r23, SPRG5
+	mfspr	r22, SPRG4
+	mfspr	r21, SPRG1
+	mfspr	r20, SPRG0
+	b	InstructionAccess
+
 	/* Damn, I came up one instruction too many to fit into the
 	 * exception space :-).  Both the instruction and data TLB
 	 * miss get to this point to load the TLB.
@@ -961,6 +1193,22 @@
 	stw	r4, 0x4(r5)
 #endif
 	mtspr	SPRN_PID,r3
+	blr
+
+_GLOBAL(tlb_lookup_x)
+	lwz	r10,0(r3)
+_GLOBAL(tlb_lookup)
+	tlbsx.	r11,0,r3
+	beq	31415f
+	li	r3,0	/* No valid tlb entry */
+	not	r3,r3
+	blr
+31415:
+	tlbre	r3,r11,TLB_DATA
+	blr
+
+_GLOBAL(pid_lookup)
+	mfspr	r3,SPRN_PID
 	blr

 /* We put a few things here that have to be page-aligned. This stuff
diff -urN ../linuxppc_2_4_devel/arch/ppc/mm/pgtable.c linux-bungo/arch/ppc/mm/pgtable.c
--- ../linuxppc_2_4_devel/arch/ppc/mm/pgtable.c	Tue Aug 28 15:06:37 2001
+++ linux-bungo/arch/ppc/mm/pgtable.c	Mon Sep 10 17:09:57 2001
@@ -204,7 +204,7 @@
 		/* On the MPC8xx, we want the page shared so we
 		 * don't get ASID compares on kernel space.
 		 */
-		f = _PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_SHARED;
+		f = _PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_SHARED | _PAGE_EXEC;
 #if defined(CONFIG_KGDB) || defined(CONFIG_XMON)
 		/* Allows stub to set breakpoints everywhere */
 		f |= _PAGE_RW | _PAGE_DIRTY;
diff -urN ../linuxppc_2_4_devel/include/asm-ppc/pgtable.h linux-bungo/include/asm-ppc/pgtable.h
--- ../linuxppc_2_4_devel/include/asm-ppc/pgtable.h	Tue Aug 28 15:07:05 2001
+++ linux-bungo/include/asm-ppc/pgtable.h	Mon Sep 10 19:29:01 2001
@@ -217,16 +217,17 @@

 #if defined(CONFIG_4xx)
 /* Definitions for 4xx embedded chips. */
+/* Beware, there is deep magic in the ordering of these bits */
 #define	_PAGE_GUARDED	0x001	/* G: page is guarded from prefetch */
 #define	_PAGE_COHERENT	0x002	/* M: enforece memory coherence */
 #define	_PAGE_NO_CACHE	0x004	/* I: caching is inhibited */
 #define	_PAGE_WRITETHRU	0x008	/* W: caching is write-through */
 #define	_PAGE_USER	0x010	/* matches one of the zone permission bits */
-#define _PAGE_EXEC	0x020	/* software: i-cache coherency required */
-#define	_PAGE_PRESENT	0x040	/* software: PTE contains a translation */
-#define _PAGE_DIRTY	0x100	/* C: page changed */
-#define	_PAGE_RW	0x200	/* Writes permitted */
-#define _PAGE_ACCESSED	0x400	/* R: page referenced */
+#define	_PAGE_PRESENT	0x020	/* software: PTE contains a translation */
+#define _PAGE_ACCESSED	0x040	/* software: page referenced */
+#define _PAGE_RW	0x080	/* software: Writes permitted */
+#define _PAGE_DIRTY	0x100	/* WR: page changed */
+#define _PAGE_EXEC	0x200	/* EX: i-cache coherency required */

 #elif defined(CONFIG_8xx)
 /* Definitions for 8xx embedded chips. */
@@ -279,7 +280,7 @@
 #define _PAGE_BASE	_PAGE_PRESENT | _PAGE_ACCESSED
 #define _PAGE_WRENABLE	_PAGE_RW | _PAGE_DIRTY

-#define _PAGE_KERNEL	_PAGE_BASE | _PAGE_WRENABLE | _PAGE_SHARED
+#define _PAGE_KERNEL	_PAGE_BASE | _PAGE_WRENABLE | _PAGE_SHARED | _PAGE_EXEC
 #define _PAGE_IO	_PAGE_KERNEL | _PAGE_NO_CACHE | _PAGE_GUARDED

 #define PAGE_NONE	__pgprot(_PAGE_BASE)
@@ -291,7 +292,7 @@
 #define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)

 #define PAGE_KERNEL	__pgprot(_PAGE_KERNEL)
-#define PAGE_KERNEL_RO	__pgprot(_PAGE_BASE | _PAGE_SHARED)
+#define PAGE_KERNEL_RO	__pgprot(_PAGE_BASE | _PAGE_SHARED | _PAGE_EXEC)
 #define PAGE_KERNEL_CI	__pgprot(_PAGE_IO)

 /*


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
