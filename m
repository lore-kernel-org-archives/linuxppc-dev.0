Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3V9r1YHYzDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 21:45:31 +1000 (AEST)
Date: Fri, 29 Sep 2017 13:45:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-arch <linux-arch@vger.kernel.org>, Avi Kivity <avi@scylladb.com>,
 maged michael <maged.michael@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Dave Watson <davejwatson@fb.com>,
 Will Deacon <will.deacon@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Andrew Hunter <ahh@google.com>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, gromer <gromer@google.com>
Subject: Re: [PATCH v4 for 4.14 1/3] membarrier: Provide register expedited
 private command
Message-ID: <20170929114518.gtr7v7sf4oskjuut@hirez.programming.kicks-ass.net>
References: <20170926175151.14264-1-mathieu.desnoyers@efficios.com>
 <33948425.19289.1506458608221.JavaMail.zimbra@efficios.com>
 <20170927230436.4af88a62@roar.ozlabs.ibm.com>
 <911707916.20840.1506605496314.JavaMail.zimbra@efficios.com>
 <20170929010112.3a54be0d@roar.ozlabs.ibm.com>
 <20170928155115.fou577qzxepnnxqc@hirez.programming.kicks-ass.net>
 <20170929022757.62d43dfc@roar.ozlabs.ibm.com>
 <20170929103131.un7tzxsixjoretal@hirez.programming.kicks-ass.net>
 <20170929213853.46c4675b@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170929213853.46c4675b@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 29, 2017 at 09:38:53PM +1000, Nicholas Piggin wrote:

> Not really. There is some ability to hold onto a line for a time, but
> there is no way to starve them, let alone starve hundreds of other
> CPUs. They will request the cacheline exclusive and eventually get it.

OK, hardware fairness there is nice.

> I would really prefer to go this way on powerpc first. We could add the
> the registration APIs as basically no-ops, but which would allow the
> locking approach to be changed if we find it causes issues. I'll try to
> find some time and a big system when I can.

Fair enough I suppose.

> > A semi related issue; I suppose we can do a arch upcall to flush_tlb_mm
> > and reset the mm_cpumask when we change cpuset groups.
> 
> For powerpc we have been looking at how mm_cpumask can be improved.
> It has real drawbacks even when you don't consider this new syscall.

What else do you use mm_cpumask for?
