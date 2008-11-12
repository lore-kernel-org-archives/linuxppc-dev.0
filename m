Return-Path: <stern+49051fc8@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 7A1E6474C1
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 06:38:16 +1100 (EST)
Date: Wed, 12 Nov 2008 14:38:02 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] usb/fsl_qe_udc: Report disconnect before unbinding
In-Reply-To: <20081112185627.GA17699@oksana.dev.rtsoft.ru>
Message-ID: <Pine.LNX.4.44L0.0811121435310.16854-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg Kroah-Hartman <greg@kroah.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Li Yang <leoli@freescale.com>, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 12 Nov 2008, Anton Vorontsov wrote:

> Gadgets disable endpoints in their disconnect callbacks, so
> we must call disconnect before unbinding. This also fixes
> muram memory leak, since we free muram in the qe_ep_disable().

> --- a/drivers/usb/gadget/fsl_qe_udc.c
> +++ b/drivers/usb/gadget/fsl_qe_udc.c
> @@ -2382,6 +2382,9 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
>  		nuke(loop_ep, -ESHUTDOWN);
>  	spin_unlock_irqrestore(&udc_controller->lock, flags);
>  
> +	/* report disconnect; the driver is already quiesced */
> +	driver->disconnect(&udc_controller->gadget);
> +
>  	/* unbind gadget and unhook driver. */
>  	driver->unbind(&udc_controller->gadget);
>  	udc_controller->gadget.dev.driver = NULL;

Wouldn't it be better to do this before nuking the existing requests?  
The comment is wrong; the gadget driver is _not_ quiesced at this
point.  In fact the disconnect call is what quiesces the driver!

And wouldn't it be better to _skip_ doing this if the gadget wasn't 
connected before?

Alan Stern
