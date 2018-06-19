Return-Path: <york.sun@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0073.outbound.protection.outlook.com [104.47.2.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419D2Q0ymYzF0fX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 02:29:42 +1000 (AEST)
From: York Sun <york.sun@nxp.com>
To: "jocke@infinera.com" <joakim.tjernlund@infinera.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH] spi/fsl-espi: Add missing cell-index OF property
Date: Tue, 19 Jun 2018 16:29:35 +0000
Message-ID: <VI1PR04MB20782A7BE6789A3AE441DB359A700@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <20180619162304.20125-1-joakim.tjernlund@infinera.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim,=0A=
=0A=
I am not the maintainer for this driver. Adding Mark Brown.=0A=
=0A=
York=0A=
=0A=
On 06/19/2018 09:23 AM, Joakim Tjernlund wrote:=0A=
> espi does not look for a OF cell-index property which=0A=
> makes the bus numbering dynamic only. This add an=0A=
> optional cell-index.=0A=
> =0A=
> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>=0A=
> ---=0A=
>  drivers/spi/spi-fsl-espi.c | 8 ++++++++=0A=
>  1 file changed, 8 insertions(+)=0A=
> =0A=
> diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c=0A=
> index 1d332e23f6ed..56b71c5e2f10 100644=0A=
> --- a/drivers/spi/spi-fsl-espi.c=0A=
> +++ b/drivers/spi/spi-fsl-espi.c=0A=
> @@ -672,6 +672,14 @@ static int fsl_espi_probe(struct device *dev, struct=
 resource *mem,=0A=
>  =0A=
>  	dev_set_drvdata(dev, master);=0A=
>  =0A=
> +	if (dev->of_node) {=0A=
> +		u32 cell_index;=0A=
> +=0A=
> +		if (!of_property_read_u32(dev->of_node, "cell-index",=0A=
> +					  &cell_index))=0A=
> +			master->bus_num =3D cell_index;=0A=
> +	}=0A=
> +=0A=
>  	master->mode_bits =3D SPI_RX_DUAL | SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |=
=0A=
>  			    SPI_LSB_FIRST | SPI_LOOP;=0A=
>  	master->dev.of_node =3D dev->of_node;=0A=
> =0A=
=0A=
