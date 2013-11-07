Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:4])
 by ozlabs.org (Postfix) with ESMTP id 579C42C0332
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 13:34:26 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] ehci-platform: Merge ppc-of EHCI driver into the
 ehci-platform driver
Date: Thu, 07 Nov 2013 13:34:10 +1100
Message-ID: <1665413.2ZX3ZjkU7S@mexican>
In-Reply-To: <Pine.LNX.4.44L0.1311061110310.1220-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1311061110310.1220-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 6 Nov 2013 11:14:44 Alan Stern wrote:
> On Wed, 6 Nov 2013, Alistair Popple wrote:

[snip]

> > +	/* Initialise platform data from device tree if available. */
> > +	if (!dn) {
> 
> Shouldn't this be "if (dn)"?

Yep. Thanks.

> > +		if (of_get_property(dn, "big-endian", NULL)) {
> > +			pdata->big_endian_mmio = 1;
> > +			pdata->big_endian_desc = 1;
> > +		}
> > +		if (of_get_property(dn, "big-endian-regs", NULL))
> > +			pdata->big_endian_mmio = 1;
> > +		if (of_get_property(dn, "big-endian-desc", NULL))
> > +			pdata->big_endian_desc = 1;
> > +	}
> > +
> 
> This isn't good if there is more than one EHCI controller using
> ehci-platform.  To accomodate such cases, it would be necessary to
> allocate a separate copy of ehci_platform_defaults for each controller.

OK, that's a problem. Rather than allocating platform data for each controller 
I will move the device tree parsing into ehci_platform_reset().

> Alan Stern
