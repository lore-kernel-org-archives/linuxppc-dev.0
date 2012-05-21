Return-Path: <B29397@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 61855B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2012 17:26:07 +1000 (EST)
From: Chen Peter-B29397 <B29397@freescale.com>
To: Christoph Fritz <chf.fritz@googlemail.com>, Li Yang-R58472
 <r58472@freescale.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v2] usb: fsl_udc: errata - postpone freeing current dTD
Date: Mon, 21 May 2012 07:25:56 +0000
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803BB2160@039-SN2MPN1-023.039d.mgd.msft.net>
References: <CAOMZO5A=sHeyoQ0PCd=09qGGKb0NjXi-kF5qyG+3U-GhD7rhzg@mail.gmail.com>
 <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <20120513225126.GA3683@lovely.krouter> <20120514042142.GD9750@kroah.com>
 <20120520231724.GA7941@mars>
 <F281D0F91ED19E4D8E63A7504E8A649803BB1E25@039-SN2MPN1-023.039d.mgd.msft.net>
 <1337583221.3394.21.camel@mars> <20120521065722.GA4363@mars>
In-Reply-To: <20120521065722.GA4363@mars>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Oliver Neukum <oneukum@suse.de>, Kukjin Kim <kgene.kim@samsung.com>,
 Eric Miao <eric.y.miao@gmail.com>, Ben Dooks <ben-linux@fluff.org>,
 Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Ido Shayevitz <idos@codeaurora.org>,
 Thomas Dahlmann <dahlmann.thomas@arcor.de>,
 Estevam Fabio-R49496 <r49496@freescale.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
 Daniel Mack <daniel@caiaq.de>, Christian Hemp <c.hemp@phytec.de>,
 Russell King <linux@arm.linux.org.uk>, Neil Zhang <zhangwm@marvell.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
>=20
> USB controller may access a wrong address for the dTD (endpoint transfer
> descriptor) and then hang. This happens a lot when doing tests with
> g_ether module and iperf, a tool for measuring maximum TCP and UDP
> bandwidth.
>=20
> This hardware bug is explained in detail by errata number 2858 for i.MX23=
:
> http://cache.freescale.com/files/dsp/doc/errata/IMX23CE.pdf
>=20

> All (?) SOCs with an IP from chipidea suffer from this problem.
> mv_udc_core fixes this bug by commit daec765.  There still may be
> unfixed drivers.
>=20
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> Signed-off-by: Christian Hemp <c.hemp@phytec.de>
> ---
>  drivers/usb/gadget/fsl_udc_core.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/fsl_udc_core.c
> b/drivers/usb/gadget/fsl_udc_core.c
> index 55abfb6..72f2139 100644
> --- a/drivers/usb/gadget/fsl_udc_core.c
> +++ b/drivers/usb/gadget/fsl_udc_core.c
> @@ -65,6 +65,8 @@ static struct usb_sys_interface *usb_sys_regs;
>  /* it is initialized in probe()  */
>  static struct fsl_udc *udc_controller =3D NULL;
>=20
> +static struct ep_td_struct *last_free_td;
> +
>  static const struct usb_endpoint_descriptor
>  fsl_ep0_desc =3D {
>  	.bLength =3D		USB_DT_ENDPOINT_SIZE,
> @@ -180,8 +182,13 @@ static void done(struct fsl_ep *ep, struct fsl_req
> *req, int status)
>  		curr_td =3D next_td;
>  		if (j !=3D req->dtd_count - 1) {
>  			next_td =3D curr_td->next_td_virt;
> +			dma_pool_free(udc->td_pool, curr_td, curr_td->td_dma);
> +		} else {
> +			if (last_free_td !=3D NULL)
> +				dma_pool_free(udc->td_pool, last_free_td,
> +						last_free_td->td_dma);
> +			last_free_td =3D curr_td;
>  		}
> -		dma_pool_free(udc->td_pool, curr_td, curr_td->td_dma);
>  	}
>=20
>  	if (req->mapped) {
> @@ -2579,6 +2586,8 @@ static int __init fsl_udc_probe(struct
> platform_device *pdev)
>  		goto err_unregister;
>  	}
>=20
> +	last_free_td =3D NULL;
> +
>  	ret =3D usb_add_gadget_udc(&pdev->dev, &udc_controller->gadget);
>  	if (ret)
>  		goto err_del_udc;
> @@ -2633,6 +2642,10 @@ static int __exit fsl_udc_remove(struct
> platform_device *pdev)
>  	kfree(udc_controller->status_req);
>  	kfree(udc_controller->eps);
>=20
> +	if (last_free_td !=3D NULL)
> +		dma_pool_free(udc_controller->td_pool, last_free_td,
> +				last_free_td->td_dma);
> +
>  	dma_pool_destroy(udc_controller->td_pool);
>  	free_irq(udc_controller->irq, udc_controller);
>  	iounmap(dr_regs);

Reviewed-by: Peter Chen <peter.chen@freescale.com>
> --
> 1.7.2.5
>=20
>=20
