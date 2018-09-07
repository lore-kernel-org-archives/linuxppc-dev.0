Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426TT249WVzF3Tx
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2018 06:25:10 +1000 (AEST)
Message-ID: <86101ce0f4201d05510e57d74cafe8c665b8e5d4.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Ran Wang <ran.wang_1@nxp.com>, Leo Li <leoyang.li@nxp.com>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 07 Sep 2018 15:25:04 -0500
In-Reply-To: <20180831035219.31619-3-ran.wang_1@nxp.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <20180831035219.31619-3-ran.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 3/3] soc: fsl: add RCPM driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-31 at 11:52 +0800, Ran Wang wrote:
> The NXP's QorIQ Processors based on ARM Core have RCPM module (Run
> Control and Power Management), which performs all device-level
> tasks associated with power management such as wakeup source control.
> 
> This driver depends on FSL platform PM driver framework which help to
> isolate user and PM service provider (such as RCPM driver).
> 
> Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> Signed-off-by: Ying Zhang <ying.zhang22455@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  drivers/soc/fsl/Kconfig   |    6 ++
>  drivers/soc/fsl/Makefile  |    1 +
>  drivers/soc/fsl/ls-rcpm.c |  153
> +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 160 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/soc/fsl/ls-rcpm.c

Is there a reason why this is LS-specific, or could it be used with PPC RCPM
blocks?

> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> index 6517412..882330d 100644
> --- a/drivers/soc/fsl/Kconfig
> +++ b/drivers/soc/fsl/Kconfig
> @@ -30,3 +30,9 @@ config FSL_PLAT_PM
>  	  have to know the implement details of wakeup function it require.
>  	  Besides, it is also easy for service side to upgrade its logic
> when
>  	  design changed and remain user side unchanged.
> +
> +config LS_RCPM
> +	bool "Freescale RCPM support"
> +	depends on (FSL_PLAT_PM)

Why is this parenthesized?

-Scott
