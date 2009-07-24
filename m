Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D009B100835
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 19:16:10 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 24 Jul 2009 19:15:47 +1000
Subject: [PATCH 18/20] powerpc: Add TLB management code for 64-bit Book3E (v2)
In-Reply-To: <1248426902.401617.944220131651.qpush@grosgo>
Message-Id: <20090724091610.BCD7DDDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds the TLB miss handler assembly, the low level TLB flush routines
along with the necessary hook for dealing with our virtual page tables
or indirect TLB entries that need to be flushes when PTE pages are freed.

There is currently no support for hugetlbfs

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2. Don't break non-Book3E nohash platforms

 arch/powerpc/include/asm/mmu-40x.h     |    3 
 arch/powerpc/include/asm/mmu-44x.h     |    6 
 arch/powerpc/include/asm/mmu-8xx.h     |    3 
 arch/powerpc/include/asm/mmu-hash32.h  |    6 
 arch/powerpc/include/asm/mmu_context.h |    8 
 arch/powerpc/kernel/setup_64.c         |    4 
 arch/powerpc/mm/mmu_decl.h             |   14 
 arch/powerpc/mm/tlb_low_64e.S          |  734 +++++++++++++++++++++++++++++++++
 arch/powerpc/mm/tlb_nohash.c           |  203 ++++++++-
 arch/powerpc/mm/tlb_nohash_low.S       |   79 +++
 10 files changed, 1055 insertions(+), 5 deletions(-)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/mm/tlb_low_64e.S	2009-07-24 18:15:31.000000000 +1000
