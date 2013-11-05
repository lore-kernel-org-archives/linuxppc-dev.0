Return-Path: <will.deacon@arm.com>
Received: from cam-admin0.cambridge.arm.com (unknown [217.140.96.50])
 by ozlabs.org (Postfix) with ESMTP id 158CC2C025E
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Nov 2013 01:06:32 +1100 (EST)
Date: Tue, 5 Nov 2013 14:05:48 +0000
From: Will Deacon <will.deacon@arm.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC] arch: Introduce new TSO memory barrier smp_tmb()
Message-ID: <20131105140548.GD26895@mudshark.cambridge.arm.com>
References: <20131103151704.GJ19466@laptop.lan>
 <CA+55aFx_kuvR-0dwJtjvnhtha5QBc5XcLZPRH=WKT+hYVAKOrw@mail.gmail.com>
 <20131103200124.GK19466@laptop.lan>
 <20131103224242.GF3947@linux.vnet.ibm.com>
 <CA+55aFyD_kCkAHQwHCUBrumO-pH6LaZikTNvyWDW_tWsHdqk6Q@mail.gmail.com>
 <20131104105059.GL3947@linux.vnet.ibm.com>
 <20131104112254.GK28601@twins.programming.kicks-ass.net>
 <20131104162732.GN3947@linux.vnet.ibm.com>
 <20131104191127.GW16117@laptop.programming.kicks-ass.net>
 <20131104205344.GW3947@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131104205344.GW3947@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Peter Zijlstra <peterz@infradead.org>,
 "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
 Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
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

On Mon, Nov 04, 2013 at 08:53:44PM +0000, Paul E. McKenney wrote:
> On Mon, Nov 04, 2013 at 08:11:27PM +0100, Peter Zijlstra wrote:
> Some comments below.  I believe that opcodes need to be fixed for IA64.
> I am unsure of the ifdefs and opcodes for arm64, but the ARM folks should
> be able to tell us.

[...]

> > diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
> > index 60f15e274e6d..a804093d6891 100644
> > --- a/arch/arm/include/asm/barrier.h
> > +++ b/arch/arm/include/asm/barrier.h
> > @@ -53,10 +53,36 @@
> >  #define smp_mb()     barrier()
> >  #define smp_rmb()    barrier()
> >  #define smp_wmb()    barrier()
> > +
> > +#define smp_store_release(p, v)                                              \
> > +do {                                                                 \
> > +     smp_mb();                                                       \
> > +     ACCESS_ONCE(p) = (v);                                           \
> > +} while (0)
> > +
> > +#define smp_load_acquire(p, v)                                               \
> > +do {                                                                 \
> > +     typeof(p) ___p1 = ACCESS_ONCE(p);                               \
> > +     smp_mb();                                                       \
> > +     return ___p1;                                                   \
> > +} while (0)

What data sizes do these accessors operate on? Assuming that we want
single-copy atomicity (with respect to interrupts in the UP case), we
probably want a check to stop people passing in things like structs.

> >  #else
> >  #define smp_mb()     dmb(ish)
> >  #define smp_rmb()    smp_mb()
> >  #define smp_wmb()    dmb(ishst)
> > +
> 
> Seems like there should be some sort of #ifdef condition to distinguish
> between these.  My guess is something like:
> 
> #if __LINUX_ARM_ARCH__ > 7
> 
> But I must defer to the ARM guys.  For all I know, they might prefer
> arch/arm to stick with smp_mb() and have arch/arm64 do the ldar and stlr.

Yes. For arch/arm/, I'd rather we stick with the smp_mb() for the time
being. We don't (yet) have any 32-bit ARMv8 support, and the efforts towards
a single zImage could do without minor variations like this, not to mention
the usual backlash I get whenever introducing something that needs a
relatively recent binutils.

> > +#define smp_store_release(p, v)                                              \
> > +do {                                                                 \
> > +     asm volatile ("stlr %w0 [%1]" : : "r" (v), "r" (&p) : "memory");\
> > +} while (0)
> > +
> > +#define smp_load_acquire(p)                                          \
> > +do {                                                                 \
> > +     typeof(p) ___p1;                                                \
> > +     asm volatile ("ldar %w0, [%1]"                                  \
> > +                     : "=r" (___p1) : "r" (&p) : "memory");          \
> > +     return ___p1;                                                   \
> > +} while (0)
> >  #endif
> >
> >  #define read_barrier_depends()               do { } while(0)
> > diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> > index d4a63338a53c..0da2d4ebb9a8 100644
> > --- a/arch/arm64/include/asm/barrier.h
> > +++ b/arch/arm64/include/asm/barrier.h
> > @@ -35,10 +35,38 @@
> >  #define smp_mb()     barrier()
> >  #define smp_rmb()    barrier()
> >  #define smp_wmb()    barrier()
> > +
> > +#define smp_store_release(p, v)                                              \
> > +do {                                                                 \
> > +     smp_mb();                                                       \
> > +     ACCESS_ONCE(p) = (v);                                           \
> > +} while (0)
> > +
> > +#define smp_load_acquire(p, v)                                               \
> > +do {                                                                 \
> > +     typeof(p) ___p1 = ACCESS_ONCE(p);                               \
> > +     smp_mb();                                                       \
> > +     return ___p1;                                                   \
> > +} while (0)
> > +
> >  #else
> > +
> >  #define smp_mb()     asm volatile("dmb ish" : : : "memory")
> >  #define smp_rmb()    asm volatile("dmb ishld" : : : "memory")
> >  #define smp_wmb()    asm volatile("dmb ishst" : : : "memory")
> > +
> > +#define smp_store_release(p, v)                                              \
> > +do {                                                                 \
> > +     asm volatile ("stlr %w0 [%1]" : : "r" (v), "r" (&p) : "memory");\

Missing comma between the operands. Also, that 'w' output modifier enforces
a 32-bit store (same early question about sizes). Finally, it might be more
efficient to use "=Q" for the addressing mode, rather than take the address
of p manually.

> > +} while (0)
> > +
> > +#define smp_load_acquire(p)                                          \
> > +do {                                                                 \
> > +     typeof(p) ___p1;                                                \
> > +     asm volatile ("ldar %w0, [%1]"                                  \
> > +                     : "=r" (___p1) : "r" (&p) : "memory");          \
> > +     return ___p1;                                                   \

Similar comments here wrt Q constraint.

Random other question: have you considered how these accessors should behave
when presented with __iomem pointers?

Will
