Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E2AF0DDF4C
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 12:06:02 +1000 (EST)
Subject: Re: [PATCH] kill useless SMT code in prom_hold_cpus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20080708223631.GP9594@localdomain>
References: <20080708223631.GP9594@localdomain>
Content-Type: text/plain
Date: Tue, 15 Jul 2008 12:05:55 +1000
Message-Id: <1216087555.7740.42.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-08 at 17:36 -0500, Nathan Lynch wrote:
> I think this code that counts SMT threads and compares against NR_CPUS
> is an artifact of pre-powerpc-merge ppc64.  We care about starting
> only primary threads in the OF client code.
> 
> Signed-off-by: Nathan Lynch <ntl@pobox.com>

That looks good. I'm not merging it right now because I want to dbl
check that it's allright on all SMT machines. IE. We compare reg[0]
against _prom->cpu now instead of interrupt_server[0] and I thus
want to ensure it's the same everywhere.

Cheers,
Ben.

>  arch/powerpc/kernel/prom_init.c |   39 +++------------------------------------
>  1 files changed, 3 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 1ea8c8d..b1dd86c 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -205,8 +205,6 @@ static int __initdata mem_reserve_cnt;
>  static cell_t __initdata regbuf[1024];
>  
> 
> -#define MAX_CPU_THREADS 2
> -
>  /*
>   * Error results ... some OF calls will return "-1" on error, some
>   * will return 0, some will return either. To simplify, here are
> @@ -1332,10 +1330,6 @@ static void __init prom_hold_cpus(void)
>  	unsigned int reg;
>  	phandle node;
>  	char type[64];
> -	int cpuid = 0;
> -	unsigned int interrupt_server[MAX_CPU_THREADS];
> -	unsigned int cpu_threads, hw_cpu_num;
> -	int propsize;
>  	struct prom_t *_prom = &RELOC(prom);
>  	unsigned long *spinloop
>  		= (void *) LOW_ADDR(__secondary_hold_spinloop);
> @@ -1379,7 +1373,6 @@ static void __init prom_hold_cpus(void)
>  		reg = -1;
>  		prom_getprop(node, "reg", &reg, sizeof(reg));
>  
> -		prom_debug("\ncpuid        = 0x%x\n", cpuid);
>  		prom_debug("cpu hw idx   = 0x%x\n", reg);
>  
>  		/* Init the acknowledge var which will be reset by
> @@ -1388,28 +1381,9 @@ static void __init prom_hold_cpus(void)
>  		 */
>  		*acknowledge = (unsigned long)-1;
>  
> -		propsize = prom_getprop(node, "ibm,ppc-interrupt-server#s",
> -					&interrupt_server,
> -					sizeof(interrupt_server));
> -		if (propsize < 0) {
> -			/* no property.  old hardware has no SMT */
> -			cpu_threads = 1;
> -			interrupt_server[0] = reg; /* fake it with phys id */
> -		} else {
> -			/* We have a threaded processor */
> -			cpu_threads = propsize / sizeof(u32);
> -			if (cpu_threads > MAX_CPU_THREADS) {
> -				prom_printf("SMT: too many threads!\n"
> -					    "SMT: found %x, max is %x\n",
> -					    cpu_threads, MAX_CPU_THREADS);
> -				cpu_threads = 1; /* ToDo: panic? */
> -			}
> -		}
> -
> -		hw_cpu_num = interrupt_server[0];
> -		if (hw_cpu_num != _prom->cpu) {
> +		if (reg != _prom->cpu) {
>  			/* Primary Thread of non-boot cpu */
> -			prom_printf("%x : starting cpu hw idx %x... ", cpuid, reg);
> +			prom_printf("starting cpu hw idx %x... ", reg);
>  			call_prom("start-cpu", 3, 0, node,
>  				  secondary_hold, reg);
>  
> @@ -1424,17 +1398,10 @@ static void __init prom_hold_cpus(void)
>  		}
>  #ifdef CONFIG_SMP
>  		else
> -			prom_printf("%x : boot cpu     %x\n", cpuid, reg);
> +			prom_printf("boot cpu hw idx %x\n", reg);
>  #endif /* CONFIG_SMP */
> -
> -		/* Reserve cpu #s for secondary threads.   They start later. */
> -		cpuid += cpu_threads;
>  	}
>  
> -	if (cpuid > NR_CPUS)
> -		prom_printf("WARNING: maximum CPUs (" __stringify(NR_CPUS)
> -			    ") exceeded: ignoring extras\n");
> -
>  	prom_debug("prom_hold_cpus: end...\n");
>  }
>  
