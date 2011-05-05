Return-Path: <cbouatmailru@gmail.com>
Date: Thu, 5 May 2011 18:23:44 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 3/7] mmc: sdhci: make sdhci-of device drivers self
	registered
Message-ID: <20110505142344.GA13400@oksana.dev.rtsoft.ru>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-4-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1304601778-13837-4-git-send-email-shawn.guo@linaro.org>
Cc: sameo@linux.intel.com, Arnd Bergmann <arnd@arndb.de>, patches@linaro.org,
	devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org,
	Saeed Bishara <saeed@marvell.com>,
	Xiaobo Xie <X.Xie@freescale.com>, kernel@pengutronix.de,
	Mike Rapoport <mike@compulab.co.il>,
	Olof Johansson <olof@lixom.net>, Chris Ball <cjb@laptop.org>,
	linuxppc-dev@lists.ozlabs.org, Albert Herranz <albert_herranz@yahoo.es>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 05, 2011 at 09:22:54PM +0800, Shawn Guo wrote:
[...]
> - * Copyright (c) 2007 Freescale Semiconductor, Inc.
> - * Copyright (c) 2009 MontaVista Software, Inc.
> - *
> - * Authors: Xiaobo Xie <X.Xie@freescale.com>
> - *	    Anton Vorontsov <avorontsov@ru.mvista.com>
[...]
> -#ifdef CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
> -
> -/*
> - * These accessors are designed for big endian hosts doing I/O to
> - * little endian controllers incorporating a 32-bit hardware byte swapper.
> - */
> -
> -u32 sdhci_be32bs_readl(struct sdhci_host *host, int reg)
> -{
> -	return in_be32(host->ioaddr + reg);
> -}
> -
> -u16 sdhci_be32bs_readw(struct sdhci_host *host, int reg)
> -{
> -	return in_be16(host->ioaddr + (reg ^ 0x2));
> -}
> -
> -u8 sdhci_be32bs_readb(struct sdhci_host *host, int reg)
> -{
> -	return in_8(host->ioaddr + (reg ^ 0x3));
> -}
> -
> -void sdhci_be32bs_writel(struct sdhci_host *host, u32 val, int reg)
> -{
> -	out_be32(host->ioaddr + reg, val);
> -}
> -
> -void sdhci_be32bs_writew(struct sdhci_host *host, u16 val, int reg)
> -{
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	int base = reg & ~0x3;
> -	int shift = (reg & 0x2) * 8;
> -
> -	switch (reg) {
> -	case SDHCI_TRANSFER_MODE:
> -		/*
> -		 * Postpone this write, we must do it together with a
> -		 * command write that is down below.
> -		 */
> -		pltfm_host->xfer_mode_shadow = val;
> -		return;
> -	case SDHCI_COMMAND:
> -		sdhci_be32bs_writel(host, val << 16 | pltfm_host->xfer_mode_shadow,
> -				    SDHCI_TRANSFER_MODE);
> -		return;
> -	}
> -	clrsetbits_be32(host->ioaddr + base, 0xffff << shift, val << shift);
> -}
> -
> -void sdhci_be32bs_writeb(struct sdhci_host *host, u8 val, int reg)
> -{
> -	int base = reg & ~0x3;
> -	int shift = (reg & 0x3) * 8;
> -
> -	clrsetbits_be32(host->ioaddr + base , 0xff << shift, val << shift);
> -}
> -#endif /* CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER */
[...]
> +#ifdef CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
> +/*
> + * These accessors are designed for big endian hosts doing I/O to
> + * little endian controllers incorporating a 32-bit hardware byte swapper.
> + */
> +u32 sdhci_be32bs_readl(struct sdhci_host *host, int reg)
> +{
> +	return in_be32(host->ioaddr + reg);
> +}
> +
> +u16 sdhci_be32bs_readw(struct sdhci_host *host, int reg)
> +{
> +	return in_be16(host->ioaddr + (reg ^ 0x2));
> +}
> +
> +u8 sdhci_be32bs_readb(struct sdhci_host *host, int reg)
> +{
> +	return in_8(host->ioaddr + (reg ^ 0x3));
> +}
> +
> +void sdhci_be32bs_writel(struct sdhci_host *host, u32 val, int reg)
> +{
> +	out_be32(host->ioaddr + reg, val);
> +}
> +
> +void sdhci_be32bs_writew(struct sdhci_host *host, u16 val, int reg)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	int base = reg & ~0x3;
> +	int shift = (reg & 0x2) * 8;
> +
> +	switch (reg) {
> +	case SDHCI_TRANSFER_MODE:
> +		/*
> +		 * Postpone this write, we must do it together with a
> +		 * command write that is down below.
> +		 */
> +		pltfm_host->xfer_mode_shadow = val;
> +		return;
> +	case SDHCI_COMMAND:
> +		sdhci_be32bs_writel(host, val << 16 | pltfm_host->xfer_mode_shadow,
> +				    SDHCI_TRANSFER_MODE);
> +		return;
> +	}
> +	clrsetbits_be32(host->ioaddr + base, 0xffff << shift, val << shift);
> +}
> +
> +void sdhci_be32bs_writeb(struct sdhci_host *host, u8 val, int reg)
> +{
> +	int base = reg & ~0x3;
> +	int shift = (reg & 0x3) * 8;
> +
> +	clrsetbits_be32(host->ioaddr + base , 0xff << shift, val << shift);
> +}
> +#endif /* CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER */

I noticed you're very careful wrt copyright/authorship notices,
except for this case. How about retaining copyright stuff when
you merge these two files?

The patch itself looks great though.

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
