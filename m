Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Mon, 23 Jun 2008 15:31:29 +1000
Subject: [PATCH 8/9] powerpc: Add VSX context save/restore,
	ptrace and signal support
In-Reply-To: <1214199088.328454.246197670684.qpush@coopers>
Message-Id: <20080623053129.A5862702A5@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch extends the floating point save and restore code to use the
VSX load/stores when VSX is available.  This will make FP context
save/restore marginally slower on FP only code, when VSX is available,
as it has to load/store 128bits rather than just 64bits.

Mixing FP, VMX and VSX code will get constant architected state.

The signals interface is extended to enable access to VSR 0-31
doubleword 1 after discussions with tool chain maintainers.  Backward
compatibility is maintained.  

The ptrace interface is also extended to allow access to VSR 0-31 full
registers.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/entry_64.S   |    5 +
 arch/powerpc/kernel/fpu.S        |   16 ++++-
 arch/powerpc/kernel/head_64.S    |   65 +++++++++++++++++++++++
 arch/powerpc/kernel/misc_64.S    |   33 ++++++++++++
 arch/powerpc/kernel/ppc32.h      |    1 
 arch/powerpc/kernel/ppc_ksyms.c  |    3 +
 arch/powerpc/kernel/process.c    |  106 ++++++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/ptrace.c     |   70 +++++++++++++++++++++++++
 arch/powerpc/kernel/signal_32.c  |   33 ++++++++++++
 arch/powerpc/kernel/signal_64.c  |   31 +++++++++++
 arch/powerpc/kernel/traps.c      |   29 ++++++++++
 include/asm-powerpc/elf.h        |    6 +-
 include/asm-powerpc/ptrace.h     |   12 ++++
 include/asm-powerpc/reg.h        |    2 
 include/asm-powerpc/sigcontext.h |   37 +++++++++++++
 include/asm-powerpc/system.h     |    9 +++
 include/linux/elf.h              |    1 
 17 files changed, 451 insertions(+), 8 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/entry_64.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/entry_64.S
@@ -353,6 +353,11 @@ _GLOBAL(_switch)
 	mflr	r20		/* Return to switch caller */
 	mfmsr	r22
 	li	r0, MSR_FP
+#ifdef CONFIG_VSX
+BEGIN_FTR_SECTION
+	oris	r0,r0,MSR_VSX@h	/* Disable VSX */
+END_FTR_SECTION_IFSET(CPU_FTR_VSX)
+#endif /* CONFIG_VSX */
 #ifdef CONFIG_ALTIVEC
 BEGIN_FTR_SECTION
 	oris	r0,r0,MSR_VEC@h	/* Disable altivec */
Index: linux-2.6-ozlabs/arch/powerpc/kernel/fpu.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/fpu.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/fpu.S
@@ -34,6 +34,11 @@
 _GLOBAL(load_up_fpu)
 	mfmsr	r5
 	ori	r5,r5,MSR_FP
+#ifdef CONFIG_VSX
+BEGIN_FTR_SECTION
+	oris	r5,r5,MSR_VSX@h
+END_FTR_SECTION_IFSET(CPU_FTR_VSX)
+#endif
 	SYNC
 	MTMSRD(r5)			/* enable use of fpu now */
 	isync
@@ -50,7 +55,7 @@ _GLOBAL(load_up_fpu)
 	beq	1f
 	toreal(r4)
 	addi	r4,r4,THREAD		/* want last_task_used_math->thread */
-	SAVE_32FPRS(0, r4)
+	SAVE_32FPVSRS(0, r5, r4)
 	mffs	fr0
 	stfd	fr0,THREAD_FPSCR(r4)
 	PPC_LL	r5,PT_REGS(r4)
@@ -77,7 +82,7 @@ _GLOBAL(load_up_fpu)
 #endif
 	lfd	fr0,THREAD_FPSCR(r5)
 	MTFSF_L(fr0)
-	REST_32FPRS(0, r5)
+	REST_32FPVSRS(0, r4, r5)
 #ifndef CONFIG_SMP
 	subi	r4,r5,THREAD
 	fromreal(r4)
@@ -96,6 +101,11 @@ _GLOBAL(load_up_fpu)
 _GLOBAL(giveup_fpu)
 	mfmsr	r5
 	ori	r5,r5,MSR_FP
+#ifdef CONFIG_VSX
+BEGIN_FTR_SECTION
+	oris	r5,r5,MSR_VSX@h
+END_FTR_SECTION_IFSET(CPU_FTR_VSX)
+#endif
 	SYNC_601
 	ISYNC_601
 	MTMSRD(r5)			/* enable use of fpu now */
