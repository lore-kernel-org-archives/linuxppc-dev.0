Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 149E91A0A82
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 17:04:32 +1000 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 06/20] powerpc/8xx: No need to save r10 and r3 when not
 calling FixupDAR
Message-Id: <20140808070341.409251ABD42@localhost.localdomain>
Date: Fri,  8 Aug 2014 09:03:41 +0200 (CEST)
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

r10 and r3 are only used inside FixupDAR function. So lets save them inside
that function only.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 arch/powerpc/kernel/head_8xx.S |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 171c6ef..845abf8 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -482,20 +482,12 @@ InstructionTLBError:
  */
 	. = 0x1400
 DataTLBError:
-#ifdef CONFIG_8xx_CPU6
-	stw	r3, 8(r0)
-#endif
 	EXCEPTION_PROLOG_0
-	mtspr	SPRN_SPRG_SCRATCH2, r10
 
-	mfspr	r10, SPRN_DAR
-	cmpwi	cr0, r10, 0x00f0
+	mfspr	r11, SPRN_DAR
+	cmpwi	cr0, r11, 0x00f0
 	beq-	FixupDAR	/* must be a buggy dcbX, icbi insn. */
 DARFixed:/* Return from dcbx instruction bug workaround */
-#ifdef CONFIG_8xx_CPU6
-	lwz	r3, 8(r0)
-#endif
-	mfspr	r10,SPRN_SPRG_SCRATCH2
 	EXCEPTION_EPILOG_0
 	b	DataAccess
 
@@ -525,6 +517,10 @@ DARFixed:/* Return from dcbx instruction bug workaround */
  /* define if you don't want to use self modifying code */
 #define NO_SELF_MODIFYING_CODE
 FixupDAR:/* Entry point for dcbx workaround. */
+#ifdef CONFIG_8xx_CPU6
+	stw	r3, 8(r0)
+#endif
+	mtspr	SPRN_SPRG_SCRATCH2, r10
 	/* fetch instruction from memory. */
 	mfspr	r10, SPRN_SRR0
 	andis.	r11, r10, 0x8000	/* Address >= 0x80000000 */
@@ -540,6 +536,9 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	mtspr	SPRN_MD_TWC, r11	/* Load pte table base address */
 	mfspr	r11, SPRN_MD_TWC	/* ....and get the pte address */
 	lwz	r11, 0(r11)	/* Get the pte */
+#ifdef CONFIG_8xx_CPU6
+	lwz	r3, 8(r0)	/* restore r3 from memory */
+#endif
 	/* concat physical page address(r11) and page offset(r10) */
 	rlwimi	r11, r10, 0, 20, 31
 	lwz	r11,0(r11)
@@ -560,15 +559,13 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	beq+	142f
 	cmpwi	cr0, r10, 1964	/* Is icbi? */
 	beq+	142f
-141:	b	DARFixed	/* Nope, go back to normal TLB processing */
+141:	mfspr	r10,SPRN_SPRG_SCRATCH2
+	b	DARFixed	/* Nope, go back to normal TLB processing */
 
 144:	mfspr	r10, SPRN_DSISR
 	rlwinm	r10, r10,0,7,5	/* Clear store bit for buggy dcbst insn */
 	mtspr	SPRN_DSISR, r10
 142:	/* continue, it was a dcbx, dcbi instruction. */
-#ifdef CONFIG_8xx_CPU6
-	lwz	r3, 8(r0)	/* restore r3 from memory */
-#endif
 #ifndef NO_SELF_MODIFYING_CODE
 	andis.	r10,r11,0x1f	/* test if reg RA is r0 */
 	li	r10,modified_instr@l
@@ -587,6 +584,7 @@ modified_instr:
 	bne+	143f
 	subf	r10,r0,r10	/* r10=r10-r0, only if reg RA is r0 */
 143:	mtdar	r10		/* store faulting EA in DAR */
+	mfspr	r10,SPRN_SPRG_SCRATCH2
 	b	DARFixed	/* Go back to normal TLB handling */
 #else
 	mfctr	r10
@@ -640,6 +638,7 @@ modified_instr:
 	mfdar	r11
 	mtctr	r11			/* restore ctr reg from DAR */
 	mtdar	r10			/* save fault EA to DAR */
+	mfspr	r10,SPRN_SPRG_SCRATCH2
 	b	DARFixed		/* Go back to normal TLB handling */
 
 	/* special handling for r10,r11 since these are modified already */
-- 
1.7.1
