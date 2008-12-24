Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 13581DDE17
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Dec 2008 06:11:26 +1100 (EST)
Date: Wed, 24 Dec 2008 22:11:23 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] USB: Driver for Freescale QUICC Engine USB Host Controller
Message-ID: <20081224191123.GA16966@oksana.dev.rtsoft.ru>
References: <20081223210322.GA2802@oksana.dev.rtsoft.ru>
	<20081223132840.55e7b666.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081223132840.55e7b666.akpm@linux-foundation.org>
Cc: dbrownell@users.sourceforge.net, greg@kroah.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	leoli@freescale.com, timur@freescale.com
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 23, 2008 at 01:28:40PM -0800, Andrew Morton wrote:
> On Wed, 24 Dec 2008 00:03:22 +0300
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > This patch adds support for the FHCI USB controller, as found
> > in the Freescale MPC836x and MPC832x processors. It can support
> > Full or Low speed modes.
> > 
> > Quite a lot the hardware is doing by itself (SOF generation, CRC
> > generation and checking), though scheduling and retransmission is on
> > software's shoulders.
> > 
> > This controller does not integrate the root hub, so this driver also
> > fakes one-port hub. External hub is required to support more than
> > one device.
> > 
> 
> <quick scan>
> 
> Nice-looking driver.  But the namespace pollution is tremendous!

Thanks for the review, Andrew.

Name-space pollution fixed.

[..]
> > +static int fhci_mem_init(struct fhci_hcd *fhci)
> > +{
> > +	int i;
> > +	int error = 0;
> > +
> > +	fhci->hc_list = kzalloc(sizeof(*fhci->hc_list), GFP_KERNEL);
> > +	if (!fhci->hc_list)
> > +		return -ENOMEM;
> > +
> > +	INIT_LIST_HEAD(&fhci->hc_list->ctrl_list);
> > +	INIT_LIST_HEAD(&fhci->hc_list->bulk_list);
> > +	INIT_LIST_HEAD(&fhci->hc_list->iso_list);
> > +	INIT_LIST_HEAD(&fhci->hc_list->intr_list);
> > +	INIT_LIST_HEAD(&fhci->hc_list->done_list);
> > +
> > +	fhci->vroot_hub = kzalloc(sizeof(*fhci->vroot_hub), GFP_KERNEL);
> > +	if (!fhci->vroot_hub)
> > +		return -ENOMEM;
> 
> Did we leak fhci->hc_list?

Apparently. Fixed.

[...]
> > +struct ed *get_empty_ed(struct fhci_hcd *fhci)
> > +{
> > +	struct ed *ed;
> > +
> > +	if (!list_empty(&fhci->empty_eds)) {
> > +		ed = list_entry(fhci->empty_eds.next, struct ed, node);
> > +		list_del(fhci->empty_eds.next);
> > +	} else {
> > +		ed = kmalloc(sizeof(*ed), GFP_ATOMIC);
> > +		if (!ed)
> > +			fhci_err(fhci, "No memory to allocate to ED\n");
> > +		else
> > +			init_ed(ed);
> > +	}
> > +
> > +	return ed;
> > +}
> 
> The GFP_ATOMICs here are regrettable.  Are these functions ever called
> from a context in which a more reliable allocation mode can be used?
> If so, the caller should pass in the gfp_t.

No, these are called with a spinlock held. But we don't normally
allocate things via this function, instead we pre-allocate the eds
and tds in the fhci_mem_init, so the kmalloc above is the last resort
when no empty tds/eds left in the appropriate lists (normally should
not happen).

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
