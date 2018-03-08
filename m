Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxhKZ65vwzF1ll
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 18:02:42 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH RFC 4/5] KVM: PPC: Book3S HV: Work around XER[SO] bug in fake
 suspend mode
Date: Thu,  8 Mar 2018 18:02:30 +1100
Message-Id: <1520492551-799-5-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1520492551-799-1-git-send-email-paulus@ozlabs.org>
References: <1520492551-799-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

This works around a hardware bug in "Nimbus" POWER9 DD2.2 processors,
where a treclaim performed in fake suspend mode can cause subsequent
reads from the XER register to return inconsistent values for the SO
(summary overflow) bit.  The inconsistent SO bit state can potentially
be observed on any thread in the core.  We have to do the treclaim
because that is the only way to get the thread out of suspend state
(fake or real) and into non-transactional state.

The workaround for the bug is to force the core into SMT4 mode before
doing the treclaim.  This patch adds the code to do that.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index f73eba6..7b932f1 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -3089,6 +3089,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 kvmppc_save_tm:
 	mflr	r0
 	std	r0, PPC_LR_STKOFF(r1)
+	stdu	r1, -PPC_MIN_STKFRM(r1)
 
 	/* Turn on TM. */
 	mfmsr	r8
@@ -3108,8 +3109,14 @@ BEGIN_FTR_SECTION
 	mfspr	r6, SPRN_TEXASR
 	std	r6, VCPU_ORIG_TEXASR(r9)
 
-	rldicl. r8, r8, 64 - MSR_TS_S_LG, 62
+	lbz	r0, HSTATE_FAKE_SUSPEND(r13) /* Were we fake suspended? */
+	cmpwi	r0, 0
 	beq	3f
+	rldicl. r8, r8, 64 - MSR_TS_S_LG, 62 /* Did we actually hrfid? */
+	beq	4f
+	bl	pnv_power9_force_smt4_catch
+	nop
+3:
 END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_EMUL)
 
 	/* Clear the MSR RI since r1, r13 are all going to be foobar. */
@@ -3126,7 +3133,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_EMUL)
 
 	/* If doing TM emulation on POWER9 DD2.2, check for fake suspend mode */
 BEGIN_FTR_SECTION
-3:
 	lbz	r9, HSTATE_FAKE_SUSPEND(r13)
 	cmpwi	r9, 0
 	beq	2f
@@ -3138,13 +3144,16 @@ BEGIN_FTR_SECTION
 	/* Reload stack pointer and TOC. */
 	ld	r1, HSTATE_HOST_R1(r13)
 	ld	r2, PACATOC(r13)
+	/* Set MSR RI now we have r1 and r13 back. */
 	li	r5, MSR_RI
 	mtmsrd	r5, 1
 	HMT_MEDIUM
 	ld	r6, HSTATE_DSCR(r13)
 	mtspr	SPRN_DSCR, r6
-	li	r0, 0
-	stb	r0, HSTATE_FAKE_SUSPEND(r13)
+	bl	pnv_power9_force_smt4_release
+	nop
+
+4:
 	mfspr	r3, SPRN_PSSCR
 	/* PSSCR_FAKE_SUSPEND is a write-only bit, but clear it anyway */
 	li	r0, PSSCR_FAKE_SUSPEND
@@ -3232,6 +3241,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_EMUL)
 	std	r6, VCPU_TFIAR(r9)
 	std	r7, VCPU_TEXASR(r9)
 
+	addi	r1, r1, PPC_MIN_STKFRM
 	ld	r0, PPC_LR_STKOFF(r1)
 	mtlr	r0
 	blr
@@ -3266,6 +3276,8 @@ kvmppc_restore_tm:
 	mtspr	SPRN_TFIAR, r6
 	mtspr	SPRN_TEXASR, r7
 
+	li	r0, 0
+	stb	r0, HSTATE_FAKE_SUSPEND(r13)
 	ld	r5, VCPU_MSR(r4)
 	rldicl. r5, r5, 64 - MSR_TS_S_LG, 62
 	beqlr		/* TM not active in guest */
-- 
2.7.4
