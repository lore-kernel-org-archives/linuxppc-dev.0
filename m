Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPl12QR1zDrnr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:48:13 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id e21-v6so4136314pgv.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:48:13 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v4 21/29] KVM: PPC: Book3S PR: add emulation for trechkpt in
 PR KVM.
Date: Wed, 23 May 2018 15:02:04 +0800
Message-Id: <1527058932-7434-22-git-send-email-wei.guo.simon@gmail.com>
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

This patch adds host emulation when guest PR KVM executes "trechkpt.",
which is a privileged instruction and will trap into host.

We firstly copy vcpu ongoing content into vcpu tm checkpoint
content, then perform kvmppc_restore_tm_pr() to do trechkpt.
with updated vcpu tm checkpoint vals.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s.h |  2 ++
 arch/powerpc/kvm/book3s_emulate.c     | 61 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_pr.c          |  2 +-
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index c1cea82..2940de7 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -262,10 +262,12 @@ extern void kvmppc_update_lpcr(struct kvm *kvm, unsigned long lpcr,
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu);
 void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu);
+void kvmppc_save_tm_sprs(struct kvm_vcpu *vcpu);
 void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu);
 #else
 static inline void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu) {}
 static inline void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu) {}
+static inline void kvmppc_save_tm_sprs(struct kvm_vcpu *vcpu) {}
 static inline void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu) {}
 #endif
 
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 04c29e0..b7530cf 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -52,6 +52,7 @@
 #define OP_31_XOP_TBEGIN	654
 
 #define OP_31_XOP_TRECLAIM	942
+#define OP_31_XOP_TRCHKPT	1006
 
 /* DCBZ is actually 1014, but we patch it to 1010 so we get a trap */
 #define OP_31_XOP_DCBZ		1010
@@ -172,6 +173,29 @@ static void kvmppc_emulate_treclaim(struct kvm_vcpu *vcpu, int ra_val)
 	kvmppc_set_msr(vcpu, guest_msr);
 	preempt_enable();
 }
+
+static void kvmppc_emulate_trchkpt(struct kvm_vcpu *vcpu)
+{
+	unsigned long guest_msr = kvmppc_get_msr(vcpu);
+
+	preempt_disable();
+	/*
+	 * need flush FP/VEC/VSX to vcpu save area before
+	 * copy.
+	 */
+	kvmppc_giveup_ext(vcpu, MSR_VSX);
+	kvmppc_copyto_vcpu_tm(vcpu);
+	kvmppc_save_tm_sprs(vcpu);
+
+	/*
+	 * as a result of trecheckpoint. set TS to suspended.
+	 */
+	guest_msr &= ~(MSR_TS_MASK);
+	guest_msr |= MSR_TS_S;
+	kvmppc_set_msr(vcpu, guest_msr);
+	kvmppc_restore_tm_pr(vcpu);
+	preempt_enable();
+}
 #endif
 
 int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
@@ -478,6 +502,43 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			kvmppc_emulate_treclaim(vcpu, ra_val);
 			break;
 		}
+		case OP_31_XOP_TRCHKPT:
+		{
+			ulong guest_msr = kvmppc_get_msr(vcpu);
+			unsigned long texasr;
+
+			if (!cpu_has_feature(CPU_FTR_TM))
+				break;
+
+			if (!(kvmppc_get_msr(vcpu) & MSR_TM)) {
+				kvmppc_trigger_fac_interrupt(vcpu, FSCR_TM_LG);
+				emulated = EMULATE_AGAIN;
+				break;
+			}
+
+			/* generate interrupt based on priorities */
+			if (guest_msr & MSR_PR) {
+				/* Privileged Instruction type Program Intr */
+				kvmppc_core_queue_program(vcpu, SRR1_PROGPRIV);
+				emulated = EMULATE_AGAIN;
+				break;
+			}
+
+			tm_enable();
+			texasr = mfspr(SPRN_TEXASR);
+			tm_disable();
+
+			if (MSR_TM_ACTIVE(guest_msr) ||
+				!(texasr & (TEXASR_FS))) {
+				/* TM bad thing interrupt */
+				kvmppc_core_queue_program(vcpu, SRR1_PROGTM);
+				emulated = EMULATE_AGAIN;
+				break;
+			}
+
+			kvmppc_emulate_trchkpt(vcpu);
+			break;
+		}
 #endif
 		default:
 			emulated = EMULATE_FAIL;
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 9a72460..5359f9c 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -299,7 +299,7 @@ void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu)
 }
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-static inline void kvmppc_save_tm_sprs(struct kvm_vcpu *vcpu)
+void kvmppc_save_tm_sprs(struct kvm_vcpu *vcpu)
 {
 	tm_enable();
 	vcpu->arch.tfhar = mfspr(SPRN_TFHAR);
-- 
1.8.3.1
