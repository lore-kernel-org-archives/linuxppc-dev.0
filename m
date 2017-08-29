Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhjhh49p6zDqGV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 08:18:44 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7TMF4CO145468
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 18:18:42 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cna03m8rq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 18:18:39 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Tue, 29 Aug 2017 18:18:38 -0400
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, agraf@suse.com, mpe@ellerman.id.au
Subject: [PATCH RFC] KVM: PPC: Book3S: Add MMIO emulation for VMX instructions
Date: Tue, 29 Aug 2017 19:18:02 -0300
In-Reply-To: <1504045082-16178-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1504045082-16178-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1504045082-16178-2-git-send-email-joserz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch provides the MMIO load/store vector indexed
X-Form emulation.

Instructions implemented: lvx, stvx

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h   |   2 +
 arch/powerpc/include/asm/kvm_ppc.h    |   4 +
 arch/powerpc/include/asm/ppc-opcode.h |   6 ++
 arch/powerpc/kvm/emulate_loadstore.c  |  32 +++++++
 arch/powerpc/kvm/powerpc.c            | 162 ++++++++++++++++++++++++++++++----
 5 files changed, 189 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 8b3f123..5835163 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -697,6 +697,7 @@ struct kvm_vcpu_arch {
 	u8 mmio_vsx_offset;
 	u8 mmio_vsx_copy_type;
 	u8 mmio_vsx_tx_sx_enabled;
+	u8 mmio_vmx_copy_nums;
 	u8 osi_needed;
 	u8 osi_enabled;
 	u8 papr_enabled;
@@ -807,6 +808,7 @@ struct kvm_vcpu_arch {
 #define KVM_MMIO_REG_QPR	0x0040
 #define KVM_MMIO_REG_FQPR	0x0060
 #define KVM_MMIO_REG_VSX	0x0080
+#define KVM_MMIO_REG_VMX	0x00a0
 
 #define __KVM_HAVE_ARCH_WQP
 #define __KVM_HAVE_CREATE_DEVICE
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index ba5fadd..c444d16 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -81,6 +81,10 @@ extern int kvmppc_handle_loads(struct kvm_run *run, struct kvm_vcpu *vcpu,
 extern int kvmppc_handle_vsx_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				unsigned int rt, unsigned int bytes,
 			int is_default_endian, int mmio_sign_extend);
+extern int kvmppc_handle_load128_by2x64(struct kvm_run *run,
+		struct kvm_vcpu *vcpu, unsigned int rt, int is_default_endian);
+extern int kvmppc_handle_store128_by2x64(struct kvm_run *run,
+		struct kvm_vcpu *vcpu, unsigned int rs, int is_default_endian);
 extern int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			       u64 val, unsigned int bytes,
 			       int is_default_endian);
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index fa9ebae..ea9bf37 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -156,6 +156,12 @@
 #define OP_31_XOP_LFDX          599
 #define OP_31_XOP_LFDUX		631
 
+/* VMX Vector Load Instructions */
+#define OP_31_XOP_LVX           103
+
+/* VMX Vector Store Instructions */
+#define OP_31_XOP_STVX          231
+
 #define OP_LWZ  32
 #define OP_STFS 52
 #define OP_STFSU 53
diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index af83353..40fbc14 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -58,6 +58,18 @@ static bool kvmppc_check_vsx_disabled(struct kvm_vcpu *vcpu)
 }
 #endif /* CONFIG_VSX */
 
+#ifdef CONFIG_ALTIVEC
+static bool kvmppc_check_altivec_disabled(struct kvm_vcpu *vcpu)
+{
+	if (!(kvmppc_get_msr(vcpu) & MSR_VEC)) {
+		kvmppc_core_queue_vec_unavail(vcpu);
+		return true;
+	}
+
+	return false;
+}
+#endif /* CONFIG_ALTIVEC */
+
 /*
  * XXX to do:
  * lfiwax, lfiwzx
@@ -98,6 +110,7 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_NONE;
 	vcpu->arch.mmio_sp64_extend = 0;
 	vcpu->arch.mmio_sign_extend = 0;
+	vcpu->arch.mmio_vmx_copy_nums = 0;
 
 	switch (get_op(inst)) {
 	case 31:
@@ -459,6 +472,25 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 							 rs, 4, 1);
 			break;
 #endif /* CONFIG_VSX */
