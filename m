Return-Path: <srinivasa@in.ibm.com>
Received: from e28esmtp06.in.ibm.com (e28smtp06.in.ibm.com [59.145.155.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E97D1DDF17
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 20:32:13 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp06.in.ibm.com (8.13.1/8.13.1) with ESMTP id m8MAVwQm004126
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 16:01:58 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8MAVwbf1695862
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 16:01:58 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id m8MAVvGm010622
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 16:01:58 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, paulus@samba.org,
	roland@redhat.com, linuxppc-dev@ozlabs.org, mingo@elte.hu,
	linux-parisc@vger.kernel.org
Subject: [RFC][PATCH] Demultiplexing SIGTRAP signal
Date: Mon, 22 Sep 2008 16:02:32 +0530
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809221602.32616.srinivasa@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently a SIGTRAP signal can denote any one of below reasons.
	- Breakpoint hit
	- H/W debug register hit
	- Single step
	- SIGTRAP signal sent through kill() or rasie()

Architectures like powerpc/parisc provides infrastructure to demultiplex
SIGTRAP signal by passing down the information for receiving SIGTRAP through
si_code of siginfot_t structure. Here is an attempt is generalise this 
infrastructure by extending it to x86 and x86_64 archs. 

Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>



---
 arch/ia64/include/asm/siginfo.h    |    5 -----
 arch/powerpc/include/asm/siginfo.h |    5 -----
 arch/x86/kernel/traps_32.c         |   19 +++++++++++++++++--
 arch/x86/kernel/traps_64.c         |    7 ++++++-
 include/asm-generic/siginfo.h      |    2 ++
 include/asm-parisc/siginfo.h       |    5 -----
 6 files changed, 25 insertions(+), 18 deletions(-)

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
@@ -890,6 +890,7 @@ void __kprobes do_int3(struct pt_regs *r
 void __kprobes do_debug(struct pt_regs *regs, long error_code)
 {
 	struct task_struct *tsk = current;
+	struct siginfo info;
 	unsigned int condition;
 
 	trace_hardirqs_fixup();
@@ -935,8 +936,22 @@ void __kprobes do_debug(struct pt_regs *
 			goto clear_TF_reenable;
 	}
 
-	/* Ok, finally something we can handle */
-	send_sigtrap(tsk, regs, error_code);
+	tsk->thread.trap_no = 1;
+	tsk->thread.error_code = error_code;
+
+	memset(&info, 0, sizeof(info));
+	info.si_signo = SIGTRAP;
+	if (condition & DR_STEP)
+		info.si_code = TRAP_TRACE;
+	else if (condition & (DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3))
+		info.si_code = TRAP_HWBKPT;
+	else
+		info.si_code = TRAP_BRKPT;
+	/* User-mode ip? */
+	info.si_addr = user_mode_vm(regs) ? (void __user *) regs->ip : NULL;
+
+	/* Send us the fake SIGTRAP */
+	force_sig_info(SIGTRAP, &info, tsk);
 
 	/*
 	 * Disable additional traps. They'll be re-enabled when
Index: linux-2.6.27-rc7/arch/x86/kernel/traps_64.c
===================================================================
--- linux-2.6.27-rc7.orig/arch/x86/kernel/traps_64.c
+++ linux-2.6.27-rc7/arch/x86/kernel/traps_64.c
@@ -936,7 +936,12 @@ asmlinkage void __kprobes do_debug(struc
 	tsk->thread.error_code = error_code;
 	info.si_signo = SIGTRAP;
 	info.si_errno = 0;
-	info.si_code = TRAP_BRKPT;
+	if (condition & DR_STEP)
+		info.si_code = TRAP_TRACE;
+	else if (condition & (DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3))
+		info.si_code = TRAP_HWBKPT;
+	else
+		info.si_code = TRAP_BRKPT;
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
 
