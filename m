Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mM4G63THzDsQ6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 03:34:06 +1000 (AEST)
Date: Wed, 16 May 2018 18:18:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>, Andy Lutomirski <luto@amacapital.net>,
 Dave Watson <davejwatson@fb.com>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Russell King <linux@arm.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Andrew Hunter <ahh@google.com>, Andi Kleen <andi@firstfloor.org>,
 Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Michael Kerrisk <mtk.manpages@gmail.com>,
 Joel Fernandes <joelaf@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/14] powerpc: Add support for restartable sequences
Message-ID: <20180516161837.GI12198@hirez.programming.kicks-ass.net>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <20180430224433.17407-8-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180430224433.17407-8-mathieu.desnoyers@efficios.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 30, 2018 at 06:44:26PM -0400, Mathieu Desnoyers wrote:
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index c32a181a7cbb..ed21a777e8c6 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -223,6 +223,7 @@ config PPC
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_VIRT_CPU_ACCOUNTING
>  	select HAVE_IRQ_TIME_ACCOUNTING
> +	select HAVE_RSEQ
>  	select IRQ_DOMAIN
>  	select IRQ_FORCED_THREADING
>  	select MODULES_USE_ELF_RELA
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> index 61db86ecd318..d3bb3aaaf5ac 100644
> --- a/arch/powerpc/kernel/signal.c
> +++ b/arch/powerpc/kernel/signal.c
> @@ -133,6 +133,8 @@ static void do_signal(struct task_struct *tsk)
>  	/* Re-enable the breakpoints for the signal stack */
>  	thread_change_pc(tsk, tsk->thread.regs);
>  
> +	rseq_signal_deliver(tsk->thread.regs);
> +
>  	if (is32) {
>          	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
>  			ret = handle_rt_signal32(&ksig, oldset, tsk);
> @@ -164,6 +166,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
>  	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
>  		clear_thread_flag(TIF_NOTIFY_RESUME);
>  		tracehook_notify_resume(regs);
> +		rseq_handle_notify_resume(regs);
>  	}
>  
>  	user_enter();

Again no rseq_syscall().
