Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A25EDDDF18
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 06:39:42 +1000 (EST)
Message-Id: <7C711FFF-E1C5-4286-93A8-382055C6760C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Roel Kluin <12o3l@tiscali.nl>
In-Reply-To: <480F99D5.7070300@tiscali.nl>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] spi_mpc83xx: test below 0 on unsigned irq in
	mpc83xx_spi_probe()
Date: Wed, 23 Apr 2008 15:39:32 -0500
References: <480F99D5.7070300@tiscali.nl>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	lkml <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 23, 2008, at 3:19 PM, Roel Kluin wrote:
> mpc83xx_spi->irq is unsigned, so the test fails
>
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>

you should copy the linux-spi list on such patches.

- k

>
> ---
> diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
> index be15a62..033fd51 100644
> --- a/drivers/spi/spi_mpc83xx.c
> +++ b/drivers/spi/spi_mpc83xx.c
> @@ -454,12 +454,12 @@ static int __init mpc83xx_spi_probe(struct  
> platform_device *dev)
> 		goto put_master;
> 	}
>
> -	mpc83xx_spi->irq = platform_get_irq(dev, 0);
> -
> -	if (mpc83xx_spi->irq < 0) {
> -		ret = -ENXIO;
> +	ret = platform_get_irq(dev, 0);
> +	if (ret < 0)
> 		goto unmap_io;
> -	}
> +
> +	mpc83xx_spi->irq = ret;
> +	ret = 0;
>
> 	/* Register for SPI Interrupt */
> 	ret = request_irq(mpc83xx_spi->irq, mpc83xx_spi_irq,
