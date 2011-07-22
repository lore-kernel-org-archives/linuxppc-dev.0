Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A5319B6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 20:15:22 +1000 (EST)
Received: by wwj40 with SMTP id 40so1675395wwj.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 03:15:17 -0700 (PDT)
Date: Fri, 22 Jul 2011 14:15:12 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH 2/2 v2] eSDHC: Fix errors when booting kernel with fsl
	esdhc
Message-ID: <20110722101512.GA1576@oksana.dev.rtsoft.ru>
References: <1311329717-13954-1-git-send-email-tie-fei.zang@freescale.com>
	<1311329717-13954-2-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1311329717-13954-2-git-send-email-tie-fei.zang@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
	linux-mmc@vger.kernel.org, Xu lei <B33228@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 22, 2011 at 06:15:17PM +0800, Roy Zang wrote:
[...]
>  	if (host->version >= SDHCI_SPEC_200) {
> -		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> -		ctrl &= ~SDHCI_CTRL_DMA_MASK;
> -		if ((host->flags & SDHCI_REQ_USE_DMA) &&
> -			(host->flags & SDHCI_USE_ADMA))
> -			ctrl |= SDHCI_CTRL_ADMA32;
> -		else
> -			ctrl |= SDHCI_CTRL_SDMA;
> -		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +		if (host->quirks & SDHCI_QUIRK_QORIQ_PROCTL_WEIRD) {
> +#define ESDHCI_PROCTL_DMAS_MASK		0x00000300
> +#define ESDHCI_PROCTL_ADMA32		0x00000200
> +#define ESDHCI_PROCTL_SDMA		0x00000000
> +			ctrl = sdhci_readl(host, SDHCI_HOST_CONTROL);
> +			ctrl &= ~ESDHCI_PROCTL_DMAS_MASK;
> +			if ((host->flags & SDHCI_REQ_USE_DMA) &&
> +				(host->flags & SDHCI_USE_ADMA))
> +				ctrl |= ESDHCI_PROCTL_ADMA32;
> +			else
> +				ctrl |= ESDHCI_PROCTL_SDMA;
> +			sdhci_writel(host, ctrl, SDHCI_HOST_CONTROL);
> +		} else {
> +			ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +			ctrl &= ~SDHCI_CTRL_DMA_MASK;
> +			if ((host->flags & SDHCI_REQ_USE_DMA) &&
> +				(host->flags & SDHCI_USE_ADMA))
> +				ctrl |= SDHCI_CTRL_ADMA32;
> +			else
> +				ctrl |= SDHCI_CTRL_SDMA;
> +			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);

We try to not pollute generic sdhci.c driver with chip-specific
quirks.

Maybe you can do the fixups via IO accessors? Or by introducing
some additional sdhci op?

[...]
>  	if (power != (unsigned short)-1) {
>  		switch (1 << power) {
> +#define	ESDHCI_FSL_POWER_MASK	0x40
> +#define	ESDHCI_FSL_POWER_180	0x00
> +#define	ESDHCI_FSL_POWER_300	0x40

Same here. The driver will rot quickly if everyone would start
putting chip-specific quirks into sdhci.c. Please don't.

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
