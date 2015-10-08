Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id E1A191A018C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 23:59:43 +1100 (AEDT)
Date: Thu, 8 Oct 2015 13:59:38 +0100
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, paulmck@linux.vnet.ibm.com,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151008125937.GH16807@arm.com>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151008111638.GL3816@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 08, 2015 at 01:16:38PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 08, 2015 at 02:50:36PM +1100, Michael Ellerman wrote:
> > On Wed, 2015-10-07 at 08:25 -0700, Paul E. McKenney wrote:
> 
> > > Currently, we do need smp_mb__after_unlock_lock() to be after the
> > > acquisition on PPC -- putting it between the unlock and the lock
> > > of course doesn't cut it for the cross-thread unlock/lock case.
> 
> This ^, that makes me think I don't understand
> smp_mb__after_unlock_lock.
> 
> How is:
> 
> 	UNLOCK x
> 	smp_mb__after_unlock_lock()
> 	LOCK y
> 
> a problem? That's still a full barrier.

I thought Paul was talking about something like this case:


CPU A     CPU B              CPU C
foo = 1
UNLOCK x
          LOCK x
          (RELEASE) bar = 1
                             ACQUIRE bar = 1
                             READ_ONCE foo = 0


but this looks the same as ISA2+lwsyncs/ISA2+lwsync+ctrlisync+lwsync,
which are both forbidden on PPC, so now I'm also confused.

The different-lock, same thread case is more straight-forward, I think.

> > > I am with Peter -- we do need the benchmark results for PPC.
> > 
> > Urgh, sorry guys. I have been slowly doing some benchmarks, but time is not
> > plentiful at the moment.
> > 
> > If we do a straight lwsync -> sync conversion for unlock it looks like that
> > will cost us ~4.2% on Anton's standard context switch benchmark.

Thanks Michael!

> And that does not seem to agree with Paul's smp_mb__after_unlock_lock()
> usage and would not be sufficient for the same (as of yet unexplained)
> reason.
> 
> Why does it matter which of the LOCK or UNLOCK gets promoted to full
> barrier on PPC in order to become RCsc?

I think we need a PPC litmus test illustrating the inter-thread, same
lock failure case when smp_mb__after_unlock_lock is not present so that
we can reason about this properly. Paul?

Will
