Return-Path: <mnazarewicz@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
 [209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 74A54B70C9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 12:22:17 +1100 (EST)
Received: by bkat8 with SMTP id t8so7265121bka.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2011 17:22:12 -0800 (PST)
Sender: =?UTF-8?Q?Micha=C5=82_Nazarewicz?= <mnazarewicz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To: leoli@freescale.com, balbi@ti.com, "Peter Chen" <peter.chen@freescale.com>
Subject: Re: [PATCH] USB: fsl_udc_core: Use (&) instead of (==) to compare ISO
 XFER
References: <1321924521-3218-1-git-send-email-peter.chen@freescale.com>
Date: Tue, 22 Nov 2011 02:22:10 +0100
MIME-Version: 1.0
From: "Michal Nazarewicz" <mina86@mina86.com>
Message-ID: <op.v5bp28eu3l0zgt@mpn-glaptop>
In-Reply-To: <1321924521-3218-1-git-send-email-peter.chen@freescale.com>
Cc: gregkh@suse.de, linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 22 Nov 2011 02:15:21 +0100, Peter Chen <peter.chen@freescale.com=
> wrote:

> Some ISO gadgets, like audio, has SYNC attribute as well as
> USB_ENDPOINT_XFER_ISOC for their bmAttributes at ISO endpoint
> descriptor. So, it needs to use & instead of =3D=3D to judge if
> it is ISO XFER.
>
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/gadget/fsl_udc_core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fs=
l_udc_core.c
> index d786ba3..bf40de3 100644
> --- a/drivers/usb/gadget/fsl_udc_core.c
> +++ b/drivers/usb/gadget/fsl_udc_core.c
> @@ -877,7 +877,7 @@ fsl_ep_queue(struct usb_ep *_ep, struct usb_reques=
t *_req, gfp_t gfp_flags)
>  		VDBG("%s, bad ep", __func__);
>  		return -EINVAL;
>  	}
> -	if (ep->desc->bmAttributes =3D=3D USB_ENDPOINT_XFER_ISOC) {
> +	if (ep->desc->bmAttributes & USB_ENDPOINT_XFER_ISOC) {

What you really meant is:

(ep->desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) =3D=3D USB_ENDPOIN=
T_XFER_ISOC

It would probably be useful to create a function that performs that chec=
k rather
than having to type all of that every time.

>  		if (req->req.length > ep->ep.maxpacket)
>  			return -EMSGSIZE;
>  	}
> @@ -1032,7 +1032,7 @@ static int fsl_ep_set_halt(struct usb_ep *_ep, i=
nt value)
>  		goto out;
>  	}
>-	if (ep->desc->bmAttributes =3D=3D USB_ENDPOINT_XFER_ISOC) {
> +	if (ep->desc->bmAttributes & USB_ENDPOINT_XFER_ISOC) {
>  		status =3D -EOPNOTSUPP;
>  		goto out;
>  	}


-- =

Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz=
    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
