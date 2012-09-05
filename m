Return-Path: <B29397@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F09202C0098
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 12:17:16 +1000 (EST)
From: Chen Peter-B29397 <B29397@freescale.com>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] usb: gadget: fsl_udc_core: remove mapped flag
Date: Wed, 5 Sep 2012 02:17:05 +0000
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803C67DB9@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1346779499-6085-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
In-Reply-To: <1346779499-6085-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 Li Yang-R58472 <r58472@freescale.com>, "balbi@ti.com" <balbi@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> @@ -195,14 +195,13 @@ static void done(struct fsl_ep *ep, struct fsl_req
> *req, int status)
>  		dma_pool_free(udc->td_pool, curr_td, curr_td->td_dma);
>  	}
>=20
> -	if (req->mapped) {
> +	if (req->req.dma !=3D DMA_ADDR_INVALID) {
>  		dma_unmap_single(ep->udc->gadget.dev.parent,
>  			req->req.dma, req->req.length,
>  			ep_is_in(ep)
>  				? DMA_TO_DEVICE
>  				: DMA_FROM_DEVICE);
>  		req->req.dma =3D DMA_ADDR_INVALID;
> -		req->mapped =3D 0;
>  	} else
>  		dma_sync_single_for_cpu(ep->udc->gadget.dev.parent,
If the class driver has already mapped this address, the req->req.dma is no=
t
DMA_ADDR_INVALID either, in this case, the dma_sync_single_for_cpu is enoug=
h.


Peter
