Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DA170B7B95
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 20:04:34 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>, Rex Feany <RFeany@mrv.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/8] 8xx: Fixup DAR from buggy dcbX instructions.
Date: Thu, 15 Oct 2009 11:04:22 +0200
Message-Id: <1255597466-30976-5-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1255597466-30976-4-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255597466-30976-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255597466-30976-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255597466-30976-4-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an assembler version to fixup DAR not being set
by dcbX, icbi instructions. There are two versions, one
uses selfmodifing code, the other uses a
jump table but is much bigger(default).
---
 arch/powerpc/kernel/head_8xx.S |  180 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 176 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index bca22fa..320f333 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -494,11 +494,16 @@ DataTLBError:
 
 	mfspr	r10, SPRN_DAR
 	cmpwi	cr0, r10, 0x00f0
-	beq-	2f	/* must be a buggy dcbX, icbi insn. */
-
+	beq-	FixupDAR	/* must be a buggy dcbX, icbi insn. */
+DARFixed:/* Return from dcbx instruction bug workaround, r10 holds value of DAR */
 	mfspr	r11, SPRN_DSISR
-	andis.	r11, r11, 0x4800	/* !translation or protection */
-	bne	2f	/* branch if either is set */
+	/* As the DAR fixup may clear store we may have all 3 states zero.
+	 * Make sure only 0x0200(store) falls down into DIRTY handling
+	 */
+	andis.	r11, r11, 0x4a00	/* !translation, protection or store */
+	srwi	r11, r11, 16
+	cmpwi	cr0, r11, 0x0200	/* just store ? */
+	bne	2f
 	/* Only Change bit left now, do it here as it is faster
 	 * than trapping to the C fault handler.
 	*/
@@ -604,6 +609,173 @@ DataTLBError:
 
 	. = 0x2000
 
