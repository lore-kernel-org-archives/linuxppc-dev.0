Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 396FF1A038B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 20:40:44 +1100 (AEDT)
Date: Fri, 9 Oct 2015 10:40:39 +0100
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151009094039.GD26278@arm.com>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008214439.GE3910@linux.vnet.ibm.com>
 <20151009083138.GU3816@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151009083138.GU3816@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 09, 2015 at 10:31:38AM +0200, Peter Zijlstra wrote:
> On Thu, Oct 08, 2015 at 02:44:39PM -0700, Paul E. McKenney wrote:
> > On Thu, Oct 08, 2015 at 01:16:38PM +0200, Peter Zijlstra wrote:
> > > On Thu, Oct 08, 2015 at 02:50:36PM +1100, Michael Ellerman wrote:
> > > > On Wed, 2015-10-07 at 08:25 -0700, Paul E. McKenney wrote:
> > > 
> > > > > Currently, we do need smp_mb__after_unlock_lock() to be after the
> > > > > acquisition on PPC -- putting it between the unlock and the lock
> > > > > of course doesn't cut it for the cross-thread unlock/lock case.
> > > 
> > > This ^, that makes me think I don't understand
> > > smp_mb__after_unlock_lock.
> > > 
> > > How is:
> > > 
> > > 	UNLOCK x
> > > 	smp_mb__after_unlock_lock()
> > > 	LOCK y
> > > 
> > > a problem? That's still a full barrier.
> > 
> > The problem is that I need smp_mb__after_unlock_lock() to give me
> > transitivity even if the UNLOCK happened on one CPU and the LOCK
> > on another.  For that to work, the smp_mb__after_unlock_lock() needs
> > to be either immediately after the acquire (the current choice) or
> > immediately before the release (which would also work from a purely
> > technical viewpoint, but I much prefer the current choice).
> > 
> > Or am I missing your point?
> 
> So lots of little confusions added up to complete fail :-{
> 
> Mostly I think it was the UNLOCK x + LOCK x are fully ordered (where I
> forgot: but not against uninvolved CPUs) and RELEASE/ACQUIRE are
> transitive (where I forgot: RELEASE/ACQUIRE _chains_ are transitive, but
> again not against uninvolved CPUs).
> 
> Which leads me to think I would like to suggest alternative rules for
> RELEASE/ACQUIRE (to replace those Will suggested; as I think those are
> partly responsible for my confusion).

Yeah, sorry. I originally used the phrase "fully ordered" but changed it
to "full barrier", which has stronger transitivity (newly understood
definition) requirements that I didn't intend.

RELEASE -> ACQUIRE should be used for message passing between two CPUs
and not have ordering effects on other observers unless they're part of
the RELEASE -> ACQUIRE chain.

>  - RELEASE -> ACQUIRE is fully ordered (but not a full barrier) when
>    they operate on the same variable and the ACQUIRE reads from the
>    RELEASE. Notable, RELEASE/ACQUIRE are RCpc and lack transitivity.

Are we explicit about the difference between "fully ordered" and "full
barrier" somewhere else, because this looks like it will confuse people.

>  - RELEASE -> ACQUIRE can be upgraded to a full barrier (including
>    transitivity) using smp_mb__release_acquire(), either before RELEASE
>    or after ACQUIRE (but consistently [*]).

Hmm, but we don't actually need this for RELEASE -> ACQUIRE, afaict. This
is just needed for UNLOCK -> LOCK, and is exactly what RCU is currently
using (for PPC only).

Stepping back a second, I believe that there are three cases:


 RELEASE X -> ACQUIRE Y (same CPU)
   * Needs a barrier on TSO architectures for full ordering

 UNLOCK X -> LOCK Y (same CPU)
   * Needs a barrier on PPC for full ordering

 RELEASE X -> ACQUIRE X (different CPUs)
 UNLOCK X -> ACQUIRE X (different CPUs)
   * Fully ordered everywhere...
   * ... but needs a barrier on PPC to become a full barrier


so maybe it makes more sense to split out the local and inter-cpu ordering
with something like:

  smp_mb__after_release_acquire()
  smp_mb__after_release_acquire_local()

then the first one directly replaces smp_mb__after_unlock_lock, and is
only defined for PPC, whereas the second one is also defined for TSO archs.

>  - RELEASE -> ACQUIRE _chains_ (on shared variables) preserve causality,
>    (because each link is fully ordered) but are not transitive.

Yup, and that's the same for UNLOCK -> LOCK, too.

> And I think that in the past few weeks we've been using transitive
> ambiguously, the definition we have in Documentation/memory-barriers.txt
> is a _strong_ transitivity, where we can make guarantees about CPUs not
> directly involved.
> 
> What we have here (due to RCpc) is a weak form of transitivity, which,
> while it preserves the natural concept of causality, does not extend to
> other CPUs.
> 
> So we could go around and call them 'strong' and 'weak' transitivity,
> but I suspect its easier for everyone involved if we come up with
> separate terms (less room for error if we accidentally omit the
> 'strong/weak' qualifier).

Surely the general case is message passing and so "transitivity" should
just refer to chains of RELEASE -> ACQUIRE? Then "strong transitivity"
could refer to the far more complicated (imo) case that is synonymous
with "full barrier".

Will
