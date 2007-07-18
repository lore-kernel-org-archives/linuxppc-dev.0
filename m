Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC9ECDDE1A
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 01:02:14 +1000 (EST)
In-Reply-To: <20070718013535.GZ15238@ld0162-tx32.am.freescale.net>
References: <20070718013535.GZ15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <44F03DBB-C3D6-4AA1-9960-730F64829EC6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 28/61] Add cpm2_set_pin().
Date: Wed, 18 Jul 2007 10:02:40 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 17, 2007, at 8:35 PM, Scott Wood wrote:

> This provides a generic way for board code to set up CPM pins, rather
> than directly poking magic values into registers.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/sysdev/cpm2_common.c |   28 ++++++++++++++++++++++++++++
>  include/asm-ppc/cpm2.h            |    8 ++++++++
>  2 files changed, 36 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/ 
> sysdev/cpm2_common.c
> index 7e3a983..0a62df7 100644
> --- a/arch/powerpc/sysdev/cpm2_common.c
> +++ b/arch/powerpc/sysdev/cpm2_common.c
> @@ -338,3 +338,31 @@ void *cpm_dpram_addr(unsigned long offset)
>  	return (void *)(im_dprambase + offset);
>  }
>  EXPORT_SYMBOL(cpm_dpram_addr);
> +
> +struct cpm2_ioports {
> +	u32	dir, par, sor, odr, dat;

__be32?

> +	u32	res[3];
> +};
> +
> +void cpm2_set_pin(int port, int pin, int flags)

Can we make the function take a pointer to the port directly?

> +{
> +	struct cpm2_ioports __iomem *iop =
> +		(struct cpm_ioports __iomem *)&cpm2_immr->im_ioport;
> +
> +	pin = 1 << (31 - pin);
> +
> +	if (flags & CPM_PIN_OUTPUT)
> +		setbits32(&iop[port].dir, pin);
> +	else
> +		clrbits32(&iop[port].dir, pin);
> +
> +	if (!(flags & CPM_PIN_GPIO))
> +		setbits32(&iop[port].par, pin);
> +	else
> +		clrbits32(&iop[port].par, pin);
> +
> +	if (flags & CPM_PIN_SECONDARY)
> +		setbits32(&iop[port].sor, pin);
> +	else
> +		clrbits32(&iop[port].sor, pin);

should we only do this if !(flags & CPM_PIN_GPIO)?

Any reason we don't also set odr here?

> +}
> diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
> index 12a2860..0e7ffb6 100644
> --- a/include/asm-ppc/cpm2.h
> +++ b/include/asm-ppc/cpm2.h
> @@ -1244,5 +1244,13 @@ enum cpm_clk {
>
>  extern int cpm2_clk_setup(enum cpm_clk_target target, int clock,  
> int mode);
>
> +#define CPM_PIN_INPUT     0
> +#define CPM_PIN_OUTPUT    1
> +#define CPM_PIN_PRIMARY   0
> +#define CPM_PIN_SECONDARY 2
> +#define CPM_PIN_GPIO      4
> +
> +void cpm2_set_pin(int port, int pin, int flags);
> +
>  #endif /* __CPM2__ */
>  #endif /* __KERNEL__ */
> -- 
> 1.5.0.3
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
