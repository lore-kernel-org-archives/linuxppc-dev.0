Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E86AEDDE1E
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 08:46:54 +1000 (EST)
Date: Wed, 7 May 2008 15:46:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: [PATCH 1/2] spi_mpc83xx: test below 0 on unsigned irq in
	mpc83xx_spi_probe()
Message-Id: <20080507154641.83a09a06.akpm@linux-foundation.org>
In-Reply-To: <480FA234.1000601@tiscali.nl>
References: <480FA234.1000601@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 23 Apr 2008 22:55:16 +0200
Roel Kluin <12o3l@tiscali.nl> wrote:

> mpc83xx_spi->irq is unsigned, so the test fails
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> ---
> diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
> index be15a62..033fd51 100644
> --- a/drivers/spi/spi_mpc83xx.c
> +++ b/drivers/spi/spi_mpc83xx.c
> @@ -454,12 +454,12 @@ static int __init mpc83xx_spi_probe(struct platform_device *dev)
>  		goto put_master;
>  	}
>  
> -	mpc83xx_spi->irq = platform_get_irq(dev, 0);
> -
> -	if (mpc83xx_spi->irq < 0) {
> -		ret = -ENXIO;
> +	ret = platform_get_irq(dev, 0);
> +	if (ret < 0)
>  		goto unmap_io;
> -	}
> +
> +	mpc83xx_spi->irq = ret;
> +	ret = 0;
>  
>  	/* Register for SPI Interrupt */
>  	ret = request_irq(mpc83xx_spi->irq, mpc83xx_spi_irq,
> 

In the recently-merged spi_mpc83xx-much-improved-driver.patch, mpc83xx_spi.irq
has type `int' so I don't think we need this fix any more.
