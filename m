Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrRMv54DfzF0pw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 05:01:31 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id r26so2573753pgv.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 10:01:31 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 20/30] KVM: PPC: Book3S PR: adds emulation for treclaim.
Date: Wed, 28 Feb 2018 01:52:28 +0800
Message-Id: <1519753958-11756-10-git-send-email-wei.guo.simon@gmail.com>
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

This patch adds support for "treclaim." emulation when PR KVM guest
executes treclaim. and traps to host.

We will firstly doing treclaim. and save TM checkpoint. Then it is
necessary to update vcpu current reg content with checkpointed vals.
When rfid into guest again, those vcpu current reg content(now the
checkpoint vals) will be loaded into regs.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/book3s_emulate.c | 77 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 90b5f59..faa46bc 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -25,6 +25,7 @@
 #include <asm/time.h>
 #include <asm/tm.h>
 #include "book3s.h"
+#include <asm/asm-prototypes.h>
 
 #define OP_19_XOP_RFID		18
 #define OP_19_XOP_RFI		50
@@ -50,6 +51,8 @@
 
 #define OP_31_XOP_TBEGIN	654
 
+#define OP_31_XOP_TRECLAIM	942
+
 /* DCBZ is actually 1014, but we patch it to 1010 so we get a trap */
 #define OP_31_XOP_DCBZ		1010
 
@@ -129,6 +132,46 @@ static inline void kvmppc_copyfrom_vcpu_tm(struct kvm_vcpu *vcpu)
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
@@ -404,6 +447,40 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
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
