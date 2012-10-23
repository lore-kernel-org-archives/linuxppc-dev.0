Return-Path: <cbouatmailru@gmail.com>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 39EBD2C0168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2012 19:29:49 +1100 (EST)
Received: by mail-pa0-f51.google.com with SMTP id kq12so2337257pab.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2012 01:29:47 -0700 (PDT)
Date: Tue, 23 Oct 2012 01:26:48 -0700
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: r66093@freescale.com
Subject: Re: [PATCH] powerpc/esdhc: enable the card insert/remove interrupt
Message-ID: <20121023082648.GA21690@lizard>
References: <1350975677-8195-1-git-send-email-r66093@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1350975677-8195-1-git-send-email-r66093@freescale.com>
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>,
 linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 23, 2012 at 03:01:17PM +0800, r66093@freescale.com wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> The current eSDHC driver use the poll mode to detect
> if the SD/MMC card is inserted or removed, which will generate
> many interrupts and impact the performance. 
> Therefore, change the default card detect to interrupt mode,
> if the board can't support this mode, we still use the poll mode.
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Anton Vorontsov <cbouatmailru@gmail.com>
> CC: Chris Ball <cjb@laptop.org>
> ---

IIRC, the card detection is broken SOC-revision-wise, not board-wise. So
the change seems wrong.

Also, take a look at this:

	http://lkml.org/lkml/2010/7/14/127

I started the work but never finished, unfortunately it caused some
regressions for non-FSL hardware...

>  drivers/mmc/host/sdhci-of-esdhc.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index ffc1226..5dc362f 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -196,6 +196,11 @@ static void esdhc_of_detect_limitation(struct platform_device *pdev,
>  	if (vvn == VENDOR_V_22)
>  		pdata->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>  
> +	/* P4080DS and MPC837XMDS board don't support interrupt mode */
> +	if (of_machine_is_compatible("fsl,mpc837xmds") ||
> +	    of_machine_is_compatible("fsl,P4080DS"))
> +		pdata->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +
>  	iounmap(ioaddr);
>  end:
>  	return;
> @@ -223,7 +228,7 @@ static struct sdhci_pltfm_data sdhci_esdhc_pdata = {
>  	 * card detection could be handled via GPIO
>  	 * eSDHC cannot support End Attribute in NOP ADMA descriptor
>  	 */
> -	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
> +	.quirks = ESDHC_DEFAULT_QUIRKS
>  		| SDHCI_QUIRK_NO_CARD_NO_RESET
>  		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>  	.ops = &sdhci_esdhc_ops,
> -- 
> 1.7.9.5
