Return-Path: <paulus@ozlabs.org>
Date: Tue, 10 Sep 2013 20:21:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/6] powerpc: Provide for giveup_fpu/altivec to save state in
 alternate location
Message-ID: <20130910102110.GC28145@iris.ozlabs.ibm.com>
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

This provides a facility which is intended for use by KVM, where the
contents of the FP/VSX and VMX (Altivec) registers can be saved away
to somewhere other than the thread_struct when kernel code wants to
use floating point or VMX instructions.  This is done by providing a
pointer in the thread_struct to indicate where the state should be
saved to.  The giveup_fpu() and giveup_altivec() functions test these
pointers and save state to the indicated location if they are non-NULL.
Note that the MSR_FP/VEC bits in task->thread.regs->msr are still used
to indicate whether the CPU register state is live, even when an
alternate save location is being used.

This also provides load_fp_state() and load_vr_state() functions, which
load up FP/VSX and VMX state from memory into the CPU registers, and
corresponding store_fp_state() and store_vr_state() functions, which
store FP/VSX and VMX state into memory from the CPU registers.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/processor.h |  7 +++++++
 arch/powerpc/kernel/asm-offsets.c    |  2 ++
 arch/powerpc/kernel/fpu.S            | 25 ++++++++++++++++++++++++-
 arch/powerpc/kernel/ppc_ksyms.c      |  4 ++++
 arch/powerpc/kernel/process.c        |  7 +++++++
 arch/powerpc/kernel/vector.S         | 29 +++++++++++++++++++++++++++--
 6 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 92f709d..8bc9d66 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -212,6 +212,7 @@ struct thread_struct {
 #endif
 #endif
 	struct thread_fp_state	fp_state;
+	struct thread_fp_state	*fp_save_area;
 	int		fpexc_mode;	/* floating-point exception mode */
 	unsigned int	align_ctl;	/* alignment handling control */
 #ifdef CONFIG_PPC64
@@ -230,6 +231,7 @@ struct thread_struct {
 	unsigned long	trap_nr;	/* last trap # on this thread */
 #ifdef CONFIG_ALTIVEC
 	struct thread_vr_state vr_state;
+	struct thread_vr_state *vr_save_area;
 	unsigned long	vrsave;
 	int		used_vr;	/* set if process has used altivec */
 #endif /* CONFIG_ALTIVEC */
@@ -359,6 +361,11 @@ extern int set_endian(struct task_struct *tsk, unsigned int val);
 extern int get_unalign_ctl(struct task_struct *tsk, unsigned long adr);
 extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
 
+extern void load_fp_state(struct thread_fp_state *fp);
+extern void store_fp_state(struct thread_fp_state *fp);
+extern void load_vr_state(struct thread_vr_state *vr);
+extern void store_vr_state(struct thread_vr_state *vr);
+
 static inline unsigned int __unpack_fe01(unsigned long msr_bits)
 {
 	return ((msr_bits & MSR_FE0) >> 10) | ((msr_bits & MSR_FE1) >> 8);
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 38ebe36..9049197 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -90,9 +90,11 @@ int main(void)
 #endif
 	DEFINE(THREAD_FPEXC_MODE, offsetof(struct thread_struct, fpexc_mode));
 	DEFINE(THREAD_FPSTATE, offsetof(struct thread_struct, fp_state));
+	DEFINE(THREAD_FPSAVEAREA, offsetof(struct thread_struct, fp_save_area));
 	DEFINE(FPSTATE_FPSCR, offsetof(struct thread_fp_state, fpscr));
 #ifdef CONFIG_ALTIVEC
 	DEFINE(THREAD_VRSTATE, offsetof(struct thread_struct, vr_state));
+	DEFINE(THREAD_VRSAVEAREA, offsetof(struct thread_struct, vr_save_area));
 	DEFINE(THREAD_VRSAVE, offsetof(struct thread_struct, vrsave));
 	DEFINE(THREAD_USED_VR, offsetof(struct thread_struct, used_vr));
 	DEFINE(VRSTATE_VSCR, offsetof(struct thread_vr_state, vscr));
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index 34b96e6..4dca05e 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -81,6 +81,26 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
 /*
+ * Load state from memory into FP registers including FPSCR.
+ * Assumes the caller has enabled FP in the MSR.
+ */
+_GLOBAL(load_fp_state)
+	lfd	fr0,FPSTATE_FPSCR(r3)
+	MTFSF_L(fr0)
+	REST_32FPVSRS(0, R4, R3)
+	blr
+
+/*
+ * Store FP state into memory, including FPSCR
+ * Assumes the caller has enabled FP in the MSR.
+ */
+_GLOBAL(store_fp_state)
+	SAVE_32FPVSRS(0, R4, R3)
+	mffs	fr0
+	stfd	fr0,FPSTATE_FPSCR(r3)
+	blr
+
+/*
  * This task wants to use the FPU now.
  * On UP, disable FP for the task which had the FPU previously,
  * and save its floating-point registers in its thread_struct.
@@ -172,9 +192,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	PPC_LCMPI	0,r3,0
 	beqlr-				/* if no previous owner, done */
 	addi	r3,r3,THREAD	        /* want THREAD of task */
+	PPC_LL	r6,THREAD_FPSAVEAREA(r3)
 	PPC_LL	r5,PT_REGS(r3)
-	PPC_LCMPI	0,r5,0
+	PPC_LCMPI	0,r6,0
+	bne	2f
 	addi	r6,r3,THREAD_FPSTATE
+2:	PPC_LCMPI	0,r5,0
 	SAVE_32FPVSRS(0, R4, R6)
 	mffs	fr0
 	stfd	fr0,FPSTATE_FPSCR(r6)
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 21646db..56a4bec 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -98,9 +98,13 @@ EXPORT_SYMBOL(start_thread);
 
 #ifdef CONFIG_PPC_FPU
 EXPORT_SYMBOL(giveup_fpu);
+EXPORT_SYMBOL(load_fp_state);
+EXPORT_SYMBOL(store_fp_state);
 #endif
 #ifdef CONFIG_ALTIVEC
 EXPORT_SYMBOL(giveup_altivec);
+EXPORT_SYMBOL(load_vr_state);
+EXPORT_SYMBOL(store_vr_state);
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_VSX
 EXPORT_SYMBOL(giveup_vsx);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 94c1257..69785a5 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1007,6 +1007,11 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	p->thread.ptrace_bps[0] = NULL;
 #endif
 
+	p->thread.fp_save_area = NULL;
+#ifdef CONFIG_ALTIVEC
+	p->thread.vr_save_area = NULL;
+#endif
+
 #ifdef CONFIG_PPC_STD_MMU_64
 	if (mmu_has_feature(MMU_FTR_SLB)) {
 		unsigned long sp_vsid;
@@ -1113,9 +1118,11 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	current->thread.used_vsr = 0;
 #endif
 	memset(&current->thread.fp_state, 0, sizeof(current->thread.fp_state));
+	current->thread.fp_save_area = NULL;
 #ifdef CONFIG_ALTIVEC
 	memset(&current->thread.vr_state, 0, sizeof(current->thread.vr_state));
 	current->thread.vr_state.vscr.u[3] = 0x00010000; /* Java mode disabled */
+	current->thread.vr_save_area = NULL;
 	current->thread.vrsave = 0;
 	current->thread.used_vr = 0;
 #endif /* CONFIG_ALTIVEC */
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index a48df87..eacda4e 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -37,6 +37,28 @@ _GLOBAL(do_load_up_transact_altivec)
 #endif
 
 /*
+ * Load state from memory into VMX registers including VSCR.
+ * Assumes the caller has enabled VMX in the MSR.
+ */
+_GLOBAL(load_vr_state)
+	li	r4,VRSTATE_VSCR
+	lvx	vr0,r4,r3
+	mtvscr	vr0
+	REST_32VRS(0,r4,r3)
+	blr
+
+/*
+ * Store VMX state into memory, including VSCR.
+ * Assumes the caller has enabled VMX in the MSR.
+ */
+_GLOBAL(store_vr_state)
+	SAVE_32VRS(0, r4, r3)
+	mfvscr	vr0
+	li	r4, VRSTATE_VSCR
+	stvx	vr0, r4, r3
+	blr
+
+/*
  * Disable VMX for the task which had it previously,
  * and save its vector registers in its thread_struct.
  * Enables the VMX for use in the kernel on return.
@@ -144,9 +166,12 @@ _GLOBAL(giveup_altivec)
 	PPC_LCMPI	0,r3,0
 	beqlr				/* if no previous owner, done */
 	addi	r3,r3,THREAD		/* want THREAD of task */
-	addi	r7,r3,THREAD_VRSTATE
+	PPC_LL	r7,THREAD_VRSAVEAREA(r3)
 	PPC_LL	r5,PT_REGS(r3)
-	PPC_LCMPI	0,r5,0
+	PPC_LCMPI	0,r7,0
+	bne	2f
+	addi	r7,r3,THREAD_VRSTATE
+2:	PPC_LCMPI	0,r5,0
 	SAVE_32VRS(0,r4,r7)
 	mfvscr	vr0
 	li	r4,VRSTATE_VSCR
-- 
1.8.4.rc3
