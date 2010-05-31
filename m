Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 6B810B7D67
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Jun 2010 04:06:33 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] powerpc: Don't export cvt_fd & _df when CONFIG_PPC_FPU is
	not set
References: <1275270628.1931.540.camel@pasglop>
	<1275271231.1931.547.camel@pasglop>
	<FAE73713-EE73-4FA6-B1C6-88D38E230F01@suse.de>
	<m3ljb0tn2l.fsf@hase.home>
	<4C03DB3D.7090007__38063.9078132392$1275321190$gmane$org@suse.de>
Date: Mon, 31 May 2010 20:06:29 +0200
In-Reply-To: <4C03DB3D.7090007__38063.9078132392$1275321190$gmane$org@suse.de>
	(Alexander Graf's message of "Mon, 31 May 2010 17:52:29 +0200")
Message-ID: <m2aargndy2.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> Mind to send it over so I can take a look at it :)? Getting rid of the
> task_struct structs lying in the stack is certainly a good idea.

Still untested, because rc1 does not boot.

Andreas.

---
 arch/powerpc/include/asm/kvm_fpu.h       |   29 +++++----
 arch/powerpc/kvm/book3s.c                |   49 ++++++++--------
 arch/powerpc/kvm/book3s_paired_singles.c |   94 ++++++++++++-------------------
 arch/powerpc/kvm/fpu.S                   |   18 +++++
 4 files changed, 98 insertions(+), 92 deletions(-)

--- linux-2.6.35-rc1.orig/arch/powerpc/include/asm/kvm_fpu.h
+++ linux-2.6.35-rc1/arch/powerpc/include/asm/kvm_fpu.h
@@ -22,24 +22,24 @@
 
 #include <linux/types.h>
 
-extern void fps_fres(struct thread_struct *t, u32 *dst, u32 *src1);
-extern void fps_frsqrte(struct thread_struct *t, u32 *dst, u32 *src1);
-extern void fps_fsqrts(struct thread_struct *t, u32 *dst, u32 *src1);
-
-extern void fps_fadds(struct thread_struct *t, u32 *dst, u32 *src1, u32 *src2);
-extern void fps_fdivs(struct thread_struct *t, u32 *dst, u32 *src1, u32 *src2);
-extern void fps_fmuls(struct thread_struct *t, u32 *dst, u32 *src1, u32 *src2);
-extern void fps_fsubs(struct thread_struct *t, u32 *dst, u32 *src1, u32 *src2);
+extern void fps_fres(u64 *fpscr, u32 *dst, u32 *src1);
+extern void fps_frsqrte(u64 *fpscr, u32 *dst, u32 *src1);
+extern void fps_fsqrts(u64 *fpscr, u32 *dst, u32 *src1);
+
+extern void fps_fadds(u64 *fpscr, u32 *dst, u32 *src1, u32 *src2);
+extern void fps_fdivs(u64 *fpscr, u32 *dst, u32 *src1, u32 *src2);
+extern void fps_fmuls(u64 *fpscr, u32 *dst, u32 *src1, u32 *src2);
+extern void fps_fsubs(u64 *fpscr, u32 *dst, u32 *src1, u32 *src2);
 
