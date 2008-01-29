Return-Path: <stern@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 484ABDDDF3
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 02:27:49 +1100 (EST)
Date: Tue, 29 Jan 2008 10:27:45 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [patch v6 3/4] USB: add Cypress c67x00 OTG controller HCD driver
In-Reply-To: <20080129123120.113543000@sunsite.dk>
Message-ID: <Pine.LNX.4.44L0.0801291016370.4083-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	USB list <linux-usb@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 29 Jan 2008, Peter Korsgaard wrote:

> This patch adds HCD support for the Cypress c67x00 family of devices.

> --- /dev/null
> +++ linux-2.6/drivers/usb/c67x00/c67x00-hcd.c

> +int c67x00_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
> +{
> +	struct c67x00_hcd *c67x00 = hcd_to_c67x00_hcd(hcd);
> +	unsigned long flags;
> +	int rc;
> +
> +	spin_lock_irqsave(&c67x00->lock, flags);
> +	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
> +	if (rc)
> +		goto done;
> +
> +	c67x00_release_urb(c67x00, urb);
> +	usb_hcd_unlink_urb_from_ep(hcd, urb);
> +	spin_unlock_irqrestore(&c67x00->lock, flags);
> +
> +	usb_hcd_giveback_urb(hcd, urb, status);

This is wrong.  usb_hcd_giveback_urb() must be called with local
interrupts disabled.

> +/*
> + * pre: urb != NULL and c67x00 locked, urb unlocked
> + */
> +static inline void
> +c67x00_giveback_urb(struct c67x00_hcd *c67x00, struct urb *urb, int status)
> +{
> +	struct c67x00_urb_priv *urbp;
> +
> +	if (!urb)
> +		return;

Since you have the documented precondition that urb != NULL, and since
this routine is never called in a context where urb could be NULL,
there's no need for this test.  Also, I doubt that this routine really
needs to be inline (and besides, the compiler is better at making such
decisions than we are).

> +static void c67x00_sched_done(unsigned long __c67x00)
> +{
> +	struct c67x00_hcd *c67x00 = (struct c67x00_hcd *)__c67x00;
> +	struct c67x00_urb_priv *urbp, *tmp;
> +	struct urb *urb;
> +
> +	spin_lock(&c67x00->lock);
> +
> +	/* Loop over the done list and give back all the urbs */
> +	list_for_each_entry_safe(urbp, tmp, &c67x00->done_list, hep_node) {
> +		urb = urbp->urb;
> +		c67x00_release_urb(c67x00, urb);
> +		if (!usb_hcd_check_unlink_urb(c67x00_hcd_to_hcd(c67x00),
> +					      urb, urbp->status)) {

The function call above is completely wrong.  It is meant to be used only
from within the dequeue method.

> +			usb_hcd_unlink_urb_from_ep(c67x00_hcd_to_hcd(c67x00),
> +						   urb);
> +			spin_unlock(&c67x00->lock);
> +			usb_hcd_giveback_urb(c67x00_hcd_to_hcd(c67x00), urb,
> +					     urbp->status);
> +			spin_lock(&c67x00->lock);
> +		}
> +	}
> +	spin_unlock(&c67x00->lock);
> +}

Is there some reason this routine needs to run in a tasklet?  Why not
just call it directly?

Also, the fact that it is in a tasklet means that it runs with
interrupts enabled.  Hence your spin_lock() and spin_unlock() calls
will not do the right thing.

Alan Stern
