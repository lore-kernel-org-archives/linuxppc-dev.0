Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62BB5DDE9B
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 22:45:42 +1100 (EST)
Subject: Re: [PATCH] prom.c: Fix dt_mem_next_cell() to read the full mem cells
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <bgill@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0802151215210.1840@monty.am.freescale.net>
References: <Pine.LNX.4.64.0802151215210.1840@monty.am.freescale.net>
Content-Type: text/plain
Date: Sat, 16 Feb 2008 22:45:14 +1100
Message-Id: <1203162314.22915.46.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-02-15 at 12:17 -0600, Becky Bruce wrote:
> dt_mem_next_cell() currently does of_read_ulong().  This does
> not allow for the case where #size-cells and/or #address-cells = 2 on
> a 32-bit system, as it will end up reading 32 bits instead of the
> expected 64. Change it to use of_read_number instead and always return
> a u64.
> 
> Signed-off-by: Becky Bruce <becky.bruce at freescale.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/kernel/prom.c |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index c17a585..ff600ef 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -865,12 +865,12 @@ static int __init early_init_dt_scan_root(unsigned long node,
>  	return 1;
>  }
>  
> -static unsigned long __init dt_mem_next_cell(int s, cell_t **cellp)
> +static u64 __init dt_mem_next_cell(int s, cell_t **cellp)
>  {
>  	cell_t *p = *cellp;
>  
>  	*cellp = p + s;
> -	return of_read_ulong(p, s);
> +	return of_read_number(p, s);
>  }
>  
>  #ifdef CONFIG_PPC_PSERIES
> @@ -883,8 +883,8 @@ static unsigned long __init dt_mem_next_cell(int s, cell_t **cellp)
>  static int __init early_init_dt_scan_drconf_memory(unsigned long node)
>  {
>  	cell_t *dm, *ls;
> -	unsigned long l, n;
> -	unsigned long base, size, lmb_size, flags;
> +	unsigned long l, n, flags;
> +	u64 base, size, lmb_size;
>  
>  	ls = (cell_t *)of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
>  	if (ls == NULL || l < dt_root_size_cells * sizeof(cell_t))
> @@ -959,14 +959,15 @@ static int __init early_init_dt_scan_memory(unsigned long node,
>  	    uname, l, reg[0], reg[1], reg[2], reg[3]);
>  
>  	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
> -		unsigned long base, size;
> +		u64 base, size;
>  
>  		base = dt_mem_next_cell(dt_root_addr_cells, &reg);
>  		size = dt_mem_next_cell(dt_root_size_cells, &reg);
>  
>  		if (size == 0)
>  			continue;
> -		DBG(" - %lx ,  %lx\n", base, size);
> +		DBG(" - %llx ,  %llx\n", (unsigned long long)base,
> +		    (unsigned long long)size);
>  #ifdef CONFIG_PPC64
>  		if (iommu_is_off) {
>  			if (base >= 0x80000000ul)
