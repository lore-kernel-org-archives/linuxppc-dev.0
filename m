Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7BC0DE00E
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 05:29:12 +1000 (EST)
In-Reply-To: <1180406209.8139.13.camel@localhost.localdomain>
References: <1180406209.8139.13.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BA0C2035-FCAD-4B34-A622-F79432079F10@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2]: Fix e500 v2 core reboot bug
Date: Tue, 29 May 2007 14:29:00 -0500
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 28, 2007, at 9:36 PM, Zang Roy-r61911 wrote:

> Fix the e500 v2 core reset bug.
> For e500 v2 core, a new reset control register is added to
> reset the core.
> On 85xx CDS board with e500 v2 core, normal reboot code will
> induce DDR block in u-boot. This patch fixes this bug. It is
> also tested on legacy e500 v1 core.

what happens on an e500 based 85xx system?

I'm not terrible happy with blindly writing to rstcr.

- k

>
>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
>
>  arch/powerpc/platforms/85xx/misc.c |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/platforms/85xx/misc.c b/arch/powerpc/ 
> platforms/85xx/misc.c
> index 3e62fcb..886a13f 100644
> --- a/arch/powerpc/platforms/85xx/misc.c
> +++ b/arch/powerpc/platforms/85xx/misc.c
> @@ -13,11 +13,29 @@
>  #include <linux/irq.h>
>  #include <linux/module.h>
>  #include <asm/irq.h>
> +#include <asm/io.h>
> +#include <sysdev/fsl_soc.h>
> +
> +static __be32 __iomem *rstcr;
>
>  extern void abort(void);
>
> +static int __init mpc85xx_rstcr(void)
> +{
> +	/* map reset control register */
> +	rstcr = ioremap(get_immrbase() + 0xE00B0, 0xff);
> +	return 0;
> +}
> +
> +arch_initcall(mpc85xx_rstcr);
> +
>  void mpc85xx_restart(char *cmd)
>  {
>  	local_irq_disable();
> +	if (rstcr)
> +		/* set reset control register */
> +		out_be32(rstcr, 0x2);	/* HRESET_REQ */
> +	else
> +		printk (KERN_EMERG "Error: reset control register not mapped,  
> spinning!\n");
>  	abort();
>  }
> -- 
> 1.5.1
>
