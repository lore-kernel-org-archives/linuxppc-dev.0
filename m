Return-Path: <stern+495b41de@rowland.harvard.edu>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by ozlabs.org (Postfix) with SMTP id EF8BBDDDEC
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Dec 2008 09:54:32 +1100 (EST)
Date: Wed, 24 Dec 2008 17:54:21 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH -mm 1/3] USB: FHCI: Driver should be responsible for
	managing endpoint queues
In-Reply-To: <20081224191303.GA21815@oksana.dev.rtsoft.ru>
Message-ID: <Pine.LNX.4.44L0.0812241752330.917-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 24 Dec 2008, Anton Vorontsov wrote:

> Follow these changes for the FHCI driver:
> 
> commit e9df41c5c5899259541dc928872cad4d07b82076
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Wed Aug 8 11:48:02 2007 -0400
> 
> USB: make HCDs responsible for managing endpoint queues

On the whole this looks good.

> --- a/drivers/usb/host/fhci-q.c
> +++ b/drivers/usb/host/fhci-q.c
> @@ -200,6 +200,9 @@ void urb_complete_free(struct fhci_hcd *fhci, struct urb *urb)
>  		else
>  			urb->status = 0;
>  	}
> +
> +	usb_hcd_unlink_urb_from_ep(fhci_to_hcd(fhci), urb);
> +
>  	spin_unlock(&fhci->lock);
>  
>  	usb_hcd_giveback_urb(fhci_to_hcd(fhci), urb, urb->status);

For the future you might think about not using urb->status at all.  The 
intention is eventually to remove that field.

Alan Stern
