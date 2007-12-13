Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 550C2DDFED
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 08:35:27 +1100 (EST)
Date: Thu, 13 Dec 2007 15:40:47 -0600
From: Olof Johansson <olof@lixom.net>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/4] mpc8313erdb: Add NAND to device tree, and call
	of_platform_bus_probe().
Message-ID: <20071213214047.GA14534@lixom.net>
References: <20071213171632.GA4491@loki.buserror.net>
	<20071213171714.GA4510@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071213171714.GA4510@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 13, 2007 at 11:17:14AM -0600, Scott Wood wrote:
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> diff --git a/arch/powerpc/platforms/83xx/mpc8313_rdb.c b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
> index 6fb8299..3ad482a 100644
> --- a/arch/powerpc/platforms/83xx/mpc8313_rdb.c
> +++ b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
> @@ -14,6 +14,7 @@
>   */
>  
>  #include <linux/pci.h>
> +#include <linux/of_platform.h>
>  
>  #include <asm/time.h>
>  #include <asm/ipic.h>
> @@ -75,6 +76,22 @@ static int __init mpc8313_rdb_probe(void)
>  	return of_flat_dt_is_compatible(root, "MPC8313ERDB");
>  }
>  
> +static struct of_device_id __initdata of_bus_ids[] = {
> +	{ .name = "soc8313", },
> +	{ .name = "localbus", },

Please probe based on compatible instead of name properties.


Thanks,

Olof
