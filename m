Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xD7Fp30wRzDrHL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 08:03:42 +1000 (AEST)
Date: Thu, 20 Jul 2017 17:03:07 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Santosh Sivaraj <santosh@fossix.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Segher Boessenkool <segher.boessenkool@nl.ibm.com>
Subject: Re: [PATCH] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
Message-ID: <20170720220306.GD13471@gate.crashing.org>
References: <20170720095834.15153-1-santosh@fossix.org>
 <87bmofgsbh.fsf@concordia.ellerman.id.au>
 <1500585459.10674.8.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500585459.10674.8.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 21, 2017 at 07:17:39AM +1000, Benjamin Herrenschmidt wrote:
> > Great patch! Always good to see asm replaced with C.
> 
> Yeah ewll ... when C becomes some kind of weird glorifed asm like
> below, I don't see much of a point ;-)

Yeah.

> > > diff --git a/arch/powerpc/kernel/vdso64/gettime.c b/arch/powerpc/kernel/vdso64/gettime.c
> > > new file mode 100644
> > > index 0000000..01f411f
> > > --- /dev/null
> > > +++ b/arch/powerpc/kernel/vdso64/gettime.c
> > > @@ -0,0 +1,162 @@
> > 
> > ...
> > > +static notrace int gettime_syscall_fallback(clockid_t clk_id,
> > > +					     struct timespec *tp)
> > > +{
> > > +	register clockid_t id asm("r3") = clk_id;
> > > +	register struct timespec *t asm("r4") = tp;
> > > +	register int nr asm("r0") = __NR_clock_gettime;
> > > +	register int ret asm("r3");
> > 
> > I guess this works. I've always been a bit nervous about register
> > variables TBH.
> 
> Does it really work ? That really makes me nervous too, I woudn't do
> this without a strong ack from a toolchain person... Segher ?

Local register variables work perfectly well, but only for one thing:
those variables are guaranteed to be in those registers, _as arguments
to an asm_.

> > > +	asm volatile("sc"
> > > +		     : "=r" (ret)
> > > +		     : "r"(nr), "r"(id), "r"(t)
> > > +		     : "memory");
> > 
> > Not sure we need the memory clobber?
> > 
> > It can clobber more registers than that though.

It needs the memory clobber (if the system call accessess any of "your"
memory).  You need more register clobbers: also for most CR fields,
CTR, etc.

One trick that often works is doing the system call from within an
assembler function that uses the C ABI, since that has almost the same
calling conventions.

Something as simple as

	.globl syscall42
syscall42:
	li 0,42
	sc
	blr

(and yeah handle the CR bit 3 thing somehow)

and declare it as

int syscall42(some_type r3_arg, another_type r4_arg);


Inline asm is good when you want the asm code inlined into the callers,
potentially with arguments optimised etc.  The only overhead making the
syscall a function has is that single blr; the only optimisation you
miss is you could potentially load GPR0 a bit earlier (and you can get
a tiny bit more scheduling flexibility).


Segher
