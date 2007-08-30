Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AD60BDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 07:06:56 +1000 (EST)
Message-ID: <46D73166.6080103@freescale.com>
Date: Thu, 30 Aug 2007 16:06:46 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1
	in	QE, register mmc_spi stub
References: <20070823113349.GA11870@localhost.localdomain>
	<20070823113600.GC18080@localhost.localdomain>
In-Reply-To: <20070823113600.GC18080@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> +static int __init mpc832x_spi_init(void)
> +{
> +	if (!machine_is(mpc832x_rdb))
> +		return 0;
> +
> +	par_io_config_pin(3,  0, 3, 0, 1, 0); /* SPI1 MOSI, I/O */
> +	par_io_config_pin(3,  1, 3, 0, 1, 0); /* SPI1 MISO, I/O */
> +	par_io_config_pin(3,  2, 3, 0, 1, 0); /* SPI1 CLK,  I/O */
> +	par_io_config_pin(3,  3, 2, 0, 1, 0); /* SPI1 SEL,  I   */
> +
> +	par_io_config_pin(3, 13, 1, 0, 0, 0); /* !SD_CS,    O */
> +	par_io_config_pin(3, 14, 2, 0, 0, 0); /* SD_INSERT, I */
> +	par_io_config_pin(3, 15, 2, 0, 0, 0); /* SD_PROTECT,I */

Why are you doing this here, and not in the device tree?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
