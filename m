Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 30 May 2007 17:17:16 +1000
Subject: [RFC/PATCH 3/6] powerpc: ptrace updates & new better requests
Message-Id: <20070530071727.75BEFDDFBB@ozlabs.org>
Cc: ulrich.weigand@de.ibm.com, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The powerpc ptrace interface is dodgy at best. We have defined our
"own" versions of GETREGS/SETREGS/GETFPREGS/SETFPREGS that strangely
take arguments in reverse order from other archs (in addition to having
different request numbers) and have subtle issue, like not accessing
all of the registers in their respective categories.

This patch moves the implementation of those to a separate function
in order to facilitate their deprecation in the future, and provides
new ptrace requests that mirror the x86 and sparc ones and use the
same numbers:

   PTRACE_GETREGS    : returns an entire pt_regs (the whole thing,
                       not only the 32 GPRs, though that doesn't
                       include the FPRs etc... There's a compat version
                       for 32 bits that returns a 32 bits compatible
                       pt_regs (44 uints)

   PTRACE_SETREGS    : sets an entire pt_regs (the whole thing,
                       not only the 32 GPRs, though that doesn't
                       include the FPRs etc... Some registers cannot be
                       written to and will just be dropped, this is the
                       same as with POKEUSR, that is anything above MQ
                       on 32 bits and CCR on 64 bits. There is a compat
                       version as well.

   PTRACE_GETFPREGS  : returns all the FP registers -including- the FPSCR
                       that is 33 doubles (regardless of 32/64 bits)

   PTRACE_SETFPREGS  : sets all the FP registers -including- the FPSCR
                       that is 33 doubles (regardless of 32/64 bits)

And two that only exist on 64 bits kernels:

   PTRACE_GETREGS64  : Same as PTRACE_GETREGS, except there is no compat
                       function, a 32 bits process will obtain the full 64
                       bits registers

   PTRACE_SETREGS64  : Same as PTRACE_SETREGS, except there is no compat
                       function, a 32 bits process will set the full 64
                       bits registers

The two later ones makes things easier to have a 32 bits debugger on a
64 bits program (or on a 32 bits program that uses the full 64 bits of
the GPRs, which is possible though has issues that will be fixed in a
later patch).

Finally, while at it, the patch removes a whole bunch of code duplication
between ptrace32.c and ptrace.c, in large part by having the former call
into the later for all requests that don't need any special "compat"
treatment.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/ptrace-common.h |   23 ++++
 arch/powerpc/kernel/ptrace.c        |  148 +++++++++++++++++---------
 arch/powerpc/kernel/ptrace32.c      |  204 +++++++++++++++---------------------
 include/asm-powerpc/ptrace.h        |   17 ++-
 4 files changed, 222 insertions(+), 170 deletions(-)

Index: linux-cell/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace.c	2007-05-30 14:40:54.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace.c	2007-05-30 16:02:52.000000000 +1000
@@ -59,6 +59,62 @@ void ptrace_disable(struct task_struct *
 	clear_single_step(child);
 }
 
+/*
+ * Here are the old "legacy" powerpc specific getregs/setregs ptrace calls,
+ * we mark them as obsolete now, they will be removed in a future version
+ */
+static long arch_ptrace_old(struct task_struct *child, long request, long addr,
+			    long data)
+{
+	int ret = -EPERM;
+
+	switch(request) {
+	case PPC_PTRACE_GETREGS: { /* Get GPRs 0 - 31. */
+		int i;
+		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
+		unsigned long __user *tmp = (unsigned long __user *)addr;
+
+		for (i = 0; i < 32; i++) {
+			ret = put_user(*reg, tmp);
+			if (ret)
+				break;
+			reg++;
+			tmp++;
+		}
+		break;
+	}
+
+	case PPC_PTRACE_SETREGS: { /* Set GPRs 0 - 31. */
+		int i;
+		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
+		unsigned long __user *tmp = (unsigned long __user *)addr;
+
+		for (i = 0; i < 32; i++) {
+			ret = get_user(*reg, tmp);
+			if (ret)
+				break;
+			reg++;
+			tmp++;
+		}
+		break;
+	}
+
+	case PPC_PTRACE_GETFPREGS: { /* Get FPRs 0 - 31. */
+		flush_fp_to_thread(child);
+		ret = get_fpregs((void __user *)addr, child, 0);
+		break;
+	}
+
+	case PPC_PTRACE_SETFPREGS: { /* Get FPRs 0 - 31. */
+		flush_fp_to_thread(child);
+		ret = set_fpregs((void __user *)addr, child, 0);
+		break;
+	}
+
+	}
+	return ret;
+}
+
 long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
 	int ret = -EPERM;
@@ -214,71 +270,58 @@ long arch_ptrace(struct task_struct *chi
 		ret = ptrace_detach(child, data);
 		break;
 
-	case PPC_PTRACE_GETREGS: { /* Get GPRs 0 - 31. */
-		int i;
-		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
-		unsigned long __user *tmp = (unsigned long __user *)addr;
-
-		for (i = 0; i < 32; i++) {
-			ret = put_user(*reg, tmp);
-			if (ret)
-				break;
-			reg++;
-			tmp++;
+#ifdef CONFIG_PPC64
+	case PTRACE_GETREGS64:
+#endif
+	case PTRACE_GETREGS: { /* Get all pt_regs from the child. */
+		int ui;
+	  	if (!access_ok(VERIFY_WRITE, (void __user *)data,
+			       sizeof(struct pt_regs))) {
+			ret = -EIO;
+			break;
+		}
+		ret = 0;
+		for (ui = 0; ui < PT_REGS_COUNT; ui ++) {
+			ret |= __put_user(get_reg(child, ui),
+					  (unsigned long __user *) data);
+			data += sizeof(long);
 		}
 		break;
 	}
 
-	case PPC_PTRACE_SETREGS: { /* Set GPRs 0 - 31. */
-		int i;
-		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
-		unsigned long __user *tmp = (unsigned long __user *)addr;
-
-		for (i = 0; i < 32; i++) {
-			ret = get_user(*reg, tmp);
+#ifdef CONFIG_PPC64
+	case PTRACE_SETREGS64:
+#endif
+	case PTRACE_SETREGS: { /* Set all gp regs in the child. */
+		unsigned long tmp;
+		int ui;
+	  	if (!access_ok(VERIFY_READ, (void __user *)data,
+			       sizeof(struct pt_regs))) {
+			ret = -EIO;
+			break;
+		}
+		ret = 0;
+		for (ui = 0; ui < PT_REGS_COUNT; ui ++) {
+			ret = __get_user(tmp, (unsigned long __user *) data);
 			if (ret)
 				break;
-			reg++;
-			tmp++;
+			put_reg(child, ui, tmp);
+			data += sizeof(long);
 		}
 		break;
 	}
 
-#ifdef CONFIG_PPC64
-	case PPC_PTRACE_GETFPREGS: { /* Get FPRs 0 - 31. */
-		int i;
-		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
-		unsigned long __user *tmp = (unsigned long __user *)addr;
-
+	case PTRACE_GETFPREGS: { /* Get the child FPU state (FPR0...31 + FPSCR) */
 		flush_fp_to_thread(child);
-
-		for (i = 0; i < 32; i++) {
-			ret = put_user(*reg, tmp);
-			if (ret)
-				break;
-			reg++;
-			tmp++;
-		}
+		ret = get_fpregs((void __user *)data, child, 1);
 		break;
 	}
 
-	case PPC_PTRACE_SETFPREGS: { /* Get FPRs 0 - 31. */
-		int i;
-		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
-		unsigned long __user *tmp = (unsigned long __user *)addr;
-
+	case PTRACE_SETFPREGS: { /* Set the child FPU state (FPR0...31 + FPSCR) */
 		flush_fp_to_thread(child);
-
-		for (i = 0; i < 32; i++) {
-			ret = get_user(*reg, tmp);
-			if (ret)
-				break;
-			reg++;
-			tmp++;
-		}
+		ret = set_fpregs((void __user *)data, child, 1);
 		break;
 	}
-#endif /* CONFIG_PPC64 */
 
 #ifdef CONFIG_ALTIVEC
 	case PTRACE_GETVRREGS:
@@ -311,11 +354,18 @@ long arch_ptrace(struct task_struct *chi
 		break;
 #endif
 
+	/* Old reverse args ptrace callss */
+	case PPC_PTRACE_GETREGS: /* Get GPRs 0 - 31. */
+	case PPC_PTRACE_SETREGS: /* Set GPRs 0 - 31. */
+	case PPC_PTRACE_GETFPREGS: /* Get FPRs 0 - 31. */
+	case PPC_PTRACE_SETFPREGS: /* Get FPRs 0 - 31. */
+		ret = arch_ptrace_old(child, request, addr, data);
+		break;
+
 	default:
 		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
-
 	return ret;
 }
 
Index: linux-cell/include/asm-powerpc/ptrace.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/ptrace.h	2007-05-30 14:26:01.000000000 +1000
+++ linux-cell/include/asm-powerpc/ptrace.h	2007-05-30 16:02:52.000000000 +1000
@@ -158,9 +158,7 @@ do {									      \
 
 #define PT_NIP	32
 #define PT_MSR	33
-#ifdef __KERNEL__
 #define PT_ORIG_R3 34
-#endif
 #define PT_CTR	35
 #define PT_LNK	36
 #define PT_XER	37
@@ -169,11 +167,12 @@ do {									      \
 #define PT_MQ	39
 #else
 #define PT_SOFTE 39
+#endif
 #define PT_TRAP	40
 #define PT_DAR	41
 #define PT_DSISR 42
 #define PT_RESULT 43
-#endif
+#define PT_REGS_COUNT 44
 
 #define PT_FPR0	48	/* each FP reg occupies 2 slots in this space */
 
@@ -229,7 +228,17 @@ do {									      \
 #define PTRACE_GET_DEBUGREG	25
 #define PTRACE_SET_DEBUGREG	26
 
-/* Additional PTRACE requests implemented on PowerPC. */
+/* (new) PTRACE requests using the same numbers as x86 and the same
+ * argument ordering. Additionally, they support more registers too
+ */
+#define PTRACE_GETREGS            12
+#define PTRACE_SETREGS            13
+#define PTRACE_GETFPREGS          14
+#define PTRACE_SETFPREGS          15
+#define PTRACE_GETREGS64	  22
+#define PTRACE_SETREGS64	  23
+
+/* (old) PTRACE requests with inverted arguments */
 #define PPC_PTRACE_GETREGS	0x99	/* Get GPRs 0 - 31 */
 #define PPC_PTRACE_SETREGS	0x98	/* Set GPRs 0 - 31 */
 #define PPC_PTRACE_GETFPREGS	0x97	/* Get FPRs 0 - 31 */
Index: linux-cell/arch/powerpc/kernel/ptrace-common.h
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace-common.h	2007-05-30 14:40:54.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace-common.h	2007-05-30 16:02:52.000000000 +1000
@@ -52,6 +52,29 @@ static inline int put_reg(struct task_st
 }
 
 
+static inline int get_fpregs(void __user *data,
+			     struct task_struct *task,
+			     int has_fpscr)
+{
+	unsigned int count = has_fpscr ? 33 : 32;
+
+	if (copy_to_user(data, task->thread.fpr, count * sizeof(double)))
+		return -EFAULT;
+	return 0;
+}
+
+static inline int set_fpregs(void __user *data,
+			     struct task_struct *task,
+			     int has_fpscr)
+{
+	unsigned int count = has_fpscr ? 33 : 32;
+
+	if (copy_from_user(task->thread.fpr, data, count * sizeof(double)))
+		return -EFAULT;
+	return 0;
+}
+
+
 #ifdef CONFIG_ALTIVEC
 /*
  * Get/set all the altivec registers vr0..vr31, vscr, vrsave, in one go.
Index: linux-cell/arch/powerpc/kernel/ptrace32.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace32.c	2007-05-30 14:40:54.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace32.c	2007-05-30 16:02:52.000000000 +1000
@@ -41,6 +41,50 @@
  * in exit.c or in signal.c.
  */
 
+/*
+ * Here are the old "legacy" powerpc specific getregs/setregs ptrace calls,
+ * we mark them as obsolete now, they will be removed in a future version
+ */
+static long compat_ptrace_old(struct task_struct *child, long request,
+			      long addr, long data)
+{
+	int ret = -EPERM;
+
+	switch(request) {
+	case PPC_PTRACE_GETREGS: { /* Get GPRs 0 - 31. */
+		int i;
+		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
+		unsigned int __user *tmp = (unsigned int __user *)addr;
+
+		for (i = 0; i < 32; i++) {
+			ret = put_user(*reg, tmp);
+			if (ret)
+				break;
+			reg++;
+			tmp++;
+		}
+		break;
+	}
+
+	case PPC_PTRACE_SETREGS: { /* Set GPRs 0 - 31. */
+		int i;
+		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
+		unsigned int __user *tmp = (unsigned int __user *)addr;
+
+		for (i = 0; i < 32; i++) {
+			ret = get_user(*reg, tmp);
+			if (ret)
+				break;
+			reg++;
+			tmp++;
+		}
+		break;
+	}
+
+	}
+	return ret;
+}
+
 long compat_sys_ptrace(int request, int pid, unsigned long addr,
 		       unsigned long data)
 {
@@ -280,52 +324,6 @@ long compat_sys_ptrace(int request, int 
 		break;
 	}
 
-	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
-	case PTRACE_CONT: { /* restart after signal. */
-		ret = -EIO;
-		if (!valid_signal(data))
-			break;
-		if (request == PTRACE_SYSCALL)
-			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-		else
-			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-		child->exit_code = data;
-		/* make sure the single step bit is not set. */
-		clear_single_step(child);
-		wake_up_process(child);
-		ret = 0;
-		break;
-	}
-
-	/*
-	 * make the child exit.  Best I can do is send it a sigkill.
-	 * perhaps it should be put in the status that it wants to
-	 * exit.
-	 */
-	case PTRACE_KILL: {
-		ret = 0;
-		if (child->exit_state == EXIT_ZOMBIE)	/* already dead */
-			break;
-		child->exit_code = SIGKILL;
-		/* make sure the single step bit is not set. */
-		clear_single_step(child);
-		wake_up_process(child);
-		break;
-	}
-
-	case PTRACE_SINGLESTEP: {  /* set the trap flag. */
-		ret = -EIO;
-		if (!valid_signal(data))
-			break;
-		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-		set_single_step(child);
-		child->exit_code = data;
-		/* give it a chance to run. */
-		wake_up_process(child);
-		ret = 0;
-		break;
-	}
-
 	case PTRACE_GET_DEBUGREG: {
 		ret = -EINVAL;
 		/* We only support one DABR and no IABRS at the moment */
@@ -335,95 +333,67 @@ long compat_sys_ptrace(int request, int 
 		break;
 	}
 
-	case PTRACE_SET_DEBUGREG:
-		ret = ptrace_set_debugreg(child, addr, data);
-		break;
-
-	case PTRACE_DETACH:
-		ret = ptrace_detach(child, data);
+	case PTRACE_GETEVENTMSG:
+		ret = put_user(child->ptrace_message, (unsigned int __user *) data);
 		break;
 
-	case PPC_PTRACE_GETREGS: { /* Get GPRs 0 - 31. */
-		int i;
-		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
-		unsigned int __user *tmp = (unsigned int __user *)addr;
-
-		for (i = 0; i < 32; i++) {
-			ret = put_user(*reg, tmp);
-			if (ret)
-				break;
-			reg++;
-			tmp++;
+	case PTRACE_GETREGS: { /* Get all pt_regs from the child. */
+		int ui;
+	  	if (!access_ok(VERIFY_WRITE, (void __user *)data,
+			       PT_REGS_COUNT * sizeof(int))) {
+			ret = -EIO;
+			break;
 		}
-		break;
-	}
-
-	case PPC_PTRACE_SETREGS: { /* Set GPRs 0 - 31. */
-		int i;
-		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
-		unsigned int __user *tmp = (unsigned int __user *)addr;
-
-		for (i = 0; i < 32; i++) {
-			ret = get_user(*reg, tmp);
-			if (ret)
-				break;
-			reg++;
-			tmp++;
+		ret = 0;
+		for (ui = 0; ui < PT_REGS_COUNT; ui ++) {
+			ret |= __put_user(get_reg(child, ui),
+					  (unsigned int __user *) data);
+			data += sizeof(int);
 		}
 		break;
 	}
 
-	case PPC_PTRACE_GETFPREGS: { /* Get FPRs 0 - 31. */
-		int i;
-		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
-		unsigned int __user *tmp = (unsigned int __user *)addr;
-
-		flush_fp_to_thread(child);
-
-		for (i = 0; i < 32; i++) {
-			ret = put_user(*reg, tmp);
-			if (ret)
-				break;
-			reg++;
-			tmp++;
+	case PTRACE_SETREGS: { /* Set all gp regs in the child. */
+		unsigned long tmp;
+		int ui;
+	  	if (!access_ok(VERIFY_READ, (void __user *)data,
+			       PT_REGS_COUNT * sizeof(int))) {
+			ret = -EIO;
+			break;
 		}
-		break;
-	}
-
-	case PPC_PTRACE_SETFPREGS: { /* Get FPRs 0 - 31. */
-		int i;
-		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
-		unsigned int __user *tmp = (unsigned int __user *)addr;
-
-		flush_fp_to_thread(child);
-
-		for (i = 0; i < 32; i++) {
-			ret = get_user(*reg, tmp);
+		ret = 0;
+		for (ui = 0; ui < PT_REGS_COUNT; ui ++) {
+			ret = __get_user(tmp, (unsigned int __user *) data);
 			if (ret)
 				break;
-			reg++;
-			tmp++;
+			put_reg(child, ui, tmp);
+			data += sizeof(int);
 		}
 		break;
 	}
 
-	case PTRACE_GETEVENTMSG:
-		ret = put_user(child->ptrace_message, (unsigned int __user *) data);
-		break;
-
-#ifdef CONFIG_ALTIVEC
+	case PTRACE_GETFPREGS:
+	case PTRACE_SETFPREGS:
 	case PTRACE_GETVRREGS:
-		/* Get the child altivec register state. */
-		flush_altivec_to_thread(child);
-		ret = get_vrregs((unsigned long __user *)data, child);
+	case PTRACE_SETVRREGS:
+	case PTRACE_GETREGS64:
+	case PTRACE_SETREGS64:
+	case PPC_PTRACE_GETFPREGS:
+	case PPC_PTRACE_SETFPREGS:
+	case PTRACE_KILL:
+	case PTRACE_SINGLESTEP:
+	case PTRACE_DETACH:
+	case PTRACE_SET_DEBUGREG:
+	case PTRACE_SYSCALL:
+	case PTRACE_CONT:
+		ret = arch_ptrace(child, request, addr, data);
 		break;
 
-	case PTRACE_SETVRREGS:
-		/* Set the child altivec register state. */
-		flush_altivec_to_thread(child);
-		ret = set_vrregs(child, (unsigned long __user *)data);
+	/* Old reverse args ptrace callss */
+	case PPC_PTRACE_GETREGS: /* Get GPRs 0 - 31. */
+	case PPC_PTRACE_SETREGS: /* Set GPRs 0 - 31. */
+		ret = compat_ptrace_old(child, request, addr, data);
 		break;
-#endif
 
 	default:
 		ret = ptrace_request(child, request, addr, data);
