Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0116.outbound.protection.outlook.com [207.46.100.116])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E8F091A18E0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 08:55:48 +1100 (AEDT)
Message-ID: <1413496523.7417.12.camel@aoeu.buserror.net>
Subject: Re: [PATCH 2/2] clk: ppc-corenet: don't use platform_driver to init
 the clock device
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Thu, 16 Oct 2014 23:55:23 +0200
In-Reply-To: <1413458321-23880-3-git-send-email-haokexin@gmail.com>
References: <1413458321-23880-1-git-send-email-haokexin@gmail.com>
 <1413458321-23880-3-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Jingchang Lu <jingchang.lu@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Mike Turquette <mturquette@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-10-16 at 19:18 +0800, Kevin Hao wrote:
> In commit da788acb2838 ("clk: ppc-corenet: Fix Section mismatch
> warning"), we put the ppc_corenet_clk_driver struct to init section
> in order to fix section mismatch warning. This is definitely wrong
> because the kernel would free the memories occupied by
> ppc_corenet_clk_driver after boot while this driver is still registered
> in the driver core. The kernel would panic when accessing this driver
> struct. So choose to use CLK_OF_DECLARE to scan and init the clock devices.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  arch/powerpc/platforms/85xx/corenet_generic.c |  7 +++++
>  drivers/clk/clk-ppc-corenet.c                 | 43 ++++-----------------------
>  2 files changed, 13 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
> index e56b89a792ed..7677cfecb787 100644
> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> @@ -16,6 +16,7 @@
>  #include <linux/kdev_t.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/clk-provider.h>
>  
>  #include <asm/time.h>
>  #include <asm/machdep.h>
> @@ -188,11 +189,17 @@ static int __init corenet_generic_probe(void)
>  	return 0;
>  }
>  
> +static void __init corenet_gen_init(void)
> +{
> +	of_clk_init(NULL);
> +}

Why is this board-specific?

-Scott
