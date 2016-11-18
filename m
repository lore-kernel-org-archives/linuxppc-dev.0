Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKqP32dz0zDvt1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 18:28:55 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 12/13] KVM: PPC: Book3S HV: Use stop instruction rather than
 nap on POWER9
Date: Fri, 18 Nov 2016 18:28:41 +1100
Message-Id: <1479454122-26994-13-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
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
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index acae5c3..e9eaff4 100644
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
@@ -2256,6 +2248,17 @@ BEGIN_FTR_SECTION
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
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	mtspr	SPRN_LPCR,r5
 	isync
 	li	r0, 0
@@ -2264,7 +2267,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
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
