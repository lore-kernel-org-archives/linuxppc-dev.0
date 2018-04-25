Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WJY63FtvzF24P
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 21:55:22 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id f189so5905723pfa.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 04:55:22 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 07/11] KVM: PPC: reconstruct non-SIMD LOAD/STORE instruction
 mmio emulation with analyse_intr() input
Date: Wed, 25 Apr 2018 19:54:40 +0800
Message-Id: <1524657284-16706-8-git-send-email-wei.guo.simon@gmail.com>
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

This patch reconstructs non-SIMD LOAD/STORE instruction MMIO emulation
with analyse_intr() input. It utilizes the BYTEREV/UPDATE/SIGNEXT
properties exported by analyse_instr() and invokes
kvmppc_handle_load(s)/kvmppc_handle_store() accordingly.

It also move CACHEOP type handling into the skeleton.

instruction_type within sstep.h is renamed to avoid conflict with
kvm_ppc.h.

Suggested-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/sstep.h     |   2 +-
 arch/powerpc/kvm/emulate_loadstore.c | 282 +++++++----------------------------
 2 files changed, 51 insertions(+), 233 deletions(-)

diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
index ab9d849..0a1a312 100644
--- a/arch/powerpc/include/asm/sstep.h
+++ b/arch/powerpc/include/asm/sstep.h
@@ -23,7 +23,7 @@
 #define IS_RFID(instr)		(((instr) & 0xfc0007fe) == 0x4c000024)
 #define IS_RFI(instr)		(((instr) & 0xfc0007fe) == 0x4c000064)
 
-enum instruction_type {
+enum analyse_instruction_type {
 	COMPUTE,		/* arith/logical/CR op, etc. */
 	LOAD,			/* load and store types need to be contiguous */
 	LOAD_MULTI,
diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index 90b9692..aaaf872 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -31,9 +31,12 @@
 #include <asm/kvm_ppc.h>
 #include <asm/disassemble.h>
 #include <asm/ppc-opcode.h>
+#include <asm/sstep.h>
 #include "timing.h"
 #include "trace.h"
 
+int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
+		  unsigned int instr);
 #ifdef CONFIG_PPC_FPU
 static bool kvmppc_check_fp_disabled(struct kvm_vcpu *vcpu)
 {
@@ -84,8 +87,9 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 	struct kvm_run *run = vcpu->run;
 	u32 inst;
 	int ra, rs, rt;
-	enum emulation_result emulated;
+	enum emulation_result emulated = EMULATE_FAIL;
 	int advance = 1;
+	struct instruction_op op;
 
 	/* this default type might be overwritten by subcategories */
 	kvmppc_set_exit_type(vcpu, EMULATED_INST_EXITS);
@@ -114,144 +118,64 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmio_update_ra = 0;
 	vcpu->arch.mmio_host_swabbed = 0;
 
-	switch (get_op(inst)) {
-	case 31:
-		switch (get_xop(inst)) {
-		case OP_31_XOP_LWZX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 4, 1);
-			break;
-
-		case OP_31_XOP_LWZUX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 4, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
-
-		case OP_31_XOP_LBZX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 1, 1);
-			break;
+	emulated = EMULATE_FAIL;
+	vcpu->arch.regs.msr = vcpu->arch.shared->msr;
+	vcpu->arch.regs.ccr = vcpu->arch.cr;
+	if (analyse_instr(&op, &vcpu->arch.regs, inst) == 0) {
+		int type = op.type & INSTR_TYPE_MASK;
+		int size = GETSIZE(op.type);
 
-		case OP_31_XOP_LBZUX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 1, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
+		switch (type) {
+		case LOAD:  {
+			int instr_byte_swap = op.type & BYTEREV;
 
-		case OP_31_XOP_STDX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 8, 1);
-			break;
+			if (op.type & UPDATE) {
+				vcpu->arch.mmio_ra = op.update_reg;
+				vcpu->arch.mmio_update_ra = 1;
+			}
 
-		case OP_31_XOP_STDUX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 8, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
-
-		case OP_31_XOP_STWX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 4, 1);
-			break;
-
-		case OP_31_XOP_STWUX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 4, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
-
-		case OP_31_XOP_STBX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 1, 1);
-			break;
-
-		case OP_31_XOP_STBUX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 1, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
-
-		case OP_31_XOP_LHAX:
-			emulated = kvmppc_handle_loads(run, vcpu, rt, 2, 1);
-			break;
-
-		case OP_31_XOP_LHAUX:
-			emulated = kvmppc_handle_loads(run, vcpu, rt, 2, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
+			if (op.type & SIGNEXT)
+				emulated = kvmppc_handle_loads(run, vcpu,
+						op.reg, size, !instr_byte_swap);
+			else
+				emulated = kvmppc_handle_load(run, vcpu,
+						op.reg, size, !instr_byte_swap);
 
-		case OP_31_XOP_LHZX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1);
 			break;
-
-		case OP_31_XOP_LHZUX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
-
-		case OP_31_XOP_STHX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 2, 1);
-			break;
-
-		case OP_31_XOP_STHUX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 2, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
-
-		case OP_31_XOP_DCBST:
-		case OP_31_XOP_DCBF:
-		case OP_31_XOP_DCBI:
+		}
+		case STORE:
+			if (op.type & UPDATE) {
+				vcpu->arch.mmio_ra = op.update_reg;
+				vcpu->arch.mmio_update_ra = 1;
+			}
+
+			/* if need byte reverse, op.val has been reverted by
+			 * analyse_instr().
+			 */
+			emulated = kvmppc_handle_store(run, vcpu, op.val,
+					size, 1);
+			break;
+		case CACHEOP:
 			/* Do nothing. The guest is performing dcbi because
 			 * hardware DMA is not snooped by the dcache, but
 			 * emulated DMA either goes through the dcache as
 			 * normal writes, or the host kernel has handled dcache
-			 * coherence. */
-			break;
-
-		case OP_31_XOP_LWBRX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 4, 0);
-			break;
-
-		case OP_31_XOP_STWBRX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 4, 0);
+			 * coherence.
+			 */
+			emulated = EMULATE_DONE;
 			break;
