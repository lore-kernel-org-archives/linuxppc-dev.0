Return-Path: <leoyang.li@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0083.outbound.protection.outlook.com [104.47.1.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN2SB1J1TzDr5T
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 04:55:05 +1000 (AEST)
From: Leo Li <leoyang.li@nxp.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Bhumika Goyal <bhumirks@gmail.com>
Subject: RE: [PATCH] usb: gadget: fsl_qe_udc: constify qe_ep0_desc
Date: Wed, 2 Aug 2017 18:54:58 +0000
Message-ID: <AM4PR0401MB1699B3AAF1609CB04AF01E668FB00@AM4PR0401MB1699.eurprd04.prod.outlook.com>
References: <1501687767-12768-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1501687767-12768-1-git-send-email-Julia.Lawall@lip6.fr>
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
> Sent: Wednesday, August 02, 2017 10:29 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: kernel-janitors@vger.kernel.org; Felipe Balbi <balbi@kernel.org>; Gre=
g
> Kroah-Hartman <gregkh@linuxfoundation.org>; linux-usb@vger.kernel.org;
> linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Bhumika Goya=
l
> <bhumirks@gmail.com>
> Subject: [PATCH] usb: gadget: fsl_qe_udc: constify qe_ep0_desc
>=20
> qe_ep0_desc is only passed as the second argument to qe_ep_init, which is
> const, so qe_ep0_desc can be const too.
>=20
> Done with the help of Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Li Yang <leoyang.li@nxp.com>

>=20
> ---
> I got a lot of warnings when compiling this file, but none seemed to be r=
elated
> to the change.
>=20
>  drivers/usb/gadget/udc/fsl_qe_udc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c
> b/drivers/usb/gadget/udc/fsl_qe_udc.c
> index 303328ce..a3e72d6 100644
> --- a/drivers/usb/gadget/udc/fsl_qe_udc.c
> +++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
> @@ -62,7 +62,7 @@
>  	"ep3",
>  };
>=20
> -static struct usb_endpoint_descriptor qe_ep0_desc =3D {
> +static const struct usb_endpoint_descriptor qe_ep0_desc =3D {
>  	.bLength =3D		USB_DT_ENDPOINT_SIZE,
>  	.bDescriptorType =3D	USB_DT_ENDPOINT,
>=20
