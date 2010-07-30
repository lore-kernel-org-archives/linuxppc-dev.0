Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 72E42B70AA
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 17:06:29 +1000 (EST)
Received: by eyh6 with SMTP id 6so2128936eyh.15
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 00:06:27 -0700 (PDT)
Date: Fri, 30 Jul 2010 11:06:24 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH 3/3 v2] mmc: Add ESDHC weird voltage bits workaround
Message-ID: <20100730070624.GB20351@oksana.dev.rtsoft.ru>
References: <1280461977-2023-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1280461977-2023-1-git-send-email-tie-fei.zang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-mmc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 30, 2010 at 11:52:57AM +0800, Roy Zang wrote:
> P4080 ESDHC controller does not support 1.8V and 3.0V voltage. but the
> host controller capabilities register wrongly set the bits.
> This patch adds the workaround to correct the weird voltage setting bits.
> 
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
[...]
> diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
> index 0c30242..1f3913d 100644
> --- a/drivers/mmc/host/sdhci-of-core.c
> +++ b/drivers/mmc/host/sdhci-of-core.c
> @@ -164,6 +164,10 @@ static int __devinit sdhci_of_probe(struct of_device *ofdev,
>  	if (sdhci_of_wp_inverted(np))
>  		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
>  
> +	if (of_device_is_compatible(np, "fsl,p4080-esdhc"))
> +		host->quirks |= (SDHCI_QUIRK_QORIQ_NO_VDD_180
> +				|SDHCI_QUIRK_QORIQ_NO_VDD_300);
> +

It should be two properties, something like sdhci,no-vdd-180
and sdhci,no-vdd-300. But it might be even better: we have
voltage-ranges for mmc-spi case, see
Documentation/powerpc/dts-bindings/mmc-spi-slot.txt.

If voltage-ranges specified, then we use it, not capabilities
register.

For p4080 it will be 'voltage-ranges = <3200 3400>;'. So, with
voltage-ranges we can do fine grained VDD control without
introducing anything new.

As for implementation, you might just factor out voltage-ranges
parsing from drivers/mmc/host/of_mmc_spi.c, and then in sdhci
driver you could do.

if (host->ocr_avail)
	mmc->ocr_avail = host->ocr_avail.

>  	clk = of_get_property(np, "clock-frequency", &size);
>  	if (clk && size == sizeof(*clk) && *clk)
>  		of_host->clock = *clk;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1424d08..a667790 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1699,6 +1699,14 @@ int sdhci_add_host(struct sdhci_host *host)
>  
>  	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>  
> +	 /* Workaround for P4080 host controller capabilities
> +	  * 1.8V and 3.0V do not supported*/
> +	if (host->quirks & SDHCI_QUIRK_QORIQ_NO_VDD_180)

The point of making NO_VDD stuff is to make these quirks
"chip-agnostic". Ideally, sdhci.c should never know about
particular chips.

So, you shouldn't name quirks with QORIQ.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
