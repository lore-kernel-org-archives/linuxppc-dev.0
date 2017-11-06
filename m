Return-Path: <mathieu.desnoyers@efficios.com>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yW4d457PVzDrK1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 07:57:27 +1100 (AEDT)
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
Subject: [RFC PATCH for 4.15 06/14] Restartable sequences: powerpc
 architecture support
Date: Mon,  6 Nov 2017 15:56:36 -0500
Message-Id: <20171106205644.29386-7-mathieu.desnoyers@efficios.com>
In-Reply-To: <20171106205644.29386-1-mathieu.desnoyers@efficios.com>
References: <20171106205644.29386-1-mathieu.desnoyers@efficios.com>
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
index cb782ac1c35d..41d1dae3b1b5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -219,6 +219,7 @@ config PPC
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_RSEQ
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index e9436c5e1e09..17a994b801b1 100644
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
