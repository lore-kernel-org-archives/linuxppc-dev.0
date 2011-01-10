Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 787E3B7185
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2011 08:38:19 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Willy Tarreau <w@1wt.eu>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 07/13] 8xx: Fixup DAR from buggy dcbX instructions.
Date: Mon, 10 Jan 2011 22:37:53 +0100
Message-Id: <1294695479-344-8-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
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

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |  149 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 146 insertions(+), 3 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index d992c24..52ff914 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -503,8 +503,17 @@ DataTLBError:
 	stw	r20, 0(r0)
 	stw	r21, 4(r0)
 
-	mfspr	r20, DSISR
-	andis.	r21, r20, 0x4800	/* !translation or protection */
+	mfspr	r20, DAR
+	cmpwi	cr0, r20, 0x00f0
+	beq-	FixupDAR	/* must be a buggy dcbX, icbi insn. */
+DARFixed:
+	/* As the DAR fixup may clear store we may have all 3 states zero.
+	 * Make sure only 0x0200(store) falls down into DIRTY handling
+	 */
+	mfspr	r21, DSISR
+	andis.	r21, r21, 0x4a00	/* !translation, protection or store */
+	srwi	r21, r21, 16
+	cmpwi	cr0, r21, 0x0200	/* just store ? */
 	bne-	2f
 	/* Only Change bit left now, do it here as it is faster
 	 * than trapping to the C fault handler.
@@ -526,7 +535,7 @@ DataTLBError:
 	 * are initialized in mapin_ram().  This will avoid the problem,
 	 * assuming we only use the dcbi instruction on kernel addresses.
 	 */
-	mfspr	r20, DAR
+	/* DAR is in r20 already */
 	rlwinm	r21, r20, 0, 0, 19
 	ori	r21, r21, MD_EVALID
 	mfspr	r20, M_CASID
@@ -610,6 +619,140 @@ DataTLBError:
 	STD_EXCEPTION(0x1f00, Trap_1f, UnknownException)
 
 	. = 0x2000
