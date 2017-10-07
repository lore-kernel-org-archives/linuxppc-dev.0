Return-Path: <parri.andrea@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y8VLL2kkBzDqlx
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Oct 2017 02:10:17 +1100 (AEDT)
Received: by mail-wm0-x244.google.com with SMTP id u138so13912302wmu.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Oct 2017 08:10:17 -0700 (PDT)
Date: Sat, 7 Oct 2017 17:10:04 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
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
Message-ID: <20171007151004.GA3874@andrea>
References: <20171004213734.GA11463@linux.vnet.ibm.com>
 <1507153075-12345-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171005121250.prr5ff5kf3lxq6hx@hirez.programming.kicks-ass.net>
 <312162.31738.1507219326334.JavaMail.zimbra@efficios.com>
 <20171005220214.GA7140@andrea>
 <206890579.32344.1507241955010.JavaMail.zimbra@efficios.com>
 <20171006083219.asdpl5w4pl6hedcd@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171006083219.asdpl5w4pl6hedcd@hirez.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 06, 2017 at 10:32:19AM +0200, Peter Zijlstra wrote:
> > AFAIU the scheduler rq->lock is held while preemption is disabled.
> > synchronize_sched() is used here to ensure that all pre-existing
> > preempt-off critical sections have completed.
> > 
> > So saying that we use synchronize_sched() to synchronize with rq->lock
> > would be stretching the truth a bit. It's actually only true because the
> > scheduler holding the rq->lock is surrounded by a preempt-off
> > critical section.
> 
> No, rq->lock is sufficient, note that rq->lock is a raw_spinlock_t which
> implies !preempt. Yes, we also surround the rq->lock usage with a
> slightly larger preempt_disable() section but that's not in fact
> required for this.

That's what it is, according to the current sources: we seemed to agree that
a preempt-off critical section is what we rely on here and that the start of
this critical section is not marked by that raw_spin_lock.

  Andrea
