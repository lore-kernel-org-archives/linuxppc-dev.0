Return-Path: <baruch@tkos.co.il>
Received: from mx.tkos.co.il (guitar.tcltek.co.il [192.115.133.116])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DA37F140089
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 19:49:23 +1100 (EST)
Date: Tue, 1 Apr 2014 11:42:56 +0300
From: Baruch Siach <baruch@tkos.co.il>
To: Zhao Qiang <B45475@freescale.com>
Subject: Re: [PATCH] spi: add "spi-lsb-first" to devicetree
Message-ID: <20140401084256.GV4579@tarshish>
References: <1396338931-10887-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396338931-10887-1-git-send-email-B45475@freescale.com>
Cc: B07421@freescale.com, devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
 broonie@kernel.org, R63061@freescale.com, linuxppc-dev@lists.ozlabs.org,
 wangyuhang2014@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Zhao Qiang,

On Tue, Apr 01, 2014 at 03:55:31PM +0800, Zhao Qiang wrote:
> add optional property devicetree for SPI slave nodes
> into devicetree so that LSB mode can be enabled by devicetree.
> 
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-bus.txt | 4 ++++
>  drivers/spi/spi.c                                 | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> index e5a4d1b..fdd9f15 100644
> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> @@ -55,11 +55,15 @@ contain the following properties.
>      		chip select active high
>  - spi-3wire       - (optional) Empty property indicating device requires
>      		    3-wire mode.
> +- spi-lsb-first   - (optional) Empty property indicating device requires
> +		LSB first mode.
>  - spi-tx-bus-width - (optional) The bus width(number of data wires) that
>                        used for MOSI. Defaults to 1 if not present.
>  - spi-rx-bus-width - (optional) The bus width(number of data wires) that
>                        used for MISO. Defaults to 1 if not present.
>  
> +- spi-rx-bus-width - (optional) The bus width(number of data wires) that
> +                      used for MISO. Defaults to 1 if not present.

Is this part intentionally here? It is not mentioned in the commit log, and 
seems to merit a separate patch.

baruch

>  Some SPI controllers and devices support Dual and Quad SPI transfer mode.
>  It allows data in SPI system transfered in 2 wires(DUAL) or 4 wires(QUAD).
>  Now the value that spi-tx-bus-width and spi-rx-bus-width can receive is
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 23756b0..0a20a90 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1050,6 +1050,8 @@ static void of_register_spi_devices(struct spi_master *master)
>  			spi->mode |= SPI_CS_HIGH;
>  		if (of_find_property(nc, "spi-3wire", NULL))
>  			spi->mode |= SPI_3WIRE;
> +		if (of_find_property(nc, "spi-lsb-first", NULL))
> +			spi->mode |= SPI_LSB_FIRST;
>  
>  		/* Device DUAL/QUAD mode */
>  		if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
