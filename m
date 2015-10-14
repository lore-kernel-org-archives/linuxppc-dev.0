Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440A71A05EF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 08:04:32 +1100 (AEDT)
Date: Wed, 14 Oct 2015 23:04:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151014210419.GY3604@twins.programming.kicks-ass.net>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151014201916.GB3910@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 14, 2015 at 01:19:17PM -0700, Paul E. McKenney wrote:
> Suppose we have something like the following, where "a" and "x" are both
> initially zero:
> 
> 	CPU 0				CPU 1
> 	-----				-----
> 
> 	WRITE_ONCE(x, 1);		WRITE_ONCE(a, 2);
> 	r3 = xchg(&a, 1);		smp_mb();
> 					r3 = READ_ONCE(x);
> 
> If xchg() is fully ordered, we should never observe both CPUs'
> r3 values being zero, correct?
> 
> And wouldn't this be represented by the following litmus test?
> 
> 	PPC SB+lwsync-RMW2-lwsync+st-sync-leading
> 	""
> 	{
> 	0:r1=1; 0:r2=x; 0:r3=3; 0:r10=0 ; 0:r11=0; 0:r12=a;
> 	1:r1=2; 1:r2=x; 1:r3=3; 1:r10=0 ; 1:r11=0; 1:r12=a;
> 	}
> 	 P0                 | P1                 ;
> 	 stw r1,0(r2)       | stw r1,0(r12)      ;
> 	 lwsync             | sync               ;
> 	 lwarx  r11,r10,r12 | lwz r3,0(r2)       ;
> 	 stwcx. r1,r10,r12  | ;
> 	 bne Fail0          | ;
> 	 mr r3,r11          | ;
> 	 Fail0:             | ;
> 	exists
> 	(0:r3=0 /\ a=2 /\ 1:r3=0)
> 
> I left off P0's trailing sync because there is nothing for it to order
> against in this particular litmus test.  I tried adding it and verified
> that it has no effect.
> 
> Am I missing something here?  If not, it seems to me that you need
> the leading lwsync to instead be a sync.

So the scenario that would fail would be this one, right?

a = x = 0

	CPU0				CPU1

	r3 = load_locked (&a);
					a = 2;
					sync();
					r3 = x;
	x = 1;
	lwsync();
	if (!store_cond(&a, 1))
		goto again


Where we hoist the load way up because lwsync allows this.

I always thought this would fail because CPU1's store to @a would fail
the store_cond() on CPU0 and we'd do the 'again' thing, re-issuing the
load and now seeing the new value (2).

> Of course, if I am not missing something, then this applies also to the
> value-returning RMW atomic operations that you pulled this pattern from.
> If so, it would seem that I didn't think through all the possibilities
> back when PPC_ATOMIC_EXIT_BARRIER moved to sync...  In fact, I believe
> that I worried about the RMW atomic operation acting as a barrier,
> but not as the load/store itself.  :-/

AARGH64 does something very similar; it does something like:

	ll
	...
	sc-release

	mb

Which I assumed worked for the same reason, any change to the variable
would fail the sc, and we go for round 2, now observing the new value.
