Return-Path: <mathieu.desnoyers@efficios.com>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yyJYZ3NPbzDrcS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 03:14:57 +1100 (AEDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>, Andy Lutomirski <luto@amacapital.net>,
 Dave Watson <davejwatson@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 Paul Turner <pjt@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Russell King <linux@arm.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
 Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
 Ben Maurer <bmaurer@fb.com>, Steven Rostedt <rostedt@goodmis.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Michael Kerrisk <mtk.manpages@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH for 4.16 07/21] powerpc: Add support for restartable
 sequences
Date: Thu, 14 Dec 2017 11:13:49 -0500
Message-Id: <20171214161403.30643-8-mathieu.desnoyers@efficios.com>
In-Reply-To: <20171214161403.30643-1-mathieu.desnoyers@efficios.com>
References: <20171214161403.30643-1-mathieu.desnoyers@efficios.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Boqun Feng <boqun.feng@gmail.com>

Call the rseq_handle_notify_resume() function on return to userspace if
TIF_NOTIFY_RESUME thread flag is set.

Increment the event counter and perform fixup on the pre-signal when a
signal is delivered on top of a restartable sequence critical section.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Peter Zijlstra <peterz@infradead.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/Kconfig         | 1 +
 arch/powerpc/kernel/signal.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c51e6ce42e7a..e9992f80819c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -221,6 +221,7 @@ config PPC
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_RSEQ
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 3d7539b90010..a7b95f7bcaf1 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -133,6 +133,8 @@ static void do_signal(struct task_struct *tsk)
 	/* Re-enable the breakpoints for the signal stack */
 	thread_change_pc(tsk, tsk->thread.regs);
 
+	rseq_signal_deliver(tsk->thread.regs);
+
 	if (is32) {
         	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
 			ret = handle_rt_signal32(&ksig, oldset, tsk);
@@ -161,6 +163,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
+		rseq_handle_notify_resume(regs);
 	}
 
 	if (thread_info_flags & _TIF_PATCH_PENDING)
-- 
2.11.0
