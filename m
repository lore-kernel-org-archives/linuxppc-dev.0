Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id F377BB7B99
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 21:52:54 +1000 (EST)
Date: Wed, 23 Sep 2009 15:52:52 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Gao Guanhua <B22826@freescale.com>
Subject: Re: [PATCH 1/6] sdhci: Enable cache snooping
Message-ID: <20090923115252.GA6425@oksana.dev.rtsoft.ru>
References: <1253696892-15262-1-git-send-email-B22826@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1253696892-15262-1-git-send-email-B22826@freescale.com>
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

On Wed, Sep 23, 2009 at 05:08:07PM +0800, Gao Guanhua wrote:
> This patch enable cache snooping when the sdhc is initialized.
> ---
>  drivers/mmc/host/sdhci.c |    3 +++
>  drivers/mmc/host/sdhci.h |    4 ++++
>  2 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 288e40b..cc6d45c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -178,6 +178,9 @@ static void sdhci_init(struct sdhci_host *host)
>  {
>  	sdhci_reset(host, SDHCI_RESET_ALL);
>  
> +	/* Enable cache snooping */
> +	sdhci_writel(host, SDHCI_CACHE_SNOOP, SDHCI_HOST_DMA_CONTROL);
> +
>  	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
>  		SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
>  		SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_INDEX |
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index afda7f1..9ee9622 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -176,6 +176,10 @@
>  #define   SDHCI_SPEC_100	0
>  #define   SDHCI_SPEC_200	1
>  
> +/* 40C DMA control register*/
> +#define SDHCI_HOST_DMA_CONTROL	0x40C

SDHCI Specification doesn't mention this register, it isn't standard.
Plus, we have this register and bit set already in sdhci-of.c:

static int esdhc_enable_dma(struct sdhci_host *host)
{
        setbits32(host->ioaddr + ESDHC_DMA_SYSCTL, ESDHC_DMA_SNOOP);
        return 0;
}

Do p2020 need this bit set for PIO mode too?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