@@ -106,7 +116,7 @@ _GLOBAL(giveup_fpu)
 	addi	r3,r3,THREAD	        /* want THREAD of task */
 	PPC_LL	r5,PT_REGS(r3)
 	PPC_LCMPI	0,r5,0
-	SAVE_32FPRS(0, r3)
+	SAVE_32FPVSRS(0, r4 ,r3)
 	mffs	fr0
 	stfd	fr0,THREAD_FPSCR(r3)
 	beq	1f
Index: linux-2.6-ozlabs/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/head_64.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/head_64.S
@@ -278,6 +278,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	. = 0xf20
 	b	altivec_unavailable_pSeries
 
+	. = 0xf40
+	b	vsx_unavailable_pSeries
+
 #ifdef CONFIG_CBE_RAS
 	HSTD_EXCEPTION_PSERIES(0x1200, cbe_system_error)
 #endif /* CONFIG_CBE_RAS */
@@ -297,6 +300,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	/* moved from 0xf00 */
 	STD_EXCEPTION_PSERIES(., performance_monitor)
 	STD_EXCEPTION_PSERIES(., altivec_unavailable)
+	STD_EXCEPTION_PSERIES(., vsx_unavailable)
 
 /*
  * An interrupt came in while soft-disabled; clear EE in SRR1,
@@ -834,6 +838,67 @@ _STATIC(load_up_altivec)
 	blr
 #endif /* CONFIG_ALTIVEC */
 
+	.align	7
+	.globl vsx_unavailable_common
+vsx_unavailable_common:
+	EXCEPTION_PROLOG_COMMON(0xf40, PACA_EXGEN)
+#ifdef CONFIG_VSX
+BEGIN_FTR_SECTION
+	bne	.load_up_vsx
+1:
+END_FTR_SECTION_IFSET(CPU_FTR_VSX)
+#endif
+	bl	.save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	ENABLE_INTS
+	bl	.vsx_unavailable_exception
+	b	.ret_from_except
+
+#ifdef CONFIG_VSX
+/*
+ * load_up_vsx(unused, unused, tsk)
+ * Disable VSX for the task which had it previously,
+ * and save its vector registers in its thread_struct.
+ * Reuse the fp and vsx saves, but first check to see if they have
+ * been saved already.
+ * On entry: r13 == 'current' && last_task_used_vsx != 'current'
+ */
+_STATIC(load_up_vsx)
+/* Load FP and VSX registers if they haven't been done yet */
+	andi.	r5,r12,MSR_FP
+	beql+	load_up_fpu		/* skip if already loaded */
+	andis.	r5,r12,MSR_VEC@h
+	beql+	load_up_altivec		/* skip if already loaded */
+
+#ifndef CONFIG_SMP
+	ld	r3,last_task_used_vsx@got(r2)
+	ld	r4,0(r3)
+	cmpdi	0,r4,0
+	beq	1f
+	/* Disable VSX for last_task_used_vsx */
+	addi	r4,r4,THREAD
+	ld	r5,PT_REGS(r4)
+	ld	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
+	lis	r6,MSR_VSX@h
+	andc	r6,r4,r6
+	std	r6,_MSR-STACK_FRAME_OVERHEAD(r5)
+1:
+#endif /* CONFIG_SMP */
+	ld	r4,PACACURRENT(r13)
+	addi	r4,r4,THREAD		/* Get THREAD */
+	li	r6,1
+	stw	r6,THREAD_USED_VSR(r4) /* ... also set thread used vsr */
+	/* enable use of VSX after return */
+	oris	r12,r12,MSR_VSX@h
+	std	r12,_MSR(r1)
+#ifndef CONFIG_SMP
+	/* Update last_task_used_math to 'current' */
+	ld	r4,PACACURRENT(r13)
+	std	r4,0(r3)
+#endif /* CONFIG_SMP */
+	b	fast_exception_return
+#endif /* CONFIG_VSX */
+
 /*
  * Hash table stuff
  */
Index: linux-2.6-ozlabs/arch/powerpc/kernel/misc_64.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/misc_64.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/misc_64.S
@@ -506,6 +506,39 @@ _GLOBAL(giveup_altivec)
 
 #endif /* CONFIG_ALTIVEC */
 
