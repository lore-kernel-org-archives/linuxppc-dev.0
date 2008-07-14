Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0731DDF69
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 23:09:57 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m6ED9rGu012851
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 08:09:54 -0500
Date: Mon, 14 Jul 2008 08:09:53 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc: rework FSL Book-E PTE access and TLB miss
In-Reply-To: <Pine.LNX.4.64.0807140808090.9284@blarg.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0807140809260.9284@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0807140808090.9284@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This converts the FSL Book-E PTE access and TLB miss handling to match
with the recent changes to 44x that introduce support for non-atomic PTE
operations in pgtable-ppc32.h and removes write back to the PTE from
the TLB miss handlers. In addition, the DSI interrupt code no longer
tries to fixup write permission, this is left to generic code, and
_PAGE_HWWRITE is gone.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

This will go via my powerpc-next tree.

 arch/powerpc/kernel/head_fsl_booke.S |  168 +++++++++-------------------------
 include/asm-powerpc/pgtable-ppc32.h  |   15 +--
 2 files changed, 48 insertions(+), 135 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index c426850..7d55496 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -483,90 +483,16 @@ interrupt_base:

 	/* Data Storage Interrupt */
 	START_EXCEPTION(DataStorage)
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
-	cmplw	0, r10, r11
-	bge	2f
-
-	/* Get the PGD for the current thread */
-3:
-	mfspr	r11,SPRN_SPRG3
-	lwz	r11,PGDIR(r11)
-4:
-	FIND_PTE
-
-	/* Are _PAGE_USER & _PAGE_RW set & _PAGE_HWWRITE not? */
-	andi.	r13, r11, _PAGE_RW|_PAGE_USER|_PAGE_HWWRITE
-	cmpwi	0, r13, _PAGE_RW|_PAGE_USER
-	bne	2f			/* Bail if not */
-
-	/* Update 'changed'. */
-	ori	r11, r11, _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE
-	stw	r11, PTE_FLAGS_OFFSET(r12) /* Update Linux page table */
-
-	/* MAS2 not updated as the entry does exist in the tlb, this
-	   fault taken to detect state transition (eg: COW -> DIRTY)
-	 */
-	andi.	r11, r11, _PAGE_HWEXEC
-	rlwimi	r11, r11, 31, 27, 27	/* SX <- _PAGE_HWEXEC */
-	ori	r11, r11, (MAS3_UW|MAS3_SW|MAS3_UR|MAS3_SR)@l /* set static perms */
-
-	/* update search PID in MAS6, AS = 0 */
-	mfspr	r12, SPRN_PID0
-	slwi	r12, r12, 16
-	mtspr	SPRN_MAS6, r12
-
-	/* find the TLB index that caused the fault.  It has to be here. */
-	tlbsx	0, r10
-
-	/* only update the perm bits, assume the RPN is fine */
-	mfspr	r12, SPRN_MAS3
-	rlwimi	r12, r11, 0, 20, 31
-	mtspr	SPRN_MAS3,r12
-	tlbwe
-
-	/* Done...restore registers and get out of here.  */
-	mfspr	r11, SPRN_SPRG7R
-	mtcr	r11
-	mfspr	r13, SPRN_SPRG5R
-	mfspr	r12, SPRN_SPRG4R
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
-	mfspr	r11, SPRN_SPRG1
-	mfspr	r10, SPRN_SPRG0
-	b	data_access
+	NORMAL_EXCEPTION_PROLOG
+	mfspr	r5,SPRN_ESR		/* Grab the ESR, save it, pass arg3 */
+	stw	r5,_ESR(r11)
+	mfspr	r4,SPRN_DEAR		/* Grab the DEAR, save it, pass arg2 */
+	andis.	r10,r5,(ESR_ILK|ESR_DLK)@h
+	bne	1f
+	EXC_XFER_EE_LITE(0x0300, handle_page_fault)
+1:
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	EXC_XFER_EE_LITE(0x0300, CacheLockingException)

 	/* Instruction Storage Interrupt */
 	INSTRUCTION_STORAGE_EXCEPTION
@@ -645,15 +571,30 @@ interrupt_base:
 	lwz	r11,PGDIR(r11)

 4:
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
+	rlwimi	r13,r12,11,29,29
+
 	FIND_PTE
-	andi.	r13, r11, _PAGE_PRESENT	/* Is the page present? */
-	beq	2f			/* Bail if not present */
+	andc.	r13,r13,r11		/* Check permission */
+	bne	2f			/* Bail if permission mismach */

 #ifdef CONFIG_PTE_64BIT
 	lwz	r13, 0(r12)
 #endif
-	ori	r11, r11, _PAGE_ACCESSED
-	stw	r11, PTE_FLAGS_OFFSET(r12)

 	 /* Jump to common tlb load */
 	b	finish_tlb_load
@@ -667,7 +608,7 @@ interrupt_base:
 	mfspr	r12, SPRN_SPRG4R
 	mfspr	r11, SPRN_SPRG1
 	mfspr	r10, SPRN_SPRG0
-	b	data_access
+	b	DataStorage

 	/* Instruction TLB Error Interrupt */
 	/*
@@ -705,15 +646,16 @@ interrupt_base:
 	lwz	r11,PGDIR(r11)

 4:
+	/* Make up the required permissions */
+	li	r13,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_HWEXEC
+
 	FIND_PTE
