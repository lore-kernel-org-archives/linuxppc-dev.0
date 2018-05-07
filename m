Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fXYZ1StTzF1PD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 16:20:50 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id p14so10648949pfh.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 May 2018 23:20:50 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 05/10] KVM: PPC: reimplement non-SIMD LOAD/STORE
 instruction mmio emulation with analyse_intr() input
Date: Mon,  7 May 2018 14:20:11 +0800
Message-Id: <1525674016-6703-6-git-send-email-wei.guo.simon@gmail.com>
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

This patch reimplements non-SIMD LOAD/STORE instruction MMIO emulation
with analyse_intr() input. It utilizes the BYTEREV/UPDATE/SIGNEXT
properties exported by analyse_instr() and invokes
kvmppc_handle_load(s)/kvmppc_handle_store() accordingly.

It also move CACHEOP type handling into the skeleton.

instruction_type within kvm_ppc.h is renamed to avoid conflict with
sstep.h.

Suggested-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/kvm_ppc.h   |   6 +-
 arch/powerpc/kvm/book3s.c            |   4 +-
 arch/powerpc/kvm/e500_mmu_host.c     |   8 +-
 arch/powerpc/kvm/emulate_loadstore.c | 271 ++++++-----------------------------
 4 files changed, 51 insertions(+), 238 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index abe7032..139cdf0 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -52,7 +52,7 @@ enum emulation_result {
 	EMULATE_EXIT_USER,    /* emulation requires exit to user-space */
 };
 
-enum instruction_type {
+enum instruction_fetch_type {
 	INST_GENERIC,
 	INST_SC,		/* system call */
 };
@@ -93,7 +93,7 @@ extern int kvmppc_handle_vsx_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				int is_default_endian);
 
 extern int kvmppc_load_last_inst(struct kvm_vcpu *vcpu,
-				 enum instruction_type type, u32 *inst);
+				 enum instruction_fetch_type type, u32 *inst);
 
 extern int kvmppc_ld(struct kvm_vcpu *vcpu, ulong *eaddr, int size, void *ptr,
 		     bool data);
