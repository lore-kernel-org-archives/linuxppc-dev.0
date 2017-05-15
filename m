Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRT693HDqzDqMG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:06:09 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4FI078v024882
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 14:06:06 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2afe8g9509-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 14:06:05 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 16 May 2017 04:06:03 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4FI5qvt3670520
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:06:00 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4FI5SZd020752
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:05:28 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/jprobes: Save and restore the parameter save area
Date: Mon, 15 May 2017 23:35:03 +0530
Message-Id: <0572aa31dd57bef6f158ac97d0b666a0c545356a.1494871248.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As pointed out in x86 setjmp_pre_handler(), we need to save and restore
the parameter save area since the jprobe hook might overwrite it. Since
there is no easy way to identify the size of the parameter save area,
we choose to save/restore a fixed 16 [double]word-sized area including
the stack frame header.

We introduce STACK_FRAME_PARM_SAVE to encode the offset of the parameter
save area from the stack frame pointer. Remove the similarly named
PARAMETER_SAVE_AREA_OFFSET in ptrace.c as those are currently not used
anywhere.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
Michael,
I've set the limit to 16 parameters as being a "reasonable" number, but
we could very well make this 24 or 32 if we want to be sure. Let me
know what you prefer.

Thanks,
Naveen

 arch/powerpc/include/asm/kprobes.h | 10 ++++++++++
 arch/powerpc/include/asm/ptrace.h  |  7 +++++++
 arch/powerpc/kernel/kprobes.c      |  7 +++++++
 arch/powerpc/kernel/ptrace.c       | 10 ----------
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index a83821f33ea3..b6960ef213ac 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -61,6 +61,15 @@ extern kprobe_opcode_t optprobe_template_end[];
 #define MAX_OPTINSN_SIZE	(optprobe_template_end - optprobe_template_entry)
 #define RELATIVEJUMP_SIZE	sizeof(kprobe_opcode_t)	/* 4 bytes */
 
+/* Save upto 16 parameters along with the stack frame header */
+#define MAX_STACK_SIZE		(STACK_FRAME_PARM_SAVE + (16 * sizeof(unsigned long)))
+#define MIN_STACK_SIZE(ADDR)					       \
+	(((MAX_STACK_SIZE) < (((unsigned long)current_thread_info()) + \
+			      THREAD_SIZE - (unsigned long)(ADDR)))    \
+	 ? (MAX_STACK_SIZE)					       \
+	 : (((unsigned long)current_thread_info()) +		       \
+	    THREAD_SIZE - (unsigned long)(ADDR)))
+
 #define flush_insn_slot(p)	do { } while (0)
 #define kretprobe_blacklist_size 0
 
@@ -90,6 +99,7 @@ struct kprobe_ctlblk {
 	unsigned long kprobe_saved_msr;
 	struct pt_regs jprobe_saved_regs;
 	struct prev_kprobe prev_kprobe;
+	u8 jprobes_stack[MAX_STACK_SIZE];
 };
 
 struct arch_optimized_insn {
diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index e4923686e43a..a50d0514a181 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -49,8 +49,14 @@
 
 #ifdef PPC64_ELF_ABI_v2
 #define STACK_FRAME_MIN_SIZE	32
+/*
+ * The parameter save area on the stack is used to store arguments being passed
+ * to callee function and is located at fixed offset from stack pointer.
+ */
+#define STACK_FRAME_PARM_SAVE	32
 #else
 #define STACK_FRAME_MIN_SIZE	STACK_FRAME_OVERHEAD
+#define STACK_FRAME_PARM_SAVE	48
 #endif
 
 /* Size of dummy stack frame allocated when calling signal handler. */
@@ -67,6 +73,7 @@
 #define STACK_INT_FRAME_SIZE	(sizeof(struct pt_regs) + STACK_FRAME_OVERHEAD)
 #define STACK_FRAME_MARKER	2
 #define STACK_FRAME_MIN_SIZE	STACK_FRAME_OVERHEAD
+#define STACK_FRAME_PARM_SAVE	8
 
 /* Size of stack frame allocated when calling signal handler. */
 #define __SIGNAL_FRAMESIZE	64
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 4398ea60b4e0..19b053475758 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -37,6 +37,7 @@
 #include <asm/sstep.h>
 #include <asm/sections.h>
 #include <linux/uaccess.h>
+#include <asm/bitops.h>
 
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
@@ -598,8 +599,10 @@ int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct jprobe *jp = container_of(p, struct jprobe, kp);
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+	unsigned long sp = kernel_stack_pointer(regs);
 
 	memcpy(&kcb->jprobe_saved_regs, regs, sizeof(struct pt_regs));
+	memcpy(&kcb->jprobes_stack, (void *)sp, MIN_STACK_SIZE(sp));
 
 	/* setup return addr to the jprobe handler routine */
 	regs->nip = arch_deref_entry_point(jp->entry);
@@ -636,6 +639,7 @@ NOKPROBE_SYMBOL(jprobe_return_end);
 int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+	unsigned long sp;
 
 	/*
 	 * FIXME - we should ideally be validating that we got here 'cos
@@ -643,6 +647,9 @@ int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 	 * saved regs...
 	 */
 	memcpy(regs, &kcb->jprobe_saved_regs, sizeof(struct pt_regs));
+	sp = kernel_stack_pointer(regs);
+	memcpy((void *)sp, &kcb->jprobes_stack, MIN_STACK_SIZE(sp));
+
 	/* It's OK to start function graph tracing again */
 	unpause_graph_tracing();
 	preempt_enable_no_resched();
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 925a4ef90559..7631318b5f37 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -44,16 +44,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
-/*
- * The parameter save area on the stack is used to store arguments being passed
- * to callee function and is located at fixed offset from stack pointer.
- */
-#ifdef CONFIG_PPC32
-#define PARAMETER_SAVE_AREA_OFFSET	24  /* bytes */
-#else /* CONFIG_PPC32 */
-#define PARAMETER_SAVE_AREA_OFFSET	48  /* bytes */
-#endif
-
 struct pt_regs_offset {
 	const char *name;
 	int offset;
-- 
2.12.2
