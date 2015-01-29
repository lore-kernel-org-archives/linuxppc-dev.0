Return-Path: <ulf.hansson@linaro.org>
Received: from mail-qg0-f53.google.com (mail-qg0-f53.google.com
 [209.85.192.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB2C51A0F4B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 23:19:58 +1100 (AEDT)
Received: by mail-qg0-f53.google.com with SMTP id a108so27062975qge.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 04:19:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150128195236.GA31422@darwin.bork.org>
References: <20150128195236.GA31422@darwin.bork.org>
Date: Thu, 29 Jan 2015 13:19:55 +0100
Message-ID: <CAPDyKFqwieB6h9WXHea1J1QM3yHJgMMH2-b0ym4xUfZc1iHPQw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Apply FSL ESDHC reset handling quirk to OF
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Martin Hicks <mort@bork.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Anton Vorontsov <anton@enomsg.org>, linux-mmc <linux-mmc@vger.kernel.org>,
 Chris Ball <chris@printf.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28 January 2015 at 20:52, Martin Hicks <mort@bork.org> wrote:
>
> The reset code was pushed into the esdhc-imx driver, but missed being
> pushed into the FSL OF driver at the same time.  The commit that broke
> the OF ESDHC driver was 0718e59ae259f7c48155b4e852d8b0632d59028e
>
> Signed-off-by: Martin Hicks <mort@bork.org>

Martin, thanks for the patch. Though I have already queued a patch for
this issue. It's available on my next branch.

Alessio Igor Bogani <alessio.bogani@elettra.eu>
mmc: sdhci: Fix FSL ESDHC reset handling quirk

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 8872c85..4a654d4 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -276,6 +276,14 @@ static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
>                         ESDHC_CTRL_BUSWIDTH_MASK, ctrl);
>  }
>
> +static void esdhc_reset(struct sdhci_host *host, u8 mask)
> +{
> +       sdhci_reset(host, mask);
> +
> +       sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +       sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +}
> +
>  static const struct sdhci_ops sdhci_esdhc_ops = {
>         .read_l = esdhc_readl,
>         .read_w = esdhc_readw,
> @@ -290,7 +298,7 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
>         .platform_init = esdhc_of_platform_init,
>         .adma_workaround = esdhci_of_adma_workaround,
>         .set_bus_width = esdhc_pltfm_set_bus_width,
> -       .reset = sdhci_reset,
> +       .reset = esdhc_reset,
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
>
> --
> 1.7.10.4
>
>
> --
> Martin Hicks P.Eng.    |      mort@bork.org
> Bork Consulting Inc.   |  +1 (613) 266-2296
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
