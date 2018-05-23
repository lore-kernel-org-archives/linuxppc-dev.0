Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPl91vrkzDrph
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:48:21 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id e1-v6so9037657pga.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:48:21 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v4 24/29] KVM: PPC: Book3S PR: Support TAR handling for PR KVM
 HTM.
Date: Wed, 23 May 2018 15:02:07 +0800
Message-Id: <1527058932-7434-25-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
References: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
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

Due to the above, the checkpointed TAR val might be a bogus TAR val.
To solve this issue, we will make vcpu->arch.fscr tar bit consistent
with shadow_fscr when TM enabled.

At the end of emulating treclaim., the correct TAR val need to be loaded
into reg if FSCR_TAR bit is on.
At the beginning of emulating trechkpt., TAR needs to be flushed so that
the right tar val can be copy into tar_tm.

Tested with:
tools/testing/selftests/powerpc/tm/tm-tar
tools/testing/selftests/powerpc/ptrace/ptrace-tm-tar (remove DSCR/PPR
related testing).

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s.h |  2 ++
 arch/powerpc/kvm/book3s_emulate.c     |  4 ++++
 arch/powerpc/kvm/book3s_pr.c          | 23 ++++++++++++++++++-----
 arch/powerpc/kvm/tm.S                 | 16 ++++++++++++++--
 4 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 2940de7..1f345a0 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -271,6 +271,8 @@ static inline void kvmppc_save_tm_sprs(struct kvm_vcpu *vcpu) {}
 static inline void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu) {}
 #endif
 
+void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac);
+
 extern int kvm_irq_bypass;
 
 static inline struct kvmppc_vcpu_book3s *to_book3s(struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 67d0fb40..fdbc695 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -173,6 +173,9 @@ static void kvmppc_emulate_treclaim(struct kvm_vcpu *vcpu, int ra_val)
 	guest_msr &= ~(MSR_TS_MASK);
 	kvmppc_set_msr(vcpu, guest_msr);
 	preempt_enable();
+
+	if (vcpu->arch.shadow_fscr & FSCR_TAR)
+		mtspr(SPRN_TAR, vcpu->arch.tar);
 }
 
 static void kvmppc_emulate_trchkpt(struct kvm_vcpu *vcpu)
@@ -185,6 +188,7 @@ static void kvmppc_emulate_trchkpt(struct kvm_vcpu *vcpu)
 	 * copy.
 	 */
 	kvmppc_giveup_ext(vcpu, MSR_VSX);
+	kvmppc_giveup_fac(vcpu, FSCR_TAR_LG);
 	kvmppc_copyto_vcpu_tm(vcpu);
 	kvmppc_save_tm_sprs(vcpu);
 
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 526c928..f7864da 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -55,7 +55,9 @@
 
 static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
 			     ulong msr);
-static void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac);
+#ifdef CONFIG_PPC_BOOK3S_64
+static int kvmppc_handle_fac(struct kvm_vcpu *vcpu, ulong fac);
+#endif
 
 /* Some compatibility defines */
 #ifdef CONFIG_PPC_BOOK3S_32
@@ -346,6 +348,7 @@ void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu)
 		return;
 	}
 
+	kvmppc_giveup_fac(vcpu, FSCR_TAR_LG);
 	kvmppc_giveup_ext(vcpu, MSR_VSX);
 
 	preempt_disable();
@@ -357,8 +360,11 @@ void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu)
 {
 	if (!MSR_TM_ACTIVE(kvmppc_get_msr(vcpu))) {
 		kvmppc_restore_tm_sprs(vcpu);
-		if (kvmppc_get_msr(vcpu) & MSR_TM)
+		if (kvmppc_get_msr(vcpu) & MSR_TM) {
 			kvmppc_handle_lost_math_exts(vcpu);
+			if (vcpu->arch.fscr & FSCR_TAR)
+				kvmppc_handle_fac(vcpu, FSCR_TAR_LG);
+		}
 		return;
 	}
 
@@ -366,9 +372,11 @@ void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu)
 	_kvmppc_restore_tm_pr(vcpu, kvmppc_get_msr(vcpu));
 	preempt_enable();
 
-	if (kvmppc_get_msr(vcpu) & MSR_TM)
+	if (kvmppc_get_msr(vcpu) & MSR_TM) {
 		kvmppc_handle_lost_math_exts(vcpu);
-
+		if (vcpu->arch.fscr & FSCR_TAR)
+			kvmppc_handle_fac(vcpu, FSCR_TAR_LG);
+	}
 }
 #endif
 
@@ -819,7 +827,7 @@ void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr)
 }
 
 /* Give up facility (TAR / EBB / DSCR) */
-static void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac)
+void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (!(vcpu->arch.shadow_fscr & (1ULL << fac))) {
@@ -1020,7 +1028,12 @@ void kvmppc_set_fscr(struct kvm_vcpu *vcpu, u64 fscr)
 	if ((vcpu->arch.fscr & FSCR_TAR) && !(fscr & FSCR_TAR)) {
 		/* TAR got dropped, drop it in shadow too */
 		kvmppc_giveup_fac(vcpu, FSCR_TAR_LG);
+	} else if (!(vcpu->arch.fscr & FSCR_TAR) && (fscr & FSCR_TAR)) {
+		vcpu->arch.fscr = fscr;
+		kvmppc_handle_fac(vcpu, FSCR_TAR_LG);
+		return;
 	}
+
 	vcpu->arch.fscr = fscr;
 }
 #endif
diff --git a/arch/powerpc/kvm/tm.S b/arch/powerpc/kvm/tm.S
index 42a7cd8..e6ce4c7 100644
--- a/arch/powerpc/kvm/tm.S
+++ b/arch/powerpc/kvm/tm.S
@@ -225,15 +225,21 @@ _GLOBAL(_kvmppc_save_tm_pr)
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
 	bl	__kvmppc_save_tm
 
+	REST_GPR(8, r1)
+	mtspr   SPRN_TAR, r8
+
 	ld      r7, _CCR(r1)
 	mtcr	r7
 
@@ -423,15 +429,21 @@ _GLOBAL(_kvmppc_restore_tm_pr)
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
 	bl	__kvmppc_restore_tm
 
+	REST_GPR(8, r1)
+	mtspr   SPRN_TAR, r8
+
 	ld      r7, _CCR(r1)
 	mtcr	r7
 
-- 
1.8.3.1
