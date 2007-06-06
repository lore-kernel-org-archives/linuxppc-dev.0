Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D6856DDED9
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 07:57:18 +1000 (EST)
Message-ID: <46672DB4.80504@freescale.com>
Date: Wed, 06 Jun 2007 16:57:08 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Philippe Lachenal <philippe.lachenal@hotmail.fr>
Subject: Re: MPC8349ea Random Device Generator driver
References: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
In-Reply-To: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, sl@powerlinux.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Philippe Lachenal wrote:
> Hello !
> 
> I've made a driver for the MPC8349ea Random Device Generator, and I 
> therefore submit it to your impartial judgment.. ;)
> thanks a lot !

First, please don't post your patch as an attachment.  I recommend you use git-send-email.

> diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
> old mode 100644
> new mode 100755
> index 40a0194..b05980b
> --- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
> +++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
> @@ -48,6 +48,24 @@ unsigned long isa_mem_base = 0;
>   * Setup the architecture
>   *
>   */
> +
> +static struct of_device_id mpc834x_itx[] = {
> +	{ .type = "soc", },
> +	{ .type ="crypto", },

You have a lot of minor spacing problems, like this one.  There should be a blank space 
before '"crypto"'.


> +
> +#include <asm/of_platform.h>
> +#include <asm/io.h>
> +
> +#define TALITOS_RNGSR		0x028	/* RNG status register */
> +#define TALITOS_RNGSR_HI	0x02c	/* RNG status register */
> +#define TALITOS_RNGSR_HI_RD	0x1	/* RNG Reset done */
> +#define TALITOS_RNGSR_HI_OFL	0xff0000/* number of dwords in RNG output FIFO*/
> +#define TALITOS_RNGDSR		0x010	/* RNG data size register */
> +#define TALITOS_RNGDSR_HI	0x014	/* RNG data size register */
> +#define TALITOS_RNG_FIFO	0x800	/* RNG FIFO - pool of random numbers */
> +#define TALITOS_RNGISR		0x030	/* RNG Interrupt status register */
> +#define TALITOS_RNGISR_HI	0x034	/* RNG Interrupt status register */
> +#define TALITOS_RNGRCR		0x018	/* RNG Reset control register */
> +#define TALITOS_RNGRCR_HI	0x01c	/* RNG Reset control register */

Please create a structure instead of using macros like this.  Example:

struct sec_rng {
	__be64	rngmr;
	u8 res1[8];
	__be64 rngdsr;
	__be64 rngrcr;
...
};

and then ...	

> +static int talitos_hwrng_data_present(struct hwrng *rng)
> +{
> +	void __iomem *rng_regs = (void __iomem *)rng->priv;

	struct sec_rng __iomem *rng = (struct sec_rng __iomem *) rng->priv;

> +
> +
> +	/* check for things like FIFO underflow */
> +	
> +	u32 v;
> +
> +	v = in_be32(rng_regs + TALITOS_RNGISR_HI);

	u64 v;
	v = rng->rngisr;

or something like that.  Try to use the built-in support for 64-bit data types when possible.

I get this confused easily, but I don't think you should be using the in/out_be macros 
either.  Just do regular reads and writes.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
