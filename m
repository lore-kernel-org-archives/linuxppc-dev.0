Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67DB9DDEF4
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 15:12:57 +1000 (EST)
Subject: Re: [PATCH 2/7] Update mpic to use dcr_host_t.base
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <59ba66469e13b37eddf4e2423ed0540cce2e1079.1190009070.git.michael@ellerman.id.au>
References: <449a181e8169af98984bb2d61a759c23e55d19b4.1190009070.git.michael@ellerman.id.au>
	<59ba66469e13b37eddf4e2423ed0540cce2e1079.1190009070.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 15:12:41 +1000
Message-Id: <1191301961.6310.68.camel@pasglop>
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


On Mon, 2007-09-17 at 16:05 +1000, Michael Ellerman wrote:
> Now that dcr_host_t contains the base address, we can use that in the mpic
> code, rather than storing it separately.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/sysdev/mpic.c |   28 +++++++++++-----------------
>  include/asm-powerpc/mpic.h |    6 ------
>  2 files changed, 11 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 8de29f2..16b1f4b 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -156,8 +156,7 @@ static inline u32 _mpic_read(enum mpic_reg_type type,
>  	switch(type) {
>  #ifdef CONFIG_PPC_DCR
>  	case mpic_access_dcr:
> -		return dcr_read(rb->dhost,
> -				rb->dbase + reg + rb->doff);
> +		return dcr_read(rb->dhost, rb->dhost.base + reg);
>  #endif
>  	case mpic_access_mmio_be:
>  		return in_be32(rb->base + (reg >> 2));
> @@ -174,8 +173,7 @@ static inline void _mpic_write(enum mpic_reg_type type,
>  	switch(type) {
>  #ifdef CONFIG_PPC_DCR
>  	case mpic_access_dcr:
> -		return dcr_write(rb->dhost,
> -				 rb->dbase + reg + rb->doff, value);
> +		return dcr_write(rb->dhost, rb->dhost.base + reg, value);
>  #endif
>  	case mpic_access_mmio_be:
>  		return out_be32(rb->base + (reg >> 2), value);
> @@ -279,9 +277,11 @@ static void _mpic_map_mmio(struct mpic *mpic, unsigned long phys_addr,
>  static void _mpic_map_dcr(struct mpic *mpic, struct mpic_reg_bank *rb,
>  			  unsigned int offset, unsigned int size)
>  {
> -	rb->dbase = mpic->dcr_base;
> -	rb->doff = offset;
> -	rb->dhost = dcr_map(mpic->irqhost->of_node, rb->dbase + rb->doff, size);
> +	const u32 *dbasep;
> +
> +	dbasep = of_get_property(mpic->irqhost->of_node, "dcr-reg", NULL);
> +
> +	rb->dhost = dcr_map(mpic->irqhost->of_node, *dbasep + offset, size);
>  	BUG_ON(!DCR_MAP_OK(rb->dhost));
>  }
>  
> @@ -1075,20 +1075,14 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  	BUG_ON(paddr == 0 && node == NULL);
>  
>  	/* If no physical address passed in, check if it's dcr based */
> -	if (paddr == 0 && of_get_property(node, "dcr-reg", NULL) != NULL)
> -		mpic->flags |= MPIC_USES_DCR;
> -
> +	if (paddr == 0 && of_get_property(node, "dcr-reg", NULL) != NULL) {
>  #ifdef CONFIG_PPC_DCR
> -	if (mpic->flags & MPIC_USES_DCR) {
> -		const u32 *dbasep;
> -		dbasep = of_get_property(node, "dcr-reg", NULL);
> -		BUG_ON(dbasep == NULL);
> -		mpic->dcr_base = *dbasep;
> +		mpic->flags |= MPIC_USES_DCR;
>  		mpic->reg_type = mpic_access_dcr;
> -	}
>  #else
> -	BUG_ON (mpic->flags & MPIC_USES_DCR);
> +		BUG();
>  #endif /* CONFIG_PPC_DCR */
> +	}
>  
>  	/* If the MPIC is not DCR based, and no physical address was passed
>  	 * in, try to obtain one
> diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
> index edb4a7c..ae84dde 100644
> --- a/include/asm-powerpc/mpic.h
> +++ b/include/asm-powerpc/mpic.h
> @@ -224,8 +224,6 @@ struct mpic_reg_bank {
>  	u32 __iomem	*base;
>  #ifdef CONFIG_PPC_DCR
>  	dcr_host_t	dhost;
> -	unsigned int	dbase;
> -	unsigned int	doff;
>  #endif /* CONFIG_PPC_DCR */
>  };
>  
> @@ -289,10 +287,6 @@ struct mpic
>  	struct mpic_reg_bank	cpuregs[MPIC_MAX_CPUS];
>  	struct mpic_reg_bank	isus[MPIC_MAX_ISU];
>  
> -#ifdef CONFIG_PPC_DCR
> -	unsigned int		dcr_base;
> -#endif
> -
>  	/* Protected sources */
>  	unsigned long		*protected;
>  
