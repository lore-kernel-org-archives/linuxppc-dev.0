Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1878E1A03D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 10:34:51 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 20 Oct 2015 17:34:50 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A52B71FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 17:22:58 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t9KNVTJq7274774
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 16:31:29 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9KNYj8h032753
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 17:34:46 -0600
Date: Tue, 20 Oct 2015 16:34:51 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151020233451.GI5105@linux.vnet.ibm.com>
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
 <20151019011718.GB924@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151019011718.GB924@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 19, 2015 at 09:17:18AM +0800, Boqun Feng wrote:
> On Fri, Oct 09, 2015 at 10:40:39AM +0100, Will Deacon wrote:
> > On Fri, Oct 09, 2015 at 10:31:38AM +0200, Peter Zijlstra wrote:
> [snip]
> > > 
> > > So lots of little confusions added up to complete fail :-{
> > > 
> > > Mostly I think it was the UNLOCK x + LOCK x are fully ordered (where I
> > > forgot: but not against uninvolved CPUs) and RELEASE/ACQUIRE are
> > > transitive (where I forgot: RELEASE/ACQUIRE _chains_ are transitive, but
> > > again not against uninvolved CPUs).
> > > 
> > > Which leads me to think I would like to suggest alternative rules for
> > > RELEASE/ACQUIRE (to replace those Will suggested; as I think those are
> > > partly responsible for my confusion).
> > 
> > Yeah, sorry. I originally used the phrase "fully ordered" but changed it
> > to "full barrier", which has stronger transitivity (newly understood
> > definition) requirements that I didn't intend.
> > 
> > RELEASE -> ACQUIRE should be used for message passing between two CPUs
> > and not have ordering effects on other observers unless they're part of
> > the RELEASE -> ACQUIRE chain.
> > 
> > >  - RELEASE -> ACQUIRE is fully ordered (but not a full barrier) when
> > >    they operate on the same variable and the ACQUIRE reads from the
> > >    RELEASE. Notable, RELEASE/ACQUIRE are RCpc and lack transitivity.
> > 
> > Are we explicit about the difference between "fully ordered" and "full
> > barrier" somewhere else, because this looks like it will confuse people.
> > 
> 
> This is confusing me right now. ;-)
> 
> Let's use a simple example for only one primitive, as I understand it,
> if we say a primitive A is "fully ordered", we actually mean:
> 
> 1.	The memory operations preceding(in program order) A can't be
> 	reordered after the memory operations following(in PO) A.
> 
> and
> 
> 2.	The memory operation(s) in A can't be reordered before the
> 	memory operations preceding(in PO) A and after the memory
> 	operations following(in PO) A.
> 
> If we say A is a "full barrier", we actually means:
> 
> 1.	The memory operations preceding(in program order) A can't be
> 	reordered after the memory operations following(in PO) A.
> 
> and
> 
> 2.	The memory ordering guarantee in #1 is visible globally.
> 
> Is that correct? Or "full barrier" is more strong than I understand,
> i.e. there is a third property of "full barrier":
> 
> 3.	The memory operation(s) in A can't be reordered before the
> 	memory operations preceding(in PO) A and after the memory
> 	operations following(in PO) A.
> 
> IOW, is "full barrier" a more strong version of "fully ordered" or not?

There is also the question of whether the barrier forces ordering
of unrelated stores, everything initially zero and all accesses
READ_ONCE() or WRITE_ONCE():

	P0		P1		P2		P3
	X = 1;		Y = 1;		r1 = X;		r3 = Y;
					some_barrier();	some_barrier();
					r2 = Y;		r4 = X;

P2's and P3's ordering could be globally visible without requiring
P0's and P1's independent stores to be ordered, for example, if you
used smp_rmb() for some_barrier().  In contrast, if we used smp_mb()
for barrier, everyone would agree on the order of P0's and P0's stores.

There are actually a fair number of different combinations of
aspects of memory ordering.  We will need to choose wisely.  ;-)

My hope is that the store-ordering gets folded into the globally
visible transitive level.  Especially given that I have not (yet)
seen any algorithms used in production that relied on the ordering of
independent stores.

							Thanx, Paul

> Regards,
> Boqun
> 
> > >  - RELEASE -> ACQUIRE can be upgraded to a full barrier (including
> > >    transitivity) using smp_mb__release_acquire(), either before RELEASE
> > >    or after ACQUIRE (but consistently [*]).
> > 
> > Hmm, but we don't actually need this for RELEASE -> ACQUIRE, afaict. This
> > is just needed for UNLOCK -> LOCK, and is exactly what RCU is currently
> > using (for PPC only).
> > 
> > Stepping back a second, I believe that there are three cases:
> > 
> > 
> >  RELEASE X -> ACQUIRE Y (same CPU)
> >    * Needs a barrier on TSO architectures for full ordering
> > 
> >  UNLOCK X -> LOCK Y (same CPU)
> >    * Needs a barrier on PPC for full ordering
> > 
> >  RELEASE X -> ACQUIRE X (different CPUs)
> >  UNLOCK X -> ACQUIRE X (different CPUs)
> >    * Fully ordered everywhere...
> >    * ... but needs a barrier on PPC to become a full barrier
> > 
> > 
