Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
	[209.85.210.42]) by ozlabs.org (Postfix) with ESMTP id D3A3CB6F04
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 10:28:16 +1000 (EST)
Received: by pzk30 with SMTP id 30so1299286pzk.15
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Jul 2010 17:28:15 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Sun, 25 Jul 2010 18:28:13 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Mingkai Hu <Mingkai.hu@freescale.com>
Subject: Re: [PATCH 3/6] of/spi: add support to parse the SPI flash's
	partitions
Message-ID: <20100726002813.GB25419@angua.secretlab.ca>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-3-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-4-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279591705-7574-4-git-send-email-Mingkai.hu@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 20, 2010 at 10:08:22AM +0800, Mingkai Hu wrote:
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> ---
>  drivers/of/of_spi.c       |   11 +++++++++++
>  drivers/spi/spi_mpc8xxx.c |    1 +
>  2 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/of/of_spi.c b/drivers/of/of_spi.c
> index 5fed7e3..284ca0e 100644
> --- a/drivers/of/of_spi.c
> +++ b/drivers/of/of_spi.c
> @@ -10,6 +10,8 @@
>  #include <linux/device.h>
>  #include <linux/spi/spi.h>
>  #include <linux/of_spi.h>
> +#include <linux/spi/flash.h>
> +#include <linux/mtd/partitions.h>
>  
>  /**
>   * of_register_spi_devices - Register child devices onto the SPI bus
> @@ -26,6 +28,7 @@ void of_register_spi_devices(struct spi_master *master, struct device_node *np)
>  	const __be32 *prop;
>  	int rc;
>  	int len;
> +	struct flash_platform_data *pdata;
>  
>  	for_each_child_of_node(np, nc) {
>  		/* Alloc an spi_device */
> @@ -81,6 +84,14 @@ void of_register_spi_devices(struct spi_master *master, struct device_node *np)
>  		of_node_get(nc);
>  		spi->dev.of_node = nc;
>  
> +		/* Parse the mtd partitions */
> +		pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
> +		if (!pdata)
> +			return;
> +		pdata->nr_parts = of_mtd_parse_partitions(&master->dev,
> +				nc, &pdata->parts);
> +		spi->dev.platform_data = pdata;
> +

Nack.  Not all spi devices are mtd devices.  In fact, most are not.

The spi driver itself should call the of_mtd_parse_partitions code to get the partition map.  Do not use pdata in this case.

>  		/* Register the new device */
>  		request_module(spi->modalias);
>  		rc = spi_add_device(spi);
> diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
> index efed70e..0fadaeb 100644
> --- a/drivers/spi/spi_mpc8xxx.c
> +++ b/drivers/spi/spi_mpc8xxx.c
> @@ -137,6 +137,7 @@ int mpc8xxx_spi_transfer(struct spi_device *spi,
>  
>  void mpc8xxx_spi_cleanup(struct spi_device *spi)
>  {
> +	kfree(spi->dev.platform_data);

Irrelevant given the above comment, but how does this even work?  What if a driver was detached and reattached to an spi_device?  The platform_data would be freed.  Not to mention that the pointer isn't cleared, so the driver would have no idea that it has a freed pointer.

>  	kfree(spi->controller_state);
>  }
>  
> -- 
> 1.6.4
> 
> 
