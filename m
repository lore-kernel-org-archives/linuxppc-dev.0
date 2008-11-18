Return-Path: <david-b@pacbell.net>
Received: from smtp115.sbc.mail.sp1.yahoo.com (smtp115.sbc.mail.sp1.yahoo.com
	[69.147.64.88]) by ozlabs.org (Postfix) with SMTP id 2C901DDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 12:48:29 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 4/6] usb/fsl_qe_udc: Fix disconnects reporting during bus
	reset
Date: Mon, 17 Nov 2008 17:48:24 -0800
References: <20081111160153.GA12783@oksana.dev.rtsoft.ru>
	<20081111160334.GD24699@oksana.dev.rtsoft.ru>
In-Reply-To: <20081111160334.GD24699@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200811171748.24310.david-b@pacbell.net>
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
> Freescale QE UDC controllers can't report the "port change" states,
> so the only way to handle disconnects is to process bus reset
> interrupts. The bus reset can take some time, that is, few irqs.
> Gadgets may print the disconnection events, and this causes few
> repetitive messages in the kernel log.
> 
> This patch fixes the issue by using the usb_state machine, if the
> usb controller has been already reset, just quit the reset irq
> early.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: David Brownell <dbrownell@users.sourceforge.net>

Note that the "port change" you reference is more typically
packaged as "VBUS detect" ... often handled with a GPIO.

> ---
>  drivers/usb/gadget/fsl_qe_udc.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
> index 1789f65..7bb5f36 100644
> --- a/drivers/usb/gadget/fsl_qe_udc.c
> +++ b/drivers/usb/gadget/fsl_qe_udc.c
> @@ -2161,6 +2161,9 @@ static int reset_irq(struct qe_udc *udc)
>  {
>  	unsigned char i;
>  
> +	if (udc->usb_state == USB_STATE_DEFAULT)
> +		return 0;
> +
>  	qe_usb_disable();
>  	out_8(&udc->usb_regs->usb_usadr, 0);
>  
> -- 
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
