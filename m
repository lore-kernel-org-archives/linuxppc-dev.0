Return-Path: <computersforpeace@gmail.com>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7D8A014008E
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2014 16:48:06 +1000 (EST)
Received: by mail-pa0-f50.google.com with SMTP id kq14so10610382pab.9
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2014 23:48:04 -0700 (PDT)
Date: Tue, 15 Apr 2014 23:48:00 -0700
From: Brian Norris <computersforpeace@gmail.com>
To: Hou Zhiqiang <B48286@freescale.com>
Subject: Re: [PATCH] mtd: m25p80: Modify the name of mtd_info
Message-ID: <20140416064800.GO3131@norris-Latitude-E6410>
References: <1395400578-5637-1-git-send-email-B48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395400578-5637-1-git-send-email-B48286@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, mingkai.hu@freescale.com,
 linux-mtd@lists.infradead.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 21, 2014 at 07:16:18PM +0800, Hou Zhiqiang wrote:
> To specify spi flash layouts by "mtdparts=..." in cmdline, we must
> give mtd_info a fixed name,because the cmdlinepart's parser will
> match the name of mtd_info given in cmdline.
> Now, if use DT, the mtd_info's name will be spi->dev->name. It
> consists of spi_master->bus_num, and the spi_master->bus_num maybe
> dynamically fetched. So, in this case, replace the component bus_num
> with thei physical address of spi master.
> 
> Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> ---
>  drivers/mtd/devices/m25p80.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 7eda71d..64450a2 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -30,6 +30,7 @@
>  #include <linux/mtd/cfi.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> +#include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  
>  #include <linux/spi/spi.h>
> @@ -934,9 +935,11 @@ static int m25p_probe(struct spi_device *spi)
>  	struct flash_platform_data	*data;
>  	struct m25p			*flash;
>  	struct flash_info		*info;
> -	unsigned			i;
> +	unsigned			i, ret;
>  	struct mtd_part_parser_data	ppdata;
>  	struct device_node *np = spi->dev.of_node;
> +	struct resource res;
> +	struct device_node *mnp = spi->master->dev.of_node;
>  
>  	/* Platform data helps sort out which chip type we have, as
>  	 * well as how this board partitions it.  If we don't have
> @@ -1009,8 +1012,17 @@ static int m25p_probe(struct spi_device *spi)
>  
>  	if (data && data->name)
>  		flash->mtd.name = data->name;
> -	else
> -		flash->mtd.name = dev_name(&spi->dev);
> +	else{
> +		ret = of_address_to_resource(mnp, 0, &res);

You're making a lot assumptions about the SPI master/device
relationship -- that the master has a device-node; that the first
resource of the master is its physical address (this is not guaranteed
by DT semantics). Please do not do this.

> +		if (ret) {
> +			dev_err(&spi->dev, "failed to get spi master resource\n");
> +			return ret;

This is wrong. It breaks all !CONFIG_OF cases which didn't specify a
name via platform data.

> +		}
> +		flash->mtd.name = kasprintf(GFP_KERNEL, "spi%x.%d",
> +				(unsigned)res.start, spi->chip_select);
> +		if (!flash->mtd.name)
> +			return -ENOMEM;
> +	}
>  
>  	flash->mtd.type = MTD_NORFLASH;
>  	flash->mtd.writesize = 1;

Brian
