Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpYQZ3YShzDq93
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 15:26:14 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 2/5] KVM: PPC: Book3S: Add MMIO emulation for FP and VSX
 instructions
Date: Thu, 23 Mar 2017 15:26:00 +1100
Message-Id: <1490243163-19566-3-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1490243163-19566-1-git-send-email-paulus@ozlabs.org>
References: <1490243163-19566-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bin Lu <lblulb@linux.vnet.ibm.com>

This patch provides the MMIO load/store emulation for instructions
of 'double & vector unsigned char & vector signed char & vector
unsigned short & vector signed short & vector unsigned int & vector
signed int & vector double '.

The instructions that this adds emulation for are:

- ldx, ldux, lwax,
- lfs, lfsx, lfsu, lfsux, lfd, lfdx, lfdu, lfdux,
- stfs, stfsx, stfsu, stfsux, stfd, stfdx, stfdu, stfdux, stfiwx,
- lxsdx, lxsspx, lxsiwax, lxsiwzx, lxvd2x, lxvw4x, lxvdsx,
- stxsdx, stxsspx, stxsiwx, stxvd2x, stxvw4x

[paulus@ozlabs.org - some cleanups, fixes and rework, make it
 compile for Book E]

Signed-off-by: Bin Lu <lblulb@linux.vnet.ibm.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/disassemble.h |   5 +
 arch/powerpc/include/asm/kvm_host.h    |  23 +++
 arch/powerpc/include/asm/kvm_ppc.h     |   7 +
 arch/powerpc/include/asm/ppc-opcode.h  |  50 +++++
 arch/powerpc/kvm/Makefile              |   2 +-
 arch/powerpc/kvm/emulate_loadstore.c   | 335 ++++++++++++++++++++++++++++++++-
 arch/powerpc/kvm/powerpc.c             | 317 ++++++++++++++++++++++++++++++-
 7 files changed, 731 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/disassemble.h b/arch/powerpc/include/asm/disassemble.h
index 4852e84..c0a5505 100644
--- a/arch/powerpc/include/asm/disassemble.h
+++ b/arch/powerpc/include/asm/disassemble.h
@@ -87,6 +87,11 @@ static inline unsigned int get_oc(u32 inst)
 	return (inst >> 11) & 0x7fff;
 }
 
+static inline unsigned int get_tx_or_sx(u32 inst)
+{
+	return (inst) & 0x1;
+}
+
 #define IS_XFORM(inst)	(get_op(inst)  == 31)
 #define IS_DSFORM(inst)	(get_op(inst) >= 56)
 
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 7bba8f4..201438b 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -441,6 +441,11 @@ struct mmio_hpte_cache {
 	unsigned int index;
 };
 
+#define KVMPPC_VSX_COPY_NONE		0
+#define KVMPPC_VSX_COPY_WORD		1
+#define KVMPPC_VSX_COPY_DWORD		2
+#define KVMPPC_VSX_COPY_DWORD_LOAD_DUMP	3
+
 struct openpic;
 
 struct kvm_vcpu_arch {
@@ -644,6 +649,21 @@ struct kvm_vcpu_arch {
 	u8 io_gpr; /* GPR used as IO source/target */
 	u8 mmio_host_swabbed;
 	u8 mmio_sign_extend;
+	/* conversion between single and double precision */
+	u8 mmio_sp64_extend;
+	/*
+	 * Number of simulations for vsx.
+	 * If we use 2*8bytes to simulate 1*16bytes,
+	 * then the number should be 2 and
+	 * mmio_vsx_copy_type=KVMPPC_VSX_COPY_DWORD.
+	 * If we use 4*4bytes to simulate 1*16bytes,
+	 * the number should be 4 and
+	 * mmio_vsx_copy_type=KVMPPC_VSX_COPY_WORD.
+	 */
+	u8 mmio_vsx_copy_nums;
+	u8 mmio_vsx_offset;
+	u8 mmio_vsx_copy_type;
+	u8 mmio_vsx_tx_sx_enabled;
 	u8 osi_needed;
 	u8 osi_enabled;
 	u8 papr_enabled;
@@ -732,6 +752,8 @@ struct kvm_vcpu_arch {
 };
 
 #define VCPU_FPR(vcpu, i)	(vcpu)->arch.fp.fpr[i][TS_FPROFFSET]
+#define VCPU_VSX_FPR(vcpu, i, j)	((vcpu)->arch.fp.fpr[i][j])
+#define VCPU_VSX_VR(vcpu, i)		((vcpu)->arch.vr.vr[i])
 
 /* Values for vcpu->arch.state */
 #define KVMPPC_VCPU_NOTREADY		0
@@ -745,6 +767,7 @@ struct kvm_vcpu_arch {
 #define KVM_MMIO_REG_FPR	0x0020
 #define KVM_MMIO_REG_QPR	0x0040
 #define KVM_MMIO_REG_FQPR	0x0060
+#define KVM_MMIO_REG_VSX	0x0080
 
 #define __KVM_HAVE_ARCH_WQP
 #define __KVM_HAVE_CREATE_DEVICE
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 4f1f22f..bbecec4 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -78,9 +78,15 @@ extern int kvmppc_handle_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
 extern int kvmppc_handle_loads(struct kvm_run *run, struct kvm_vcpu *vcpu,
                                unsigned int rt, unsigned int bytes,
 			       int is_default_endian);
+extern int kvmppc_handle_vsx_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				unsigned int rt, unsigned int bytes,
+			int is_default_endian, int mmio_sign_extend);
 extern int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			       u64 val, unsigned int bytes,
 			       int is_default_endian);
+extern int kvmppc_handle_vsx_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				int rs, unsigned int bytes,
+				int is_default_endian);
 
 extern int kvmppc_load_last_inst(struct kvm_vcpu *vcpu,
 				 enum instruction_type type, u32 *inst);
