Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fXYg1dDXzF14y
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 16:20:55 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id w129so16607021pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 May 2018 23:20:55 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 07/10] KVM: PPC: reimplement LOAD_FP/STORE_FP instruction
 mmio emulation with analyse_intr() input
Date: Mon,  7 May 2018 14:20:13 +0800
Message-Id: <1525674016-6703-8-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1525674016-6703-1-git-send-email-wei.guo.simon@gmail.com>
References: <1525674016-6703-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

This patch reimplements LOAD_FP/STORE_FP instruction MMIO emulation with
analyse_intr() input. It utilizes the FPCONV/UPDATE properties exported by
analyse_instr() and invokes kvmppc_handle_load(s)/kvmppc_handle_store()
accordingly.

For FP store MMIO emulation, the FP regs need to be flushed firstly so
that the right FP reg vals can be read from vcpu->arch.fpr, which will
be stored into MMIO data.

Suggested-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/emulate_loadstore.c | 197 +++++++----------------------------
 1 file changed, 40 insertions(+), 157 deletions(-)

diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index 2a91845..5a6571c 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -138,6 +138,22 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 
 			break;
 		}
+#ifdef CONFIG_PPC_FPU
+		case LOAD_FP:
+			if (kvmppc_check_fp_disabled(vcpu))
+				return EMULATE_DONE;
+
+			if (op.type & FPCONV)
+				vcpu->arch.mmio_sp64_extend = 1;
+
+			emulated = kvmppc_handle_load(run, vcpu,
+					KVM_MMIO_REG_FPR|op.reg, size, 1);
+
+			if ((op.type & UPDATE) && (emulated != EMULATE_FAIL))
+				kvmppc_set_gpr(vcpu, op.update_reg, op.ea);
+
+			break;
+#endif
 		case STORE:
 			/* if need byte reverse, op.val has been reversed by
 			 * analyse_instr().
@@ -149,6 +165,30 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 				kvmppc_set_gpr(vcpu, op.update_reg, op.ea);
 
 			break;
+#ifdef CONFIG_PPC_FPU
+		case STORE_FP:
+			if (kvmppc_check_fp_disabled(vcpu))
+				return EMULATE_DONE;
+
+			/* The FP registers need to be flushed so that
+			 * kvmppc_handle_store() can read actual FP vals
+			 * from vcpu->arch.
+			 */
+			if (vcpu->kvm->arch.kvm_ops->giveup_ext)
+				vcpu->kvm->arch.kvm_ops->giveup_ext(vcpu,
+						MSR_FP);
+
+			if (op.type & FPCONV)
+				vcpu->arch.mmio_sp64_extend = 1;
+
+			emulated = kvmppc_handle_store(run, vcpu,
+					VCPU_FPR(vcpu, op.reg), size, 1);
+
+			if ((op.type & UPDATE) && (emulated != EMULATE_FAIL))
+				kvmppc_set_gpr(vcpu, op.update_reg, op.ea);
+
+			break;
+#endif
 		case CACHEOP:
 			/* Do nothing. The guest is performing dcbi because
 			 * hardware DMA is not snooped by the dcache, but
@@ -170,93 +210,6 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
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
@@ -421,76 +374,6 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
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
