Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7CCF7474C1
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 06:59:19 +1100 (EST)
Date: Wed, 12 Nov 2008 22:59:16 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb/fsl_qe_udc: Report disconnect before unbinding
Message-ID: <20081112195916.GA31938@oksana.dev.rtsoft.ru>
References: <20081112185627.GA17699@oksana.dev.rtsoft.ru>
	<Pine.LNX.4.44L0.0811121435310.16854-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <Pine.LNX.4.44L0.0811121435310.16854-100000@iolanthe.rowland.org>
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

On Wed, Nov 12, 2008 at 02:38:02PM -0500, Alan Stern wrote:
> On Wed, 12 Nov 2008, Anton Vorontsov wrote:
> 
> > Gadgets disable endpoints in their disconnect callbacks, so
> > we must call disconnect before unbinding. This also fixes
> > muram memory leak, since we free muram in the qe_ep_disable().
> 
> > --- a/drivers/usb/gadget/fsl_qe_udc.c
> > +++ b/drivers/usb/gadget/fsl_qe_udc.c
> > @@ -2382,6 +2382,9 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
> >  		nuke(loop_ep, -ESHUTDOWN);
> >  	spin_unlock_irqrestore(&udc_controller->lock, flags);
> >  
> > +	/* report disconnect; the driver is already quiesced */
> > +	driver->disconnect(&udc_controller->gadget);
> > +
> >  	/* unbind gadget and unhook driver. */
> >  	driver->unbind(&udc_controller->gadget);
> >  	udc_controller->gadget.dev.driver = NULL;
> 
> Wouldn't it be better to do this before nuking the existing requests?  
> The comment is wrong; the gadget driver is _not_ quiesced at this
> point.  In fact the disconnect call is what quiesces the driver!

composite_unbind() says:

        /* composite_disconnect() must already have been called
         * by the underlying peripheral controller driver!
         * so there's no i/o concurrency that could affect the
         * state protected by cdev->lock.
         */

Which I read as "at disconnect time the controller should
already be disabled, no further i/o can happen". Which means
that we should nuke all pending requests and stop the
controller.

In this comment:
"/* report disconnect; the driver is already quiesced */"
"the driver" means "the udc driver", not the gadget driver.

FWIW, the PXA27x UDC controller also stops all activity and
completely disables the controller before calling the
disconnect().

> And wouldn't it be better to _skip_ doing this if the gadget wasn't 
> connected before?

Composite framework handles this. If there were no connections,
then the disconnect() is a nop (except the spin lock/unlock pair).

I'm not sure how the controller driver could tell if there
was a connection or not: it doesn't operate these terms.
What the udc controller knows is: how to report bus reset
and how to receive or transmit the data...

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
