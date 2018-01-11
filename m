Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHMCQ10NLzF0WY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:13:22 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id j4so1885162pgp.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:13:22 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 25/26] KVM: PPC: Book3S PR: Support TAR handling for PR KVM
 HTM.
Date: Thu, 11 Jan 2018 18:11:38 +0800
Message-Id: <1515665499-31710-26-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

Currently guest kernel doesn't handle TAR fac unavailable and it always
runs with TAR bit on. PR KVM will lazily enable TAR. TAR is not a
frequent-use reg and it is not included in SVCPU struct.

To make it work for transaction memory at PR KVM:
1). Flush/giveup TAR at kvmppc_save_tm_pr().
2) If we are receiving a TAR fac unavail exception inside a transaction,
the checkpointed TAR might be a TAR value from another process. So we need
treclaim the transaction, then load the desired TAR value into reg, and
perform trecheckpoint.
3) Load TAR facility at kvmppc_restore_tm_pr() when TM active.
The reason we always loads TAR when restoring TM is that:
If we don't do this way, when there is a TAR fac unavailable exception
during TM active:
case 1: it is the 1st TAR fac unavail exception after tbegin.
vcpu->arch.tar should be reloaded as checkpoint tar val.
case 2: it is the 2nd or later TAR fac unavail exception after tbegin.
vcpu->arch.tar_tm should be reloaded as checkpoint tar val.
There will be unnecessary difficulty to handle the above 2 cases.

at the end of emulating treclaim., the correct TAR val need to be loaded
into reg if FSCR_TAR bit is on.
at the beginning of emulating trechkpt., TAR needs to be flushed so that
the right tar val can be copy into tar_tm.

Tested with:
tools/testing/selftests/powerpc/tm/tm-tar
tools/testing/selftests/powerpc/ptrace/ptrace-tm-tar (remove DSCR/PPR
related testing).

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s.h |  1 +
 arch/powerpc/kvm/book3s_emulate.c     |  4 ++++
 arch/powerpc/kvm/book3s_pr.c          | 31 +++++++++++++++++++++++++++++--
 arch/powerpc/kvm/tm.S                 | 16 ++++++++++++++--
 4 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 8bd454c..6635506 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -259,6 +259,7 @@ extern void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu);
 void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu);
 void kvmppc_save_tm_sprs(struct kvm_vcpu *vcpu);
+void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac);
 #endif
 
 extern int kvm_irq_bypass;
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 11d76be..52ae307 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -167,6 +167,9 @@ static void kvmppc_emulate_treclaim(struct kvm_vcpu *vcpu, int ra_val)
 	mtspr(SPRN_TFIAR, vcpu->arch.tfiar);
 	tm_disable();
 	preempt_enable();
+
+	if (vcpu->arch.shadow_fscr & FSCR_TAR)
+		mtspr(SPRN_TAR, vcpu->arch.tar);
 }
 
 static void kvmppc_emulate_trchkpt(struct kvm_vcpu *vcpu)
@@ -183,6 +186,7 @@ static void kvmppc_emulate_trchkpt(struct kvm_vcpu *vcpu)
 	 * copy.
 	 */
 	kvmppc_giveup_ext(vcpu, MSR_VSX);
+	kvmppc_giveup_fac(vcpu, FSCR_TAR_LG);
 	kvmppc_copyto_vcpu_tm(vcpu);
 	kvmppc_restore_tm_pr(vcpu);
 	preempt_enable();
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index cc568bc..9085524 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -56,7 +56,6 @@
 static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
 			     ulong msr);
 static int kvmppc_load_ext(struct kvm_vcpu *vcpu, ulong msr);
-static void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac);
 
 /* Some compatibility defines */
 #ifdef CONFIG_PPC_BOOK3S_32
@@ -306,6 +305,7 @@ void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu)
 	vcpu->arch.save_msr_tm |= (vcpu->arch.guest_owned_ext &
 			(MSR_FP | MSR_VEC | MSR_VSX));
 
+	kvmppc_giveup_fac(vcpu, FSCR_TAR_LG);
 	kvmppc_giveup_ext(vcpu, MSR_VSX);
 
 	preempt_disable();
@@ -320,8 +320,20 @@ void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu)
 		return;
 	}
 
+
 	preempt_disable();
 	_kvmppc_restore_tm_pr(vcpu, vcpu->arch.save_msr_tm);
