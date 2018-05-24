Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40s3KL1XPczF1Nf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 19:01:41 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id c41-v6so655473plj.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 02:01:41 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH] KVM: PPC: remove mmio_vsx_tx_sx_enabled in PR KVM MMIO
 emulation
Date: Thu, 24 May 2018 17:01:26 +0800
Message-Id: <1527152486-13843-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

Originally PR KVM MMIO emulation uses only 0~31#(5 bits) for VSR
reg number, and use mmio_vsx_tx_sx_enabled field together for
0~63# VSR regs.

Currently PR KVM MMIO emulation is reimplemented with analyse_instr()
assistence. analyse_instr() returns 0~63 for VSR register number, so
it is not necessary to use additional mmio_vsx_tx_sx_enabled field
any more.

This patch extends related reg bits(expand io_gpr to u16 from u8
and use 6 bits for VSR reg#), so that mmio_vsx_tx_sx_enabled can
be removed.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/kvm_host.h  | 17 ++++++++---------
 arch/powerpc/kvm/emulate_loadstore.c |  7 +++----
 arch/powerpc/kvm/powerpc.c           | 30 +++++++++++++++---------------
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 8dc5e43..bd220a3 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -673,7 +673,7 @@ struct kvm_vcpu_arch {
 	gva_t vaddr_accessed;
 	pgd_t *pgdir;
 
-	u8 io_gpr; /* GPR used as IO source/target */
+	u16 io_gpr; /* GPR used as IO source/target */
 	u8 mmio_host_swabbed;
 	u8 mmio_sign_extend;
 	/* conversion between single and double precision */
@@ -689,7 +689,6 @@ struct kvm_vcpu_arch {
 	 */
 	u8 mmio_vsx_copy_nums;
 	u8 mmio_vsx_offset;
-	u8 mmio_vsx_tx_sx_enabled;
 	u8 mmio_vmx_copy_nums;
 	u8 mmio_vmx_offset;
 	u8 mmio_copy_type;
@@ -802,14 +801,14 @@ struct kvm_vcpu_arch {
 #define KVMPPC_VCPU_BUSY_IN_HOST	2
 
 /* Values for vcpu->arch.io_gpr */
-#define KVM_MMIO_REG_MASK	0x001f
-#define KVM_MMIO_REG_EXT_MASK	0xffe0
+#define KVM_MMIO_REG_MASK	0x003f
+#define KVM_MMIO_REG_EXT_MASK	0xffc0
 #define KVM_MMIO_REG_GPR	0x0000
-#define KVM_MMIO_REG_FPR	0x0020
-#define KVM_MMIO_REG_QPR	0x0040
-#define KVM_MMIO_REG_FQPR	0x0060
-#define KVM_MMIO_REG_VSX	0x0080
-#define KVM_MMIO_REG_VMX	0x00c0
+#define KVM_MMIO_REG_FPR	0x0040
+#define KVM_MMIO_REG_QPR	0x0080
+#define KVM_MMIO_REG_FQPR	0x00c0
+#define KVM_MMIO_REG_VSX	0x0100
+#define KVM_MMIO_REG_VMX	0x0180
 
 #define __KVM_HAVE_ARCH_WQP
 #define __KVM_HAVE_CREATE_DEVICE
diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index dca7f1c..64b325b 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -106,7 +106,6 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 	 * if mmio_vsx_tx_sx_enabled == 1, copy data between
 	 * VSR[32..63] and memory
 	 */
-	vcpu->arch.mmio_vsx_tx_sx_enabled = get_tx_or_sx(inst);
 	vcpu->arch.mmio_vsx_copy_nums = 0;
 	vcpu->arch.mmio_vsx_offset = 0;
 	vcpu->arch.mmio_copy_type = KVMPPC_VSX_COPY_NONE;
@@ -242,8 +241,8 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 			}
 
 			emulated = kvmppc_handle_vsx_load(run, vcpu,
-					KVM_MMIO_REG_VSX | (op.reg & 0x1f),
-					io_size_each, 1, op.type & SIGNEXT);
+					KVM_MMIO_REG_VSX|op.reg, io_size_each,
+					1, op.type & SIGNEXT);
 			break;
 		}
 #endif
@@ -363,7 +362,7 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 			}
 
 			emulated = kvmppc_handle_vsx_store(run, vcpu,
-					op.reg & 0x1f, io_size_each, 1);
+					op.reg, io_size_each, 1);
 			break;
 		}
 #endif
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 05eccdc..dcc7982 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -881,10 +881,10 @@ static inline void kvmppc_set_vsr_dword(struct kvm_vcpu *vcpu,
 	if (offset == -1)
 		return;
 
-	if (vcpu->arch.mmio_vsx_tx_sx_enabled) {
-		val.vval = VCPU_VSX_VR(vcpu, index);
+	if (index >= 32) {
+		val.vval = VCPU_VSX_VR(vcpu, index - 32);
 		val.vsxval[offset] = gpr;
-		VCPU_VSX_VR(vcpu, index) = val.vval;
+		VCPU_VSX_VR(vcpu, index - 32) = val.vval;
 	} else {
 		VCPU_VSX_FPR(vcpu, index, offset) = gpr;
 	}
@@ -896,11 +896,11 @@ static inline void kvmppc_set_vsr_dword_dump(struct kvm_vcpu *vcpu,
 	union kvmppc_one_reg val;
 	int index = vcpu->arch.io_gpr & KVM_MMIO_REG_MASK;
 
-	if (vcpu->arch.mmio_vsx_tx_sx_enabled) {
-		val.vval = VCPU_VSX_VR(vcpu, index);
+	if (index >= 32) {
+		val.vval = VCPU_VSX_VR(vcpu, index - 32);
 		val.vsxval[0] = gpr;
 		val.vsxval[1] = gpr;
-		VCPU_VSX_VR(vcpu, index) = val.vval;
+		VCPU_VSX_VR(vcpu, index - 32) = val.vval;
 	} else {
 		VCPU_VSX_FPR(vcpu, index, 0) = gpr;
 		VCPU_VSX_FPR(vcpu, index, 1) = gpr;
@@ -913,12 +913,12 @@ static inline void kvmppc_set_vsr_word_dump(struct kvm_vcpu *vcpu,
 	union kvmppc_one_reg val;
 	int index = vcpu->arch.io_gpr & KVM_MMIO_REG_MASK;
 
-	if (vcpu->arch.mmio_vsx_tx_sx_enabled) {
+	if (index >= 32) {
 		val.vsx32val[0] = gpr;
 		val.vsx32val[1] = gpr;
 		val.vsx32val[2] = gpr;
 		val.vsx32val[3] = gpr;
-		VCPU_VSX_VR(vcpu, index) = val.vval;
+		VCPU_VSX_VR(vcpu, index - 32) = val.vval;
 	} else {
 		val.vsx32val[0] = gpr;
 		val.vsx32val[1] = gpr;
@@ -938,10 +938,10 @@ static inline void kvmppc_set_vsr_word(struct kvm_vcpu *vcpu,
 	if (offset == -1)
 		return;
 
-	if (vcpu->arch.mmio_vsx_tx_sx_enabled) {
-		val.vval = VCPU_VSX_VR(vcpu, index);
+	if (index >= 32) {
+		val.vval = VCPU_VSX_VR(vcpu, index - 32);
 		val.vsx32val[offset] = gpr32;
-		VCPU_VSX_VR(vcpu, index) = val.vval;
+		VCPU_VSX_VR(vcpu, index - 32) = val.vval;
 	} else {
 		dword_offset = offset / 2;
 		word_offset = offset % 2;
@@ -1362,10 +1362,10 @@ static inline int kvmppc_get_vsr_data(struct kvm_vcpu *vcpu, int rs, u64 *val)
 			break;
 		}
 
-		if (!vcpu->arch.mmio_vsx_tx_sx_enabled) {
+		if (rs < 32) {
 			*val = VCPU_VSX_FPR(vcpu, rs, vsx_offset);
 		} else {
-			reg.vval = VCPU_VSX_VR(vcpu, rs);
+			reg.vval = VCPU_VSX_VR(vcpu, rs - 32);
 			*val = reg.vsxval[vsx_offset];
 		}
 		break;
@@ -1379,13 +1379,13 @@ static inline int kvmppc_get_vsr_data(struct kvm_vcpu *vcpu, int rs, u64 *val)
 			break;
 		}
 
-		if (!vcpu->arch.mmio_vsx_tx_sx_enabled) {
+		if (rs < 32) {
 			dword_offset = vsx_offset / 2;
 			word_offset = vsx_offset % 2;
 			reg.vsxval[0] = VCPU_VSX_FPR(vcpu, rs, dword_offset);
 			*val = reg.vsx32val[word_offset];
 		} else {
-			reg.vval = VCPU_VSX_VR(vcpu, rs);
+			reg.vval = VCPU_VSX_VR(vcpu, rs - 32);
 			*val = reg.vsx32val[vsx_offset];
 		}
 		break;
-- 
1.8.3.1
