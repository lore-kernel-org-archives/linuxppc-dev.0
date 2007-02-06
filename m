Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 70DB9DDFE6
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 03:50:33 +1100 (EST)
In-Reply-To: <20070205204339.GB3683@ld0162-tx32.am.freescale.net>
References: <20070205204339.GB3683@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CA30AAD9-D1D4-4D62-AFB2-0A54A5CB4BE1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] 83xx: Don't ioremap() from the reset function.
Date: Tue, 6 Feb 2007 10:50:28 -0600
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


On Feb 5, 2007, at 2:43 PM, Scott Wood wrote:

> ioremap() is not safe to call from interrupt context, so instead  
> use the
> whole-soc mapping to access the reset registers.

Nack.

I've already got a patch that fixes this issue in my tree.

- k

>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/platforms/83xx/misc.c |   17 +++++++++--------
>  1 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/ 
> platforms/83xx/misc.c
> index f0c6df6..a4b14c1 100644
> --- a/arch/powerpc/platforms/83xx/misc.c
> +++ b/arch/powerpc/platforms/83xx/misc.c
> @@ -23,18 +23,19 @@ void mpc83xx_restart(char *cmd)
>  #define RST_OFFSET	0x00000900
>  #define RST_PROT_REG	0x00000018
>  #define RST_CTRL_REG	0x0000001c
> -	__be32 __iomem *reg;
>
> -	/* map reset register space */
> -	reg = ioremap(get_immrbase() + 0x900, 0xff);
> +	if (mpc83xx_immr) {
> +		__be32 __iomem *reg = mpc83xx_immr + RST_OFFSET;
>
> -	local_irq_disable();
> +		local_irq_disable();
>
> -	/* enable software reset "RSTE" */
> -	out_be32(reg + (RST_PROT_REG >> 2), 0x52535445);
> +		/* enable software reset "RSTE" */
> +		out_be32(reg + (RST_PROT_REG >> 2), 0x52535445);
> +
> +		/* set software hard reset */
> +		out_be32(reg + (RST_CTRL_REG >> 2), 0x2);
> +	}
>
> -	/* set software hard reset */
> -	out_be32(reg + (RST_CTRL_REG >> 2), 0x2);
>  	for (;;) ;
>  }
>
> -- 
> 1.4.4
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
