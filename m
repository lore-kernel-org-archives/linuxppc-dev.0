Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0142.outbound.protection.outlook.com [207.46.163.142])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 789911A0052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 08:51:18 +1000 (EST)
Message-ID: <1409093463.6510.92.camel@snotra.buserror.net>
Subject: Re: [RESEND] clk: ppc-corenet: Add Freescale ARM-based platforms
 CLK_OF_DECLARE support
From: Scott Wood <scottwood@freescale.com>
To: Jingchang Lu <jingchang.lu@freescale.com>
Date: Tue, 26 Aug 2014 17:51:03 -0500
In-Reply-To: <1408700096-25415-1-git-send-email-jingchang.lu@freescale.com>
References: <1408700096-25415-1-git-send-email-jingchang.lu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, mturquette@linaro.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-08-22 at 17:34 +0800, Jingchang Lu wrote:
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> ---
>  drivers/clk/Kconfig           | 7 ++++---
>  drivers/clk/clk-ppc-corenet.c | 5 +++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index cfd3af7..8784704 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -82,11 +82,12 @@ config COMMON_CLK_AXI_CLKGEN
>  	  FPGAs. It is commonly used in Analog Devices' reference designs.
>  
>  config CLK_PPC_CORENET
> -	bool "Clock driver for PowerPC corenet platforms"
> -	depends on PPC_E500MC && OF
> +	bool "Clock driver for PowerPC corenet and compatible ARM-based platforms"
> +	depends on (PPC_E500MC || ARM) && OF

Should the symbol and driver be renamed to something like CLK_FSL_QORIQ?

> diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
> index 8e58edf..7692cac 100644
> --- a/drivers/clk/clk-ppc-corenet.c
> +++ b/drivers/clk/clk-ppc-corenet.c
> @@ -305,3 +305,8 @@ static int __init ppc_corenet_clk_init(void)
>  	return platform_driver_register(&ppc_corenet_clk_driver);
>  }
>  subsys_initcall(ppc_corenet_clk_init);
> +
> +CLK_OF_DECLARE(ppc_core_pll_v1, "fsl,qoriq-core-pll-1.0", core_pll_init);
> +CLK_OF_DECLARE(ppc_core_pll_v2, "fsl,qoriq-core-pll-2.0", core_pll_init);
> +CLK_OF_DECLARE(ppc_core_mux_v1, "fsl,qoriq-core-mux-1.0", core_mux_init);
> +CLK_OF_DECLARE(ppc_core_mux_v2, "fsl,qoriq-core-mux-2.0", core_mux_init);

What does this do that the existing platform driver and match table
don't?  Why is it needed for ARM when PPC didn't need it?

-Scott
