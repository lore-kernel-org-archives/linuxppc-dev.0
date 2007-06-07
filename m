Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2E1BDDEBD
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 08:26:08 +1000 (EST)
Subject: Re: [PATCH] Fix per-cpu allocation on oldworld SMP powermacs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18023.64811.643218.556485@cargo.ozlabs.ibm.com>
References: <18023.64811.643218.556485@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 08 Jun 2007 08:26:02 +1000
Message-Id: <1181255162.14818.79.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-07 at 22:42 +1000, Paul Mackerras wrote:
> diff --git a/arch/powerpc/platforms/powermac/setup.c
> b/arch/powerpc/platforms/powermac/setup.c
> index 07b1c4e..c519b2a 100644
> --- a/arch/powerpc/platforms/powermac/setup.c
> +++ b/arch/powerpc/platforms/powermac/setup.c
> @@ -363,8 +363,19 @@ static void __init pmac_setup_arch(void)
>                 smp_ops = &core99_smp_ops;
>         }
>  #ifdef CONFIG_PPC32
> -       else
> +       else {
> +               /*
> +                * We have to set bits in cpu_possible_map here since
> the
> +                * secondary CPU(s) aren't in the device tree, and
> +                * setup_per_cpu_areas only allocates per-cpu data for
> +                * CPUs in the cpu_possible_map.
> +                */
> +               int cpu;
> +
> +               for (cpu = 1; cpu < 4 && cpu < NR_CPUS; ++cpu)
> +                       cpu_set(cpu, cpu_possible_map);
>                 smp_ops = &psurge_smp_ops;
> +       }
>  #endif
>  #endif /* CONFIG_SMP */ 

Why not use the result from probe() instead which returns the number of
possible CPUs ? That would catch more than just the powermac case ... we
might have similar issues when finally porting PReP over...

Ben.
