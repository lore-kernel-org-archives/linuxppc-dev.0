Return-Path: <mnazarewicz@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
 [209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 3BEC61007D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 12:58:01 +1100 (EST)
Received: by bkat8 with SMTP id t8so7291318bka.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2011 17:57:57 -0800 (PST)
Sender: =?UTF-8?Q?Micha=C5=82_Nazarewicz?= <mnazarewicz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To: leoli@freescale.com, balbi@ti.com, "Peter Chen" <peter.chen@freescale.com>
Subject: Re: [PATCH v2] USB: fsl_udc_core: use usb_endpoint_xfer_isoc to judge
 ISO XFER
References: <1321926945-8182-1-git-send-email-peter.chen@freescale.com>
Date: Tue, 22 Nov 2011 02:57:56 +0100
MIME-Version: 1.0
From: "Michal Nazarewicz" <mina86@mina86.com>
Message-ID: <op.v5brquwq3l0zgt@mpn-glaptop>
In-Reply-To: <1321926945-8182-1-git-send-email-peter.chen@freescale.com>
Cc: gregkh@suse.de, linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 hzpeterchen@gmail.com, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 22 Nov 2011 02:55:45 +0100, Peter Chen <peter.chen@freescale.com=
> wrote:
> Some ISO gadgets, like audio, has SYNC attribute as well as
> USB_ENDPOINT_XFER_ISOC for their bmAttributes at ISO endpoint
> descriptor. So, it needs to use usb_endpoint_xfer_isoc to judge
> ISO XFER.
>
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> @@ -877,7 +877,7 @@ fsl_ep_queue(struct usb_ep *_ep, struct usb_reques=
t *_req, gfp_t gfp_flags)
>  		VDBG("%s, bad ep", __func__);
>  		return -EINVAL;
>  	}
> -	if (ep->desc->bmAttributes =3D=3D USB_ENDPOINT_XFER_ISOC) {
> +	if (usb_endpoint_xfer_isoc(ep->desc)) {
>  		if (req->req.length > ep->ep.maxpacket)
>  			return -EMSGSIZE;
>  	}
> @@ -1032,7 +1032,7 @@ static int fsl_ep_set_halt(struct usb_ep *_ep, i=
nt value)
>  		goto out;
>  	}
>-	if (ep->desc->bmAttributes =3D=3D USB_ENDPOINT_XFER_ISOC) {
> +	if (usb_endpoint_xfer_isoc(ep->desc)) {
>  		status =3D -EOPNOTSUPP;
>  		goto out;
>  	}

-- =

Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz=
    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
