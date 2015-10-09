Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 702A21A0562
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2015 04:21:57 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 9 Oct 2015 11:21:55 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id CB5201FF0041
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 11:10:05 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t99HKab53146066
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2015 10:20:36 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t99HLqMK015279
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2015 11:21:53 -0600
Date: Fri, 9 Oct 2015 10:21:54 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151009172154.GU3910@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008214439.GE3910@linux.vnet.ibm.com>
 <20151009083138.GU3816@twins.programming.kicks-ass.net>
 <20151009094039.GD26278@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151009094039.GD26278@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 09, 2015 at 10:40:39AM +0100, Will Deacon wrote:
> On Fri, Oct 09, 2015 at 10:31:38AM +0200, Peter Zijlstra wrote:
> > On Thu, Oct 08, 2015 at 02:44:39PM -0700, Paul E. McKenney wrote:
> > > On Thu, Oct 08, 2015 at 01:16:38PM +0200, Peter Zijlstra wrote:
> > > > On Thu, Oct 08, 2015 at 02:50:36PM +1100, Michael Ellerman wrote:
> > > > > On Wed, 2015-10-07 at 08:25 -0700, Paul E. McKenney wrote:
> > > > 
> > > > > > Currently, we do need smp_mb__after_unlock_lock() to be after the
> > > > > > acquisition on PPC -- putting it between the unlock and the lock
> > > > > > of course doesn't cut it for the cross-thread unlock/lock case.
> > > > 
> > > > This ^, that makes me think I don't understand
> > > > smp_mb__after_unlock_lock.
> > > > 
> > > > How is:
> > > > 
> > > > 	UNLOCK x
> > > > 	smp_mb__after_unlock_lock()
> > > > 	LOCK y
> > > > 
> > > > a problem? That's still a full barrier.
> > > 
> > > The problem is that I need smp_mb__after_unlock_lock() to give me
> > > transitivity even if the UNLOCK happened on one CPU and the LOCK
> > > on another.  For that to work, the smp_mb__after_unlock_lock() needs
> > > to be either immediately after the acquire (the current choice) or
> > > immediately before the release (which would also work from a purely
> > > technical viewpoint, but I much prefer the current choice).
> > > 
> > > Or am I missing your point?
> > 
> > So lots of little confusions added up to complete fail :-{

I know that feeling!

> > Mostly I think it was the UNLOCK x + LOCK x are fully ordered (where I
> > forgot: but not against uninvolved CPUs) and RELEASE/ACQUIRE are
> > transitive (where I forgot: RELEASE/ACQUIRE _chains_ are transitive, but
> > again not against uninvolved CPUs).
> > 
> > Which leads me to think I would like to suggest alternative rules for
> > RELEASE/ACQUIRE (to replace those Will suggested; as I think those are
> > partly responsible for my confusion).
> 
> Yeah, sorry. I originally used the phrase "fully ordered" but changed it
> to "full barrier", which has stronger transitivity (newly understood
> definition) requirements that I didn't intend.
> 
> RELEASE -> ACQUIRE should be used for message passing between two CPUs
> and not have ordering effects on other observers unless they're part of
> the RELEASE -> ACQUIRE chain.
> 
> >  - RELEASE -> ACQUIRE is fully ordered (but not a full barrier) when
> >    they operate on the same variable and the ACQUIRE reads from the
> >    RELEASE. Notable, RELEASE/ACQUIRE are RCpc and lack transitivity.

RELEASE->ACQUIRE has local transistivity/causality.  However, it is more
than just message passing:

	void thread0(void)
	{
		r1 = READ_ONCE(a);
		WRITE_ONCE(b, 1);
		smp_store_release(&c, 1);
	}

	void thread1(void)
	{
		r2 = smp_store_acquire(&c);
		WRITE_ONCE(a, 1);
		r3 = READ_ONCE(b);
		smp_store_release(&d, 1);
	}

	void thread2(void)
	{
		r4 = smp_load_acquire(&d);
		WRITE_ONCE(a, 2);
		r5 = READ_ONCE(b);
	}

After the dust settles, if r2==1&&r4==1, we should also have
r1==0&&r3==1&&r5==1.  And here is the PowerPC ppcmem/herd model:

------------------------------------------------------------------------

PPC LinuxAcqRelLocal
""
(*
 * Does a powerpc lwsync-based Acq-Rel chain provide local causality?
 * October 9, 2015: Yes.
 *)
{
a=0; b=0; c=0; d=0;
0:r0=1; 0:r11=a; 0:r12=b; 0:r13=c; 0:r14=d;
1:r0=1; 1:r11=a; 1:r12=b; 1:r13=c; 1:r14=d;
2:r0=2; 2:r11=a; 2:r12=b; 2:r13=c; 2:r14=d;
}
 P0            | P1            | P2            ;
 lwz r1,0(r11) | lwz r2,0(r13) | lwz r4,0(r14) ;
 stw r0,0(r12) | lwsync        | lwsync        ;
 lwsync        | stw r0,0(r11) | stw r0,0(r11) ;
 stw r0,0(r13) | lwz r3,0(r12) | lwz r5,0(r12) ;
               | lwsync        |               ;
               | stw r0,0(r14) |               ;
exists
(1:r2=1 /\ 2:r4=1 /\ (0:r1=1 \/ 0:r1=2 \/ 1:r3=0 \/ 2:r5=0))

------------------------------------------------------------------------

This confirms the local causality/transitivity.

So let's add an uninvolved observer thread, which will also require adding
another variable to avoid ordering via cache coherence:

	void thread0(void)
	{
		r1 = READ_ONCE(a);
		WRITE_ONCE(b, 1);
		smp_store_release(&c, 1);
	}

	void thread1(void)
	{
		r2 = smp_store_acquire(&c);
		WRITE_ONCE(a, 1);
		r3 = READ_ONCE(b);
		smp_store_release(&d, 1);
	}

	void thread2(void)
	{
		r4 = smp_load_acquire(&d);
		WRITE_ONCE(a, 2);
		r5 = READ_ONCE(b);
		r6 = READ_ONCE(e);
	}

	void thread3(void) /* uninvolved observer */
	{
		WRITE_ONCE(e, 1);
		smp_mb();
		r7 = READ_ONCE(b);
	}

Can we see r2==1&&r4==1&&r6=0&&r7==0?  Here is the PowerPC model:

------------------------------------------------------------------------

PPC LinuxAcqRelGlobal
""
(*
 * Does a powerpc lwsync-based Acq-Rel chain provide global causality?
 * October 9, 2015: No.
 *)
{
a=0; b=0; c=0; d=0; e=0;
0:r0=1; 0:r11=a; 0:r12=b; 0:r13=c; 0:r14=d; 0:r15=e;
1:r0=1; 1:r11=a; 1:r12=b; 1:r13=c; 1:r14=d; 1:r15=e;
2:r0=2; 2:r11=a; 2:r12=b; 2:r13=c; 2:r14=d; 2:r15=e;
3:r0=1; 3:r11=a; 3:r12=b; 3:r13=c; 3:r14=d; 3:r15=e;
}
 P0            | P1            | P2            | P3            ;
 lwz r1,0(r11) | lwz r2,0(r13) | lwz r4,0(r14) | stw r0,0(r15) ;
 stw r0,0(r12) | lwsync        | lwsync        | sync          ;
 lwsync        | stw r0,0(r11) | stw r0,0(r11) | lwz r7,0(r12) ;
 stw r0,0(r13) | lwz r3,0(r12) | lwz r5,0(r12) |               ;
               | lwsync        | lwz r6,0(r15) |               ;
               | stw r0,0(r14) |               |               ;
exists
(1:r2=1 /\ 2:r4=1 /\ 2:r6=0 /\ 3:r7=0)

------------------------------------------------------------------------

And, as expected, P3 can see misordering because it is not involved
in the acquire-release chain.

> Are we explicit about the difference between "fully ordered" and "full
> barrier" somewhere else, because this looks like it will confuse people.

Probably not.  We need something meaning "local transitivity" on the
one hand and "global transitivity" on the other.  I suppose we could use
"causality" for the local case and "transitivity" for the global case,
but I do not believe that normal formal/mathematical usage matches this.

The term "single-copy atomic" could reasonably be used to mean "local
transitivity" and "multi-copy atomic" to mean "global transitivity",
but those are all too easy to confuse with each other, require a lot of
knowledge to understand, and don't exactly roll off the tongue.

The phrases "locally visible causality" and "globally visible causality"
should be (relatively) easy to understand, but don't exactly roll off
the tongue, either.

Maybe LVC and GVC?

LVC:  Locally visible causality:  If you are in the causal chain,
	you are guaranteed to see the ordering.  Otherwise, you
	might not.

GVC: Globally visible causality:  You are guarantee to see the
	ordering whether or not you are in the causal chain.

I could of course poll the memory-ordering academics and get more options.  ;-)

