Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WJYB4psjzF24d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 21:55:26 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id o16so15005216pfk.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 04:55:26 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 09/11] KVM: PPC: reconstruct LOAD_FP/STORE_FP instruction mmio
 emulation with analyse_intr() input
Date: Wed, 25 Apr 2018 19:54:42 +0800
Message-Id: <1524657284-16706-10-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

This patch reconstructs LOAD_FP/STORE_FP instruction MMIO emulation with
analyse_intr() input. It utilizes the FPCONV/UPDATE properties exported by
analyse_instr() and invokes kvmppc_handle_load(s)/kvmppc_handle_store()
accordingly.

The FP regs need to be flushed so that the right FP reg vals can be read
from vcpu->arch.fpr.

Suggested-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/emulate_loadstore.c | 199 ++++++++---------------------------
 1 file changed, 42 insertions(+), 157 deletions(-)

diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index aaaf872..2dbdf9a 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -143,6 +143,23 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 
 			break;
 		}
+#ifdef CONFIG_PPC_FPU
+		case LOAD_FP:
+			if (kvmppc_check_fp_disabled(vcpu))
+				return EMULATE_DONE;
+
+			if (op.type & UPDATE) {
+				vcpu->arch.mmio_ra = op.update_reg;
+				vcpu->arch.mmio_update_ra = 1;
+			}
+
+			if (op.type & FPCONV)
+				vcpu->arch.mmio_sp64_extend = 1;
+
+			emulated = kvmppc_handle_load(run, vcpu,
+					KVM_MMIO_REG_FPR|op.reg, size, 1);
+			break;
+#endif
 		case STORE:
 			if (op.type & UPDATE) {
 				vcpu->arch.mmio_ra = op.update_reg;
@@ -155,6 +172,31 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 			emulated = kvmppc_handle_store(run, vcpu, op.val,
 					size, 1);
 			break;
+#ifdef CONFIG_PPC_FPU
+		case STORE_FP:
+			if (kvmppc_check_fp_disabled(vcpu))
+				return EMULATE_DONE;
+
+			/* if it is PR KVM, the FP/VEC/VSX registers need to
+			 * be flushed so that kvmppc_handle_store() can read
+			 * actual VMX vals from vcpu->arch.
+			 */
+			if (!is_kvmppc_hv_enabled(vcpu->kvm))
+				vcpu->kvm->arch.kvm_ops->giveup_ext(vcpu,
+						MSR_FP);
+
+			if (op.type & UPDATE) {
+				vcpu->arch.mmio_ra = op.update_reg;
+				vcpu->arch.mmio_update_ra = 1;
+			}
+
+			if (op.type & FPCONV)
+				vcpu->arch.mmio_sp64_extend = 1;
+
+			emulated = kvmppc_handle_store(run, vcpu,
+					VCPU_FPR(vcpu, op.reg), size, 1);
+			break;
+#endif
 		case CACHEOP:
 			/* Do nothing. The guest is performing dcbi because
 			 * hardware DMA is not snooped by the dcache, but
@@ -176,93 +218,6 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 	switch (get_op(inst)) {
 	case 31:
 		switch (get_xop(inst)) {
-#ifdef CONFIG_PPC_FPU
-		case OP_31_XOP_LFSX:
-			if (kvmppc_check_fp_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.mmio_sp64_extend = 1;
-			emulated = kvmppc_handle_load(run, vcpu,
-				KVM_MMIO_REG_FPR|rt, 4, 1);
-			break;
-
-		case OP_31_XOP_LFSUX:
-			if (kvmppc_check_fp_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.mmio_sp64_extend = 1;
-			emulated = kvmppc_handle_load(run, vcpu,
-				KVM_MMIO_REG_FPR|rt, 4, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
-
-		case OP_31_XOP_LFDX:
-			if (kvmppc_check_fp_disabled(vcpu))
-				return EMULATE_DONE;
-			emulated = kvmppc_handle_load(run, vcpu,
-				KVM_MMIO_REG_FPR|rt, 8, 1);
-			break;
-
-		case OP_31_XOP_LFDUX:
-			if (kvmppc_check_fp_disabled(vcpu))
-				return EMULATE_DONE;
-			emulated = kvmppc_handle_load(run, vcpu,
-				KVM_MMIO_REG_FPR|rt, 8, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
-
-		case OP_31_XOP_LFIWAX:
-			if (kvmppc_check_fp_disabled(vcpu))
-				return EMULATE_DONE;
-			emulated = kvmppc_handle_loads(run, vcpu,
-				KVM_MMIO_REG_FPR|rt, 4, 1);
-			break;
-
-		case OP_31_XOP_LFIWZX:
-			if (kvmppc_check_fp_disabled(vcpu))
-				return EMULATE_DONE;
-			emulated = kvmppc_handle_load(run, vcpu,
-				KVM_MMIO_REG_FPR|rt, 4, 1);
-			break;
-
-		case OP_31_XOP_STFSX:
-			if (kvmppc_check_fp_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.mmio_sp64_extend = 1;
-			emulated = kvmppc_handle_store(run, vcpu,
-				VCPU_FPR(vcpu, rs), 4, 1);
-			break;
-
-		case OP_31_XOP_STFSUX:
-			if (kvmppc_check_fp_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.mmio_sp64_extend = 1;
-			emulated = kvmppc_handle_store(run, vcpu,
-				VCPU_FPR(vcpu, rs), 4, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
-
-		case OP_31_XOP_STFDX:
-			if (kvmppc_check_fp_disabled(vcpu))
-				return EMULATE_DONE;
-			emulated = kvmppc_handle_store(run, vcpu,
-				VCPU_FPR(vcpu, rs), 8, 1);
-			break;
-
-		case OP_31_XOP_STFDUX:
-			if (kvmppc_check_fp_disabled(vcpu))
-				return EMULATE_DONE;
-			emulated = kvmppc_handle_store(run, vcpu,
-				VCPU_FPR(vcpu, rs), 8, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
-
-		case OP_31_XOP_STFIWX:
-			if (kvmppc_check_fp_disabled(vcpu))
-				return EMULATE_DONE;
-			emulated = kvmppc_handle_store(run, vcpu,
-				VCPU_FPR(vcpu, rs), 4, 1);
-			break;
-#endif
-
 #ifdef CONFIG_VSX
 		case OP_31_XOP_LXSDX:
 			if (kvmppc_check_vsx_disabled(vcpu))
@@ -427,76 +382,6 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 		}
 		break;
 
-#ifdef CONFIG_PPC_FPU
-	case OP_STFS:
-		if (kvmppc_check_fp_disabled(vcpu))
-			return EMULATE_DONE;
-		vcpu->arch.mmio_sp64_extend = 1;
-		emulated = kvmppc_handle_store(run, vcpu,
-			VCPU_FPR(vcpu, rs),
-			4, 1);
-		break;
-
-	case OP_STFSU:
-		if (kvmppc_check_fp_disabled(vcpu))
-			return EMULATE_DONE;
-		vcpu->arch.mmio_sp64_extend = 1;
-		emulated = kvmppc_handle_store(run, vcpu,
-			VCPU_FPR(vcpu, rs),
-			4, 1);
-		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-		break;
-
-	case OP_STFD:
-		if (kvmppc_check_fp_disabled(vcpu))
-			return EMULATE_DONE;
-		emulated = kvmppc_handle_store(run, vcpu,
-			VCPU_FPR(vcpu, rs),
-	                               8, 1);
-		break;
-
-	case OP_STFDU:
-		if (kvmppc_check_fp_disabled(vcpu))
-			return EMULATE_DONE;
-		emulated = kvmppc_handle_store(run, vcpu,
-			VCPU_FPR(vcpu, rs),
-	                               8, 1);
-		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-		break;
-
-	case OP_LFS:
-		if (kvmppc_check_fp_disabled(vcpu))
-			return EMULATE_DONE;
-		vcpu->arch.mmio_sp64_extend = 1;
-		emulated = kvmppc_handle_load(run, vcpu,
-			KVM_MMIO_REG_FPR|rt, 4, 1);
-		break;
-
-	case OP_LFSU:
-		if (kvmppc_check_fp_disabled(vcpu))
-			return EMULATE_DONE;
-		vcpu->arch.mmio_sp64_extend = 1;
-		emulated = kvmppc_handle_load(run, vcpu,
-			KVM_MMIO_REG_FPR|rt, 4, 1);
-		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-		break;
-
-	case OP_LFD:
-		if (kvmppc_check_fp_disabled(vcpu))
-			return EMULATE_DONE;
-		emulated = kvmppc_handle_load(run, vcpu,
-			KVM_MMIO_REG_FPR|rt, 8, 1);
-		break;
-
-	case OP_LFDU:
-		if (kvmppc_check_fp_disabled(vcpu))
-			return EMULATE_DONE;
-		emulated = kvmppc_handle_load(run, vcpu,
-			KVM_MMIO_REG_FPR|rt, 8, 1);
-		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-		break;
-#endif
-
 	default:
 		emulated = EMULATE_FAIL;
 		break;
-- 
1.8.3.1