@@ -0,0 +1,734 @@
+/*
+ *  Low leve TLB miss handlers for Book3E
+ *
+ *  Copyright (C) 2008-2009
+ *      Ben. Herrenschmidt (benh@kernel.crashing.org), IBM Corp.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/processor.h>
+#include <asm/reg.h>
+#include <asm/page.h>
+#include <asm/mmu.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/cputable.h>
+#include <asm/pgtable.h>
+#include <asm/reg.h>
+#include <asm/exception-64e.h>
+#include <asm/ppc-opcode.h>
+
+#ifdef CONFIG_PPC_64K_PAGES
+#define VPTE_PMD_SHIFT	(PTE_INDEX_SIZE+1)
+#else
+#define VPTE_PMD_SHIFT	(PTE_INDEX_SIZE)
+#endif
+#define VPTE_PUD_SHIFT	(VPTE_PMD_SHIFT + PMD_INDEX_SIZE)
+#define VPTE_PGD_SHIFT	(VPTE_PUD_SHIFT + PUD_INDEX_SIZE)
+#define VPTE_INDEX_SIZE (VPTE_PGD_SHIFT + PGD_INDEX_SIZE)
+
+
+/**********************************************************************
+ *                                                                    *
+ * TLB miss handling for Book3E with TLB reservation and HES support  *
+ *                                                                    *
+ **********************************************************************/
+
+
+/* Data TLB miss */
+	START_EXCEPTION(data_tlb_miss)
+	TLB_MISS_PROLOG
+
+	/* Now we handle the fault proper. We only save DEAR in normal
+	 * fault case since that's the only interesting values here.
+	 * We could probably also optimize by not saving SRR0/1 in the
+	 * linear mapping case but I'll leave that for later
+	 */
+	mfspr	r14,SPRN_ESR
+	mfspr	r16,SPRN_DEAR		/* get faulting address */
+	srdi	r15,r16,60		/* get region */
+	cmpldi	cr0,r15,0xc		/* linear mapping ? */
+	TLB_MISS_STATS_SAVE_INFO
+	beq	tlb_load_linear		/* yes -> go to linear map load */
+
+	/* The page tables are mapped virtually linear. At this point, though,
+	 * we don't know whether we are trying to fault in a first level
+	 * virtual address or a virtual page table address. We can get that
+	 * from bit 0x1 of the region ID which we have set for a page table
+	 */
+	andi.	r10,r15,0x1
+	bne-	virt_page_table_tlb_miss
+
+	std	r14,EX_TLB_ESR(r12);	/* save ESR */
+	std	r16,EX_TLB_DEAR(r12);	/* save DEAR */
+
+	 /* We need _PAGE_PRESENT and  _PAGE_ACCESSED set */
+	li	r11,_PAGE_PRESENT
+	oris	r11,r11,_PAGE_ACCESSED@h
+
+	/* We do the user/kernel test for the PID here along with the RW test
+	 */
+	cmpldi	cr0,r15,0		/* Check for user region */
+
+	/* We pre-test some combination of permissions to avoid double
+	 * faults:
+	 *
+	 * We move the ESR:ST bit into the position of _PAGE_BAP_SW in the PTE
+	 * ESR_ST   is 0x00800000
+	 * _PAGE_BAP_SW is 0x00000010
+	 * So the shift is >> 19. This tests for supervisor writeability.
+	 * If the page happens to be supervisor writeable and not user
+	 * writeable, we will take a new fault later, but that should be
+	 * a rare enough case.
+	 *
+	 * We also move ESR_ST in _PAGE_DIRTY position
+	 * _PAGE_DIRTY is 0x00001000 so the shift is >> 11
+	 *
+	 * MAS1 is preset for all we need except for TID that needs to
+	 * be cleared for kernel translations
+	 */
+	rlwimi	r11,r14,32-19,27,27
+	rlwimi	r11,r14,32-16,19,19
+	beq	normal_tlb_miss
+	/* XXX replace the RMW cycles with immediate loads + writes */
+1:	mfspr	r10,SPRN_MAS1
+	cmpldi	cr0,r15,8		/* Check for vmalloc region */
+	rlwinm	r10,r10,0,16,1		/* Clear TID */
+	mtspr	SPRN_MAS1,r10
+	beq+	normal_tlb_miss
+
+	/* We got a crappy address, just fault with whatever DEAR and ESR
+	 * are here
+	 */
+	TLB_MISS_STATS_D(MMSTAT_TLB_MISS_NORM_FAULT)
+	TLB_MISS_EPILOG_ERROR
+	b	exc_data_storage_book3e
+
+/* Instruction TLB miss */
+	START_EXCEPTION(instruction_tlb_miss)
+	TLB_MISS_PROLOG
+
+	/* If we take a recursive fault, the second level handler may need
+	 * to know whether we are handling a data or instruction fault in
+	 * order to get to the right store fault handler. We provide that
+	 * info by writing a crazy value in ESR in our exception frame
+	 */
+	li	r14,-1	/* store to exception frame is done later */
+
+	/* Now we handle the fault proper. We only save DEAR in the non
+	 * linear mapping case since we know the linear mapping case will
+	 * not re-enter. We could indeed optimize and also not save SRR0/1
+	 * in the linear mapping case but I'll leave that for later
+	 *
+	 * Faulting address is SRR0 which is already in r16
+	 */
+	srdi	r15,r16,60		/* get region */
+	cmpldi	cr0,r15,0xc		/* linear mapping ? */
+	TLB_MISS_STATS_SAVE_INFO
+	beq	tlb_load_linear		/* yes -> go to linear map load */
+
+	/* We do the user/kernel test for the PID here along with the RW test
+	 */
+	li	r11,_PAGE_PRESENT|_PAGE_HWEXEC	/* Base perm */
+	oris	r11,r11,_PAGE_ACCESSED@h
+
+	cmpldi	cr0,r15,0			/* Check for user region */
+	std	r14,EX_TLB_ESR(r12)		/* write crazy -1 to frame */
+	beq	normal_tlb_miss
+	/* XXX replace the RMW cycles with immediate loads + writes */
+1:	mfspr	r10,SPRN_MAS1
+	cmpldi	cr0,r15,8			/* Check for vmalloc region */
+	rlwinm	r10,r10,0,16,1			/* Clear TID */
+	mtspr	SPRN_MAS1,r10
+	beq+	normal_tlb_miss
+
+	/* We got a crappy address, just fault */
+	TLB_MISS_STATS_I(MMSTAT_TLB_MISS_NORM_FAULT)
+	TLB_MISS_EPILOG_ERROR
+	b	exc_instruction_storage_book3e
+
+/*
+ * This is the guts of the first-level TLB miss handler for direct
+ * misses. We are entered with:
+ *
+ * r16 = faulting address
+ * r15 = region ID
+ * r14 = crap (free to use)
+ * r13 = PACA
+ * r12 = TLB exception frame in PACA
+ * r11 = PTE permission mask
+ * r10 = crap (free to use)
+ */
+normal_tlb_miss:
+	/* So we first construct the page table address. We do that by
+	 * shifting the bottom of the address (not the region ID) by
+	 * PAGE_SHIFT-3, clearing the bottom 3 bits (get a PTE ptr) and
+	 * or'ing the fourth high bit.
+	 *
+	 * NOTE: For 64K pages, we do things slightly differently in
+	 * order to handle the weird page table format used by linux
+	 */
+	ori	r10,r15,0x1
+#ifdef CONFIG_PPC_64K_PAGES
+	/* For the top bits, 16 bytes per PTE */
+	rldicl	r14,r16,64-(PAGE_SHIFT-4),PAGE_SHIFT-4+4
+	/* Now create the bottom bits as 0 in position 0x8000 and
+	 * the rest calculated for 8 bytes per PTE
+	 */
+	rldicl	r15,r16,64-(PAGE_SHIFT-3),64-15
+	/* Insert the bottom bits in */
+	rlwimi	r14,r15,0,16,31
+#else
+	rldicl	r14,r16,64-(PAGE_SHIFT-3),PAGE_SHIFT-3+4
+#endif
+	sldi	r15,r10,60
+	clrrdi	r14,r14,3
+	or	r10,r15,r14
+
+	/* Set the TLB reservation and seach for existing entry. Then load
+	 * the entry.
+	 */
+	PPC_TLBSRX_DOT(0,r16)
+	ld	r14,0(r10)
+	beq	normal_tlb_miss_done
+
+finish_normal_tlb_miss:
+	/* Check if required permissions are met */
+	andc.	r15,r11,r14
+	bne-	normal_tlb_miss_access_fault
+
+	/* Now we build the MAS:
+	 *
+	 * MAS 0   :	Fully setup with defaults in MAS4 and TLBnCFG
+	 * MAS 1   :	Almost fully setup
+	 *               - PID already updated by caller if necessary
+	 *               - TSIZE need change if !base page size, not
+	 *                 yet implemented for now
+	 * MAS 2   :	Defaults not useful, need to be redone
+	 * MAS 3+7 :	Needs to be done
+	 *
+	 * TODO: mix up code below for better scheduling
+	 */
+	clrrdi	r11,r16,12		/* Clear low crap in EA */
+	rlwimi	r11,r14,32-19,27,31	/* Insert WIMGE */
+	mtspr	SPRN_MAS2,r11
+
+	/* Check page size, if not standard, update MAS1 */
+	rldicl	r11,r14,64-8,64-8
+#ifdef CONFIG_PPC_64K_PAGES
+	cmpldi	cr0,r11,BOOK3E_PAGESZ_64K
+#else
+	cmpldi	cr0,r11,BOOK3E_PAGESZ_4K
+#endif
+	beq-	1f
+	mfspr	r11,SPRN_MAS1
+	rlwimi	r11,r14,31,21,24
+	rlwinm	r11,r11,0,21,19
+	mtspr	SPRN_MAS1,r11
+1:
+	/* Move RPN in position */
+	rldicr	r11,r14,64-(PTE_RPN_SHIFT-PAGE_SHIFT),63-PAGE_SHIFT
+	clrldi	r15,r11,12		/* Clear crap at the top */
+	rlwimi	r15,r14,32-8,22,25	/* Move in U bits */
+	rlwimi	r15,r14,32-2,26,31	/* Move in BAP bits */
+
+	/* Mask out SW and UW if !DIRTY (XXX optimize this !) */
+	andi.	r11,r14,_PAGE_DIRTY
+	bne	1f
+	li	r11,MAS3_SW|MAS3_UW
+	andc	r15,r15,r11
+1:	mtspr	SPRN_MAS7_MAS3,r15
+
+	tlbwe
+
+normal_tlb_miss_done:
+	/* We don't bother with restoring DEAR or ESR since we know we are
+	 * level 0 and just going back to userland. They are only needed
+	 * if you are going to take an access fault
+	 */
+	TLB_MISS_STATS_X(MMSTAT_TLB_MISS_NORM_OK)
+	TLB_MISS_EPILOG_SUCCESS
+	rfi
+
+normal_tlb_miss_access_fault:
+	/* We need to check if it was an instruction miss */
+	andi.	r10,r11,_PAGE_HWEXEC
+	bne	1f
+	ld	r14,EX_TLB_DEAR(r12)
+	ld	r15,EX_TLB_ESR(r12)
+	mtspr	SPRN_DEAR,r14
+	mtspr	SPRN_ESR,r15
+	TLB_MISS_STATS_D(MMSTAT_TLB_MISS_NORM_FAULT)
+	TLB_MISS_EPILOG_ERROR
+	b	exc_data_storage_book3e
+1:	TLB_MISS_STATS_I(MMSTAT_TLB_MISS_NORM_FAULT)
+	TLB_MISS_EPILOG_ERROR
+	b	exc_instruction_storage_book3e
+
+
+/*
+ * This is the guts of the second-level TLB miss handler for direct
+ * misses. We are entered with:
+ *
+ * r16 = virtual page table faulting address
+ * r15 = region (top 4 bits of address)
+ * r14 = crap (free to use)
+ * r13 = PACA
+ * r12 = TLB exception frame in PACA
+ * r11 = crap (free to use)
+ * r10 = crap (free to use)
+ *
+ * Note that this should only ever be called as a second level handler
+ * with the current scheme when using SW load.
+ * That means we can always get the original fault DEAR at
+ * EX_TLB_DEAR-EX_TLB_SIZE(r12)
+ *
+ * It can be re-entered by the linear mapping miss handler. However, to
+ * avoid too much complication, it will restart the whole fault at level
+ * 0 so we don't care too much about clobbers
+ *
+ * XXX That code was written back when we couldn't clobber r14. We can now,
+ * so we could probably optimize things a bit
+ */
+virt_page_table_tlb_miss:
+	/* Are we hitting a kernel page table ? */
+	andi.	r10,r15,0x8
+
+	/* The cool thing now is that r10 contains 0 for user and 8 for kernel,
+	 * and we happen to have the swapper_pg_dir at offset 8 from the user
+	 * pgdir in the PACA :-).
+	 */
+	add	r11,r10,r13
+
+	/* If kernel, we need to clear MAS1 TID */
+	beq	1f
+	/* XXX replace the RMW cycles with immediate loads + writes */
+	mfspr	r10,SPRN_MAS1
+	rlwinm	r10,r10,0,16,1			/* Clear TID */
+	mtspr	SPRN_MAS1,r10
+1:
+	/* Search if we already have a TLB entry for that virtual address, and
+	 * if we do, bail out.
+	 */
+	PPC_TLBSRX_DOT(0,r16)
+	beq	virt_page_table_tlb_miss_done
+
+	/* Now, we need to walk the page tables. First check if we are in
+	 * range.
+	 */
+	rldicl.	r10,r16,64-(VPTE_INDEX_SIZE+3),VPTE_INDEX_SIZE+3+4
+	bne-	virt_page_table_tlb_miss_fault
+
+	/* Get the PGD pointer */
+	ld	r15,PACAPGD(r11)
+	cmpldi	cr0,r15,0
+	beq-	virt_page_table_tlb_miss_fault
+
+	/* Get to PGD entry */
+	rldicl	r11,r16,64-VPTE_PGD_SHIFT,64-PGD_INDEX_SIZE-3
+	clrrdi	r10,r11,3
+	ldx	r15,r10,r15
+	cmpldi	cr0,r15,0
+	beq	virt_page_table_tlb_miss_fault
+
+#ifndef CONFIG_PPC_64K_PAGES
+	/* Get to PUD entry */
+	rldicl	r11,r16,64-VPTE_PUD_SHIFT,64-PUD_INDEX_SIZE-3
+	clrrdi	r10,r11,3
+	ldx	r15,r10,r15
+	cmpldi	cr0,r15,0
+	beq	virt_page_table_tlb_miss_fault
+#endif /* CONFIG_PPC_64K_PAGES */
+
+	/* Get to PMD entry */
+	rldicl	r11,r16,64-VPTE_PMD_SHIFT,64-PMD_INDEX_SIZE-3
+	clrrdi	r10,r11,3
+	ldx	r15,r10,r15
+	cmpldi	cr0,r15,0
+	beq	virt_page_table_tlb_miss_fault
+
+	/* Ok, we're all right, we can now create a kernel translation for
+	 * a 4K or 64K page from r16 -> r15.
+	 */
+	/* Now we build the MAS:
+	 *
+	 * MAS 0   :	Fully setup with defaults in MAS4 and TLBnCFG
+	 * MAS 1   :	Almost fully setup
+	 *               - PID already updated by caller if necessary
+	 *               - TSIZE for now is base page size always
+	 * MAS 2   :	Use defaults
+	 * MAS 3+7 :	Needs to be done
+	 *
+	 * So we only do MAS 2 and 3 for now...
+	 */
+	clrldi	r11,r15,4		/* remove region ID from RPN */
+	ori	r10,r11,1		/* Or-in SR */
+	mtspr	SPRN_MAS7_MAS3,r10
+
+	tlbwe
+
+virt_page_table_tlb_miss_done:
+
+	/* We have overriden MAS2:EPN but currently our primary TLB miss
+	 * handler will always restore it so that should not be an issue,
+	 * if we ever optimize the primary handler to not write MAS2 on
+	 * some cases, we'll have to restore MAS2:EPN here based on the
+	 * original fault's DEAR. If we do that we have to modify the
+	 * ITLB miss handler to also store SRR0 in the exception frame
+	 * as DEAR.
+	 *
+	 * However, one nasty thing we did is we cleared the reservation
+	 * (well, potentially we did). We do a trick here thus if we
+	 * are not a level 0 exception (we interrupted the TLB miss) we
+	 * offset the return address by -4 in order to replay the tlbsrx
+	 * instruction there
+	 */
+	subf	r10,r13,r12
+	cmpldi	cr0,r10,PACA_EXTLB+EX_TLB_SIZE
+	bne-	1f
+	ld	r11,PACA_EXTLB+EX_TLB_SIZE+EX_TLB_SRR0(r13)
+	addi	r10,r11,-4
+	std	r10,PACA_EXTLB+EX_TLB_SIZE+EX_TLB_SRR0(r13)
+1:
+	/* Return to caller, normal case */
+	TLB_MISS_STATS_X(MMSTAT_TLB_MISS_PT_OK);
+	TLB_MISS_EPILOG_SUCCESS
+	rfi
+
+virt_page_table_tlb_miss_fault:
+	/* If we fault here, things are a little bit tricky. We need to call
+	 * either data or instruction store fault, and we need to retreive
+	 * the original fault address and ESR (for data).
+	 *
+	 * The thing is, we know that in normal circumstances, this is
+	 * always called as a second level tlb miss for SW load or as a first
+	 * level TLB miss for HW load, so we should be able to peek at the
+	 * relevant informations in the first exception frame in the PACA.
+	 *
+	 * However, we do need to double check that, because we may just hit
+	 * a stray kernel pointer or a userland attack trying to hit those
+	 * areas. If that is the case, we do a data fault. (We can't get here
+	 * from an instruction tlb miss anyway).
+	 *
+	 * Note also that when going to a fault, we must unwind the previous
+	 * level as well. Since we are doing that, we don't need to clear or
+	 * restore the TLB reservation neither.
+	 */
+	subf	r10,r13,r12
+	cmpldi	cr0,r10,PACA_EXTLB+EX_TLB_SIZE
+	bne-	virt_page_table_tlb_miss_whacko_fault
+
+	/* We dig the original DEAR and ESR from slot 0 */
+	ld	r15,EX_TLB_DEAR+PACA_EXTLB(r13)
+	ld	r16,EX_TLB_ESR+PACA_EXTLB(r13)
+
+	/* We check for the "special" ESR value for instruction faults */
+	cmpdi	cr0,r16,-1
+	beq	1f
+	mtspr	SPRN_DEAR,r15
+	mtspr	SPRN_ESR,r16
+	TLB_MISS_STATS_D(MMSTAT_TLB_MISS_PT_FAULT);
+	TLB_MISS_EPILOG_ERROR
+	b	exc_data_storage_book3e
+1:	TLB_MISS_STATS_I(MMSTAT_TLB_MISS_PT_FAULT);
+	TLB_MISS_EPILOG_ERROR
+	b	exc_instruction_storage_book3e
+
+virt_page_table_tlb_miss_whacko_fault:
+	/* The linear fault will restart everything so ESR and DEAR will
+	 * not have been clobbered, let's just fault with what we have
+	 */
+	TLB_MISS_STATS_X(MMSTAT_TLB_MISS_PT_FAULT);
+	TLB_MISS_EPILOG_ERROR
+	b	exc_data_storage_book3e
+
+
+/**************************************************************
+ *                                                            *
+ * TLB miss handling for Book3E with hw page table support    *
+ *                                                            *
+ **************************************************************/
+
+
+/* Data TLB miss */
+	START_EXCEPTION(data_tlb_miss_htw)
+	TLB_MISS_PROLOG
+
+	/* Now we handle the fault proper. We only save DEAR in normal
+	 * fault case since that's the only interesting values here.
+	 * We could probably also optimize by not saving SRR0/1 in the
+	 * linear mapping case but I'll leave that for later
+	 */
+	mfspr	r14,SPRN_ESR
+	mfspr	r16,SPRN_DEAR		/* get faulting address */
+	srdi	r11,r16,60		/* get region */
+	cmpldi	cr0,r11,0xc		/* linear mapping ? */
+	TLB_MISS_STATS_SAVE_INFO
+	beq	tlb_load_linear		/* yes -> go to linear map load */
+
+	/* We do the user/kernel test for the PID here along with the RW test
+	 */
+	cmpldi	cr0,r11,0		/* Check for user region */
+	ld	r15,PACAPGD(r13)	/* Load user pgdir */
+	beq	htw_tlb_miss
+
+	/* XXX replace the RMW cycles with immediate loads + writes */
+1:	mfspr	r10,SPRN_MAS1
+	cmpldi	cr0,r11,8		/* Check for vmalloc region */
+	rlwinm	r10,r10,0,16,1		/* Clear TID */
+	mtspr	SPRN_MAS1,r10
+	ld	r15,PACA_KERNELPGD(r13)	/* Load kernel pgdir */
+	beq+	htw_tlb_miss
+
+	/* We got a crappy address, just fault with whatever DEAR and ESR
+	 * are here
+	 */
+	TLB_MISS_STATS_D(MMSTAT_TLB_MISS_NORM_FAULT)
+	TLB_MISS_EPILOG_ERROR
+	b	exc_data_storage_book3e
+
+/* Instruction TLB miss */
+	START_EXCEPTION(instruction_tlb_miss_htw)
+	TLB_MISS_PROLOG
+
+	/* If we take a recursive fault, the second level handler may need
+	 * to know whether we are handling a data or instruction fault in
+	 * order to get to the right store fault handler. We provide that
+	 * info by keeping a crazy value for ESR in r14
+	 */
+	li	r14,-1	/* store to exception frame is done later */
+
+	/* Now we handle the fault proper. We only save DEAR in the non
+	 * linear mapping case since we know the linear mapping case will
+	 * not re-enter. We could indeed optimize and also not save SRR0/1
+	 * in the linear mapping case but I'll leave that for later
+	 *
+	 * Faulting address is SRR0 which is already in r16
+	 */
+	srdi	r11,r16,60		/* get region */
+	cmpldi	cr0,r11,0xc		/* linear mapping ? */
+	TLB_MISS_STATS_SAVE_INFO
+	beq	tlb_load_linear		/* yes -> go to linear map load */
+
+	/* We do the user/kernel test for the PID here along with the RW test
+	 */
+	cmpldi	cr0,r11,0			/* Check for user region */
+	ld	r15,PACAPGD(r13)		/* Load user pgdir */
+	beq	htw_tlb_miss
+
+	/* XXX replace the RMW cycles with immediate loads + writes */
+1:	mfspr	r10,SPRN_MAS1
+	cmpldi	cr0,r11,8			/* Check for vmalloc region */
+	rlwinm	r10,r10,0,16,1			/* Clear TID */
+	mtspr	SPRN_MAS1,r10
+	ld	r15,PACA_KERNELPGD(r13)		/* Load kernel pgdir */
+	beq+	htw_tlb_miss
+
+	/* We got a crappy address, just fault */
+	TLB_MISS_STATS_I(MMSTAT_TLB_MISS_NORM_FAULT)
+	TLB_MISS_EPILOG_ERROR
+	b	exc_instruction_storage_book3e
+
+
+/*
+ * This is the guts of the second-level TLB miss handler for direct
+ * misses. We are entered with:
+ *
+ * r16 = virtual page table faulting address
+ * r15 = PGD pointer
+ * r14 = ESR
+ * r13 = PACA
+ * r12 = TLB exception frame in PACA
+ * r11 = crap (free to use)
+ * r10 = crap (free to use)
+ *
+ * It can be re-entered by the linear mapping miss handler. However, to
+ * avoid too much complication, it will save/restore things for us
+ */
+htw_tlb_miss:
+	/* Search if we already have a TLB entry for that virtual address, and
+	 * if we do, bail out.
+	 *
+	 * MAS1:IND should be already set based on MAS4
+	 */
+	PPC_TLBSRX_DOT(0,r16)
+	beq	htw_tlb_miss_done
+
+	/* Now, we need to walk the page tables. First check if we are in
+	 * range.
+	 */
+	rldicl.	r10,r16,64-PGTABLE_EADDR_SIZE,PGTABLE_EADDR_SIZE+4
+	bne-	htw_tlb_miss_fault
+
+	/* Get the PGD pointer */
+	cmpldi	cr0,r15,0
+	beq-	htw_tlb_miss_fault
+
+	/* Get to PGD entry */
+	rldicl	r11,r16,64-(PGDIR_SHIFT-3),64-PGD_INDEX_SIZE-3
+	clrrdi	r10,r11,3
+	ldx	r15,r10,r15
+	cmpldi	cr0,r15,0
+	beq	htw_tlb_miss_fault
+
+#ifndef CONFIG_PPC_64K_PAGES
+	/* Get to PUD entry */
+	rldicl	r11,r16,64-(PUD_SHIFT-3),64-PUD_INDEX_SIZE-3
+	clrrdi	r10,r11,3
+	ldx	r15,r10,r15
+	cmpldi	cr0,r15,0
+	beq	htw_tlb_miss_fault
+#endif /* CONFIG_PPC_64K_PAGES */
+
+	/* Get to PMD entry */
+	rldicl	r11,r16,64-(PMD_SHIFT-3),64-PMD_INDEX_SIZE-3
+	clrrdi	r10,r11,3
+	ldx	r15,r10,r15
+	cmpldi	cr0,r15,0
+	beq	htw_tlb_miss_fault
+
+	/* Ok, we're all right, we can now create an indirect entry for
+	 * a 1M or 256M page.
+	 *
+	 * The last trick is now that because we use "half" pages for
+	 * the HTW (1M IND is 2K and 256M IND is 32K) we need to account
+	 * for an added LSB bit to the RPN. For 64K pages, there is no
+	 * problem as we already use 32K arrays (half PTE pages), but for
+	 * 4K page we need to extract a bit from the virtual address and
+	 * insert it into the "PA52" bit of the RPN.
+	 */
+#ifndef CONFIG_PPC_64K_PAGES
+	rlwimi	r15,r16,32-9,20,20
+#endif
+	/* Now we build the MAS:
+	 *
+	 * MAS 0   :	Fully setup with defaults in MAS4 and TLBnCFG
+	 * MAS 1   :	Almost fully setup
+	 *               - PID already updated by caller if necessary
+	 *               - TSIZE for now is base ind page size always
+	 * MAS 2   :	Use defaults
+	 * MAS 3+7 :	Needs to be done
+	 */
+#ifdef CONFIG_PPC_64K_PAGES
+	ori	r10,r15,(BOOK3E_PAGESZ_64K << MAS3_SPSIZE_SHIFT)
+#else
+	ori	r10,r15,(BOOK3E_PAGESZ_4K << MAS3_SPSIZE_SHIFT)
+#endif
+	mtspr	SPRN_MAS7_MAS3,r10
+
+	tlbwe
+
+htw_tlb_miss_done:
+	/* We don't bother with restoring DEAR or ESR since we know we are
+	 * level 0 and just going back to userland. They are only needed
+	 * if you are going to take an access fault
+	 */
+	TLB_MISS_STATS_X(MMSTAT_TLB_MISS_PT_OK)
+	TLB_MISS_EPILOG_SUCCESS
+	rfi
+
+htw_tlb_miss_fault:
+	/* We need to check if it was an instruction miss. We know this
+	 * though because r14 would contain -1
+	 */
+	cmpdi	cr0,r14,-1
+	beq	1f
+	mtspr	SPRN_DEAR,r16
+	mtspr	SPRN_ESR,r14
+	TLB_MISS_STATS_D(MMSTAT_TLB_MISS_PT_FAULT)
+	TLB_MISS_EPILOG_ERROR
+	b	exc_data_storage_book3e
+1:	TLB_MISS_STATS_I(MMSTAT_TLB_MISS_PT_FAULT)
+	TLB_MISS_EPILOG_ERROR
+	b	exc_instruction_storage_book3e
+
+/*
+ * This is the guts of "any" level TLB miss handler for kernel linear
+ * mapping misses. We are entered with:
+ *
+ *
+ * r16 = faulting address
+ * r15 = crap (free to use)
+ * r14 = ESR (data) or -1 (instruction)
+ * r13 = PACA
+ * r12 = TLB exception frame in PACA
+ * r11 = crap (free to use)
+ * r10 = crap (free to use)
+ *
+ * In addition we know that we will not re-enter, so in theory, we could
+ * use a simpler epilog not restoring SRR0/1 etc.. but we'll do that later.
+ *
+ * We also need to be careful about MAS registers here & TLB reservation,
+ * as we know we'll have clobbered them if we interrupt the main TLB miss
+ * handlers in which case we probably want to do a full restart at level
+ * 0 rather than saving / restoring the MAS.
+ *
+ * Note: If we care about performance of that core, we can easily shuffle
+ *       a few things around
+ */
+tlb_load_linear:
+	/* For now, we assume the linear mapping is contiguous and stops at
+	 * linear_map_top. We also assume the size is a multiple of 1G, thus
+	 * we only use 1G pages for now. That might have to be changed in a
+	 * final implementation, especially when dealing with hypervisors
+	 */
+	ld	r11,PACATOC(r13)
+	ld	r11,linear_map_top@got(r11)
+	ld	r10,0(r11)
+	cmpld	cr0,r10,r16
+	bge	tlb_load_linear_fault
+
+	/* MAS1 need whole new setup. */
+	li	r15,(BOOK3E_PAGESZ_1GB<<MAS1_TSIZE_SHIFT)
+	oris	r15,r15,MAS1_VALID@h	/* MAS1 needs V and TSIZE */
+	mtspr	SPRN_MAS1,r15
+
+	/* Already somebody there ? */
+	PPC_TLBSRX_DOT(0,r16)
+	beq	tlb_load_linear_done
+
+	/* Now we build the remaining MAS. MAS0 and 2 should be fine
+	 * with their defaults, which leaves us with MAS 3 and 7. The
+	 * mapping is linear, so we just take the address, clear the
+	 * region bits, and or in the permission bits which are currently
+	 * hard wired
+	 */
+	clrrdi	r10,r16,30		/* 1G page index */
+	clrldi	r10,r10,4		/* clear region bits */
+	ori	r10,r10,MAS3_SR|MAS3_SW|MAS3_SX
+	mtspr	SPRN_MAS7_MAS3,r10
+
+	tlbwe
+
+tlb_load_linear_done:
+	/* We use the "error" epilog for success as we do want to
+	 * restore to the initial faulting context, whatever it was.
+	 * We do that because we can't resume a fault within a TLB
+	 * miss handler, due to MAS and TLB reservation being clobbered.
+	 */
+	TLB_MISS_STATS_X(MMSTAT_TLB_MISS_LINEAR)
+	TLB_MISS_EPILOG_ERROR
+	rfi
+
+tlb_load_linear_fault:
+	/* We keep the DEAR and ESR around, this shouldn't have happened */
+	cmpdi	cr0,r14,-1
+	beq	1f
+	TLB_MISS_EPILOG_ERROR_SPECIAL
+	b	exc_data_storage_book3e
+1:	TLB_MISS_EPILOG_ERROR_SPECIAL
+	b	exc_instruction_storage_book3e
+
+
+#ifdef CONFIG_BOOK3E_MMU_TLB_STATS
+.tlb_stat_inc:
+1:	ldarx	r8,0,r9
+	addi	r8,r8,1
+	stdcx.	r8,0,r9
+	bne-	1b
+	blr
+#endif
Index: linux-work/arch/powerpc/mm/mmu_decl.h
===================================================================
--- linux-work.orig/arch/powerpc/mm/mmu_decl.h	2009-07-24 18:14:35.000000000 +1000
+++ linux-work/arch/powerpc/mm/mmu_decl.h	2009-07-24 18:15:35.000000000 +1000
@@ -41,7 +41,11 @@ static inline void _tlbil_pid(unsigned i
 #else /* CONFIG_40x || CONFIG_8xx */
 extern void _tlbil_all(void);
 extern void _tlbil_pid(unsigned int pid);
+#ifdef CONFIG_PPC_BOOK3E
+extern void _tlbil_pid_noind(unsigned int pid);
+#else
 #define _tlbil_pid_noind(pid)	_tlbil_pid(pid)
+#endif
 #endif /* !(CONFIG_40x || CONFIG_8xx) */
 
 /*
@@ -53,7 +57,10 @@ static inline void _tlbil_va(unsigned lo
 {
 	asm volatile ("tlbie %0; sync" : : "r" (address) : "memory");
 }
-#else /* CONFIG_8xx */
+#elif defined(CONFIG_PPC_BOOK3E)
+extern void _tlbil_va(unsigned long address, unsigned int pid,
+		      unsigned int tsize, unsigned int ind);
+#else
 extern void __tlbil_va(unsigned long address, unsigned int pid);
 static inline void _tlbil_va(unsigned long address, unsigned int pid,
 			     unsigned int tsize, unsigned int ind)
@@ -67,11 +74,16 @@ static inline void _tlbil_va(unsigned lo
  * implementation. When that becomes the case, this will be
  * an extern.
  */
+#ifdef CONFIG_PPC_BOOK3E
+extern void _tlbivax_bcast(unsigned long address, unsigned int pid,
+			   unsigned int tsize, unsigned int ind);
+#else
 static inline void _tlbivax_bcast(unsigned long address, unsigned int pid,
 				   unsigned int tsize, unsigned int ind)
 {
 	BUG();
 }
+#endif
 
 #else /* CONFIG_PPC_MMU_NOHASH */
 
Index: linux-work/arch/powerpc/mm/tlb_nohash.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/tlb_nohash.c	2009-07-24 18:14:35.000000000 +1000
+++ linux-work/arch/powerpc/mm/tlb_nohash.c	2009-07-24 18:15:35.000000000 +1000
@@ -7,8 +7,8 @@
  *
  *  -- BenH
  *
- * Copyright 2008 Ben Herrenschmidt <benh@kernel.crashing.org>
- *                IBM Corp.
+ * Copyright 2008,2009 Ben Herrenschmidt <benh@kernel.crashing.org>
+ *                     IBM Corp.
  *
  *  Derived from arch/ppc/mm/init.c:
  *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
@@ -34,12 +34,70 @@
 #include <linux/pagemap.h>
 #include <linux/preempt.h>
 #include <linux/spinlock.h>
+#include <linux/lmb.h>
 
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
+#include <asm/code-patching.h>
 
 #include "mmu_decl.h"
 
+#ifdef CONFIG_PPC_BOOK3E
+struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
+	[MMU_PAGE_4K] = {
+		.shift	= 12,
+		.enc	= BOOK3E_PAGESZ_4K,
+	},
+	[MMU_PAGE_16K] = {
+		.shift	= 14,
+		.enc	= BOOK3E_PAGESZ_16K,
+	},
+	[MMU_PAGE_64K] = {
+		.shift	= 16,
+		.enc	= BOOK3E_PAGESZ_64K,
+	},
+	[MMU_PAGE_1M] = {
+		.shift	= 20,
+		.enc	= BOOK3E_PAGESZ_1M,
+	},
+	[MMU_PAGE_16M] = {
+		.shift	= 24,
+		.enc	= BOOK3E_PAGESZ_16M,
+	},
+	[MMU_PAGE_256M] = {
+		.shift	= 28,
+		.enc	= BOOK3E_PAGESZ_256M,
+	},
+	[MMU_PAGE_1G] = {
+		.shift	= 30,
+		.enc	= BOOK3E_PAGESZ_1GB,
+	},
+};
+static inline int mmu_get_tsize(int psize)
+{
+	return mmu_psize_defs[psize].enc;
+}
+#else
+static inline int mmu_get_tsize(int psize)
+{
+	/* This isn't used on !Book3E for now */
+	return 0;
+}
+#endif
+
+/* The variables below are currently only used on 64-bit Book3E
+ * though this will probably be made common with other nohash
+ * implementations at some point
+ */
+#ifdef CONFIG_PPC64
+
+int mmu_linear_psize;		/* Page size used for the linear mapping */
+int mmu_pte_psize;		/* Page size used for PTE pages */
+int book3e_htw_enabled;		/* Is HW tablewalk enabled ? */
+unsigned long linear_map_top;	/* Top of linear mapping */
+
+#endif /* CONFIG_PPC64 */
+
 /*
  * Base TLB flushing operations:
  *
@@ -82,7 +140,7 @@ void __local_flush_tlb_page(struct mm_st
 void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 {
 	__local_flush_tlb_page(vma ? vma->vm_mm : NULL, vmaddr,
-			       0 /* tsize unused for now */, 0);
+			       mmu_get_tsize(mmu_virtual_psize), 0);
 }
 EXPORT_SYMBOL(local_flush_tlb_page);
 
