Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405mCB4mK0zF0gF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 21:25:10 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH 5/5] KVM: PPC: Book3S HV: Work around TEXASR bug in fake
 suspend state
Date: Wed, 21 Mar 2018 21:25:01 +1100
Message-Id: <1521627901-13547-6-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1521627901-13547-1-git-send-email-paulus@ozlabs.org>
References: <1521627901-13547-1-git-send-email-paulus@ozlabs.org>
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

With this workaround, the code will actually run slightly faster, and
will operate correctly on systems without the TEXASR bug (since TEXASR
may not be written in suspend state, and is only changed by failure
recording, which will have already been done before we get into fake
suspend state).  Therefore these changes are not made subject to a CPU
feature bit.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kernel/idle_book3s.S       |  4 ++--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 17 ++++++++++-------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 72b8d19..89157cf 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -430,7 +430,7 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
  * r3 contains desired PSSCR register value.
  */
 _GLOBAL(power9_idle_stop)
-BEGIN_FEATURE_SECTION
+BEGIN_FTR_SECTION
 	lwz	r5, PACA_DONT_STOP(r13)
 	cmpwi	r5, 0
 	bne	1f
@@ -439,7 +439,7 @@ BEGIN_FEATURE_SECTION
 	lwz	r5, PACA_DONT_STOP(r13)
 	cmpwi	r5, 0
 	bne	1f
-END_FEATURE_SECTION_IFSET(CPU_FTR_P9_TM_XER_SO_BUG)
+END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_XER_SO_BUG)
 	mtspr 	SPRN_PSSCR,r3
 	LOAD_REG_ADDR(r4,power_enter_stop)
 	b	pnv_powersave_common
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 11396c0..736809f 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -3117,10 +3117,6 @@ kvmppc_save_tm:
 	li	r3, TM_CAUSE_KVM_RESCHED
 
 BEGIN_FTR_SECTION
-	/* Emulation of the treclaim instruction needs TEXASR before treclaim */
-	mfspr	r6, SPRN_TEXASR
-	std	r6, VCPU_ORIG_TEXASR(r9)
-
 	lbz	r0, HSTATE_FAKE_SUSPEND(r13) /* Were we fake suspended? */
 	cmpwi	r0, 0
 	beq	3f
@@ -3130,7 +3126,12 @@ BEGIN_FTR_SECTION_NESTED(96)
 	bl	pnv_power9_force_smt4_catch
 END_FTR_SECTION_NESTED(CPU_FTR_P9_TM_XER_SO_BUG, CPU_FTR_P9_TM_XER_SO_BUG, 96)
 	nop
+	b	6f
 3:
+	/* Emulation of the treclaim instruction needs TEXASR before treclaim */
+	mfspr	r6, SPRN_TEXASR
+	std	r6, VCPU_ORIG_TEXASR(r9)
+6:
 END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
 
 	/* Clear the MSR RI since r1, r13 are all going to be foobar. */
@@ -3176,7 +3177,8 @@ END_FTR_SECTION_NESTED(CPU_FTR_P9_TM_XER_SO_BUG, CPU_FTR_P9_TM_XER_SO_BUG, 96)
 	andc	r3, r3, r0
 	mtspr	SPRN_PSSCR, r3
 	ld	r9, HSTATE_KVM_VCPU(r13)
-	b	1f
+	/* Don't save TEXASR, use value from last exit in real suspend state */
+	b	11f
 2:
 END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
 
@@ -3250,12 +3252,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
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
