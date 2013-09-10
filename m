Return-Path: <paulus@ozlabs.org>
Date: Tue, 10 Sep 2013 20:21:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/6] KVM: PPC: Store FP/VSX/VMX state in thread_fp/vr_state
 structures
Message-ID: <20130910102158.GE28145@iris.ozlabs.ibm.com>
References: <20130910102000.GA28145@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130910102000.GA28145@iris.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This uses struct thread_fp_state and struct thread_vr_state to store
the floating-point, VMX/Altivec and VSX state, rather than flat arrays.
This makes transferring the state to/from the thread_struct simpler
and allows us to unify the get/set_one_reg implementations for the
VSX registers.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_host.h      |  12 +--
 arch/powerpc/kernel/asm-offsets.c        |  11 +-
 arch/powerpc/kvm/book3s.c                |  38 +++++--
 arch/powerpc/kvm/book3s_hv.c             |  42 --------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |   4 +-
 arch/powerpc/kvm/book3s_paired_singles.c | 169 +++++++++++++++----------------
 arch/powerpc/kvm/book3s_pr.c             |  63 +-----------
 arch/powerpc/kvm/booke.c                 |   8 +-
 arch/powerpc/kvm/powerpc.c               |   4 +-
 9 files changed, 131 insertions(+), 220 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 3328353..e2a2a81 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -406,8 +406,7 @@ struct kvm_vcpu_arch {
 
 	ulong gpr[32];
 
-	u64 fpr[32];
-	u64 fpscr;
+	struct thread_fp_state fp;
 
 #ifdef CONFIG_SPE
 	ulong evr[32];
@@ -416,12 +415,7 @@ struct kvm_vcpu_arch {
 	u64 acc;
 #endif
 #ifdef CONFIG_ALTIVEC
-	vector128 vr[32];
-	vector128 vscr;
-#endif
-
-#ifdef CONFIG_VSX
-	u64 vsr[64];
+	struct thread_vr_state vr;
 #endif
 
 #ifdef CONFIG_KVM_BOOKE_HV
@@ -608,6 +602,8 @@ struct kvm_vcpu_arch {
 #endif
 };
 
+#define VCPU_FPR(vcpu, i)	(vcpu)->arch.fp.fpr[i][TS_FPROFFSET]
+
 /* Values for vcpu->arch.state */
 #define KVMPPC_VCPU_NOTREADY		0
 #define KVMPPC_VCPU_RUNNABLE		1
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 9049197..4c1609f 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -424,14 +424,11 @@ int main(void)
 	DEFINE(VCPU_GUEST_PID, offsetof(struct kvm_vcpu, arch.pid));
 	DEFINE(VCPU_GPRS, offsetof(struct kvm_vcpu, arch.gpr));
 	DEFINE(VCPU_VRSAVE, offsetof(struct kvm_vcpu, arch.vrsave));
-	DEFINE(VCPU_FPRS, offsetof(struct kvm_vcpu, arch.fpr));
-	DEFINE(VCPU_FPSCR, offsetof(struct kvm_vcpu, arch.fpscr));
+	DEFINE(VCPU_FPRS, offsetof(struct kvm_vcpu, arch.fp.fpr));
+	DEFINE(VCPU_FPSCR, offsetof(struct kvm_vcpu, arch.fp.fpscr));
 #ifdef CONFIG_ALTIVEC
-	DEFINE(VCPU_VRS, offsetof(struct kvm_vcpu, arch.vr));
-	DEFINE(VCPU_VSCR, offsetof(struct kvm_vcpu, arch.vscr));
-#endif
-#ifdef CONFIG_VSX
-	DEFINE(VCPU_VSRS, offsetof(struct kvm_vcpu, arch.vsr));
+	DEFINE(VCPU_VRS, offsetof(struct kvm_vcpu, arch.vr.vr));
+	DEFINE(VCPU_VSCR, offsetof(struct kvm_vcpu, arch.vr.vscr));
 #endif
 	DEFINE(VCPU_XER, offsetof(struct kvm_vcpu, arch.xer));
 	DEFINE(VCPU_CTR, offsetof(struct kvm_vcpu, arch.ctr));
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 700df6f..6ca11a3 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -508,10 +508,10 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 			break;
 		case KVM_REG_PPC_FPR0 ... KVM_REG_PPC_FPR31:
 			i = reg->id - KVM_REG_PPC_FPR0;
-			val = get_reg_val(reg->id, vcpu->arch.fpr[i]);
+			val = get_reg_val(reg->id, VCPU_FPR(vcpu, i));
 			break;
 		case KVM_REG_PPC_FPSCR:
-			val = get_reg_val(reg->id, vcpu->arch.fpscr);
+			val = get_reg_val(reg->id, vcpu->arch.fp.fpscr);
 			break;
 #ifdef CONFIG_ALTIVEC
 		case KVM_REG_PPC_VR0 ... KVM_REG_PPC_VR31:
@@ -519,16 +519,27 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 				r = -ENXIO;
 				break;
 			}
-			val.vval = vcpu->arch.vr[reg->id - KVM_REG_PPC_VR0];
+			val.vval = vcpu->arch.vr.vr[reg->id - KVM_REG_PPC_VR0];
 			break;
 		case KVM_REG_PPC_VSCR:
 			if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
 				r = -ENXIO;
 				break;
 			}
