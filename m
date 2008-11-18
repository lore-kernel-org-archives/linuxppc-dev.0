Return-Path: <david-b@pacbell.net>
Received: from smtp120.sbc.mail.sp1.yahoo.com (smtp120.sbc.mail.sp1.yahoo.com
	[69.147.64.93]) by ozlabs.org (Postfix) with SMTP id CBA56DDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 13:14:41 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 6/6] usb/fsl_qe_udc: Fix stalled TX requests bug
Date: Mon, 17 Nov 2008 17:53:12 -0800
References: <20081111160153.GA12783@oksana.dev.rtsoft.ru>
	<20081111160344.GF24699@oksana.dev.rtsoft.ru>
In-Reply-To: <20081111160344.GF24699@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200811171753.12695.david-b@pacbell.net>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Li Yang <leoli@freescale.com>,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: dbrownell@users.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 11 November 2008, Anton Vorontsov wrote:
> While disabling an endpoint the driver nuking any pending requests,
> thus completing them with -ESHUTDOWN status. But the driver doesn't
> clear the tx_req, which means that a next TX request (after
> ep_enable), might get stalled, since the driver won't queue the new
> reqests.
> 
> This fixes a bug I'm observing with ethernet gadget while playing
> with ifconfig usb0 up/down (the up/down sequence disables and
> enables `in' and `out' endpoints).
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: David Brownell <dbrownell@users.sourceforge.net>

> ---
>  drivers/usb/gadget/fsl_qe_udc.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
> index cb47337..37c8575 100644
> --- a/drivers/usb/gadget/fsl_qe_udc.c
> +++ b/drivers/usb/gadget/fsl_qe_udc.c
> @@ -1622,6 +1622,7 @@ static int qe_ep_disable(struct usb_ep *_ep)
>  	nuke(ep, -ESHUTDOWN);
>  	ep->desc = NULL;
>  	ep->stopped = 1;
> +	ep->tx_req = NULL;
>  	qe_ep_reset(udc, ep->epnum);
>  	spin_unlock_irqrestore(&udc->lock, flags);
>  
> -- 
> 1.5.6.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
