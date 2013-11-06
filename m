Return-Path: <will.deacon@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id A46912C007B
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Nov 2013 22:01:06 +1100 (EST)
Date: Wed, 6 Nov 2013 11:00:43 +0000
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] arch: Introduce new TSO memory barrier smp_tmb()
Message-ID: <20131106110043.GD21074@mudshark.cambridge.arm.com>
References: <20131103200124.GK19466@laptop.lan>
 <20131103224242.GF3947@linux.vnet.ibm.com>
 <CA+55aFyD_kCkAHQwHCUBrumO-pH6LaZikTNvyWDW_tWsHdqk6Q@mail.gmail.com>
 <20131104105059.GL3947@linux.vnet.ibm.com>
 <20131104112254.GK28601@twins.programming.kicks-ass.net>
 <20131104162732.GN3947@linux.vnet.ibm.com>
 <20131104191127.GW16117@laptop.programming.kicks-ass.net>
 <20131104205344.GW3947@linux.vnet.ibm.com>
 <20131105140548.GD26895@mudshark.cambridge.arm.com>
 <20131105184943.GY16117@laptop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131105184943.GY16117@laptop.programming.kicks-ass.net>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
 Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 05, 2013 at 06:49:43PM +0000, Peter Zijlstra wrote:
> On Tue, Nov 05, 2013 at 02:05:48PM +0000, Will Deacon wrote:
> > > > +
> > > > +#define smp_store_release(p, v)                                              \
> > > > +do {                                                                 \
> > > > +     smp_mb();                                                       \
> > > > +     ACCESS_ONCE(p) = (v);                                           \
> > > > +} while (0)
> > > > +
> > > > +#define smp_load_acquire(p, v)                                               \
> > > > +do {                                                                 \
> > > > +     typeof(p) ___p1 = ACCESS_ONCE(p);                               \
> > > > +     smp_mb();                                                       \
> > > > +     return ___p1;                                                   \
> > > > +} while (0)
> > 
> > What data sizes do these accessors operate on? Assuming that we want
> > single-copy atomicity (with respect to interrupts in the UP case), we
> > probably want a check to stop people passing in things like structs.
> 
> Fair enough; I think we should restrict to native word sizes same as we
> do for atomics.
> 
> Something like so perhaps:
> 
> #ifdef CONFIG_64BIT
> #define __check_native_word(t)	(sizeof(t) == 4 || sizeof(t) == 8)

Ok, if we want to support 32-bit accesses on 64-bit machines, that will
complicate some of your assembly (more below).

> #else
> #define __check_native_word(t)	(sizeof(t) == 4)
> #endif
> 
> #define smp_store_release(p, v) 		\
> do {						\
> 	BUILD_BUG_ON(!__check_native_word(p));	\
> 	smp_mb();				\
> 	ACCESS_ONCE(p) = (v);			\
> } while (0)
> 
> > > > +#define smp_store_release(p, v)                                              \
> > > > +do {                                                                 \
> > > > +     asm volatile ("stlr %w0 [%1]" : : "r" (v), "r" (&p) : "memory");\
> > 
> > Missing comma between the operands. Also, that 'w' output modifier enforces
> > a 32-bit store (same early question about sizes). Finally, it might be more
> > efficient to use "=Q" for the addressing mode, rather than take the address
> > of p manually.
> 
> so something like:
> 
> 	asm volatile ("stlr %0, [%1]" : : "r" (v), "=Q" (p) : "memory");
> 
> ?
> 
> My inline asm foo is horrid and I mostly get by with copy paste from a
> semi similar existing form :/

Almost: you just need to drop the square brackets and make the memory
location an output operand:

	asm volatile("stlr %1, %0" : "=Q" (p) : "r" (v) : "memory");

however, for a 32-bit access, you need to use an output modifier:

	asm volatile("stlr %w1, %0" : "=Q" (p) : "r" (v) : "memory");

so I guess a switch on sizeof(p) is required.

> > Random other question: have you considered how these accessors should behave
> > when presented with __iomem pointers?
> 
> A what? ;-)

Then let's go with Paul's suggestion of mandating __kernel, or the like
(unless we need to worry about __user addresses for things like futexes?).

Will
