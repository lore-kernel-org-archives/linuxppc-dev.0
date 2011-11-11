Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 44F741007D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 15:23:07 +1100 (EST)
Message-ID: <1320985376.21206.39.camel@pasglop>
Subject: Re: [PATCH 2/7] powerpc/85xx: add HOTPLUG_CPU support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Date: Fri, 11 Nov 2011 15:22:56 +1100
In-Reply-To: <1320409889-14408-1-git-send-email-chenhui.zhao@freescale.com>
References: <1320409889-14408-1-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-11-04 at 20:31 +0800, Zhao Chenhui wrote:

>  #ifdef CONFIG_SMP
>  /* When we get here, r24 needs to hold the CPU # */
>  	.globl __secondary_start
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 7bf2187..12a54f0 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -381,8 +381,14 @@ void generic_cpu_die(unsigned int cpu)
>  
>  	for (i = 0; i < 100; i++) {
>  		smp_rmb();
> -		if (per_cpu(cpu_state, cpu) == CPU_DEAD)
> +		if (per_cpu(cpu_state, cpu) == CPU_DEAD) {
> +			/*
> +			 * After another core sets cpu_state to CPU_DEAD,
> +			 * it needs some time to die.
> +			 */
> +			msleep(10);
>  			return;
> +		}
>  		msleep(100);
>  	}
>  	printk(KERN_ERR "CPU%d didn't die...\n", cpu);

I don't really see why you need to wait. This loop is about waiting for
the CPU to mark itself DEAD, not necessarily to be physically powered
off.

> +struct epapr_entry {
> +	u32	addr_h;
> +	u32	addr_l;
> +	u32	r3_h;
> +	u32	r3_l;
> +	u32	reserved;
> +	u32	pir;
> +	u32	r6_h;
> +	u32	r6_l;
> +};

This should probably be in a generic location.

> +static int is_corenet;

This global is a bit gross...

 ...

> +
> +static void __cpuinit smp_85xx_reset_core(int nr)
> +{
> +	__iomem u32 *vaddr, *pir_vaddr;
> +	u32 val, cpu_mask;
> +
> +	/* If CoreNet platform, use BRR as release register. */
> +	if (is_corenet) {
> +		cpu_mask = 1 << nr;
> +		vaddr = ioremap(get_immrbase() + MPC85xx_BRR_OFF, 4);
> +	} else {
> +		cpu_mask = 1 << (24 + nr);
> +		vaddr = ioremap(get_immrbase() + MPC85xx_ECM_EEBPCR_OFF, 4);
> +	}

Instead, can't you instead have two functions using a common helper and
pick/hook the right one ?

Also in what context is that reset_core() called ? Doing ioremap isn't
something you can do at any random time...

Cheers,
Ben.
