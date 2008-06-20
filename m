Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C0FEDDDED6
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 22:28:23 +1000 (EST)
Date: Fri, 20 Jun 2008 16:28:20 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Chen Gong <g.chen@freescale.com>
Subject: Re: [PATCH] fix mpc83xx spi prescale modulus calculate
Message-ID: <20080620122820.GA24187@polina.dev.rtsoft.ru>
References: <1213954697-8569-1-git-send-email-g.chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1213954697-8569-1-git-send-email-g.chen@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 20, 2008 at 05:38:17PM +0800, Chen Gong wrote:
> Signed-off-by: Chen Gong <g.chen@freescale.com>

The patch lacks any description. E.g. at which frequencies the current
math breaks, and why?

> ---
>  drivers/spi/spi_mpc83xx.c |   29 ++++++++++++++++-------------
>  1 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
> index 6832da6..070c621 100644
> --- a/drivers/spi/spi_mpc83xx.c
> +++ b/drivers/spi/spi_mpc83xx.c
> @@ -266,21 +266,24 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
>  
>  	cs->hw_mode |= SPMODE_LEN(bits_per_word);
>  
> -	if ((mpc83xx_spi->spibrg / hz) >= 64) {
> -		pm = mpc83xx_spi->spibrg / (hz * 64) - 1;
> -		if (pm > 0x0f) {
> -			dev_err(&spi->dev, "Requested speed is too "
> -				"low: %d Hz. Will use %d Hz instead.\n",
> -				hz, mpc83xx_spi->spibrg / 1024);
> -			pm = 0x0f;
> +	if ((mpc83xx_spi->spibrg / hz) > 64) {
> +		pm = mpc83xx_spi->spibrg / (hz * 64);
> +		if (pm > 16) {

Suppose this didn't happen. So we calculated:
pm = mpc83xx_spi->spibrg / (hz * 64);
And we didn't set any hw flag.

> +			cs->hw_mode |= SPMODE_DIV16;
> +			pm /= 16;
> +			if (pm > 16) {
> +				dev_err(&spi->dev, "Requested speed is too "
> +					"low: %d Hz. Will use %d Hz instead.\n",
> +					hz, mpc83xx_spi->spibrg / 1024);
> +				pm = 16;
> +			}
>  		}
> -		cs->hw_mode |= SPMODE_PM(pm) | SPMODE_DIV16;
> -	} else {
> +	} else
>  		pm = mpc83xx_spi->spibrg / (hz * 4);

Now suppose this did happen. So we calculated:
pm = mpc83xx_spi->spibrg / (hz * 4);
And we didn't set any hw flag either.

So, we used two different formulas with the same hw flags.

Maybe I'm missing something, but this looks quite wrong.

> -		if (pm)
> -			pm--;
> -		cs->hw_mode |= SPMODE_PM(pm);
> -	}
> +	if (pm)
> +		pm--;
> +
> +	cs->hw_mode |= SPMODE_PM(pm);
>  	regval =  mpc83xx_spi_read_reg(&mpc83xx_spi->base->mode);
>  	if (cs->hw_mode != regval) {
>  		unsigned long flags;
> -- 
> 1.5.4

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
