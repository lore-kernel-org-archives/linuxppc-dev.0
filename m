Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WJYF0jzwzF24l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 21:55:29 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id a13so8715933pgu.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 04:55:28 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 10/11] KVM: PPC: reconstruct LOAD_VMX/STORE_VMX instruction
 mmio emulation with analyse_intr() input
Date: Wed, 25 Apr 2018 19:54:43 +0800
Message-Id: <1524657284-16706-11-git-send-email-wei.guo.simon@gmail.com>
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

This patch reconstructs LOAD_VMX/STORE_VMX instruction MMIO emulation with
analyse_intr() input. When emulating the store, the VMX reg will need to
be flushed so that the right reg val can be retrieved before writing to
IO MEM.

Suggested-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/kvm_ppc.h   |  1 +
 arch/powerpc/kvm/emulate_loadstore.c | 73 +++++++++++++++++++++++++-----------
 arch/powerpc/kvm/powerpc.c           |  2 +-
 3 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index b265538..eeb00de 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -83,6 +83,7 @@ extern int kvmppc_handle_vsx_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			int is_default_endian, int mmio_sign_extend);
 extern int kvmppc_handle_load128_by2x64(struct kvm_run *run,
 		struct kvm_vcpu *vcpu, unsigned int rt, int is_default_endian);
+extern int kvmppc_get_vmx_data(struct kvm_vcpu *vcpu, int rs, u64 *val);
 extern int kvmppc_handle_store128_by2x64(struct kvm_run *run,
 		struct kvm_vcpu *vcpu, unsigned int rs, int is_default_endian);
 extern int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index 2dbdf9a..0bfee2f 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -160,6 +160,27 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 					KVM_MMIO_REG_FPR|op.reg, size, 1);
 			break;
 #endif
+#ifdef CONFIG_ALTIVEC
+		case LOAD_VMX:
+			if (kvmppc_check_altivec_disabled(vcpu))
+				return EMULATE_DONE;
+
+			/* VMX access will need to be size aligned */
+			vcpu->arch.vaddr_accessed &= ~((unsigned long)size - 1);
+			vcpu->arch.paddr_accessed &= ~((unsigned long)size - 1);
+
+			if (size == 16) {
+				vcpu->arch.mmio_vmx_copy_nums = 2;
+				emulated = kvmppc_handle_load128_by2x64(run,
+						vcpu, KVM_MMIO_REG_VMX|op.reg,
+						1);
+			} else if (size <= 8)
+				emulated = kvmppc_handle_load(run, vcpu,
+						KVM_MMIO_REG_VMX|op.reg,
+						size, 1);
+
+			break;
+#endif
 		case STORE:
 			if (op.type & UPDATE) {
 				vcpu->arch.mmio_ra = op.update_reg;
@@ -197,6 +218,36 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 					VCPU_FPR(vcpu, op.reg), size, 1);
 			break;
 #endif
+#ifdef CONFIG_ALTIVEC
+		case STORE_VMX:
+			if (kvmppc_check_altivec_disabled(vcpu))
+				return EMULATE_DONE;
+
+			/* VMX access will need to be size aligned */
+			vcpu->arch.vaddr_accessed &= ~((unsigned long)size - 1);
+			vcpu->arch.paddr_accessed &= ~((unsigned long)size - 1);
+
+			/* if it is PR KVM, the FP/VEC/VSX registers need to
+			 * be flushed so that kvmppc_handle_store() can read
+			 * actual VMX vals from vcpu->arch.
+			 */
+			if (!is_kvmppc_hv_enabled(vcpu->kvm))
+				vcpu->kvm->arch.kvm_ops->giveup_ext(vcpu,
+						MSR_VEC);
+
+			if (size == 16) {
+				vcpu->arch.mmio_vmx_copy_nums = 2;
+				emulated = kvmppc_handle_store128_by2x64(run,
+						vcpu, op.reg, 1);
+			} else if (size <= 8) {
+				u64 val;
+
+				kvmppc_get_vmx_data(vcpu, op.reg, &val);
+				emulated = kvmppc_handle_store(run, vcpu,
+						val, size, 1);
+			}
+			break;
+#endif
 		case CACHEOP:
 			/* Do nothing. The guest is performing dcbi because
 			 * hardware DMA is not snooped by the dcache, but
@@ -354,28 +405,6 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 			break;
 #endif /* CONFIG_VSX */
 
-#ifdef CONFIG_ALTIVEC
-		case OP_31_XOP_LVX:
-			if (kvmppc_check_altivec_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.vaddr_accessed &= ~0xFULL;
-			vcpu->arch.paddr_accessed &= ~0xFULL;
-			vcpu->arch.mmio_vmx_copy_nums = 2;
-			emulated = kvmppc_handle_load128_by2x64(run, vcpu,
-					KVM_MMIO_REG_VMX|rt, 1);
-			break;
-
-		case OP_31_XOP_STVX:
-			if (kvmppc_check_altivec_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.vaddr_accessed &= ~0xFULL;
-			vcpu->arch.paddr_accessed &= ~0xFULL;
-			vcpu->arch.mmio_vmx_copy_nums = 2;
-			emulated = kvmppc_handle_store128_by2x64(run, vcpu,
-					rs, 1);
-			break;
-#endif /* CONFIG_ALTIVEC */
-
 		default:
 			emulated = EMULATE_FAIL;
 			break;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index e724601..000182e 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1408,7 +1408,7 @@ int kvmppc_handle_load128_by2x64(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return emulated;
 }
 
-static inline int kvmppc_get_vmx_data(struct kvm_vcpu *vcpu, int rs, u64 *val)
+int kvmppc_get_vmx_data(struct kvm_vcpu *vcpu, int rs, u64 *val)
 {
 	vector128 vrs = VCPU_VSX_VR(vcpu, rs);
 	u32 di;
-- 
1.8.3.1