> >  - RELEASE -> ACQUIRE can be upgraded to a full barrier (including
> >    transitivity) using smp_mb__release_acquire(), either before RELEASE
> >    or after ACQUIRE (but consistently [*]).
> 
> Hmm, but we don't actually need this for RELEASE -> ACQUIRE, afaict. This
> is just needed for UNLOCK -> LOCK, and is exactly what RCU is currently
> using (for PPC only).

If by "don't actually need this" you mean "don't currently know of a
use case", I agree.  For now, anyway.  ;-)

> Stepping back a second, I believe that there are three cases:
> 
> 
>  RELEASE X -> ACQUIRE Y (same CPU)
>    * Needs a barrier on TSO architectures for full ordering

Agreed, assuming these restatements match your views:

Compiler barrier() for TSO for ordering to be visible within the causal chain.

Memory-barrier instruction for TSO for ordering to be visible globally.

>  UNLOCK X -> LOCK Y (same CPU)
>    * Needs a barrier on PPC for full ordering

Where "full ordering" is what I have been calling "globally visible
ordering" (or transitivity or causality or whatever), agreed.

>  RELEASE X -> ACQUIRE X (different CPUs)
>  UNLOCK X -> ACQUIRE X (different CPUs)
>    * Fully ordered everywhere...
>    * ... but needs a barrier on PPC to become a full barrier

