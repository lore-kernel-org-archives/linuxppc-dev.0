Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id A4186DDDEE
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 20:35:14 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so318608uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 01:35:12 -0800 (PST)
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch v6 3/4] USB: add Cypress c67x00 OTG controller HCD driver
References: <Pine.LNX.4.44L0.0801291016370.4083-100000@iolanthe.rowland.org>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 30 Jan 2008 10:35:09 +0100
In-Reply-To: <Pine.LNX.4.44L0.0801291016370.4083-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Tue\,
	29 Jan 2008 10\:27\:45 -0500 \(EST\)")
Message-ID: <87r6fzd5bm.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
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

>>>>> "Alan" == Alan Stern <stern@rowland.harvard.edu> writes:

 Alan> On Tue, 29 Jan 2008, Peter Korsgaard wrote:
 >> This patch adds HCD support for the Cypress c67x00 family of devices.

 >> --- /dev/null
 >> +++ linux-2.6/drivers/usb/c67x00/c67x00-hcd.c

 >> +int c67x00_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 >> +{
 >> +	struct c67x00_hcd *c67x00 = hcd_to_c67x00_hcd(hcd);
 >> +	unsigned long flags;
 >> +	int rc;
 >> +
 >> +	spin_lock_irqsave(&c67x00->lock, flags);
 >> +	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
 >> +	if (rc)
 >> +		goto done;
 >> +
 >> +	c67x00_release_urb(c67x00, urb);
 >> +	usb_hcd_unlink_urb_from_ep(hcd, urb);
 >> +	spin_unlock_irqrestore(&c67x00->lock, flags);
 >> +
 >> +	usb_hcd_giveback_urb(hcd, urb, status);

 Alan> This is wrong.  usb_hcd_giveback_urb() must be called with local
 Alan> interrupts disabled.

Ups, good catch. I've put a spin_unlock() / spin_lock() around it and
moved the _irqrestore down below now.

 >> +/*
 >> + * pre: urb != NULL and c67x00 locked, urb unlocked
 >> + */
 >> +static inline void
 >> +c67x00_giveback_urb(struct c67x00_hcd *c67x00, struct urb *urb, int status)
 >> +{
 >> +	struct c67x00_urb_priv *urbp;
 >> +
 >> +	if (!urb)
 >> +		return;

 Alan> Since you have the documented precondition that urb != NULL, and since
 Alan> this routine is never called in a context where urb could be NULL,
 Alan> there's no need for this test.  Also, I doubt that this routine really
 Alan> needs to be inline (and besides, the compiler is better at making such
 Alan> decisions than we are).

It can be null in c67x00_check_td_list, so it's actually the comment
that's wrong. I've fixed that.

 >> +static void c67x00_sched_done(unsigned long __c67x00)
 >> +{
 >> +	struct c67x00_hcd *c67x00 = (struct c67x00_hcd *)__c67x00;
 >> +	struct c67x00_urb_priv *urbp, *tmp;
 >> +	struct urb *urb;
 >> +
 >> +	spin_lock(&c67x00->lock);
 >> +
 >> +	/* Loop over the done list and give back all the urbs */
 >> +	list_for_each_entry_safe(urbp, tmp, &c67x00->done_list, hep_node) {
 >> +		urb = urbp->urb;
 >> +		c67x00_release_urb(c67x00, urb);
 >> +		if (!usb_hcd_check_unlink_urb(c67x00_hcd_to_hcd(c67x00),
 >> +					      urb, urbp->status)) {

 Alan> The function call above is completely wrong.  It is meant to be used only
 Alan> from within the dequeue method.

Ahh, so should I just unconditionally do the unlink_urb_from_ep and
giveback_urb?

 >> +			usb_hcd_unlink_urb_from_ep(c67x00_hcd_to_hcd(c67x00),
 >> +						   urb);
 >> +			spin_unlock(&c67x00->lock);
 >> +			usb_hcd_giveback_urb(c67x00_hcd_to_hcd(c67x00), urb,
 >> +					     urbp->status);
 >> +			spin_lock(&c67x00->lock);
 >> +		}
 >> +	}
 >> +	spin_unlock(&c67x00->lock);
 >> +}

 Alan> Is there some reason this routine needs to run in a tasklet?  Why not
 Alan> just call it directly?

Hmm, I don't actually remember anymore. It's was written back in
Spring 2006 by Jan. I'll try moving it out of the tasklet and see what
it gives.

 Alan> Also, the fact that it is in a tasklet means that it runs with
 Alan> interrupts enabled.  Hence your spin_lock() and spin_unlock() calls
 Alan> will not do the right thing.

Ahh, ofcause.

Thanks for the feedback!

-- 
Bye, Peter Korsgaard
