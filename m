Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2AB10B7D6D
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Feb 2010 07:35:42 +1100 (EST)
Subject: Re: [PATCH 5/5] powerpc: Increase NR_IRQS Kconfig maximum to 32768
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20100131111403.GP2996@kryten>
References: <20100131110938.GL2996@kryten> <20100131111012.GM2996@kryten>
	<20100131111155.GN2996@kryten> <20100131111315.GO2996@kryten>
	<20100131111403.GP2996@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 01 Feb 2010 07:35:24 +1100
Message-ID: <1264970124.8287.9.camel@pasglop>
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

On Sun, 2010-01-31 at 22:14 +1100, Anton Blanchard wrote:
> With dynamic irq descriptors the overhead of a large NR_IRQS is much lower
> than it used to be. With more MSI-X capable adapters and drivers exploiting 
> multiple vectors we may as well allow the user to increase it beyond the
> current maximum of 512.
> 
> 32768 seems large enough that we'd never have to bump it again (although I bet
> my prediction is horribly wrong). It boot tests OK and the vmlinux footprint
> increase is only around 500kB due to:
> 
> struct irq_map_entry irq_map[NR_IRQS];

We could dynamically allocate that one.

Cheers,
Ben.

> We format /proc/interrupts correctly with the previous changes:
> 
>              CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
>   286:          0          0          0          0          0          0     
>   516:          0          0          0          0          0          0     
> 16689:       1833          0          0          0          0          0     
> 17157:          0          0          0          0          0          0     
> 17158:        319          0          0          0          0          0     
> 25092:          0          0          0          0          0          0     
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: linux-cpumask/arch/powerpc/Kconfig
> ===================================================================
> --- linux-cpumask.orig/arch/powerpc/Kconfig	2010-01-31 15:07:11.707211107 +1100
> +++ linux-cpumask/arch/powerpc/Kconfig	2010-01-31 21:52:39.999711689 +1100
> @@ -58,7 +58,7 @@ config IRQ_PER_CPU
>  
>  config NR_IRQS
>  	int "Number of virtual interrupt numbers"
> -	range 32 512
> +	range 32 32768
>  	default "512"
>  	help
>  	  This defines the number of virtual interrupt numbers the kernel
