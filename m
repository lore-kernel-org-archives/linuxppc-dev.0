Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrRMy3ckczF1XH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 05:01:34 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id y8-v6so1374286pll.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 10:01:34 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 22/30] KVM: PPC: Book3S PR: add emulation for tabort. for
 privilege guest
Date: Wed, 28 Feb 2018 01:52:30 +0800
Message-Id: <1519753958-11756-12-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1519753958-11756-1-git-send-email-wei.guo.simon@gmail.com>
References: <1519753958-11756-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

Currently privilege guest will be run with TM disabled.

Although the privilege guest cannot initiate a new transaction,
it can use tabort to terminate its problem state's transaction.
So it is still necessary to emulate tabort. for privilege guest.

This patch adds emulation for tabort. of privilege guest.

Tested with:
https://github.com/justdoitqd/publicFiles/blob/master/test_tabort.c

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/book3s_emulate.c | 68 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index ec88fbf..5656cdf 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -50,6 +50,7 @@
 #define OP_31_XOP_SLBMFEE	915
 
 #define OP_31_XOP_TBEGIN	654
+#define OP_31_XOP_TABORT	910
 
 #define OP_31_XOP_TRECLAIM	942
 #define OP_31_XOP_TRCHKPT	1006
@@ -196,6 +197,47 @@ static void kvmppc_emulate_trchkpt(struct kvm_vcpu *vcpu)
 	kvmppc_restore_tm_pr(vcpu);
 	preempt_enable();
 }
+
+/* emulate tabort. at guest privilege state */
+static void kvmppc_emulate_tabort(struct kvm_vcpu *vcpu, int ra_val)
+{
+	/* currently we only emulate tabort. but no emulation of other
+	 * tabort variants since there is no kernel usage of them at
+	 * present.
+	 */
+	unsigned long guest_msr = kvmppc_get_msr(vcpu);
+
+	preempt_disable();
+	tm_enable();
+	tm_abort(ra_val);
+
+	/* CR0 = 0 | MSR[TS] | 0 */
+	vcpu->arch.cr = (vcpu->arch.cr & ~(CR0_MASK << CR0_SHIFT)) |
+		(((guest_msr & MSR_TS_MASK) >> (MSR_TS_S_LG - 1))
+		 << CR0_SHIFT);
+
+	vcpu->arch.texasr = mfspr(SPRN_TEXASR);
+	/* failure recording depends on Failure Summary bit,
+	 * and tabort will be treated as nops in non-transactional
+	 * state.
+	 */
+	if (!(vcpu->arch.texasr & TEXASR_FS) &&
+			MSR_TM_ACTIVE(guest_msr)) {
+		vcpu->arch.texasr &= ~(TEXASR_PR | TEXASR_HV);
+		if (guest_msr & MSR_PR)
+			vcpu->arch.texasr |= TEXASR_PR;
+
+		if (guest_msr & MSR_HV)
+			vcpu->arch.texasr |= TEXASR_HV;
+
+		vcpu->arch.tfiar = kvmppc_get_pc(vcpu);
+		mtspr(SPRN_TEXASR, vcpu->arch.texasr);
+		mtspr(SPRN_TFIAR, vcpu->arch.tfiar);
+	}
+	tm_disable();
+	preempt_enable();
+}
+
 #endif
 
 int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
@@ -471,6 +513,32 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				emulated = EMULATE_FAIL;
 			break;
 		}
+		case OP_31_XOP_TABORT:
+		{
+			ulong guest_msr = kvmppc_get_msr(vcpu);
+			unsigned long ra_val = 0;
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
+			/* only emulate for privilege guest, since problem state
+			 * guest can run with TM enabled and we don't expect to
+			 * trap at here for that case.
+			 */
+			WARN_ON(guest_msr & MSR_PR);
+
+			if (ra)
+				ra_val = kvmppc_get_gpr(vcpu, ra);
+
+			kvmppc_emulate_tabort(vcpu, ra_val);
+			break;
+		}
 		case OP_31_XOP_TRECLAIM:
 		{
 			ulong guest_msr = kvmppc_get_msr(vcpu);
-- 
1.8.3.1
