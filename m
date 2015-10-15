Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F14611A03A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 02:42:57 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 15 Oct 2015 09:42:54 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B76BA3E4004C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 09:42:52 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t9FFgqJr6488436
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 08:42:52 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9FFgpKN004634
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 09:42:52 -0600
Date: Thu, 15 Oct 2015 08:42:52 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151015154252.GG3910@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151014210419.GY3604@twins.programming.kicks-ass.net>
 <20151014214453.GC3910@linux.vnet.ibm.com>
 <20151015103510.GA27524@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151015103510.GA27524@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 15, 2015 at 11:35:44AM +0100, Will Deacon wrote:
> Dammit guys, it's never simple is it?
> 
> On Wed, Oct 14, 2015 at 02:44:53PM -0700, Paul E. McKenney wrote:
> > To that end, the herd tool can make a diagram of what it thought
> > happened, and I have attached it.  I used this diagram to try and force
> > this scenario at https://www.cl.cam.ac.uk/~pes20/ppcmem/index.html#PPC,
> > and succeeded.  Here is the sequence of events:
> > 
> > o	Commit P0's write.  The model offers to propagate this write
> > 	to the coherence point and to P1, but don't do so yet.
> > 
> > o	Commit P1's write.  Similar offers, but don't take them up yet.
> > 
> > o	Commit P0's lwsync.
> > 
> > o	Execute P0's lwarx, which reads a=0.  Then commit it.
> > 
> > o	Commit P0's stwcx. as successful.  This stores a=1.
> 
> On arm64, this is a conditional-store-*release* and therefore cannot be
> observed before the initial write to x...
> 
> > o	Commit P0's branch (not taken).
> > 
> > o	Commit P0's final register-to-register move.
> > 
> > o	Commit P1's sync instruction.
> > 
> > o	There is now nothing that can happen in either processor.
> > 	P0 is done, and P1 is waiting for its sync.  Therefore,
> > 	propagate P1's a=2 write to the coherence point and to
> > 	the other thread.
> 
> ... therefore this is illegal, because you haven't yet propagated that
> prior write...

OK.  Power distinguishes between propagating to the coherence point
and to each of the other CPUs.

> > o	There is still nothing that can happen in either processor.
> > 	So pick the barrier propagate, then the acknowledge sync.
> > 
> > o	P1 can now execute its read from x.  Because P0's write to
> > 	x is still waiting to propagate to P1, this still reads
> > 	x=0.  Execute and commit, and we now have both r3 registers
> > 	equal to zero and the final value a=2.
> 
> ... and P1 would have to read x == 1.

Good!  Do ARMMEM and herd agree with you?

> So arm64 is ok. Doesn't lwsync order store->store observability for PPC?

Yes.  But this is not store->store observability, but rather store->load
visibility.  Furthermore, as I understand it, lwsync controls the
visibility to other CPUs, but not necessarily the coherence order.

Let's look at the example C code again:

	CPU 0				CPU 1
	-----				-----

	WRITE_ONCE(x, 1);		WRITE_ONCE(a, 2);
	r3 = xchg(&a, 1);		smp_mb();
					r3 = READ_ONCE(x);

The problem is that we are applying intuitions obtained from a
release-acquire chain, which hands off from stores to loads.  In contrast,
this example is quite weird in that we have a store handing off to another
store, but with reads also involved.  Making that work on Power requires
full memory barriers on both sides.  Intuitively, the coherence order
can be established after the fact as long as all readers see a consistent
set of values based on the subset of the sequence that each reader sees.

Anyway, it looks like Power does need a sync before and after for
value-returning atomics.  That certainly simplifies the analysis.

							Thanx, Paul
