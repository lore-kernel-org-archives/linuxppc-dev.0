Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 390991A0396
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 14:07:12 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 14 Oct 2015 21:07:10 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 372361FF0041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 20:55:20 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t9F367jm10355066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 20:06:07 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9F376um022787
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 21:07:08 -0600
Date: Wed, 14 Oct 2015 20:07:05 -0700
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
Message-ID: <20151015030705.GD3910@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151014210419.GY3604@twins.programming.kicks-ass.net>
 <20151014214453.GC3910@linux.vnet.ibm.com>
 <20151015005321.GB29432@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151015005321.GB29432@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 15, 2015 at 08:53:21AM +0800, Boqun Feng wrote:
> On Wed, Oct 14, 2015 at 02:44:53PM -0700, Paul E. McKenney wrote:
> > On Wed, Oct 14, 2015 at 11:04:19PM +0200, Peter Zijlstra wrote:
> > > On Wed, Oct 14, 2015 at 01:19:17PM -0700, Paul E. McKenney wrote:
> > > > Suppose we have something like the following, where "a" and "x" are both
> > > > initially zero:
> > > > 
> > > > 	CPU 0				CPU 1
> > > > 	-----				-----
> > > > 
> > > > 	WRITE_ONCE(x, 1);		WRITE_ONCE(a, 2);
> > > > 	r3 = xchg(&a, 1);		smp_mb();
> > > > 					r3 = READ_ONCE(x);
> > > > 
> > > > If xchg() is fully ordered, we should never observe both CPUs'
> > > > r3 values being zero, correct?
> > > > 
> > > > And wouldn't this be represented by the following litmus test?
> > > > 
> > > > 	PPC SB+lwsync-RMW2-lwsync+st-sync-leading
> > > > 	""
> > > > 	{
> > > > 	0:r1=1; 0:r2=x; 0:r3=3; 0:r10=0 ; 0:r11=0; 0:r12=a;
> > > > 	1:r1=2; 1:r2=x; 1:r3=3; 1:r10=0 ; 1:r11=0; 1:r12=a;
> > > > 	}
> > > > 	 P0                 | P1                 ;
> > > > 	 stw r1,0(r2)       | stw r1,0(r12)      ;
> > > > 	 lwsync             | sync               ;
> > > > 	 lwarx  r11,r10,r12 | lwz r3,0(r2)       ;
> > > > 	 stwcx. r1,r10,r12  | ;
> > > > 	 bne Fail0          | ;
> > > > 	 mr r3,r11          | ;
> > > > 	 Fail0:             | ;
> > > > 	exists
> > > > 	(0:r3=0 /\ a=2 /\ 1:r3=0)
> > > > 
> > > > I left off P0's trailing sync because there is nothing for it to order
> > > > against in this particular litmus test.  I tried adding it and verified
> > > > that it has no effect.
> > > > 
> > > > Am I missing something here?  If not, it seems to me that you need
> > > > the leading lwsync to instead be a sync.
> 
> I'm afraid more than that, the above litmus also shows that
> 
> 	CPU 0				CPU 1
> 	-----				-----
> 
> 	WRITE_ONCE(x, 1);		WRITE_ONCE(a, 2);
> 	r3 = xchg_release(&a, 1);	smp_mb();
> 					r3 = READ_ONCE(x);
> 
> 	(0:r3 == 0 && 1:r3 == 0 && a == 2) is not prohibitted
> 
> in the implementation of this patchset, which should be disallowed by
> the semantics of RELEASE, right?

Not necessarily.  If you had the read first on CPU 1, and you had a
similar problem, I would be more worried.

> And even:
> 
> 	CPU 0				CPU 1
> 	-----				-----
> 
> 	WRITE_ONCE(x, 1);		WRITE_ONCE(a, 2);
> 	smp_store_release(&a, 1);	smp_mb();
> 					r3 = READ_ONCE(x);
> 
> 	(1:r3 == 0 && a == 2) is not prohibitted
> 
> shows by:
> 
> 	PPC weird-lwsync
> 	""
> 	{
> 	0:r1=1; 0:r2=x; 0:r3=3; 0:r12=a;
> 	1:r1=2; 1:r2=x; 1:r3=3; 1:r12=a;
> 	}
> 	 P0                 | P1                 ;
> 	 stw r1,0(r2)       | stw r1,0(r12)      ;
> 	 lwsync             | sync               ;
> 	 stw  r1,0(r12)	    | lwz r3,0(r2)       ;
> 	exists
> 	(a=2 /\ 1:r3=0)
> 
> Please find something I'm (or the tool is) missing, maybe we can't use
> (a == 2) as a indication that STORE on CPU 1 happens after STORE on CPU
> 0?

