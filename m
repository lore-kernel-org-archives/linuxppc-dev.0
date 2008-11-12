Return-Path: <stern+49051fc8@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 82AF6DDDE3
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 08:12:37 +1100 (EST)
Date: Wed, 12 Nov 2008 16:12:33 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] usb/fsl_qe_udc: Report disconnect before unbinding
In-Reply-To: <20081112202017.GA5161@oksana.dev.rtsoft.ru>
Message-ID: <Pine.LNX.4.44L0.0811121606280.17105-100000@iolanthe.rowland.org>
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

> On Wed, Nov 12, 2008 at 11:12:18PM +0300, Anton Vorontsov wrote:
> > On Wed, Nov 12, 2008 at 10:59:16PM +0300, Anton Vorontsov wrote:
> > [...]
> > > > And wouldn't it be better to _skip_ doing this if the gadget wasn't 
> > > > connected before?
> > > 
> > > Composite framework handles this. If there were no connections,
> > > then the disconnect() is a nop (except the spin lock/unlock pair).
> > > 
> > > I'm not sure how the controller driver could tell if there
> > > was a connection or not: it doesn't operate these terms.
> > > What the udc controller knows is: how to report bus reset
> > > and how to receive or transmit the data...
> > 
> > It seems I lied. Did you mean something like this patch?
> > 
> > diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
> > index c7de671..fd44cf4 100644
> > --- a/drivers/usb/gadget/fsl_qe_udc.c
> > +++ b/drivers/usb/gadget/fsl_qe_udc.c
> > @@ -2368,6 +2368,9 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
> >  	/* stop usb controller, disable intr */
> >  	qe_usb_disable();
> >  
> > +	if (udc->usb_state == USB_STATE_DEFAULT)
> 
> Should be also || usb_state == USB_STATE_ATTACHED, since
> this is the initial value after the usb_gadget_register_driver().
> 
> And the _DEFAULT state is "we're just after the bus reset" (also
> means that we already called the disconnect()).

That sounds right.  Although come to think of it, I guess there really 
is no harm in calling the disconnect method twice in a row.  But it's 
better to do what the other UDC drivers do.

> > +		goto skip_quiesce;
> > +
> >  	/* in fact, no needed */
> >  	udc_controller->usb_state = USB_STATE_ATTACHED;
> >  	udc_controller->ep0_state = WAIT_FOR_SETUP;
> > @@ -2385,6 +2388,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
> >  	/* report disconnect; the driver is already quiesced */
> >  	driver->disconnect(&udc_controller->gadget);

I would update this last comment slightly.  The word "driver" is
ambiguous, and since this function is named
usb_gadget_unregister_driver(), it looks like you're talking about the
gadget driver.

> > +skip_quiesce:
> >  	/* unbind gadget and unhook driver. */
> >  	driver->unbind(&udc_controller->gadget);
> >  	udc_controller->gadget.dev.driver = NULL;

Alan Stern
