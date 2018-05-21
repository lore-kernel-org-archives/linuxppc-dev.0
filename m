Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q7Rd4147zDqG0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 16:00:29 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id n9-v6so5880886pgq.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 23:00:29 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v3 7/7] KVM: PPC: reimplements LOAD_VMX/STORE_VMX instruction
 mmio emulation with analyse_intr() input
Date: Mon, 21 May 2018 13:24:26 +0800
Message-Id: <1526880266-11291-8-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1526880266-11291-1-git-send-email-wei.guo.simon@gmail.com>
References: <1526880266-11291-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

This patch reimplements LOAD_VMX/STORE_VMX MMIO emulation with
analyse_intr() input. When emulating the store, the VMX reg will need to
be flushed so that the right reg val can be retrieved before writing to
IO MEM.

This patch also adds support for lvebx/lvehx/lvewx/stvebx/stvehx/stvewx
MMIO emulation. To meet the requirement of handling different element
sizes, kvmppc_handle_load128_by2x64()/kvmppc_handle_store128_by2x64()
were replaced with kvmppc_handle_vmx_load()/kvmppc_handle_vmx_store().

The framework used is the similar with VSX instruction mmio emulation.

Suggested-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/kvm_host.h  |   1 +
 arch/powerpc/include/asm/kvm_ppc.h   |  10 +-
 arch/powerpc/kvm/emulate_loadstore.c | 124 +++++++++++------
 arch/powerpc/kvm/powerpc.c           | 259 ++++++++++++++++++++++++++++-------
 4 files changed, 302 insertions(+), 92 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index fe506c8..8dc5e43 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -691,6 +691,7 @@ struct kvm_vcpu_arch {
 	u8 mmio_vsx_offset;
 	u8 mmio_vsx_tx_sx_enabled;
 	u8 mmio_vmx_copy_nums;
+	u8 mmio_vmx_offset;
 	u8 mmio_copy_type;
 	u8 osi_needed;
 	u8 osi_enabled;
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 1f087c4..e991821 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -81,10 +81,10 @@ extern int kvmppc_handle_loads(struct kvm_run *run, struct kvm_vcpu *vcpu,
 extern int kvmppc_handle_vsx_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				unsigned int rt, unsigned int bytes,
 			int is_default_endian, int mmio_sign_extend);
-extern int kvmppc_handle_load128_by2x64(struct kvm_run *run,
-		struct kvm_vcpu *vcpu, unsigned int rt, int is_default_endian);
-extern int kvmppc_handle_store128_by2x64(struct kvm_run *run,
-		struct kvm_vcpu *vcpu, unsigned int rs, int is_default_endian);
+extern int kvmppc_handle_vmx_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
+		unsigned int rt, unsigned int bytes, int is_default_endian);
+extern int kvmppc_handle_vmx_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
+		unsigned int rs, unsigned int bytes, int is_default_endian);
 extern int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			       u64 val, unsigned int bytes,
 			       int is_default_endian);
