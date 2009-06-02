Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 244B0DDE05
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jun 2009 03:26:46 +1000 (EST)
Date: Tue, 2 Jun 2009 21:26:44 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Dave Liu <daveliu@freescale.com>
Subject: Re: [PATCH] mmc: Fix the wrong accessor to HOSTVER register
Message-ID: <20090602172644.GA26721@oksana.dev.rtsoft.ru>
References: <1241606407-18685-1-git-send-email-daveliu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1241606407-18685-1-git-send-email-daveliu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, pierre@ossman.eu, sdhci-devel@list.drzeus.cx,
	ben-linux@fluff.org, drzeus-sdhci@drzeus.cx
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 06, 2009 at 06:40:07PM +0800, Dave Liu wrote:
> Freescale eSDHC controller has the special order for
> the HOST version register. that is not same as the other's
> registers. The address of HOSTVER in spec is 0xFE, and
> we need use the in_be16(0xFE) to access it, not in_be16(0xFC).
> 
> Signed-off-by: Dave Liu <daveliu@freescale.com>

Sorry for the delay Dave. This patch is surely

Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>

> ---
>  drivers/mmc/host/sdhci-of.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
> index 3ff4ac3..e167131 100644
> --- a/drivers/mmc/host/sdhci-of.c
> +++ b/drivers/mmc/host/sdhci-of.c
> @@ -55,7 +55,13 @@ static u32 esdhc_readl(struct sdhci_host *host, int reg)
>  
>  static u16 esdhc_readw(struct sdhci_host *host, int reg)
>  {
> -	return in_be16(host->ioaddr + (reg ^ 0x2));
> +	u16 ret;
> +
> +	if (unlikely(reg == SDHCI_HOST_VERSION))
> +		ret = in_be16(host->ioaddr + reg);
> +	else
> +		ret = in_be16(host->ioaddr + (reg ^ 0x2));
> +	return ret;
>  }
>  
>  static u8 esdhc_readb(struct sdhci_host *host, int reg)
> -- 
> 1.5.4

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