-extern void fps_fmadds(struct thread_struct *t, u32 *dst, u32 *src1, u32 *src2,
+extern void fps_fmadds(u64 *fpscr, u32 *dst, u32 *src1, u32 *src2,
 		       u32 *src3);
-extern void fps_fmsubs(struct thread_struct *t, u32 *dst, u32 *src1, u32 *src2,
+extern void fps_fmsubs(u64 *fpscr, u32 *dst, u32 *src1, u32 *src2,
 		       u32 *src3);
-extern void fps_fnmadds(struct thread_struct *t, u32 *dst, u32 *src1, u32 *src2,
+extern void fps_fnmadds(u64 *fpscr, u32 *dst, u32 *src1, u32 *src2,
 		        u32 *src3);
-extern void fps_fnmsubs(struct thread_struct *t, u32 *dst, u32 *src1, u32 *src2,
+extern void fps_fnmsubs(u64 *fpscr, u32 *dst, u32 *src1, u32 *src2,
 		        u32 *src3);
-extern void fps_fsel(struct thread_struct *t, u32 *dst, u32 *src1, u32 *src2,
+extern void fps_fsel(u64 *fpscr, u32 *dst, u32 *src1, u32 *src2,
 		     u32 *src3);
 
 #define FPD_ONE_IN(name) extern void fpd_ ## name(u64 *fpscr, u32 *cr, \
@@ -82,4 +82,7 @@ FPD_THREE_IN(fmadd)
 FPD_THREE_IN(fnmsub)
 FPD_THREE_IN(fnmadd)
 
+extern void kvm_cvt_fd(u32 *from, u64 *to, u64 *fpscr);
+extern void kvm_cvt_df(u64 *from, u32 *to, u64 *fpscr);
+
 #endif
--- linux-2.6.35-rc1.orig/arch/powerpc/kvm/book3s.c
+++ linux-2.6.35-rc1/arch/powerpc/kvm/book3s.c
@@ -1309,12 +1309,17 @@ extern int __kvmppc_vcpu_entry(struct kv
 int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 {
 	int ret;
-	struct thread_struct ext_bkp;
+	double fpr[32][TS_FPRWIDTH];
+	unsigned int fpscr;
+	int fpexc_mode;
 #ifdef CONFIG_ALTIVEC
-	bool save_vec = current->thread.used_vr;
+	vector128 vr[32];
+	vector128 vscr;
+	unsigned long uninitialized_var(vrsave);
+	int used_vr;
 #endif
 #ifdef CONFIG_VSX
-	bool save_vsx = current->thread.used_vsr;
+	int used_vsr;
 #endif
 	ulong ext_msr;
 
@@ -1327,27 +1332,27 @@ int __kvmppc_vcpu_run(struct kvm_run *kv
 	/* Save FPU state in stack */
 	if (current->thread.regs->msr & MSR_FP)
 		giveup_fpu(current);
-	memcpy(ext_bkp.fpr, current->thread.fpr, sizeof(current->thread.fpr));
-	ext_bkp.fpscr = current->thread.fpscr;
-	ext_bkp.fpexc_mode = current->thread.fpexc_mode;
+	memcpy(fpr, current->thread.fpr, sizeof(current->thread.fpr));
+	fpscr = current->thread.fpscr.val;
+	fpexc_mode = current->thread.fpexc_mode;
 
 #ifdef CONFIG_ALTIVEC
 	/* Save Altivec state in stack */
-	if (save_vec) {
+	used_vr = current->thread.used_vr;
+	if (used_vr) {
 		if (current->thread.regs->msr & MSR_VEC)
 			giveup_altivec(current);
-		memcpy(ext_bkp.vr, current->thread.vr, sizeof(ext_bkp.vr));
-		ext_bkp.vscr = current->thread.vscr;
-		ext_bkp.vrsave = current->thread.vrsave;
+		memcpy(vr, current->thread.vr, sizeof(current->thread.vr));
+		vscr = current->thread.vscr;
+		vrsave = current->thread.vrsave;
 	}
-	ext_bkp.used_vr = current->thread.used_vr;
 #endif
 
 #ifdef CONFIG_VSX
 	/* Save VSX state in stack */
-	if (save_vsx && (current->thread.regs->msr & MSR_VSX))
+	used_vsr = current->thread.used_vsr;
+	if (used_vsr && (current->thread.regs->msr & MSR_VSX))
 			__giveup_vsx(current);
-	ext_bkp.used_vsr = current->thread.used_vsr;
 #endif
 
 	/* Remember the MSR with disabled extensions */
@@ -1372,22 +1377,22 @@ int __kvmppc_vcpu_run(struct kvm_run *kv
 	kvmppc_giveup_ext(vcpu, MSR_VSX);
 
 	/* Restore FPU state from stack */
-	memcpy(current->thread.fpr, ext_bkp.fpr, sizeof(ext_bkp.fpr));
-	current->thread.fpscr = ext_bkp.fpscr;
-	current->thread.fpexc_mode = ext_bkp.fpexc_mode;
+	memcpy(current->thread.fpr, fpr, sizeof(current->thread.fpr));
+	current->thread.fpscr.val = fpscr;
+	current->thread.fpexc_mode = fpexc_mode;
 
 #ifdef CONFIG_ALTIVEC
 	/* Restore Altivec state from stack */
-	if (save_vec && current->thread.used_vr) {
-		memcpy(current->thread.vr, ext_bkp.vr, sizeof(ext_bkp.vr));
-		current->thread.vscr = ext_bkp.vscr;
-		current->thread.vrsave= ext_bkp.vrsave;
+	if (used_vr && current->thread.used_vr) {
+		memcpy(current->thread.vr, vr, sizeof(current->thread.vr));
+		current->thread.vscr = vscr;
+		current->thread.vrsave = vrsave;
 	}
-	current->thread.used_vr = ext_bkp.used_vr;
+	current->thread.used_vr = used_vr;
 #endif
 
 #ifdef CONFIG_VSX
-	current->thread.used_vsr = ext_bkp.used_vsr;
+	current->thread.used_vsr = used_vsr;
 #endif
 
 	return ret;
--- linux-2.6.35-rc1.orig/arch/powerpc/kvm/book3s_paired_singles.c
+++ linux-2.6.35-rc1/arch/powerpc/kvm/book3s_paired_singles.c
@@ -159,10 +159,7 @@
 
 static inline void kvmppc_sync_qpr(struct kvm_vcpu *vcpu, int rt)
 {
-	struct thread_struct t;
-
-	t.fpscr.val = vcpu->arch.fpscr;
-	cvt_df((double*)&vcpu->arch.fpr[rt], (float*)&vcpu->arch.qpr[rt], &t);
+	kvm_cvt_df(&vcpu->arch.fpr[rt], &vcpu->arch.qpr[rt], &vcpu->arch.fpscr);
 }
 
 static void kvmppc_inject_pf(struct kvm_vcpu *vcpu, ulong eaddr, bool is_store)
@@ -183,7 +180,6 @@ static int kvmppc_emulate_fpr_load(struc
 				   int rs, ulong addr, int ls_type)
 {
 	int emulated = EMULATE_FAIL;
-	struct thread_struct t;
 	int r;
 	char tmp[8];
 	int len = sizeof(u32);
@@ -191,8 +187,6 @@ static int kvmppc_emulate_fpr_load(struc
 	if (ls_type == FPU_LS_DOUBLE)
 		len = sizeof(u64);
 
-	t.fpscr.val = vcpu->arch.fpscr;
-
 	/* read from memory */
 	r = kvmppc_ld(vcpu, &addr, len, tmp, true);
 	vcpu->arch.paddr_accessed = addr;
@@ -210,7 +204,7 @@ static int kvmppc_emulate_fpr_load(struc
 	/* put in registers */
 	switch (ls_type) {
 	case FPU_LS_SINGLE:
-		cvt_fd((float*)tmp, (double*)&vcpu->arch.fpr[rs], &t);
+		kvm_cvt_fd((u32*)tmp, &vcpu->arch.fpr[rs], &vcpu->arch.fpscr);
 		vcpu->arch.qpr[rs] = *((u32*)tmp);
 		break;
 	case FPU_LS_DOUBLE:
@@ -229,17 +223,14 @@ static int kvmppc_emulate_fpr_store(stru
 				    int rs, ulong addr, int ls_type)
 {
 	int emulated = EMULATE_FAIL;
-	struct thread_struct t;
 	int r;
 	char tmp[8];
 	u64 val;
 	int len;
 
-	t.fpscr.val = vcpu->arch.fpscr;
-
 	switch (ls_type) {
 	case FPU_LS_SINGLE:
-		cvt_df((double*)&vcpu->arch.fpr[rs], (float*)tmp, &t);
+		kvm_cvt_df(&vcpu->arch.fpr[rs], (u32*)tmp, &vcpu->arch.fpscr);
 		val = *((u32*)tmp);
 		len = sizeof(u32);
 		break;
@@ -278,13 +269,10 @@ static int kvmppc_emulate_psq_load(struc
 				   int rs, ulong addr, bool w, int i)
 {
 	int emulated = EMULATE_FAIL;
-	struct thread_struct t;
 	int r;
 	float one = 1.0;
 	u32 tmp[2];
 
-	t.fpscr.val = vcpu->arch.fpscr;
-
 	/* read from memory */
 	if (w) {
 		r = kvmppc_ld(vcpu, &addr, sizeof(u32), tmp, true);
@@ -308,7 +296,7 @@ static int kvmppc_emulate_psq_load(struc
 	emulated = EMULATE_DONE;
 
 	/* put in registers */
-	cvt_fd((float*)&tmp[0], (double*)&vcpu->arch.fpr[rs], &t);
+	kvm_cvt_fd(&tmp[0], &vcpu->arch.fpr[rs], &vcpu->arch.fpscr);
 	vcpu->arch.qpr[rs] = tmp[1];
 
 	dprintk(KERN_INFO "KVM: PSQ_LD [0x%x, 0x%x] at 0x%lx (%d)\n", tmp[0],
@@ -322,14 +310,11 @@ static int kvmppc_emulate_psq_store(stru
 				    int rs, ulong addr, bool w, int i)
 {
 	int emulated = EMULATE_FAIL;
-	struct thread_struct t;
 	int r;
 	u32 tmp[2];
 	int len = w ? sizeof(u32) : sizeof(u64);
 
-	t.fpscr.val = vcpu->arch.fpscr;
-
-	cvt_df((double*)&vcpu->arch.fpr[rs], (float*)&tmp[0], &t);
+	kvm_cvt_df(&vcpu->arch.fpr[rs], &tmp[0], &vcpu->arch.fpscr);
 	tmp[1] = vcpu->arch.qpr[rs];
 
 	r = kvmppc_st(vcpu, &addr, len, tmp, true);
@@ -517,7 +502,7 @@ static int get_d_signext(u32 inst)
 static int kvmppc_ps_three_in(struct kvm_vcpu *vcpu, bool rc,
 				      int reg_out, int reg_in1, int reg_in2,
 				      int reg_in3, int scalar,
-				      void (*func)(struct thread_struct *t,
+				      void (*func)(u64 *fpscr,
 						 u32 *dst, u32 *src1,
 						 u32 *src2, u32 *src3))
 {
@@ -526,27 +511,25 @@ static int kvmppc_ps_three_in(struct kvm
 	u32 ps0_out;
 	u32 ps0_in1, ps0_in2, ps0_in3;
 	u32 ps1_in1, ps1_in2, ps1_in3;
-	struct thread_struct t;
-	t.fpscr.val = vcpu->arch.fpscr;
 
 	/* RC */
 	WARN_ON(rc);
 
 	/* PS0 */
-	cvt_df((double*)&fpr[reg_in1], (float*)&ps0_in1, &t);
-	cvt_df((double*)&fpr[reg_in2], (float*)&ps0_in2, &t);
-	cvt_df((double*)&fpr[reg_in3], (float*)&ps0_in3, &t);
+	kvm_cvt_df(&fpr[reg_in1], &ps0_in1, &vcpu->arch.fpscr);
+	kvm_cvt_df(&fpr[reg_in2], &ps0_in2, &vcpu->arch.fpscr);
+	kvm_cvt_df(&fpr[reg_in3], &ps0_in3, &vcpu->arch.fpscr);
 
 	if (scalar & SCALAR_LOW)
 		ps0_in2 = qpr[reg_in2];
 
-	func(&t, &ps0_out, &ps0_in1, &ps0_in2, &ps0_in3);
+	func(&vcpu->arch.fpscr, &ps0_out, &ps0_in1, &ps0_in2, &ps0_in3);
 
 	dprintk(KERN_INFO "PS3 ps0 -> f(0x%x, 0x%x, 0x%x) = 0x%x\n",
 			  ps0_in1, ps0_in2, ps0_in3, ps0_out);
 
 	if (!(scalar & SCALAR_NO_PS0))
-		cvt_fd((float*)&ps0_out, (double*)&fpr[reg_out], &t);
+		kvm_cvt_fd(&ps0_out, &fpr[reg_out], &vcpu->arch.fpscr);
 
 	/* PS1 */
 	ps1_in1 = qpr[reg_in1];
@@ -557,7 +540,7 @@ static int kvmppc_ps_three_in(struct kvm
 		ps1_in2 = ps0_in2;
 
 	if (!(scalar & SCALAR_NO_PS1))
-		func(&t, &qpr[reg_out], &ps1_in1, &ps1_in2, &ps1_in3);
+		func(&vcpu->arch.fpscr, &qpr[reg_out], &ps1_in1, &ps1_in2, &ps1_in3);
 
 	dprintk(KERN_INFO "PS3 ps1 -> f(0x%x, 0x%x, 0x%x) = 0x%x\n",
 			  ps1_in1, ps1_in2, ps1_in3, qpr[reg_out]);
@@ -568,7 +551,7 @@ static int kvmppc_ps_three_in(struct kvm
 static int kvmppc_ps_two_in(struct kvm_vcpu *vcpu, bool rc,
 				    int reg_out, int reg_in1, int reg_in2,
 				    int scalar,
-				    void (*func)(struct thread_struct *t,
+				    void (*func)(u64 *fpscr,
 						 u32 *dst, u32 *src1,
 						 u32 *src2))
 {
@@ -578,27 +561,25 @@ static int kvmppc_ps_two_in(struct kvm_v
 	u32 ps0_in1, ps0_in2;
 	u32 ps1_out;
 	u32 ps1_in1, ps1_in2;
-	struct thread_struct t;
-	t.fpscr.val = vcpu->arch.fpscr;
 
 	/* RC */
 	WARN_ON(rc);
 
 	/* PS0 */
-	cvt_df((double*)&fpr[reg_in1], (float*)&ps0_in1, &t);
+	kvm_cvt_df(&fpr[reg_in1], &ps0_in1, &vcpu->arch.fpscr);
 
 	if (scalar & SCALAR_LOW)
 		ps0_in2 = qpr[reg_in2];
 	else
-		cvt_df((double*)&fpr[reg_in2], (float*)&ps0_in2, &t);
+		kvm_cvt_df(&fpr[reg_in2], &ps0_in2, &vcpu->arch.fpscr);
 
-	func(&t, &ps0_out, &ps0_in1, &ps0_in2);
+	func(&vcpu->arch.fpscr, &ps0_out, &ps0_in1, &ps0_in2);
 
 	if (!(scalar & SCALAR_NO_PS0)) {
 		dprintk(KERN_INFO "PS2 ps0 -> f(0x%x, 0x%x) = 0x%x\n",
 				  ps0_in1, ps0_in2, ps0_out);
 
-		cvt_fd((float*)&ps0_out, (double*)&fpr[reg_out], &t);
+		kvm_cvt_fd(&ps0_out, &fpr[reg_out], &vcpu->arch.fpscr);
 	}
 
 	/* PS1 */
@@ -608,7 +589,7 @@ static int kvmppc_ps_two_in(struct kvm_v
 	if (scalar & SCALAR_HIGH)
 		ps1_in2 = ps0_in2;
 
-	func(&t, &ps1_out, &ps1_in1, &ps1_in2);
+	func(&vcpu->arch.fpscr, &ps1_out, &ps1_in1, &ps1_in2);
 
 	if (!(scalar & SCALAR_NO_PS1)) {
 		qpr[reg_out] = ps1_out;
@@ -622,31 +603,29 @@ static int kvmppc_ps_two_in(struct kvm_v
 
 static int kvmppc_ps_one_in(struct kvm_vcpu *vcpu, bool rc,
 				    int reg_out, int reg_in,
-				    void (*func)(struct thread_struct *t,
+				    void (*func)(u64 *t,
 						 u32 *dst, u32 *src1))
 {
 	u32 *qpr = vcpu->arch.qpr;
 	u64 *fpr = vcpu->arch.fpr;
 	u32 ps0_out, ps0_in;
 	u32 ps1_in;
-	struct thread_struct t;
-	t.fpscr.val = vcpu->arch.fpscr;
 
 	/* RC */
 	WARN_ON(rc);
 
 	/* PS0 */
-	cvt_df((double*)&fpr[reg_in], (float*)&ps0_in, &t);
-	func(&t, &ps0_out, &ps0_in);
+	kvm_cvt_df(&fpr[reg_in], &ps0_in, &vcpu->arch.fpscr);
+	func(&vcpu->arch.fpscr, &ps0_out, &ps0_in);
 
 	dprintk(KERN_INFO "PS1 ps0 -> f(0x%x) = 0x%x\n",
 			  ps0_in, ps0_out);
 
-	cvt_fd((float*)&ps0_out, (double*)&fpr[reg_out], &t);
+	kvm_cvt_fd(&ps0_out, &fpr[reg_out], &vcpu->arch.fpscr);
 
 	/* PS1 */
 	ps1_in = qpr[reg_in];
-	func(&t, &qpr[reg_out], &ps1_in);
+	func(&vcpu->arch.fpscr, &qpr[reg_out], &ps1_in);
 
 	dprintk(KERN_INFO "PS1 ps1 -> f(0x%x) = 0x%x\n",
 			  ps1_in, qpr[reg_out]);
@@ -672,13 +651,10 @@ int kvmppc_emulate_paired_single(struct
 
 	bool rcomp = (inst & 1) ? true : false;
 	u32 cr = kvmppc_get_cr(vcpu);
-	struct thread_struct t;
 #ifdef DEBUG
 	int i;
 #endif
 
-	t.fpscr.val = vcpu->arch.fpscr;
-
 	if (!kvmppc_inst_is_paired_single(vcpu, inst))
 		return EMULATE_FAIL;
 
@@ -695,7 +671,7 @@ int kvmppc_emulate_paired_single(struct
 #ifdef DEBUG
 	for (i = 0; i < ARRAY_SIZE(vcpu->arch.fpr); i++) {
 		u32 f;
-		cvt_df((double*)&vcpu->arch.fpr[i], (float*)&f, &t);
+		kvm_cvt_df(&vcpu->arch.fpr[i], &f, &vcpu->arch.fpscr);
 		dprintk(KERN_INFO "FPR[%d] = 0x%x / 0x%llx    QPR[%d] = 0x%x\n",
 			i, f, vcpu->arch.fpr[i], i, vcpu->arch.qpr[i]);
 	}
@@ -819,8 +795,9 @@ int kvmppc_emulate_paired_single(struct
 			WARN_ON(rcomp);
 			vcpu->arch.fpr[ax_rd] = vcpu->arch.fpr[ax_ra];
 			/* vcpu->arch.qpr[ax_rd] = vcpu->arch.fpr[ax_rb]; */
-			cvt_df((double*)&vcpu->arch.fpr[ax_rb],
-			       (float*)&vcpu->arch.qpr[ax_rd], &t);
+			kvm_cvt_df(&vcpu->arch.fpr[ax_rb],
+				   &vcpu->arch.qpr[ax_rd],
+				   &vcpu->arch.fpscr);
 			break;
 		case OP_4X_PS_MERGE01:
 			WARN_ON(rcomp);
@@ -830,17 +807,20 @@ int kvmppc_emulate_paired_single(struct
 		case OP_4X_PS_MERGE10:
 			WARN_ON(rcomp);
 			/* vcpu->arch.fpr[ax_rd] = vcpu->arch.qpr[ax_ra]; */
-			cvt_fd((float*)&vcpu->arch.qpr[ax_ra],
-			       (double*)&vcpu->arch.fpr[ax_rd], &t);
+			kvm_cvt_fd(&vcpu->arch.qpr[ax_ra],
+				   &vcpu->arch.fpr[ax_rd],
+				   &vcpu->arch.fpscr);
 			/* vcpu->arch.qpr[ax_rd] = vcpu->arch.fpr[ax_rb]; */
-			cvt_df((double*)&vcpu->arch.fpr[ax_rb],
-			       (float*)&vcpu->arch.qpr[ax_rd], &t);
+			kvm_cvt_df(&vcpu->arch.fpr[ax_rb],
+				   &vcpu->arch.qpr[ax_rd],
+				   &vcpu->arch.fpscr);
 			break;
 		case OP_4X_PS_MERGE11:
 			WARN_ON(rcomp);
 			/* vcpu->arch.fpr[ax_rd] = vcpu->arch.qpr[ax_ra]; */
-			cvt_fd((float*)&vcpu->arch.qpr[ax_ra],
-			       (double*)&vcpu->arch.fpr[ax_rd], &t);
+			kvm_cvt_fd(&vcpu->arch.qpr[ax_ra],
+				   &vcpu->arch.fpr[ax_rd],
+				   &vcpu->arch.fpscr);
 			vcpu->arch.qpr[ax_rd] = vcpu->arch.qpr[ax_rb];
 			break;
 		}
@@ -1275,7 +1255,7 @@ int kvmppc_emulate_paired_single(struct
 #ifdef DEBUG
 	for (i = 0; i < ARRAY_SIZE(vcpu->arch.fpr); i++) {
 		u32 f;
-		cvt_df((double*)&vcpu->arch.fpr[i], (float*)&f, &t);
+		kvm_cvt_df(&vcpu->arch.fpr[i], &f, &vcpu->arch.fpscr);
 		dprintk(KERN_INFO "FPR[%d] = 0x%x\n", i, f);
 	}
 #endif
--- linux-2.6.35-rc1.orig/arch/powerpc/kvm/fpu.S
+++ linux-2.6.35-rc1/arch/powerpc/kvm/fpu.S
@@ -271,3 +271,21 @@ FPD_THREE_IN(fmsub)
 FPD_THREE_IN(fmadd)
 FPD_THREE_IN(fnmsub)
 FPD_THREE_IN(fnmadd)
+
+_GLOBAL(kvm_cvt_fd)
+	lfd	0,0(r5)			/* load up fpscr value */
+	MTFSF_L(0)
+	lfs	0,0(r3)
+	stfd	0,0(r4)
+	mffs	0
+	stfd	0,0(r5)			/* save new fpscr value */
+	blr
+
+_GLOBAL(kvm_cvt_df)
+	lfd	0,0(r5)			/* load up fpscr value */
+	MTFSF_L(0)
+	lfd	0,0(r3)
+	stfs	0,0(r4)
+	mffs	0
+	stfd	0,0(r5)			/* save new fpscr value */
+	blr

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
