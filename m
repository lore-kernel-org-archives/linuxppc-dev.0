Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7Bn94BY5zDr6M
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 23:25:33 +1100 (AEDT)
Date: Thu, 5 Oct 2017 14:24:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
 dipankar@in.ibm.com, akpm@linux-foundation.org,
 mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
 tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
 edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
 Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>,
 Maged Michael <maged.michael@gmail.com>, gromer@google.com,
 Avi Kivity <avi@scylladb.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>,
 Will Deacon <will.deacon@arm.com>,
 Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH tip/core/rcu 1/3] membarrier: Provide register expedited
 private command
Message-ID: <20171005122458.zfl2vl7h4jiu67ms@hirez.programming.kicks-ass.net>
References: <20171004213734.GA11463@linux.vnet.ibm.com>
 <1507153075-12345-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171005121250.prr5ff5kf3lxq6hx@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171005121250.prr5ff5kf3lxq6hx@hirez.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 05, 2017 at 02:12:50PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 04, 2017 at 02:37:53PM -0700, Paul E. McKenney wrote:
> > diff --git a/arch/powerpc/kernel/membarrier.c b/arch/powerpc/kernel/membarrier.c
> > new file mode 100644
> > index 000000000000..b0d79a5f5981
> > --- /dev/null
> > +++ b/arch/powerpc/kernel/membarrier.c
> > @@ -0,0 +1,45 @@
> 
> > +void membarrier_arch_register_private_expedited(struct task_struct *p)
> > +{
> > +	struct task_struct *t;
> > +
> > +	if (get_nr_threads(p) == 1) {
> > +		set_thread_flag(TIF_MEMBARRIER_PRIVATE_EXPEDITED);
> > +		return;
> > +	}
> > +	/*
> > +	 * Coherence of TIF_MEMBARRIER_PRIVATE_EXPEDITED against thread
> > +	 * fork is protected by siglock.
> > +	 */
> > +	spin_lock(&p->sighand->siglock);
> > +	for_each_thread(p, t)
> > +		set_ti_thread_flag(task_thread_info(t),
> > +				TIF_MEMBARRIER_PRIVATE_EXPEDITED);
> 
> I'm not sure this works correctly vs CLONE_VM without CLONE_THREAD.

Also, for easier reading I would suggest putting { } around the block.

> > +	spin_unlock(&p->sighand->siglock);
> > +	/*
> > +	 * Ensure all future scheduler executions will observe the new
> > +	 * thread flag state for this process.
> > +	 */
> > +	synchronize_sched();
> 
> This relies on the flag being read inside rq->lock, right?
> 
> > +}
