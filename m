Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 2A7211A2BE4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 01:38:49 +1000 (AEST)
Date: Mon, 14 Sep 2015 16:38:48 +0100
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC 3/5] powerpc: atomic: implement
 atomic{,64}_{add,sub}_return_* variants
Message-ID: <20150914153848.GE23878@arm.com>
References: <20150828120614.GC29325@fixme-laptop.cn.ibm.com>
 <20150828141602.GA924@fixme-laptop.cn.ibm.com>
 <20150828153921.GF19282@twins.programming.kicks-ass.net>
 <20150901190027.GP1612@arm.com>
 <20150901214540.GI4029@linux.vnet.ibm.com>
 <20150902095906.GC25720@arm.com> <20150911124507.GB16833@arm.com>
 <20150914113520.GP18489@twins.programming.kicks-ass.net>
 <20150914120153.GY18673@twins.programming.kicks-ass.net>
 <20150914121156.GZ18673@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150914121156.GZ18673@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 14, 2015 at 01:11:56PM +0100, Peter Zijlstra wrote:
> On Mon, Sep 14, 2015 at 02:01:53PM +0200, Peter Zijlstra wrote:
> > The scenario is:
> > 
> > 	CPU0			CPU1
> > 
> > 				unlock(x)
> > 				  smp_store_release(&x->lock, 0);
> > 
> > 	unlock(y)
> > 	  smp_store_release(&next->lock, 1); /* next == &y */
> > 
> > 				lock(y)
> > 				  while (!(smp_load_acquire(&y->lock))
> > 					cpu_relax();
> > 
> > 
> > Where the lock does _NOT_ issue a store to acquire the lock at all. Now
> > I don't think any of our current primitives manage this, so we should be
> > good, but it might just be possible.
> 
> So with a bit more through this seems fundamentally impossible, you
> always needs some stores in a lock() implementation, the above for
> instance needs to queue itself, otherwise CPU0 will not be able to find
> it etc..

Which brings us back round to separating LOCK/UNLOCK from ACQUIRE/RELEASE.

If we say that UNLOCK(foo) -> LOCK(bar) is ordered but RELEASE(baz) ->
ACQUIRE(boz) is only ordered by smp_mb__release_acquire(), then I think
we're in a position where we can at least build arbitrary locks portably
out of ACQUIRE/RELEASE operations, even though I don't see any users of
that macro in the imminent future.

I'll have a crack at some documentation.

Will
