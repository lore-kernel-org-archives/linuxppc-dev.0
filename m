Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2568A2C009A
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2012 18:45:49 +1000 (EST)
Message-ID: <1347439541.2603.100.camel@pasglop>
Subject: Re: [PATCH] powerpc: Add an xmon command to dump one or all pacas
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 12 Sep 2012 18:45:41 +1000
In-Reply-To: <1347436360-29095-1-git-send-email-michael@ellerman.id.au>
References: <1347436360-29095-1-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-09-12 at 17:52 +1000, Michael Ellerman wrote:
> This was originally motivated by a desire to see the mapping between
> logical and hardware cpu numbers.
> 
> But it seemed that it made more sense to just add a command to dump
> (most of) the paca.
> 
> With no arguments "dp" will dump the paca for all possible cpus. If
> there are no possible cpus, like early in boot, it will tell you that.

I'd rather "dp" dump the paca for the current active CPU in xmon.
Shouldn't be hard to make a "dpa" that dumps them all too.

(You can do inchar to check the next char and if not 'a' you can put it
back in termch).

Cheers,
Ben.

> It also takes an argument, eg. "dp 3" which is the logical cpu number
> in hex. This form does not check if the cpu is possible, but displays
> the paca regardless, as well as the cpu's state in the possible, present
> and online masks.
> 
> Sample output, number in brackets is the offset into the struct:
> 
> 2:mon> dp 3
> paca for cpu 0x3 @ c00000000ff20a80:
>  possible         = yes
>  present          = yes
>  online           = yes

A bit of bike shed painting but ... the above isn't strictly PACA
fields... Handy to have but should it be part of the same command ?

Cheers,
Ben.

>  lock_token       = 0x8000            	(0x8)
>  paca_index       = 0x3               	(0xa)
>  kernel_toc       = 0xc00000000144f990	(0x10)
>  kernelbase       = 0xc000000000000000	(0x18)
>  kernel_msr       = 0xb000000000001032	(0x20)
>  stab_real        = 0x0               	(0x28)
>  stab_addr        = 0x0               	(0x30)
>  emergency_sp     = 0xc00000003ffe4000	(0x38)
>  data_offset      = 0xa40000          	(0x40)
>  hw_cpu_id        = 0x9               	(0x50)
>  cpu_start        = 0x1               	(0x52)
>  kexec_state      = 0x0               	(0x53)
>  __current        = 0xc00000007e568680	(0x218)
>  kstack           = 0xc00000007e5a3e30	(0x220)
>  stab_rr          = 0x1a              	(0x228)
>  saved_r1         = 0xc00000007e7cb450	(0x230)
>  trap_save        = 0x0               	(0x240)
>  soft_enabled     = 0x0               	(0x242)
>  irq_happened     = 0x0               	(0x243)
>  io_sync          = 0x0               	(0x244)
>  irq_work_pending = 0x0               	(0x245)
>  nap_state_lost   = 0x0               	(0x246)
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/xmon/xmon.c |   83 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index eab3492..f090c46 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -202,6 +202,7 @@ Commands:\n\
>    df	dump float values\n\
>    dd	dump double values\n\
>    dl    dump the kernel log buffer\n\
> +  dp #  dump paca for cpu # (or all)\n\
>    dr	dump stream of raw bytes\n\
>    e	print exception information\n\
>    f	flush cache\n\
> @@ -2008,6 +2009,82 @@ static void xmon_rawdump (unsigned long adrs, long ndump)
>  	printf("\n");
>  }
>  
> +static void dump_one_paca(int cpu)
> +{
> +	struct paca_struct *p;
> +
> +	if (setjmp(bus_error_jmp) != 0) {
> +		printf("*** Error dumping paca for cpu 0x%x!\n", cpu);
> +		return;
> +	}
> +
> +	catch_memory_errors = 1;
> +	sync();
> +
> +	p = &paca[cpu];
> +
> +	printf("paca for cpu 0x%x @ %p:\n", cpu, p);
> +
> +	printf(" %-*s = %s\n", 16, "possible", cpu_possible(cpu) ? "yes" : "no");
> +	printf(" %-*s = %s\n", 16, "present", cpu_present(cpu) ? "yes" : "no");
> +	printf(" %-*s = %s\n", 16, "online", cpu_online(cpu) ? "yes" : "no");
> +
> +#define DUMP(name, format) \
> +	printf(" %-*s = %#-*"format"\t(0x%lx)\n", 16, #name, 18, p->name, \
> +		(u64)((void *)&(p->name) - (void *)p));
> +
> +	DUMP(lock_token, "x");
> +	DUMP(paca_index, "x");
> +	DUMP(kernel_toc, "lx");
> +	DUMP(kernelbase, "lx");
> +	DUMP(kernel_msr, "lx");
> +#ifdef CONFIG_PPC_STD_MMU_64
> +	DUMP(stab_real, "lx");
> +	DUMP(stab_addr, "lx");
> +#endif
> +	DUMP(emergency_sp, "p");
> +	DUMP(data_offset, "lx");
> +	DUMP(hw_cpu_id, "x");
> +	DUMP(cpu_start, "x");
> +	DUMP(kexec_state, "x");
> +	DUMP(__current, "p");
> +	DUMP(kstack, "lx");
> +	DUMP(stab_rr, "lx");
> +	DUMP(saved_r1, "lx");
> +	DUMP(trap_save, "x");
> +	DUMP(soft_enabled, "x");
> +	DUMP(irq_happened, "x");
> +	DUMP(io_sync, "x");
> +	DUMP(irq_work_pending, "x");
> +	DUMP(nap_state_lost, "x");
> +
> +#undef DUMP
> +
> +	catch_memory_errors = 0;
> +	sync();
> +}
> +
> +static void dump_pacas(void)
> +{
> +	unsigned long num = ULONG_MAX;
> +	int cpu;
> +
> +	scanhex(&num);
> +	if (num != ULONG_MAX) {
> +		/* NB we allow showing a non-possible paca here */
> +		dump_one_paca(num);
> +		return;
> +	}
> +
> +	if (num_possible_cpus() == 0) {
> +		printf("No possible cpus, use 'dp #' to dump individual cpus\n");
> +		return;
> +	}
> +
> +	for_each_possible_cpu(cpu)
> +		dump_one_paca(cpu);
> +}
> +
>  #define isxdigit(c)	(('0' <= (c) && (c) <= '9') \
>  			 || ('a' <= (c) && (c) <= 'f') \
>  			 || ('A' <= (c) && (c) <= 'F'))
> @@ -2017,6 +2094,12 @@ dump(void)
>  	int c;
>  
>  	c = inchar();
> +
> +	if (c == 'p') {
> +		dump_pacas();
> +		return;
> +	}
> +
>  	if ((isxdigit(c) && c != 'f' && c != 'd') || c == '\n')
>  		termch = c;
>  	scanhex((void *)&adrs);
