Return-Path: <leoyang.li@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0095.outbound.protection.outlook.com [157.56.112.95])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxQlC6kBBzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Apr 2016 06:48:22 +1000 (AEST)
From: Yang-Leo Li <leoyang.li@nxp.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>, Li Yang <leoli@freescale.com>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "Zhang Wei" <zw@zh-kernel.org>, Vinod Koul <vinod.koul@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "dmaengine@vger.kernel.org"
 <dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/5] dmaengine: fsldma: Use dma_pool_zalloc
Date: Fri, 29 Apr 2016 20:48:14 +0000
Message-ID: <AM2PR04MB07705B52D8136609F47A18E58F660@AM2PR04MB0770.eurprd04.prod.outlook.com>
References: <1461960552-7429-1-git-send-email-Julia.Lawall@lip6.fr>
 <1461960552-7429-6-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1461960552-7429-6-git-send-email-Julia.Lawall@lip6.fr>
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



> -----Original Message-----
> From: Julia Lawall [mailto:Julia.Lawall@lip6.fr]
> Sent: Friday, April 29, 2016 3:09 PM
> To: Li Yang <leoli@freescale.com>
> Cc: kernel-janitors@vger.kernel.org; Zhang Wei <zw@zh-kernel.org>; Vinod
> Koul <vinod.koul@intel.com>; Dan Williams <dan.j.williams@intel.com>;
> linuxppc-dev@lists.ozlabs.org; dmaengine@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH 5/5] dmaengine: fsldma: Use dma_pool_zalloc
>=20
> Dma_pool_zalloc combines dma_pool_alloc and memset 0.  The semantic patch
> that makes this transformation is as follows: (http://coccinelle.lip6.fr/=
)
>=20
> // <smpl>
> @@
> expression d,e;
> statement S;
> @@
>=20
>         d =3D
> -            dma_pool_alloc
> +            dma_pool_zalloc
>              (...);
>         if (!d) S
> -       memset(d, 0, sizeof(*d));
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Li Yang <leoyang.li@nxp.com>

>=20
> ---
>  drivers/dma/fsldma.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c index
> aac85c3..a8828ed 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -462,13 +462,12 @@ static struct fsl_desc_sw
> *fsl_dma_alloc_descriptor(struct fsldma_chan *chan)
>  	struct fsl_desc_sw *desc;
>  	dma_addr_t pdesc;
>=20
> -	desc =3D dma_pool_alloc(chan->desc_pool, GFP_ATOMIC, &pdesc);
> +	desc =3D dma_pool_zalloc(chan->desc_pool, GFP_ATOMIC, &pdesc);
>  	if (!desc) {
>  		chan_dbg(chan, "out of memory for link descriptor\n");
>  		return NULL;
>  	}
>=20
> -	memset(desc, 0, sizeof(*desc));
>  	INIT_LIST_HEAD(&desc->tx_list);
>  	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
>  	desc->async_tx.tx_submit =3D fsl_dma_tx_submit;
