Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 08/17] powerpc: Add FP/VSX and VMX register load functions for
 transactional memory
Date: Fri, 18 Jan 2013 16:48:28 +1100
Message-Id: <1358488117-17363-9-git-send-email-mikey@neuling.org>
In-Reply-To: <1358488117-17363-1-git-send-email-mikey@neuling.org>
References: <1358488117-17363-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds functions to restore the state of the FP/VSX registers from
what's stored in the thread_struct.  Two version for FP/VSX are required
since one restores them from transactional/checkpoint side of the
thread_struct and the other from the speculated side.

Similar functions are added for VMX registers.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/fpu.S    |   54 ++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/vector.S |   51 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index adb1551..6ab0e87 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -62,6 +62,60 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
 	__REST_32FPVSRS_TRANSACT(n,__REG_##c,__REG_##base)
 #define SAVE_32FPVSRS(n,c,base) __SAVE_32FPVSRS(n,__REG_##c,__REG_##base)
 
+#ifdef CONFIG_TRANSACTIONAL_MEM
+/*
+ * Wrapper to call load_up_fpu from C.
+ * void do_load_up_fpu(struct pt_regs *regs);
+ */
+_GLOBAL(do_load_up_fpu)
+	mflr	r0
+	std	r0, 16(r1)
+	stdu	r1, -112(r1)
+
+	subi	r6, r3, STACK_FRAME_OVERHEAD
+	/* load_up_fpu expects r12=MSR, r13=PACA, and returns
+	 * with r12 = new MSR.
+	 */
+	ld	r12,_MSR(r6)
+	GET_PACA(r13)
+
+	bl	load_up_fpu
+	std	r12,_MSR(r6)
+
+	ld	r0, 112+16(r1)
+	addi	r1, r1, 112
+	mtlr	r0
+	blr
+
+
+/* void do_load_up_fpu(struct thread_struct *thread)
+ *
+ * This is similar to load_up_fpu but for the transactional version of the FP
+ * register set.  It doesn't mess with the task MSR or valid flags.
+ * Furthermore, we don't do lazy FP with TM currently.
+ */
+_GLOBAL(do_load_up_transact_fpu)
+	mfmsr	r6
+	ori	r5,r6,MSR_FP
+#ifdef CONFIG_VSX
+BEGIN_FTR_SECTION
+	oris	r5,r5,MSR_VSX@h
+END_FTR_SECTION_IFSET(CPU_FTR_VSX)
+#endif
+	SYNC
+	MTMSRD(r5)
+
+	lfd	fr0,THREAD_TRANSACT_FPSCR(r3)
+	MTFSF_L(fr0)
+	REST_32FPVSRS_TRANSACT(0, R4, R3)
+
+	/* FP/VSX off again */
+	MTMSRD(r6)
+	SYNC
+
+	blr
+#endif /* CONFIG_TRANSACTIONAL_MEM */
+
 /*
  * This task wants to use the FPU now.
  * On UP, disable FP for the task which had the FPU previously,
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index e830289..330fc8c 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -7,6 +7,57 @@
 #include <asm/page.h>
 #include <asm/ptrace.h>
 
+#ifdef CONFIG_TRANSACTIONAL_MEM
+/*
+ * Wrapper to call load_up_altivec from C.
+ * void do_load_up_altivec(struct pt_regs *regs);
+ */
+_GLOBAL(do_load_up_altivec)
+	mflr	r0
+	std	r0, 16(r1)
+	stdu	r1, -112(r1)
+
+	subi	r6, r3, STACK_FRAME_OVERHEAD
+	/* load_up_altivec expects r12=MSR, r13=PACA, and returns
+	 * with r12 = new MSR.
+	 */
+	ld	r12,_MSR(r6)
+	GET_PACA(r13)
+	bl	load_up_altivec
+	std	r12,_MSR(r6)
+
+	ld	r0, 112+16(r1)
+	addi	r1, r1, 112
+	mtlr	r0
+	blr
+
+/* void do_load_up_altivec(struct thread_struct *thread)
+ *
+ * This is similar to load_up_altivec but for the transactional version of the
+ * vector regs.  It doesn't mess with the task MSR or valid flags.
+ * Furthermore, VEC laziness is not supported with TM currently.
+ */
+_GLOBAL(do_load_up_transact_altivec)
+	mfmsr	r6
+	oris	r5,r6,MSR_VEC@h
+	MTMSRD(r5)
+	isync
+
+	li	r4,1
+	stw	r4,THREAD_USED_VR(r3)
+
+	li	r10,THREAD_TRANSACT_VSCR
+	lvx	vr0,r10,r3
+	mtvscr	vr0
+	REST_32VRS_TRANSACT(0,r4,r3)
+
+	/* Disable VEC again. */
+	MTMSRD(r6)
+	isync
+
+	blr
+#endif
+
 /*
  * load_up_altivec(unused, unused, tsk)
  * Disable VMX for the task which had it previously,
-- 
1.7.10.4
