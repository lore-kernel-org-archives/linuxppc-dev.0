Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Dynamically allocate pacas
In-reply-to: <c22a0fd3d76675813ce5f1596d80614aee80ed24.1264568410.git.michael@ellerman.id.au>
References: <c22a0fd3d76675813ce5f1596d80614aee80ed24.1264568410.git.michael@ellerman.id.au>
Date: Wed, 27 Jan 2010 17:29:36 +1030
Message-ID: <4389.1264575576@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On 64-bit kernels we currently have a 512 byte struct paca_struct for
> each cpu (usually just called "the paca"). Currently they are statically
> allocated, which means a kernel built for a large number of cpus will
> waste a lot of space if it's booted on a machine with few cpus.
> 
> We can avoid that by only allocating the number of pacas we need at
> boot. However this is complicated by the fact that we need to access
> the paca before we know how many cpus there are in the system.
> 
> The solution is to dynamically allocate enough space for NR_CPUS pacas,
> but then later in boot when we know how many cpus we have, we free any
> unused pacas.
> 
> Lightly booted on Legacy iSeries & pSeries LPAR.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

<snip>

> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -493,6 +493,8 @@ void __init smp_setup_cpu_maps(void)
>  	 * here will have to be reworked
>  	 */
>  	cpu_init_thread_core_maps(nthreads);
> +
> +	free_unused_pacas();

This is still barfing for me on 32bit.

Putting an #include <asm/paca.h> at the top of setup-common.c fixes it.

Mikey
