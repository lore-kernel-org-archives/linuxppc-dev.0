Return-Path: <srinivasa@in.ibm.com>
Received: from e28esmtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 42895DDEF4
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 00:25:21 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id m8NEOn4p012855
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 19:54:49 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8NEOnGI1708236
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 19:54:49 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id m8NEOmow014898
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 00:24:49 +1000
From: Srinivasa Ds <srinivasa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH] Demultiplexing SIGTRAP signal -v2
Date: Tue, 23 Sep 2008 19:55:01 +0530
References: <200809221602.32616.srinivasa@in.ibm.com>
	<20080923112812.GL29021@elte.hu> <20080923113001.GA12531@elte.hu>
In-Reply-To: <20080923113001.GA12531@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200809231955.01564.srinivasa@in.ibm.com>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	"H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org,
	Thomas Gleixner <tglx@linutronix.de>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 23 September 2008 17:00:01 Ingo Molnar wrote:

> > applied to [the new topic] tip/core/signal, thanks Srinivasa! There
> > are some other pending x86 signal changes already, so i based
> > tip/core/signal on tip/x86/signal.
>
> -tip testing found the following build error with the attached config:
>

Ingo, Reproduced build break issue with your config on tip tree. It was a costly overlook 
to miss one header file. I included it in this patch and tested it out.


Currently a SIGTRAP can denote any one of below reasons.
	- Breakpoint hit
	- H/W debug register hit
	- Single step
	- Signal sent through kill() or rasie()

Architectures like powerpc/parisc provides infrastructure to demultiplex
SIGTRAP signal by passing down the information for receiving SIGTRAP through
si_code of siginfot_t structure. Here is an attempt is generalise this 
infrastructure by extending it to x86 and x86_64 archs. 

Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>


---
 arch/ia64/include/asm/siginfo.h    |    5 -----
 arch/powerpc/include/asm/siginfo.h |    5 -----
 arch/x86/kernel/ptrace.c           |    7 ++++---
 arch/x86/kernel/traps_32.c         |    4 +++-
 arch/x86/kernel/traps_64.c         |    2 +-
 include/asm-generic/siginfo.h      |    2 ++
 include/asm-parisc/siginfo.h       |    5 -----
 include/asm-x86/ptrace.h           |    2 +-
 include/asm-x86/traps.h            |   12 ++++++++++++
 9 files changed, 23 insertions(+), 21 deletions(-)

