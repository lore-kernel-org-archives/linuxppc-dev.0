Return-Path: <SRS0+205f48b658e4c0f39389+623+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDE54679E6
	for <linuxppc-dev@ozlabs.org>; Mon,  9 May 2005 01:08:09 +1000 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org, benh@kernel.crashing.org
Content-Type: text/plain
Date: Sun, 08 May 2005 16:07:03 +0100
Message-Id: <1115564823.3755.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Syscall auditing and seccomp for PPC32.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For information (and feedback) only. Do not apply; it's already in 
    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/dwmw2/audit-2.6.git

Why _is_ do_syscall_trace() exported, anyway?

Index: arch/ppc/Kconfig
===================================================================
--- 6cdd9771bd9a56de1b0246a330ccd916ecdb1d41/arch/ppc/Kconfig  (mode:100644)
+++ 27383b18b9f62d3c4f1b5dd9f3daeffb10416c15/arch/ppc/Kconfig  (mode:100644)
@@ -1083,6 +1083,23 @@
 
 source kernel/power/Kconfig
 
+config SECCOMP
+	bool "Enable seccomp to safely compute untrusted bytecode"
+	depends on PROC_FS
+	default y
+	help
+	  This kernel feature is useful for number crunching applications
+	  that may need to compute untrusted bytecode during their
+	  execution. By using pipes or other transports made available to
+	  the process as file descriptors supporting the read/write
+	  syscalls, it's possible to isolate those applications in
+	  their own address space using seccomp. Once seccomp is
+	  enabled via /proc/<pid>/seccomp, it cannot be disabled
+	  and the task is only allowed to execute a few safe syscalls
+	  defined by each seccomp mode.
+
+	  If unsure, say Y. Only embedded should say N here.
+
 endmenu
 
 config ISA_DMA_API
Index: arch/ppc/kernel/entry.S
===================================================================
--- 6cdd9771bd9a56de1b0246a330ccd916ecdb1d41/arch/ppc/kernel/entry.S  (mode:100644)
+++ 27383b18b9f62d3c4f1b5dd9f3daeffb10416c15/arch/ppc/kernel/entry.S  (mode:100644)
@@ -202,7 +202,7 @@
 	rlwinm	r11,r11,0,~_TIFL_FORCE_NOERROR
 	stw	r11,TI_LOCAL_FLAGS(r10)
 	lwz	r11,TI_FLAGS(r10)
-	andi.	r11,r11,_TIF_SYSCALL_TRACE
+	andi.	r11,r11,_TIF_SYSCALL_T_OR_A
 	bne-	syscall_dotrace
 syscall_dotrace_cont:
 	cmplwi	0,r0,NR_syscalls
@@ -237,7 +237,7 @@
 	SYNC
 	MTMSRD(r10)
 	lwz	r9,TI_FLAGS(r12)
-	andi.	r0,r9,(_TIF_SYSCALL_TRACE|_TIF_SIGPENDING|_TIF_NEED_RESCHED)
+	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SIGPENDING|_TIF_NEED_RESCHED)
 	bne-	syscall_exit_work
 syscall_exit_cont:
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
@@ -277,7 +277,8 @@
 	SAVE_NVGPRS(r1)
 	li	r0,0xc00
 	stw	r0,TRAP(r1)
-	bl	do_syscall_trace
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	do_syscall_trace_enter
 	lwz	r0,GPR0(r1)	/* Restore original registers */
 	lwz	r3,GPR3(r1)
 	lwz	r4,GPR4(r1)
@@ -291,7 +292,7 @@
 syscall_exit_work:
 	stw	r6,RESULT(r1)	/* Save result */
 	stw	r3,GPR3(r1)	/* Update return value */
-	andi.	r0,r9,_TIF_SYSCALL_TRACE
+	andi.	r0,r9,_TIF_SYSCALL_T_OR_A
 	beq	5f
 	ori	r10,r10,MSR_EE
 	SYNC
@@ -303,7 +304,8 @@
 	li	r4,0xc00
 	stw	r4,TRAP(r1)
 4:
-	bl	do_syscall_trace
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	do_syscall_trace_leave
 	REST_NVGPRS(r1)
 2:
 	lwz	r3,GPR3(r1)
@@ -627,8 +629,8 @@
 	subi	r1,r3,STACK_FRAME_OVERHEAD
 	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
 	lwz	r9,TI_FLAGS(r12)
-	andi.	r0,r9,_TIF_SYSCALL_TRACE
-	bnel-	do_syscall_trace
+	andi.	r0,r9,_TIF_SYSCALL_T_OR_A
+	bnel-	do_syscall_trace_leave
 	/* fall through */
 
 	.globl	ret_from_except_full
