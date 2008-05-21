Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id DF63ADE06D
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 01:56:17 +1000 (EST)
Date: Wed, 21 May 2008 17:56:33 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/4] [OF] spi_of: add support for dedicated SPI
	constructors
In-Reply-To: <20080521154139.GB4566@polina.dev.rtsoft.ru>
Message-ID: <Pine.LNX.4.64.0805211754300.5386@axis700.grange>
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
	<20080521154139.GB4566@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 21 May 2008, Anton Vorontsov wrote:

> Dedicated (usually the ones that need to fill platform data) constructors
> will create board info, so SPI core will probe them as normal SPI devices.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/spi/spi_of.c       |   67 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/spi/spi_of.h |    5 +++
>  2 files changed, 72 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi_of.c b/drivers/spi/spi_of.c
> index b5ae434..2e1a11f 100644
> --- a/drivers/spi/spi_of.c
> +++ b/drivers/spi/spi_of.c
> @@ -11,6 +11,66 @@
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi_of.h>
>  
> +/*
> + * Caller have no idea who is master, i.e. this function does not
> + * accept pointer to the master, instead we use board infos.
> + */
> +int of_spi_device_probe_common(struct device_node *np,
> +			       struct spi_board_info *spi_binfo,
> +			       const char *modalias)
> +{

Hm, I might well misunderstand something here, but it looks to me like you 
are again trying to use both OF _and_ platform (spi_board_info) bindings 
for your SPI setup? And this is exactly what we are trying to avoid in 
Grant's series of patches...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