Index: linux-2.6.27-rc7/arch/ia64/include/asm/siginfo.h
===================================================================
--- linux-2.6.27-rc7.orig/arch/ia64/include/asm/siginfo.h
+++ linux-2.6.27-rc7/arch/ia64/include/asm/siginfo.h
@@ -113,11 +113,6 @@ typedef struct siginfo {
 #undef NSIGSEGV
 #define NSIGSEGV	3
 
-/*
- * SIGTRAP si_codes
- */
-#define TRAP_BRANCH	(__SI_FAULT|3)	/* process taken branch trap */
-#define TRAP_HWBKPT	(__SI_FAULT|4)	/* hardware breakpoint or watchpoint */
 #undef NSIGTRAP
 #define NSIGTRAP	4
 
Index: linux-2.6.27-rc7/arch/powerpc/include/asm/siginfo.h
===================================================================
--- linux-2.6.27-rc7.orig/arch/powerpc/include/asm/siginfo.h
+++ linux-2.6.27-rc7/arch/powerpc/include/asm/siginfo.h
@@ -15,11 +15,6 @@
 
 #include <asm-generic/siginfo.h>
 
-/*
- * SIGTRAP si_codes
- */
-#define TRAP_BRANCH	(__SI_FAULT|3)	/* process taken branch trap */
-#define TRAP_HWBKPT	(__SI_FAULT|4)	/* hardware breakpoint or watchpoint */
 #undef NSIGTRAP
 #define NSIGTRAP	4
 
Index: linux-2.6.27-rc7/arch/x86/kernel/traps_32.c
===================================================================
--- linux-2.6.27-rc7.orig/arch/x86/kernel/traps_32.c
+++ linux-2.6.27-rc7/arch/x86/kernel/traps_32.c
@@ -891,6 +891,7 @@ void __kprobes do_debug(struct pt_regs *
 {
 	struct task_struct *tsk = current;
 	unsigned int condition;
+	int si_code;
 
 	trace_hardirqs_fixup();
 
@@ -935,8 +936,9 @@ void __kprobes do_debug(struct pt_regs *
 			goto clear_TF_reenable;
 	}
 
+	si_code = get_si_code((unsigned long)condition);
 	/* Ok, finally something we can handle */
-	send_sigtrap(tsk, regs, error_code);
+	send_sigtrap(tsk, regs, error_code, si_code);
 
 	/*
 	 * Disable additional traps. They'll be re-enabled when
Index: linux-2.6.27-rc7/arch/x86/kernel/traps_64.c
===================================================================
--- linux-2.6.27-rc7.orig/arch/x86/kernel/traps_64.c
+++ linux-2.6.27-rc7/arch/x86/kernel/traps_64.c
@@ -936,7 +936,7 @@ asmlinkage void __kprobes do_debug(struc
 	tsk->thread.error_code = error_code;
 	info.si_signo = SIGTRAP;
 	info.si_errno = 0;
-	info.si_code = TRAP_BRKPT;
+	info.si_code = get_si_code(condition);
 	info.si_addr = user_mode(regs) ? (void __user *)regs->ip : NULL;
 	force_sig_info(SIGTRAP, &info, tsk);
 
Index: linux-2.6.27-rc7/include/asm-generic/siginfo.h
===================================================================
--- linux-2.6.27-rc7.orig/include/asm-generic/siginfo.h
+++ linux-2.6.27-rc7/include/asm-generic/siginfo.h
@@ -199,6 +199,8 @@ typedef struct siginfo {
  */
 #define TRAP_BRKPT	(__SI_FAULT|1)	/* process breakpoint */
 #define TRAP_TRACE	(__SI_FAULT|2)	/* process trace trap */
+#define TRAP_BRANCH     (__SI_FAULT|3)  /* process taken branch trap */
+#define TRAP_HWBKPT     (__SI_FAULT|4)  /* hardware breakpoint/watchpoint */
 #define NSIGTRAP	2
 
 /*
Index: linux-2.6.27-rc7/include/asm-parisc/siginfo.h
===================================================================
--- linux-2.6.27-rc7.orig/include/asm-parisc/siginfo.h
+++ linux-2.6.27-rc7/include/asm-parisc/siginfo.h
@@ -3,11 +3,6 @@
 
 #include <asm-generic/siginfo.h>
 
-/*
- * SIGTRAP si_codes
- */
-#define TRAP_BRANCH	(__SI_FAULT|3)	/* process taken branch trap */
-#define TRAP_HWBKPT	(__SI_FAULT|4)	/* hardware breakpoint or watchpoint */
 #undef NSIGTRAP
 #define NSIGTRAP	4
 
Index: linux-2.6.27-rc7/arch/x86/kernel/ptrace.c
===================================================================
--- linux-2.6.27-rc7.orig/arch/x86/kernel/ptrace.c
+++ linux-2.6.27-rc7/arch/x86/kernel/ptrace.c
@@ -1357,7 +1357,8 @@ const struct user_regset_view *task_user
 #endif
 }
 
-void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int error_code)
+void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
+					 int error_code, int si_code)
 {
 	struct siginfo info;
 
@@ -1366,7 +1367,7 @@ void send_sigtrap(struct task_struct *ts
 
 	memset(&info, 0, sizeof(info));
 	info.si_signo = SIGTRAP;
-	info.si_code = TRAP_BRKPT;
+	info.si_code = si_code;
 
 	/* User-mode ip? */
 	info.si_addr = user_mode_vm(regs) ? (void __user *) regs->ip : NULL;
@@ -1476,5 +1477,5 @@ asmregparm void syscall_trace_leave(stru
 	 */
 	if (test_thread_flag(TIF_SINGLESTEP) &&
 	    (current->ptrace & PT_PTRACED))
-		send_sigtrap(current, regs, 0);
+		send_sigtrap(current, regs, 0, TRAP_BRKPT);
 }
Index: linux-2.6.27-rc7/include/asm-x86/traps.h
===================================================================
--- linux-2.6.27-rc7.orig/include/asm-x86/traps.h
+++ linux-2.6.27-rc7/include/asm-x86/traps.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_X86_TRAPS_H
 #define _ASM_X86_TRAPS_H
 
+#include <asm/debugreg.h>
+
 /* Common in X86_32 and X86_64 */
 asmlinkage void divide_error(void);
 asmlinkage void debug(void);
@@ -36,6 +38,16 @@ void do_invalid_op(struct pt_regs *, lon
 void do_general_protection(struct pt_regs *, long);
 void do_nmi(struct pt_regs *, long);
 
+static inline int get_si_code(unsigned long condition)
+{
+	if (condition & DR_STEP)
+		return TRAP_TRACE;
+	else if (condition & (DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3))
+		return TRAP_HWBKPT;
+	else
+		return TRAP_BRKPT;
+}
+
 extern int panic_on_unrecovered_nmi;
 extern int kstack_depth_to_print;
 
Index: linux-2.6.27-rc7/include/asm-x86/ptrace.h
===================================================================
--- linux-2.6.27-rc7.orig/include/asm-x86/ptrace.h
+++ linux-2.6.27-rc7/include/asm-x86/ptrace.h
@@ -143,7 +143,7 @@ convert_ip_to_linear(struct task_struct 
 
 #ifdef CONFIG_X86_32
 extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
-			 int error_code);
+			 int error_code, int si_code);
 #else
 void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
 #endif
