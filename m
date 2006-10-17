Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E31967C01
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 01:50:16 +1000 (EST)
In-Reply-To: <Pine.LNX.4.61.0610170125160.10940@ld0175-tx32.am.freescale.net>
References: <Pine.LNX.4.61.0610170125160.10940@ld0175-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <42AF8416-3B89-4C78-B220-38D61D25FD01@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Slight refactor of interrupt mapping for FSL parts
Date: Tue, 17 Oct 2006 10:50:11 -0500
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 17, 2006, at 1:27 AM, Andy Fleming wrote:

> * Cleaned up interrupt mapping a little by adding a helper
>   function which parses the irq out of the device-tree, and puts
>   it into a resource.
> * Changed the PHY Layer to use NO_IRQ instead of -1 for PHY_POLL.
>   This means that polling will always be used if mapping the
>   interrupt fails for any reason.
> * Changed the arch/ppc platform files to specify PHY_POLL, instead  
> of -1
> * Changed the fixed phy to use PHY_IGNORE_INTERRUPT
> ---
> This is a respin of the patch to reply to comments from the community
>
>  arch/powerpc/sysdev/fsl_soc.c                |   27 +++++++++ 
> +----------------
>  arch/ppc/platforms/85xx/mpc8540_ads.c        |    4 ++--
>  arch/ppc/platforms/85xx/mpc8560_ads.c        |    4 ++--
>  arch/ppc/platforms/85xx/mpc85xx_cds_common.c |    6 +++---
>  arch/ppc/platforms/85xx/sbc8560.c            |    2 +-
>  arch/ppc/platforms/85xx/stx_gp3.c            |    2 +-
>  arch/ppc/platforms/85xx/tqm85xx.c            |    4 ++--
>  drivers/net/phy/fixed.c                      |    2 +-
>  include/asm-powerpc/prom.h                   |    7 +++++++
>  include/linux/phy.h                          |    7 ++++++-
>  10 files changed, 35 insertions(+), 30 deletions(-)

What about arch/ppc/platforms/83xx?  also arch/ppc/platforms/ 
mpc8272ads_setup.c

[snip]

> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 9447a57..4dbffe4 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -20,6 +20,7 @@ #define __PHY_H
>
>  #include <linux/spinlock.h>
>  #include <linux/device.h>
> +#include <asm/irq.h>
>
>  #define PHY_BASIC_FEATURES	(SUPPORTED_10baseT_Half | \
>  				 SUPPORTED_10baseT_Full | \
> @@ -37,7 +38,11 @@ #define PHY_GBIT_FEATURES	(PHY_BASIC_FEA
>   * or not desired for this PHY.  Set to PHY_IGNORE_INTERRUPT if
>   * the attached driver handles the interrupt
>   */
> -#define PHY_POLL		-1
> +#ifndef NO_IRQ
> +#define NO_IRQ 0
> +#endif
> +
> +#define PHY_POLL		NO_IRQ
>  #define PHY_IGNORE_INTERRUPT	-2
>
>  #define PHY_HAS_INTERRUPT	0x00000001

We really should run this by the larger kernel community

- k
