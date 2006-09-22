Return-Path: <SRS0+e8fc20ab33191259865d+1125+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7DC6567B73
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 18:32:51 +1000 (EST)
Subject: [PATCH] Fix PPC32 SECCOMP, unexport do_syscall_trace_{enter,leave}
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org
Content-Type: text/plain
Date: Fri, 22 Sep 2006 09:32:45 +0100
Message-Id: <1158913965.24527.659.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The secure_computing() call which automatically aborts a process if it
tries to execute a syscall it shouldn't is much more useful if we
actually do it _before_ the syscall, rather than afterwards. PPC64 got
this right, but the original incorrect behaviour inherited from arch/ppc
was preserved by ifdefs. Make it the same on PPC32 too.

Also, I see no need to export do_syscall_trace_{leave,enter} on ppc32 --
they were only exported because the old do_syscall_trace() (which they
replaced) used to be.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index dea75d7..9c78009 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -526,9 +526,7 @@ static void do_syscall_trace(void)
 
 void do_syscall_trace_enter(struct pt_regs *regs)
 {
-#ifdef CONFIG_PPC64
 	secure_computing(regs->gpr[0]);
-#endif
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE)
 	    && (current->ptrace & PT_PTRACED))
@@ -548,10 +546,6 @@ #endif
 
 void do_syscall_trace_leave(struct pt_regs *regs)
 {
-#ifdef CONFIG_PPC32
-	secure_computing(regs->gpr[0]);
-#endif
-
 	if (unlikely(current->audit_context))
 		audit_syscall_exit((regs->ccr&0x10000000)?AUDITSC_FAILURE:AUDITSC_SUCCESS,
 				   regs->result);
@@ -561,8 +555,3 @@ #endif
 	    && (current->ptrace & PT_PTRACED))
 		do_syscall_trace();
 }
-
-#ifdef CONFIG_PPC32
-EXPORT_SYMBOL(do_syscall_trace_enter);
-EXPORT_SYMBOL(do_syscall_trace_leave);
-#endif

-- 
dwmw2
