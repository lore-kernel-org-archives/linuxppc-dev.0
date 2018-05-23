Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPkp08mHzDrnr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:48:02 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id c11-v6so12518763plr.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:48:01 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v4 17/29] KVM: PPC: Book3S PR: make mtspr/mfspr emulation
 behavior based on active TM SPRs
Date: Wed, 23 May 2018 15:02:00 +0800
Message-Id: <1527058932-7434-18-git-send-email-wei.guo.simon@gmail.com>
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
 arch/powerpc/kvm/book3s_emulate.c     | 58 +++++++++++++++++++++++++++++------
 arch/powerpc/kvm/book3s_pr.c          |  2 +-
 3 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index fc15ad9..43e8bb1 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -210,6 +210,7 @@ extern long kvmppc_hv_get_dirty_log_radix(struct kvm *kvm,
 extern void kvmppc_book3s_dequeue_irqprio(struct kvm_vcpu *vcpu,
 					  unsigned int vec);
 extern void kvmppc_inject_interrupt(struct kvm_vcpu *vcpu, int vec, u64 flags);
+extern void kvmppc_trigger_fac_interrupt(struct kvm_vcpu *vcpu, ulong fac);
 extern void kvmppc_set_bat(struct kvm_vcpu *vcpu, struct kvmppc_bat *bat,
 			   bool upper, u32 val);
 extern void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr);
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index f81a921..c4e3ec6 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -24,6 +24,7 @@
 #include <asm/switch_to.h>
 #include <asm/time.h>
 #include "book3s.h"
+#include <asm/asm-prototypes.h>
 
 #define OP_19_XOP_RFID		18
 #define OP_19_XOP_RFI		50
@@ -523,13 +524,38 @@ int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
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
+		if (MSR_TM_ACTIVE(kvmppc_get_msr(vcpu)) &&
+			!((MSR_TM_SUSPENDED(kvmppc_get_msr(vcpu))) &&
+					(sprn == SPRN_TFHAR))) {
+			/* it is illegal to mtspr() TM regs in
+			 * other than non-transactional state, with
+			 * the exception of TFHAR in suspend state.
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
@@ -676,13 +702,25 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
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
index 4b81b3c..e8e7f3a 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -918,7 +918,7 @@ static void kvmppc_handle_lost_ext(struct kvm_vcpu *vcpu)
 
 #ifdef CONFIG_PPC_BOOK3S_64
 
-static void kvmppc_trigger_fac_interrupt(struct kvm_vcpu *vcpu, ulong fac)
+void kvmppc_trigger_fac_interrupt(struct kvm_vcpu *vcpu, ulong fac)
 {
 	/* Inject the Interrupt Cause field and trigger a guest interrupt */
 	vcpu->arch.fscr &= ~(0xffULL << 56);
-- 
1.8.3.1
