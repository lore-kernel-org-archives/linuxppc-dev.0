Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8143DDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 07:20:19 +1100 (EST)
Date: Wed, 12 Nov 2008 23:20:17 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb/fsl_qe_udc: Report disconnect before unbinding
Message-ID: <20081112202017.GA5161@oksana.dev.rtsoft.ru>
References: <20081112185627.GA17699@oksana.dev.rtsoft.ru>
	<Pine.LNX.4.44L0.0811121435310.16854-100000@iolanthe.rowland.org>
	<20081112195916.GA31938@oksana.dev.rtsoft.ru>
	<20081112201218.GA5870@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20081112201218.GA5870@oksana.dev.rtsoft.ru>
Cc: Greg Kroah-Hartman <greg@kroah.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Li Yang <leoli@freescale.com>, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 12, 2008 at 11:12:18PM +0300, Anton Vorontsov wrote:
> On Wed, Nov 12, 2008 at 10:59:16PM +0300, Anton Vorontsov wrote:
> [...]
> > > And wouldn't it be better to _skip_ doing this if the gadget wasn't 
> > > connected before?
> > 
> > Composite framework handles this. If there were no connections,
> > then the disconnect() is a nop (except the spin lock/unlock pair).
> > 
> > I'm not sure how the controller driver could tell if there
> > was a connection or not: it doesn't operate these terms.
> > What the udc controller knows is: how to report bus reset
> > and how to receive or transmit the data...
> 
> It seems I lied. Did you mean something like this patch?
> 
> diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
> index c7de671..fd44cf4 100644
> --- a/drivers/usb/gadget/fsl_qe_udc.c
> +++ b/drivers/usb/gadget/fsl_qe_udc.c
> @@ -2368,6 +2368,9 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
>  	/* stop usb controller, disable intr */
>  	qe_usb_disable();
>  
> +	if (udc->usb_state == USB_STATE_DEFAULT)

Should be also || usb_state == USB_STATE_ATTACHED, since
this is the initial value after the usb_gadget_register_driver().

And the _DEFAULT state is "we're just after the bus reset" (also
means that we already called the disconnect()).

> +		goto skip_quiesce;
> +
>  	/* in fact, no needed */
>  	udc_controller->usb_state = USB_STATE_ATTACHED;
>  	udc_controller->ep0_state = WAIT_FOR_SETUP;
> @@ -2385,6 +2388,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
>  	/* report disconnect; the driver is already quiesced */
>  	driver->disconnect(&udc_controller->gadget);
>  
> +skip_quiesce:
>  	/* unbind gadget and unhook driver. */
>  	driver->unbind(&udc_controller->gadget);
>  	udc_controller->gadget.dev.driver = NULL;

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
