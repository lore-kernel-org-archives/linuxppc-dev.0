Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AD68CB7C3E
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 03:35:27 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>, Scott Wood <scottwood@freescale.com>
Subject: [PATCH 5/8] 8xx: dcbst sets store bit in DTLB error, workaround.
Date: Sun, 11 Oct 2009 18:35:09 +0200
Message-Id: <1255278912-8042-6-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1255278912-8042-5-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-5-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

dcbst should not set the store bit(bit 6, DSISR) when
trapping into a DTLB Error. Clear this bit while doing
the dcbX missing DAR workaround.
---
 arch/powerpc/kernel/head_8xx.S |   34 +++++++++++++++++++++++++++++++---
 1 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 9839e79..027856e 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -496,10 +496,14 @@ DataTLBError:
 	cmpwi	cr0, r10, 0x00f0
 	beq-	FixDAR	/* must be a buggy dcbX, icbi insn. */
 DARFix:	/* Return from dcbx instruction bug workaround, r10 holds value of DAR */
-
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
@@ -632,6 +636,30 @@ FixDAR:	/* Entry point for dcbx workaround. */
 	tophys  (r11, r10)
 	beq-	139b		/* Branch if user space address */
 140:	lwz	r11,0(r11)
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
 #ifdef CONFIG_8xx_CPU6
 	lwz	r3, 8(r0)	/* restore r3 from memory */
 #endif
-- 
1.6.4.4
