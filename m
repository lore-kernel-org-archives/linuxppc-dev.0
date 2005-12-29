Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 391B968984
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 07:51:31 +1100 (EST)
Date: Thu, 29 Dec 2005 18:51:42 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	Dan Malek <dan@embeddededge.com>
Message-ID: <20051229205142.GC9751@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] Use 8MB D-TLB entries for kernel static mapping
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

The following patch implements support for instantiation of 8MB D-TLB
entries for the kernel direct virtual mapping on 8xx, thus reducing TLB
space consumed for the kernel.

Test used: writing 40MB from /dev/zero to file in ext2fs over 
RAMDISK.

$ time dd if=/dev/zero of=file bs=4k count=10000 

VANILLA			8MB kernel data pages

real    0m11.485s	real    0m11.267s
user    0m0.218s        user    0m0.250s
sys     0m8.939s	sys     0m9.108s

real    0m11.518s	real    0m10.978s
user    0m0.203s 	user    0m0.222s
sys     0m9.585s	sys     0m9.138s

real    0m11.554s	real    0m10.967s
user    0m0.228s    	user    0m0.222s
sys     0m9.497s	sys     0m9.127s

real    0m11.633s	real	0m11.286s
user    0m0.214s	user    0m0.196s
sys     0m9.529s	sys     0m9.134s

and averages for both:

real	11.54750	real 11.12450

Which is a 3.6% improvement in execution time. More improvement is
expected for loads with larger kernel data footprint (real workloads).

Dan, could you please review the code.

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index de09787..fe25f3f 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -375,6 +375,14 @@ DataStoreTLBMiss:
 	lis	r11, swapper_pg_dir@h
 	ori	r11, r11, swapper_pg_dir@l
 	rlwimi	r10, r11, 0, 2, 19
+	stw	r12, 16(r0)
+	mflr	r12
+	stw	r12, 20(r0)	/* save LR */
+	lis	r3, LoadLargeDTLB@h
+	ori	r3, r3, LoadLargeDTLB@l
+	tophys	(r3, r3)
+	mtlr	r3
+	blr
 3:
 	lwz	r11, 0(r10)	/* Get the level 1 entry */
 	rlwinm.	r10, r11,0,0,19	/* Extract page descriptor page address */
@@ -430,6 +438,83 @@ DataStoreTLBMiss:
 InstructionTLBError:
 	b	InstructionAccess
 
+LoadLargeDTLB:
+	li	r12, 0
+	lwz	r11, 0(r10)	/* Get the level 1 entry */
+	rlwinm.	r10, r11,0,0,19	/* Extract page descriptor page address */
+	beq	3f		/* If zero, don't try to find a pte */
+
+	/* We have a pte table, so load fetch the pte from the table.
+	 */
+	ori	r11, r11, 1	/* Set valid bit in physical L2 page */
+	DO_8xx_CPU6(0x3b80, r3)
+	mtspr	SPRN_MD_TWC, r11	/* Load pte table base address */
+	mfspr	r10, SPRN_MD_TWC	/* ....and get the pte address */
+	lwz	r10, 0(r10)	/* Get the pte */
+
+	/* Insert the Guarded flag into the TWC from the Linux PTE.
+	 * It is bit 27 of both the Linux PTE and the TWC (at least
+	 * I got that right :-).  It will be better when we can put
+	 * this into the Linux pgd/pmd and load it in the operation
+	 * above.
+	 */
+	rlwimi	r11, r10, 0, 27, 27
+
+	rlwimi  r12, r10, 0, 0, 9	/* extract phys. addr */
+	mfspr	r3, SPRN_MD_EPN
+	rlwinm	r3, r3, 0, 0, 9		/* extract virtual address */
+	tophys(r3, r3)
+	cmpw	r3, r12			/* only use 8M page if it is a direct 
+					   kernel mapping */
+	bne	1f
+	ori     r11, r11, MD_PS8MEG
+	li	r12, 1
+	b	2f
+1:
+	li	r12, 0		/* can't use 8MB TLB, so zero r12. */
+2:
+	DO_8xx_CPU6(0x3b80, r3)
+	mtspr	SPRN_MD_TWC, r11
+
+	/* The Linux PTE won't go exactly into the MMU TLB.
+	 * Software indicator bits 21, 22 and 28 must be clear.
+	 * Software indicator bits 24, 25, 26, and 27 must be
+	 * set.  All other Linux PTE bits control the behavior
+	 * of the MMU.
+	 */
+3:	li	r11, 0x00f0
+	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
+	cmpwi   r12, 1
+	bne 4f
+	ori     r10, r10, 0x8
+
+	mfspr	r12, SPRN_MD_EPN
+	lis	r3, 0xff80		/* 10-19 must be clear for 8MB TLB */
+	ori	r3, r3, 0x0fff
+	and	r12, r3, r12
+	DO_8xx_CPU6(0x3780, r3)
+	mtspr	SPRN_MD_EPN, r12
+
+	lis	r3, 0xff80		/* 10-19 must be clear for 8MB TLB */
+	ori	r3, r3, 0x0fff
+	and	r10, r3, r10
+4:
+	DO_8xx_CPU6(0x3d80, r3)
+	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
+
+	mfspr	r10, SPRN_M_TW	/* Restore registers */
+	lwz	r11, 0(r0)
+	mtcr	r11
+	lwz	r11, 4(r0)
+
+	lwz	r12, 20(r0)
+	mtlr	r12		/* Restore LR */
+	lwz	r12, 16(r0)
+#ifdef CONFIG_8xx_CPU6
+	lwz	r3, 8(r0)
+#endif
+	rfi
+
 /* This is the data TLB error on the MPC8xx.  This could be due to
  * many reasons, including a dirty update to a pte.  We can catch that
  * one here, but anything else is an error.  First, we track down the