+/* This is the procedure to calculate the data EA for buggy dcbx,dcbi instructions
+ * by decoding the registers used by the dcbx instruction and adding them.
+ * DAR is set to the calculated address and r10 also holds the EA on exit.
+ */
+#define NO_SELF_MODIFYING_CODE /* define if you don't want to use self modifying code */
+	nop	/* A few nops to make the modified_instr: space below cache line aligned */
+	nop
+139:	/* fetch instruction from userspace memory */
+	DO_8xx_CPU6(0x3780, r3)
+	mtspr	SPRN_MD_EPN, r10
+	mfspr	r11, SPRN_M_TWB	/* Get level 1 table entry address */
+	lwz	r11, 0(r11)	/* Get the level 1 entry */
+	tophys  (r11, r11)
+	DO_8xx_CPU6(0x3b80, r3)
+	mtspr	SPRN_MD_TWC, r11	/* Load pte table base address */
+	mfspr	r11, SPRN_MD_TWC	/* ....and get the pte address */
+	lwz	r11, 0(r11)	/* Get the pte */
+	/* concat physical page address(r11) and page offset(r10) */
+	rlwimi	r11, r10, 0, 20, 31
+	b	140f
+FixupDAR:	/* Entry point for dcbx workaround. */
+	/* fetch instruction from memory. */
+	mfspr	r10, SPRN_SRR0
+	andis.	r11, r10, 0x8000
+	tophys  (r11, r10)
+	beq-	139b		/* Branch if user space address */
+140:	lwz	r11,0(r11)
+/* Check if it really is a dcbx instruction. */
+/* dcbt and dcbtst does not generate DTLB Misses/Errors,
+ * no need to include them here */
+	srwi	r10, r11, 26	/* check if major OP code is 31 */
+	cmpwi	cr0, r10, 31
+	bne-	141f
+	rlwinm	r10, r11, 0, 21, 30
+	cmpwi	cr0, r10, 2028	/* Is dcbz? */
+	beq+	142f
+	cmpwi	cr0, r10, 940	/* Is dcbi? */
+	beq+	142f
+	cmpwi	cr0, r10, 108	/* Is dcbst? */
+	beq+	144f		/* Fix up store bit! */
+	cmpwi	cr0, r10, 172	/* Is dcbf? */
+	beq+	142f
+	cmpwi	cr0, r10, 1964	/* Is icbi? */
+	beq+	142f
+141:	mfspr	r10, SPRN_DAR	/* r10 must hold DAR at exit */
+	b	DARfix		/* Nope, go back to normal TLB processing */
+
+144:	mfspr	r10, SPRN_DSISR
+	rlwinm	r10, r10,0,7,5	/* Clear store bit for buggy dcbst insn */
+	mtspr	SPRN_DSISR, r10
+142:	/* continue, it was a dcbx, dcbi instruction. */
+#ifdef CONFIG_8xx_CPU6
+	lwz	r3, 8(r0)	/* restore r3 from memory */
+#endif
+#ifndef NO_SELF_MODIFYING_CODE
+	andis.	r10,r11,0x1f	/* test if reg RA is r0 */
+	li	r10,modified_instr@l
+	dcbtst	r0,r10		/* touch for store */
+	rlwinm	r11,r11,0,0,20	/* Zero lower 10 bits */
+	oris	r11,r11,640	/* Transform instr. to a "add r10,RA,RB" */
+	ori	r11,r11,532
+	stw	r11,0(r10)	/* store add/and instruction */
+	dcbf	0,r10		/* flush new instr. to memory. */
+	icbi	0,r10		/* invalidate instr. cache line */
+	lwz	r11, 4(r0)	/* restore r11 from memory */
+	mfspr	r10, SPRN_M_TW	/* restore r10 from M_TW */
+	isync			/* Wait until new instr is loaded from memory */
+modified_instr:
+	.space	4		/* this is where the add/and instr. is stored */
+	bne+	143f
+	subf	r10,r0,r10	/* r10=r10-r0, only if reg RA is r0 */
+143:	mtdar	r10		/* store faulting EA in DAR */
+	b	DARFixed	/* Go back to normal TLB handling */
+#else
+	mfctr	r10
+	mtdar	r10			/* save ctr reg in DAR */
+	rlwinm	r10, r11, 24, 24, 28	/* offset into jump table for reg RB */
+	addi	r10, r10, 150f@l	/* add start of table */
+	mtctr	r10			/* load ctr with jump address */
+	xor	r10, r10, r10		/* sum starts at zero */
+	bctr				/* jump into table */
+150:
+	add	r10, r10, r0
+	b	151f
+	add	r10, r10, r1
+	b	151f
+	add	r10, r10, r2
+	b	151f
+	add	r10, r10, r3
+	b	151f
+	add	r10, r10, r4
+	b	151f
+	add	r10, r10, r5
+	b	151f
+	add	r10, r10, r6
+	b	151f
+	add	r10, r10, r7
+	b	151f
+	add	r10, r10, r8
+	b	151f
+	add	r10, r10, r9
+	b	151f
+	add	r10, r10, r10
+	b	151f
+	add	r10, r10, r11
+	b	151f
+	add	r10, r10, r12
+	b	151f
+	add	r10, r10, r13
+	b	151f
+	add	r10, r10, r14
+	b	151f
+	add	r10, r10, r15
+	b	151f
+	add	r10, r10, r16
+	b	151f
+	add	r10, r10, r17
+	b	151f
+	add	r10, r10, r18
+	b	151f
+	add	r10, r10, r19
+	b	151f
+	mtctr	r11	/* r10 needs special handling */
+	b	154f
+	mtctr	r11	/* r11 needs special handling */
+	b	153f
+	add	r10, r10, r22
+	b	151f
+	add	r10, r10, r23
+	b	151f
+	add	r10, r10, r24
+	b	151f
+	add	r10, r10, r25
+	b	151f
+	add	r10, r10, r25
+	b	151f
+	add	r10, r10, r27
+	b	151f
+	add	r10, r10, r28
+	b	151f
+	add	r10, r10, r29
+	b	151f
+	add	r10, r10, r30
+	b	151f
+	add	r10, r10, r31
+151:
+	rlwinm. r11,r11,19,24,28	/* offset into jump table for reg RA */
+	beq	152f			/* if reg RA is zero, don't add it */ 
+	addi	r11, r11, 150b@l	/* add start of table */
+	mtctr	r11			/* load ctr with jump address */
+	rlwinm	r11,r11,0,16,10		/* make sure we don't execute this more than once */
+	bctr				/* jump into table */
+152:
+	mfdar	r11
+	mtctr	r11			/* restore ctr reg from DAR */
+	mtdar	r10			/* save fault EA to DAR */
+	b	DARFixed		/* Go back to normal TLB handling */
+
+	/* special handling for r10,r11 since these are modified already */
+153:	lwz	r11, 4(r0)	/* load r11 from memory */
+	b	155f
+154:	mfspr	r11, SPRN_M_TW	/* load r10 from M_TW */
+155:	add	r10, r10, r11	/* add it */
+	mfctr	r11		/* restore r11 */
+	b	151b
+#endif
+
 	.globl	giveup_fpu
 giveup_fpu:
 	blr
-- 
1.6.4.4
