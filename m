Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id F31DCDDF47
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 01:36:33 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Anton Vorontsov'" <avorontsov@ru.mvista.com>, <linuxppc-dev@ozlabs.org>
Subject: RE: [RFC][PATCH] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Date: Thu, 26 Jul 2007 17:36:06 +0200
Message-ID: <02aa01c7cf9a$aebf3bf0$02ac10ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20070726135738.GB5643@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 

> -----Original Message-----
> From: 
> linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozlabs.org 
> [mailto:linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozl
> abs.org] On Behalf Of Anton Vorontsov
> Sent: den 26 juli 2007 15:58
> To: linuxppc-dev@ozlabs.org
> Subject: [RFC][PATCH] MPC832x_RDB: update dts to use spi, 
> register mmc_spi stub
> 
> mmc_spi already tested to work. When it will hit mainline
> the only change that would be needed is replacing "spidev"
> by "mmc_spi", and adding trivial platform data to mmc_spi
> driver.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/boot/dts/mpc832x_rdb.dts     |   33 
> ++++++++++++++++++++-
>  arch/powerpc/platforms/83xx/mpc832x_rdb.c |   46 
> +++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts 
> b/arch/powerpc/boot/dts/mpc832x_rdb.dts
> index 7c4beff..5dcbdd3 100644
> --- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
> @@ -183,6 +183,21 @@
>  					1  c  1  0  1  0 	
> /* TX_EN */
>  					1  d  2  0  1  0>;      
> /* CRS */
>  			};
> +			spi1pio:spi_pin@01 {
> +				pio-map = <
> +			/* port  pin  dir  open_drain  
> assignment  has_irq    */
> +					3  0  3  0  1  0	
> /* SPI1 MOSI, I/O */
> +					3  1  3  0  1  0	
> /* SPI1 MISO, I/O */
> +					3  2  3  0  1  0	
> /* SPI1 CLK,  I/O */
> +					3  3  2  0  1  0>;	
> /* SPI1 SEL,  I   */
> +			};
> +			mmc1pio:mmc_pin@01 {
> +				pio-map = <
> +			/* port  pin  dir  open_drain  
> assignment  has_irq    */
> +					3  d  1  0  0  0	
> /* !SD_CS     */
> +					3  e  2  0  0  0	
> /* SD_INSERT  */
> +					3  f  2  0  0  0>;	
> /* SD_PROTECT */
> +			};
>  		};
>  	};
>  
> @@ -207,20 +222,36 @@
>  
>  		spi@4c0 {
>  			device_type = "spi";
> +			device-id = <1>;
>  			compatible = "fsl_spi";
>  			reg = <4c0 40>;
>  			interrupts = <2>;
>  			interrupt-parent = <&qeic>;
> -			mode = "cpu";
> +			mode = "qe";

The driver is still using "cpu" mode. It just happens that the cpu mode for QE
enabled CPUs isn't 100% compatible with the defacto cpu mode used by other CPU:s.
So mode should probably be "cpu_qe" or, even better, if the drver could
autodetect that it is running on a QE enabled CPU and adjust accordinly.
Maybe the Freescale guys have some ideas how to do that.

 Jocke

PS.
   Will be on vacation for a week as of tmw, won't have access
   during this time.
