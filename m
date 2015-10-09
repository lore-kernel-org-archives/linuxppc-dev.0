Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A514E1A038C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 19:31:45 +1100 (AEDT)
Date: Fri, 9 Oct 2015 10:31:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151009083138.GU3816@twins.programming.kicks-ass.net>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008214439.GE3910@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151008214439.GE3910@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 08, 2015 at 02:44:39PM -0700, Paul E. McKenney wrote:
> On Thu, Oct 08, 2015 at 01:16:38PM +0200, Peter Zijlstra wrote:
> > On Thu, Oct 08, 2015 at 02:50:36PM +1100, Michael Ellerman wrote:
> > > On Wed, 2015-10-07 at 08:25 -0700, Paul E. McKenney wrote:
> > 
> > > > Currently, we do need smp_mb__after_unlock_lock() to be after the
> > > > acquisition on PPC -- putting it between the unlock and the lock
> > > > of course doesn't cut it for the cross-thread unlock/lock case.
> > 
> > This ^, that makes me think I don't understand
> > smp_mb__after_unlock_lock.
> > 
> > How is:
> > 
> > 	UNLOCK x
> > 	smp_mb__after_unlock_lock()
> > 	LOCK y
> > 
> > a problem? That's still a full barrier.
> 
> The problem is that I need smp_mb__after_unlock_lock() to give me
> transitivity even if the UNLOCK happened on one CPU and the LOCK
> on another.  For that to work, the smp_mb__after_unlock_lock() needs
> to be either immediately after the acquire (the current choice) or
> immediately before the release (which would also work from a purely
> technical viewpoint, but I much prefer the current choice).
> 
> Or am I missing your point?

So lots of little confusions added up to complete fail :-{

Mostly I think it was the UNLOCK x + LOCK x are fully ordered (where I
forgot: but not against uninvolved CPUs) and RELEASE/ACQUIRE are
transitive (where I forgot: RELEASE/ACQUIRE _chains_ are transitive, but
again not against uninvolved CPUs).

Which leads me to think I would like to suggest alternative rules for
RELEASE/ACQUIRE (to replace those Will suggested; as I think those are
partly responsible for my confusion).

 - RELEASE -> ACQUIRE is fully ordered (but not a full barrier) when
   they operate on the same variable and the ACQUIRE reads from the
   RELEASE. Notable, RELEASE/ACQUIRE are RCpc and lack transitivity.

 - RELEASE -> ACQUIRE can be upgraded to a full barrier (including
   transitivity) using smp_mb__release_acquire(), either before RELEASE
   or after ACQUIRE (but consistently [*]).

 - RELEASE -> ACQUIRE _chains_ (on shared variables) preserve causality,
   (because each link is fully ordered) but are not transitive.

And I think that in the past few weeks we've been using transitive
ambiguously, the definition we have in Documentation/memory-barriers.txt
is a _strong_ transitivity, where we can make guarantees about CPUs not
directly involved.

What we have here (due to RCpc) is a weak form of transitivity, which,
while it preserves the natural concept of causality, does not extend to
other CPUs.

So we could go around and call them 'strong' and 'weak' transitivity,
but I suspect its easier for everyone involved if we come up with
separate terms (less room for error if we accidentally omit the
'strong/weak' qualifier).


[*] Do we want to take that choice away and go for:
smp_mb__after_release_acquire() ?
