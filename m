Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BB999DDEE2
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 06:20:25 +1100 (EST)
In-Reply-To: <1173293364.23776.128.camel@ld0161-tx32>
References: <1173293364.23776.128.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Better timer and RTC handling for 8641HPCN.
Date: Wed, 7 Mar 2007 13:19:29 -0600
To: Jon Loeliger <jdl@freescale.com>,
	Zhang Wei-r63237 <wei.zhang@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 7, 2007, at 12:49 PM, Jon Loeliger wrote:

> From: Zhang Wei <wei.zhang@freescale.com>
>
> Give more IRQ numbers for MPIC IPIs and TIMERs use.
> Added generic RTC support for MPC8641HPCN.
>
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>

Nack.

You can't call the generic set_rtc_time from the  
ppc_md.set_rtc_time.  Take a look at:

http://ozlabs.org/pipermail/linuxppc-dev/2007-January/030440.html

- k

> ---
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/ 
> powerpc/platforms/86xx/mpc86xx_hpcn.c
> index f42f801..5ef6d61 100644
> --- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> +++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> @@ -28,7 +28,7 @@
>  #include <mm/mmu_decl.h>
>  #include <asm/udbg.h>
>  #include <asm/i8259.h>
> -
> +#include <asm-generic/rtc.h>
>  #include <asm/mpic.h>
>
>  #include <sysdev/fsl_soc.h>
> @@ -81,7 +81,7 @@ mpc86xx_hpcn_init_irq(void)
>  	/* Alloc mpic structure and per isu has 16 INT entries. */
>  	mpic1 = mpic_alloc(np, res.start,
>  			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
> -			16, NR_IRQS - 4,
> +			16, NR_IRQS - 10,
>  			" MPIC     ");

Why is the number of interrupts reduced by 10?

>  	BUG_ON(mpic1 == NULL);
>
> @@ -452,4 +452,10 @@ define_machine(mpc86xx_hpcn) {
>  	.time_init		= mpc86xx_time_init,
>  	.calibrate_decr		= generic_calibrate_decr,
>  	.progress		= udbg_progress,
> +
> +#ifdef CONFIG_GEN_RTC
> +	/* RTC interface, using functions in include/asm-generic/rtc.h */
> +	.get_rtc_time		= get_rtc_time,
> +	.set_rtc_time		= set_rtc_time,
> +#endif
>  };
> -- 
> 1.5.0.1.213.g509b
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
