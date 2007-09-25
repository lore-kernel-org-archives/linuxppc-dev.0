Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64DEBDDEF4
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 01:04:53 +1000 (EST)
In-Reply-To: <20070925143531.GG5323@localhost.localdomain>
References: <20070925143126.GA30013@localhost.localdomain>
	<20070925143531.GG5323@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <16E78F0E-B57B-4084-887E-5D2F9C1D0331@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] [PATCH 7/7] [POWERPC][SPI] spi_mpc83xx: allow
	use on MPC85xx
Date: Tue, 25 Sep 2007 10:04:41 -0500
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 25, 2007, at 9:35 AM, Anton Vorontsov wrote:

> MPC85xx's QE SPI controller is almost the same comparing to MPC83xx.
> Thus lets use that driver. Tested to work in loopback mode.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/spi/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index b915711..14f0d0d 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -125,7 +125,7 @@ config SPI_MPC52xx_PSC
>
>  config SPI_MPC83xx
>  	tristate "Freescale MPC83xx SPI controller"
> -	depends on SPI_MASTER && PPC_83xx && EXPERIMENTAL
> +	depends on SPI_MASTER && (PPC_83xx || PPC_85xx) && EXPERIMENTAL
>  	select SPI_BITBANG
>  	help
>  	  This enables using the Freescale MPC83xx SPI controller in master

Should that really be just PPC_83xx || QUICC_ENGINE?

- k
