Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C584C100968
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 21:21:36 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
Subject: [PATCH 09/10] 8xx: Remove DIRTY pte handling in DTLB Error.
Date: Fri, 20 Nov 2009 11:21:10 +0100
Message-Id: <1258712471-3104-10-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1258712471-3104-9-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1258712471-3104-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-5-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-6-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-7-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-8-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-9-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no need to do set the DIRTY bit directly in DTLB Error.
Trap to do_page_fault() and let the generic MM code do the work.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/powerpc/kernel/head_8xx.S |   96 ----------------------------------------
 1 files changed, 0 insertions(+), 96 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index d3f09ef..36af721 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -500,102 +500,6 @@ DataTLBError:
 	cmpwi	cr0, r10, 0x00f0
 	beq-	FixupDAR	/* must be a buggy dcbX, icbi insn. */
 DARFixed:/* Return from dcbx instruction bug workaround, r10 holds value of DAR */
-	mfspr	r11, SPRN_DSISR
-	/* As the DAR fixup may clear store we may have all 3 states zero.
-	 * Make sure only 0x0200(store) falls down into DIRTY handling
-	 */
-	andis.	r11, r11, 0x4a00	/* !translation, protection or store */
-	srwi	r11, r11, 16
-	cmpwi	cr0, r11, 0x0200	/* just store ? */
-	bne	2f
-	/* Only Change bit left now, do it here as it is faster
-	 * than trapping to the C fault handler.
-	*/
-
-	/* The EA of a data TLB miss is automatically stored in the MD_EPN
-	 * register.  The EA of a data TLB error is automatically stored in
-	 * the DAR, but not the MD_EPN register.  We must copy the 20 most
-	 * significant bits of the EA from the DAR to MD_EPN before we
-	 * start walking the page tables.  We also need to copy the CASID
-	 * value from the M_CASID register.
-	 * Addendum:  The EA of a data TLB error is _supposed_ to be stored
-	 * in DAR, but it seems that this doesn't happen in some cases, such
-	 * as when the error is due to a dcbi instruction to a page with a
-	 * TLB that doesn't have the changed bit set.  In such cases, there
-	 * does not appear to be any way  to recover the EA of the error
-	 * since it is neither in DAR nor MD_EPN.  As a workaround, the
-	 * _PAGE_HWWRITE bit is set for all kernel data pages when the PTEs
-	 * are initialized in mapin_ram().  This will avoid the problem,
-	 * assuming we only use the dcbi instruction on kernel addresses.
-	 */
-
-	/* DAR is in r10 already */
-	rlwinm	r11, r10, 0, 0, 19
-	ori	r11, r11, MD_EVALID
-	mfspr	r10, SPRN_M_CASID
-	rlwimi	r11, r10, 0, 28, 31
-	DO_8xx_CPU6(0x3780, r3)
-	mtspr	SPRN_MD_EPN, r11
-
-	mfspr	r10, SPRN_M_TWB	/* Get level 1 table entry address */
-
-	/* If we are faulting a kernel address, we have to use the
-	 * kernel page tables.
-	 */
-	andi.	r11, r10, 0x0800
-	beq	3f
-	lis	r11, swapper_pg_dir@h
-	ori	r11, r11, swapper_pg_dir@l
-	rlwimi	r10, r11, 0, 2, 19
-3:
-	lwz	r11, 0(r10)	/* Get the level 1 entry */
-	rlwinm.	r10, r11,0,0,19	/* Extract page descriptor page address */
-	beq	2f		/* If zero, bail */
-
-	/* We have a pte table, so fetch the pte from the table.
-	 */
-	ori	r11, r11, 1		/* Set valid bit in physical L2 page */
-	DO_8xx_CPU6(0x3b80, r3)
-	mtspr	SPRN_MD_TWC, r11	/* Load pte table base address */
-	mfspr	r10, SPRN_MD_TWC	/* ....and get the pte address */
-	lwz	r10, 0(r10)		/* Get the pte */
-	/* Insert the Guarded flag into the TWC from the Linux PTE.
-	 * It is bit 27 of both the Linux PTE and the TWC
-	 */
-	rlwimi	r11, r10, 0, 27, 27
-	/* Insert the WriteThru flag into the TWC from the Linux PTE.
-	 * It is bit 25 in the Linux PTE and bit 30 in the TWC
-	 */
-	rlwimi	r11, r10, 32-5, 30, 30
-	DO_8xx_CPU6(0x3b80, r3)
-	mtspr	SPRN_MD_TWC, r11
-	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
-
-	ori	r10, r10, _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_HWWRITE
-	stw	r10, 0(r11)		/* and update pte in table */
-	xori	r10, r10, _PAGE_RW	/* RW bit is inverted */
-
-	/* The Linux PTE won't go exactly into the MMU TLB.
-	 * Software indicator bits 22 and 28 must be clear.
-	 * Software indicator bits 24, 25, 26, and 27 must be
-	 * set.  All other Linux PTE bits control the behavior
-	 * of the MMU.
-	 */
-	li	r11, 0x00f0
-	mtspr	SPRN_DAR,r11	/* Tag DAR */
-	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
-	DO_8xx_CPU6(0x3d80, r3)
-	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
-
-	mfspr	r10, SPRN_M_TW	/* Restore registers */
-	lwz	r11, 0(r0)
-	mtcr	r11
-	lwz	r11, 4(r0)
-#ifdef CONFIG_8xx_CPU6
-	lwz	r3, 8(r0)
-#endif
-	rfi
-2:
 	mfspr	r10, SPRN_M_TW	/* Restore registers */
 	lwz	r11, 0(r0)
 	mtcr	r11
-- 
1.6.4.4
