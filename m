Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNjvx6yn0zDw1q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 11:32:13 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm-ppc@vger.kernel.org,
	kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH v2 08/11] KVM: PPC: Book3S HV: Use stop instruction rather
 than nap on POWER9
Date: Wed, 23 Nov 2016 11:32:02 +1100
Message-Id: <1479861125-21394-9-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1479861125-21394-1-git-send-email-paulus@ozlabs.org>
References: <1479861125-21394-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 replaces the various power-saving mode instructions on POWER8
(doze, nap, sleep and rvwinkle) with a single "stop" instruction, plus
a register, PSSCR, which controls the depth of the power-saving mode.
This replaces the use of the nap instruction when threads are idle
during guest execution with the stop instruction, and adds code to
set PSSCR to a value which will allow an SMT mode switch while the
thread is idle (given that the core as a whole won't be idle in these
cases).

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 598d828..9338a81 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -501,17 +501,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	cmpwi	r0, 0
 	beq	57f
 	li	r3, (LPCR_PECEDH | LPCR_PECE0) >> 4
-	mfspr	r4, SPRN_LPCR
-	rlwimi	r4, r3, 4, (LPCR_PECEDP | LPCR_PECEDH | LPCR_PECE0 | LPCR_PECE1)
-	mtspr	SPRN_LPCR, r4
-	isync
-	std	r0, HSTATE_SCRATCH0(r13)
-	ptesync
-	ld	r0, HSTATE_SCRATCH0(r13)
-1:	cmpd	r0, r0
-	bne	1b
-	nap
-	b	.
+	mfspr	r5, SPRN_LPCR
+	rlwimi	r5, r3, 4, (LPCR_PECEDP | LPCR_PECEDH | LPCR_PECE0 | LPCR_PECE1)
+	b	kvm_nap_sequence
 
 57:	li	r0, 0
 	stbx	r0, r3, r4
@@ -2256,6 +2248,21 @@ BEGIN_FTR_SECTION
 	ori	r5, r5, LPCR_PECEDH
 	rlwimi	r5, r3, 0, LPCR_PECEDP
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
+
+kvm_nap_sequence:		/* desired LPCR value in r5 */
+BEGIN_FTR_SECTION
+	/*
+	 * PSSCR bits:	exit criterion = 1 (wakeup based on LPCR at sreset)
+	 *		enable state loss = 1 (allow SMT mode switch)
+	 *		requested level = 0 (just stop dispatching)
+	 */
+	lis	r3, (PSSCR_EC | PSSCR_ESL)@h
+	mtspr	SPRN_PSSCR, r3
+	/* Set LPCR_PECE_HVEE bit to enable wakeup by HV interrupts */
+	li	r4, LPCR_PECE_HVEE@higher
+	sldi	r4, r4, 32
+	or	r5, r5, r4
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	mtspr	SPRN_LPCR,r5
 	isync
 	li	r0, 0
@@ -2264,7 +2271,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	ld	r0, HSTATE_SCRATCH0(r13)
 1:	cmpd	r0, r0
 	bne	1b
+BEGIN_FTR_SECTION
 	nap
+FTR_SECTION_ELSE
+	PPC_STOP
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
 	b	.
 
 33:	mr	r4, r3
-- 
2.7.4