@@ -198,7 +256,7 @@ void __flush_tlb_page(struct mm_struct *
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 {
 	__flush_tlb_page(vma ? vma->vm_mm : NULL, vmaddr,
-			 0 /* tsize unused for now */, 0);
+			 mmu_get_tsize(mmu_virtual_psize), 0);
 }
 EXPORT_SYMBOL(flush_tlb_page);
 
@@ -241,3 +299,140 @@ void tlb_flush(struct mmu_gather *tlb)
 	/* Push out batch of freed page tables */
 	pte_free_finish();
 }
+
+/*
+ * Below are functions specific to the 64-bit variant of Book3E though that
+ * may change in the future
+ */
+
+#ifdef CONFIG_PPC64
+
+/*
+ * Handling of virtual linear page tables or indirect TLB entries
+ * flushing when PTE pages are freed
+ */
+void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address)
+{
+	int tsize = mmu_psize_defs[mmu_pte_psize].enc;
+
+	if (book3e_htw_enabled) {
+		unsigned long start = address & PMD_MASK;
+		unsigned long end = address + PMD_SIZE;
+		unsigned long size = 1UL << mmu_psize_defs[mmu_pte_psize].shift;
+
+		/* This isn't the most optimal, ideally we would factor out the
+		 * while preempt & CPU mask mucking around, or even the IPI but
+		 * it will do for now
+		 */
+		while (start < end) {
+			__flush_tlb_page(tlb->mm, start, tsize, 1);
+			start += size;
+		}
+	} else {
+		unsigned long rmask = 0xf000000000000000ul;
+		unsigned long rid = (address & rmask) | 0x1000000000000000ul;
+		unsigned long vpte = address & ~rmask;
+
+#ifdef CONFIG_PPC_64K_PAGES
+		vpte = (vpte >> (PAGE_SHIFT - 4)) & ~0xfffful;
+#else
+		vpte = (vpte >> (PAGE_SHIFT - 3)) & ~0xffful;
+#endif
+		vpte |= rid;
+		__flush_tlb_page(tlb->mm, vpte, tsize, 0);
+	}
+}
+
+/*
+ * Early initialization of the MMU TLB code
+ */
+static void __early_init_mmu(int boot_cpu)
+{
+	extern unsigned int interrupt_base_book3e;
+	extern unsigned int exc_data_tlb_miss_htw_book3e;
+	extern unsigned int exc_instruction_tlb_miss_htw_book3e;
+
+	unsigned int *ibase = &interrupt_base_book3e;
+	unsigned int mas4;
+
+	/* XXX This will have to be decided at runtime, but right
+	 * now our boot and TLB miss code hard wires it
+	 */
+	mmu_linear_psize = MMU_PAGE_1G;
+
+
+	/* Check if HW tablewalk is present, and if yes, enable it by:
+	 *
+	 * - patching the TLB miss handlers to branch to the
+	 *   one dedicates to it
+	 *
+	 * - setting the global book3e_htw_enabled
+	 *
+	 * - Set MAS4:INDD and default page size
+	 */
+
+	/* XXX This code only checks for TLB 0 capabilities and doesn't
+	 *     check what page size combos are supported by the HW. It
+	 *     also doesn't handle the case where a separate array holds
+	 *     the IND entries from the array loaded by the PT.
+	 */
+	if (boot_cpu) {
+		unsigned int tlb0cfg = mfspr(SPRN_TLB0CFG);
+
+		/* Check if HW loader is supported */
+		if ((tlb0cfg & TLBnCFG_IND) &&
+		    (tlb0cfg & TLBnCFG_PT)) {
+			patch_branch(ibase + (0x1c0 / 4),
+			     (unsigned long)&exc_data_tlb_miss_htw_book3e, 0);
+			patch_branch(ibase + (0x1e0 / 4),
+			     (unsigned long)&exc_instruction_tlb_miss_htw_book3e, 0);
+			book3e_htw_enabled = 1;
+		}
+		pr_info("MMU: Book3E Page Tables %s\n",
+			book3e_htw_enabled ? "Enabled" : "Disabled");
+	}
+
+	/* Set MAS4 based on page table setting */
+
+	mas4 = 0x4 << MAS4_WIMGED_SHIFT;
+	if (book3e_htw_enabled) {
+		mas4 |= mas4 | MAS4_INDD;
+#ifdef CONFIG_PPC_64K_PAGES
+		mas4 |=	BOOK3E_PAGESZ_256M << MAS4_TSIZED_SHIFT;
+		mmu_pte_psize = MMU_PAGE_256M;
+#else
+		mas4 |=	BOOK3E_PAGESZ_1M << MAS4_TSIZED_SHIFT;
+		mmu_pte_psize = MMU_PAGE_1M;
+#endif
+	} else {
+#ifdef CONFIG_PPC_64K_PAGES
+		mas4 |=	BOOK3E_PAGESZ_64K << MAS4_TSIZED_SHIFT;
+#else
+		mas4 |=	BOOK3E_PAGESZ_4K << MAS4_TSIZED_SHIFT;
+#endif
+		mmu_pte_psize = mmu_virtual_psize;
+	}
+	mtspr(SPRN_MAS4, mas4);
+
+	/* Set the global containing the top of the linear mapping
+	 * for use by the TLB miss code
+	 */
+	linear_map_top = lmb_end_of_DRAM();
+
+	/* A sync won't hurt us after mucking around with
+	 * the MMU configuration
+	 */
+	mb();
+}
+
+void __init early_init_mmu(void)
+{
+	__early_init_mmu(1);
+}
+
+void __cpuinit early_init_mmu_secondary(void)
+{
+	__early_init_mmu(0);
+}
+
+#endif /* CONFIG_PPC64 */
Index: linux-work/arch/powerpc/include/asm/mmu_context.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu_context.h	2009-07-24 18:14:35.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu_context.h	2009-07-24 18:15:31.000000000 +1000
@@ -43,6 +43,10 @@ static inline void switch_mm(struct mm_s
 	tsk->thread.pgdir = next->pgd;
 #endif /* CONFIG_PPC32 */
 
+	/* 64-bit Book3E keeps track of current PGD in the PACA */
+#ifdef CONFIG_PPC_BOOK3E_64
+	get_paca()->pgd = next->pgd;
+#endif
 	/* Nothing else to do if we aren't actually switching */
 	if (prev == next)
 		return;
@@ -89,6 +93,10 @@ static inline void activate_mm(struct mm
 static inline void enter_lazy_tlb(struct mm_struct *mm,
 				  struct task_struct *tsk)
 {
+ 	/* 64-bit Book3E keeps track of current PGD in the PACA */
+#ifdef CONFIG_PPC_BOOK3E_64
+      	get_paca()->pgd = NULL;
+#endif
 }
 
 #endif /* __KERNEL__ */
Index: linux-work/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2009-07-24 18:14:35.000000000 +1000
+++ linux-work/arch/powerpc/kernel/setup_64.c	2009-07-24 18:15:34.000000000 +1000
@@ -62,6 +62,7 @@
 #include <asm/udbg.h>
 #include <asm/kexec.h>
 #include <asm/swiotlb.h>
+#include <asm/mmu_context.h>
 
 #include "setup.h"
 
@@ -147,6 +148,9 @@ void __init setup_paca(int cpu)
 {
 	local_paca = &paca[cpu];
 	mtspr(SPRN_SPRG_PACA, local_paca);
+#ifdef CONFIG_PPC_BOOK3E
+	mtspr(SPRN_SPRG_TLB_EXFRAME, local_paca->extlb);
+#endif
 }
 
 /*
Index: linux-work/arch/powerpc/mm/tlb_nohash_low.S
===================================================================
--- linux-work.orig/arch/powerpc/mm/tlb_nohash_low.S	2009-07-24 18:14:35.000000000 +1000
+++ linux-work/arch/powerpc/mm/tlb_nohash_low.S	2009-07-24 18:15:31.000000000 +1000
@@ -191,6 +191,85 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_US
 	isync
 1:	wrtee	r10
 	blr
+#elif defined(CONFIG_PPC_BOOK3E)
+/*
+ * New Book3E (>= 2.06) implementation
+ *
+ * Note: We may be able to get away without the interrupt masking stuff
+ * if we save/restore MAS6 on exceptions that might modify it
+ */
+_GLOBAL(_tlbil_pid)
+	slwi	r4,r3,MAS6_SPID_SHIFT
+	mfmsr	r10
+	wrteei	0
+	mtspr	SPRN_MAS6,r4
+	PPC_TLBILX_PID(0,0)
+	wrtee	r10
+	msync
+	isync
+	blr
+
+_GLOBAL(_tlbil_pid_noind)
+	slwi	r4,r3,MAS6_SPID_SHIFT
+	mfmsr	r10
+	ori	r4,r4,MAS6_SIND
+	wrteei	0
+	mtspr	SPRN_MAS6,r4
+	PPC_TLBILX_PID(0,0)
+	wrtee	r10
+	msync
+	isync
+	blr
+
+_GLOBAL(_tlbil_all)
+	PPC_TLBILX_ALL(0,0)
+	msync
+	isync
+	blr
+
+_GLOBAL(_tlbil_va)
+	mfmsr	r10
+	wrteei	0
+	cmpwi	cr0,r6,0
+	slwi	r4,r4,MAS6_SPID_SHIFT
+	rlwimi	r4,r5,MAS6_ISIZE_SHIFT,MAS6_ISIZE_MASK
+	beq	1f
+	rlwimi	r4,r6,MAS6_SIND_SHIFT,MAS6_SIND
+1:	mtspr	SPRN_MAS6,r4		/* assume AS=0 for now */
+	PPC_TLBILX_VA(0,r3)
+	msync
+	isync
+	wrtee	r10
+	blr
+
+_GLOBAL(_tlbivax_bcast)
+	mfmsr	r10
+	wrteei	0
+	cmpwi	cr0,r6,0
+	slwi	r4,r4,MAS6_SPID_SHIFT
+	rlwimi	r4,r5,MAS6_ISIZE_SHIFT,MAS6_ISIZE_MASK
+	beq	1f
+	rlwimi	r4,r6,MAS6_SIND_SHIFT,MAS6_SIND
+1:	mtspr	SPRN_MAS6,r4		/* assume AS=0 for now */
+	PPC_TLBIVAX(0,r3)
+	eieio
+	tlbsync
+	sync
+	wrtee	r10
+	blr
+
+_GLOBAL(set_context)
+#ifdef CONFIG_BDI_SWITCH
+	/* Context switch the PTE pointer for the Abatron BDI2000.
+	 * The PGDIR is the second parameter.
+	 */
+	lis	r5, abatron_pteptrs@h
+	ori	r5, r5, abatron_pteptrs@l
+	stw	r4, 0x4(r5)
+#endif
+	mtspr	SPRN_PID,r3
+	isync			/* Force context change */
+	blr
 #else
 #error Unsupported processor type !
 #endif
Index: linux-work/arch/powerpc/include/asm/mmu-40x.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu-40x.h	2009-07-24 18:14:35.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu-40x.h	2009-07-24 18:15:31.000000000 +1000
@@ -61,4 +61,7 @@ typedef struct {
 
 #endif /* !__ASSEMBLY__ */
 
+#define mmu_virtual_psize	MMU_PAGE_4K
+#define mmu_linear_psize	MMU_PAGE_256M
+
 #endif /* _ASM_POWERPC_MMU_40X_H_ */
Index: linux-work/arch/powerpc/include/asm/mmu-44x.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu-44x.h	2009-07-24 18:14:35.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu-44x.h	2009-07-24 18:15:31.000000000 +1000
@@ -79,16 +79,22 @@ typedef struct {
 
 #if (PAGE_SHIFT == 12)
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_4K
+#define mmu_virtual_psize	MMU_PAGE_4K
 #elif (PAGE_SHIFT == 14)
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_16K
+#define mmu_virtual_psize	MMU_PAGE_16K
 #elif (PAGE_SHIFT == 16)
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_64K
+#define mmu_virtual_psize	MMU_PAGE_64K
 #elif (PAGE_SHIFT == 18)
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_256K
+#define mmu_virtual_psize	MMU_PAGE_256K
 #else
 #error "Unsupported PAGE_SIZE"
 #endif
 
+#define mmu_linear_psize	MMU_PAGE_256M
+
 #define PPC44x_PGD_OFF_SHIFT	(32 - PGDIR_SHIFT + PGD_T_LOG2)
 #define PPC44x_PGD_OFF_MASK_BIT	(PGDIR_SHIFT - PGD_T_LOG2)
 #define PPC44x_PTE_ADD_SHIFT	(32 - PGDIR_SHIFT + PTE_SHIFT + PTE_T_LOG2)
Index: linux-work/arch/powerpc/include/asm/mmu-8xx.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu-8xx.h	2009-07-24 18:14:35.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu-8xx.h	2009-07-24 18:15:31.000000000 +1000
@@ -143,4 +143,7 @@ typedef struct {
 } mm_context_t;
 #endif /* !__ASSEMBLY__ */
 
+#define mmu_virtual_psize	MMU_PAGE_4K
+#define mmu_linear_psize	MMU_PAGE_8M
+
 #endif /* _ASM_POWERPC_MMU_8XX_H_ */
Index: linux-work/arch/powerpc/include/asm/mmu-hash32.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu-hash32.h	2009-07-24 18:14:35.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu-hash32.h	2009-07-24 18:15:31.000000000 +1000
@@ -80,4 +80,10 @@ typedef struct {
 
 #endif /* !__ASSEMBLY__ */
 
+/* We happily ignore the smaller BATs on 601, we don't actually use
+ * those definitions on hash32 at the moment anyway
+ */
+#define mmu_virtual_psize	MMU_PAGE_4K
+#define mmu_linear_psize	MMU_PAGE_256M
+
 #endif /* _ASM_POWERPC_MMU_HASH32_H_ */