Agreed, assuming these restatements match your views:

With compiler barrier (for TSO) or lwsync-capable memory-barrier instruction
(for weakly ordered systems), ordering is visible within the causal chain.

With compiler barrier (for TSO) or full memory-barrier instruction
(for weakly ordered systems), ordering is visible globally.

> so maybe it makes more sense to split out the local and inter-cpu ordering
> with something like:
> 
>   smp_mb__after_release_acquire()
>   smp_mb__after_release_acquire_local()
> 
> then the first one directly replaces smp_mb__after_unlock_lock, and is
> only defined for PPC, whereas the second one is also defined for TSO archs.

I don't see the need for the _local() variant.  We already have
smp_store_release() and smp_load_acquire(), both of which imply any
barriers needed for the case of locally visible causality.

> >  - RELEASE -> ACQUIRE _chains_ (on shared variables) preserve causality,
> >    (because each link is fully ordered) but are not transitive.
> 
> Yup, and that's the same for UNLOCK -> LOCK, too.

Any transitive ordering is visible only locally, within the chain.
For global visibility, you need smp_mb__after_release_acquire().

> > And I think that in the past few weeks we've been using transitive
> > ambiguously, the definition we have in Documentation/memory-barriers.txt
> > is a _strong_ transitivity, where we can make guarantees about CPUs not
> > directly involved.
> > 
> > What we have here (due to RCpc) is a weak form of transitivity, which,
> > while it preserves the natural concept of causality, does not extend to
> > other CPUs.
> > 
> > So we could go around and call them 'strong' and 'weak' transitivity,
> > but I suspect its easier for everyone involved if we come up with
> > separate terms (less room for error if we accidentally omit the
> > 'strong/weak' qualifier).
> 
> Surely the general case is message passing and so "transitivity" should
> just refer to chains of RELEASE -> ACQUIRE? Then "strong transitivity"
> could refer to the far more complicated (imo) case that is synonymous
> with "full barrier".

We should have fun agreeing on the best words to describe all this, but
agreed.

One nit:  RELEASE->ACQUIRE chains can do more than message passing.
Anything before the RELEASE, be it a load or a store, is visible to
anything after any ACQUIRE further down the chain.  Here a prior load is
"visible" to a subsequent store in the sense that the store cannot affect
the value loaded.  This is consistent with the C11/C++11 memory model.

Seem reasonable?

							Thanx, Paul
