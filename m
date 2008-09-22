Return-Path: <srinivasa@in.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 31282DDF11
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 23:11:17 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m8MDAQsH025626
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 23:10:26 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8MDAbFn211470
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 23:10:59 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8MDAbxo001866
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 23:10:37 +1000
From: Srinivasa Ds <srinivasa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH] Demultiplexing SIGTRAP signal
Date: Mon, 22 Sep 2008 18:41:27 +0530
References: <200809221602.32616.srinivasa@in.ibm.com>
	<20080922104202.GE30137@elte.hu>
In-Reply-To: <20080922104202.GE30137@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809221841.27993.srinivasa@in.ibm.com>
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

On Monday 22 September 2008 16:12:02 Ingo Molnar wrote:
> no fundamental objections - assuming existing x86 apps have not grown an
> ABI dependency on the existing send_sigtrap() semantics. (Debuggers and
> JITs would be a candidate for such dependencies.)
>

Assuming that no ABI dependency exist between x86 apps and send_sigtrap(),
And implementing some of the Ingo's suggestions, Iam resending the patch.

Still waiting for Roland's reply.


Currently a SIGTRAP can denote any one of below reasons.
	- Breakpoint hit
	- H/W debug register hit
	- Single step
	- Signal sent through kill() or rasie()

Architectures like powerpc/parisc provides infrastructure to demultiplex
SIGTRAP signal by passing down the information for receiving SIGTRAP through
si_code of siginfot_t strucutre. Here is an attempt is generalise this 
infrasturcutre by extending it to x86 and x86_64 archs. 

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
 include/asm-x86/traps.h            |   10 ++++++++++
 9 files changed, 21 insertions(+), 21 deletions(-)

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
 
+	si_code = get_si_code((unsigned long*)&condition);
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
+	info.si_code = get_si_code(&condition);
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
+#define TRAP_HWBKPT     (__SI_FAULT|4)  /* hardware breakpoint or watchpoint 
*/
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
 
-void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int 
error_code)
+void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int 
error_code,
+							          int si_code)
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
@@ -36,6 +36,16 @@ void do_invalid_op(struct pt_regs *, lon
 void do_general_protection(struct pt_regs *, long);
 void do_nmi(struct pt_regs *, long);
 
+int get_si_code(unsigned long *condition)
+{
+	if (*condition & DR_STEP)
+		return TRAP_TRACE;
+	else if (*condition & (DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3))
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