+#ifdef CONFIG_VSX
+/*
+ * giveup_vsx(tsk)
+ * Disable VSX for the task given as the argument,
+ * and save the vector registers in its thread_struct.
+ * Enables the VSX for use in the kernel on return.
+ */
+_GLOBAL(giveup_vsx)
+	mfmsr	r5
+	oris	r5,r5,MSR_VSX@h
+	mtmsrd	r5			/* enable use of VSX now */
+	isync
+
+	cmpdi	0,r3,0
+	beqlr-				/* if no previous owner, done */
+	addi	r3,r3,THREAD		/* want THREAD of task */
+	ld	r5,PT_REGS(r3)
+	cmpdi	0,r5,0
+	beq	1f
+	ld	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
+	lis	r3,MSR_VSX@h
+	andc	r4,r4,r3		/* disable VSX for previous task */
+	std	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
+1:
+#ifndef CONFIG_SMP
+	li	r5,0
+	ld	r4,last_task_used_vsx@got(r2)
+	std	r5,0(r4)
+#endif /* CONFIG_SMP */
+	blr
+
+#endif /* CONFIG_VSX */
+
 /* kexec_wait(phys_cpu)
  *
  * wait for the flag to change, indicating this kernel is going away but
Index: linux-2.6-ozlabs/arch/powerpc/kernel/ppc32.h
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/ppc32.h
+++ linux-2.6-ozlabs/arch/powerpc/kernel/ppc32.h
@@ -120,6 +120,7 @@ struct mcontext32 {
 	elf_fpregset_t		mc_fregs;
 	unsigned int		mc_pad[2];
 	elf_vrregset_t32	mc_vregs __attribute__((__aligned__(16)));
+	elf_vsrreghalf_t32      mc_vsregs __attribute__((__aligned__(16)));
 };
 
 struct ucontext32 { 
Index: linux-2.6-ozlabs/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/ppc_ksyms.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/ppc_ksyms.c
@@ -102,6 +102,9 @@ EXPORT_SYMBOL(giveup_fpu);
 #ifdef CONFIG_ALTIVEC
 EXPORT_SYMBOL(giveup_altivec);
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_VSX
+EXPORT_SYMBOL(giveup_vsx);
+#endif /* CONFIG_VSX */
 #ifdef CONFIG_SPE
 EXPORT_SYMBOL(giveup_spe);
 #endif /* CONFIG_SPE */
Index: linux-2.6-ozlabs/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/process.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/process.c
@@ -53,6 +53,7 @@ extern unsigned long _get_SP(void);
 #ifndef CONFIG_SMP
 struct task_struct *last_task_used_math = NULL;
 struct task_struct *last_task_used_altivec = NULL;
+struct task_struct *last_task_used_vsx = NULL;
 struct task_struct *last_task_used_spe = NULL;
 #endif
 
@@ -106,11 +107,23 @@ EXPORT_SYMBOL(enable_kernel_fp);
 
 int dump_task_fpu(struct task_struct *tsk, elf_fpregset_t *fpregs)
 {
+#ifdef CONFIG_VSX
+	int i;
+	elf_fpreg_t *reg;
+#endif
+
 	if (!tsk->thread.regs)
 		return 0;
 	flush_fp_to_thread(current);
 
+#ifdef CONFIG_VSX
+	reg = (elf_fpreg_t *)fpregs;
+	for (i = 0; i < ELF_NFPREG - 1; i++, reg++)
+		*reg = tsk->thread.TS_FPR(i);
+	memcpy(reg, &tsk->thread.fpscr, sizeof(elf_fpreg_t));
+#else
 	memcpy(fpregs, &tsk->thread.TS_FPR(0), sizeof(*fpregs));
+#endif
 
 	return 1;
 }
@@ -149,7 +162,7 @@ void flush_altivec_to_thread(struct task
 	}
 }
 
