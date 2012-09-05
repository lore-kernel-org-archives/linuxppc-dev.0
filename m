Return-Path: <balbi@ti.com>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
 [74.125.149.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CB5922C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 22:47:51 +1000 (EST)
Received: by lbao2 with SMTP id o2so300920lba.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2012 05:47:47 -0700 (PDT)
Date: Wed, 5 Sep 2012 15:36:40 +0300
From: Felipe Balbi <balbi@ti.com>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: Re: [PATCH] usb: gadget: fsl_udc_core: remove mapped flag
Message-ID: <20120905123639.GD19591@arwen.pp.htv.fi>
References: <1346779499-6085-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
In-Reply-To: <1346779499-6085-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, balbi@ti.com
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 04, 2012 at 07:24:59PM +0200, Enrico Scholz wrote:
> The 'mapped' flag in 'struct fsl_req' flag is redundant with checking
> for 'req.dma !=3D DMA_ADDR_INVALID' and it was also set to a wrong value

you should not be using DMA_ADDR_INVALID anymore. Use the generic
map/unmap routines from udc-core.c

> (see 2nd hunk of patch).
>=20
> Replacing it in the way described above saves 60 bytes:
>=20
>   function                                     old     new   delta
>   fsl_udc_irq                                 2952    2940     -12
>   ep0_prime_status                             380     368     -12
>   done                                         448     432     -16
>   fsl_ep_queue                                 668     648     -20
>=20
> and has same (or less) runtime costs like evaluating 'req->mapped'.
>=20
> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
> ---
>  drivers/usb/gadget/fsl_udc_core.c | 10 ++--------
>  drivers/usb/gadget/fsl_usb2_udc.h |  1 -
>  2 files changed, 2 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_u=
dc_core.c
> index 55c4a61..1282a11 100644
> --- a/drivers/usb/gadget/fsl_udc_core.c
> +++ b/drivers/usb/gadget/fsl_udc_core.c
> @@ -195,14 +195,13 @@ static void done(struct fsl_ep *ep, struct fsl_req =
*req, int status)
>  		dma_pool_free(udc->td_pool, curr_td, curr_td->td_dma);
>  	}
> =20
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
>  			req->req.dma, req->req.length,
> @@ -915,15 +914,12 @@ fsl_ep_queue(struct usb_ep *_ep, struct usb_request=
 *_req, gfp_t gfp_flags)
>  					req->req.length, ep_is_in(ep)
>  						? DMA_TO_DEVICE
>  						: DMA_FROM_DEVICE);
> -		req->mapped =3D 1;
> -	} else {
> +	} else
>  		dma_sync_single_for_device(ep->udc->gadget.dev.parent,
>  					req->req.dma, req->req.length,
>  					ep_is_in(ep)
>  						? DMA_TO_DEVICE
>  						: DMA_FROM_DEVICE);
> -		req->mapped =3D 0;
> -	}
> =20
>  	req->req.status =3D -EINPROGRESS;
>  	req->req.actual =3D 0;
> @@ -1306,7 +1302,6 @@ static int ep0_prime_status(struct fsl_udc *udc, in=
t direction)
>  	req->req.dma =3D dma_map_single(ep->udc->gadget.dev.parent,
>  			req->req.buf, req->req.length,
>  			ep_is_in(ep) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
> -	req->mapped =3D 1;
> =20
>  	if (fsl_req_to_dtd(req, GFP_ATOMIC) =3D=3D 0)
>  		fsl_queue_td(ep, req);
> @@ -1389,7 +1384,6 @@ static void ch9getstatus(struct fsl_udc *udc, u8 re=
quest_type, u16 value,
>  	req->req.dma =3D dma_map_single(ep->udc->gadget.dev.parent,
>  				req->req.buf, req->req.length,
>  				ep_is_in(ep) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
> -	req->mapped =3D 1;
> =20
>  	/* prime the data phase */
>  	if ((fsl_req_to_dtd(req, GFP_ATOMIC) =3D=3D 0))
> diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_u=
sb2_udc.h
> index fbd77ba..9aab166 100644
> --- a/drivers/usb/gadget/fsl_usb2_udc.h
> +++ b/drivers/usb/gadget/fsl_usb2_udc.h
> @@ -436,7 +436,6 @@ struct fsl_req {
>  	/* ep_queue() func will add
>  	   a request->queue into a udc_ep->queue 'd tail */
>  	struct fsl_ep *ep;
> -	unsigned mapped:1;
> =20
>  	struct ep_td_struct *head, *tail;	/* For dTD List
>  						   cpu endian Virtual addr */
> --=20
> 1.7.11.4
>=20

--=20
balbi

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQR0dWAAoJEIaOsuA1yqREylYP/Ri8QHa2ek50Hu+aRyKu92fW
DdekjQUqJvSVRyAF2FONzwJLJ163oNHveqFmyg9D4RkJDfGT7OeaOBvpWKbg6kh+
nKwOZYUnuVzmXB/AUjJRhREqxwy1w5BMsCVIyvkDYfc14qKBZ+at6PS4WNHrSShq
uL0cUnEgwOSvE7AyQjJVfSSq/ero1jqEskz1frOTxoEE0BdAv7MVKvXejQhNcsEb
Yqu/shSHA1UG3wHt/V54+Fzn7sxmYoRKBAZV1PtgkOGr8bI9KzbQ/r+mMyZ8e4TO
pn5tnacJ7iq8d4UU0te07XMujRXWzOmYOBv3n6D3MJZY104v7Xvmjikh0D/iqWBR
CceHeVWPbSRShK+o+VqRgxChV4wCuLNviIZ+6UdLnU2hLoGikmBDMcVQcmmLZvMa
h/v0KGdHt6NQXtpN8XIzbZnRaSwQdomHc6rMOvT/aBHjXlR5jAWPA5qeJfQWWWrJ
ByLMNch5OfeZEP0pz7XaOpZLaDpJWxSAFHOuDTzgbO8yPwgfcBYr3ok0/bjkfZeQ
0rzu+himZx/QJIR50Nv1DXMNIfLEsyIXKa/bdkF/xOZmOE2n0BJsRx87vXdZvcSU
fu12jVVru50ljg+wiN6upJWGvWHIZCnAFov3om3eVLRF9byzCIVbQ1/BtI4UzhY5
L0AshY1w50sWUz9ye/u6
=Pjyv
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
