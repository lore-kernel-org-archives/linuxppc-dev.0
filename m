Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0602B1A2BFF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 02:40:59 +1000 (AEST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 14 Sep 2015 10:40:45 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 49A503E40062
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 10:40:42 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8EGegbu1376612
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 09:40:42 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8EGedr0018851
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 10:40:42 -0600
Date: Mon, 14 Sep 2015 09:26:40 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC 3/5] powerpc: atomic: implement
 atomic{,64}_{add,sub}_return_* variants
Message-ID: <20150914162640.GU4029@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20150828141602.GA924@fixme-laptop.cn.ibm.com>
 <20150828153921.GF19282@twins.programming.kicks-ass.net>
 <20150901190027.GP1612@arm.com>
 <20150901214540.GI4029@linux.vnet.ibm.com>
 <20150902095906.GC25720@arm.com> <20150911124507.GB16833@arm.com>
 <20150914113520.GP18489@twins.programming.kicks-ass.net>
 <20150914120153.GY18673@twins.programming.kicks-ass.net>
 <20150914121156.GZ18673@twins.programming.kicks-ass.net>
 <20150914153848.GE23878@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150914153848.GE23878@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 14, 2015 at 04:38:48PM +0100, Will Deacon wrote:
> On Mon, Sep 14, 2015 at 01:11:56PM +0100, Peter Zijlstra wrote:
> > On Mon, Sep 14, 2015 at 02:01:53PM +0200, Peter Zijlstra wrote:
> > > The scenario is:
> > > 
> > > 	CPU0			CPU1
> > > 
> > > 				unlock(x)
> > > 				  smp_store_release(&x->lock, 0);
> > > 
> > > 	unlock(y)
> > > 	  smp_store_release(&next->lock, 1); /* next == &y */
> > > 
> > > 				lock(y)
> > > 				  while (!(smp_load_acquire(&y->lock))
> > > 					cpu_relax();
> > > 
> > > 
> > > Where the lock does _NOT_ issue a store to acquire the lock at all. Now
> > > I don't think any of our current primitives manage this, so we should be
> > > good, but it might just be possible.
> > 
> > So with a bit more through this seems fundamentally impossible, you
> > always needs some stores in a lock() implementation, the above for
> > instance needs to queue itself, otherwise CPU0 will not be able to find
> > it etc..
> 
> Which brings us back round to separating LOCK/UNLOCK from ACQUIRE/RELEASE.

I believe that we do need to do this, unless we decide to have unlock-lock
continue to imply only acquire and release, rather than full ordering.
I believe that Mike Ellerman is working up additional benchmarking
on this.

							Thanx, Paul

> If we say that UNLOCK(foo) -> LOCK(bar) is ordered but RELEASE(baz) ->
> ACQUIRE(boz) is only ordered by smp_mb__release_acquire(), then I think
> we're in a position where we can at least build arbitrary locks portably
> out of ACQUIRE/RELEASE operations, even though I don't see any users of
> that macro in the imminent future.
> 
> I'll have a crack at some documentation.
> 
> Will
> 