-			val = get_reg_val(reg->id, vcpu->arch.vscr.u[3]);
+			val = get_reg_val(reg->id, vcpu->arch.vr.vscr.u[3]);
 			break;
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_VSX
+		case KVM_REG_PPC_VSR0 ... KVM_REG_PPC_VSR31:
+			if (cpu_has_feature(CPU_FTR_VSX)) {
+				long int i = reg->id - KVM_REG_PPC_VSR0;
+				val.vsxval[0] = vcpu->arch.fp.fpr[i][0];
+				val.vsxval[1] = vcpu->arch.fp.fpr[i][1];
+			} else {
+				r = -ENXIO;
+			}
+			break;
+#endif /* CONFIG_VSX */
 		case KVM_REG_PPC_DEBUG_INST: {
 			u32 opcode = INS_TW;
 			r = copy_to_user((u32 __user *)(long)reg->addr,
@@ -585,10 +596,10 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 			break;
 		case KVM_REG_PPC_FPR0 ... KVM_REG_PPC_FPR31:
 			i = reg->id - KVM_REG_PPC_FPR0;
-			vcpu->arch.fpr[i] = set_reg_val(reg->id, val);
+			VCPU_FPR(vcpu, i) = set_reg_val(reg->id, val);
 			break;
 		case KVM_REG_PPC_FPSCR:
-			vcpu->arch.fpscr = set_reg_val(reg->id, val);
+			vcpu->arch.fp.fpscr = set_reg_val(reg->id, val);
 			break;
 #ifdef CONFIG_ALTIVEC
 		case KVM_REG_PPC_VR0 ... KVM_REG_PPC_VR31:
@@ -596,16 +607,27 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 				r = -ENXIO;
 				break;
 			}
-			vcpu->arch.vr[reg->id - KVM_REG_PPC_VR0] = val.vval;
+			vcpu->arch.vr.vr[reg->id - KVM_REG_PPC_VR0] = val.vval;
 			break;
 		case KVM_REG_PPC_VSCR:
 			if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
 				r = -ENXIO;
 				break;
 			}
-			vcpu->arch.vscr.u[3] = set_reg_val(reg->id, val);
+			vcpu->arch.vr.vscr.u[3] = set_reg_val(reg->id, val);
 			break;
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_VSX
+		case KVM_REG_PPC_VSR0 ... KVM_REG_PPC_VSR31:
+			if (cpu_has_feature(CPU_FTR_VSX)) {
+				long int i = reg->id - KVM_REG_PPC_VSR0;
+				vcpu->arch.fp.fpr[i][0] = val.vsxval[0];
+				vcpu->arch.fp.fpr[i][1] = val.vsxval[1];
+			} else {
+				r = -ENXIO;
+			}
+			break;
+#endif /* CONFIG_VSX */
 #ifdef CONFIG_KVM_XICS
 		case KVM_REG_PPC_ICP_STATE:
 			if (!vcpu->arch.icp) {
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 62a2b5a..9a849e4 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -749,27 +749,6 @@ int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id, union kvmppc_one_reg *val)
 		i = id - KVM_REG_PPC_PMC1;
 		*val = get_reg_val(id, vcpu->arch.pmc[i]);
 		break;
-#ifdef CONFIG_VSX
-	case KVM_REG_PPC_FPR0 ... KVM_REG_PPC_FPR31:
-		if (cpu_has_feature(CPU_FTR_VSX)) {
-			/* VSX => FP reg i is stored in arch.vsr[2*i] */
-			long int i = id - KVM_REG_PPC_FPR0;
-			*val = get_reg_val(id, vcpu->arch.vsr[2 * i]);
-		} else {
-			/* let generic code handle it */
-			r = -EINVAL;
-		}
-		break;
-	case KVM_REG_PPC_VSR0 ... KVM_REG_PPC_VSR31:
-		if (cpu_has_feature(CPU_FTR_VSX)) {
-			long int i = id - KVM_REG_PPC_VSR0;
-			val->vsxval[0] = vcpu->arch.vsr[2 * i];
-			val->vsxval[1] = vcpu->arch.vsr[2 * i + 1];
-		} else {
-			r = -ENXIO;
-		}
-		break;
-#endif /* CONFIG_VSX */
 	case KVM_REG_PPC_VPA_ADDR:
 		spin_lock(&vcpu->arch.vpa_update_lock);
 		*val = get_reg_val(id, vcpu->arch.vpa.next_gpa);
@@ -833,27 +812,6 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id, union kvmppc_one_reg *val)
 		i = id - KVM_REG_PPC_PMC1;
 		vcpu->arch.pmc[i] = set_reg_val(id, *val);
 		break;
-#ifdef CONFIG_VSX
-	case KVM_REG_PPC_FPR0 ... KVM_REG_PPC_FPR31:
-		if (cpu_has_feature(CPU_FTR_VSX)) {
-			/* VSX => FP reg i is stored in arch.vsr[2*i] */
-			long int i = id - KVM_REG_PPC_FPR0;
-			vcpu->arch.vsr[2 * i] = set_reg_val(id, *val);
-		} else {
-			/* let generic code handle it */
-			r = -EINVAL;
-		}
-		break;
-	case KVM_REG_PPC_VSR0 ... KVM_REG_PPC_VSR31:
-		if (cpu_has_feature(CPU_FTR_VSX)) {
-			long int i = id - KVM_REG_PPC_VSR0;
-			vcpu->arch.vsr[2 * i] = val->vsxval[0];
-			vcpu->arch.vsr[2 * i + 1] = val->vsxval[1];
-		} else {
-			r = -ENXIO;
-		}
-		break;
-#endif /* CONFIG_VSX */
 	case KVM_REG_PPC_VPA_ADDR:
 		addr = set_reg_val(id, *val);
 		r = -EINVAL;
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 294b7af..f5f2396 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1786,7 +1786,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 BEGIN_FTR_SECTION
 	reg = 0
 	.rept	32
