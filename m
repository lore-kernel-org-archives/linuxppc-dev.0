Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A4AF2DDDE9
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 10:34:53 +1000 (EST)
Subject: Re: [patch 00/14] Current 4xx patch series
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20070803002652.GX3925@crusty.rchland.ibm.com>
References: <41060.0659474314$1184697204@news.gmane.org>
	<f8tgfm$e2g$1@sea.gmane.org>
	<20070802163951.11c398ee@weaponx.rchland.ibm.com>
	<1186094296.5495.638.camel@localhost.localdomain>
	<20070803002652.GX3925@crusty.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 03 Aug 2007 10:29:44 +1000
Message-Id: <1186100984.5495.648.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-08-02 at 19:26 -0500, Josh Boyer wrote:
> On Fri, Aug 03, 2007 at 08:38:16AM +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2007-08-02 at 16:39 -0500, Josh Boyer wrote:
> > > 
> > > Someone brought up the fact that the EMAC rewrite is mostly just
> > > changing probing code and the guts are still similar to the current
> > > EMAC driver.  I haven't really looked into it yet, but if that's true,
> > > I'd be curious as to why it was done that way.
> > 
> > Ask :-) What specifically do you want to know ?
> 
> :)
> 
> Are the guts mostly the same, and if so why wasn't the existing driver just
> modified to do the device tree probing, perhaps in addition to the arch/ppc
> method?
>
> I can answer the "are they similar" myself with inspection, but I just haven't
> found the time yet.  So just some history about the patch would be good in
> general I think.

Guts are the same with subtle differences :-)

The main reason not to modify the existing one was because I wanted to
be conservative and not take any chance at breaking arch/ppc. Also, we
did that in earlier versions internally (have both OCP and device-tree
probing) and it's a terrible mess. Since arch/ppc is doomed, I wanted to
avoid designing something that can do both for no real benefit.

There are other subtle differences, such as the locking of the MDIO
accesses, and locking bits and pieces in general (EMAC wasn't tested in
SMP environments, and while it was tested with preempt, there are a few
subtle differences and issues that went unnoticed).

I also haven't brought back the workarounds for the loss of the Rx clock
with some PHYs at this stage. I need to get my hand on HW that has this
issue to be able to decide what to do I believe. The thing is, global
whacking of clock control registers like the old driver does is a bit
scary, totally per-chip-type, and requires locking vs. other parts of
the system that may want to access the same registers etc...

However, some of the chip folks told me it might be possible instead to
just use loopback mode when there is no link. So I want to investigate
that possibility first, but for that, I need HW that has the symptoms
and so far, I think I don't.

Finally, we still need to add in proper DMA unmapping. The current
driver never unmaps which is a problem on Axon when using the iommu.

Cheers,
Ben.
