Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ECFFD67CBF
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 10:55:08 +1100 (EST)
Subject: Re: [PATCH 11/16] PATA driver for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>, Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <20061115184416.GE21633@lst.de>
References: <200611150949.kAF9nGUY009229@toshiba.co.jp>
	<20061115184416.GE21633@lst.de>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 10:55:00 +1100
Message-Id: <1163634900.5940.290.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-11-15 at 19:44 +0100, Christoph Hellwig wrote:
> On Wed, Nov 15, 2006 at 06:49:15PM +0900, Ishizaki Kou wrote:
> > This patch adds PATA driver for Celleb platform.
> 
> This needs to go to linux-ide for review.  But IIRC new PATA drivers
> should use libata these days, not the old ide layer.

While I agree, there are still issues with libata vs. devices that needs
special IOps. libata allows you to override writing/reading taskfiles,
but there are cases, specifically in the EH/bus reset code, where it
still assumes the standard taskfile byte access format for a few things
and while it's possible to "override" these, that means re-implementing
a lot of logic in the driver.

I need to sort that out with Jeff one of these days as there is a
similar problem with the mpc52xx IDE driver.

In the meantime, I reckon it's ok to have a drivers/ide driver for
2.6.20

I have another question for Toshiba though. From my experience, the
Spider chip is very lousy vs. ordering of requests (it has several
severe violations of the PCI spec on the PCI and PCIe busses, requiring
the workarounds I've implemented in my recent serie of patches, the
worst one being that reads don't flush pending writes in the other
direction).

What is the kind of ordering guarantees provided by the IDE interface in
that case ? The main issue with IDE DMA is that you need to make sure
that by the time your ide_dma_end callback returns, all outstanding DMAs
done by the chip have completed. If the chip was writing to memory (due
to an IDE DMA READ operation), you must guarantee that all the data are
visible to the BE by the time you return from ide_dma_end().

This is typically not working with standard IDE controllers on spider as
they rely on an IO read from the device status register to perform that
flush of pending DMAs, according to the PCI spec, but on spider, no
flush occurs unless the "dummy read" function is used. That's the reason
why I implement a dummy read access after every MMIO read access in my
workarounds.

Thus there are two potential issues you need to clarify here:

 - Does your IDE controller guarantee some sort of ordering or not at
all ? I see that you have your own dma_end callback which does a read
from the "intsts_port" register. Will that guarantee a flush of
outstanding DMAs to the BE ?

 - Regarding PCI and PCIe on SCC, I didn't see any code in your PCI
support code for handling that issue. Is it fixed ? If not, then I
suppose you'll have problem with most PCI device/drivers on the field as
they do rely on such ordering to be provided. There was also an issue
with prefetch on PCI, for which I currently disable the prefetch in the
workarounds for the cell blade. I don't know if you handle that at all
neither.

Regards,
Ben.