-	andi.	r13, r11, _PAGE_PRESENT	/* Is the page present? */
-	beq	2f			/* Bail if not present */
+	andc.	r13,r13,r11		/* Check permission */
+	bne	2f			/* Bail if permission mismach */

 #ifdef CONFIG_PTE_64BIT
 	lwz	r13, 0(r12)
 #endif
-	ori	r11, r11, _PAGE_ACCESSED
-	stw	r11, PTE_FLAGS_OFFSET(r12)

 	/* Jump to common TLB load point */
 	b	finish_tlb_load
@@ -768,29 +710,13 @@ interrupt_base:
  * Local functions
  */

-	/*
-	 * Data TLB exceptions will bail out to this point
-	 * if they can't resolve the lightweight TLB fault.
-	 */
-data_access:
-	NORMAL_EXCEPTION_PROLOG
-	mfspr	r5,SPRN_ESR		/* Grab the ESR, save it, pass arg3 */
-	stw	r5,_ESR(r11)
-	mfspr	r4,SPRN_DEAR		/* Grab the DEAR, save it, pass arg2 */
-	andis.	r10,r5,(ESR_ILK|ESR_DLK)@h
-	bne	1f
-	EXC_XFER_EE_LITE(0x0300, handle_page_fault)
-1:
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_EE_LITE(0x0300, CacheLockingException)
-
 /*
-
  * Both the instruction and data TLB miss get to this
  * point to load the TLB.
  *	r10 - EA of fault
  *	r11 - TLB (info from Linux PTE)
- *	r12, r13 - available to use
+ *	r12 - available to use
+ *	r13 - upper bits of PTE (if PTE_64BIT) or available to use
  *	CR5 - results of addr >= PAGE_OFFSET
  *	MAS0, MAS1 - loaded with proper value when we get here
  *	MAS2, MAS3 - will need additional info from Linux PTE
@@ -812,20 +738,14 @@ finish_tlb_load:
 #endif
 	mtspr	SPRN_MAS2, r12

-	bge	5, 1f
-
-	/* is user addr */
-	andi.	r12, r11, (_PAGE_USER | _PAGE_HWWRITE | _PAGE_HWEXEC)
+	li	r10, (_PAGE_HWEXEC | _PAGE_PRESENT)
+	rlwimi	r10, r11, 31, 29, 29	/* extract _PAGE_DIRTY into SW */
+	and	r12, r11, r10
 	andi.	r10, r11, _PAGE_USER	/* Test for _PAGE_USER */
-	srwi	r10, r12, 1
-	or	r12, r12, r10	/* Copy user perms into supervisor */
-	iseleq	r12, 0, r12
-	b	2f
-
-	/* is kernel addr */
-1:	rlwinm	r12, r11, 31, 29, 29	/* Extract _PAGE_HWWRITE into SW */
-	ori	r12, r12, (MAS3_SX | MAS3_SR)
-
+	slwi	r10, r12, 1
+	or	r10, r10, r12
+	iseleq	r12, r12, r10
+
 #ifdef CONFIG_PTE_64BIT
 2:	rlwimi	r12, r13, 24, 0, 7	/* grab RPN[32:39] */
 	rlwimi	r12, r11, 24, 8, 19	/* grab RPN[40:51] */
diff --git a/include/asm-powerpc/pgtable-ppc32.h b/include/asm-powerpc/pgtable-ppc32.h
index 73015f0..3a96d00 100644
--- a/include/asm-powerpc/pgtable-ppc32.h
+++ b/include/asm-powerpc/pgtable-ppc32.h
@@ -295,10 +295,10 @@ extern int icache_44x_need_flush;
 #define _PAGE_PRESENT	0x00001	/* S: PTE contains a translation */
 #define _PAGE_USER	0x00002	/* S: User page (maps to UR) */
 #define _PAGE_FILE	0x00002	/* S: when !present: nonlinear file mapping */
-#define _PAGE_ACCESSED	0x00004	/* S: Page referenced */
-#define _PAGE_HWWRITE	0x00008	/* H: Dirty & RW, set in exception */
-#define _PAGE_RW	0x00010	/* S: Write permission */
-#define _PAGE_HWEXEC	0x00020	/* H: UX permission */
+#define _PAGE_RW	0x00004	/* S: Write permission (SW) */
+#define _PAGE_DIRTY	0x00008	/* S: Page dirty */
+#define _PAGE_HWEXEC	0x00010	/* H: SX permission */
+#define _PAGE_ACCESSED	0x00020	/* S: Page referenced */

 #define _PAGE_ENDIAN	0x00040	/* H: E bit */
 #define _PAGE_GUARDED	0x00080	/* H: G bit */
@@ -307,21 +307,14 @@ extern int icache_44x_need_flush;
 #define _PAGE_WRITETHRU	0x00400	/* H: W bit */

 #ifdef CONFIG_PTE_64BIT
-#define _PAGE_DIRTY	0x08000	/* S: Page dirty */
-
 /* ERPN in a PTE never gets cleared, ignore it */
 #define _PTE_NONE_MASK	0xffffffffffff0000ULL
-#else
-#define _PAGE_DIRTY	0x00800	/* S: Page dirty */
 #endif

 #define _PMD_PRESENT	0
 #define _PMD_PRESENT_MASK (PAGE_MASK)
 #define _PMD_BAD	(~PAGE_MASK)

-/* Until my rework is finished, FSL BookE still needs atomic PTE updates */
-#define PTE_ATOMIC_UPDATES	1
-
 #elif defined(CONFIG_8xx)
 /* Definitions for 8xx embedded chips. */
 #define _PAGE_PRESENT	0x0001	/* Page is valid */
-- 
1.5.5.1
