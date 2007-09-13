Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8C051DDDD8
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 00:49:30 +1000 (EST)
Date: Thu, 13 Sep 2007 09:49:19 -0500
From: Scott Wood <scottwood@freescale.com>
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
Subject: Re: [PATCH 5/5] Add DMA engine driver for Freescale MPC85xxprocessors.
Message-ID: <20070913144919.GB32043@ld0162-tx32.am.freescale.net>
References: <11891624582950-git-send-email-wei.zhang@freescale.com>
	<20070907223553.GA18599@freescale.com>
	<46B96294322F7D458F9648B60E15112C85D8A5@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46B96294322F7D458F9648B60E15112C85D8A5@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, dan.j.williams@intel.com, shannon.nelson@intel.com,
	paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 13, 2007 at 03:13:06AM -0700, Zhang Wei-r63237 wrote:
> > After dropping the lock, you can no longer assume that your 
> > iterator is
> > still valid; you need to work off of the list head.
> > 
> 
> list_for_each_entry_safe() is used here. I think the safe should be ok.
> :P

Nope.  The safety is against the particular item you're iterating on
being removed; it doesn't protect against the *next* entry being removed
when you drop the lock.

> > Why not use an array of channels?
> 
> The list is used in dma engine core file. And it's possible that there
> are not all channel listed in dts and array.

I'm not sure I understand what you mean by the latter comment...

> > You could have the features be part of the match struct, so 
> > you don't have
> > to do extra strcmps.
> > 
> 
> Can I use the data field of struct of_device_id?

Yes, that's what it's there for. :-)

> > > +static struct of_device_id of_fsl_dma_ids[] = {
> > > +	{ .compatible = "fsl,dma", },
> > > +};
> > 
> > Why do we need to bind to the parent node at all?
> 
> Yes, the MPC83xx should get interrupt source from DMA device register.

You don't need to bind to it for that, though -- just call of_get_parent
from the channel probe.  Though it might be easier to bind to the parent
to ensure that you only register the IRQ once.

-Scott
