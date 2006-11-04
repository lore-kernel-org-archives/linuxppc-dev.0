Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94B8A67BD7
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 08:52:18 +1100 (EST)
Subject: Re: [PATCH/RFC] powerpc: Refactor 64 bits DMA operations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20061104132101.GA8704@lst.de>
References: <1162588895.10630.112.camel@localhost.localdomain>
	<20061104132101.GA8704@lst.de>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 08:52:08 +1100
Message-Id: <1162677128.28571.40.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-11-04 at 14:21 +0100, Christoph Hellwig wrote:
> On Sat, Nov 04, 2006 at 08:21:34AM +1100, Benjamin Herrenschmidt wrote:
> > This is also something I'll need in 2.6.20. Right now posted only for
> > comments though. It's known to "miss" fixup of at least pasemi and maybe
> > a few other things and I've not tested if I break 32 bits build yet :)
> > 
> > This patch completely refactors DMA operations for 64 bits powerpc. 32 bits
> > is untouched for now.
> 
> Can we please make 32bit use the same scheme for consistancy?  It would
> just plug in a set of dummy direct mapped ops, quite similar to what we
> do in Cell (just without setting the magic bit)

dma_64.c has a set of generic direct ops that could be used for 32 bits
as well. It's just that in addition to fairly different PCI code, 32
bits code use a wider variety of bus types and platform devices and does
DMA from them. All those would need to be updated to get the device
extension with the dma ops pointers.

That's why right now, I prefer leaving 32 bits alone. I do plan to
converge 32 and 64 bits PCI code, don't worry about that :-) At which
point I'll also tackle that issue.

Right now, 64 bits DMA is different, I'm not making it more or less
different, just differently different :-). Merging 32 bits here is just
not something I can do for 2.6.20 timeframe.

Ben
