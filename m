Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 424F42C00A0
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Nov 2013 07:01:47 +1100 (EST)
Date: Sun, 3 Nov 2013 21:01:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] arch: Introduce new TSO memory barrier smp_tmb()
Message-ID: <20131103200124.GK19466@laptop.lan>
References: <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <20131030112526.GI16117@laptop.programming.kicks-ass.net>
 <20131031064015.GV4126@linux.vnet.ibm.com>
 <20131101145634.GH19466@laptop.lan>
 <20131102173239.GB3947@linux.vnet.ibm.com>
 <20131103144017.GA25118@linux.vnet.ibm.com>
 <20131103151704.GJ19466@laptop.lan>
 <CA+55aFx_kuvR-0dwJtjvnhtha5QBc5XcLZPRH=WKT+hYVAKOrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFx_kuvR-0dwJtjvnhtha5QBc5XcLZPRH=WKT+hYVAKOrw@mail.gmail.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 03, 2013 at 10:08:14AM -0800, Linus Torvalds wrote:
> On Sun, Nov 3, 2013 at 7:17 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Sun, Nov 03, 2013 at 06:40:17AM -0800, Paul E. McKenney wrote:
> >> If there was an smp_tmb(), I would likely use it in rcu_assign_pointer().
> >
> > Well, I'm obviously all for introducing this new barrier, for it will
> > reduce a full mfence on x86 to a compiler barrier. And ppc can use
> > lwsync as opposed to sync afaict. Not sure ARM can do better.
> >
> > ---
> > Subject: arch: Introduce new TSO memory barrier smp_tmb()
> 
> This is specialized enough that I would *really* like the name to be
> more descriptive. Compare to the special "smp_read_barrier_depends()"
> maco: it's unusual, and it has very specific semantics, so it gets a
> long and descriptive name.
> 
> Memory ordering is subtle enough without then using names that are
> subtle in themselves. mb/rmb/wmb are conceptually pretty simple
> operations, and very basic when talking about memory ordering.
> "acquire" and "release" are less simple, but have descriptive names
> and have very specific uses in locking.
> 
> In contrast "smp_tmb()" is a *horrible* name, because TSO is a
> description of the memory ordering, not of a particular barrier. It's
> also not even clear that you can have a "tso barrier", since the
> ordering (like acquire/release) presumably is really about one
> particular *store*, not about some kind of barrier between different
> operations.
> 
> So please describe exactly what the semantics that barrier has, and
> then name the barrier that way.
> 
> I assume that in this particular case, the semantics RCU wants is
> "write barrier, and no preceding reads can move past this point".
> 
> Calling that "smp_tmb()" is f*cking insane, imnsho.

Fair enough; from what I could gather the proposed semantics are
RELEASE+WMB, such that neither reads not writes can cross over, writes
can't cross back, but reads could.

Since both RELEASE and WMB are trivial under TSO the entire thing
collapses.

Now I'm currently completely confused as to what C/C++ wrecks vs actual
proper memory order issues; let alone fully comprehend the case that
started all this.