@@ -330,7 +330,7 @@ struct kvmppc_ops {
 extern struct kvmppc_ops *kvmppc_pr_ops;
 
 static inline int kvmppc_get_last_inst(struct kvm_vcpu *vcpu,
-					enum instruction_type type, u32 *inst)
+				enum instruction_fetch_type type, u32 *inst)
 {
 	int ret = EMULATE_DONE;
 	u32 fetched_inst;
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 97d4a11..320cdcf 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -450,8 +450,8 @@ int kvmppc_xlate(struct kvm_vcpu *vcpu, ulong eaddr, enum xlate_instdata xlid,
 	return r;
 }
 
-int kvmppc_load_last_inst(struct kvm_vcpu *vcpu, enum instruction_type type,
-					 u32 *inst)
+int kvmppc_load_last_inst(struct kvm_vcpu *vcpu,
+		enum instruction_fetch_type type, u32 *inst)
 {
 	ulong pc = kvmppc_get_pc(vcpu);
 	int r;
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index c878b4f..8f2985e 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -625,8 +625,8 @@ void kvmppc_mmu_map(struct kvm_vcpu *vcpu, u64 eaddr, gpa_t gpaddr,
 }
 
 #ifdef CONFIG_KVM_BOOKE_HV
-int kvmppc_load_last_inst(struct kvm_vcpu *vcpu, enum instruction_type type,
-			  u32 *instr)
+int kvmppc_load_last_inst(struct kvm_vcpu *vcpu,
+		enum instruction_fetch_type type, u32 *instr)
 {
 	gva_t geaddr;
 	hpa_t addr;
@@ -715,8 +715,8 @@ int kvmppc_load_last_inst(struct kvm_vcpu *vcpu, enum instruction_type type,
 	return EMULATE_DONE;
 }
 #else
-int kvmppc_load_last_inst(struct kvm_vcpu *vcpu, enum instruction_type type,
-			  u32 *instr)
+int kvmppc_load_last_inst(struct kvm_vcpu *vcpu,
+		enum instruction_fetch_type type, u32 *instr)
 {
 	return EMULATE_AGAIN;
 }
diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index b8a3aef..2a91845 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -31,6 +31,7 @@
 #include <asm/kvm_ppc.h>
 #include <asm/disassemble.h>
 #include <asm/ppc-opcode.h>
+#include <asm/sstep.h>
 #include "timing.h"
 #include "trace.h"
 
@@ -84,8 +85,9 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 	struct kvm_run *run = vcpu->run;
 	u32 inst;
 	int ra, rs, rt;
-	enum emulation_result emulated;
+	enum emulation_result emulated = EMULATE_FAIL;
 	int advance = 1;
+	struct instruction_op op;
 
 	/* this default type might be overwritten by subcategories */
 	kvmppc_set_exit_type(vcpu, EMULATED_INST_EXITS);
@@ -113,144 +115,61 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmio_vmx_copy_nums = 0;
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
-
-		case OP_31_XOP_LBZUX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 1, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
-
-		case OP_31_XOP_STDX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 8, 1);
-			break;
-
-		case OP_31_XOP_STDUX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 8, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
+	emulated = EMULATE_FAIL;
+	vcpu->arch.regs.msr = vcpu->arch.shared->msr;
+	vcpu->arch.regs.ccr = vcpu->arch.cr;
+	if (analyse_instr(&op, &vcpu->arch.regs, inst) == 0) {
+		int type = op.type & INSTR_TYPE_MASK;
+		int size = GETSIZE(op.type);
 
-		case OP_31_XOP_STWX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 4, 1);
-			break;
+		switch (type) {
+		case LOAD:  {
+			int instr_byte_swap = op.type & BYTEREV;
 
-		case OP_31_XOP_STWUX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 4, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
+			if (op.type & SIGNEXT)
+				emulated = kvmppc_handle_loads(run, vcpu,
+						op.reg, size, !instr_byte_swap);
+			else
+				emulated = kvmppc_handle_load(run, vcpu,
+						op.reg, size, !instr_byte_swap);
 
-		case OP_31_XOP_STBX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 1, 1);
-			break;
+			if ((op.type & UPDATE) && (emulated != EMULATE_FAIL))
+				kvmppc_set_gpr(vcpu, op.update_reg, op.ea);
 
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
-
-		case OP_31_XOP_LHZX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1);
 			break;
+		}
+		case STORE:
+			/* if need byte reverse, op.val has been reversed by
+			 * analyse_instr().
+			 */
+			emulated = kvmppc_handle_store(run, vcpu, op.val,
+					size, 1);
 
-		case OP_31_XOP_LHZUX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
-			break;
+			if ((op.type & UPDATE) && (emulated != EMULATE_FAIL))
+				kvmppc_set_gpr(vcpu, op.update_reg, op.ea);
 
-		case OP_31_XOP_STHX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 2, 1);
-			break;
-
-		case OP_31_XOP_STHUX:
-			emulated = kvmppc_handle_store(run, vcpu,
-					kvmppc_get_gpr(vcpu, rs), 2, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 			break;
-
-		case OP_31_XOP_DCBST:
-		case OP_31_XOP_DCBF:
-		case OP_31_XOP_DCBI:
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
-			break;
-
-		case OP_31_XOP_LHBRX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 2, 0);
+			 * coherence.
+			 */
+			emulated = EMULATE_DONE;
 			break;
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
-			break;
-
-		case OP_31_XOP_LDUX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 8, 1);
-			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
+		default:
 			break;
+		}
+	}
 
-		case OP_31_XOP_LWAX:
-			emulated = kvmppc_handle_loads(run, vcpu, rt, 4, 1);
-			break;
 
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
@@ -502,10 +421,6 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 		}
 		break;
 
-	case OP_LWZ:
-		emulated = kvmppc_handle_load(run, vcpu, rt, 4, 1);
-		break;
-
 #ifdef CONFIG_PPC_FPU
 	case OP_STFS:
 		if (kvmppc_check_fp_disabled(vcpu))
@@ -542,110 +457,7 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
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
-
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
@@ -684,6 +496,7 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 		break;
 	}
 
+out:
 	if (emulated == EMULATE_FAIL) {
 		advance = 0;
 		kvmppc_core_queue_program(vcpu, 0);
-- 
1.8.3.1