Again, if you were pairing the smp_store_release() with an smp_load_acquire()
or even a READ_ONCE() followed by a barrier, I would be quite concerned.
I am not at all worried about the above two litmus tests.

> And there is really something I find strange, see below.
> 
> > > 
> > > So the scenario that would fail would be this one, right?
> > > 
> > > a = x = 0
> > > 
> > > 	CPU0				CPU1
> > > 
> > > 	r3 = load_locked (&a);
> > > 					a = 2;
> > > 					sync();
> > > 					r3 = x;
> > > 	x = 1;
> > > 	lwsync();
> > > 	if (!store_cond(&a, 1))
> > > 		goto again
> > > 
> > > 
> > > Where we hoist the load way up because lwsync allows this.
> > 
> > That scenario would end up with a==1 rather than a==2.
> > 
> > > I always thought this would fail because CPU1's store to @a would fail
> > > the store_cond() on CPU0 and we'd do the 'again' thing, re-issuing the
> > > load and now seeing the new value (2).
> > 
> > The stwcx. failure was one thing that prevented a number of other
> > misordering cases.  The problem is that we have to let go of the notion
> > of an implicit global clock.
> > 
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
> > 
> > o	Commit P0's branch (not taken).
> 
> So at this point, P0's write to 'a' has propagated to P1, right? But
> P0's write to 'x' hasn't, even there is a lwsync between them, right?
> Doesn't the lwsync prevent this from happening?

No, because lwsync is quite a bit weaker than sync aside from just
the store-load ordering.

> If at this point P0's write to 'a' hasn't propagated then when?

Later.  At the very end of the test, in this case.  ;-)

Why not try creating a longer litmus test that requires P0's write to
"a" to propagate to P1 before both processes complete?

							Thanx, Paul

> Regards,
> Boqun
> 
> > o	Commit P0's final register-to-register move.
> > 
> > o	Commit P1's sync instruction.
> > 
> > o	There is now nothing that can happen in either processor.
> > 	P0 is done, and P1 is waiting for its sync.  Therefore,
> > 	propagate P1's a=2 write to the coherence point and to
> > 	the other thread.
> > 
> > o	There is still nothing that can happen in either processor.
> > 	So pick the barrier propagate, then the acknowledge sync.
> > 
> > o	P1 can now execute its read from x.  Because P0's write to
> > 	x is still waiting to propagate to P1, this still reads
> > 	x=0.  Execute and commit, and we now have both r3 registers
> > 	equal to zero and the final value a=2.
> > 
> > o	Clean up by propagating the write to x everywhere, and
> > 	propagating the lwsync.
> > 
> > And the "exists" clause really does trigger: 0:r3=0; 1:r3=0; [a]=2;
> > 
> > I am still not 100% confident of my litmus test.  It is quite possible
> > that I lost something in translation, but that is looking less likely.
> > 
> > > > Of course, if I am not missing something, then this applies also to the
> > > > value-returning RMW atomic operations that you pulled this pattern from.
> > > > If so, it would seem that I didn't think through all the possibilities
> > > > back when PPC_ATOMIC_EXIT_BARRIER moved to sync...  In fact, I believe
> > > > that I worried about the RMW atomic operation acting as a barrier,
> > > > but not as the load/store itself.  :-/
> > > 
> > > AARGH64 does something very similar; it does something like:
> > > 
> > > 	ll
> > > 	...
> > > 	sc-release
> > > 
> > > 	mb
> > > 
> > > Which I assumed worked for the same reason, any change to the variable
> > > would fail the sc, and we go for round 2, now observing the new value.
> > 
> > I have to defer to Will on this one.  You are right that ARM and PowerPC
> > do have similar memory models, but there are some differences.
> > 
> > 							Thanx, Paul
> 
> 