-
-		case OP_31_XOP_LHBRX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 2, 0);
-			break;
-
-		case OP_31_XOP_STHBRX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 2, 0);
-			break;
-
-		case OP_31_XOP_LDBRX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 8, 0);
-			break;
-
-		case OP_31_XOP_STDBRX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 8, 0);
-			break;
-
-		case OP_31_XOP_LDX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 8, 1);
+		default:
 			break;
+		}
+	}
 
-		case OP_31_XOP_LDUX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 8, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
 
-		case OP_31_XOP_LWAX:
-			emulated = kvmppc_handle_loads(run, vcpu, rt, 4, 1);
-			break;
-
-		case OP_31_XOP_LWAUX:
-			emulated = kvmppc_handle_loads(run, vcpu, rt, 4, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
+	if (emulated == EMULATE_DONE)
+		goto out;
 
+	switch (get_op(inst)) {
+	case 31:
+		switch (get_xop(inst)) {
 #ifdef CONFIG_PPC_FPU
 		case OP_31_XOP_LFSX:
 			if (kvmppc_check_fp_disabled(vcpu))
@@ -503,10 +427,6 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 		}
 		break;
 
-	case OP_LWZ:
-		emulated = kvmppc_handle_load(run, vcpu, rt, 4, 1);
-		break;
-
 #ifdef CONFIG_PPC_FPU
 	case OP_STFS:
 		if (kvmppc_check_fp_disabled(vcpu))
@@ -543,110 +463,7 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 	                               8, 1);
 		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 		break;
-#endif
-
-	case OP_LD:
-		rt = get_rt(inst);
-		switch (inst & 3) {
-		case 0:	/* ld */
-			emulated = kvmppc_handle_load(run, vcpu, rt, 8, 1);
-			break;
-		case 1: /* ldu */
-			emulated = kvmppc_handle_load(run, vcpu, rt, 8, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
-		case 2:	/* lwa */
-			emulated = kvmppc_handle_loads(run, vcpu, rt, 4, 1);
-			break;
-		default:
-			emulated = EMULATE_FAIL;
-		}
-		break;
-
-	case OP_LWZU:
-		emulated = kvmppc_handle_load(run, vcpu, rt, 4, 1);
-		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-		break;
-
-	case OP_LBZ:
-		emulated = kvmppc_handle_load(run, vcpu, rt, 1, 1);
-		break;
-
-	case OP_LBZU:
-		emulated = kvmppc_handle_load(run, vcpu, rt, 1, 1);
-		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-		break;
-
-	case OP_STW:
-		emulated = kvmppc_handle_store(run, vcpu,
-					       kvmppc_get_gpr(vcpu, rs),
-		                               4, 1);
-		break;
-
-	case OP_STD:
-		rs = get_rs(inst);
-		switch (inst & 3) {
-		case 0:	/* std */
-			emulated = kvmppc_handle_store(run, vcpu,
-				kvmppc_get_gpr(vcpu, rs), 8, 1);
-			break;
-		case 1: /* stdu */
-			emulated = kvmppc_handle_store(run, vcpu,
-				kvmppc_get_gpr(vcpu, rs), 8, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
-		default:
-			emulated = EMULATE_FAIL;
-		}
-		break;
-
-	case OP_STWU:
-		emulated = kvmppc_handle_store(run, vcpu,
-				kvmppc_get_gpr(vcpu, rs), 4, 1);
-		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-		break;
-
-	case OP_STB:
-		emulated = kvmppc_handle_store(run, vcpu,
-				kvmppc_get_gpr(vcpu, rs), 1, 1);
-		break;
-
-	case OP_STBU:
-		emulated = kvmppc_handle_store(run, vcpu,
-				kvmppc_get_gpr(vcpu, rs), 1, 1);
-		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-		break;
-
-	case OP_LHZ:
-		emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1);
-		break;
-
-	case OP_LHZU:
-		emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1);
-		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-		break;
-
-	case OP_LHA:
-		emulated = kvmppc_handle_loads(run, vcpu, rt, 2, 1);
-		break;
-
-	case OP_LHAU:
-		emulated = kvmppc_handle_loads(run, vcpu, rt, 2, 1);
-		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-		break;
 
-	case OP_STH:
-		emulated = kvmppc_handle_store(run, vcpu,
-				kvmppc_get_gpr(vcpu, rs), 2, 1);
-		break;
-
-	case OP_STHU:
-		emulated = kvmppc_handle_store(run, vcpu,
-				kvmppc_get_gpr(vcpu, rs), 2, 1);
-		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-		break;
-
-#ifdef CONFIG_PPC_FPU
 	case OP_LFS:
 		if (kvmppc_check_fp_disabled(vcpu))
 			return EMULATE_DONE;
@@ -685,6 +502,7 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 		break;
 	}
 
+out:
 	if (emulated == EMULATE_FAIL) {
 		advance = 0;
 		kvmppc_core_queue_program(vcpu, 0);
-- 
1.8.3.1
