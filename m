Return-Path: <B32616@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4EB3D2C009B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 13:56:35 +1000 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>
Subject: RE: [PATCH 7/7] carma: remove unnecessary DMA_INTERRUPT capability
Date: Wed, 1 Aug 2012 03:56:24 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB70C6273@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1343778352-5549-1-git-send-email-iws@ovro.caltech.edu>
 <1343778352-5549-8-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1343778352-5549-8-git-send-email-iws@ovro.caltech.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Ira W. Snyder [mailto:iws@ovro.caltech.edu]
> Sent: Wednesday, August 01, 2012 7:46 AM
> To: linux-crypto@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org; Liu Qiang-B32616; Ira W. Snyder
> Subject: [PATCH 7/7] carma: remove unnecessary DMA_INTERRUPT capability
>=20
> From: "Ira W. Snyder" <iws@ovro.caltech.edu>
>=20
> These drivers set the DMA_INTERRUPT capability bit when requesting a DMA
> controller channel. This was historical, and is no longer needed.
>=20
> Recent changes to the drivers/dma/fsldma.c driver have removed support
> for this flag. This makes the carma drivers unable to find a DMA channel
> with the required capabilities.
>=20
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
>  drivers/misc/carma/carma-fpga-program.c |    1 -
>  drivers/misc/carma/carma-fpga.c         |    3 +--
>  2 files changed, 1 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/misc/carma/carma-fpga-program.c
> b/drivers/misc/carma/carma-fpga-program.c
> index a2d25e4..eaddfe9 100644
> --- a/drivers/misc/carma/carma-fpga-program.c
> +++ b/drivers/misc/carma/carma-fpga-program.c
> @@ -978,7 +978,6 @@ static int fpga_of_probe(struct platform_device *op)
>  	dev_set_drvdata(priv->dev, priv);
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_MEMCPY, mask);
> -	dma_cap_set(DMA_INTERRUPT, mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  	dma_cap_set(DMA_SG, mask);
>=20
> diff --git a/drivers/misc/carma/carma-fpga.c b/drivers/misc/carma/carma-
> fpga.c index 8c279da..861b298 100644
> --- a/drivers/misc/carma/carma-fpga.c
> +++ b/drivers/misc/carma/carma-fpga.c
> @@ -666,7 +666,7 @@ static int data_submit_dma(struct fpga_device *priv,
> struct data_buf *buf)
>  	src =3D SYS_FPGA_BLOCK;
>  	tx =3D chan->device->device_prep_dma_memcpy(chan, dst, src,
>  						  REG_BLOCK_SIZE,
> -						  DMA_PREP_INTERRUPT);
> +						  0);
>  	if (!tx) {
>  		dev_err(priv->dev, "unable to prep SYS-FPGA DMA\n");
>  		return -ENOMEM;
> @@ -1333,7 +1333,6 @@ static int data_of_probe(struct platform_device *op=
)
>=20
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_MEMCPY, mask);
> -	dma_cap_set(DMA_INTERRUPT, mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  	dma_cap_set(DMA_SG, mask);
Hi Ira, attached link is the comments of Dan Williams to the original patch=
 of fsl-dma.
http://lkml.indiana.edu/hypermail/linux/kernel/0910.1/03836.html

> --
> 1.7.8.6
>=20
