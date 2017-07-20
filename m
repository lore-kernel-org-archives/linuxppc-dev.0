Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCvbl3T4qzDrF4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 23:18:27 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Santosh Sivaraj <santosh@fossix.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
In-Reply-To: <20170720095834.15153-1-santosh@fossix.org>
References: <20170720095834.15153-1-santosh@fossix.org>
Date: Thu, 20 Jul 2017 23:18:26 +1000
Message-ID: <87bmofgsbh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Santosh Sivaraj <santosh@fossix.org> writes:

> Current vDSO64 implementation does not have support for coarse
> clocks (CLOCK_MONOTONIC_COARSE, CLOCK_REALTIME_COARSE), for which it falls
> back to system call. Below is a benchmark of the difference in execution
> time with and without vDSO support.

Hi Santosh,

Great patch! Always good to see asm replaced with C.

> diff --git a/arch/powerpc/kernel/vdso64/gettime.c b/arch/powerpc/kernel/vdso64/gettime.c
> new file mode 100644
> index 0000000..01f411f
> --- /dev/null
> +++ b/arch/powerpc/kernel/vdso64/gettime.c
> @@ -0,0 +1,162 @@
...
> +static notrace int gettime_syscall_fallback(clockid_t clk_id,
> +					     struct timespec *tp)
> +{
> +	register clockid_t id asm("r3") = clk_id;
> +	register struct timespec *t asm("r4") = tp;
> +	register int nr asm("r0") = __NR_clock_gettime;
> +	register int ret asm("r3");

I guess this works. I've always been a bit nervous about register
variables TBH.

> +	asm volatile("sc"
> +		     : "=r" (ret)
> +		     : "r"(nr), "r"(id), "r"(t)
> +		     : "memory");

Not sure we need the memory clobber?

It can clobber more registers than that though.

See: Documentation/powerpc/syscall64-abi.txt

> diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
> index 3820213..1258009 100644
> --- a/arch/powerpc/kernel/vdso64/gettimeofday.S
> +++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
> @@ -51,85 +53,21 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
...
> +	stwu	r1,-112(r1)
> +  .cfi_register lr,r6
> +	std	r6,24(r1)
> +	bl	V_LOCAL_FUNC(kernel_clock_gettime)
>  	crclr	cr0*4+so

Clearing CR0[SO] says that the syscall always succeeded.

What happens if you call this with a completely bogus clock id?

I think the solution is probably to do the syscall fallback in asm, and
everything else in C.

cheers
