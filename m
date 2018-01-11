Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHMCD2tw6zDqqR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:13:12 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id u19so1314459pfa.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:13:12 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 22/26] KVM: PPC: Book3S PR: add emulation for trechkpt in PR
 KVM.
Date: Thu, 11 Jan 2018 18:11:35 +0800
Message-Id: <1515665499-31710-23-git-send-email-wei.guo.simon@gmail.com>
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

This patch adds host emulation when guest PR KVM executes "trechkpt.",
which is a privileged instruction and will trap into host.

We firstly copy vcpu ongoing content into vcpu tm checkpoint
content, then perform kvmppc_restore_tm_pr() to do trechkpt.
with updated vcpu tm checkpoint vals.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/book3s_emulate.c | 57 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 51c0e20..52a2e46 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -52,6 +52,7 @@
 #define OP_31_XOP_TBEGIN	654
 
 #define OP_31_XOP_TRECLAIM	942
+#define OP_31_XOP_TRCHKPT	1006
 
 /* DCBZ is actually 1014, but we patch it to 1010 so we get a trap */
 #define OP_31_XOP_DCBZ		1010
@@ -94,7 +95,7 @@ static bool spr_allowed(struct kvm_vcpu *vcpu, enum priv_level level)
 }
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-void kvmppc_copyto_vcpu_tm(struct kvm_vcpu *vcpu)
+static void kvmppc_copyto_vcpu_tm(struct kvm_vcpu *vcpu)
 {
 	memcpy(&vcpu->arch.gpr_tm[0], &vcpu->arch.gpr[0],
 			sizeof(vcpu->arch.gpr_tm));
@@ -166,6 +167,32 @@ static void kvmppc_emulate_treclaim(struct kvm_vcpu *vcpu, int ra_val)
 	tm_disable();
 	preempt_enable();
 }
+
+static void kvmppc_emulate_trchkpt(struct kvm_vcpu *vcpu)
+{
+	unsigned long guest_msr = kvmppc_get_msr(vcpu);
+
+	preempt_disable();
+	vcpu->arch.save_msr_tm = MSR_TS_S;
+	vcpu->arch.save_msr_tm &= ~(MSR_FP | MSR_VEC | MSR_VSX);
+	vcpu->arch.save_msr_tm |= (vcpu->arch.guest_owned_ext &
+			(MSR_FP | MSR_VEC | MSR_VSX));
+	/*
+	 * need flush FP/VEC/VSX to vcpu save area before
+	 * copy.
+	 */
+	kvmppc_giveup_ext(vcpu, MSR_VSX);
+	kvmppc_copyto_vcpu_tm(vcpu);
+	kvmppc_restore_tm_pr(vcpu);
+	preempt_enable();
+
+	/*
+	 * as a result of trecheckpoint. set TS to suspended.
+	 */
+	guest_msr &= ~(MSR_TS_MASK);
+	guest_msr |= MSR_TS_S;
+	kvmppc_set_msr(vcpu, guest_msr);
+}
 #endif
 
 int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
@@ -457,6 +484,34 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			kvmppc_emulate_treclaim(vcpu, ra_val);
 			break;
 		}
+		case OP_31_XOP_TRCHKPT:
+		{
+			ulong guest_msr = kvmppc_get_msr(vcpu);
+			unsigned long texasr;
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
-- 
1.8.3.1
