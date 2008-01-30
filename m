Return-Path: <stern@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 74404DDDF0
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 02:19:18 +1100 (EST)
Date: Wed, 30 Jan 2008 10:19:12 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [patch v6 3/4] USB: add Cypress c67x00 OTG controller HCD driver
In-Reply-To: <87r6fzd5bm.fsf@macbook.be.48ers.dk>
Message-ID: <Pine.LNX.4.44L0.0801301016450.4337-100000@iolanthe.rowland.org>
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

On Wed, 30 Jan 2008, Peter Korsgaard wrote:

>  >> +static void c67x00_sched_done(unsigned long __c67x00)
>  >> +{
>  >> +	struct c67x00_hcd *c67x00 = (struct c67x00_hcd *)__c67x00;
>  >> +	struct c67x00_urb_priv *urbp, *tmp;
>  >> +	struct urb *urb;
>  >> +
>  >> +	spin_lock(&c67x00->lock);
>  >> +
>  >> +	/* Loop over the done list and give back all the urbs */
>  >> +	list_for_each_entry_safe(urbp, tmp, &c67x00->done_list, hep_node) {
>  >> +		urb = urbp->urb;
>  >> +		c67x00_release_urb(c67x00, urb);
>  >> +		if (!usb_hcd_check_unlink_urb(c67x00_hcd_to_hcd(c67x00),
>  >> +					      urb, urbp->status)) {
> 
>  Alan> The function call above is completely wrong.  It is meant to be used only
>  Alan> from within the dequeue method.
> 
> Ahh, so should I just unconditionally do the unlink_urb_from_ep and
> giveback_urb?

Yes, that's right.  The check_unlink_urb routine merely verifies that 
an unlink is valid.  If you're about to giveback an URB then you 
already know it's valid to do so.

Alan Stern
