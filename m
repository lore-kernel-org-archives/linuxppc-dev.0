Return-Path: <stern@rowland.harvard.edu>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by ozlabs.org (Postfix) with SMTP id 908D1DDDF4
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Dec 2007 08:51:25 +1100 (EST)
Date: Sat, 29 Dec 2007 16:44:43 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [linux-usb-devel] [PATCH v2 3/4] USB: add Cypress c67x00 OTG
	controller HCD driver
In-Reply-To: <20071228235241.16003.2229.stgit@trillian.secretlab.ca>
Message-ID: <Pine.LNX.4.44L0.0712291641050.26261-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: akpm@osdl.org, dbrownell@users.sourceforge.net,
	linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 28 Dec 2007, Grant Likely wrote:

> From: Grant Likely <grant.likely@secretlab.ca>
> 
> This patch adds HDC support for the Cypress c67x00 family of devices.

One minor correction:

> +static void c67x00_sched_done(unsigned long __c67x00)
> +{
> +	struct c67x00_hcd *c67x00 = (struct c67x00_hcd *)__c67x00;
> +	struct c67x00_urb_priv *urbp, *tmp;
> +	struct usb_hcd *hcd = c67x00_hcd_to_hcd(c67x00);
> +	struct urb *urb;
> +	int status;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&c67x00->lock, flags);
> +
> +	/* Loop over the done list and give back all the urbs */
> +	list_for_each_entry_safe(urbp, tmp, &c67x00->done_list, hep_node) {
> +		urb = urbp->urb;
> +		status = urbp->status;
> +
> +		c67x00_release_urb(c67x00, urb);
> +
> +		usb_hcd_unlink_urb_from_ep(hcd, urb);
> +
> +		spin_unlock_irqrestore(&c67x00->lock, flags);
> +		usb_hcd_giveback_urb(hcd, urb, status);
> +		spin_lock_irqsave(&c67x00->lock, flags);

The giveback routine is supposed to be called with interrupts disabled.  
Consequently you should use spin_unlock() and spin_lock() here, not the 
_irqsave/_irqrestore variants.

> +	}
> +	spin_unlock_irqrestore(&c67x00->lock, flags);
> +}

Alan Stern
