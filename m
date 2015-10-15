Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 84AAC1A01BA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 14:33:14 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 14 Oct 2015 21:33:11 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id C03BB1FF0049
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 21:21:20 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t9F3W70Q10092914
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 20:32:07 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9F3X6sw026931
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 21:33:08 -0600
Date: Wed, 14 Oct 2015 20:33:05 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151015033305.GF3910@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151014210419.GY3604@twins.programming.kicks-ass.net>
 <20151014214453.GC3910@linux.vnet.ibm.com>
 <20151015005321.GB29432@fixme-laptop.cn.ibm.com>
 <20151015031101.GD14305@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151015031101.GD14305@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 15, 2015 at 11:11:01AM +0800, Boqun Feng wrote:
> Hi Paul,
> 
> On Thu, Oct 15, 2015 at 08:53:21AM +0800, Boqun Feng wrote:
> > On Wed, Oct 14, 2015 at 02:44:53PM -0700, Paul E. McKenney wrote:
> [snip]
> > > To that end, the herd tool can make a diagram of what it thought
> > > happened, and I have attached it.  I used this diagram to try and force
> > > this scenario at https://www.cl.cam.ac.uk/~pes20/ppcmem/index.html#PPC,
> > > and succeeded.  Here is the sequence of events:
> > > 
> > > o	Commit P0's write.  The model offers to propagate this write
> > > 	to the coherence point and to P1, but don't do so yet.
> > > 
> > > o	Commit P1's write.  Similar offers, but don't take them up yet.
> > > 
> > > o	Commit P0's lwsync.
> > > 
> > > o	Execute P0's lwarx, which reads a=0.  Then commit it.
> > > 
> > > o	Commit P0's stwcx. as successful.  This stores a=1.
> > > 
> > > o	Commit P0's branch (not taken).
> > > 
> > 
> > So at this point, P0's write to 'a' has propagated to P1, right? But
> > P0's write to 'x' hasn't, even there is a lwsync between them, right?
> > Doesn't the lwsync prevent this from happening?
> > 
> > If at this point P0's write to 'a' hasn't propagated then when?
> 
> Hmm.. I played around ppcmem, and figured out what happens to
> propagation of P0's write to 'a':
> 
> At this point, or some point after store 'a' to 1 and before sync on
> P1 finish, writes to 'a' reachs a coherence point which 'a' is 2, so
> P0's write to 'a' "fails" and will not propagate.
> 
> I probably misunderstood the word "propagate", which actually means an
> already coherent write gets seen by another CPU, right?

It is quite possible for a given write to take a position in the coherence
order that guarantees that no one will see it, as is the case here.
But yes, all readers will see an order of values for a given memory
location that is consistent with the coherence order.

> So my question should be:
> 
> As lwsync can order P0's write to 'a' happens after P0's write to 'x',
> why P0's write to 'x' isn't seen by P1 after P1's write to 'a' overrides
> P0's?

There is no global clock for PPC's memory model.

> But ppcmem gave me the answer ;-) lwsync won't wait under P0's write to
> 'x' gets propagated, and if P0's write to 'a' "wins" in write coherence,
> lwsync will guarantee propagation of 'x' happens before that of 'a', but
> if P0's write to 'a' "fails", there will be no propagation of 'a' from
> P0. So that lwsync can't do anything here.

I believe that this is consistent, but the corners can get tricky.

							Thanx, Paul

> Regards,
> Boqun
> 
> > 
> > > o	Commit P0's final register-to-register move.
> > > 
> > > o	Commit P1's sync instruction.
> > > 
> > > o	There is now nothing that can happen in either processor.
> > > 	P0 is done, and P1 is waiting for its sync.  Therefore,
> > > 	propagate P1's a=2 write to the coherence point and to
> > > 	the other thread.
> > > 
> > > o	There is still nothing that can happen in either processor.
> > > 	So pick the barrier propagate, then the acknowledge sync.
> > > 
> > > o	P1 can now execute its read from x.  Because P0's write to
> > > 	x is still waiting to propagate to P1, this still reads
> > > 	x=0.  Execute and commit, and we now have both r3 registers
> > > 	equal to zero and the final value a=2.
> > > 
> > > o	Clean up by propagating the write to x everywhere, and
> > > 	propagating the lwsync.
> > > 
> > > And the "exists" clause really does trigger: 0:r3=0; 1:r3=0; [a]=2;
> > > 
> > > I am still not 100% confident of my litmus test.  It is quite possible
> > > that I lost something in translation, but that is looking less likely.
> > > 
