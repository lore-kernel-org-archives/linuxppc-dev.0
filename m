Return-Path: <stern@rowland.harvard.edu>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by ozlabs.org (Postfix) with SMTP id E73B3DDE37
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 14:56:25 +1100 (EST)
Date: Fri, 23 Nov 2007 22:56:21 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [linux-usb-devel] [PATCH 4/5] USB: add Cypress c67x00 OTG
	controller HCD driver
In-Reply-To: <20071124002446.25361.88850.stgit@trillian.cg.shawcable.net>
Message-ID: <Pine.LNX.4.44L0.0711232253530.29983-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	linux-usb-devel@lists.sourceforge.net, gregkh@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 23 Nov 2007, Grant Likely wrote:

> From: Grant Likely <grant.likely@secretlab.ca>
> 
> This patch adds HDC support for the Cypress c67x00 family of devices.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

> +static void c67x00_sched_done(unsigned long __c67x00)
> +{
> +	struct c67x00_hcd *c67x00 = (struct c67x00_hcd *)__c67x00;
> +	struct c67x00_urb_priv *urbp, *tmp;
> +	struct usb_hcd *hcd = c67x00_hcd_to_hcd(c67x00);
> +	struct urb *urb;
> +	int status;
> +
> +	spin_lock(&c67x00->lock);
> +
> +	/* Loop over the done list and give back all the urbs */
> +	list_for_each_entry_safe(urbp, tmp, &c67x00->done_list, hep_node) {
> +		urb = urbp->urb;
> +		status = urbp->status;
> +
> +		c67x00_release_urb(c67x00, urb);
> +
> +		usb_hcd_unlink_urb_from_ep(hcd, urb);
> +		usb_hcd_giveback_urb(hcd, urb, status);
> +	}
> +	spin_unlock(&c67x00->lock);
> +}

You need to release the spinlock around the call to 
usb_hcd_giveback_urb().  Otherwise you will deadlock if the completion 
routine submits another URB.

Alan Stern
