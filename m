Return-Path: <B05471@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 168BC2C0078
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 17:09:15 +1000 (EST)
From: Geanta Neag Horia Ioan-B05471 <B05471@freescale.com>
To: Liu Qiang-B32616 <B32616@freescale.com>
Subject: RE: [PATCH 4/4] Talitos: fix the issue of dma memory leak
Date: Wed, 11 Jul 2012 07:09:08 +0000
Message-ID: <FD18E5D573A8AB48A365D4D78185DE9923CC29@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1341900014-20915-1-git-send-email-qiang.liu@freescale.com>
In-Reply-To: <1341900014-20915-1-git-send-email-qiang.liu@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>,
 Phillips Kim-R1AAHA <R1AAHA@freescale.com>,
 Herbert Xu <herbert@gondor.hengli.com.au>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S.
 Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 10 Jul 2012 09:00:14 +0300, Qiang Liu <qiang.liu@freescale.com> wro=
te:
> An error will be happened when test with mass data:
> "DMA-API: device driver tries to sync DMA memory it has not allocated";
> "DMA-API: debugging out of memory - disabling"
> dma mapping memory of request->desc is not released by right device,
> it should be private->dev but not dev;
>=20
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
> ---
>  drivers/crypto/talitos.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
> index 81f8497..a7da48c 100644
> --- a/drivers/crypto/talitos.c
> +++ b/drivers/crypto/talitos.c
> @@ -264,7 +264,7 @@ static void flush_channel(struct device *dev, int
> ch, int error, int reset_ch)
>  			else
>  				status =3D error;
> -		dma_unmap_single(dev, request->dma_desc,
> +		 dma_unmap_single(priv->dev, request->dma_desc,
>  				 sizeof(struct talitos_desc),
>  				 DMA_BIDIRECTIONAL);

Are you sure this fix applies to the upstream version of talitos?
(i.e. have you encountered the error while running on cryptodev.git ?)

Looks to me this is a fix for the not-upstreamed-yet NAPI patch
(which needs to be reworked according to Dave's feedback).

When you respin the patch series, consider removing this one.

Cheers,
Horia
