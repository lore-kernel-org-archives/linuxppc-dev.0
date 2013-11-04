Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 743262C00F9
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Nov 2013 04:05:49 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 4 Nov 2013 10:05:47 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1B0B219D8186
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Nov 2013 10:01:42 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA4H1jPe268242
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Nov 2013 10:01:45 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rA4H4Z6H014796
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Nov 2013 10:04:37 -0700
Date: Mon, 4 Nov 2013 08:34:21 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC] arch: Introduce new TSO memory barrier smp_tmb()
Message-ID: <20131104163421.GO3947@linux.vnet.ibm.com>
References: <20131031064015.GV4126@linux.vnet.ibm.com>
 <20131101145634.GH19466@laptop.lan>
 <20131102173239.GB3947@linux.vnet.ibm.com>
 <20131103144017.GA25118@linux.vnet.ibm.com>
 <20131103151704.GJ19466@laptop.lan>
 <CA+55aFx_kuvR-0dwJtjvnhtha5QBc5XcLZPRH=WKT+hYVAKOrw@mail.gmail.com>
 <20131103200124.GK19466@laptop.lan>
 <20131103224242.GF3947@linux.vnet.ibm.com>
 <CA+55aFyD_kCkAHQwHCUBrumO-pH6LaZikTNvyWDW_tWsHdqk6Q@mail.gmail.com>
 <20131104110553.GA8595@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131104110553.GA8595@mudshark.cambridge.arm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>, Frederic Weisbecker <fweisbec@gmail.com>,
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

On Mon, Nov 04, 2013 at 11:05:53AM +0000, Will Deacon wrote:
> On Sun, Nov 03, 2013 at 11:34:00PM +0000, Linus Torvalds wrote:
> > So it would *kind* of act like a "smp_wmb() + smp_rmb()", but the
> > problem is that a "smp_rmb()" doesn't really "attach" to the preceding
> > write.
> 
> Agreed.
> 
> > This is analogous to a "acquire" operation: you cannot make an
> > "acquire" barrier, because it's not a barrier *between* two ops, it's
> > associated with one particular op.
> > 
> > So what I *think* you actually really really want is a "store with
> > release consistency, followed by a write barrier".
> 
> How does that order reads against reads? (Paul mentioned this as a
> requirement). I not clear about the use case for this, so perhaps there is a
> dependency that I'm not aware of.

An smp_store_with_release_semantics() orders against prior reads -and-
writes.  It maps to barrier() for x86, stlr for ARM, and lwsync for
PowerPC, as called out in my prototype definitions.

> > In TSO, afaik all stores have release consistency, and all writes are
> > ordered, which is why this is a no-op in TSO. And x86 also has that
> > "all stores have release consistency, and all writes are ordered"
> > model, even if TSO doesn't really describe the x86 model.
> > 
> > But on ARM64, for example, I think you'd really want the store itself
> > to be done with "stlr" (store with release), and then follow up with a
> > "dsb st" after that.
> 
> So a dsb is pretty heavyweight here (it prevents execution of *any* further
> instructions until all preceeding stores have completed, as well as
> ensuring completion of any ongoing cache flushes). In conjunction with the
> store-release, that's going to hold everything up until the store-release
> (and therefore any preceeding memory accesses) have completed. Granted, I
> think that gives Paul his read/read ordering, but it's a lot heavier than
> what's required.

I do not believe that we need the trailing "dsb st".

> > And notice how that requires you to mark the store itself. There is no
> > actual barrier *after* the store that does the optimized model.
> > 
> > Of course, it's entirely possible that it's not worth worrying about
> > this on ARM64, and that just doing it as a "normal store followed by a
> > full memory barrier" is good enough. But at least in *theory* a
> > microarchitecture might make it much cheaper to do a "store with
> > release consistency" followed by "write barrier".
> 
> I agree with the sentiment but, given that this stuff is so heavily
> microarchitecture-dependent (and not simple to probe), a simple dmb ish
> might be the best option after all. That's especially true if the
> microarchitecture decided to ignore the barrier options and treat everything
> as `all accesses, full system' in order to keep the hardware design simple.

I believe that we can do quite a bit better with current hardware
instructions (in the case of ARM, for a recent definition of "current")
and also simplify the memory ordering quite a bit.

								Thanx, Paul
