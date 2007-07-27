Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C886DDE21
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 18:13:11 +1000 (EST)
In-Reply-To: <20070726135738.GB5643@localhost.localdomain>
References: <20070726135738.GB5643@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7BACDD73-9097-4139-8331-A1A14A6134D0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Date: Fri, 27 Jul 2007 03:14:06 -0500
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 26, 2007, at 8:57 AM, Anton Vorontsov wrote:

> mmc_spi already tested to work. When it will hit mainline
> the only change that would be needed is replacing "spidev"
> by "mmc_spi", and adding trivial platform data to mmc_spi
> driver.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/boot/dts/mpc832x_rdb.dts     |   33 ++++++++++++++++++ 
> ++-
>  arch/powerpc/platforms/83xx/mpc832x_rdb.c |   46 ++++++++++++++++++ 
> +++++++++++
>  2 files changed, 78 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/ 
> boot/dts/mpc832x_rdb.dts
> index 7c4beff..5dcbdd3 100644
> --- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
> @@ -183,6 +183,21 @@
>  					1  c  1  0  1  0 	/* TX_EN */
>  					1  d  2  0  1  0>;      /* CRS */
>  			};
> +			spi1pio:spi_pin@01 {
> +				pio-map = <
> +			/* port  pin  dir  open_drain  assignment  has_irq    */
> +					3  0  3  0  1  0	/* SPI1 MOSI, I/O */
> +					3  1  3  0  1  0	/* SPI1 MISO, I/O */
> +					3  2  3  0  1  0	/* SPI1 CLK,  I/O */
> +					3  3  2  0  1  0>;	/* SPI1 SEL,  I   */
> +			};
> +			mmc1pio:mmc_pin@01 {
> +				pio-map = <
> +			/* port  pin  dir  open_drain  assignment  has_irq    */
> +					3  d  1  0  0  0	/* !SD_CS     */
> +					3  e  2  0  0  0	/* SD_INSERT  */
> +					3  f  2  0  0  0>;	/* SD_PROTECT */
> +			};
>  		};
>  	};
>
> @@ -207,20 +222,36 @@
>
>  		spi@4c0 {
>  			device_type = "spi";
> +			device-id = <1>;

Can we just use the reg value for bus_num in the kernel.

>  			compatible = "fsl_spi";
>  			reg = <4c0 40>;
>  			interrupts = <2>;
>  			interrupt-parent = <&qeic>;
> -			mode = "cpu";
> +			mode = "qe";
> +			sysclk = <5f5e100>; /* 100000000 Hz */

we don't need this in the spi node, its just the system clock  
frequency which we can get other ways.

> +			max-chipselect = <1>;

I'm not sure how I feel about this in here, I'm thinking it should go.

> +			pio-handle = <&spi1pio>;
> +
> +			mmc@01 {
> +				device_type = "mmc";
> +				compatible = "mmc-spi";
> +				device-id = <1>;
> +				max-speed-hz = <bebc20>; /* 12500000 Hz */
> +				chip-select = <0>;
> +				pio-handle = <&mmc1pio>;
> +			};

we should do this in board code and not the device tree.

>  		};
>
>  		spi@500 {
>  			device_type = "spi";
> +			device-id = <2>;
>  			compatible = "fsl_spi";
>  			reg = <500 40>;
>  			interrupts = <1>;
>  			interrupt-parent = <&qeic>;
>  			mode = "cpu";
> +			sysclk = <5f5e100>; /* 100000000 Hz */
> +			max_chipselect = <1>;
>  		};
>
>  		ucc@3000 {
> diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/ 
> powerpc/platforms/83xx/mpc832x_rdb.c
> index b2b28a4..c5463c7 100644
> --- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
> +++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
> @@ -15,6 +15,7 @@
>   */
>
>  #include <linux/pci.h>
> +#include <linux/spi/spi.h>
>
>  #include <asm/of_platform.h>
>  #include <asm/time.h>
> @@ -24,6 +25,7 @@
>  #include <asm/qe_ic.h>
>
>  #include "mpc83xx.h"
> +#include "../../sysdev/fsl_soc.h"
>
>  #undef DEBUG
>  #ifdef DEBUG
> @@ -32,6 +34,43 @@
>  #define DBG(fmt...)
>  #endif
>
> +extern int par_io_data_set(u8 port, u8 pin, u8 val);
> +
> +static void mpc83xx_spi_activate_cs(u8 cs, u8 polarity)
> +{
> +	pr_debug("%s %d %d\n", __func__, cs, polarity);
> +	par_io_data_set(3, 13, polarity);
> +}
> +
> +static void mpc83xx_spi_deactivate_cs(u8 cs, u8 polarity)
> +{
> +	pr_debug("%s %d %d\n", __func__, cs, polarity);
> +	par_io_data_set(3, 13, !polarity);
> +}
> +
> +static int __init mpc83xx_spi_devices_init(void)
> +{
> +	struct spi_board_info spi_bi = {
> +		.bus_num = 1,
> +		/*
> +		 * XXX: This is spidev (spi in userspace) stub, should
> +		 * be replaced by "mmc_spi" when mmc_spi will hit mainline.
> +		 */
> +		.modalias = "spidev",
> +	};
> +	struct device_node *np = NULL;
> +
> +	np = of_find_compatible_node(np, "mmc", "mmc-spi");
> +	if (!np)
> +		return 0;
> +
> +	spi_bi.max_speed_hz = *((u32 *)of_get_property(np, "max-speed- 
> hz", NULL));
> +	spi_bi.chip_select = *((u32 *)of_get_property(np, "chip-select",  
> NULL));
> +
> +	return spi_register_board_info(&spi_bi, 1);
> +}
> +device_initcall(mpc83xx_spi_devices_init);
> +
>  /*  
> ********************************************************************** 
> **
>   *
>   * Setup the architecture
> @@ -62,8 +101,15 @@ static void __init mpc832x_rdb_setup_arch(void)
>
>  		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
>  			par_io_of_config(np);
> +		for (np = NULL; (np = of_find_node_by_name(np, "spi")) != NULL;)
> +			par_io_of_config(np);
> +		for (np = NULL; (np = of_find_node_by_name(np, "mmc")) != NULL;)
> +			par_io_of_config(np);
>  	}
>  #endif				/* CONFIG_QUICC_ENGINE */
> +
> +	fsl_spi_activate_cs = mpc83xx_spi_activate_cs;
> +	fsl_spi_deactivate_cs = mpc83xx_spi_deactivate_cs;
>  }
>
>  static struct of_device_id mpc832x_ids[] = {
> -- 
> 1.5.0.6
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