@@ -265,6 +265,8 @@ extern int kvmppc_xics_get_xive(struct kvm *kvm, u32 irq, u32 *server,
 	vector128 vval;
 	u64	vsxval[2];
 	u32	vsx32val[4];
+	u16	vsx16val[8];
+	u8	vsx8val[16];
 	struct {
 		u64	addr;
 		u64	length;
diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index fa4de6b..b6b2d25 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -113,6 +113,7 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmio_sp64_extend = 0;
 	vcpu->arch.mmio_sign_extend = 0;
 	vcpu->arch.mmio_vmx_copy_nums = 0;
+	vcpu->arch.mmio_vmx_offset = 0;
 	vcpu->arch.mmio_host_swabbed = 0;
 
 	emulated = EMULATE_FAIL;
@@ -158,6 +159,46 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 
 			break;
 #endif
+#ifdef CONFIG_ALTIVEC
+		case LOAD_VMX:
+			if (kvmppc_check_altivec_disabled(vcpu))
+				return EMULATE_DONE;
+
+			/* Hardware enforces alignment of VMX accesses */
+			vcpu->arch.vaddr_accessed &= ~((unsigned long)size - 1);
+			vcpu->arch.paddr_accessed &= ~((unsigned long)size - 1);
+
+			if (size == 16) { /* lvx */
+				vcpu->arch.mmio_copy_type =
+						KVMPPC_VMX_COPY_DWORD;
+			} else if (size == 4) { /* lvewx  */
+				vcpu->arch.mmio_copy_type =
+						KVMPPC_VMX_COPY_WORD;
+			} else if (size == 2) { /* lvehx  */
+				vcpu->arch.mmio_copy_type =
+						KVMPPC_VMX_COPY_HWORD;
+			} else if (size == 1) { /* lvebx  */
+				vcpu->arch.mmio_copy_type =
+						KVMPPC_VMX_COPY_BYTE;
+			} else
+				break;
+
+			vcpu->arch.mmio_vmx_offset =
+				(vcpu->arch.vaddr_accessed & 0xf)/size;
+
+			if (size == 16) {
+				vcpu->arch.mmio_vmx_copy_nums = 2;
+				emulated = kvmppc_handle_vmx_load(run,
+						vcpu, KVM_MMIO_REG_VMX|op.reg,
+						8, 1);
+			} else {
+				vcpu->arch.mmio_vmx_copy_nums = 1;
+				emulated = kvmppc_handle_vmx_load(run, vcpu,
+						KVM_MMIO_REG_VMX|op.reg,
+						size, 1);
+			}
+			break;
+#endif
 #ifdef CONFIG_VSX
 		case LOAD_VSX: {
 			int io_size_each;
@@ -241,6 +282,48 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 
 			break;
 #endif
+#ifdef CONFIG_ALTIVEC
+		case STORE_VMX:
+			if (kvmppc_check_altivec_disabled(vcpu))
+				return EMULATE_DONE;
+
+			/* Hardware enforces alignment of VMX accesses. */
+			vcpu->arch.vaddr_accessed &= ~((unsigned long)size - 1);
+			vcpu->arch.paddr_accessed &= ~((unsigned long)size - 1);
+
+			if (vcpu->kvm->arch.kvm_ops->giveup_ext)
+				vcpu->kvm->arch.kvm_ops->giveup_ext(vcpu,
+						MSR_VEC);
+			if (size == 16) { /* stvx */
+				vcpu->arch.mmio_copy_type =
+						KVMPPC_VMX_COPY_DWORD;
+			} else if (size == 4) { /* stvewx  */
+				vcpu->arch.mmio_copy_type =
+						KVMPPC_VMX_COPY_WORD;
+			} else if (size == 2) { /* stvehx  */
+				vcpu->arch.mmio_copy_type =
+						KVMPPC_VMX_COPY_HWORD;
+			} else if (size == 1) { /* stvebx  */
+				vcpu->arch.mmio_copy_type =
+						KVMPPC_VMX_COPY_BYTE;
+			} else
+				break;
+
+			vcpu->arch.mmio_vmx_offset =
+				(vcpu->arch.vaddr_accessed & 0xf)/size;
+
+			if (size == 16) {
+				vcpu->arch.mmio_vmx_copy_nums = 2;
+				emulated = kvmppc_handle_vmx_store(run,
+						vcpu, op.reg, 8, 1);
+			} else {
+				vcpu->arch.mmio_vmx_copy_nums = 1;
+				emulated = kvmppc_handle_vmx_store(run,
+						vcpu, op.reg, size, 1);
+			}
+
+			break;
+#endif
 #ifdef CONFIG_VSX
 		case STORE_VSX: {
 			int io_size_each;
@@ -298,47 +381,6 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 		}
 	}
 
-
-	if ((emulated == EMULATE_DONE) || (emulated == EMULATE_DO_MMIO))
-		goto out;
-
-	switch (get_op(inst)) {
-	case 31:
-		switch (get_xop(inst)) {
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
-		default:
-			emulated = EMULATE_FAIL;
-			break;
-		}
-		break;
-
-	default:
-		emulated = EMULATE_FAIL;
-		break;
-	}
-
-out:
 	if (emulated == EMULATE_FAIL) {
 		advance = 0;
 		kvmppc_core_queue_program(vcpu, 0);
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 1580bd2..05eccdc 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -953,30 +953,110 @@ static inline void kvmppc_set_vsr_word(struct kvm_vcpu *vcpu,
 #endif /* CONFIG_VSX */
 
 #ifdef CONFIG_ALTIVEC
+static inline int kvmppc_get_vmx_offset_generic(struct kvm_vcpu *vcpu,
+		int index, int element_size)
+{
+	int offset;
+	int elts = sizeof(vector128)/element_size;
+
+	if ((index < 0) || (index >= elts))
+		return -1;
+
+	if (kvmppc_need_byteswap(vcpu))
+		offset = elts - index - 1;
+	else
+		offset = index;
+
+	return offset;
+}
+
+static inline int kvmppc_get_vmx_dword_offset(struct kvm_vcpu *vcpu,
+		int index)
+{
+	return kvmppc_get_vmx_offset_generic(vcpu, index, 8);
+}
+
+static inline int kvmppc_get_vmx_word_offset(struct kvm_vcpu *vcpu,
+		int index)
+{
+	return kvmppc_get_vmx_offset_generic(vcpu, index, 4);
+}
+
+static inline int kvmppc_get_vmx_hword_offset(struct kvm_vcpu *vcpu,
+		int index)
+{
+	return kvmppc_get_vmx_offset_generic(vcpu, index, 2);
+}
+
+static inline int kvmppc_get_vmx_byte_offset(struct kvm_vcpu *vcpu,
+		int index)
+{
+	return kvmppc_get_vmx_offset_generic(vcpu, index, 1);
+}
+
+
 static inline void kvmppc_set_vmx_dword(struct kvm_vcpu *vcpu,
-		u64 gpr)
+	u64 gpr)
 {
+	union kvmppc_one_reg val;
+	int offset = kvmppc_get_vmx_dword_offset(vcpu,
+			vcpu->arch.mmio_vmx_offset);
 	int index = vcpu->arch.io_gpr & KVM_MMIO_REG_MASK;
-	u32 hi, lo;
-	u32 di;
 
-#ifdef __BIG_ENDIAN
-	hi = gpr >> 32;
-	lo = gpr & 0xffffffff;
-#else
-	lo = gpr >> 32;
-	hi = gpr & 0xffffffff;
-#endif
+	if (offset == -1)
+		return;
+
+	val.vval = VCPU_VSX_VR(vcpu, index);
+	val.vsxval[offset] = gpr;
+	VCPU_VSX_VR(vcpu, index) = val.vval;
+}
+
+static inline void kvmppc_set_vmx_word(struct kvm_vcpu *vcpu,
+	u32 gpr32)
+{
+	union kvmppc_one_reg val;
+	int offset = kvmppc_get_vmx_word_offset(vcpu,
+			vcpu->arch.mmio_vmx_offset);
+	int index = vcpu->arch.io_gpr & KVM_MMIO_REG_MASK;
+
+	if (offset == -1)
+		return;
+
+	val.vval = VCPU_VSX_VR(vcpu, index);
+	val.vsx32val[offset] = gpr32;
+	VCPU_VSX_VR(vcpu, index) = val.vval;
+}
 
-	di = 2 - vcpu->arch.mmio_vmx_copy_nums;		/* doubleword index */
-	if (di > 1)
+static inline void kvmppc_set_vmx_hword(struct kvm_vcpu *vcpu,
+	u16 gpr16)
+{
+	union kvmppc_one_reg val;
+	int offset = kvmppc_get_vmx_hword_offset(vcpu,
+			vcpu->arch.mmio_vmx_offset);
+	int index = vcpu->arch.io_gpr & KVM_MMIO_REG_MASK;
+
+	if (offset == -1)
 		return;
 
-	if (vcpu->arch.mmio_host_swabbed)
-		di = 1 - di;
+	val.vval = VCPU_VSX_VR(vcpu, index);
+	val.vsx16val[offset] = gpr16;
+	VCPU_VSX_VR(vcpu, index) = val.vval;
+}
+
+static inline void kvmppc_set_vmx_byte(struct kvm_vcpu *vcpu,
+	u8 gpr8)
+{
+	union kvmppc_one_reg val;
+	int offset = kvmppc_get_vmx_byte_offset(vcpu,
+			vcpu->arch.mmio_vmx_offset);
+	int index = vcpu->arch.io_gpr & KVM_MMIO_REG_MASK;
 
-	VCPU_VSX_VR(vcpu, index).u[di * 2] = hi;
-	VCPU_VSX_VR(vcpu, index).u[di * 2 + 1] = lo;
+	if (offset == -1)
+		return;
+
+	val.vval = VCPU_VSX_VR(vcpu, index);
+	val.vsx8val[offset] = gpr8;
+	VCPU_VSX_VR(vcpu, index) = val.vval;
 }
 #endif /* CONFIG_ALTIVEC */
 
@@ -1097,7 +1177,16 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
 		if (vcpu->kvm->arch.kvm_ops->giveup_ext)
 			vcpu->kvm->arch.kvm_ops->giveup_ext(vcpu, MSR_VEC);
 
-		kvmppc_set_vmx_dword(vcpu, gpr);
+		if (vcpu->arch.mmio_copy_type == KVMPPC_VMX_COPY_DWORD)
+			kvmppc_set_vmx_dword(vcpu, gpr);
+		else if (vcpu->arch.mmio_copy_type == KVMPPC_VMX_COPY_WORD)
+			kvmppc_set_vmx_word(vcpu, gpr);
+		else if (vcpu->arch.mmio_copy_type ==
+				KVMPPC_VMX_COPY_HWORD)
+			kvmppc_set_vmx_hword(vcpu, gpr);
+		else if (vcpu->arch.mmio_copy_type ==
+				KVMPPC_VMX_COPY_BYTE)
+			kvmppc_set_vmx_byte(vcpu, gpr);
 		break;
 #endif
 	default:
@@ -1376,14 +1465,16 @@ static int kvmppc_emulate_mmio_vsx_loadstore(struct kvm_vcpu *vcpu,
 #endif /* CONFIG_VSX */
 
 #ifdef CONFIG_ALTIVEC
-/* handle quadword load access in two halves */
-int kvmppc_handle_load128_by2x64(struct kvm_run *run, struct kvm_vcpu *vcpu,
-		unsigned int rt, int is_default_endian)
+int kvmppc_handle_vmx_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
+		unsigned int rt, unsigned int bytes, int is_default_endian)
 {
 	enum emulation_result emulated = EMULATE_DONE;
 
+	if (vcpu->arch.mmio_vsx_copy_nums > 2)
+		return EMULATE_FAIL;
+
 	while (vcpu->arch.mmio_vmx_copy_nums) {
-		emulated = __kvmppc_handle_load(run, vcpu, rt, 8,
+		emulated = __kvmppc_handle_load(run, vcpu, rt, bytes,
 				is_default_endian, 0);
 
 		if (emulated != EMULATE_DONE)
@@ -1391,55 +1482,127 @@ int kvmppc_handle_load128_by2x64(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 		vcpu->arch.paddr_accessed += run->mmio.len;
 		vcpu->arch.mmio_vmx_copy_nums--;
+		vcpu->arch.mmio_vmx_offset++;
 	}
 
 	return emulated;
 }
 
-static inline int kvmppc_get_vmx_data(struct kvm_vcpu *vcpu, int rs, u64 *val)
+int kvmppc_get_vmx_dword(struct kvm_vcpu *vcpu, int index, u64 *val)
 {
-	vector128 vrs = VCPU_VSX_VR(vcpu, rs);
-	u32 di;
-	u64 w0, w1;
+	union kvmppc_one_reg reg;
+	int vmx_offset = 0;
+	int result = 0;
+
+	vmx_offset =
+		kvmppc_get_vmx_dword_offset(vcpu, vcpu->arch.mmio_vmx_offset);
 
-	di = 2 - vcpu->arch.mmio_vmx_copy_nums;		/* doubleword index */
-	if (di > 1)
+	if (vmx_offset == -1)
 		return -1;
 
-	if (kvmppc_need_byteswap(vcpu))
-		di = 1 - di;
+	reg.vval = VCPU_VSX_VR(vcpu, index);
+	*val = reg.vsxval[vmx_offset];
 
-	w0 = vrs.u[di * 2];
-	w1 = vrs.u[di * 2 + 1];
+	return result;
+}
 
-#ifdef __BIG_ENDIAN
-	*val = (w0 << 32) | w1;
-#else
-	*val = (w1 << 32) | w0;
-#endif
-	return 0;
+int kvmppc_get_vmx_word(struct kvm_vcpu *vcpu, int index, u64 *val)
+{
+	union kvmppc_one_reg reg;
+	int vmx_offset = 0;
+	int result = 0;
+
+	vmx_offset =
+		kvmppc_get_vmx_word_offset(vcpu, vcpu->arch.mmio_vmx_offset);
+
+	if (vmx_offset == -1)
+		return -1;
+
+	reg.vval = VCPU_VSX_VR(vcpu, index);
+	*val = reg.vsx32val[vmx_offset];
+
+	return result;
+}
+
+int kvmppc_get_vmx_hword(struct kvm_vcpu *vcpu, int index, u64 *val)
+{
+	union kvmppc_one_reg reg;
+	int vmx_offset = 0;
+	int result = 0;
+
+	vmx_offset =
+		kvmppc_get_vmx_hword_offset(vcpu, vcpu->arch.mmio_vmx_offset);
+
+	if (vmx_offset == -1)
+		return -1;
+
+	reg.vval = VCPU_VSX_VR(vcpu, index);
+	*val = reg.vsx16val[vmx_offset];
+
+	return result;
+}
+
+int kvmppc_get_vmx_byte(struct kvm_vcpu *vcpu, int index, u64 *val)
+{
+	union kvmppc_one_reg reg;
+	int vmx_offset = 0;
+	int result = 0;
+
+	vmx_offset =
+		kvmppc_get_vmx_byte_offset(vcpu, vcpu->arch.mmio_vmx_offset);
+
+	if (vmx_offset == -1)
+		return -1;
+
+	reg.vval = VCPU_VSX_VR(vcpu, index);
+	*val = reg.vsx8val[vmx_offset];
+
+	return result;
 }
 
-/* handle quadword store in two halves */
-int kvmppc_handle_store128_by2x64(struct kvm_run *run, struct kvm_vcpu *vcpu,
-		unsigned int rs, int is_default_endian)
+int kvmppc_handle_vmx_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
+		unsigned int rs, unsigned int bytes, int is_default_endian)
 {
 	u64 val = 0;
+	unsigned int index = rs & KVM_MMIO_REG_MASK;
 	enum emulation_result emulated = EMULATE_DONE;
 
+	if (vcpu->arch.mmio_vsx_copy_nums > 2)
+		return EMULATE_FAIL;
+
 	vcpu->arch.io_gpr = rs;
 
 	while (vcpu->arch.mmio_vmx_copy_nums) {
-		if (kvmppc_get_vmx_data(vcpu, rs, &val) == -1)
+		switch (vcpu->arch.mmio_copy_type) {
+		case KVMPPC_VMX_COPY_DWORD:
+			if (kvmppc_get_vmx_dword(vcpu, index, &val) == -1)
+				return EMULATE_FAIL;
+
+			break;
+		case KVMPPC_VMX_COPY_WORD:
+			if (kvmppc_get_vmx_word(vcpu, index, &val) == -1)
+				return EMULATE_FAIL;
+			break;
+		case KVMPPC_VMX_COPY_HWORD:
+			if (kvmppc_get_vmx_hword(vcpu, index, &val) == -1)
+				return EMULATE_FAIL;
+			break;
+		case KVMPPC_VMX_COPY_BYTE:
+			if (kvmppc_get_vmx_byte(vcpu, index, &val) == -1)
+				return EMULATE_FAIL;
+			break;
+		default:
 			return EMULATE_FAIL;
+		}
 
-		emulated = kvmppc_handle_store(run, vcpu, val, 8,
+		emulated = kvmppc_handle_store(run, vcpu, val, bytes,
 				is_default_endian);
 		if (emulated != EMULATE_DONE)
 			break;
 
 		vcpu->arch.paddr_accessed += run->mmio.len;
 		vcpu->arch.mmio_vmx_copy_nums--;
+		vcpu->arch.mmio_vmx_offset++;
 	}
 
 	return emulated;
@@ -1454,11 +1617,11 @@ static int kvmppc_emulate_mmio_vmx_loadstore(struct kvm_vcpu *vcpu,
 	vcpu->arch.paddr_accessed += run->mmio.len;
 
 	if (!vcpu->mmio_is_write) {
-		emulated = kvmppc_handle_load128_by2x64(run, vcpu,
-				vcpu->arch.io_gpr, 1);
+		emulated = kvmppc_handle_vmx_load(run, vcpu,
+				vcpu->arch.io_gpr, run->mmio.len, 1);
 	} else {
-		emulated = kvmppc_handle_store128_by2x64(run, vcpu,
-				vcpu->arch.io_gpr, 1);
+		emulated = kvmppc_handle_vmx_store(run, vcpu,
+				vcpu->arch.io_gpr, run->mmio.len, 1);
 	}
 
 	switch (emulated) {
@@ -1602,8 +1765,10 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		}
 #endif
 #ifdef CONFIG_ALTIVEC
-		if (vcpu->arch.mmio_vmx_copy_nums > 0)
+		if (vcpu->arch.mmio_vmx_copy_nums > 0) {
 			vcpu->arch.mmio_vmx_copy_nums--;
+			vcpu->arch.mmio_vmx_offset++;
+		}
 
 		if (vcpu->arch.mmio_vmx_copy_nums > 0) {
 			r = kvmppc_emulate_mmio_vmx_loadstore(vcpu, run);
-- 
1.8.3.1