Index: arch/ppc/kernel/ppc_ksyms.c
===================================================================
--- 6cdd9771bd9a56de1b0246a330ccd916ecdb1d41/arch/ppc/kernel/ppc_ksyms.c  (mode:100644)
+++ 27383b18b9f62d3c4f1b5dd9f3daeffb10416c15/arch/ppc/kernel/ppc_ksyms.c  (mode:100644)
@@ -55,7 +55,6 @@
 #define EXPORT_SYMTAB_STROPS
 
 extern void transfer_to_handler(void);
-extern void do_syscall_trace(void);
 extern void do_IRQ(struct pt_regs *regs);
 extern void MachineCheckException(struct pt_regs *regs);
 extern void AlignmentException(struct pt_regs *regs);
@@ -74,7 +73,6 @@
 EXPORT_SYMBOL(clear_pages);
 EXPORT_SYMBOL(clear_user_page);
 EXPORT_SYMBOL(do_signal);
-EXPORT_SYMBOL(do_syscall_trace);
 EXPORT_SYMBOL(transfer_to_handler);
 EXPORT_SYMBOL(do_IRQ);
 EXPORT_SYMBOL(MachineCheckException);
Index: arch/ppc/kernel/ptrace.c
===================================================================
--- 6cdd9771bd9a56de1b0246a330ccd916ecdb1d41/arch/ppc/kernel/ptrace.c  (mode:100644)
+++ 27383b18b9f62d3c4f1b5dd9f3daeffb10416c15/arch/ppc/kernel/ptrace.c  (mode:100644)
@@ -27,6 +27,9 @@
 #include <linux/user.h>
 #include <linux/security.h>
 #include <linux/signal.h>
+#include <linux/seccomp.h>
+#include <linux/audit.h>
+#include <linux/module.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -455,11 +458,10 @@
 	return ret;
 }
 
-void do_syscall_trace(void)
+static void do_syscall_trace(void)
 {
-        if (!test_thread_flag(TIF_SYSCALL_TRACE)
-	    || !(current->ptrace & PT_PTRACED))
-		return;
+	/* the 0x80 provides a way for the tracing parent to distinguish
+	   between a syscall stop and SIGTRAP delivery */
 	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
 				 ? 0x80 : 0));
 
@@ -473,3 +475,33 @@
 		current->exit_code = 0;
 	}
 }
+
+void do_syscall_trace_enter(struct pt_regs *regs)
+{
+	if (test_thread_flag(TIF_SYSCALL_TRACE)
+	    && (current->ptrace & PT_PTRACED))
+		do_syscall_trace();
+
+	if (unlikely(current->audit_context))
+		audit_syscall_entry(current, AUDIT_ARCH_PPC,
+				    regs->gpr[0],
+				    regs->gpr[3], regs->gpr[4],
+				    regs->gpr[5], regs->gpr[6]);
+}
+
+void do_syscall_trace_leave(struct pt_regs *regs)
+{
+	secure_computing(regs->gpr[0]);
+
+	if (unlikely(current->audit_context))
+		audit_syscall_exit(current,
+				   (regs->ccr&0x1000)?AUDITSC_FAILURE:AUDITSC_SUCCESS,
+				   regs->result);
+
+	if ((test_thread_flag(TIF_SYSCALL_TRACE))
+	    && (current->ptrace & PT_PTRACED))
+		do_syscall_trace();
+}
+
+EXPORT_SYMBOL(do_syscall_trace_enter);
+EXPORT_SYMBOL(do_syscall_trace_leave);
Index: include/asm-ppc/thread_info.h
===================================================================
--- 6cdd9771bd9a56de1b0246a330ccd916ecdb1d41/include/asm-ppc/thread_info.h  (mode:100644)
+++ 27383b18b9f62d3c4f1b5dd9f3daeffb10416c15/include/asm-ppc/thread_info.h  (mode:100644)
@@ -77,12 +77,19 @@
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
 #define TIF_MEMDIE		5
+#define TIF_SYSCALL_AUDIT       6       /* syscall auditing active */
+#define TIF_SECCOMP             7      /* secure computing */
+
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
+#define _TIF_SYSCALL_AUDIT      (1<<TIF_SYSCALL_AUDIT)
+#define _TIF_SECCOMP            (1<<TIF_SECCOMP)
+
+#define _TIF_SYSCALL_T_OR_A     (_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP)
 
 /*
  * Non racy (local) flags bit numbers
Index: init/Kconfig
===================================================================
--- 6cdd9771bd9a56de1b0246a330ccd916ecdb1d41/init/Kconfig  (mode:100644)
+++ 27383b18b9f62d3c4f1b5dd9f3daeffb10416c15/init/Kconfig  (mode:100644)
@@ -173,7 +173,7 @@
 
 config AUDITSYSCALL
 	bool "Enable system-call auditing support"
-	depends on AUDIT && (X86 || PPC64 || ARCH_S390 || IA64 || UML)
+	depends on AUDIT && (X86 || PPC || PPC64 || ARCH_S390 || IA64 || UML)
 	default y if SECURITY_SELINUX
 	help
 	  Enable low-overhead system-call auditing infrastructure that

-- 
dwmw2