-	li	r6,reg*16+VCPU_VSRS
+	li	r6,reg*16+VCPU_FPRS
 	STXVD2X(reg,R6,R3)
 	reg = reg + 1
 	.endr
@@ -1848,7 +1848,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 BEGIN_FTR_SECTION
 	reg = 0
 	.rept	32
-	li	r7,reg*16+VCPU_VSRS
+	li	r7,reg*16+VCPU_FPRS
 	LXVD2X(reg,R7,R4)
 	reg = reg + 1
 	.endr
diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
index a59a25a..c1abd95 100644
--- a/arch/powerpc/kvm/book3s_paired_singles.c
+++ b/arch/powerpc/kvm/book3s_paired_singles.c
@@ -160,7 +160,7 @@
 
 static inline void kvmppc_sync_qpr(struct kvm_vcpu *vcpu, int rt)
 {
-	kvm_cvt_df(&vcpu->arch.fpr[rt], &vcpu->arch.qpr[rt]);
+	kvm_cvt_df(&VCPU_FPR(vcpu, rt), &vcpu->arch.qpr[rt]);
 }
 
 static void kvmppc_inject_pf(struct kvm_vcpu *vcpu, ulong eaddr, bool is_store)
@@ -207,11 +207,11 @@ static int kvmppc_emulate_fpr_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	/* put in registers */
 	switch (ls_type) {
 	case FPU_LS_SINGLE:
-		kvm_cvt_fd((u32*)tmp, &vcpu->arch.fpr[rs]);
+		kvm_cvt_fd((u32*)tmp, &VCPU_FPR(vcpu, rs));
 		vcpu->arch.qpr[rs] = *((u32*)tmp);
 		break;
 	case FPU_LS_DOUBLE:
-		vcpu->arch.fpr[rs] = *((u64*)tmp);
+		VCPU_FPR(vcpu, rs) = *((u64*)tmp);
 		break;
 	}
 