-int dump_task_altivec(struct task_struct *tsk, elf_vrregset_t *vrregs)
+int dump_task_altivec(struct task_struct *tsk, elf_vrreg_t *vrregs)
 {
 	/* ELF_NVRREG includes the VSCR and VRSAVE which we need to save
 	 * separately, see below */
@@ -179,6 +192,79 @@ int dump_task_altivec(struct task_struct
 }
 #endif /* CONFIG_ALTIVEC */
 
+#ifdef CONFIG_VSX
+#if 0
+/* not currently used, but some crazy RAID module might want to later */
+void enable_kernel_vsx(void)
+{
+	WARN_ON(preemptible());
+
+#ifdef CONFIG_SMP
+	if (current->thread.regs && (current->thread.regs->msr & MSR_VSX))
+		giveup_vsx(current);
+	else
+		giveup_vsx(NULL);	/* just enable vsx for kernel - force */
+#else
+	giveup_vsx(last_task_used_vsx);
+#endif /* CONFIG_SMP */
+}
+EXPORT_SYMBOL(enable_kernel_vsx);
+#endif
+
+void flush_vsx_to_thread(struct task_struct *tsk)
+{
+	if (tsk->thread.regs) {
+		preempt_disable();
+		if (tsk->thread.regs->msr & MSR_VSX) {
+#ifdef CONFIG_SMP
+			BUG_ON(tsk != current);
+#endif
+			giveup_vsx(tsk);
+		}
+		preempt_enable();
+	}
+}
+
+/*
+ * This dumps the full 128bits of the first 32 VSX registers.  This
+ * needs to be called with dump_task_fp and dump_task_altivec to get
+ * all the VSX state.
+ */
+int dump_task_vsx(struct task_struct *tsk, elf_vrreg_t *vrregs)
+{
+	/* Grab only the first half */
+	const int nregs = 32;
+	elf_vrreg_t *reg;
+
+	if (tsk == current)
+		flush_vsx_to_thread(tsk);
+
+	reg = (elf_vrreg_t *)vrregs;
+
+	/* copy the first 32 vsr registers */
+	memcpy(reg, &tsk->thread.vr[0], nregs * sizeof(*reg));
+
+	return 1;
+}
+#endif /* CONFIG_VSX */
+
+int dump_task_vector(struct task_struct *tsk, elf_vrregset_t *vrregs)
+{
+	int rc = 0;
+	elf_vrreg_t *regs = (elf_vrreg_t *)vrregs;
+#ifdef CONFIG_ALTIVEC
+	rc = dump_task_altivec(tsk, regs);
+	if (rc)
+		return rc;
+	regs += ELF_NVRREG;
+#endif
+
+#ifdef CONFIG_VSX
+	rc = dump_task_altivec(tsk, regs);
+#endif
+	return rc;
+}
+
 #ifdef CONFIG_SPE
 
 void enable_kernel_spe(void)
@@ -233,6 +319,10 @@ void discard_lazy_cpu_state(void)
 	if (last_task_used_altivec == current)
 		last_task_used_altivec = NULL;
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_VSX
+	if (last_task_used_vsx == current)
+		last_task_used_vsx = NULL;
+#endif /* CONFIG_VSX */
 #ifdef CONFIG_SPE
 	if (last_task_used_spe == current)
 		last_task_used_spe = NULL;
@@ -297,6 +387,10 @@ struct task_struct *__switch_to(struct t
 	if (prev->thread.regs && (prev->thread.regs->msr & MSR_VEC))
 		giveup_altivec(prev);
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_VSX
+	if (prev->thread.regs && (prev->thread.regs->msr & MSR_VSX))
+		giveup_vsx(prev);
+#endif /* CONFIG_VSX */
 #ifdef CONFIG_SPE
 	/*
 	 * If the previous thread used spe in the last quantum
@@ -317,6 +411,10 @@ struct task_struct *__switch_to(struct t
 	if (new->thread.regs && last_task_used_altivec == new)
 		new->thread.regs->msr |= MSR_VEC;
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_VSX
+	if (new->thread.regs && last_task_used_vsx == new)
+		new->thread.regs->msr |= MSR_VSX;
+#endif /* CONFIG_VSX */
 #ifdef CONFIG_SPE
 	/* Avoid the trap.  On smp this this never happens since
 	 * we don't set last_task_used_spe
@@ -417,6 +515,8 @@ static struct regbit {
 	{MSR_EE,	"EE"},
 	{MSR_PR,	"PR"},
 	{MSR_FP,	"FP"},
+	{MSR_VEC,	"VEC"},
+	{MSR_VSX,	"VSX"},
 	{MSR_ME,	"ME"},
 	{MSR_IR,	"IR"},
 	{MSR_DR,	"DR"},
@@ -534,6 +634,7 @@ void prepare_to_copy(struct task_struct 
 {
 	flush_fp_to_thread(current);
 	flush_altivec_to_thread(current);
+	flush_vsx_to_thread(current);
 	flush_spe_to_thread(current);
 }
 
@@ -689,6 +790,9 @@ void start_thread(struct pt_regs *regs, 
 #endif
 
 	discard_lazy_cpu_state();
+#ifdef CONFIG_VSX
+	current->thread.used_vsr = 0;
+#endif
 	memset(current->thread.fpr, 0,
 	       sizeof(current->thread.fpr));
 	current->thread.fpscr.val = 0;
Index: linux-2.6-ozlabs/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/ptrace.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/ptrace.c
@@ -351,6 +351,51 @@ static int vr_set(struct task_struct *ta
 }
 #endif /* CONFIG_ALTIVEC */
 
+#ifdef CONFIG_VSX
+/*
+ * Currently to set and and get all the vsx state, you need to call
+ * the fp and VMX calls aswell.  This only get/sets the lower 32
+ * 128bit VSX registers.
+ */
+
+static int vsr_active(struct task_struct *target,
+		      const struct user_regset *regset)
+{
+	flush_vsx_to_thread(target);
+	return target->thread.used_vsr ? regset->n : 0;
+}
+
+static int vsr_get(struct task_struct *target, const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	flush_vsx_to_thread(target);
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  target->thread.fpr, 0,
+				  32 * sizeof(vector128));
+
+	return ret;
+}
+
+static int vsr_set(struct task_struct *target, const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	flush_vsx_to_thread(target);
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 target->thread.fpr, 0,
+				 32 * sizeof(vector128));
+
+	return ret;
+}
+#endif /* CONFIG_VSX */
+
 #ifdef CONFIG_SPE
 
 /*
@@ -427,6 +472,9 @@ enum powerpc_regset {
 #ifdef CONFIG_ALTIVEC
 	REGSET_VMX,
 #endif
+#ifdef CONFIG_VSX
+	REGSET_VSX,
+#endif
 #ifdef CONFIG_SPE
 	REGSET_SPE,
 #endif
@@ -450,6 +498,13 @@ static const struct user_regset native_r
 		.active = vr_active, .get = vr_get, .set = vr_set
 	},
 #endif
+#ifdef CONFIG_VSX
+	[REGSET_VSX] = {
+		.core_note_type = NT_PPC_VSX, .n = 34,
+		.size = sizeof(vector128), .align = sizeof(vector128),
+		.active = vsr_active, .get = vsr_get, .set = vsr_set
+	},
+#endif
 #ifdef CONFIG_SPE
 	[REGSET_SPE] = {
 		.n = 35,
@@ -850,6 +905,21 @@ long arch_ptrace(struct task_struct *chi
 						 sizeof(u32)),
 					     (const void __user *) data);
 #endif
+#ifdef CONFIG_VSX
+	case PTRACE_GETVSRREGS:
+		return copy_regset_to_user(child, &user_ppc_native_view,
+					   REGSET_VSX,
+					   0, (32 * sizeof(vector128) +
+					       sizeof(u32)),
+					   (void __user *) data);
+
+	case PTRACE_SETVSRREGS:
+		return copy_regset_from_user(child, &user_ppc_native_view,
+					     REGSET_VSX,
+					     0, (32 * sizeof(vector128) +
+						 sizeof(u32)),
+					     (const void __user *) data);
+#endif
 #ifdef CONFIG_SPE
 	case PTRACE_GETEVRREGS:
 		/* Get the child spe register state. */
