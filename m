Return-Path: <ulf.hansson@linaro.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C71711A01F4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 21:51:37 +1000 (EST)
Received: by mail-qa0-f51.google.com with SMTP id k15so8642975qaq.24
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 04:51:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1407839872-12864-1-git-send-email-pawel.moll@arm.com>
References: <CAPDyKFrb9OSbhHtn=wgbs9Yky1t453rdNBJVgGA62vER-65dYw@mail.gmail.com>
 <1407839872-12864-1-git-send-email-pawel.moll@arm.com>
Date: Tue, 12 Aug 2014 13:51:34 +0200
Message-ID: <CAPDyKFpR2fuCjD3v6wMWkfCqY4gO3K52vOv8nkyfuLtB1e792w@mail.gmail.com>
Subject: Re: [PATCH 3/5 v2] mmc: sdhci-pltfm: Do not use parent as the host's
 device
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Pawel Moll <pawel.moll@arm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Anton Vorontsov <anton@enomsg.org>, linux-mmc <linux-mmc@vger.kernel.org>,
 Chris Ball <chris@printf.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12 August 2014 12:37, Pawel Moll <pawel.moll@arm.com> wrote:
> The code selecting a device for the sdhci host has been
> continuously tweaked (4b711cb13843f5082e82970dd1e8031383134a65
> "mmc: sdhci-pltfm: Add structure for host-specific data" and
> a4d2177f00a5252d825236c5124bc1e9918bdb41 "mmc: sdhci-pltfm: dt
> device does not pass parent to sdhci_alloc_host" while there
> does not seem to be any reason to use platform device's parent
> in the first place.
>
> The comment saying "Some PCI-based MFD need the parent here"
> seem to refer to Timberdale FPGA driver (the only MFD driver
> registering SDHCI cell, drivers/mfd/timberdale.c) but again,
> the only situation when parent device matter is runtime PM,
> which is not implemented for Timberdale.
>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Thanks! Queued for 3.18.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pltfm.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index 7e834fb..c5b01d6 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -123,7 +123,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>                                     size_t priv_size)
>  {
>         struct sdhci_host *host;
> -       struct device_node *np = pdev->dev.of_node;
>         struct resource *iomem;
>         int ret;
>
> @@ -136,13 +135,8 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>         if (resource_size(iomem) < 0x100)
>                 dev_err(&pdev->dev, "Invalid iomem size!\n");
>
> -       /* Some PCI-based MFD need the parent here */
> -       if (pdev->dev.parent != &platform_bus && !np)
> -               host = sdhci_alloc_host(pdev->dev.parent,
> -                       sizeof(struct sdhci_pltfm_host) + priv_size);
> -       else
> -               host = sdhci_alloc_host(&pdev->dev,
> -                       sizeof(struct sdhci_pltfm_host) + priv_size);
> +       host = sdhci_alloc_host(&pdev->dev,
> +               sizeof(struct sdhci_pltfm_host) + priv_size);
>
>         if (IS_ERR(host)) {
>                 ret = PTR_ERR(host);
> --
> 1.9.1
>
