Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xD6F350HzzDrHB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 07:17:59 +1000 (AEST)
Message-ID: <1500585459.10674.8.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Santosh Sivaraj
 <santosh@fossix.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, Segher Boessenkool
 <segher.boessenkool@nl.ibm.com>
Date: Fri, 21 Jul 2017 07:17:39 +1000
In-Reply-To: <87bmofgsbh.fsf@concordia.ellerman.id.au>
References: <20170720095834.15153-1-santosh@fossix.org>
 <87bmofgsbh.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-07-20 at 23:18 +1000, Michael Ellerman wrote:
> Santosh Sivaraj <santosh@fossix.org> writes:
> 
> > Current vDSO64 implementation does not have support for coarse
> > clocks (CLOCK_MONOTONIC_COARSE, CLOCK_REALTIME_COARSE), for which it falls
> > back to system call. Below is a benchmark of the difference in execution
> > time with and without vDSO support.
> 
> Hi Santosh,
> 
> Great patch! Always good to see asm replaced with C.

Yeah ewll ... when C becomes some kind of weird glorifed asm like
below, I don't see much of a point ;-)

> > diff --git a/arch/powerpc/kernel/vdso64/gettime.c b/arch/powerpc/kernel/vdso64/gettime.c
> > new file mode 100644
> > index 0000000..01f411f
> > --- /dev/null
> > +++ b/arch/powerpc/kernel/vdso64/gettime.c
> > @@ -0,0 +1,162 @@
> 
> ...
> > +static notrace int gettime_syscall_fallback(clockid_t clk_id,
> > +					     struct timespec *tp)
> > +{
> > +	register clockid_t id asm("r3") = clk_id;
> > +	register struct timespec *t asm("r4") = tp;
> > +	register int nr asm("r0") = __NR_clock_gettime;
> > +	register int ret asm("r3");
> 
> I guess this works. I've always been a bit nervous about register
> variables TBH.

Does it really work ? That really makes me nervous too, I woudn't do
this without a strong ack from a toolchain person... Segher ?

> > +	asm volatile("sc"
> > +		     : "=r" (ret)
> > +		     : "r"(nr), "r"(id), "r"(t)
> > +		     : "memory");
> 
> Not sure we need the memory clobber?
> 
> It can clobber more registers than that though.
> 
> See: Documentation/powerpc/syscall64-abi.txt
> 
> > diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
> > index 3820213..1258009 100644
> > --- a/arch/powerpc/kernel/vdso64/gettimeofday.S
> > +++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
> > @@ -51,85 +53,21 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
> 
> ...
> > +	stwu	r1,-112(r1)
> > +  .cfi_register lr,r6
> > +	std	r6,24(r1)
> > +	bl	V_LOCAL_FUNC(kernel_clock_gettime)
> >  	crclr	cr0*4+so
> 
> Clearing CR0[SO] says that the syscall always succeeded.
> 
> What happens if you call this with a completely bogus clock id?
> 
> I think the solution is probably to do the syscall fallback in asm, and
> everything else in C.
> 
> cheers
