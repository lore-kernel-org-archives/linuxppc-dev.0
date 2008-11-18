Return-Path: <david-b@pacbell.net>
Received: from smtp120.sbc.mail.sp1.yahoo.com (smtp120.sbc.mail.sp1.yahoo.com
	[69.147.64.93]) by ozlabs.org (Postfix) with SMTP id 75299DDDED
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 13:14:41 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 5/6] usb/fsl_qe_udc: Fix muram corruption by disabled
	endpoints
Date: Mon, 17 Nov 2008 17:52:21 -0800
References: <20081111160153.GA12783@oksana.dev.rtsoft.ru>
	<20081111160340.GE24699@oksana.dev.rtsoft.ru>
In-Reply-To: <20081111160340.GE24699@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200811171752.22105.david-b@pacbell.net>
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
> Before freeing an endpoint's muram memory, we should stop all activity
> of the endpoint, otherwise the QE UDC controller might do nasty things
> with the muram memory that isn't belong to that endpoint anymore.
> 
> The qe_ep_reset() effectively flushes the hardware fifos, finishes all
> late transaction and thus prevents the corruption.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: David Brownell <dbrownell@users.sourceforge.net>


> ---
>  drivers/usb/gadget/fsl_qe_udc.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
> index 7bb5f36..cb47337 100644
> --- a/drivers/usb/gadget/fsl_qe_udc.c
> +++ b/drivers/usb/gadget/fsl_qe_udc.c
> @@ -1622,6 +1622,7 @@ static int qe_ep_disable(struct usb_ep *_ep)
>  	nuke(ep, -ESHUTDOWN);
>  	ep->desc = NULL;
>  	ep->stopped = 1;
> +	qe_ep_reset(udc, ep->epnum);
>  	spin_unlock_irqrestore(&udc->lock, flags);
>  
>  	cpm_muram_free(cpm_muram_offset(ep->rxbase));
> -- 
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
