Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHMC03kmTzF0Y1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:13:00 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id d23so1312021pfe.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:13:00 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 19/26] KVM: PPC: Book3S PR: always fail transaction in guest
 privilege state
Date: Thu, 11 Jan 2018 18:11:32 +0800
Message-Id: <1515665499-31710-20-git-send-email-wei.guo.simon@gmail.com>
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
 arch/powerpc/include/asm/kvm_book3s.h |  1 +
 arch/powerpc/kvm/book3s_emulate.c     | 34 ++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_pr.c          | 11 ++++++++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index d8dbfa5..524cd82 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -257,6 +257,7 @@ extern void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu);
 void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu);
+void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu);
 #endif
 
 extern int kvm_irq_bypass;
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index c2836330..1eb1900 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -23,6 +23,7 @@
 #include <asm/reg.h>
 #include <asm/switch_to.h>
 #include <asm/time.h>
+#include <asm/tm.h>
 #include "book3s.h"
 
 #define OP_19_XOP_RFID		18
@@ -47,6 +48,8 @@
 #define OP_31_XOP_EIOIO		854
 #define OP_31_XOP_SLBMFEE	915
 
+#define OP_31_XOP_TBEGIN	654
+
 /* DCBZ is actually 1014, but we patch it to 1010 so we get a trap */
 #define OP_31_XOP_DCBZ		1010
 
@@ -360,6 +363,37 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 			break;
 		}
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+		case OP_31_XOP_TBEGIN:
+		{
+			if (!(kvmppc_get_msr(vcpu) & MSR_PR)) {
+				preempt_disable();
+				vcpu->arch.cr = (CR0_TBEGIN_FAILURE |
+				  (vcpu->arch.cr & ~(CR0_MASK << CR0_SHIFT)));
+
+				vcpu->arch.texasr = (TEXASR_FS | TEXASR_EX |
+					(((u64)(TM_CAUSE_EMULATE | TM_CAUSE_PERSISTENT))
+						 << TEXASR_FC_LG));
+
+				if ((inst >> 21) & 0x1)
+					vcpu->arch.texasr |= TEXASR_ROT;
+
+				if (kvmppc_get_msr(vcpu) & MSR_PR)
+					vcpu->arch.texasr |= TEXASR_PR;
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
index c35bd02..a26f4db 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -255,7 +255,7 @@ static inline void kvmppc_save_tm_sprs(struct kvm_vcpu *vcpu)
 	tm_disable();
 }
 
-static inline void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu)
+inline void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu)
 {
 	tm_enable();
 	mtspr(SPRN_TFHAR, vcpu->arch.tfhar);
@@ -447,6 +447,15 @@ static void kvmppc_recalc_shadow_msr(struct kvm_vcpu *vcpu)
 	    (PVR_VER(guest_pvr) == PVR_970GX))
 		smsr |= MSR_HV;
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
 
-- 
1.8.3.1
