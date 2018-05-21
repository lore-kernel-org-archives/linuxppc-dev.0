Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q5p15ydKzF0dY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 14:46:17 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id k2-v6so5826036pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 21:46:17 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v3 20/29] KVM: PPC: Book3S PR: adds emulation for treclaim.
Date: Mon, 21 May 2018 12:09:37 +0800
Message-Id: <1526875786-10372-21-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1526875786-10372-1-git-send-email-wei.guo.simon@gmail.com>
References: <1526875786-10372-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

This patch adds support for "treclaim." emulation when PR KVM guest
executes treclaim. and traps to host.

We will firstly doing treclaim. and save TM checkpoint. Then it is
necessary to update vcpu current reg content with checkpointed vals.
When rfid into guest again, those vcpu current reg content(now the
checkpoint vals) will be loaded into regs.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/book3s_emulate.c | 76 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 570339b..04c29e0 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -51,6 +51,8 @@
 
 #define OP_31_XOP_TBEGIN	654
 
+#define OP_31_XOP_TRECLAIM	942
+
 /* DCBZ is actually 1014, but we patch it to 1010 so we get a trap */
 #define OP_31_XOP_DCBZ		1010
 
@@ -130,6 +132,46 @@ static inline void kvmppc_copyfrom_vcpu_tm(struct kvm_vcpu *vcpu)
 	vcpu->arch.vrsave = vcpu->arch.vrsave_tm;
 }
 
+static void kvmppc_emulate_treclaim(struct kvm_vcpu *vcpu, int ra_val)
+{
+	unsigned long guest_msr = kvmppc_get_msr(vcpu);
+	int fc_val = ra_val ? ra_val : 1;
+
+	/* CR0 = 0 | MSR[TS] | 0 */
+	vcpu->arch.cr = (vcpu->arch.cr & ~(CR0_MASK << CR0_SHIFT)) |
+		(((guest_msr & MSR_TS_MASK) >> (MSR_TS_S_LG - 1))
+		 << CR0_SHIFT);
+
+	preempt_disable();
+	kvmppc_save_tm_pr(vcpu);
+	kvmppc_copyfrom_vcpu_tm(vcpu);
+
+	tm_enable();
+	vcpu->arch.texasr = mfspr(SPRN_TEXASR);
+	/* failure recording depends on Failure Summary bit */
+	if (!(vcpu->arch.texasr & TEXASR_FS)) {
+		vcpu->arch.texasr &= ~TEXASR_FC;
+		vcpu->arch.texasr |= ((u64)fc_val << TEXASR_FC_LG);
+
+		vcpu->arch.texasr &= ~(TEXASR_PR | TEXASR_HV);
+		if (kvmppc_get_msr(vcpu) & MSR_PR)
+			vcpu->arch.texasr |= TEXASR_PR;
+
+		if (kvmppc_get_msr(vcpu) & MSR_HV)
+			vcpu->arch.texasr |= TEXASR_HV;
+
+		vcpu->arch.tfiar = kvmppc_get_pc(vcpu);
+		mtspr(SPRN_TEXASR, vcpu->arch.texasr);
+		mtspr(SPRN_TFIAR, vcpu->arch.tfiar);
+	}
+	tm_disable();
+	/*
+	 * treclaim need quit to non-transactional state.
+	 */
+	guest_msr &= ~(MSR_TS_MASK);
+	kvmppc_set_msr(vcpu, guest_msr);
+	preempt_enable();
+}
 #endif
 
 int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
@@ -402,6 +444,40 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				emulated = EMULATE_FAIL;
 			break;
 		}
+		case OP_31_XOP_TRECLAIM:
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
+			/* generate interrupts based on priorities */
+			if (guest_msr & MSR_PR) {
+				/* Privileged Instruction type Program Interrupt */
+				kvmppc_core_queue_program(vcpu, SRR1_PROGPRIV);
+				emulated = EMULATE_AGAIN;
+				break;
+			}
+
+			if (!MSR_TM_ACTIVE(guest_msr)) {
+				/* TM bad thing interrupt */
+				kvmppc_core_queue_program(vcpu, SRR1_PROGTM);
+				emulated = EMULATE_AGAIN;
+				break;
+			}
+
+			if (ra)
+				ra_val = kvmppc_get_gpr(vcpu, ra);
+			kvmppc_emulate_treclaim(vcpu, ra_val);
+			break;
+		}
 #endif
 		default:
 			emulated = EMULATE_FAIL;
-- 
1.8.3.1
