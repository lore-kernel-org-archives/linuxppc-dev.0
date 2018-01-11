Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHMC73Bd4zDqHQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:13:07 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id f14so1845842pga.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:13:07 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 21/26] KVM: PPC: Book3S PR: adds emulation for treclaim.
Date: Thu, 11 Jan 2018 18:11:34 +0800
Message-Id: <1515665499-31710-22-git-send-email-wei.guo.simon@gmail.com>
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

This patch adds support for "treclaim." emulation when PR KVM guest
executes treclaim. and traps to host.

We will firstly doing treclaim. and save TM checkpoint and doing
treclaim. Then it is necessary to update vcpu current reg content
with checkpointed vals. When rfid into guest again, those vcpu
current reg content(now the checkpoint vals) will be loaded into
regs.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/reg.h    |  4 +++
 arch/powerpc/kvm/book3s_emulate.c | 66 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 6c293bc..b3bcf6b 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -244,12 +244,16 @@
 #define SPRN_TEXASR	0x82	/* Transaction EXception & Summary */
 #define SPRN_TEXASRU	0x83	/* ''	   ''	   ''	 Upper 32  */
 #define TEXASR_FC_LG	(63 - 7)	/* Failure Code */
+#define TEXASR_AB_LG	(63 - 31)	/* Abort */
+#define TEXASR_SU_LG	(63 - 32)	/* Suspend */
 #define TEXASR_HV_LG	(63 - 34)	/* Hypervisor state*/
 #define TEXASR_PR_LG	(63 - 35)	/* Privilege level */
 #define TEXASR_FS_LG	(63 - 36)	/* failure summary */
 #define TEXASR_EX_LG	(63 - 37)	/* TFIAR exact bit */
 #define TEXASR_ROT_LG	(63 - 38)	/* ROT bit */
 #define TEXASR_FC	(ASM_CONST(0xFF) << TEXASR_FC_LG)
+#define TEXASR_AB	__MASK(TEXASR_AB_LG)
+#define TEXASR_SU	__MASK(TEXASR_SU_LG)
 #define TEXASR_HV	__MASK(TEXASR_HV_LG)
 #define TEXASR_PR	__MASK(TEXASR_PR_LG)
 #define TEXASR_FS	__MASK(TEXASR_FS_LG)
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 1eb1900..51c0e20 100644
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
 
@@ -109,7 +112,7 @@ void kvmppc_copyto_vcpu_tm(struct kvm_vcpu *vcpu)
 	vcpu->arch.vrsave_tm = vcpu->arch.vrsave;
 }
 
-void kvmppc_copyfrom_vcpu_tm(struct kvm_vcpu *vcpu)
+static void kvmppc_copyfrom_vcpu_tm(struct kvm_vcpu *vcpu)
 {
 	memcpy(&vcpu->arch.gpr[0], &vcpu->arch.gpr_tm[0],
 			sizeof(vcpu->arch.gpr));
@@ -127,6 +130,42 @@ void kvmppc_copyfrom_vcpu_tm(struct kvm_vcpu *vcpu)
 	vcpu->arch.vrsave = vcpu->arch.vrsave_tm;
 }
 
+static void kvmppc_emulate_treclaim(struct kvm_vcpu *vcpu, int ra_val)
+{
+	unsigned long guest_msr = kvmppc_get_msr(vcpu);
+	int fc_val = ra_val ? ra_val : 1;
+
+	kvmppc_save_tm_pr(vcpu);
+
+	preempt_disable();
+	kvmppc_copyfrom_vcpu_tm(vcpu);
+	preempt_enable();
+
+	/*
+	 * treclaim need quit to non-transactional state.
+	 */
+	guest_msr &= ~(MSR_TS_MASK);
+	kvmppc_set_msr(vcpu, guest_msr);
+
+	preempt_disable();
+	tm_enable();
+	vcpu->arch.texasr = mfspr(SPRN_TEXASR);
+	vcpu->arch.texasr &= ~TEXASR_FC;
+	vcpu->arch.texasr |= ((u64)fc_val << TEXASR_FC_LG);
+
+	vcpu->arch.texasr &= ~(TEXASR_PR | TEXASR_HV);
+	if (kvmppc_get_msr(vcpu) & MSR_PR)
+		vcpu->arch.texasr |= TEXASR_PR;
+
+	if (kvmppc_get_msr(vcpu) & MSR_HV)
+		vcpu->arch.texasr |= TEXASR_HV;
+
+	vcpu->arch.tfiar = kvmppc_get_pc(vcpu);
+	mtspr(SPRN_TEXASR, vcpu->arch.texasr);
+	mtspr(SPRN_TFIAR, vcpu->arch.tfiar);
+	tm_disable();
+	preempt_enable();
+}
 #endif
 
 int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
@@ -393,6 +432,31 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				emulated = EMULATE_FAIL;
 			break;
 		}
+		case OP_31_XOP_TRECLAIM:
+		{
+			ulong guest_msr = kvmppc_get_msr(vcpu);
+			unsigned long ra_val = 0;
+
+			/* generate interrupt based on priorities */
+			if (guest_msr & MSR_PR) {
+				/* Privileged Instruction type Program Interrupt */
+				kvmppc_core_queue_program(vcpu, SRR1_PROGPRIV);
+				emulated = EMULATE_AGAIN;
+				break;
+			}
+
+			if (!MSR_TM_SUSPENDED(guest_msr)) {
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
