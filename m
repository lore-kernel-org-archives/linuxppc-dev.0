Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id B88C6DDF96
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 07:55:40 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>
To: "'Roel Kluin'" <12o3l@tiscali.nl>, <galak@kernel.crashing.org>,
	<linuxppc-dev@ozlabs.org>
References: <480FA234.1000601@tiscali.nl>
In-Reply-To: <480FA234.1000601@tiscali.nl>
Subject: RE: [PATCH 1/2] spi_mpc83xx: test below 0 on unsigned irq
	in	mpc83xx_spi_probe()
Date: Wed, 23 Apr 2008 23:55:11 +0200
Message-ID: <00ed01c8a58c$b4a5fa40$1df1eec0$@Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Cc: spi-devel-general@lists.sourceforge.net, dbrownell@users.sourceforge.net,
	'lkml' <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozlabs.org [mailto:linuxppc-dev-
> bounces+joakim.tjernlund=transmode.se@ozlabs.org] On Behalf Of Roel Kluin
> Sent: den 23 april 2008 22:55
> To: galak@kernel.crashing.org; linuxppc-dev@ozlabs.org
> Cc: spi-devel-general@lists.sourceforge.net; dbrownell@users.sourceforge.net; lkml
> Subject: [PATCH 1/2] spi_mpc83xx: test below 0 on unsigned irq in mpc83xx_spi_probe()
> 
> mpc83xx_spi->irq is unsigned, so the test fails
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>

hmm, I got a pretty large 83xx spi patch queued at dbrownell. I hope
that one can be applied first. Then you probably need to rediff this patch.

David, any progress on my patch?

 Jocke
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
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
