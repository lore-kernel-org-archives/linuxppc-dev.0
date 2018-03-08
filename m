Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxhKb3QwTzF1lw
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 18:02:43 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH RFC 5/5] KVM: PPC: Book3S HV: Work around TEXASR bug in fake
 suspend mode
Date: Thu,  8 Mar 2018 18:02:31 +1100
Message-Id: <1520492551-799-6-git-send-email-paulus@ozlabs.org>
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

This works around a hardware bug in "Nimbus" POWER9 DD2.2 processors,
where the contents of the TEXASR can get corrupted while a thread is
in fake suspend state.  The workaround is for the instruction emulation
code to use the value saved at the most recent guest exit in real
suspend mode.  We achieve this by simply not saving the TEXASR into
the vcpu struct on an exit in fake suspend state.  We also have to
take care to set the orig_texasr field only on guest exit in real
suspend state.

This also means that on guest entry in fake suspend state, TEXASR
will be restored to the value it had on the last exit in real suspend
state, effectively counteracting any hardware-caused corruption.  This
works because TEXASR may not be written in suspend state.

With this, the guest might see the wrong values in TEXASR if it reads
it while in suspend state, but will see the correct value in
non-transactional state (e.g. after a treclaim), and treclaim will
work correctly.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 7b932f1..f374073 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -3105,10 +3105,6 @@ kvmppc_save_tm:
 	li	r3, TM_CAUSE_KVM_RESCHED
 
 BEGIN_FTR_SECTION
-	/* Emulation of the treclaim instruction needs TEXASR before treclaim */
-	mfspr	r6, SPRN_TEXASR
-	std	r6, VCPU_ORIG_TEXASR(r9)
-
 	lbz	r0, HSTATE_FAKE_SUSPEND(r13) /* Were we fake suspended? */
 	cmpwi	r0, 0
 	beq	3f
@@ -3116,7 +3112,12 @@ BEGIN_FTR_SECTION
 	beq	4f
 	bl	pnv_power9_force_smt4_catch
 	nop
+	b	6f
 3:
+	/* Emulation of the treclaim instruction needs TEXASR before treclaim */
+	mfspr	r6, SPRN_TEXASR
+	std	r6, VCPU_ORIG_TEXASR(r9)
+6:
 END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_EMUL)
 
 	/* Clear the MSR RI since r1, r13 are all going to be foobar. */
@@ -3160,7 +3161,8 @@ BEGIN_FTR_SECTION
 	andc	r3, r3, r0
 	mtspr	SPRN_PSSCR, r3
 	ld	r9, HSTATE_KVM_VCPU(r13)
-	b	1f
+	/* Don't save TEXASR, use value from last exit in real suspend state */
+	b	11f
 2:
 END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_EMUL)
 
@@ -3234,12 +3236,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_EMUL)
 	 * change these outside of a transaction, so they must always be
 	 * context switched.
 	 */
+	mfspr	r7, SPRN_TEXASR
+	std	r7, VCPU_TEXASR(r9)
+11:
 	mfspr	r5, SPRN_TFHAR
 	mfspr	r6, SPRN_TFIAR
-	mfspr	r7, SPRN_TEXASR
 	std	r5, VCPU_TFHAR(r9)
 	std	r6, VCPU_TFIAR(r9)
-	std	r7, VCPU_TEXASR(r9)
 
 	addi	r1, r1, PPC_MIN_STKFRM
 	ld	r0, PPC_LR_STKOFF(r1)
-- 
2.7.4
