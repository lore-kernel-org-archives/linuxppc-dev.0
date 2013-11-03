Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A39232C00C8
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Nov 2013 09:46:01 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sun, 3 Nov 2013 15:45:59 -0700
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D97B6C9003E
 for <linuxppc-dev@ozlabs.org>; Sun,  3 Nov 2013 17:45:54 -0500 (EST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA3Mjt9I66912458
 for <linuxppc-dev@ozlabs.org>; Sun, 3 Nov 2013 22:45:55 GMT
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rA3MjbW1016299
 for <linuxppc-dev@ozlabs.org>; Sun, 3 Nov 2013 15:45:38 -0700
Date: Sun, 3 Nov 2013 14:42:42 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] arch: Introduce new TSO memory barrier smp_tmb()
Message-ID: <20131103224242.GF3947@linux.vnet.ibm.com>
References: <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <20131030112526.GI16117@laptop.programming.kicks-ass.net>
 <20131031064015.GV4126@linux.vnet.ibm.com>
 <20131101145634.GH19466@laptop.lan>
 <20131102173239.GB3947@linux.vnet.ibm.com>
 <20131103144017.GA25118@linux.vnet.ibm.com>
 <20131103151704.GJ19466@laptop.lan>
 <CA+55aFx_kuvR-0dwJtjvnhtha5QBc5XcLZPRH=WKT+hYVAKOrw@mail.gmail.com>
 <20131103200124.GK19466@laptop.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131103200124.GK19466@laptop.lan>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 03, 2013 at 09:01:24PM +0100, Peter Zijlstra wrote:
> On Sun, Nov 03, 2013 at 10:08:14AM -0800, Linus Torvalds wrote:
> > On Sun, Nov 3, 2013 at 7:17 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Sun, Nov 03, 2013 at 06:40:17AM -0800, Paul E. McKenney wrote:
> > >> If there was an smp_tmb(), I would likely use it in rcu_assign_pointer().
> > >
> > > Well, I'm obviously all for introducing this new barrier, for it will
> > > reduce a full mfence on x86 to a compiler barrier. And ppc can use
> > > lwsync as opposed to sync afaict. Not sure ARM can do better.
> > >
> > > ---
> > > Subject: arch: Introduce new TSO memory barrier smp_tmb()
> > 
> > This is specialized enough that I would *really* like the name to be
> > more descriptive. Compare to the special "smp_read_barrier_depends()"
> > maco: it's unusual, and it has very specific semantics, so it gets a
> > long and descriptive name.
> > 
> > Memory ordering is subtle enough without then using names that are
> > subtle in themselves. mb/rmb/wmb are conceptually pretty simple
> > operations, and very basic when talking about memory ordering.
> > "acquire" and "release" are less simple, but have descriptive names
> > and have very specific uses in locking.
> > 
> > In contrast "smp_tmb()" is a *horrible* name, because TSO is a
> > description of the memory ordering, not of a particular barrier. It's
> > also not even clear that you can have a "tso barrier", since the
> > ordering (like acquire/release) presumably is really about one
> > particular *store*, not about some kind of barrier between different
> > operations.
> > 
> > So please describe exactly what the semantics that barrier has, and
> > then name the barrier that way.
> > 
> > I assume that in this particular case, the semantics RCU wants is
> > "write barrier, and no preceding reads can move past this point".

Its semantics order prior reads against subsequent reads, prior reads
against subsequent writes, and prior writes against subsequent writes.
It does -not- order prior writes against subsequent reads.

> > Calling that "smp_tmb()" is f*cking insane, imnsho.
> 
> Fair enough; from what I could gather the proposed semantics are
> RELEASE+WMB, such that neither reads not writes can cross over, writes
> can't cross back, but reads could.
> 
> Since both RELEASE and WMB are trivial under TSO the entire thing
> collapses.

And here are some candidate names, with no attempt to sort sanity from
insanity:

smp_storebuffer_mb() -- A barrier that enforces those orderings
	that do not invalidate the hardware store-buffer optimization.

smp_not_w_r_mb() -- A barrier that orders everything except prior
	writes against subsequent reads.

smp_acqrel_mb() -- A barrier that combines C/C++ acquire and release
	semantics.  (C/C++ "acquire" orders a specific load against
	subsequent loads and stores, while C/C++ "release" orders
	a specific store against prior loads and stores.)

Others?

> Now I'm currently completely confused as to what C/C++ wrecks vs actual
> proper memory order issues; let alone fully comprehend the case that
> started all this.

Each can result in similar wreckage.  In either case, it is about failing
to guarantee needed orderings.

							Thanx, Paul