+/* This is the procedure to calculate the data EA for buggy dcbx,dcbi instructions
+ * by decoding the registers used by the dcbx instruction and adding them.
+ * DAR is set to the calculated address and r10 also holds the EA on exit.
+ */
+ /* define if you don't want to use self modifying code */
+#define NO_SELF_MODIFYING_CODE
+FixupDAR:/* Entry point for dcbx workaround. */
+	/* fetch instruction from memory. */
+	mfspr	r20, SRR0
+	andis.	r21, r20, 0x8000	/* Address >= 0x80000000 */
+	DO_8xx_CPU6(0x3780, r3)
+	mtspr	MD_EPN, r20
+	mfspr	r21, M_TWB	/* Get level 1 table entry address */
+	beq-	3f		/* Branch if user space */
+	lis	r21, (swapper_pg_dir-PAGE_OFFSET)@h
+	ori	r21, r21, (swapper_pg_dir-PAGE_OFFSET)@l
+	rlwimi	r21, r20, 32-20, 0xffc /* r21 = r21&~0xffc|(r20>>20)&0xffc */
+3:	lwz	r21, 0(r21)	/* Get the level 1 entry */
+	tophys  (r21, r21)
+	DO_8xx_CPU6(0x3b80, r3)
+	mtspr	MD_TWC, r21	/* Load pte table base address */
+	mfspr	r21, MD_TWC	/* ....and get the pte address */
+	lwz	r21, 0(r21)	/* Get the pte */
+	/* concat physical page address(r21) and page offset(r20) */
+	rlwimi	r21, r20, 0, 20, 31
+	lwz	r21,0(r21)
+/* Check if it really is a dcbx instruction. */
+/* dcbt and dcbtst does not generate DTLB Misses/Errors,
+ * no need to include them here */
+	srwi	r20, r21, 26	/* check if major OP code is 31 */
+	cmpwi	cr0, r20, 31
+	bne-	141f
+	rlwinm	r20, r21, 0, 21, 30
+	cmpwi	cr0, r20, 2028	/* Is dcbz? */
+	beq+	142f
+	cmpwi	cr0, r20, 940	/* Is dcbi? */
+	beq+	142f
+	cmpwi	cr0, r20, 108	/* Is dcbst? */
+	beq+	144f		/* Fix up store bit! */
+	cmpwi	cr0, r20, 172	/* Is dcbf? */
+	beq+	142f
+	cmpwi	cr0, r20, 1964	/* Is icbi? */
+	beq+	142f
+141:	mfspr	r20, DAR	/* r20 must hold DAR at exit */
+	b	DARFixed	/* Nope, go back to normal TLB processing */
+
+144:	mfspr	r20, DSISR
+	rlwinm	r20, r20,0,7,5	/* Clear store bit for buggy dcbst insn */
+	mtspr	DSISR, r20
+142:	/* continue, it was a dcbx, dcbi instruction. */
+#ifdef CONFIG_8xx_CPU6
+	lwz	r3, 8(r0)	/* restore r3 from memory */
+#endif
+#ifndef NO_SELF_MODIFYING_CODE
+	andis.	r20,r21,0x1f	/* test if reg RA is r0 */
+	li	r20,modified_instr@l
+	dcbtst	r0,r20		/* touch for store */
+	rlwinm	r21,r21,0,0,20	/* Zero lower 10 bits */
+	oris	r21,r21,640	/* Transform instr. to a "add r20,RA,RB" */
+	ori	r21,r21,532
+	stw	r21,0(r20)	/* store add/and instruction */
+	dcbf	0,r20		/* flush new instr. to memory. */
+	icbi	0,r20		/* invalidate instr. cache line */
+	lwz	r21, 4(r0)	/* restore r21 from memory */
+	mfspr	r20, M_TW	/* restore r20 from M_TW */
+	isync			/* Wait until new instr is loaded from memory */
+modified_instr:
+	.space	4		/* this is where the add instr. is stored */
+	bne+	143f
+	subf	r20,r0,r20	/* r20=r20-r0, only if reg RA is r0 */
+143:	mtdar	r20		/* store faulting EA in DAR */
+	b	DARFixed	/* Go back to normal TLB handling */
+#else
+	mfctr	r20
+	mtdar	r20			/* save ctr reg in DAR */
+	rlwinm	r20, r21, 24, 24, 28	/* offset into jump table for reg RB */
+	addi	r20, r20, 150f@l	/* add start of table */
+	mtctr	r20			/* load ctr with jump address */
+	xor	r20, r20, r20		/* sum starts at zero */
+	bctr				/* jump into table */
+150:
+	add	r20, r20, r0	;b	151f
+	add	r20, r20, r1	;b	151f
+	add	r20, r20, r2	;b	151f
+	add	r20, r20, r3	;b	151f
+	add	r20, r20, r4	;b	151f
+	add	r20, r20, r5	;b	151f
+	add	r20, r20, r6	;b	151f
+	add	r20, r20, r7	;b	151f
+	add	r20, r20, r8	;b	151f
+	add	r20, r20, r9	;b	151f
+	add	r20, r20, r10	;b	151f
+	add	r20, r20, r11	;b	151f
+	add	r20, r20, r12	;b	151f
+	add	r20, r20, r13	;b	151f
+	add	r20, r20, r14	;b	151f
+	add	r20, r20, r15	;b	151f
+	add	r20, r20, r16	;b	151f
+	add	r20, r20, r17	;b	151f
+	add	r20, r20, r18	;b	151f
+	add	r20, r20, r19	;b	151f
+	mtctr	r21	;b	154f	/* r20 needs special handling */
+	mtctr	r21	;b	153f	/* r21 needs special handling */
+	add	r20, r20, r22	;b	151f
+	add	r20, r20, r23	;b	151f
+	add	r20, r20, r24	;b	151f
+	add	r20, r20, r25	;b	151f
+	add	r20, r20, r26	;b	151f
+	add	r20, r20, r27	;b	151f
+	add	r20, r20, r28	;b	151f
+	add	r20, r20, r29	;b	151f
+	add	r20, r20, r30	;b	151f
+	add	r20, r20, r31
+151:
+	rlwinm. r21,r21,19,24,28	/* offset into jump table for reg RA */
+	beq	152f			/* if reg RA is zero, don't add it */ 
+	addi	r21, r21, 150b@l	/* add start of table */
+	mtctr	r21			/* load ctr with jump address */
+	rlwinm	r21,r21,0,16,10		/* make sure we don't execute this more than once */
+	bctr				/* jump into table */
+152:
+	mfdar	r21
+	mtctr	r21			/* restore ctr reg from DAR */
+	mtdar	r20			/* save fault EA to DAR */
+	b	DARFixed		/* Go back to normal TLB handling */
+
+	/* special handling for r20,r21 since these are modified already */
+153:	lwz	r21, 4(r0)	/* load r21 from memory */
+	b	155f
+154:	mfspr	r21, M_TW	/* load r20 from M_TW */
+155:	add	r20, r20, r21	/* add it */
+	mfctr	r21		/* restore r21 */
+	b	151b
+#endif
 
 /*
  * This code finishes saving the registers to the exception frame
-- 
1.7.3.4
