Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 3091DB6F8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 18:09:49 +1000 (EST)
From: Milton Miller <miltonm@bga.com>
Subject: Re: powerpc: Make early memory scan more resilient to out of order
	nodes
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1305183498.29820.95.camel@pasglop>
References: <1305183498.29820.95.camel@pasglop>
Message-Id: <benh-inital-memory@mdm.bga.com>
Date: Thu, 12 May 2011 03:09:48 -0500
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 11 May 2011 about 20:58:18 -0000, Benjamin Herrenschmidt wrote:
> We keep track of the size of the lowest block of memory and call
> setup_initial_memory_limit() only after we've parsed them all
> 

Good, we lose our sensitivity to device node ordering.

> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c

> index 584b398..27475c6 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -70,6 +70,7 @@ int __initdata iommu_force_on;
>  unsigned long tce_alloc_start, tce_alloc_end;
>  u64 ppc64_rma_size;
>  #endif
> +static phys_addr_t first_memblock_size;

__initdata 

(its only referenced by 2 __init functions)

Acked-by: Milton Miller <miltonm@bga.com>


>  static int __init early_parse_mem(char *p)
>  {
..
> @@ -507,11 +508,14 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
..
> @@ -708,6 +712,7 @@ void __init early_init_devtree(void *params)
