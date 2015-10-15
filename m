Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 81DBC1A08B5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 03:30:49 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 15 Oct 2015 10:30:47 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id BA30019D805C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 10:18:51 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t9FGTdGT65208474
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 09:29:39 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9FGUd8k001839
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 10:30:40 -0600
Date: Thu, 15 Oct 2015 09:30:40 -0700
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
Message-ID: <20151015163040.GJ3910@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151014210419.GY3604@twins.programming.kicks-ass.net>
 <20151014214453.GC3910@linux.vnet.ibm.com>
 <20151015005321.GB29432@fixme-laptop.cn.ibm.com>
 <20151015030705.GD3910@linux.vnet.ibm.com>
 <20151015044803.GC29432@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151015044803.GC29432@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 15, 2015 at 12:48:03PM +0800, Boqun Feng wrote:
> On Wed, Oct 14, 2015 at 08:07:05PM -0700, Paul E. McKenney wrote:
> > On Thu, Oct 15, 2015 at 08:53:21AM +0800, Boqun Feng wrote:
> [snip]
> > > 
> > > I'm afraid more than that, the above litmus also shows that
> > > 
> > > 	CPU 0				CPU 1
> > > 	-----				-----
> > > 
> > > 	WRITE_ONCE(x, 1);		WRITE_ONCE(a, 2);
> > > 	r3 = xchg_release(&a, 1);	smp_mb();
> > > 					r3 = READ_ONCE(x);
> > > 
> > > 	(0:r3 == 0 && 1:r3 == 0 && a == 2) is not prohibitted
> > > 
> > > in the implementation of this patchset, which should be disallowed by
> > > the semantics of RELEASE, right?
> > 
> > Not necessarily.  If you had the read first on CPU 1, and you had a
> > similar problem, I would be more worried.
> > 
> 
> Sometimes I think maybe we should say that a single unpaired ACQUIRE or
> RELEASE doesn't have any order guarantee because of the above case.
> 
> But seems that's not a normal or even existing case, my bad ;-(
> 
> > > And even:
> > > 
> > > 	CPU 0				CPU 1
> > > 	-----				-----
> > > 
> > > 	WRITE_ONCE(x, 1);		WRITE_ONCE(a, 2);
> > > 	smp_store_release(&a, 1);	smp_mb();
> > > 					r3 = READ_ONCE(x);
> > > 
> > > 	(1:r3 == 0 && a == 2) is not prohibitted
> > > 
> > > shows by:
> > > 
> > > 	PPC weird-lwsync
> > > 	""
> > > 	{
> > > 	0:r1=1; 0:r2=x; 0:r3=3; 0:r12=a;
> > > 	1:r1=2; 1:r2=x; 1:r3=3; 1:r12=a;
> > > 	}
> > > 	 P0                 | P1                 ;
> > > 	 stw r1,0(r2)       | stw r1,0(r12)      ;
> > > 	 lwsync             | sync               ;
> > > 	 stw  r1,0(r12)	    | lwz r3,0(r2)       ;
> > > 	exists
> > > 	(a=2 /\ 1:r3=0)
> > > 
> > > Please find something I'm (or the tool is) missing, maybe we can't use
> > > (a == 2) as a indication that STORE on CPU 1 happens after STORE on CPU
> > > 0?
> > 
> > Again, if you were pairing the smp_store_release() with an smp_load_acquire()
> > or even a READ_ONCE() followed by a barrier, I would be quite concerned.
> > I am not at all worried about the above two litmus tests.
> > 
> 
> Understood, thank you for think through that ;-)
> 
> > > And there is really something I find strange, see below.
> > > 
> > > > > 
> > > > > So the scenario that would fail would be this one, right?
> > > > > 
> > > > > a = x = 0
> > > > > 
> > > > > 	CPU0				CPU1
> > > > > 
> > > > > 	r3 = load_locked (&a);
> > > > > 					a = 2;
> > > > > 					sync();
> > > > > 					r3 = x;
> > > > > 	x = 1;
> > > > > 	lwsync();
> > > > > 	if (!store_cond(&a, 1))
> > > > > 		goto again
> > > > > 
> > > > > 
> > > > > Where we hoist the load way up because lwsync allows this.
> > > > 
> > > > That scenario would end up with a==1 rather than a==2.
> > > > 
> > > > > I always thought this would fail because CPU1's store to @a would fail
> > > > > the store_cond() on CPU0 and we'd do the 'again' thing, re-issuing the
> > > > > load and now seeing the new value (2).
> > > > 
> > > > The stwcx. failure was one thing that prevented a number of other
> > > > misordering cases.  The problem is that we have to let go of the notion
> > > > of an implicit global clock.
> > > > 
> > > > To that end, the herd tool can make a diagram of what it thought
> > > > happened, and I have attached it.  I used this diagram to try and force
> > > > this scenario at https://www.cl.cam.ac.uk/~pes20/ppcmem/index.html#PPC,
> > > > and succeeded.  Here is the sequence of events:
> > > > 
> > > > o	Commit P0's write.  The model offers to propagate this write
> > > > 	to the coherence point and to P1, but don't do so yet.
> > > > 
> > > > o	Commit P1's write.  Similar offers, but don't take them up yet.
> > > > 
> > > > o	Commit P0's lwsync.
> > > > 
> > > > o	Execute P0's lwarx, which reads a=0.  Then commit it.
> > > > 
> > > > o	Commit P0's stwcx. as successful.  This stores a=1.
> > > > 
> > > > o	Commit P0's branch (not taken).
> > > 
> > > So at this point, P0's write to 'a' has propagated to P1, right? But
> > > P0's write to 'x' hasn't, even there is a lwsync between them, right?
> > > Doesn't the lwsync prevent this from happening?
> > 
> > No, because lwsync is quite a bit weaker than sync aside from just
> > the store-load ordering.
> > 
> 
> Understood, I've tried the ppcmem, much clear now ;-)
> 
> > > If at this point P0's write to 'a' hasn't propagated then when?
> > 
> > Later.  At the very end of the test, in this case.  ;-)
> > 
> 
> Hmm.. I tried exactly this sequence in ppcmem, seems propagation of P0's
> write to 'a' is never an option...
> 
> > Why not try creating a longer litmus test that requires P0's write to
> > "a" to propagate to P1 before both processes complete?
> > 
> 
> I will try to write one, but to be clear, you mean we still observe 
> 
> 0:r3 == 0 && a == 2 && 1:r3 == 0 
> 
> at the end, right? Because I understand that if P1's write to 'a'
> doesn't override P0's, P0's write to 'a' will propagate.

Your choice.  My question is whether you can come up with a similar
litmus test where lwsync is allowing the behavior here, but clearly
is affecting some other aspect of ordering.

							Thanx, Paul
