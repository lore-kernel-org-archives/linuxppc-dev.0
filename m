Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 0CB51B7B8C
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 21:55:20 +1000 (EST)
Date: Wed, 23 Sep 2009 15:55:18 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Gao Guanhua <B22826@freescale.com>
Subject: Re: [PATCH 3/6] P2020DS: Fixup sdhc to use PIO mode
Message-ID: <20090923115518.GB6425@oksana.dev.rtsoft.ru>
References: <1253696892-15262-1-git-send-email-B22826@freescale.com>
	<1253696892-15262-2-git-send-email-B22826@freescale.com>
	<1253696892-15262-3-git-send-email-B22826@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1253696892-15262-3-git-send-email-B22826@freescale.com>
Cc: linuxppc-dev@ozlabs.org, sdhci-devel@lists.ossman.eu
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 23, 2009 at 05:08:09PM +0800, Gao Guanhua wrote:
> The SDHC can not work on DMA mode because of the hardware bug,
> so we set a broken dma flag and use PIO mode. This patch applies
> to Rev1.0.

Signed-off-by line is missing (in all patches).

> ---
>  arch/powerpc/boot/dts/p2020ds.dts |    1 +
>  drivers/mmc/host/sdhci-of.c       |    3 +++
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/p2020ds.dts b/arch/powerpc/boot/dts/p2020ds.dts
> index be449ba..574ad4f 100644
> --- a/arch/powerpc/boot/dts/p2020ds.dts
> +++ b/arch/powerpc/boot/dts/p2020ds.dts
> @@ -459,6 +459,7 @@
>  			reg = <0x2e000 0x1000>;
>  			interrupts = <72 0x2>;
>  			interrupt-parent = <&mpic>;
> +			fsl,sdhci-dma-broken;

You might want to update
Documentation/powerpc/dts-bindings/fsl/esdhc.txt

>  			clock-frequency = <0>;
>  		};
>  
> diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
> index 01ab916..5879483 100644
> --- a/drivers/mmc/host/sdhci-of.c
> +++ b/drivers/mmc/host/sdhci-of.c
> @@ -270,6 +270,9 @@ static int __devinit sdhci_of_probe(struct of_device *ofdev,
>  	if (sdhci_of_wp_inverted(np))
>  		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
>  
> +	if (of_get_property(np, "fsl,sdhci-dma-broken", NULL))
> +		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> +
>  	clk = of_get_property(np, "clock-frequency", &size);
>  	if (clk && size == sizeof(*clk) && *clk)
>  		of_host->clock = *clk;
> -- 
> 1.6.4

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
