Return-Path: <compudj@efficios.com>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7Rwf5Bj6zDqhb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 09:17:54 +1100 (AEDT)
Date: Thu, 5 Oct 2017 22:19:15 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 dipankar <dipankar@in.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arch <linux-arch@vger.kernel.org>
Message-ID: <206890579.32344.1507241955010.JavaMail.zimbra@efficios.com>
In-Reply-To: <20171005220214.GA7140@andrea>
References: <20171004213734.GA11463@linux.vnet.ibm.com>
 <1507153075-12345-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171005121250.prr5ff5kf3lxq6hx@hirez.programming.kicks-ass.net>
 <312162.31738.1507219326334.JavaMail.zimbra@efficios.com>
 <20171005220214.GA7140@andrea>
Subject: Re: [PATCH tip/core/rcu 1/3] membarrier: Provide register expedited
 private command
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

----- On Oct 5, 2017, at 6:02 PM, Andrea Parri parri.andrea@gmail.com wrote:

> On Thu, Oct 05, 2017 at 04:02:06PM +0000, Mathieu Desnoyers wrote:
>> ----- On Oct 5, 2017, at 8:12 AM, Peter Zijlstra peterz@infradead.org wrote:
>> 
>> > On Wed, Oct 04, 2017 at 02:37:53PM -0700, Paul E. McKenney wrote:
>> >> diff --git a/arch/powerpc/kernel/membarrier.c b/arch/powerpc/kernel/membarrier.c
>> >> new file mode 100644
>> >> index 000000000000..b0d79a5f5981
>> >> --- /dev/null
>> >> +++ b/arch/powerpc/kernel/membarrier.c
>> >> @@ -0,0 +1,45 @@
>> > 
>> >> +void membarrier_arch_register_private_expedited(struct task_struct *p)
>> >> +{
>> >> +	struct task_struct *t;
>> >> +
>> >> +	if (get_nr_threads(p) == 1) {
>> >> +		set_thread_flag(TIF_MEMBARRIER_PRIVATE_EXPEDITED);
>> >> +		return;
>> >> +	}
>> >> +	/*
>> >> +	 * Coherence of TIF_MEMBARRIER_PRIVATE_EXPEDITED against thread
>> >> +	 * fork is protected by siglock.
>> >> +	 */
>> >> +	spin_lock(&p->sighand->siglock);
>> >> +	for_each_thread(p, t)
>> >> +		set_ti_thread_flag(task_thread_info(t),
>> >> +				TIF_MEMBARRIER_PRIVATE_EXPEDITED);
>> > 
>> > I'm not sure this works correctly vs CLONE_VM without CLONE_THREAD.
>> 
>> The intent here is to hold the sighand siglock to provide mutual
>> exclusion against invocation of membarrier_fork(p, clone_flags)
>> by copy_process().
>> 
>> copy_process() grabs spin_lock(&current->sighand->siglock) for both
>> CLONE_THREAD and not CLONE_THREAD flags.
>> 
>> What am I missing here ?
>> 
>> > 
>> >> +	spin_unlock(&p->sighand->siglock);
>> >> +	/*
>> >> +	 * Ensure all future scheduler executions will observe the new
>> >> +	 * thread flag state for this process.
>> >> +	 */
>> >> +	synchronize_sched();
>> > 
>> > This relies on the flag being read inside rq->lock, right?
>> 
>> Yes. The flag is read by membarrier_arch_switch_mm(), invoked
>> within switch_mm_irqs_off(), called by context_switch() before
>> finish_task_switch() releases the rq lock.
> 
> I fail to grap the relation between this synchronize_sched() and rq->lock.
> 
> (Besides, we made no reference to rq->lock while discussing:
> 
>  https://github.com/paulmckrcu/litmus/commit/47039df324b60ace0cf7b2403299580be730119b
>  replace membarrier_arch_sched_in with switch_mm_irqs_off )
> 
> Could you elaborate?

Hi Andrea,

AFAIU the scheduler rq->lock is held while preemption is disabled.
synchronize_sched() is used here to ensure that all pre-existing
preempt-off critical sections have completed.

So saying that we use synchronize_sched() to synchronize with rq->lock
would be stretching the truth a bit. It's actually only true because the
scheduler holding the rq->lock is surrounded by a preempt-off
critical section.

Thanks,

Mathieu



> 
>  Andrea
> 
> 
>> 
>> Is the comment clear enough, or do you have suggestions for
>> improvements ?
> 
> 
> 
>> 
>> Thanks,
>> 
>> Mathieu
>> 
>> > 
>> > > +}
>> 
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
> > http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