@@ -243,6 +249,7 @@ union kvmppc_one_reg {
 	u64	dval;
 	vector128 vval;
 	u64	vsxval[2];
+	u32	vsx32val[4];
 	struct {
 		u64	addr;
 		u64	length;
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index e7d6d86..1e37c3c 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -86,7 +86,9 @@
 #define OP_TRAP_64 2
 
 #define OP_31_XOP_TRAP      4
+#define OP_31_XOP_LDX       21
 #define OP_31_XOP_LWZX      23
+#define OP_31_XOP_LDUX      53
 #define OP_31_XOP_DCBST     54
 #define OP_31_XOP_LWZUX     55
 #define OP_31_XOP_TRAP_64   68
@@ -99,6 +101,7 @@
 #define OP_31_XOP_LHZX      279
 #define OP_31_XOP_LHZUX     311
 #define OP_31_XOP_MFSPR     339
+#define OP_31_XOP_LWAX      341
 #define OP_31_XOP_LHAX      343
 #define OP_31_XOP_LHAUX     375
 #define OP_31_XOP_STHX      407
@@ -108,10 +111,46 @@
 #define OP_31_XOP_LWBRX     534
 #define OP_31_XOP_TLBSYNC   566
 #define OP_31_XOP_STWBRX    662
+#define OP_31_XOP_STFSX	    663
+#define OP_31_XOP_STFSUX    695
+#define OP_31_XOP_STFDX     727
+#define OP_31_XOP_STFDUX    759
 #define OP_31_XOP_LHBRX     790
 #define OP_31_XOP_STHBRX    918
+#define OP_31_XOP_STFIWX    983
+
+/* VSX Scalar Load Instructions */
+#define OP_31_XOP_LXSDX         588
+#define OP_31_XOP_LXSSPX        524
+#define OP_31_XOP_LXSIWAX       76
+#define OP_31_XOP_LXSIWZX       12
+
+/* VSX Scalar Store Instructions */
+#define OP_31_XOP_STXSDX        716
+#define OP_31_XOP_STXSSPX       652
+#define OP_31_XOP_STXSIWX       140
+
+/* VSX Vector Load Instructions */
+#define OP_31_XOP_LXVD2X        844
+#define OP_31_XOP_LXVW4X        780
+
+/* VSX Vector Load and Splat Instruction */
+#define OP_31_XOP_LXVDSX        332
+
+/* VSX Vector Store Instructions */
+#define OP_31_XOP_STXVD2X       972
+#define OP_31_XOP_STXVW4X       908
+
+#define OP_31_XOP_LFSX          535
+#define OP_31_XOP_LFSUX         567
+#define OP_31_XOP_LFDX          599
+#define OP_31_XOP_LFDUX		631
 
 #define OP_LWZ  32
+#define OP_STFS 52
+#define OP_STFSU 53
+#define OP_STFD 54
+#define OP_STFDU 55
 #define OP_LD   58
 #define OP_LWZU 33
 #define OP_LBZ  34
@@ -127,6 +166,17 @@
 #define OP_LHAU 43
 #define OP_STH  44
 #define OP_STHU 45
+#define OP_LMW  46
+#define OP_STMW 47
+#define OP_LFS  48
+#define OP_LFSU 49
+#define OP_LFD  50
+#define OP_LFDU 51
+#define OP_STFS 52
+#define OP_STFSU 53
+#define OP_STFD  54
+#define OP_STFDU 55
+#define OP_LQ    56
 
 /* sorted alphabetically */
 #define PPC_INST_BHRBE			0x7c00025c
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index b87ccde..23dcb18 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -17,6 +17,7 @@ CFLAGS_emulate.o  := -I.
 CFLAGS_emulate_loadstore.o  := -I.
 
 common-objs-y += powerpc.o emulate_loadstore.o
+common-objs-$(CONFIG_PPC_FPU) += fpu.o
 obj-$(CONFIG_KVM_EXIT_TIMING) += timing.o
 obj-$(CONFIG_KVM_BOOK3S_HANDLER) += book3s_exports.o
 
@@ -101,7 +102,6 @@ kvm-objs-$(CONFIG_KVM_BOOK3S_64) := $(kvm-book3s_64-module-objs)
 kvm-book3s_32-objs := \
 	$(common-objs-y) \
 	emulate.o \
-	fpu.o \
 	book3s_paired_singles.o \
 	book3s.o \
 	book3s_pr.o \
diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index 6d3c0ee..9cda1b9 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -34,6 +34,30 @@
 #include "timing.h"
 #include "trace.h"
 
+#ifdef CONFIG_PPC_FPU
+static bool kvmppc_check_fp_disabled(struct kvm_vcpu *vcpu)
+{
+	if (!(kvmppc_get_msr(vcpu) & MSR_FP)) {
+		kvmppc_core_queue_fpunavail(vcpu);
+		return true;
+	}
+
+	return false;
+}
+#endif /* CONFIG_PPC_FPU */
+
+#ifdef CONFIG_VSX
+static bool kvmppc_check_vsx_disabled(struct kvm_vcpu *vcpu)
+{
+	if (!(kvmppc_get_msr(vcpu) & MSR_VSX)) {
+		kvmppc_core_queue_vsx_unavail(vcpu);
+		return true;
+	}
+
+	return false;
+}
+#endif /* CONFIG_VSX */
+
 /* XXX to do:
  * lhax
  * lhaux
@@ -66,6 +90,19 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 	rs = get_rs(inst);
 	rt = get_rt(inst);
 
+	/*
+	 * if mmio_vsx_tx_sx_enabled == 0, copy data between
+	 * VSR[0..31] and memory
+	 * if mmio_vsx_tx_sx_enabled == 1, copy data between
+	 * VSR[32..63] and memory
+	 */
+	vcpu->arch.mmio_vsx_tx_sx_enabled = get_tx_or_sx(inst);
+	vcpu->arch.mmio_vsx_copy_nums = 0;
+	vcpu->arch.mmio_vsx_offset = 0;
+	vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_NONE;
+	vcpu->arch.mmio_sp64_extend = 0;
+	vcpu->arch.mmio_sign_extend = 0;
+
 	switch (get_op(inst)) {
 	case 31:
 		switch (get_xop(inst)) {
@@ -157,6 +194,230 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 			                               2, 0);
 			break;
 
+		case OP_31_XOP_LDX:
+			emulated = kvmppc_handle_load(run, vcpu, rt, 8, 1);
+			break;
+
+		case OP_31_XOP_LDUX:
+			emulated = kvmppc_handle_load(run, vcpu, rt, 8, 1);
+			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
+			break;
+
+		case OP_31_XOP_LWAX:
+			emulated = kvmppc_handle_loads(run, vcpu, rt, 4, 1);
+			break;
+
+#ifdef CONFIG_PPC_FPU
+		case OP_31_XOP_LFSX:
+			if (kvmppc_check_fp_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_sp64_extend = 1;
+			emulated = kvmppc_handle_load(run, vcpu,
+				KVM_MMIO_REG_FPR|rt, 4, 1);
+			break;
+
+		case OP_31_XOP_LFSUX:
+			if (kvmppc_check_fp_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_sp64_extend = 1;
+			emulated = kvmppc_handle_load(run, vcpu,
+				KVM_MMIO_REG_FPR|rt, 4, 1);
+			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
+			break;
+
+		case OP_31_XOP_LFDX:
+			if (kvmppc_check_fp_disabled(vcpu))
+				return EMULATE_DONE;
+			emulated = kvmppc_handle_load(run, vcpu,
+				KVM_MMIO_REG_FPR|rt, 8, 1);
+			break;
+
+		case OP_31_XOP_LFDUX:
+			if (kvmppc_check_fp_disabled(vcpu))
+				return EMULATE_DONE;
+			emulated = kvmppc_handle_load(run, vcpu,
+				KVM_MMIO_REG_FPR|rt, 8, 1);
+			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
+			break;
+
+		case OP_31_XOP_STFSX:
+			if (kvmppc_check_fp_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_sp64_extend = 1;
+			emulated = kvmppc_handle_store(run, vcpu,
+				VCPU_FPR(vcpu, rs), 4, 1);
+			break;
+
+		case OP_31_XOP_STFSUX:
+			if (kvmppc_check_fp_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_sp64_extend = 1;
+			emulated = kvmppc_handle_store(run, vcpu,
+				VCPU_FPR(vcpu, rs), 4, 1);
+			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
+			break;
+
+		case OP_31_XOP_STFDX:
+			if (kvmppc_check_fp_disabled(vcpu))
+				return EMULATE_DONE;
+			emulated = kvmppc_handle_store(run, vcpu,
+				VCPU_FPR(vcpu, rs),
+		                               8, 1);
+			break;
+
+		case OP_31_XOP_STFDUX:
+			if (kvmppc_check_fp_disabled(vcpu))
+				return EMULATE_DONE;
+			emulated = kvmppc_handle_store(run, vcpu,
+				VCPU_FPR(vcpu, rs),
+		                               8, 1);
+			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
+			break;
+
+		case OP_31_XOP_STFIWX:
+			if (kvmppc_check_fp_disabled(vcpu))
+				return EMULATE_DONE;
+			emulated = kvmppc_handle_store(run, vcpu,
+				VCPU_FPR(vcpu, rs),
+		                               4, 1);
+			break;
+#endif
+
+#ifdef CONFIG_VSX
+		case OP_31_XOP_LXSDX:
+			if (kvmppc_check_vsx_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_vsx_copy_nums = 1;
+			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_DWORD;
+			emulated = kvmppc_handle_vsx_load(run, vcpu,
+				KVM_MMIO_REG_VSX|rt, 8, 1, 0);
+			break;
+
+		case OP_31_XOP_LXSSPX:
+			if (kvmppc_check_vsx_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_vsx_copy_nums = 1;
+			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_DWORD;
+			vcpu->arch.mmio_sp64_extend = 1;
+			emulated = kvmppc_handle_vsx_load(run, vcpu,
+				KVM_MMIO_REG_VSX|rt, 4, 1, 0);
+			break;
+
+		case OP_31_XOP_LXSIWAX:
+			if (kvmppc_check_vsx_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_vsx_copy_nums = 1;
+			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_DWORD;
+			emulated = kvmppc_handle_vsx_load(run, vcpu,
+				KVM_MMIO_REG_VSX|rt, 4, 1, 1);
+			break;
+
+		case OP_31_XOP_LXSIWZX:
+			if (kvmppc_check_vsx_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_vsx_copy_nums = 1;
+			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_DWORD;
+			emulated = kvmppc_handle_vsx_load(run, vcpu,
+				KVM_MMIO_REG_VSX|rt, 4, 1, 0);
+			break;
+
+		case OP_31_XOP_LXVD2X:
+		/*
+		 * In this case, the official load/store process is like this:
+		 * Step1, exit from vm by page fault isr, then kvm save vsr.
+		 * Please see guest_exit_cont->store_fp_state->SAVE_32VSRS
+		 * as reference.
+		 *
+		 * Step2, copy data between memory and VCPU
+		 * Notice: for LXVD2X/STXVD2X/LXVW4X/STXVW4X, we use
+		 * 2copies*8bytes or 4copies*4bytes
+		 * to simulate one copy of 16bytes.
+		 * Also there is an endian issue here, we should notice the
+		 * layout of memory.
+		 * Please see MARCO of LXVD2X_ROT/STXVD2X_ROT as more reference.
+		 * If host is little-endian, kvm will call XXSWAPD for
+		 * LXVD2X_ROT/STXVD2X_ROT.
+		 * So, if host is little-endian,
+		 * the postion of memeory should be swapped.
+		 *
+		 * Step3, return to guest, kvm reset register.
+		 * Please see kvmppc_hv_entry->load_fp_state->REST_32VSRS
+		 * as reference.
+		 */
+			if (kvmppc_check_vsx_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_vsx_copy_nums = 2;
+			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_DWORD;
+			emulated = kvmppc_handle_vsx_load(run, vcpu,
+				KVM_MMIO_REG_VSX|rt, 8, 1, 0);
+			break;
+
+		case OP_31_XOP_LXVW4X:
+			if (kvmppc_check_vsx_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_vsx_copy_nums = 4;
+			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_WORD;
+			emulated = kvmppc_handle_vsx_load(run, vcpu,
+				KVM_MMIO_REG_VSX|rt, 4, 1, 0);
+			break;
+
+		case OP_31_XOP_LXVDSX:
+			if (kvmppc_check_vsx_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_vsx_copy_nums = 1;
+			vcpu->arch.mmio_vsx_copy_type =
+				 KVMPPC_VSX_COPY_DWORD_LOAD_DUMP;
+			emulated = kvmppc_handle_vsx_load(run, vcpu,
+				KVM_MMIO_REG_VSX|rt, 8, 1, 0);
+			break;
+
+		case OP_31_XOP_STXSDX:
+			if (kvmppc_check_vsx_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_vsx_copy_nums = 1;
+			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_DWORD;
+			emulated = kvmppc_handle_vsx_store(run, vcpu,
+						 rs, 8, 1);
+			break;
+
+		case OP_31_XOP_STXSSPX:
+			if (kvmppc_check_vsx_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_vsx_copy_nums = 1;
+			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_DWORD;
+			vcpu->arch.mmio_sp64_extend = 1;
+			emulated = kvmppc_handle_vsx_store(run, vcpu,
+						 rs, 4, 1);
+			break;
+
+		case OP_31_XOP_STXSIWX:
+			if (kvmppc_check_vsx_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_vsx_offset = 1;
+			vcpu->arch.mmio_vsx_copy_nums = 1;
+			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_WORD;
+			emulated = kvmppc_handle_vsx_store(run, vcpu,
+							 rs, 4, 1);
+			break;
+
+		case OP_31_XOP_STXVD2X:
+			if (kvmppc_check_vsx_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_vsx_copy_nums = 2;
+			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_DWORD;
+			emulated = kvmppc_handle_vsx_store(run, vcpu,
+							 rs, 8, 1);
+			break;
+
+		case OP_31_XOP_STXVW4X:
+			if (kvmppc_check_vsx_disabled(vcpu))
+				return EMULATE_DONE;
+			vcpu->arch.mmio_vsx_copy_nums = 4;
+			vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_WORD;
+			emulated = kvmppc_handle_vsx_store(run, vcpu,
+							 rs, 4, 1);
+			break;
+#endif /* CONFIG_VSX */
 		default:
 			emulated = EMULATE_FAIL;
 			break;
@@ -167,7 +428,45 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 		emulated = kvmppc_handle_load(run, vcpu, rt, 4, 1);
 		break;
 
-	/* TBD: Add support for other 64 bit load variants like ldu, ldux, ldx etc. */
+#ifdef CONFIG_PPC_FPU
+	case OP_STFS:
+		if (kvmppc_check_fp_disabled(vcpu))
+			return EMULATE_DONE;
+		vcpu->arch.mmio_sp64_extend = 1;
+		emulated = kvmppc_handle_store(run, vcpu,
+			VCPU_FPR(vcpu, rs),
+			4, 1);
+		break;
+
+	case OP_STFSU:
+		if (kvmppc_check_fp_disabled(vcpu))
+			return EMULATE_DONE;
+		vcpu->arch.mmio_sp64_extend = 1;
+		emulated = kvmppc_handle_store(run, vcpu,
+			VCPU_FPR(vcpu, rs),
+			4, 1);
+		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
+		break;
+
+	case OP_STFD:
+		if (kvmppc_check_fp_disabled(vcpu))
+			return EMULATE_DONE;
+		emulated = kvmppc_handle_store(run, vcpu,
+			VCPU_FPR(vcpu, rs),
+	                               8, 1);
+		break;
+
+	case OP_STFDU:
+		if (kvmppc_check_fp_disabled(vcpu))
+			return EMULATE_DONE;
+		emulated = kvmppc_handle_store(run, vcpu,
+			VCPU_FPR(vcpu, rs),
+	                               8, 1);
+		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
+		break;
+#endif
+
+	/* TBD: Add support for other 64 bit load variants like ldu etc. */
 	case OP_LD:
 		rt = get_rt(inst);
 		emulated = kvmppc_handle_load(run, vcpu, rt, 8, 1);
@@ -252,6 +551,40 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 		break;
 
+#ifdef CONFIG_PPC_FPU
+	case OP_LFS:
+		if (kvmppc_check_fp_disabled(vcpu))
+			return EMULATE_DONE;
+		vcpu->arch.mmio_sp64_extend = 1;
+		emulated = kvmppc_handle_load(run, vcpu,
+			KVM_MMIO_REG_FPR|rt, 4, 1);
+		break;
+
+	case OP_LFSU:
+		if (kvmppc_check_fp_disabled(vcpu))
+			return EMULATE_DONE;
+		vcpu->arch.mmio_sp64_extend = 1;
+		emulated = kvmppc_handle_load(run, vcpu,
+			KVM_MMIO_REG_FPR|rt, 4, 1);
+		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
+		break;
+
+	case OP_LFD:
+		if (kvmppc_check_fp_disabled(vcpu))
+			return EMULATE_DONE;
+		emulated = kvmppc_handle_load(run, vcpu,
+			KVM_MMIO_REG_FPR|rt, 8, 1);
+		break;
+
+	case OP_LFDU:
+		if (kvmppc_check_fp_disabled(vcpu))
+			return EMULATE_DONE;
+		emulated = kvmppc_handle_load(run, vcpu,
+			KVM_MMIO_REG_FPR|rt, 8, 1);
+		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
+		break;
+#endif
+
 	default:
 		emulated = EMULATE_FAIL;
 		break;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 95c91a9..21c9aff 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -37,6 +37,8 @@
 #include <asm/cputhreads.h>
 #include <asm/irqflags.h>
 #include <asm/iommu.h>
+#include <asm/kvm_fpu.h>
+#include <asm/switch_to.h>
 #include "timing.h"
 #include "irq.h"
 #include "../mm/mmu_decl.h"
@@ -806,6 +808,127 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 		kvm->arch.kvm_ops->irq_bypass_del_producer(cons, prod);
 }
 
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
+static inline int kvmppc_get_vsr_word_offset(int index)
+{
+	int offset;
+
+	if ((index > 3) || (index < 0))
+		return -1;
+
+#ifdef __BIG_ENDIAN
+	offset = index;
+#else
+	offset = 3 - index;
+#endif
+	return offset;
+}
+
+static inline void kvmppc_set_vsr_dword(struct kvm_vcpu *vcpu,
+	u64 gpr)
+{
+	union kvmppc_one_reg val;
+	int offset = kvmppc_get_vsr_dword_offset(vcpu->arch.mmio_vsx_offset);
+	int index = vcpu->arch.io_gpr & KVM_MMIO_REG_MASK;
+
+	if (offset == -1)
+		return;
+
+	if (vcpu->arch.mmio_vsx_tx_sx_enabled) {
+		val.vval = VCPU_VSX_VR(vcpu, index);
+		val.vsxval[offset] = gpr;
+		VCPU_VSX_VR(vcpu, index) = val.vval;
+	} else {
+		VCPU_VSX_FPR(vcpu, index, offset) = gpr;
+	}
+}
+
+static inline void kvmppc_set_vsr_dword_dump(struct kvm_vcpu *vcpu,
+	u64 gpr)
+{
+	union kvmppc_one_reg val;
+	int index = vcpu->arch.io_gpr & KVM_MMIO_REG_MASK;
+
+	if (vcpu->arch.mmio_vsx_tx_sx_enabled) {
+		val.vval = VCPU_VSX_VR(vcpu, index);
+		val.vsxval[0] = gpr;
+		val.vsxval[1] = gpr;
+		VCPU_VSX_VR(vcpu, index) = val.vval;
+	} else {
+		VCPU_VSX_FPR(vcpu, index, 0) = gpr;
+		VCPU_VSX_FPR(vcpu, index, 1) = gpr;
+	}
+}
+
+static inline void kvmppc_set_vsr_word(struct kvm_vcpu *vcpu,
+	u32 gpr32)
+{
+	union kvmppc_one_reg val;
+	int offset = kvmppc_get_vsr_word_offset(vcpu->arch.mmio_vsx_offset);
+	int index = vcpu->arch.io_gpr & KVM_MMIO_REG_MASK;
+	int dword_offset, word_offset;
+
+	if (offset == -1)
+		return;
+
+	if (vcpu->arch.mmio_vsx_tx_sx_enabled) {
+		val.vval = VCPU_VSX_VR(vcpu, index);
+		val.vsx32val[offset] = gpr32;
+		VCPU_VSX_VR(vcpu, index) = val.vval;
+	} else {
+		dword_offset = offset / 2;
+		word_offset = offset % 2;
+		val.vsxval[0] = VCPU_VSX_FPR(vcpu, index, dword_offset);
+		val.vsx32val[word_offset] = gpr32;
+		VCPU_VSX_FPR(vcpu, index, dword_offset) = val.vsxval[0];
+	}
+}
+#endif /* CONFIG_VSX */
+
+#ifdef CONFIG_PPC_FPU
+static inline u64 sp_to_dp(u32 fprs)
+{
+	u64 fprd;
+
+	preempt_disable();
+	enable_kernel_fp();
+	kvm_cvt_fd(&fprs, &fprd);
+	preempt_enable();
+	return fprd;
+}
+
+static inline u32 dp_to_sp(u64 fprd)
+{
+	u32 fprs;
+
+	preempt_disable();
+	enable_kernel_fp();
+	kvm_cvt_df(&fprd, &fprs);
+	preempt_enable();
+	return fprs;
+}
+
+#else
+#define sp_to_dp(x)	(x)
+#define dp_to_sp(x)	(x)
+#endif /* CONFIG_PPC_FPU */
+
 static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
                                       struct kvm_run *run)
 {
@@ -832,6 +955,10 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
 		}
 	}
 
+	/* conversion between single and double precision */
+	if ((vcpu->arch.mmio_sp64_extend) && (run->mmio.len == 4))
+		gpr = sp_to_dp(gpr);
+
 	if (vcpu->arch.mmio_sign_extend) {
 		switch (run->mmio.len) {
 #ifdef CONFIG_PPC64
@@ -848,8 +975,6 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
 		}
 	}
 
-	kvmppc_set_gpr(vcpu, vcpu->arch.io_gpr, gpr);
-
 	switch (vcpu->arch.io_gpr & KVM_MMIO_REG_EXT_MASK) {
 	case KVM_MMIO_REG_GPR:
 		kvmppc_set_gpr(vcpu, vcpu->arch.io_gpr, gpr);
@@ -866,6 +991,17 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
 		vcpu->arch.qpr[vcpu->arch.io_gpr & KVM_MMIO_REG_MASK] = gpr;
 		break;
 #endif
+#ifdef CONFIG_VSX
+	case KVM_MMIO_REG_VSX:
+		if (vcpu->arch.mmio_vsx_copy_type == KVMPPC_VSX_COPY_DWORD)
+			kvmppc_set_vsr_dword(vcpu, gpr);
+		else if (vcpu->arch.mmio_vsx_copy_type == KVMPPC_VSX_COPY_WORD)
+			kvmppc_set_vsr_word(vcpu, gpr);
+		else if (vcpu->arch.mmio_vsx_copy_type ==
+				KVMPPC_VSX_COPY_DWORD_LOAD_DUMP)
+			kvmppc_set_vsr_dword_dump(vcpu, gpr);
+		break;
+#endif
 	default:
 		BUG();
 	}
@@ -932,6 +1068,35 @@ int kvmppc_handle_loads(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return __kvmppc_handle_load(run, vcpu, rt, bytes, is_default_endian, 1);
 }
 
+#ifdef CONFIG_VSX
+int kvmppc_handle_vsx_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
+			unsigned int rt, unsigned int bytes,
+			int is_default_endian, int mmio_sign_extend)
+{
+	enum emulation_result emulated = EMULATE_DONE;
+
+	/* Currently, mmio_vsx_copy_nums only allowed to be less than 4 */
+	if ( (vcpu->arch.mmio_vsx_copy_nums > 4) ||
+		(vcpu->arch.mmio_vsx_copy_nums < 0) ) {
+		return EMULATE_FAIL;
+	}
+
+	while (vcpu->arch.mmio_vsx_copy_nums) {
+		emulated = __kvmppc_handle_load(run, vcpu, rt, bytes,
+			is_default_endian, mmio_sign_extend);
+
+		if (emulated != EMULATE_DONE)
+			break;
+
+		vcpu->arch.paddr_accessed += run->mmio.len;
+
+		vcpu->arch.mmio_vsx_copy_nums--;
+		vcpu->arch.mmio_vsx_offset++;
+	}
+	return emulated;
+}
+#endif /* CONFIG_VSX */
+
 int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			u64 val, unsigned int bytes, int is_default_endian)
 {
@@ -957,6 +1122,9 @@ int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	vcpu->mmio_needed = 1;
 	vcpu->mmio_is_write = 1;
 
+	if ((vcpu->arch.mmio_sp64_extend) && (bytes == 4))
+		val = dp_to_sp(val);
+
 	/* Store the value at the lowest bytes in 'data'. */
 	if (!host_swabbed) {
 		switch (bytes) {
@@ -990,6 +1158,129 @@ int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
 }
 EXPORT_SYMBOL_GPL(kvmppc_handle_store);
 
+#ifdef CONFIG_VSX
+static inline int kvmppc_get_vsr_data(struct kvm_vcpu *vcpu, int rs, u64 *val)
+{
+	u32 dword_offset, word_offset;
+	union kvmppc_one_reg reg;
+	int vsx_offset = 0;
+	int copy_type = vcpu->arch.mmio_vsx_copy_type;
+	int result = 0;
+
+	switch (copy_type) {
+	case KVMPPC_VSX_COPY_DWORD:
+		vsx_offset =
+			kvmppc_get_vsr_dword_offset(vcpu->arch.mmio_vsx_offset);
+
+		if (vsx_offset == -1) {
+			result = -1;
+			break;
+		}
+
+		if (!vcpu->arch.mmio_vsx_tx_sx_enabled) {
+			*val = VCPU_VSX_FPR(vcpu, rs, vsx_offset);
+		} else {
+			reg.vval = VCPU_VSX_VR(vcpu, rs);
+			*val = reg.vsxval[vsx_offset];
+		}
+		break;
+
+	case KVMPPC_VSX_COPY_WORD:
+		vsx_offset =
+			kvmppc_get_vsr_word_offset(vcpu->arch.mmio_vsx_offset);
+
+		if (vsx_offset == -1) {
+			result = -1;
+			break;
+		}
+
+		if (!vcpu->arch.mmio_vsx_tx_sx_enabled) {
+			dword_offset = vsx_offset / 2;
+			word_offset = vsx_offset % 2;
+			reg.vsxval[0] = VCPU_VSX_FPR(vcpu, rs, dword_offset);
+			*val = reg.vsx32val[word_offset];
+		} else {
+			reg.vval = VCPU_VSX_VR(vcpu, rs);
+			*val = reg.vsx32val[vsx_offset];
+		}
+		break;
+
+	default:
+		result = -1;
+		break;
+	}
+
+	return result;
+}
+
+int kvmppc_handle_vsx_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
+			int rs, unsigned int bytes, int is_default_endian)
+{
+	u64 val;
+	enum emulation_result emulated = EMULATE_DONE;
+
+	vcpu->arch.io_gpr = rs;
+
+	/* Currently, mmio_vsx_copy_nums only allowed to be less than 4 */
+	if ( (vcpu->arch.mmio_vsx_copy_nums > 4) ||
+		(vcpu->arch.mmio_vsx_copy_nums < 0) ) {
+		return EMULATE_FAIL;
+	}
+
+	while (vcpu->arch.mmio_vsx_copy_nums) {
+		if (kvmppc_get_vsr_data(vcpu, rs, &val) == -1)
+			return EMULATE_FAIL;
+
+		emulated = kvmppc_handle_store(run, vcpu,
+			 val, bytes, is_default_endian);
+
+		if (emulated != EMULATE_DONE)
+			break;
+
+		vcpu->arch.paddr_accessed += run->mmio.len;
+
+		vcpu->arch.mmio_vsx_copy_nums--;
+		vcpu->arch.mmio_vsx_offset++;
+	}
+
+	return emulated;
+}
+
+static int kvmppc_emulate_mmio_vsx_loadstore(struct kvm_vcpu *vcpu,
+			struct kvm_run *run)
+{
+	enum emulation_result emulated = EMULATE_FAIL;
+	int r;
+
+	vcpu->arch.paddr_accessed += run->mmio.len;
+
+	if (!vcpu->mmio_is_write) {
+		emulated = kvmppc_handle_vsx_load(run, vcpu, vcpu->arch.io_gpr,
+			 run->mmio.len, 1, vcpu->arch.mmio_sign_extend);
+	} else {
+		emulated = kvmppc_handle_vsx_store(run, vcpu,
+			 vcpu->arch.io_gpr, run->mmio.len, 1);
+	}
+
+	switch (emulated) {
+	case EMULATE_DO_MMIO:
+		run->exit_reason = KVM_EXIT_MMIO;
+		r = RESUME_HOST;
+		break;
+	case EMULATE_FAIL:
+		pr_info("KVM: MMIO emulation failed (VSX repeat)\n");
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
+#endif /* CONFIG_VSX */
+
 int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 {
 	int r = 0;
@@ -1092,13 +1383,24 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	int r;
 	sigset_t sigsaved;
 
-	if (vcpu->sigset_active)
-		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
-
 	if (vcpu->mmio_needed) {
+		vcpu->mmio_needed = 0;
 		if (!vcpu->mmio_is_write)
 			kvmppc_complete_mmio_load(vcpu, run);
-		vcpu->mmio_needed = 0;
+#ifdef CONFIG_VSX
+		if (vcpu->arch.mmio_vsx_copy_nums > 0) {
+			vcpu->arch.mmio_vsx_copy_nums--;
+			vcpu->arch.mmio_vsx_offset++;
+		}
+
+		if (vcpu->arch.mmio_vsx_copy_nums > 0) {
+			r = kvmppc_emulate_mmio_vsx_loadstore(vcpu, run);
+			if (r == RESUME_HOST) {
+				vcpu->mmio_needed = 1;
+				return r;
+			}
+		}
+#endif
 	} else if (vcpu->arch.osi_needed) {
 		u64 *gprs = run->osi.gprs;
 		int i;
@@ -1120,6 +1422,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 #endif
 	}
 
+	if (vcpu->sigset_active)
+		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
+
 	if (run->immediate_exit)
 		r = -EINTR;
 	else
-- 
2.7.4
