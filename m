Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426Thd30t5zF3Sy
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2018 06:35:13 +1000 (AEST)
Message-ID: <cad8c585fb415959e7ade8b500278c2c5e070873.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Ran Wang <ran.wang_1@nxp.com>, Leo Li <leoyang.li@nxp.com>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 07 Sep 2018 15:35:08 -0500
In-Reply-To: <20180831035219.31619-1-ran.wang_1@nxp.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 1/3] soc: fsl: add Platform PM driver QorIQ platforms
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-31 at 11:52 +0800, Ran Wang wrote:
> This driver is to provide a independent framework for PM service
> provider and consumer to configure system level wake up feature. For
> example, RCPM driver could register a callback function on this
> platform first, and Flex timer driver who want to enable timer wake
> up feature, will call generic API provided by this platform driver,
> and then it will trigger RCPM driver to do it. The benefit is to
> isolate the user and service, such as flex timer driver will not have
> to know the implement details of wakeup function it require. Besides,
> it is also easy for service side to upgrade its logic when design is
> changed and remain user side unchanged.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  drivers/soc/fsl/Kconfig   |   14 +++++
>  drivers/soc/fsl/Makefile  |    1 +
>  drivers/soc/fsl/plat_pm.c |  144
> +++++++++++++++++++++++++++++++++++++++++++++
>  include/soc/fsl/plat_pm.h |   22 +++++++
>  4 files changed, 181 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/soc/fsl/plat_pm.c
>  create mode 100644 include/soc/fsl/plat_pm.h
> 
> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> index 7a9fb9b..6517412 100644
> --- a/drivers/soc/fsl/Kconfig
> +++ b/drivers/soc/fsl/Kconfig
> @@ -16,3 +16,17 @@ config FSL_GUTS
>  	  Initially only reading SVR and registering soc device are
> supported.
>  	  Other guts accesses, such as reading RCW, should eventually be
> moved
>  	  into this driver as well.
+
> +config FSL_PLAT_PM
> +	bool "Freescale platform PM framework"

This name seems to be simultaneously too generic (for something that is likely
intended only for use with certain Freescale/NXP chip families) and too
specific (for something that seems to be general infrastructure with no real
hardware dependencies).

What specific problems with Linux's generic wakeup infrastructure is this
trying to solve, and why would those problems not be better solved there?

Also, you should CC linux-pm on these patches.

-Scott