@@ -233,18 +233,18 @@ static int kvmppc_emulate_fpr_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 	switch (ls_type) {
 	case FPU_LS_SINGLE:
-		kvm_cvt_df(&vcpu->arch.fpr[rs], (u32*)tmp);
+		kvm_cvt_df(&VCPU_FPR(vcpu, rs), (u32*)tmp);
 		val = *((u32*)tmp);
 		len = sizeof(u32);
 		break;
 	case FPU_LS_SINGLE_LOW:
-		*((u32*)tmp) = vcpu->arch.fpr[rs];
-		val = vcpu->arch.fpr[rs] & 0xffffffff;
+		*((u32*)tmp) = VCPU_FPR(vcpu, rs);
+		val = VCPU_FPR(vcpu, rs) & 0xffffffff;
 		len = sizeof(u32);
 		break;
 	case FPU_LS_DOUBLE:
-		*((u64*)tmp) = vcpu->arch.fpr[rs];
-		val = vcpu->arch.fpr[rs];
+		*((u64*)tmp) = VCPU_FPR(vcpu, rs);
+		val = VCPU_FPR(vcpu, rs);
 		len = sizeof(u64);
 		break;
 	default:
@@ -301,7 +301,7 @@ static int kvmppc_emulate_psq_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	emulated = EMULATE_DONE;
 
 	/* put in registers */
-	kvm_cvt_fd(&tmp[0], &vcpu->arch.fpr[rs]);
+	kvm_cvt_fd(&tmp[0], &VCPU_FPR(vcpu, rs));
 	vcpu->arch.qpr[rs] = tmp[1];
 
 	dprintk(KERN_INFO "KVM: PSQ_LD [0x%x, 0x%x] at 0x%lx (%d)\n", tmp[0],
@@ -319,7 +319,7 @@ static int kvmppc_emulate_psq_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	u32 tmp[2];
 	int len = w ? sizeof(u32) : sizeof(u64);
 
-	kvm_cvt_df(&vcpu->arch.fpr[rs], &tmp[0]);
+	kvm_cvt_df(&VCPU_FPR(vcpu, rs), &tmp[0]);
 	tmp[1] = vcpu->arch.qpr[rs];
 
 	r = kvmppc_st(vcpu, &addr, len, tmp, true);
@@ -512,7 +512,6 @@ static int kvmppc_ps_three_in(struct kvm_vcpu *vcpu, bool rc,
 						 u32 *src2, u32 *src3))
 {
 	u32 *qpr = vcpu->arch.qpr;
-	u64 *fpr = vcpu->arch.fpr;
 	u32 ps0_out;
 	u32 ps0_in1, ps0_in2, ps0_in3;
 	u32 ps1_in1, ps1_in2, ps1_in3;
@@ -521,20 +520,20 @@ static int kvmppc_ps_three_in(struct kvm_vcpu *vcpu, bool rc,
 	WARN_ON(rc);
 
 	/* PS0 */
-	kvm_cvt_df(&fpr[reg_in1], &ps0_in1);
-	kvm_cvt_df(&fpr[reg_in2], &ps0_in2);
-	kvm_cvt_df(&fpr[reg_in3], &ps0_in3);
+	kvm_cvt_df(&VCPU_FPR(vcpu, reg_in1), &ps0_in1);
+	kvm_cvt_df(&VCPU_FPR(vcpu, reg_in2), &ps0_in2);
+	kvm_cvt_df(&VCPU_FPR(vcpu, reg_in3), &ps0_in3);
 
 	if (scalar & SCALAR_LOW)
 		ps0_in2 = qpr[reg_in2];
 
-	func(&vcpu->arch.fpscr, &ps0_out, &ps0_in1, &ps0_in2, &ps0_in3);
+	func(&vcpu->arch.fp.fpscr, &ps0_out, &ps0_in1, &ps0_in2, &ps0_in3);
 
 	dprintk(KERN_INFO "PS3 ps0 -> f(0x%x, 0x%x, 0x%x) = 0x%x\n",
 			  ps0_in1, ps0_in2, ps0_in3, ps0_out);
 
 	if (!(scalar & SCALAR_NO_PS0))
-		kvm_cvt_fd(&ps0_out, &fpr[reg_out]);
+		kvm_cvt_fd(&ps0_out, &VCPU_FPR(vcpu, reg_out));
 
 	/* PS1 */
 	ps1_in1 = qpr[reg_in1];
@@ -545,7 +544,7 @@ static int kvmppc_ps_three_in(struct kvm_vcpu *vcpu, bool rc,
 		ps1_in2 = ps0_in2;
 
 	if (!(scalar & SCALAR_NO_PS1))
-		func(&vcpu->arch.fpscr, &qpr[reg_out], &ps1_in1, &ps1_in2, &ps1_in3);
+		func(&vcpu->arch.fp.fpscr, &qpr[reg_out], &ps1_in1, &ps1_in2, &ps1_in3);
 
 	dprintk(KERN_INFO "PS3 ps1 -> f(0x%x, 0x%x, 0x%x) = 0x%x\n",
 			  ps1_in1, ps1_in2, ps1_in3, qpr[reg_out]);
@@ -561,7 +560,6 @@ static int kvmppc_ps_two_in(struct kvm_vcpu *vcpu, bool rc,
 						 u32 *src2))
 {
 	u32 *qpr = vcpu->arch.qpr;
-	u64 *fpr = vcpu->arch.fpr;
 	u32 ps0_out;
 	u32 ps0_in1, ps0_in2;
 	u32 ps1_out;
@@ -571,20 +569,20 @@ static int kvmppc_ps_two_in(struct kvm_vcpu *vcpu, bool rc,
 	WARN_ON(rc);
 
 	/* PS0 */
-	kvm_cvt_df(&fpr[reg_in1], &ps0_in1);
+	kvm_cvt_df(&VCPU_FPR(vcpu, reg_in1), &ps0_in1);
 
 	if (scalar & SCALAR_LOW)
 		ps0_in2 = qpr[reg_in2];
 	else
-		kvm_cvt_df(&fpr[reg_in2], &ps0_in2);
+		kvm_cvt_df(&VCPU_FPR(vcpu, reg_in2), &ps0_in2);
 
-	func(&vcpu->arch.fpscr, &ps0_out, &ps0_in1, &ps0_in2);
+	func(&vcpu->arch.fp.fpscr, &ps0_out, &ps0_in1, &ps0_in2);
 
 	if (!(scalar & SCALAR_NO_PS0)) {
 		dprintk(KERN_INFO "PS2 ps0 -> f(0x%x, 0x%x) = 0x%x\n",
 				  ps0_in1, ps0_in2, ps0_out);
 
-		kvm_cvt_fd(&ps0_out, &fpr[reg_out]);
+		kvm_cvt_fd(&ps0_out, &VCPU_FPR(vcpu, reg_out));
 	}
 
 	/* PS1 */
@@ -594,7 +592,7 @@ static int kvmppc_ps_two_in(struct kvm_vcpu *vcpu, bool rc,
 	if (scalar & SCALAR_HIGH)
 		ps1_in2 = ps0_in2;
 
-	func(&vcpu->arch.fpscr, &ps1_out, &ps1_in1, &ps1_in2);
+	func(&vcpu->arch.fp.fpscr, &ps1_out, &ps1_in1, &ps1_in2);
 
 	if (!(scalar & SCALAR_NO_PS1)) {
 		qpr[reg_out] = ps1_out;
@@ -612,7 +610,6 @@ static int kvmppc_ps_one_in(struct kvm_vcpu *vcpu, bool rc,
 						 u32 *dst, u32 *src1))
 {
 	u32 *qpr = vcpu->arch.qpr;
-	u64 *fpr = vcpu->arch.fpr;
 	u32 ps0_out, ps0_in;
 	u32 ps1_in;
 
@@ -620,17 +617,17 @@ static int kvmppc_ps_one_in(struct kvm_vcpu *vcpu, bool rc,
 	WARN_ON(rc);
 
 	/* PS0 */
-	kvm_cvt_df(&fpr[reg_in], &ps0_in);
-	func(&vcpu->arch.fpscr, &ps0_out, &ps0_in);
+	kvm_cvt_df(&VCPU_FPR(vcpu, reg_in), &ps0_in);
+	func(&vcpu->arch.fp.fpscr, &ps0_out, &ps0_in);
 
 	dprintk(KERN_INFO "PS1 ps0 -> f(0x%x) = 0x%x\n",
 			  ps0_in, ps0_out);
 
-	kvm_cvt_fd(&ps0_out, &fpr[reg_out]);
+	kvm_cvt_fd(&ps0_out, &VCPU_FPR(vcpu, reg_out));
 
 	/* PS1 */
 	ps1_in = qpr[reg_in];
-	func(&vcpu->arch.fpscr, &qpr[reg_out], &ps1_in);
+	func(&vcpu->arch.fp.fpscr, &qpr[reg_out], &ps1_in);
 
 	dprintk(KERN_INFO "PS1 ps1 -> f(0x%x) = 0x%x\n",
 			  ps1_in, qpr[reg_out]);
@@ -649,10 +646,10 @@ int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	int ax_rc = inst_get_field(inst, 21, 25);
 	short full_d = inst_get_field(inst, 16, 31);
 
-	u64 *fpr_d = &vcpu->arch.fpr[ax_rd];
-	u64 *fpr_a = &vcpu->arch.fpr[ax_ra];
-	u64 *fpr_b = &vcpu->arch.fpr[ax_rb];
-	u64 *fpr_c = &vcpu->arch.fpr[ax_rc];
+	u64 *fpr_d = &VCPU_FPR(vcpu, ax_rd);
+	u64 *fpr_a = &VCPU_FPR(vcpu, ax_ra);
+	u64 *fpr_b = &VCPU_FPR(vcpu, ax_rb);
+	u64 *fpr_c = &VCPU_FPR(vcpu, ax_rc);
 
 	bool rcomp = (inst & 1) ? true : false;
 	u32 cr = kvmppc_get_cr(vcpu);
@@ -674,11 +671,11 @@ int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	/* Do we need to clear FE0 / FE1 here? Don't think so. */
 
 #ifdef DEBUG
-	for (i = 0; i < ARRAY_SIZE(vcpu->arch.fpr); i++) {
+	for (i = 0; i < ARRAY_SIZE(vcpu->arch.fp.fpr); i++) {
 		u32 f;
-		kvm_cvt_df(&vcpu->arch.fpr[i], &f);
+		kvm_cvt_df(&VCPU_FPR(vcpu, i), &f);
 		dprintk(KERN_INFO "FPR[%d] = 0x%x / 0x%llx    QPR[%d] = 0x%x\n",
-			i, f, vcpu->arch.fpr[i], i, vcpu->arch.qpr[i]);
+			i, f, VCPU_FPR(vcpu, i), i, vcpu->arch.qpr[i]);
 	}
 #endif
 
@@ -764,8 +761,8 @@ int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			break;
 		}
 		case OP_4X_PS_NEG:
-			vcpu->arch.fpr[ax_rd] = vcpu->arch.fpr[ax_rb];
-			vcpu->arch.fpr[ax_rd] ^= 0x8000000000000000ULL;
+			VCPU_FPR(vcpu, ax_rd) = VCPU_FPR(vcpu, ax_rb);
+			VCPU_FPR(vcpu, ax_rd) ^= 0x8000000000000000ULL;
 			vcpu->arch.qpr[ax_rd] = vcpu->arch.qpr[ax_rb];
 			vcpu->arch.qpr[ax_rd] ^= 0x80000000;
 			break;
@@ -775,7 +772,7 @@ int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			break;
 		case OP_4X_PS_MR:
 			WARN_ON(rcomp);
-			vcpu->arch.fpr[ax_rd] = vcpu->arch.fpr[ax_rb];
+			VCPU_FPR(vcpu, ax_rd) = VCPU_FPR(vcpu, ax_rb);
 			vcpu->arch.qpr[ax_rd] = vcpu->arch.qpr[ax_rb];
 			break;
 		case OP_4X_PS_CMPO1:
@@ -784,44 +781,44 @@ int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			break;
 		case OP_4X_PS_NABS:
 			WARN_ON(rcomp);
-			vcpu->arch.fpr[ax_rd] = vcpu->arch.fpr[ax_rb];
-			vcpu->arch.fpr[ax_rd] |= 0x8000000000000000ULL;
+			VCPU_FPR(vcpu, ax_rd) = VCPU_FPR(vcpu, ax_rb);
+			VCPU_FPR(vcpu, ax_rd) |= 0x8000000000000000ULL;
 			vcpu->arch.qpr[ax_rd] = vcpu->arch.qpr[ax_rb];
 			vcpu->arch.qpr[ax_rd] |= 0x80000000;
 			break;
 		case OP_4X_PS_ABS:
 			WARN_ON(rcomp);
-			vcpu->arch.fpr[ax_rd] = vcpu->arch.fpr[ax_rb];
-			vcpu->arch.fpr[ax_rd] &= ~0x8000000000000000ULL;
+			VCPU_FPR(vcpu, ax_rd) = VCPU_FPR(vcpu, ax_rb);
+			VCPU_FPR(vcpu, ax_rd) &= ~0x8000000000000000ULL;
 			vcpu->arch.qpr[ax_rd] = vcpu->arch.qpr[ax_rb];
 			vcpu->arch.qpr[ax_rd] &= ~0x80000000;
 			break;
 		case OP_4X_PS_MERGE00:
 			WARN_ON(rcomp);
-			vcpu->arch.fpr[ax_rd] = vcpu->arch.fpr[ax_ra];
-			/* vcpu->arch.qpr[ax_rd] = vcpu->arch.fpr[ax_rb]; */
-			kvm_cvt_df(&vcpu->arch.fpr[ax_rb],
+			VCPU_FPR(vcpu, ax_rd) = VCPU_FPR(vcpu, ax_ra);
+			/* vcpu->arch.qpr[ax_rd] = VCPU_FPR(vcpu, ax_rb); */
+			kvm_cvt_df(&VCPU_FPR(vcpu, ax_rb),
 				   &vcpu->arch.qpr[ax_rd]);
 			break;
 		case OP_4X_PS_MERGE01:
 			WARN_ON(rcomp);
-			vcpu->arch.fpr[ax_rd] = vcpu->arch.fpr[ax_ra];
+			VCPU_FPR(vcpu, ax_rd) = VCPU_FPR(vcpu, ax_ra);
 			vcpu->arch.qpr[ax_rd] = vcpu->arch.qpr[ax_rb];
 			break;
 		case OP_4X_PS_MERGE10:
 			WARN_ON(rcomp);
-			/* vcpu->arch.fpr[ax_rd] = vcpu->arch.qpr[ax_ra]; */
+			/* VCPU_FPR(vcpu, ax_rd) = vcpu->arch.qpr[ax_ra]; */
 			kvm_cvt_fd(&vcpu->arch.qpr[ax_ra],
-				   &vcpu->arch.fpr[ax_rd]);
-			/* vcpu->arch.qpr[ax_rd] = vcpu->arch.fpr[ax_rb]; */
-			kvm_cvt_df(&vcpu->arch.fpr[ax_rb],
+				   &VCPU_FPR(vcpu, ax_rd));
+			/* vcpu->arch.qpr[ax_rd] = VCPU_FPR(vcpu, ax_rb); */
+			kvm_cvt_df(&VCPU_FPR(vcpu, ax_rb),
 				   &vcpu->arch.qpr[ax_rd]);
 			break;
 		case OP_4X_PS_MERGE11:
 			WARN_ON(rcomp);
-			/* vcpu->arch.fpr[ax_rd] = vcpu->arch.qpr[ax_ra]; */
+			/* VCPU_FPR(vcpu, ax_rd) = vcpu->arch.qpr[ax_ra]; */
 			kvm_cvt_fd(&vcpu->arch.qpr[ax_ra],
-				   &vcpu->arch.fpr[ax_rd]);
+				   &VCPU_FPR(vcpu, ax_rd));
 			vcpu->arch.qpr[ax_rd] = vcpu->arch.qpr[ax_rb];
 			break;
 		}
@@ -856,7 +853,7 @@ int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		case OP_4A_PS_SUM1:
 			emulated = kvmppc_ps_two_in(vcpu, rcomp, ax_rd,
 					ax_rb, ax_ra, SCALAR_NO_PS0 | SCALAR_HIGH, fps_fadds);
-			vcpu->arch.fpr[ax_rd] = vcpu->arch.fpr[ax_rc];
+			VCPU_FPR(vcpu, ax_rd) = VCPU_FPR(vcpu, ax_rc);
 			break;
 		case OP_4A_PS_SUM0:
 			emulated = kvmppc_ps_two_in(vcpu, rcomp, ax_rd,
@@ -1106,45 +1103,45 @@ int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	case 59:
 		switch (inst_get_field(inst, 21, 30)) {
 		case OP_59_FADDS:
-			fpd_fadds(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_b);
+			fpd_fadds(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_b);
 			kvmppc_sync_qpr(vcpu, ax_rd);
 			break;
 		case OP_59_FSUBS:
-			fpd_fsubs(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_b);
+			fpd_fsubs(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_b);
 			kvmppc_sync_qpr(vcpu, ax_rd);
 			break;
 		case OP_59_FDIVS:
-			fpd_fdivs(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_b);
+			fpd_fdivs(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_b);
 			kvmppc_sync_qpr(vcpu, ax_rd);
 			break;
 		case OP_59_FRES:
-			fpd_fres(&vcpu->arch.fpscr, &cr, fpr_d, fpr_b);
+			fpd_fres(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_b);
 			kvmppc_sync_qpr(vcpu, ax_rd);
 			break;
 		case OP_59_FRSQRTES:
-			fpd_frsqrtes(&vcpu->arch.fpscr, &cr, fpr_d, fpr_b);
+			fpd_frsqrtes(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_b);
 			kvmppc_sync_qpr(vcpu, ax_rd);
 			break;
 		}
 		switch (inst_get_field(inst, 26, 30)) {
 		case OP_59_FMULS:
-			fpd_fmuls(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_c);
+			fpd_fmuls(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_c);
 			kvmppc_sync_qpr(vcpu, ax_rd);
 			break;
 		case OP_59_FMSUBS:
-			fpd_fmsubs(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
+			fpd_fmsubs(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
 			kvmppc_sync_qpr(vcpu, ax_rd);
 			break;
 		case OP_59_FMADDS:
-			fpd_fmadds(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
+			fpd_fmadds(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
 			kvmppc_sync_qpr(vcpu, ax_rd);
 			break;
 		case OP_59_FNMSUBS:
-			fpd_fnmsubs(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
+			fpd_fnmsubs(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
 			kvmppc_sync_qpr(vcpu, ax_rd);
 			break;
 		case OP_59_FNMADDS:
-			fpd_fnmadds(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
+			fpd_fnmadds(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
 			kvmppc_sync_qpr(vcpu, ax_rd);
 			break;
 		}
@@ -1159,12 +1156,12 @@ int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			break;
 		case OP_63_MFFS:
 			/* XXX missing CR */
-			*fpr_d = vcpu->arch.fpscr;
+			*fpr_d = vcpu->arch.fp.fpscr;
 			break;
 		case OP_63_MTFSF:
 			/* XXX missing fm bits */
 			/* XXX missing CR */
-			vcpu->arch.fpscr = *fpr_b;
+			vcpu->arch.fp.fpscr = *fpr_b;
 			break;
 		case OP_63_FCMPU:
 		{
@@ -1172,7 +1169,7 @@ int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			u32 cr0_mask = 0xf0000000;
 			u32 cr_shift = inst_get_field(inst, 6, 8) * 4;
 
-			fpd_fcmpu(&vcpu->arch.fpscr, &tmp_cr, fpr_a, fpr_b);
+			fpd_fcmpu(&vcpu->arch.fp.fpscr, &tmp_cr, fpr_a, fpr_b);
 			cr &= ~(cr0_mask >> cr_shift);
 			cr |= (cr & cr0_mask) >> cr_shift;
 			break;
@@ -1183,40 +1180,40 @@ int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			u32 cr0_mask = 0xf0000000;
 			u32 cr_shift = inst_get_field(inst, 6, 8) * 4;
 
-			fpd_fcmpo(&vcpu->arch.fpscr, &tmp_cr, fpr_a, fpr_b);
+			fpd_fcmpo(&vcpu->arch.fp.fpscr, &tmp_cr, fpr_a, fpr_b);
 			cr &= ~(cr0_mask >> cr_shift);
 			cr |= (cr & cr0_mask) >> cr_shift;
 			break;
 		}
 		case OP_63_FNEG:
-			fpd_fneg(&vcpu->arch.fpscr, &cr, fpr_d, fpr_b);
+			fpd_fneg(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_b);
 			break;
 		case OP_63_FMR:
 			*fpr_d = *fpr_b;
 			break;
 		case OP_63_FABS:
-			fpd_fabs(&vcpu->arch.fpscr, &cr, fpr_d, fpr_b);
+			fpd_fabs(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_b);
 			break;
 		case OP_63_FCPSGN:
-			fpd_fcpsgn(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_b);
+			fpd_fcpsgn(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_b);
 			break;
 		case OP_63_FDIV:
-			fpd_fdiv(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_b);
+			fpd_fdiv(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_b);
 			break;
 		case OP_63_FADD:
-			fpd_fadd(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_b);
+			fpd_fadd(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_b);
 			break;
 		case OP_63_FSUB:
-			fpd_fsub(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_b);
+			fpd_fsub(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_b);
 			break;
 		case OP_63_FCTIW:
-			fpd_fctiw(&vcpu->arch.fpscr, &cr, fpr_d, fpr_b);
+			fpd_fctiw(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_b);
 			break;
 		case OP_63_FCTIWZ:
-			fpd_fctiwz(&vcpu->arch.fpscr, &cr, fpr_d, fpr_b);
+			fpd_fctiwz(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_b);
 			break;
 		case OP_63_FRSP:
-			fpd_frsp(&vcpu->arch.fpscr, &cr, fpr_d, fpr_b);
+			fpd_frsp(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_b);
 			kvmppc_sync_qpr(vcpu, ax_rd);
 			break;
 		case OP_63_FRSQRTE:
@@ -1224,39 +1221,39 @@ int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			double one = 1.0f;
 
 			/* fD = sqrt(fB) */
-			fpd_fsqrt(&vcpu->arch.fpscr, &cr, fpr_d, fpr_b);
+			fpd_fsqrt(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_b);
 			/* fD = 1.0f / fD */
-			fpd_fdiv(&vcpu->arch.fpscr, &cr, fpr_d, (u64*)&one, fpr_d);
+			fpd_fdiv(&vcpu->arch.fp.fpscr, &cr, fpr_d, (u64*)&one, fpr_d);
 			break;
 		}
 		}
 		switch (inst_get_field(inst, 26, 30)) {
 		case OP_63_FMUL:
-			fpd_fmul(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_c);
+			fpd_fmul(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_c);
 			break;
 		case OP_63_FSEL:
-			fpd_fsel(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
+			fpd_fsel(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
 			break;
 		case OP_63_FMSUB:
-			fpd_fmsub(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
+			fpd_fmsub(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
 			break;
 		case OP_63_FMADD:
-			fpd_fmadd(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
+			fpd_fmadd(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
 			break;
 		case OP_63_FNMSUB:
-			fpd_fnmsub(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
+			fpd_fnmsub(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
 			break;
 		case OP_63_FNMADD:
-			fpd_fnmadd(&vcpu->arch.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
+			fpd_fnmadd(&vcpu->arch.fp.fpscr, &cr, fpr_d, fpr_a, fpr_c, fpr_b);
 			break;
 		}
 		break;
 	}
 
 #ifdef DEBUG
-	for (i = 0; i < ARRAY_SIZE(vcpu->arch.fpr); i++) {
+	for (i = 0; i < ARRAY_SIZE(vcpu->arch.fp.fpr); i++) {
 		u32 f;
-		kvm_cvt_df(&vcpu->arch.fpr[i], &f);
+		kvm_cvt_df(&VCPU_FPR(vcpu, i), &f);
 		dprintk(KERN_INFO "FPR[%d] = 0x%x\n", i, f);
 	}
 #endif
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 3c52b08..90be91c 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -440,12 +440,6 @@ static inline int get_fpr_index(int i)
 void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr)
 {
 	struct thread_struct *t = &current->thread;
-	u64 *vcpu_fpr = vcpu->arch.fpr;
-#ifdef CONFIG_VSX
-	u64 *vcpu_vsx = vcpu->arch.vsr;
-#endif
-	u64 *thread_fpr = &t->fp_state.fpr[0][0];
-	int i;
 
 	/*
 	 * VSX instructions can access FP and vector registers, so if
@@ -470,24 +464,14 @@ void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr)
 		 */
 		if (current->thread.regs->msr & MSR_FP)
 			giveup_fpu(current);
-		for (i = 0; i < ARRAY_SIZE(vcpu->arch.fpr); i++)
-			vcpu_fpr[i] = thread_fpr[get_fpr_index(i)];
-
-		vcpu->arch.fpscr = t->fp_state.fpscr;
-
-#ifdef CONFIG_VSX
-		if (cpu_has_feature(CPU_FTR_VSX))
-			for (i = 0; i < ARRAY_SIZE(vcpu->arch.vsr) / 2; i++)
-				vcpu_vsx[i] = thread_fpr[get_fpr_index(i) + 1];
-#endif
+		vcpu->arch.fp = t->fp_state;
 	}
 
 #ifdef CONFIG_ALTIVEC
 	if (msr & MSR_VEC) {
 		if (current->thread.regs->msr & MSR_VEC)
 			giveup_altivec(current);
-		memcpy(vcpu->arch.vr, t->vr_state.vr, sizeof(vcpu->arch.vr));
-		vcpu->arch.vscr = t->vr_state.vscr;
+		vcpu->arch.vr = t->vr_state;
 	}
 #endif
 
@@ -535,12 +519,6 @@ static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
 			     ulong msr)
 {
 	struct thread_struct *t = &current->thread;
-	u64 *vcpu_fpr = vcpu->arch.fpr;
-#ifdef CONFIG_VSX
-	u64 *vcpu_vsx = vcpu->arch.vsr;
-#endif
-	u64 *thread_fpr = &t->fp_state.fpr[0][0];
-	int i;
 
 	/* When we have paired singles, we emulate in software */
 	if (vcpu->arch.hflags & BOOK3S_HFLAG_PAIRED_SINGLE)
@@ -578,13 +556,7 @@ static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
 #endif
 
 	if (msr & MSR_FP) {
-		for (i = 0; i < ARRAY_SIZE(vcpu->arch.fpr); i++)
-			thread_fpr[get_fpr_index(i)] = vcpu_fpr[i];
-#ifdef CONFIG_VSX
-		for (i = 0; i < ARRAY_SIZE(vcpu->arch.vsr) / 2; i++)
-			thread_fpr[get_fpr_index(i) + 1] = vcpu_vsx[i];
-#endif
-		t->fp_state.fpscr = vcpu->arch.fpscr;
+		t->fp_state = vcpu->arch.fp;
 		t->fpexc_mode = 0;
 		enable_kernel_fp();
 		load_fp_state(&t->fp_state);
@@ -592,8 +564,7 @@ static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
 
 	if (msr & MSR_VEC) {
 #ifdef CONFIG_ALTIVEC
-		memcpy(t->vr_state.vr, vcpu->arch.vr, sizeof(vcpu->arch.vr));
-		t->vr_state.vscr = vcpu->arch.vscr;
+		t->vr_state = vcpu->arch.vr;
 		t->vrsave = -1;
 		enable_kernel_altivec();
 		load_vr_state(&t->vr_state);
@@ -997,19 +968,6 @@ int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id, union kvmppc_one_reg *val)
 	case KVM_REG_PPC_HIOR:
 		*val = get_reg_val(id, to_book3s(vcpu)->hior);
 		break;
-#ifdef CONFIG_VSX
-	case KVM_REG_PPC_VSR0 ... KVM_REG_PPC_VSR31: {
-		long int i = id - KVM_REG_PPC_VSR0;
-
-		if (!cpu_has_feature(CPU_FTR_VSX)) {
-			r = -ENXIO;
-			break;
-		}
-		val->vsxval[0] = vcpu->arch.fpr[i];
-		val->vsxval[1] = vcpu->arch.vsr[i];
-		break;
-	}
-#endif /* CONFIG_VSX */
 	default:
 		r = -EINVAL;
 		break;
@@ -1027,19 +985,6 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id, union kvmppc_one_reg *val)
 		to_book3s(vcpu)->hior = set_reg_val(id, *val);
 		to_book3s(vcpu)->hior_explicit = true;
 		break;
-#ifdef CONFIG_VSX
-	case KVM_REG_PPC_VSR0 ... KVM_REG_PPC_VSR31: {
-		long int i = id - KVM_REG_PPC_VSR0;
-
-		if (!cpu_has_feature(CPU_FTR_VSX)) {
-			r = -ENXIO;
-			break;
-		}
-		vcpu->arch.fpr[i] = val->vsxval[0];
-		vcpu->arch.vsr[i] = val->vsxval[1];
-		break;
-	}
-#endif /* CONFIG_VSX */
 	default:
 		r = -EINVAL;
 		break;
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 5133199..4998a65 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -680,9 +680,7 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	fpexc_mode = current->thread.fpexc_mode;
 
 	/* Restore guest FPU state to thread */
-	memcpy(current->thread.fp_state.fpr, vcpu->arch.fpr,
-	       sizeof(vcpu->arch.fpr));
-	current->thread.fp_state.fpscr = vcpu->arch.fpscr;
+	current->thread.fp_state = vcpu->arch.fp;
 
 	/*
 	 * Since we can't trap on MSR_FP in GS-mode, we consider the guest
@@ -708,9 +706,7 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	vcpu->fpu_active = 0;
 
 	/* Save guest FPU state from thread */
-	memcpy(vcpu->arch.fpr, current->thread.fp_state.fpr,
-	       sizeof(vcpu->arch.fpr));
-	vcpu->arch.fpscr = current->thread.fp_state.fpscr;
+	vcpu->arch.fp = current->thread.fp_state;
 
 	/* Restore userspace FPU state from stack */
 	current->thread.fp_state = fp;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 07c0106..4cd3dcf 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -608,14 +608,14 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
 		kvmppc_set_gpr(vcpu, vcpu->arch.io_gpr, gpr);
 		break;
 	case KVM_MMIO_REG_FPR:
-		vcpu->arch.fpr[vcpu->arch.io_gpr & KVM_MMIO_REG_MASK] = gpr;
+		VCPU_FPR(vcpu, vcpu->arch.io_gpr & KVM_MMIO_REG_MASK) = gpr;
 		break;
 #ifdef CONFIG_PPC_BOOK3S
 	case KVM_MMIO_REG_QPR:
 		vcpu->arch.qpr[vcpu->arch.io_gpr & KVM_MMIO_REG_MASK] = gpr;
 		break;
 	case KVM_MMIO_REG_FQPR:
-		vcpu->arch.fpr[vcpu->arch.io_gpr & KVM_MMIO_REG_MASK] = gpr;
+		VCPU_FPR(vcpu, vcpu->arch.io_gpr & KVM_MMIO_REG_MASK) = gpr;
 		vcpu->arch.qpr[vcpu->arch.io_gpr & KVM_MMIO_REG_MASK] = gpr;
 		break;
 #endif
-- 
1.8.4.rc3
