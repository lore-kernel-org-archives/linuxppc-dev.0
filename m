Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0109.outbound.protection.outlook.com [65.55.169.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F2B21A01DA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 02:37:22 +1000 (AEST)
Message-ID: <1431535027.3868.44.camel@freescale.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pltfm: enable interrupt mode to detect card
From: Scott Wood <scottwood@freescale.com>
To: Yangbo Lu <yangbo.lu@freescale.com>
Date: Wed, 13 May 2015 11:37:07 -0500
In-Reply-To: <1431505246-40102-1-git-send-email-yangbo.lu@freescale.com>
References: <1431505246-40102-1-git-send-email-yangbo.lu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-05-13 at 16:20 +0800, Yangbo Lu wrote:
> Enable interrupt mode to detect card instead of polling mode
> for P1020/P4080/P5020/P5040/T1040 by removing the quirk
> SDHCI_QUIRK_BROKEN_CARD_DETECTION. This could improve data
> transferring performance and avoid the call trace caused by
> polling card status sometime.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
>  drivers/mmc/host/sdhci-pltfm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index c5b01d6..62f4049 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -102,6 +102,13 @@ void sdhci_get_of_property(struct platform_device *pdev)
>  		    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
>  			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>  
> +		if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||
> +			of_device_is_compatible(np, "fsl,p5020-esdhc") ||
> +			of_device_is_compatible(np, "fsl,p4080-esdhc") ||
> +			of_device_is_compatible(np, "fsl,p1020-esdhc") ||
> +			of_device_is_compatible(np, "fsl,t1040-esdhc"))
> +			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;

Please don't line up continuation lines with the if-body.  All of the
"of_device_is_compatibles" should start in the same column.

Given that you need to modify the device tree for this, why not just use
SVR?

-Scott
