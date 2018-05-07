Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fXYk72wnzF14r
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 16:20:58 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id j20so7716319pff.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 May 2018 23:20:58 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 08/10] KVM: PPC: reimplements LOAD_VSX/STORE_VSX
 instruction mmio emulation with analyse_intr() input
Date: Mon,  7 May 2018 14:20:14 +0800
Message-Id: <1525674016-6703-9-git-send-email-wei.guo.simon@gmail.com>
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

This patch reimplements LOAD_VSX/STORE_VSX instruction MMIO emulation with
analyse_intr() input. It utilizes VSX_FPCONV/VSX_SPLAT/SIGNEXT exported
by analyse_instr() and handle accordingly.

When emulating VSX store, the VSX reg will need to be flushed so that
the right reg val can be retrieved before writing to IO MEM.

Suggested-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/emulate_loadstore.c | 227 ++++++++++++++---------------------
 1 file changed, 91 insertions(+), 136 deletions(-)

diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index 5a6571c..28e97c5 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -154,6 +154,54 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 
 			break;
 #endif
+#ifdef CONFIG_VSX
+		case LOAD_VSX: {
+			int io_size_each;
+
+			if (op.vsx_flags & VSX_CHECK_VEC) {
+				if (kvmppc_check_altivec_disabled(vcpu))
+					return EMULATE_DONE;
+			} else {
+				if (kvmppc_check_vsx_disabled(vcpu))
+					return EMULATE_DONE;
+			}
+
+			if (op.vsx_flags & VSX_FPCONV)
+				vcpu->arch.mmio_sp64_extend = 1;
+
+			if (op.element_size == 8)  {
+				if (op.vsx_flags & VSX_SPLAT)
+					vcpu->arch.mmio_vsx_copy_type =
+						KVMPPC_VSX_COPY_DWORD_LOAD_DUMP;
+				else
+					vcpu->arch.mmio_vsx_copy_type =
+						KVMPPC_VSX_COPY_DWORD;
+			} else if (op.element_size == 4) {
+				if (op.vsx_flags & VSX_SPLAT)
+					vcpu->arch.mmio_vsx_copy_type =
+						KVMPPC_VSX_COPY_WORD_LOAD_DUMP;
+				else
+					vcpu->arch.mmio_vsx_copy_type =
+						KVMPPC_VSX_COPY_WORD;
+			} else
+				break;
+
+			if (size < op.element_size) {
+				/* precision convert case: lxsspx, etc */
+				vcpu->arch.mmio_vsx_copy_nums = 1;
+				io_size_each = size;
+			} else { /* lxvw4x, lxvd2x, etc */
+				vcpu->arch.mmio_vsx_copy_nums =
+					size/op.element_size;
+				io_size_each = op.element_size;
+			}
+
+			emulated = kvmppc_handle_vsx_load(run, vcpu,
+					KVM_MMIO_REG_VSX|op.reg, io_size_each,
+					1, op.type & SIGNEXT);
+			break;
+		}
+#endif
 		case STORE:
 			/* if need byte reverse, op.val has been reversed by
 			 * analyse_instr().
@@ -189,6 +237,49 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 
 			break;
 #endif
+#ifdef CONFIG_VSX
+		case STORE_VSX: {
+			int io_size_each;
+
+			if (op.vsx_flags & VSX_CHECK_VEC) {
+				if (kvmppc_check_altivec_disabled(vcpu))
+					return EMULATE_DONE;
+			} else {
+				if (kvmppc_check_vsx_disabled(vcpu))
+					return EMULATE_DONE;
+			}
+
+			if (vcpu->kvm->arch.kvm_ops->giveup_ext)
+				vcpu->kvm->arch.kvm_ops->giveup_ext(vcpu,
+						MSR_VSX);
+
+			if (op.vsx_flags & VSX_FPCONV)
+				vcpu->arch.mmio_sp64_extend = 1;
+
+			if (op.element_size == 8)
+				vcpu->arch.mmio_vsx_copy_type =
+						KVMPPC_VSX_COPY_DWORD;
+			else if (op.element_size == 4)
+				vcpu->arch.mmio_vsx_copy_type =
+						KVMPPC_VSX_COPY_WORD;
+			else
+				break;
+
+			if (size < op.element_size) {
+				/* precise conversion case, like stxsspx */
+				vcpu->arch.mmio_vsx_copy_nums = 1;
+				io_size_each = size;
+			} else { /* stxvw4x, stxvd2x, etc */
+				vcpu->arch.mmio_vsx_copy_nums =
+						size/op.element_size;
+				io_size_each = op.element_size;
+			}
+
+			emulated = kvmppc_handle_vsx_store(run, vcpu,
+					op.reg, io_size_each, 1);
+			break;
+		}
+#endif
 		case CACHEOP:
 			/* Do nothing. The guest is performing dcbi because
 			 * hardware DMA is not snooped by the dcache, but
@@ -210,142 +301,6 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 	switch (get_op(inst)) {
 	case 31:
 		switch (get_xop(inst)) {
-#ifdef CONFIG_VSX
-		case OP_31_XOP_LXSDX:
-			if (kvmppc_check_vsx_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.mmio_vsx_copy_nums = 1;
-			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_DWORD;
-			emulated = kvmppc_handle_vsx_load(run, vcpu,
-				KVM_MMIO_REG_VSX|rt, 8, 1, 0);
-			break;
-
-		case OP_31_XOP_LXSSPX:
-			if (kvmppc_check_vsx_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.mmio_vsx_copy_nums = 1;
-			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_DWORD;
-			vcpu->arch.mmio_sp64_extend = 1;
-			emulated = kvmppc_handle_vsx_load(run, vcpu,
-				KVM_MMIO_REG_VSX|rt, 4, 1, 0);
-			break;
-
-		case OP_31_XOP_LXSIWAX:
-			if (kvmppc_check_vsx_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.mmio_vsx_copy_nums = 1;
-			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_DWORD;
-			emulated = kvmppc_handle_vsx_load(run, vcpu,
-				KVM_MMIO_REG_VSX|rt, 4, 1, 1);
-			break;
-
-		case OP_31_XOP_LXSIWZX:
-			if (kvmppc_check_vsx_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.mmio_vsx_copy_nums = 1;
-			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_DWORD;
-			emulated = kvmppc_handle_vsx_load(run, vcpu,
-				KVM_MMIO_REG_VSX|rt, 4, 1, 0);
-			break;
-
-		case OP_31_XOP_LXVD2X:
-		/*
-		 * In this case, the official load/store process is like this:
-		 * Step1, exit from vm by page fault isr, then kvm save vsr.
-		 * Please see guest_exit_cont->store_fp_state->SAVE_32VSRS
-		 * as reference.
-		 *
-		 * Step2, copy data between memory and VCPU
-		 * Notice: for LXVD2X/STXVD2X/LXVW4X/STXVW4X, we use
-		 * 2copies*8bytes or 4copies*4bytes
-		 * to simulate one copy of 16bytes.
-		 * Also there is an endian issue here, we should notice the
-		 * layout of memory.
-		 * Please see MARCO of LXVD2X_ROT/STXVD2X_ROT as more reference.
-		 * If host is little-endian, kvm will call XXSWAPD for
-		 * LXVD2X_ROT/STXVD2X_ROT.
-		 * So, if host is little-endian,
-		 * the postion of memeory should be swapped.
-		 *
-		 * Step3, return to guest, kvm reset register.
-		 * Please see kvmppc_hv_entry->load_fp_state->REST_32VSRS
-		 * as reference.
-		 */
-			if (kvmppc_check_vsx_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.mmio_vsx_copy_nums = 2;
-			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_DWORD;
-			emulated = kvmppc_handle_vsx_load(run, vcpu,
-				KVM_MMIO_REG_VSX|rt, 8, 1, 0);
-			break;
-
-		case OP_31_XOP_LXVW4X:
-			if (kvmppc_check_vsx_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.mmio_vsx_copy_nums = 4;
-			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_WORD;
-			emulated = kvmppc_handle_vsx_load(run, vcpu,
-				KVM_MMIO_REG_VSX|rt, 4, 1, 0);
-			break;
-
-		case OP_31_XOP_LXVDSX:
-			if (kvmppc_check_vsx_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.mmio_vsx_copy_nums = 1;
-			vcpu->arch.mmio_vsx_copy_type =
-				 KVMPPC_VSX_COPY_DWORD_LOAD_DUMP;
-			emulated = kvmppc_handle_vsx_load(run, vcpu,
-				KVM_MMIO_REG_VSX|rt, 8, 1, 0);
-			break;
-
-		case OP_31_XOP_STXSDX:
-			if (kvmppc_check_vsx_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.mmio_vsx_copy_nums = 1;
-			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_DWORD;
-			emulated = kvmppc_handle_vsx_store(run, vcpu,
-						 rs, 8, 1);
-			break;
-
-		case OP_31_XOP_STXSSPX:
-			if (kvmppc_check_vsx_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.mmio_vsx_copy_nums = 1;
-			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_DWORD;
-			vcpu->arch.mmio_sp64_extend = 1;
-			emulated = kvmppc_handle_vsx_store(run, vcpu,
-						 rs, 4, 1);
-			break;
-
-		case OP_31_XOP_STXSIWX:
-			if (kvmppc_check_vsx_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.mmio_vsx_offset = 1;
-			vcpu->arch.mmio_vsx_copy_nums = 1;
-			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_WORD;
-			emulated = kvmppc_handle_vsx_store(run, vcpu,
-							 rs, 4, 1);
-			break;
-
-		case OP_31_XOP_STXVD2X:
-			if (kvmppc_check_vsx_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.mmio_vsx_copy_nums = 2;
-			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_DWORD;
-			emulated = kvmppc_handle_vsx_store(run, vcpu,
-							 rs, 8, 1);
-			break;
-
-		case OP_31_XOP_STXVW4X:
-			if (kvmppc_check_vsx_disabled(vcpu))
-				return EMULATE_DONE;
-			vcpu->arch.mmio_vsx_copy_nums = 4;
-			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_WORD;
-			emulated = kvmppc_handle_vsx_store(run, vcpu,
-							 rs, 4, 1);
-			break;
-#endif /* CONFIG_VSX */
-
 #ifdef CONFIG_ALTIVEC
 		case OP_31_XOP_LVX:
 			if (kvmppc_check_altivec_disabled(vcpu))
-- 
1.8.3.1
