Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrRMk34bWzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 05:01:22 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id w21so11836166plp.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 10:01:22 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 17/30] KVM: PPC: Book3S PR: make mtspr/mfspr emulation
 behavior based on active TM SPRs
Date: Wed, 28 Feb 2018 01:52:25 +0800
Message-Id: <1519753958-11756-7-git-send-email-wei.guo.simon@gmail.com>
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

The mfspr/mtspr on TM SPRs(TEXASR/TFIAR/TFHAR) are non-privileged
instructions and can be executed at PR KVM guest without trapping
into host in problem state. We only emulate mtspr/mfspr
texasr/tfiar/tfhar at guest PR=0 state.

When we are emulating mtspr tm sprs at guest PR=0 state, the emulation
result need to be visible to guest PR=1 state. That is, the actual TM
SPR val should be loaded into actual registers.

We already flush TM SPRs into vcpu when switching out of CPU, and load
TM SPRs when switching back.

This patch corrects mfspr()/mtspr() emulation for TM SPRs to make the
actual source/dest based on actual TM SPRs.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s.h |  1 +
 arch/powerpc/kvm/book3s_emulate.c     | 54 ++++++++++++++++++++++++++++-------
 arch/powerpc/kvm/book3s_pr.c          |  2 +-
 3 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 5911c3b..2ecb6a3 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -208,6 +208,7 @@ extern long kvmppc_hv_get_dirty_log_radix(struct kvm *kvm,
 extern void kvmppc_book3s_dequeue_irqprio(struct kvm_vcpu *vcpu,
 					  unsigned int vec);
 extern void kvmppc_inject_interrupt(struct kvm_vcpu *vcpu, int vec, u64 flags);
+extern void kvmppc_trigger_fac_interrupt(struct kvm_vcpu *vcpu, ulong fac);
 extern void kvmppc_set_bat(struct kvm_vcpu *vcpu, struct kvmppc_bat *bat,
 			   bool upper, u32 val);
 extern void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr);
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 63af17f..a03533d 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -523,13 +523,35 @@ int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 		break;
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	case SPRN_TFHAR:
-		vcpu->arch.tfhar = spr_val;
-		break;
 	case SPRN_TEXASR:
-		vcpu->arch.texasr = spr_val;
-		break;
 	case SPRN_TFIAR:
-		vcpu->arch.tfiar = spr_val;
+		if (!cpu_has_feature(CPU_FTR_TM))
+			break;
+
+		if (!(kvmppc_get_msr(vcpu) & MSR_TM)) {
+			kvmppc_trigger_fac_interrupt(vcpu, FSCR_TM_LG);
+			emulated = EMULATE_AGAIN;
+			break;
+		}
+
+		if (MSR_TM_ACTIVE(kvmppc_get_msr(vcpu))) {
+			/* it is illegal to mtspr() TM regs in
+			 * other than non-transactional state.
+			 */
+			kvmppc_core_queue_program(vcpu, SRR1_PROGTM);
+			emulated = EMULATE_AGAIN;
+			break;
+		}
+
+		tm_enable();
+		if (sprn == SPRN_TFHAR)
+			mtspr(SPRN_TFHAR, spr_val);
+		else if (sprn == SPRN_TEXASR)
+			mtspr(SPRN_TEXASR, spr_val);
+		else
+			mtspr(SPRN_TFIAR, spr_val);
+		tm_disable();
+
 		break;
 #endif
 #endif
@@ -676,13 +698,25 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
 		break;
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	case SPRN_TFHAR:
-		*spr_val = vcpu->arch.tfhar;
-		break;
 	case SPRN_TEXASR:
-		*spr_val = vcpu->arch.texasr;
-		break;
 	case SPRN_TFIAR:
-		*spr_val = vcpu->arch.tfiar;
+		if (!cpu_has_feature(CPU_FTR_TM))
+			break;
+
+		if (!(kvmppc_get_msr(vcpu) & MSR_TM)) {
+			kvmppc_trigger_fac_interrupt(vcpu, FSCR_TM_LG);
+			emulated = EMULATE_AGAIN;
+			break;
+		}
+
+		tm_enable();
+		if (sprn == SPRN_TFHAR)
+			*spr_val = mfspr(SPRN_TFHAR);
+		else if (sprn == SPRN_TEXASR)
+			*spr_val = mfspr(SPRN_TEXASR);
+		else if (sprn == SPRN_TFIAR)
+			*spr_val = mfspr(SPRN_TFIAR);
+		tm_disable();
 		break;
 #endif
 #endif
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 2fcc059..473c819 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -927,7 +927,7 @@ static void kvmppc_handle_lost_ext(struct kvm_vcpu *vcpu)
 
 #ifdef CONFIG_PPC_BOOK3S_64
 
-static void kvmppc_trigger_fac_interrupt(struct kvm_vcpu *vcpu, ulong fac)
+void kvmppc_trigger_fac_interrupt(struct kvm_vcpu *vcpu, ulong fac)
 {
 	/* Inject the Interrupt Cause field and trigger a guest interrupt */
 	vcpu->arch.fscr &= ~(0xffULL << 56);
-- 
1.8.3.1