+
+#ifdef CONFIG_ALTIVEC
+		case OP_31_XOP_LVX:
+			if (kvmppc_check_altivec_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_vmx_copy_nums = 2;
+			emulated = kvmppc_handle_load128_by2x64(run, vcpu,
+					KVM_MMIO_REG_VMX|rt, 1);
+			break;
+
+		case OP_31_XOP_STVX:
+			if (kvmppc_check_altivec_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_vmx_copy_nums = 2;
+			emulated = kvmppc_handle_store128_by2x64(run, vcpu,
+					rs, 1);
+			break;
+#endif /* CONFIG_ALTIVEC */
+
 		default:
 			emulated = EMULATE_FAIL;
 			break;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 1a75c0b..dc3611b 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -828,23 +828,7 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 		kvm->arch.kvm_ops->irq_bypass_del_producer(cons, prod);
 }
 
-#ifdef CONFIG_VSX
-static inline int kvmppc_get_vsr_dword_offset(int index)
-{
-	int offset;
-
-	if ((index != 0) && (index != 1))
-		return -1;
-
-#ifdef __BIG_ENDIAN
-	offset =  index;
-#else
-	offset = 1 - index;
-#endif
-
-	return offset;
-}
-
+#ifdef CONFIG_ALTIVEC
 static inline int kvmppc_get_vsr_word_offset(int index)
 {
 	int offset;
@@ -860,6 +844,40 @@ static inline int kvmppc_get_vsr_word_offset(int index)
 	return offset;
 }
 
+static inline void kvmppc_set_vmx_dword(struct kvm_vcpu *vcpu,
+		u64 gpr)
+{
+	int index = vcpu->arch.io_gpr & KVM_MMIO_REG_MASK;
+	u64 hi = gpr >> 32;
+	u64 lo = gpr & 0xffffffff;
+
+	if (vcpu->arch.mmio_vmx_copy_nums == 1) {
+		VCPU_VSX_VR(vcpu, index).u[kvmppc_get_vsr_word_offset(2)] = hi;
+		VCPU_VSX_VR(vcpu, index).u[kvmppc_get_vsr_word_offset(3)] = lo;
+	} else if (vcpu->arch.mmio_vmx_copy_nums == 2) {
+		VCPU_VSX_VR(vcpu, index).u[kvmppc_get_vsr_word_offset(0)] = hi;
+		VCPU_VSX_VR(vcpu, index).u[kvmppc_get_vsr_word_offset(1)] = lo;
+	}
+}
+#endif /* CONFIG_ALTIVEC */
+
+#ifdef CONFIG_VSX
+static inline int kvmppc_get_vsr_dword_offset(int index)
+{
+	int offset;
+
+	if ((index != 0) && (index != 1))
+		return -1;
+
+#ifdef __BIG_ENDIAN
+	offset =  index;
+#else
+	offset = 1 - index;
+#endif
+
+	return offset;
+}
+
 static inline void kvmppc_set_vsr_dword(struct kvm_vcpu *vcpu,
 	u64 gpr)
 {
@@ -1024,6 +1042,11 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
 			kvmppc_set_vsr_dword_dump(vcpu, gpr);
 		break;
 #endif
+#ifdef CONFIG_ALTIVEC
+	case KVM_MMIO_REG_VMX:
+		kvmppc_set_vmx_dword(vcpu, gpr);
+		break;
+#endif
 	default:
 		BUG();
 	}
@@ -1303,6 +1326,99 @@ static int kvmppc_emulate_mmio_vsx_loadstore(struct kvm_vcpu *vcpu,
 }
 #endif /* CONFIG_VSX */
 
+#ifdef CONFIG_ALTIVEC
+/* handle quadword load access in two halves */
+int kvmppc_handle_load128_by2x64(struct kvm_run *run, struct kvm_vcpu *vcpu,
+		unsigned int rt, int is_default_endian)
+{
+	enum emulation_result emulated = EMULATE_DONE;
+
+	while (vcpu->arch.mmio_vmx_copy_nums) {
+		emulated = __kvmppc_handle_load(run, vcpu, rt, 8,
+				is_default_endian, 0);
+		if (emulated != EMULATE_DONE)
+			break;
+
+		vcpu->arch.mmio_vmx_copy_nums--;
+	}
+	return emulated;
+}
+
+static inline int kvmppc_get_vmx_data(struct kvm_vcpu *vcpu, int rs, u64 *val)
+{
+
+	if (vcpu->arch.mmio_vmx_copy_nums == 1) {
+		*val = VCPU_VSX_VR(vcpu, rs).u[kvmppc_get_vsr_word_offset(2)];
+		*val = (*val << 32) | VCPU_VSX_VR(vcpu, rs).
+			u[kvmppc_get_vsr_word_offset(3)];
+		return 0;
+	} else if (vcpu->arch.mmio_vmx_copy_nums == 2) {
+		*val = VCPU_VSX_VR(vcpu, rs).u[kvmppc_get_vsr_word_offset(0)];
+		*val = (*val << 32) | VCPU_VSX_VR(vcpu, rs).
+			u[kvmppc_get_vsr_word_offset(1)];
+		return 0;
+	}
+	return -1;
+}
+
+/* handle quadword store in two halves */
+int kvmppc_handle_store128_by2x64(struct kvm_run *run, struct kvm_vcpu *vcpu,
+		unsigned int rs, int is_default_endian)
+{
+	u64 val = 0;
+	enum emulation_result emulated = EMULATE_DONE;
+
+	vcpu->arch.io_gpr = rs;
+
+	while (vcpu->arch.mmio_vmx_copy_nums) {
+		if (kvmppc_get_vmx_data(vcpu, rs, &val) == -1)
+			return EMULATE_FAIL;
+
+		emulated = kvmppc_handle_store(run, vcpu, val, 8,
+				is_default_endian);
+		if (emulated != EMULATE_DONE)
+			break;
+
+		vcpu->arch.mmio_vmx_copy_nums--;
+	}
+	return emulated;
+}
+
+static int kvmppc_emulate_mmio_vmx_loadstore(struct kvm_vcpu *vcpu,
+		struct kvm_run *run)
+{
+	enum emulation_result emulated = EMULATE_FAIL;
+	int r;
+
+	vcpu->arch.paddr_accessed += run->mmio.len;
+
+	if (!vcpu->mmio_is_write) {
+		emulated = kvmppc_handle_load128_by2x64(run, vcpu,
+				vcpu->arch.io_gpr, 1);
+	} else {
+		emulated = kvmppc_handle_store128_by2x64(run, vcpu,
+				vcpu->arch.io_gpr, 1);
+	}
+
+	switch (emulated) {
+	case EMULATE_DO_MMIO:
+		run->exit_reason = KVM_EXIT_MMIO;
+		r = RESUME_HOST;
+		break;
+	case EMULATE_FAIL:
+		pr_info("KVM: MMIO emulation failed (VMX repeat)\n");
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
+		r = RESUME_HOST;
+		break;
+	default:
+		r = RESUME_GUEST;
+		break;
+	}
+	return r;
+}
+#endif /* CONFIG_ALTIVEC */
+
 int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 {
 	int r = 0;
@@ -1423,6 +1539,18 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			}
 		}
 #endif
+#ifdef CONFIG_ALTIVEC
+		if (vcpu->arch.mmio_vmx_copy_nums > 0)
+			vcpu->arch.mmio_vmx_copy_nums--;
+
+		if (vcpu->arch.mmio_vmx_copy_nums > 0) {
+			r = kvmppc_emulate_mmio_vmx_loadstore(vcpu, run);
+			if (r == RESUME_HOST) {
+				vcpu->mmio_needed = 1;
+				return r;
+			}
+		}
+#endif
 	} else if (vcpu->arch.osi_needed) {
 		u64 *gprs = run->osi.gprs;
 		int i;
-- 
2.7.4
