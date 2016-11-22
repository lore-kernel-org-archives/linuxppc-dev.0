Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNWKV2dJqzDvrm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 03:35:10 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAMGYLIg065922
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:35:07 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26vpk6g260-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:35:06 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 23 Nov 2016 02:35:03 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4C92F2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 03:35:00 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAMGZ0ZB33554456
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 03:35:00 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAMGYxJD018060
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 03:35:00 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 Torsten Duwe <duwe@lst.de>
Subject: [PATCH v2] powerpc: split ftrace bits into a separate file
Date: Tue, 22 Nov 2016 22:04:39 +0530
Message-Id: <20161122163439.524-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

entry_*.S now includes a lot more than just kernel entry/exit code. As a
first step at cleaning this up, let's split out the ftrace bits into
separate files.

No functional changes.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
v2: updated commit description.

 arch/powerpc/kernel/Makefile    |   2 +
 arch/powerpc/kernel/entry_32.S  | 107 -----------
 arch/powerpc/kernel/entry_64.S  | 380 --------------------------------------
 arch/powerpc/kernel/ftrace_32.S | 118 ++++++++++++
 arch/powerpc/kernel/ftrace_64.S | 391 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 511 insertions(+), 487 deletions(-)
 create mode 100644 arch/powerpc/kernel/ftrace_32.S
 create mode 100644 arch/powerpc/kernel/ftrace_64.S

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 26b5a5e..298c98d 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -112,6 +112,8 @@ obj64-$(CONFIG_AUDIT)		+= compat_audit.o
 
 obj-$(CONFIG_PPC_IO_WORKAROUNDS)	+= io-workarounds.o
 
+obj32-$(CONFIG_FUNCTION_TRACER)	+= ftrace_32.o
+obj64-$(CONFIG_FUNCTION_TRACER)	+= ftrace_64.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
 obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 3841d74..5b30eb9 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -31,7 +31,6 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/unistd.h>
-#include <asm/ftrace.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
 
@@ -1304,109 +1303,3 @@ machine_check_in_rtas:
 	/* XXX load up BATs and panic */
 
 #endif /* CONFIG_PPC_RTAS */
-
-#ifdef CONFIG_FUNCTION_TRACER
-#ifdef CONFIG_DYNAMIC_FTRACE
-_GLOBAL(mcount)
-_GLOBAL(_mcount)
-	/*
-	 * It is required that _mcount on PPC32 must preserve the
-	 * link register. But we have r0 to play with. We use r0
-	 * to push the return address back to the caller of mcount
-	 * into the ctr register, restore the link register and
-	 * then jump back using the ctr register.
-	 */
-	mflr	r0
-	mtctr	r0
-	lwz	r0, 4(r1)
-	mtlr	r0
-	bctr
-
-_GLOBAL(ftrace_caller)
-	MCOUNT_SAVE_FRAME
-	/* r3 ends up with link register */
-	subi	r3, r3, MCOUNT_INSN_SIZE
-.globl ftrace_call
-ftrace_call:
-	bl	ftrace_stub
-	nop
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-.globl ftrace_graph_call
-ftrace_graph_call:
-	b	ftrace_graph_stub
-_GLOBAL(ftrace_graph_stub)
-#endif
-	MCOUNT_RESTORE_FRAME
-	/* old link register ends up in ctr reg */
-	bctr
-#else
-_GLOBAL(mcount)
-_GLOBAL(_mcount)
-
-	MCOUNT_SAVE_FRAME
-
-	subi	r3, r3, MCOUNT_INSN_SIZE
-	LOAD_REG_ADDR(r5, ftrace_trace_function)
-	lwz	r5,0(r5)
-
-	mtctr	r5
-	bctrl
-	nop
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	b	ftrace_graph_caller
-#endif
-	MCOUNT_RESTORE_FRAME
-	bctr
-#endif
-EXPORT_SYMBOL(_mcount)
-
-_GLOBAL(ftrace_stub)
-	blr
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-_GLOBAL(ftrace_graph_caller)
-	/* load r4 with local address */
-	lwz	r4, 44(r1)
-	subi	r4, r4, MCOUNT_INSN_SIZE
-
-	/* Grab the LR out of the caller stack frame */
-	lwz	r3,52(r1)
-
-	bl	prepare_ftrace_return
-	nop
-
-        /*
-         * prepare_ftrace_return gives us the address we divert to.
-         * Change the LR in the callers stack frame to this.
-         */
-	stw	r3,52(r1)
-
-	MCOUNT_RESTORE_FRAME
-	/* old link register ends up in ctr reg */
-	bctr
-
-_GLOBAL(return_to_handler)
-	/* need to save return values */
-	stwu	r1, -32(r1)
-	stw	r3, 20(r1)
-	stw	r4, 16(r1)
-	stw	r31, 12(r1)
-	mr	r31, r1
-
-	bl	ftrace_return_to_handler
-	nop
-
-	/* return value has real return address */
-	mtlr	r3
-
-	lwz	r3, 20(r1)
-	lwz	r4, 16(r1)
-	lwz	r31,12(r1)
-	lwz	r1, 0(r1)
-
-	/* Jump back to real return address */
-	blr
-#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-
-#endif /* CONFIG_FUNCTION_TRACER */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 6432d4b..9b541d2 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -20,7 +20,6 @@
 
 #include <linux/errno.h>
 #include <linux/err.h>
