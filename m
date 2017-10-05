Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7J1Z676TzDqks
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 03:21:38 +1100 (AEDT)
Date: Thu, 5 Oct 2017 18:21:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 dipankar <dipankar@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Thomas Gleixner <tglx@linutronix.de>, rostedt <rostedt@goodmis.org>,
 David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, fweisbec <fweisbec@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Andrew Hunter <ahh@google.com>,
 maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>,
 Avi Kivity <avi@scylladb.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>,
 Will Deacon <will.deacon@arm.com>,
 Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH tip/core/rcu 1/3] membarrier: Provide register expedited
 private command
Message-ID: <20171005162101.ryhmtlc3sa72dmyr@hirez.programming.kicks-ass.net>
References: <20171004213734.GA11463@linux.vnet.ibm.com>
 <1507153075-12345-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171005121250.prr5ff5kf3lxq6hx@hirez.programming.kicks-ass.net>
 <312162.31738.1507219326334.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <312162.31738.1507219326334.JavaMail.zimbra@efficios.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 05, 2017 at 04:02:06PM +0000, Mathieu Desnoyers wrote:
> ----- On Oct 5, 2017, at 8:12 AM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Wed, Oct 04, 2017 at 02:37:53PM -0700, Paul E. McKenney wrote:
> >> diff --git a/arch/powerpc/kernel/membarrier.c b/arch/powerpc/kernel/membarrier.c
> >> new file mode 100644
> >> index 000000000000..b0d79a5f5981
> >> --- /dev/null
> >> +++ b/arch/powerpc/kernel/membarrier.c
> >> @@ -0,0 +1,45 @@
> > 
> >> +void membarrier_arch_register_private_expedited(struct task_struct *p)
> >> +{
> >> +	struct task_struct *t;
> >> +
> >> +	if (get_nr_threads(p) == 1) {
> >> +		set_thread_flag(TIF_MEMBARRIER_PRIVATE_EXPEDITED);
> >> +		return;
> >> +	}
> >> +	/*
> >> +	 * Coherence of TIF_MEMBARRIER_PRIVATE_EXPEDITED against thread
> >> +	 * fork is protected by siglock.
> >> +	 */
> >> +	spin_lock(&p->sighand->siglock);
> >> +	for_each_thread(p, t)
> >> +		set_ti_thread_flag(task_thread_info(t),
> >> +				TIF_MEMBARRIER_PRIVATE_EXPEDITED);
> > 
> > I'm not sure this works correctly vs CLONE_VM without CLONE_THREAD.
> 
> The intent here is to hold the sighand siglock to provide mutual
> exclusion against invocation of membarrier_fork(p, clone_flags)
> by copy_process().
> 
> copy_process() grabs spin_lock(&current->sighand->siglock) for both
> CLONE_THREAD and not CLONE_THREAD flags.
> 
> What am I missing here ?

If you do CLONE_VM without CLONE_THREAD you'll end up sharing the mm but
you'll not be part of thread_head, so the for_each_thread() iteration
will not find the task.