+
+	if (!(vcpu->arch.shadow_fscr & FSCR_TAR)) {
+		/* always restore TAR in TM active state, since we don't
+		 * want to be confused at fac unavailable while TM active:
+		 * load vcpu->arch.tar or vcpu->arch.tar_tm as chkpt value?
+		 */
+		current->thread.tar = mfspr(SPRN_TAR);
+		mtspr(SPRN_TAR, vcpu->arch.tar);
+		vcpu->arch.shadow_fscr |= FSCR_TAR;
+	}
+
 	preempt_enable();
 
 	if (vcpu->arch.save_msr_tm & MSR_VSX)
@@ -333,6 +345,7 @@ void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu)
 		if (vcpu->arch.save_msr_tm & MSR_FP)
 			kvmppc_load_ext(vcpu, MSR_FP);
 	}
+
 }
 #endif
 
@@ -828,7 +841,7 @@ void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr)
 }
 
 /* Give up facility (TAR / EBB / DSCR) */
-static void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac)
+void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (!(vcpu->arch.shadow_fscr & (1ULL << fac))) {
@@ -1031,6 +1044,20 @@ static int kvmppc_handle_fac(struct kvm_vcpu *vcpu, ulong fac)
 
 	switch (fac) {
 	case FSCR_TAR_LG:
+		if (MSR_TM_ACTIVE(mfmsr())) {
+			/* When tbegin. was executed, the TAR in checkpoint
+			 * state might be invalid. We need treclaim., then
+			 * load correct TAR value, and perform trechkpt.,
+			 * so that valid TAR val can be checkpointed.
+			 */
+			preempt_disable();
+			kvmppc_save_tm_pr(vcpu);
+
+			vcpu->arch.tar_tm = vcpu->arch.tar;
+
+			kvmppc_restore_tm_pr(vcpu);
+			preempt_enable();
+		}
 		/* TAR switching isn't lazy in Linux yet */
 		current->thread.tar = mfspr(SPRN_TAR);
 		mtspr(SPRN_TAR, vcpu->arch.tar);
diff --git a/arch/powerpc/kvm/tm.S b/arch/powerpc/kvm/tm.S
index 5752bae..8b73af4 100644
--- a/arch/powerpc/kvm/tm.S
+++ b/arch/powerpc/kvm/tm.S
@@ -164,13 +164,16 @@ _GLOBAL(_kvmppc_save_tm_pr)
 	mfmsr	r5
 	SAVE_GPR(5, r1)
 
-	/* also save DSCR/CR so that it can be recovered later */
+	/* also save DSCR/CR/TAR so that it can be recovered later */
 	mfspr   r6, SPRN_DSCR
 	SAVE_GPR(6, r1)
 
 	mfcr    r7
 	stw     r7, _CCR(r1)
 
+	mfspr   r8, SPRN_TAR
+	SAVE_GPR(8, r1)
+
 	/* allocate stack frame for __kvmppc_save_tm since
 	 * it will save LR into its stackframe and we don't
 	 * want to corrupt _kvmppc_save_tm_pr's.
@@ -179,6 +182,9 @@ _GLOBAL(_kvmppc_save_tm_pr)
 	bl	__kvmppc_save_tm
 	addi    r1, r1, PPC_MIN_STKFRM
 
+	REST_GPR(8, r1)
+	mtspr   SPRN_TAR, r8
+
 	ld      r7, _CCR(r1)
 	mtcr	r7
 
@@ -341,13 +347,16 @@ _GLOBAL(_kvmppc_restore_tm_pr)
 	mfmsr	r5
 	SAVE_GPR(5, r1)
 
-	/* also save DSCR/CR so that it can be recovered later */
+	/* also save DSCR/CR/TAR so that it can be recovered later */
 	mfspr   r6, SPRN_DSCR
 	SAVE_GPR(6, r1)
 
 	mfcr    r7
 	stw     r7, _CCR(r1)
 
+	mfspr   r8, SPRN_TAR
+	SAVE_GPR(8, r1)
+
 	/* allocate stack frame for __kvmppc_restore_tm since
 	 * it will save LR into its own stackframe.
 	 */
@@ -356,6 +365,9 @@ _GLOBAL(_kvmppc_restore_tm_pr)
 	bl	__kvmppc_restore_tm
 	addi    r1, r1, PPC_MIN_STKFRM
 
+	REST_GPR(8, r1)
+	mtspr   SPRN_TAR, r8
+
 	ld      r7, _CCR(r1)
 	mtcr	r7
 
-- 
1.8.3.1
