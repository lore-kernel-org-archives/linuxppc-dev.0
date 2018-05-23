Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPkr3X4yzDrnr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:48:04 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id i5-v6so12512987plt.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:48:04 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v4 18/29] KVM: PPC: Book3S PR: always fail transaction in
 guest privilege state
Date: Wed, 23 May 2018 15:02:01 +0800
Message-Id: <1527058932-7434-19-git-send-email-wei.guo.simon@gmail.com>
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

Currently kernel doesn't use transaction memory.
And there is an issue for privilege guest that:
tbegin/tsuspend/tresume/tabort TM instructions can impact MSR TM bits
without trap into PR host. So following code will lead to a false mfmsr
result:
	tbegin	<- MSR bits update to Transaction active.
	beq 	<- failover handler branch
	mfmsr	<- still read MSR bits from magic page with
		transaction inactive.

It is not an issue for non-privilege guest since its mfmsr is not patched
with magic page and will always trap into PR host.

This patch will always fail tbegin attempt for privilege guest, so that
the above issue is prevented. It is benign since currently (guest) kernel
doesn't initiate a transaction.

Test case:
https://github.com/justdoitqd/publicFiles/blob/master/test_tbegin_pr.c

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s.h |  2 ++
 arch/powerpc/kvm/book3s_emulate.c     | 40 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_pr.c          | 11 +++++++++-
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 43e8bb1..c1cea82 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -262,9 +262,11 @@ extern void kvmppc_update_lpcr(struct kvm *kvm, unsigned long lpcr,
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu);
 void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu);
+void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu);
 #else
 static inline void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu) {}
 static inline void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu) {}
+static inline void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu) {}
 #endif
 
 extern int kvm_irq_bypass;
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index c4e3ec6..570339b 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -23,6 +23,7 @@
 #include <asm/reg.h>
 #include <asm/switch_to.h>
 #include <asm/time.h>
+#include <asm/tm.h>
 #include "book3s.h"
 #include <asm/asm-prototypes.h>
 
@@ -48,6 +49,8 @@
 #define OP_31_XOP_EIOIO		854
 #define OP_31_XOP_SLBMFEE	915
 
+#define OP_31_XOP_TBEGIN	654
+
 /* DCBZ is actually 1014, but we patch it to 1010 so we get a trap */
 #define OP_31_XOP_DCBZ		1010
 
@@ -363,6 +366,43 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 			break;
 		}
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+		case OP_31_XOP_TBEGIN:
+		{
+			if (!cpu_has_feature(CPU_FTR_TM))
+				break;
+
+			if (!(kvmppc_get_msr(vcpu) & MSR_TM)) {
+				kvmppc_trigger_fac_interrupt(vcpu, FSCR_TM_LG);
+				emulated = EMULATE_AGAIN;
+				break;
+			}
+
+			if (!(kvmppc_get_msr(vcpu) & MSR_PR)) {
+				preempt_disable();
+				vcpu->arch.cr = (CR0_TBEGIN_FAILURE |
+				  (vcpu->arch.cr & ~(CR0_MASK << CR0_SHIFT)));
+
+				vcpu->arch.texasr = (TEXASR_FS | TEXASR_EXACT |
+					(((u64)(TM_CAUSE_EMULATE | TM_CAUSE_PERSISTENT))
+						 << TEXASR_FC_LG));
+
+				if ((inst >> 21) & 0x1)
+					vcpu->arch.texasr |= TEXASR_ROT;
+
+				if (kvmppc_get_msr(vcpu) & MSR_HV)
+					vcpu->arch.texasr |= TEXASR_HV;
+
+				vcpu->arch.tfhar = kvmppc_get_pc(vcpu) + 4;
+				vcpu->arch.tfiar = kvmppc_get_pc(vcpu);
+
+				kvmppc_restore_tm_sprs(vcpu);
+				preempt_enable();
+			} else
+				emulated = EMULATE_FAIL;
+			break;
+		}
+#endif
 		default:
 			emulated = EMULATE_FAIL;
 		}
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index e8e7f3a..9becca1 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -207,6 +207,15 @@ static void kvmppc_recalc_shadow_msr(struct kvm_vcpu *vcpu)
 #ifdef CONFIG_PPC_BOOK3S_64
 	smsr |= MSR_ISF | MSR_HV;
 #endif
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	/*
+	 * in guest privileged state, we want to fail all TM transactions.
+	 * So disable MSR TM bit so that all tbegin. will be able to be
+	 * trapped into host.
+	 */
+	if (!(guest_msr & MSR_PR))
+		smsr &= ~MSR_TM;
+#endif
 	vcpu->arch.shadow_msr = smsr;
 }
 
@@ -299,7 +308,7 @@ static inline void kvmppc_save_tm_sprs(struct kvm_vcpu *vcpu)
 	tm_disable();
 }
 
-static inline void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu)
+void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu)
 {
 	tm_enable();
 	mtspr(SPRN_TFHAR, vcpu->arch.tfhar);
-- 
1.8.3.1
