Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B3D6DE060
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 05:35:53 +1100 (EST)
In-Reply-To: <1173291755.23776.121.camel@ld0161-tx32>
References: <1173291755.23776.121.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3CF6D7AF-D5E0-4325-8015-FE048C63E8B6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Fix e500 v2 core reboot bug
Date: Wed, 7 Mar 2007 12:34:53 -0600
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mar 7, 2007, at 12:22 PM, Jon Loeliger wrote:

> From: Roy Zang <tie-fei.zang@freescale.com>
>
> For e500 v2 core, a new reset control register is added.
>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Acked-by: Jon Loeliger <jdl@freescale.com>

Nack.  See comments below.

- k

> ---
>  arch/powerpc/platforms/85xx/misc.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/platforms/85xx/misc.c b/arch/powerpc/ 
> platforms/85xx/misc.c
> index 3e62fcb..9fcbf56 100644
> --- a/arch/powerpc/platforms/85xx/misc.c
> +++ b/arch/powerpc/platforms/85xx/misc.c
> @@ -13,11 +13,21 @@
>  #include <linux/irq.h>
>  #include <linux/module.h>
>  #include <asm/irq.h>
> +#include <asm/io.h>
> +#include <sysdev/fsl_soc.h>
>
>  extern void abort(void);
>
>  void mpc85xx_restart(char *cmd)
>  {
> +	unsigned int pvr;
> +
> +	pvr = mfspr(SPRN_PVR);
> +	if ((pvr >> 16) & 0x1){

Testing the PVR isn't proper.. you are using a system feature that  
has nothing to do with the core revision.

Maybe add an attribute in the soc node for this?

> +		u32 __iomem *rstcr;
> +		rstcr = ioremap(get_immrbase() + 0xE00B0, 0x100);

You can't do the ioremap here, this my get called from interrupt  
context..  See 83xx/misc.c for a slightly better example.  The  
unprotected arch_initcall is still an issue on 83xx.

> +		*rstcr = 0x2;           /* HRESET_REQ */

we should be using out_be32()

> +	}
>  	local_irq_disable();
>  	abort();
>  }
