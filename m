Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D6D02DDE09
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 07:28:56 +1000 (EST)
Date: Wed, 5 Sep 2007 00:51:05 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/9] cpm2: Add cpm2_set_pin().
Message-ID: <20070905005105.38c00829@localhost.localdomain>
In-Reply-To: <20070828201924.GD24329@ld0162-tx32.am.freescale.net>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201924.GD24329@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 28 Aug 2007 15:19:24 -0500
Scott Wood wrote:

> This provides a generic way for board code to set up CPM pins, rather
> than directly poking magic values into registers.
> 
Please provide more info either here or somewhere in Documentation/, or inside the code at least.
We're adding new utility function here, and need to describe in a nutshell now the thing works.

This is completely self-explanatory for limited amount of people, I mean.


> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/sysdev/cpm2_common.c |   33
> +++++++++++++++++++++++++++++++++ include/asm-powerpc/cpm2.h
> |    9 +++++++++ 2 files changed, 42 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/cpm2_common.c
> b/arch/powerpc/sysdev/cpm2_common.c index 549da4b..b8460c0 100644
> --- a/arch/powerpc/sysdev/cpm2_common.c
> +++ b/arch/powerpc/sysdev/cpm2_common.c
> @@ -418,3 +418,36 @@ void *cpm_dpram_addr(unsigned long offset)
>  	return (void __force *)(im_dprambase + offset);
>  }
>  EXPORT_SYMBOL(cpm_dpram_addr);
> +
> +struct cpm2_ioports {
> +	u32	dir, par, sor, odr, dat;
> +	u32	res[3];
> +};
> +
> +void cpm2_set_pin(int port, int pin, int flags)
> +{
> +	struct cpm2_ioports __iomem *iop =
> +		(struct cpm2_ioports __iomem *)&cpm2_immr->im_ioport;
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
> +
> +	if (flags & CPM_PIN_OPENDRAIN)
> +		setbits32(&iop[port].odr, pin);
> +	else
> +		clrbits32(&iop[port].odr, pin);
> +}
> diff --git a/include/asm-powerpc/cpm2.h b/include/asm-powerpc/cpm2.h
> index 41a45db..d7b57ac 100644
> --- a/include/asm-powerpc/cpm2.h
> +++ b/include/asm-powerpc/cpm2.h
> @@ -1247,5 +1247,14 @@ enum cpm_clk {
>  extern int cpm2_clk_setup(enum cpm_clk_target target, int clock, int
> mode); extern int cpm2_smc_clk_setup(enum cpm_clk_target target, int
> clock); 
> +#define CPM_PIN_INPUT     0
> +#define CPM_PIN_OUTPUT    1
> +#define CPM_PIN_PRIMARY   0
> +#define CPM_PIN_SECONDARY 2
> +#define CPM_PIN_GPIO      4
> +#define CPM_PIN_OPENDRAIN 8
> +
> +void cpm2_set_pin(int port, int pin, int flags);
> +
>  #endif /* __CPM2__ */
>  #endif /* __KERNEL__ */


-- 
Sincerely, Vitaly