-#include <linux/magic.h>
 #include <asm/unistd.h>
 #include <asm/processor.h>
 #include <asm/page.h>
@@ -33,7 +32,6 @@
 #include <asm/bug.h>
 #include <asm/ptrace.h>
 #include <asm/irqflags.h>
-#include <asm/ftrace.h>
 #include <asm/hw_irq.h>
 #include <asm/context_tracking.h>
 #include <asm/tm.h>
@@ -1173,381 +1171,3 @@ _GLOBAL(enter_prom)
 	ld	r0,16(r1)
 	mtlr    r0
         blr
-
-#ifdef CONFIG_FUNCTION_TRACER
-#ifdef CONFIG_DYNAMIC_FTRACE
-_GLOBAL(mcount)
-_GLOBAL(_mcount)
-EXPORT_SYMBOL(_mcount)
-	mflr	r12
-	mtctr	r12
-	mtlr	r0
-	bctr
-
-#ifndef CC_USING_MPROFILE_KERNEL
-_GLOBAL_TOC(ftrace_caller)
-	/* Taken from output of objdump from lib64/glibc */
-	mflr	r3
-	ld	r11, 0(r1)
-	stdu	r1, -112(r1)
-	std	r3, 128(r1)
-	ld	r4, 16(r11)
-	subi	r3, r3, MCOUNT_INSN_SIZE
-.globl ftrace_call
-ftrace_call:
-	bl	ftrace_stub
-	nop
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-.globl ftrace_graph_call
-ftrace_graph_call:
-	b	ftrace_graph_stub
-_GLOBAL(ftrace_graph_stub)
-#endif
-	ld	r0, 128(r1)
-	mtlr	r0
-	addi	r1, r1, 112
-
-#else /* CC_USING_MPROFILE_KERNEL */
-/*
- *
- * ftrace_caller() is the function that replaces _mcount() when ftrace is
- * active.
- *
- * We arrive here after a function A calls function B, and we are the trace
- * function for B. When we enter r1 points to A's stack frame, B has not yet
- * had a chance to allocate one yet.
- *
- * Additionally r2 may point either to the TOC for A, or B, depending on
- * whether B did a TOC setup sequence before calling us.
- *
- * On entry the LR points back to the _mcount() call site, and r0 holds the
- * saved LR as it was on entry to B, ie. the original return address at the
- * call site in A.
- *
- * Our job is to save the register state into a struct pt_regs (on the stack)
- * and then arrange for the ftrace function to be called.
- */
-_GLOBAL(ftrace_caller)
-	/* Save the original return address in A's stack frame */
-	std	r0,LRSAVE(r1)
-
-	/* Create our stack frame + pt_regs */
-	stdu	r1,-SWITCH_FRAME_SIZE(r1)
-
-	/* Save all gprs to pt_regs */
-	SAVE_8GPRS(0,r1)
-	SAVE_8GPRS(8,r1)
-	SAVE_8GPRS(16,r1)
-	SAVE_8GPRS(24,r1)
-
-	/* Load special regs for save below */
-	mfmsr   r8
-	mfctr   r9
-	mfxer   r10
-	mfcr	r11
-
-	/* Get the _mcount() call site out of LR */
-	mflr	r7
-	/* Save it as pt_regs->nip & pt_regs->link */
-	std     r7, _NIP(r1)
-	std     r7, _LINK(r1)
-
-	/* Save callee's TOC in the ABI compliant location */
-	std	r2, 24(r1)
-	ld	r2,PACATOC(r13)	/* get kernel TOC in r2 */
-
-	addis	r3,r2,function_trace_op@toc@ha
-	addi	r3,r3,function_trace_op@toc@l
-	ld	r5,0(r3)
-
-#ifdef CONFIG_LIVEPATCH
-	mr	r14,r7		/* remember old NIP */
-#endif
-	/* Calculate ip from nip-4 into r3 for call below */
-	subi    r3, r7, MCOUNT_INSN_SIZE
-
-	/* Put the original return address in r4 as parent_ip */
-	mr	r4, r0
-
-	/* Save special regs */
-	std     r8, _MSR(r1)
-	std     r9, _CTR(r1)
-	std     r10, _XER(r1)
-	std     r11, _CCR(r1)
-
-	/* Load &pt_regs in r6 for call below */
-	addi    r6, r1 ,STACK_FRAME_OVERHEAD
-
-	/* ftrace_call(r3, r4, r5, r6) */
-.globl ftrace_call
-ftrace_call:
-	bl	ftrace_stub
-	nop
-
-	/* Load ctr with the possibly modified NIP */
-	ld	r3, _NIP(r1)
-	mtctr	r3
-#ifdef CONFIG_LIVEPATCH
-	cmpd	r14,r3		/* has NIP been altered? */
-#endif
-
-	/* Restore gprs */
-	REST_8GPRS(0,r1)
-	REST_8GPRS(8,r1)
-	REST_8GPRS(16,r1)
-	REST_8GPRS(24,r1)
-
-	/* Restore callee's TOC */
-	ld	r2, 24(r1)
-
-	/* Pop our stack frame */
-	addi r1, r1, SWITCH_FRAME_SIZE
-
-	/* Restore original LR for return to B */
-	ld	r0, LRSAVE(r1)
-	mtlr	r0
-
-#ifdef CONFIG_LIVEPATCH
-        /* Based on the cmpd above, if the NIP was altered handle livepatch */
-	bne-	livepatch_handler
-#endif
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	stdu	r1, -112(r1)
-.globl ftrace_graph_call
-ftrace_graph_call:
-	b	ftrace_graph_stub
-_GLOBAL(ftrace_graph_stub)
-	addi	r1, r1, 112
-#endif
-
-	ld	r0,LRSAVE(r1)	/* restore callee's lr at _mcount site */
-	mtlr	r0
-	bctr			/* jump after _mcount site */
-#endif /* CC_USING_MPROFILE_KERNEL */
-
-_GLOBAL(ftrace_stub)
-	blr
-
-#ifdef CONFIG_LIVEPATCH
-	/*
-	 * This function runs in the mcount context, between two functions. As
-	 * such it can only clobber registers which are volatile and used in
-	 * function linkage.
-	 *
-	 * We get here when a function A, calls another function B, but B has
-	 * been live patched with a new function C.
-	 *
-	 * On entry:
-	 *  - we have no stack frame and can not allocate one
-	 *  - LR points back to the original caller (in A)
-	 *  - CTR holds the new NIP in C
-	 *  - r0 & r12 are free
-	 *
-	 * r0 can't be used as the base register for a DS-form load or store, so
-	 * we temporarily shuffle r1 (stack pointer) into r0 and then put it back.
-	 */
-livepatch_handler:
-	CURRENT_THREAD_INFO(r12, r1)
-
-	/* Save stack pointer into r0 */
-	mr	r0, r1
-
-	/* Allocate 3 x 8 bytes */
-	ld	r1, TI_livepatch_sp(r12)
-	addi	r1, r1, 24
-	std	r1, TI_livepatch_sp(r12)
-
-	/* Save toc & real LR on livepatch stack */
-	std	r2,  -24(r1)
-	mflr	r12
-	std	r12, -16(r1)
-
-	/* Store stack end marker */
-	lis     r12, STACK_END_MAGIC@h
-	ori     r12, r12, STACK_END_MAGIC@l
-	std	r12, -8(r1)
-
-	/* Restore real stack pointer */
-	mr	r1, r0
-
-	/* Put ctr in r12 for global entry and branch there */
-	mfctr	r12
-	bctrl
-
-	/*
-	 * Now we are returning from the patched function to the original
-	 * caller A. We are free to use r0 and r12, and we can use r2 until we
-	 * restore it.
-	 */
-
-	CURRENT_THREAD_INFO(r12, r1)
-
-	/* Save stack pointer into r0 */
-	mr	r0, r1
-
-	ld	r1, TI_livepatch_sp(r12)
-
-	/* Check stack marker hasn't been trashed */
-	lis     r2,  STACK_END_MAGIC@h
-	ori     r2,  r2, STACK_END_MAGIC@l
-	ld	r12, -8(r1)
-1:	tdne	r12, r2
-	EMIT_BUG_ENTRY 1b, __FILE__, __LINE__ - 1, 0
-
-	/* Restore LR & toc from livepatch stack */
-	ld	r12, -16(r1)
-	mtlr	r12
-	ld	r2,  -24(r1)
-
-	/* Pop livepatch stack frame */
-	CURRENT_THREAD_INFO(r12, r0)
-	subi	r1, r1, 24
-	std	r1, TI_livepatch_sp(r12)
-
-	/* Restore real stack pointer */
-	mr	r1, r0
-
-	/* Return to original caller of live patched function */
-	blr
-#endif
-
-
-#else
-_GLOBAL_TOC(_mcount)
-EXPORT_SYMBOL(_mcount)
-	/* Taken from output of objdump from lib64/glibc */
-	mflr	r3
-	ld	r11, 0(r1)
-	stdu	r1, -112(r1)
-	std	r3, 128(r1)
-	ld	r4, 16(r11)
-
-	subi	r3, r3, MCOUNT_INSN_SIZE
-	LOAD_REG_ADDR(r5,ftrace_trace_function)
-	ld	r5,0(r5)
-	ld	r5,0(r5)
-	mtctr	r5
-	bctrl
-	nop
-
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	b	ftrace_graph_caller
-#endif
-	ld	r0, 128(r1)
-	mtlr	r0
-	addi	r1, r1, 112
-_GLOBAL(ftrace_stub)
-	blr
-
-#endif /* CONFIG_DYNAMIC_FTRACE */
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-#ifndef CC_USING_MPROFILE_KERNEL
-_GLOBAL(ftrace_graph_caller)
-	/* load r4 with local address */
-	ld	r4, 128(r1)
-	subi	r4, r4, MCOUNT_INSN_SIZE
-
-	/* Grab the LR out of the caller stack frame */
-	ld	r11, 112(r1)
-	ld	r3, 16(r11)
-
-	bl	prepare_ftrace_return
-	nop
-
-	/*
-	 * prepare_ftrace_return gives us the address we divert to.
-	 * Change the LR in the callers stack frame to this.
-	 */
-	ld	r11, 112(r1)
-	std	r3, 16(r11)
-
-	ld	r0, 128(r1)
-	mtlr	r0
-	addi	r1, r1, 112
-	blr
-
-#else /* CC_USING_MPROFILE_KERNEL */
-_GLOBAL(ftrace_graph_caller)
-	/* with -mprofile-kernel, parameter regs are still alive at _mcount */
-	std	r10, 104(r1)
-	std	r9, 96(r1)
-	std	r8, 88(r1)
-	std	r7, 80(r1)
-	std	r6, 72(r1)
-	std	r5, 64(r1)
-	std	r4, 56(r1)
-	std	r3, 48(r1)
-
-	/* Save callee's TOC in the ABI compliant location */
-	std	r2, 24(r1)
-	ld	r2, PACATOC(r13)	/* get kernel TOC in r2 */
-
-	mfctr	r4		/* ftrace_caller has moved local addr here */
-	std	r4, 40(r1)
-	mflr	r3		/* ftrace_caller has restored LR from stack */
-	subi	r4, r4, MCOUNT_INSN_SIZE
-
-	bl	prepare_ftrace_return
-	nop
-
-	/*
-	 * prepare_ftrace_return gives us the address we divert to.
-	 * Change the LR to this.
-	 */
-	mtlr	r3
-
-	ld	r0, 40(r1)
-	mtctr	r0
-	ld	r10, 104(r1)
-	ld	r9, 96(r1)
-	ld	r8, 88(r1)
-	ld	r7, 80(r1)
-	ld	r6, 72(r1)
-	ld	r5, 64(r1)
-	ld	r4, 56(r1)
-	ld	r3, 48(r1)
-
-	/* Restore callee's TOC */
-	ld	r2, 24(r1)
-
-	addi	r1, r1, 112
-	mflr	r0
-	std	r0, LRSAVE(r1)
-	bctr
-#endif /* CC_USING_MPROFILE_KERNEL */
-
-_GLOBAL(return_to_handler)
-	/* need to save return values */
-	std	r4,  -32(r1)
-	std	r3,  -24(r1)
-	/* save TOC */
-	std	r2,  -16(r1)
-	std	r31, -8(r1)
-	mr	r31, r1
-	stdu	r1, -112(r1)
-
-	/*
-	 * We might be called from a module.
-	 * Switch to our TOC to run inside the core kernel.
-	 */
-	ld	r2, PACATOC(r13)
-
-	bl	ftrace_return_to_handler
-	nop
-
-	/* return value has real return address */
-	mtlr	r3
-
-	ld	r1, 0(r1)
-	ld	r4,  -32(r1)
-	ld	r3,  -24(r1)
-	ld	r2,  -16(r1)
-	ld	r31, -8(r1)
-
-	/* Jump back to real return address */
-	blr
-#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-#endif /* CONFIG_FUNCTION_TRACER */
diff --git a/arch/powerpc/kernel/ftrace_32.S b/arch/powerpc/kernel/ftrace_32.S
new file mode 100644
index 0000000..afef2c0
--- /dev/null
+++ b/arch/powerpc/kernel/ftrace_32.S
@@ -0,0 +1,118 @@
+/*
+ * Split from entry_32.S
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/magic.h>
+#include <asm/reg.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/ftrace.h>
+#include <asm/export.h>
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+_GLOBAL(mcount)
+_GLOBAL(_mcount)
+	/*
+	 * It is required that _mcount on PPC32 must preserve the
+	 * link register. But we have r0 to play with. We use r0
+	 * to push the return address back to the caller of mcount
+	 * into the ctr register, restore the link register and
+	 * then jump back using the ctr register.
+	 */
+	mflr	r0
+	mtctr	r0
+	lwz	r0, 4(r1)
+	mtlr	r0
+	bctr
+
+_GLOBAL(ftrace_caller)
+	MCOUNT_SAVE_FRAME
+	/* r3 ends up with link register */
+	subi	r3, r3, MCOUNT_INSN_SIZE
+.globl ftrace_call
+ftrace_call:
+	bl	ftrace_stub
+	nop
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+.globl ftrace_graph_call
+ftrace_graph_call:
+	b	ftrace_graph_stub
+_GLOBAL(ftrace_graph_stub)
+#endif
+	MCOUNT_RESTORE_FRAME
+	/* old link register ends up in ctr reg */
+	bctr
+#else
+_GLOBAL(mcount)
+_GLOBAL(_mcount)
+
+	MCOUNT_SAVE_FRAME
+
+	subi	r3, r3, MCOUNT_INSN_SIZE
+	LOAD_REG_ADDR(r5, ftrace_trace_function)
+	lwz	r5,0(r5)
+
+	mtctr	r5
+	bctrl
+	nop
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	b	ftrace_graph_caller
+#endif
+	MCOUNT_RESTORE_FRAME
+	bctr
+#endif
+EXPORT_SYMBOL(_mcount)
+
+_GLOBAL(ftrace_stub)
+	blr
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+_GLOBAL(ftrace_graph_caller)
+	/* load r4 with local address */
+	lwz	r4, 44(r1)
+	subi	r4, r4, MCOUNT_INSN_SIZE
+
+	/* Grab the LR out of the caller stack frame */
+	lwz	r3,52(r1)
+
+	bl	prepare_ftrace_return
+	nop
+
+        /*
+         * prepare_ftrace_return gives us the address we divert to.
+         * Change the LR in the callers stack frame to this.
+         */
+	stw	r3,52(r1)
+
+	MCOUNT_RESTORE_FRAME
+	/* old link register ends up in ctr reg */
+	bctr
+
+_GLOBAL(return_to_handler)
+	/* need to save return values */
+	stwu	r1, -32(r1)
+	stw	r3, 20(r1)
+	stw	r4, 16(r1)
+	stw	r31, 12(r1)
+	mr	r31, r1
+
+	bl	ftrace_return_to_handler
+	nop
+
+	/* return value has real return address */
+	mtlr	r3
+
+	lwz	r3, 20(r1)
+	lwz	r4, 16(r1)
+	lwz	r31,12(r1)
+	lwz	r1, 0(r1)
+
+	/* Jump back to real return address */
+	blr
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/powerpc/kernel/ftrace_64.S b/arch/powerpc/kernel/ftrace_64.S
new file mode 100644
index 0000000..df47433
--- /dev/null
+++ b/arch/powerpc/kernel/ftrace_64.S
@@ -0,0 +1,391 @@
+/*
+ * Split from entry_64.S
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/magic.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/ftrace.h>
+#include <asm/ppc-opcode.h>
+#include <asm/export.h>
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+_GLOBAL(mcount)
+_GLOBAL(_mcount)
+EXPORT_SYMBOL(_mcount)
+	mflr	r12
+	mtctr	r12
+	mtlr	r0
+	bctr
+
+#ifndef CC_USING_MPROFILE_KERNEL
+_GLOBAL_TOC(ftrace_caller)
+	/* Taken from output of objdump from lib64/glibc */
+	mflr	r3
+	ld	r11, 0(r1)
+	stdu	r1, -112(r1)
+	std	r3, 128(r1)
+	ld	r4, 16(r11)
+	subi	r3, r3, MCOUNT_INSN_SIZE
+.globl ftrace_call
+ftrace_call:
+	bl	ftrace_stub
+	nop
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+.globl ftrace_graph_call
+ftrace_graph_call:
+	b	ftrace_graph_stub
+_GLOBAL(ftrace_graph_stub)
+#endif
+	ld	r0, 128(r1)
+	mtlr	r0
+	addi	r1, r1, 112
+
+#else /* CC_USING_MPROFILE_KERNEL */
+/*
+ *
+ * ftrace_caller() is the function that replaces _mcount() when ftrace is
+ * active.
+ *
+ * We arrive here after a function A calls function B, and we are the trace
+ * function for B. When we enter r1 points to A's stack frame, B has not yet
+ * had a chance to allocate one yet.
+ *
+ * Additionally r2 may point either to the TOC for A, or B, depending on
+ * whether B did a TOC setup sequence before calling us.
+ *
+ * On entry the LR points back to the _mcount() call site, and r0 holds the
+ * saved LR as it was on entry to B, ie. the original return address at the
+ * call site in A.
+ *
+ * Our job is to save the register state into a struct pt_regs (on the stack)
+ * and then arrange for the ftrace function to be called.
+ */
+_GLOBAL(ftrace_caller)
+	/* Save the original return address in A's stack frame */
+	std	r0,LRSAVE(r1)
+
+	/* Create our stack frame + pt_regs */
+	stdu	r1,-SWITCH_FRAME_SIZE(r1)
+
+	/* Save all gprs to pt_regs */
+	SAVE_8GPRS(0,r1)
+	SAVE_8GPRS(8,r1)
+	SAVE_8GPRS(16,r1)
+	SAVE_8GPRS(24,r1)
+
+	/* Load special regs for save below */
+	mfmsr   r8
+	mfctr   r9
+	mfxer   r10
+	mfcr	r11
+
+	/* Get the _mcount() call site out of LR */
+	mflr	r7
+	/* Save it as pt_regs->nip & pt_regs->link */
+	std     r7, _NIP(r1)
+	std     r7, _LINK(r1)
+
+	/* Save callee's TOC in the ABI compliant location */
+	std	r2, 24(r1)
+	ld	r2,PACATOC(r13)	/* get kernel TOC in r2 */
+
+	addis	r3,r2,function_trace_op@toc@ha
+	addi	r3,r3,function_trace_op@toc@l
+	ld	r5,0(r3)
+
+#ifdef CONFIG_LIVEPATCH
+	mr	r14,r7		/* remember old NIP */
+#endif
+	/* Calculate ip from nip-4 into r3 for call below */
+	subi    r3, r7, MCOUNT_INSN_SIZE
+
+	/* Put the original return address in r4 as parent_ip */
+	mr	r4, r0
+
+	/* Save special regs */
+	std     r8, _MSR(r1)
+	std     r9, _CTR(r1)
+	std     r10, _XER(r1)
+	std     r11, _CCR(r1)
+
+	/* Load &pt_regs in r6 for call below */
+	addi    r6, r1 ,STACK_FRAME_OVERHEAD
+
+	/* ftrace_call(r3, r4, r5, r6) */
+.globl ftrace_call
+ftrace_call:
+	bl	ftrace_stub
+	nop
+
+	/* Load ctr with the possibly modified NIP */
+	ld	r3, _NIP(r1)
+	mtctr	r3
+#ifdef CONFIG_LIVEPATCH
+	cmpd	r14,r3		/* has NIP been altered? */
+#endif
+
+	/* Restore gprs */
+	REST_8GPRS(0,r1)
+	REST_8GPRS(8,r1)
+	REST_8GPRS(16,r1)
+	REST_8GPRS(24,r1)
+
+	/* Restore callee's TOC */
+	ld	r2, 24(r1)
+
+	/* Pop our stack frame */
+	addi r1, r1, SWITCH_FRAME_SIZE
+
+	/* Restore original LR for return to B */
+	ld	r0, LRSAVE(r1)
+	mtlr	r0
+
+#ifdef CONFIG_LIVEPATCH
+        /* Based on the cmpd above, if the NIP was altered handle livepatch */
+	bne-	livepatch_handler
+#endif
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	stdu	r1, -112(r1)
+.globl ftrace_graph_call
+ftrace_graph_call:
+	b	ftrace_graph_stub
+_GLOBAL(ftrace_graph_stub)
+	addi	r1, r1, 112
+#endif
+
+	ld	r0,LRSAVE(r1)	/* restore callee's lr at _mcount site */
+	mtlr	r0
+	bctr			/* jump after _mcount site */
+#endif /* CC_USING_MPROFILE_KERNEL */
+
+_GLOBAL(ftrace_stub)
+	blr
+
+#ifdef CONFIG_LIVEPATCH
+	/*
+	 * This function runs in the mcount context, between two functions. As
+	 * such it can only clobber registers which are volatile and used in
+	 * function linkage.
+	 *
+	 * We get here when a function A, calls another function B, but B has
+	 * been live patched with a new function C.
+	 *
+	 * On entry:
+	 *  - we have no stack frame and can not allocate one
+	 *  - LR points back to the original caller (in A)
+	 *  - CTR holds the new NIP in C
+	 *  - r0 & r12 are free
+	 *
+	 * r0 can't be used as the base register for a DS-form load or store, so
+	 * we temporarily shuffle r1 (stack pointer) into r0 and then put it back.
+	 */
+livepatch_handler:
+	CURRENT_THREAD_INFO(r12, r1)
+
+	/* Save stack pointer into r0 */
+	mr	r0, r1
+
+	/* Allocate 3 x 8 bytes */
+	ld	r1, TI_livepatch_sp(r12)
+	addi	r1, r1, 24
+	std	r1, TI_livepatch_sp(r12)
+
+	/* Save toc & real LR on livepatch stack */
+	std	r2,  -24(r1)
+	mflr	r12
+	std	r12, -16(r1)
+
+	/* Store stack end marker */
+	lis     r12, STACK_END_MAGIC@h
+	ori     r12, r12, STACK_END_MAGIC@l
+	std	r12, -8(r1)
+
+	/* Restore real stack pointer */
+	mr	r1, r0
+
+	/* Put ctr in r12 for global entry and branch there */
+	mfctr	r12
+	bctrl
+
+	/*
+	 * Now we are returning from the patched function to the original
+	 * caller A. We are free to use r0 and r12, and we can use r2 until we
+	 * restore it.
+	 */
+
+	CURRENT_THREAD_INFO(r12, r1)
+
+	/* Save stack pointer into r0 */
+	mr	r0, r1
+
+	ld	r1, TI_livepatch_sp(r12)
+
+	/* Check stack marker hasn't been trashed */
+	lis     r2,  STACK_END_MAGIC@h
+	ori     r2,  r2, STACK_END_MAGIC@l
+	ld	r12, -8(r1)
+1:	tdne	r12, r2
+	EMIT_BUG_ENTRY 1b, __FILE__, __LINE__ - 1, 0
+
+	/* Restore LR & toc from livepatch stack */
+	ld	r12, -16(r1)
+	mtlr	r12
+	ld	r2,  -24(r1)
+
+	/* Pop livepatch stack frame */
+	CURRENT_THREAD_INFO(r12, r0)
+	subi	r1, r1, 24
+	std	r1, TI_livepatch_sp(r12)
+
+	/* Restore real stack pointer */
+	mr	r1, r0
+
+	/* Return to original caller of live patched function */
+	blr
+#endif
+
+
+#else
+_GLOBAL_TOC(_mcount)
+EXPORT_SYMBOL(_mcount)
+	/* Taken from output of objdump from lib64/glibc */
+	mflr	r3
+	ld	r11, 0(r1)
+	stdu	r1, -112(r1)
+	std	r3, 128(r1)
+	ld	r4, 16(r11)
+
+	subi	r3, r3, MCOUNT_INSN_SIZE
+	LOAD_REG_ADDR(r5,ftrace_trace_function)
+	ld	r5,0(r5)
+	ld	r5,0(r5)
+	mtctr	r5
+	bctrl
+	nop
+
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	b	ftrace_graph_caller
+#endif
+	ld	r0, 128(r1)
+	mtlr	r0
+	addi	r1, r1, 112
+_GLOBAL(ftrace_stub)
+	blr
+
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#ifndef CC_USING_MPROFILE_KERNEL
+_GLOBAL(ftrace_graph_caller)
+	/* load r4 with local address */
+	ld	r4, 128(r1)
+	subi	r4, r4, MCOUNT_INSN_SIZE
+
+	/* Grab the LR out of the caller stack frame */
+	ld	r11, 112(r1)
+	ld	r3, 16(r11)
+
+	bl	prepare_ftrace_return
+	nop
+
+	/*
+	 * prepare_ftrace_return gives us the address we divert to.
+	 * Change the LR in the callers stack frame to this.
+	 */
+	ld	r11, 112(r1)
+	std	r3, 16(r11)
+
+	ld	r0, 128(r1)
+	mtlr	r0
+	addi	r1, r1, 112
+	blr
+
+#else /* CC_USING_MPROFILE_KERNEL */
+_GLOBAL(ftrace_graph_caller)
+	/* with -mprofile-kernel, parameter regs are still alive at _mcount */
+	std	r10, 104(r1)
+	std	r9, 96(r1)
+	std	r8, 88(r1)
+	std	r7, 80(r1)
+	std	r6, 72(r1)
+	std	r5, 64(r1)
+	std	r4, 56(r1)
+	std	r3, 48(r1)
+
+	/* Save callee's TOC in the ABI compliant location */
+	std	r2, 24(r1)
+	ld	r2, PACATOC(r13)	/* get kernel TOC in r2 */
+
+	mfctr	r4		/* ftrace_caller has moved local addr here */
+	std	r4, 40(r1)
+	mflr	r3		/* ftrace_caller has restored LR from stack */
+	subi	r4, r4, MCOUNT_INSN_SIZE
+
+	bl	prepare_ftrace_return
+	nop
+
+	/*
+	 * prepare_ftrace_return gives us the address we divert to.
+	 * Change the LR to this.
+	 */
+	mtlr	r3
+
+	ld	r0, 40(r1)
+	mtctr	r0
+	ld	r10, 104(r1)
+	ld	r9, 96(r1)
+	ld	r8, 88(r1)
+	ld	r7, 80(r1)
+	ld	r6, 72(r1)
+	ld	r5, 64(r1)
+	ld	r4, 56(r1)
+	ld	r3, 48(r1)
+
+	/* Restore callee's TOC */
+	ld	r2, 24(r1)
+
+	addi	r1, r1, 112
+	mflr	r0
+	std	r0, LRSAVE(r1)
+	bctr
+#endif /* CC_USING_MPROFILE_KERNEL */
+
+_GLOBAL(return_to_handler)
+	/* need to save return values */
+	std	r4,  -32(r1)
+	std	r3,  -24(r1)
+	/* save TOC */
+	std	r2,  -16(r1)
+	std	r31, -8(r1)
+	mr	r31, r1
+	stdu	r1, -112(r1)
+
+	/*
+	 * We might be called from a module.
+	 * Switch to our TOC to run inside the core kernel.
+	 */
+	ld	r2, PACATOC(r13)
+
+	bl	ftrace_return_to_handler
+	nop
+
+	/* return value has real return address */
+	mtlr	r3
+
+	ld	r1, 0(r1)
+	ld	r4,  -32(r1)
+	ld	r3,  -24(r1)
+	ld	r2,  -16(r1)
+	ld	r31, -8(r1)
+
+	/* Jump back to real return address */
+	blr
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.10.2
