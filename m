Return-Path: <SRS0=ewqr=BE=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7SYP0V3zzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 09:46:16 +1100 (AEDT)
Date: Thu, 5 Oct 2017 18:46:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, dipankar
 <dipankar@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Josh
 Triplett <josh@joshtriplett.org>, Thomas Gleixner <tglx@linutronix.de>,
 David Howells <dhowells@redhat.com>, Eric Dumazet <edumazet@google.com>,
 fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Boqun Feng
 <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, maged michael
 <maged.michael@gmail.com>, gromer <gromer@google.com>, Avi Kivity
 <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul
 Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave
 Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will
 Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH tip/core/rcu 1/3] membarrier: Provide register expedited
 private command
Message-ID: <20171005184609.44185ce1@gandalf.local.home>
In-Reply-To: <206890579.32344.1507241955010.JavaMail.zimbra@efficios.com>
References: <20171004213734.GA11463@linux.vnet.ibm.com>
 <1507153075-12345-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171005121250.prr5ff5kf3lxq6hx@hirez.programming.kicks-ass.net>
 <312162.31738.1507219326334.JavaMail.zimbra@efficios.com>
 <20171005220214.GA7140@andrea>
 <206890579.32344.1507241955010.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 5 Oct 2017 22:19:15 +0000 (UTC)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> AFAIU the scheduler rq->lock is held while preemption is disabled.
> synchronize_sched() is used here to ensure that all pre-existing
> preempt-off critical sections have completed.
> 
> So saying that we use synchronize_sched() to synchronize with rq->lock
> would be stretching the truth a bit. It's actually only true because the
> scheduler holding the rq->lock is surrounded by a preempt-off
> critical section.

Not only is preemption disabled (which is true for all spinlocks, at
least with non PREEMPT_RT), but the rq->lock must also only be taken
with interrupts disabled (for PREEMPT_RT as well). Because it can also
be taken in interrupt context.

-- Steve