Index: linux-2.6-ozlabs/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/signal_32.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/signal_32.c
@@ -378,6 +378,21 @@ static int save_user_regs(struct pt_regs
 	memcpy(&buf[i], &current->thread.fpscr, sizeof(double));
 	if (__copy_to_user(&frame->mc_fregs, buf, ELF_NFPREG * sizeof(double)))
 		return 1;
+	/*
+	 * Copy VSR 0-31 upper half from thread_struct to local
+	 * buffer, then write that to userspace.  Also set MSR_VSX in
+	 * the saved MSR value to indicate that frame->mc_vregs
+	 * contains valid data
+	 */
+	if (current->thread.used_vsr) {
+		flush_vsx_to_thread(current);
+		for (i = 0; i < 32 ; i++)
+			buf[i] = current->thread.fpr[i][TS_VSRLOWOFFSET];
+		if (__copy_to_user(&frame->mc_vsregs, buf,
+				   ELF_NVSRHALFREG  * sizeof(double)))
+			return 1;
+		msr |= MSR_VSX;
+	}
 #else
 	/* save floating-point registers */
 	if (__copy_to_user(&frame->mc_fregs, current->thread.fpr,
@@ -482,6 +497,24 @@ static long restore_user_regs(struct pt_
 	for (i = 0; i < 32 ; i++)
 		current->thread.TS_FPR(i) = buf[i];
 	memcpy(&current->thread.fpscr, &buf[i], sizeof(double));
+	/*
+	 * Force the process to reload the VSX registers from
+	 * current->thread when it next does VSX instruction.
+	 */
+	regs->msr &= ~MSR_VSX;
+	if (msr & MSR_VSX) {
+		/*
+		 * Restore altivec registers from the stack to a local
+		 * buffer, then write this out to the thread_struct
+		 */
+		if (__copy_from_user(buf, &sr->mc_vsregs,
+				     sizeof(sr->mc_vsregs)))
+			return 1;
+		for (i = 0; i < 32 ; i++)
+			current->thread.fpr[i][TS_VSRLOWOFFSET] = buf[i];
+	} else if (current->thread.used_vsr)
+		for (i = 0; i < 32 ; i++)
+			current->thread.fpr[i][TS_VSRLOWOFFSET] = 0;
 #else
 	if (__copy_from_user(current->thread.fpr, &sr->mc_fregs,
 			     sizeof(sr->mc_fregs)))
Index: linux-2.6-ozlabs/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/signal_64.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/signal_64.c
@@ -123,6 +123,22 @@ static long setup_sigcontext(struct sigc
 		buf[i] = current->thread.TS_FPR(i);
 	memcpy(&buf[i], &current->thread.fpscr, sizeof(double));
 	err |= __copy_to_user(&sc->fp_regs, buf, FP_REGS_SIZE);
+	/*
+	 * Copy VSX low doubleword to local buffer for formatting,
+	 * then out to userspace.  Update v_regs to point after the
+	 * VMX data.
+	 */
+	if (current->thread.used_vsr) {
+		flush_vsx_to_thread(current);
+		v_regs += ELF_NVRREG;
+		for (i = 0; i < 32 ; i++)
+			buf[i] = current->thread.fpr[i][TS_VSRLOWOFFSET];
+		err |= __copy_to_user(v_regs, buf, 32 * sizeof(double));
+		/* set MSR_VSX in the MSR value in the frame to
+		 * indicate that sc->vs_reg) contains valid data.
+		 */
+		msr |= MSR_VSX;
+	}
 #else /* CONFIG_VSX */
 	/* copy fpr regs and fpscr */
 	err |= __copy_to_user(&sc->fp_regs, &current->thread.fpr, FP_REGS_SIZE);
@@ -197,7 +213,7 @@ static long restore_sigcontext(struct pt
 	 * This has to be done before copying stuff into current->thread.fpr/vr
 	 * for the reasons explained in the previous comment.
 	 */
-	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1 | MSR_VEC);
+	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1 | MSR_VEC | MSR_VSX);
 
 #ifdef CONFIG_ALTIVEC
 	err |= __get_user(v_regs, &sc->v_regs);
@@ -226,6 +242,19 @@ static long restore_sigcontext(struct pt
 		current->thread.TS_FPR(i) = buf[i];
 	memcpy(&current->thread.fpscr, &buf[i], sizeof(double));
 
+	/*
+	 * Get additional VSX data. Update v_regs to point after the
+	 * VMX data.  Copy VSX low doubleword from userspace to local
+	 * buffer for formatting, then into the taskstruct.
+	 */
+	v_regs += ELF_NVRREG;
+	if ((msr & MSR_VSX) != 0)
+		err |= __copy_from_user(buf, v_regs, 32 * sizeof(double));
+	else
+		memset(buf, 0, 32 * sizeof(double));
+
+	for (i = 0; i < 32 ; i++)
+		current->thread.fpr[i][TS_VSRLOWOFFSET] = buf[i];
 #else
 	err |= __copy_from_user(&current->thread.fpr, &sc->fp_regs, FP_REGS_SIZE);
 #endif
Index: linux-2.6-ozlabs/arch/powerpc/kernel/traps.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/traps.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/traps.c
@@ -967,6 +967,20 @@ void altivec_unavailable_exception(struc
 	die("Unrecoverable VMX/Altivec Unavailable Exception", regs, SIGABRT);
 }
 
+void vsx_unavailable_exception(struct pt_regs *regs)
+{
+	if (user_mode(regs)) {
+		/* A user program has executed an vsx instruction,
+		   but this kernel doesn't support vsx. */
+		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
+		return;
+	}
+
+	printk(KERN_EMERG "Unrecoverable VSX Unavailable Exception "
+			"%lx at %lx\n", regs->trap, regs->nip);
+	die("Unrecoverable VSX Unavailable Exception", regs, SIGABRT);
+}
+
 void performance_monitor_exception(struct pt_regs *regs)
 {
 	perf_irq(regs);
@@ -1091,6 +1105,21 @@ void altivec_assist_exception(struct pt_
 }
 #endif /* CONFIG_ALTIVEC */
 
+#ifdef CONFIG_VSX
+void vsx_assist_exception(struct pt_regs *regs)
+{
+	if (!user_mode(regs)) {
+		printk(KERN_EMERG "VSX assist exception in kernel mode"
+		       " at %lx\n", regs->nip);
+		die("Kernel VSX assist exception", regs, SIGILL);
+	}
+
+	flush_vsx_to_thread(current);
+	printk(KERN_INFO "VSX assist not supported at %lx\n", regs->nip);
+	_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
+}
+#endif /* CONFIG_VSX */
+
 #ifdef CONFIG_FSL_BOOKE
 void CacheLockingException(struct pt_regs *regs, unsigned long address,
 			   unsigned long error_code)
Index: linux-2.6-ozlabs/include/asm-powerpc/elf.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/elf.h
+++ linux-2.6-ozlabs/include/asm-powerpc/elf.h
@@ -109,6 +109,7 @@ typedef elf_gregset_t32 compat_elf_gregs
 #ifdef __powerpc64__
 # define ELF_NVRREG32	33	/* includes vscr & vrsave stuffed together */
 # define ELF_NVRREG	34	/* includes vscr & vrsave in split vectors */
+# define ELF_NVSRHALFREG 32	/* Half the vsx registers */
 # define ELF_GREG_TYPE	elf_greg_t64
 #else
 # define ELF_NEVRREG	34	/* includes acc (as 2) */
@@ -158,6 +159,7 @@ typedef __vector128 elf_vrreg_t;
 typedef elf_vrreg_t elf_vrregset_t[ELF_NVRREG];
 #ifdef __powerpc64__
 typedef elf_vrreg_t elf_vrregset_t32[ELF_NVRREG32];
+typedef elf_fpreg_t elf_vsrreghalf_t32[ELF_NVSRHALFREG];
 #endif
 
 #ifdef __KERNEL__
@@ -219,8 +221,8 @@ extern int dump_task_fpu(struct task_str
 typedef elf_vrregset_t elf_fpxregset_t;
 
 #ifdef CONFIG_ALTIVEC
-extern int dump_task_altivec(struct task_struct *, elf_vrregset_t *vrregs);
-#define ELF_CORE_COPY_XFPREGS(tsk, regs) dump_task_altivec(tsk, regs)
+extern int dump_task_vector(struct task_struct *, elf_vrregset_t *vrregs);
+#define ELF_CORE_COPY_XFPREGS(tsk, regs) dump_task_vector(tsk, regs)
 #define ELF_CORE_XFPREG_TYPE NT_PPC_VMX
 #endif
 
Index: linux-2.6-ozlabs/include/asm-powerpc/ptrace.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/ptrace.h
+++ linux-2.6-ozlabs/include/asm-powerpc/ptrace.h
@@ -223,6 +223,14 @@ extern void user_disable_single_step(str
 #define PT_VRSAVE_32 (PT_VR0 + 33*4)
 #endif
 
+/*
+ * Only store first 32 VSRs here. The second 32 VSRs in VR0-31
+ */
+#define PT_VSR0 150	/* each VSR reg occupies 2 slots in 64-bit */
+#define PT_VSR31 (PT_VSR0 + 2*31)
+#ifdef __KERNEL__
+#define PT_VSR0_32 300 	/* each VSR reg occupies 4 slots in 32-bit */
+#endif
 #endif /* __powerpc64__ */
 
 /*
@@ -245,6 +253,10 @@ extern void user_disable_single_step(str
 #define PTRACE_GETEVRREGS	20
 #define PTRACE_SETEVRREGS	21
 
+/* Get the first 32 128bit VSX registers */
+#define PTRACE_GETVSRREGS	27
+#define PTRACE_SETVSRREGS	28
+
 /*
  * Get or set a debug register. The first 16 are DABR registers and the
  * second 16 are IABR registers.
Index: linux-2.6-ozlabs/include/asm-powerpc/reg.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/reg.h
+++ linux-2.6-ozlabs/include/asm-powerpc/reg.h
@@ -30,6 +30,7 @@
 #define MSR_ISF_LG	61              /* Interrupt 64b mode valid on 630 */
 #define MSR_HV_LG 	60              /* Hypervisor state */
 #define MSR_VEC_LG	25	        /* Enable AltiVec */
+#define MSR_VSX_LG	23		/* Enable VSX */
 #define MSR_POW_LG	18		/* Enable Power Management */
 #define MSR_WE_LG	18		/* Wait State Enable */
 #define MSR_TGPR_LG	17		/* TLB Update registers in use */
@@ -71,6 +72,7 @@
 #endif
 
 #define MSR_VEC		__MASK(MSR_VEC_LG)	/* Enable AltiVec */
+#define MSR_VSX		__MASK(MSR_VSX_LG)	/* Enable VSX */
 #define MSR_POW		__MASK(MSR_POW_LG)	/* Enable Power Management */
 #define MSR_WE		__MASK(MSR_WE_LG)	/* Wait State Enable */
 #define MSR_TGPR	__MASK(MSR_TGPR_LG)	/* TLB Update registers in use */
Index: linux-2.6-ozlabs/include/asm-powerpc/sigcontext.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/sigcontext.h
+++ linux-2.6-ozlabs/include/asm-powerpc/sigcontext.h
@@ -43,9 +43,44 @@ struct sigcontext {
  * it must be copied via a vector register to/from storage) or as a word.
  * The entry with index 33 contains the vrsave as the first word (offset 0)
  * within the quadword.
+ *
+ * Part of the VSX data is stored here also by extending vmx_restore
+ * by an additional 32 double words.  Architecturally the layout of
+ * the VSR registers and how they overlap on top of the legacy FPR and
+ * VR registers is shown below:
+ *
+ *                    VSR doubleword 0               VSR doubleword 1
+ *           ----------------------------------------------------------------
+ *   VSR[0]  |             FPR[0]            |                              |
+ *           ----------------------------------------------------------------
+ *   VSR[1]  |             FPR[1]            |                              |
+ *           ----------------------------------------------------------------
+ *           |              ...              |                              |
+ *           |              ...              |                              |
+ *           ----------------------------------------------------------------
+ *   VSR[30] |             FPR[30]           |                              |
+ *           ----------------------------------------------------------------
+ *   VSR[31] |             FPR[31]           |                              |
+ *           ----------------------------------------------------------------
+ *   VSR[32] |                             VR[0]                            |
+ *           ----------------------------------------------------------------
+ *   VSR[33] |                             VR[1]                            |
+ *           ----------------------------------------------------------------
+ *           |                              ...                             |
+ *           |                              ...                             |
+ *           ----------------------------------------------------------------
+ *   VSR[62] |                             VR[30]                           |
+ *           ----------------------------------------------------------------
+ *   VSR[63] |                             VR[31]                           |
+ *           ----------------------------------------------------------------
+ *
+ * FPR/VSR 0-31 doubleword 0 is stored in fp_regs, and VMX/VSR 32-63
+ * is stored at the start of vmx_reserve.  vmx_reserve is extended for
+ * backwards compatility to store VSR 0-31 doubleword 1 after the VMX
+ * registers and vscr/vrsave.
  */
 	elf_vrreg_t	__user *v_regs;
-	long		vmx_reserve[ELF_NVRREG+ELF_NVRREG+1];
+	long		vmx_reserve[ELF_NVRREG+ELF_NVRREG+32+1];
 #endif
 };
 
Index: linux-2.6-ozlabs/include/asm-powerpc/system.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/system.h
+++ linux-2.6-ozlabs/include/asm-powerpc/system.h
@@ -132,6 +132,7 @@ extern void enable_kernel_altivec(void);
 extern void giveup_altivec(struct task_struct *);
 extern void load_up_altivec(struct task_struct *);
 extern int emulate_altivec(struct pt_regs *);
+extern void giveup_vsx(struct task_struct *);
 extern void enable_kernel_spe(void);
 extern void giveup_spe(struct task_struct *);
 extern void load_up_spe(struct task_struct *);
@@ -155,6 +156,14 @@ static inline void flush_altivec_to_thre
 }
 #endif
 
+#ifdef CONFIG_VSX
+extern void flush_vsx_to_thread(struct task_struct *);
+#else
+static inline void flush_vsx_to_thread(struct task_struct *t)
+{
+}
+#endif
+
 #ifdef CONFIG_SPE
 extern void flush_spe_to_thread(struct task_struct *);
 #else
Index: linux-2.6-ozlabs/include/linux/elf.h
===================================================================
--- linux-2.6-ozlabs.orig/include/linux/elf.h
+++ linux-2.6-ozlabs/include/linux/elf.h
@@ -358,6 +358,7 @@ typedef struct elf64_shdr {
 #define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/common.h */
 #define NT_PPC_VMX	0x100		/* PowerPC Altivec/VMX registers */
 #define NT_PPC_SPE	0x101		/* PowerPC SPE/EVR registers */
+#define NT_PPC_VSX	0x102		/* PowerPC VSX registers */
 #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
 
 
