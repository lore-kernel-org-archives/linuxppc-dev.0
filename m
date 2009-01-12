Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 1CA37DE1BC
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 04:56:27 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH RFC v5] net: add PCINet driver
Date: Mon, 12 Jan 2009 18:56:12 +0100
References: <20090107195052.GA24981@ovro.caltech.edu>
	<20090108215127.GA28935@ovro.caltech.edu>
	<1231630355.2142.92.camel@pasglop>
In-Reply-To: <1231630355.2142.92.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901121856.12814.arnd@arndb.de>
Cc: Ira Snyder <iws@ovro.caltech.edu>, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	shemminger@vyatta.com, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 11 January 2009, Benjamin Herrenschmidt wrote:
> On Thu, 2009-01-08 at 13:51 -0800, Ira Snyder wrote:
> > The guests (PowerPC computers running Linux) are PCI cards in the host
> > system (an Intel Pentium3-M system). The guest computers can access all
> > of the host's memory. The guests provide a 1MB (movable) window into
> > their memory.
> > 
> > The PowerPC computers also have a DMA controller, which I've used to get
> > better throughput from my driver. I have a way to create interrupts to
> > both the host and guest systems.
> 
> That looks -very- similar to the PCI driver for CAB and Cell triblades
> that was, I think, submitted a while ago. Arnd what's the status with
> that driver ?

Complicated ;-)

There were two device drivers for the Axon PCIe endpoint (from Mercury
and IBM), but both were abandoned due to being too complex to get into
a mergeable stage, and all the original developers are doing other work
now.

I'm maintaining the IBM driver now, but have no plans to submit that
for inclusion. I hope that I can soon find more time to work on a
replacement driver that will provide the right abstraction through
virtio for kernel drivers, plus a ibverbs user interface for direct
application programming. It should also have pluggable backends to
support not only Cell hardware but anything with a similar hardware
implementation.

I did make a presentation about this at the Plumbers Conference, see
http://userweb.kernel.org/%7Earnd/papers/plumbers08/plumbers-slides.pdf.
Since then, I have come to a much clearer idea of what needs to be
done, but not more actual code.

	Arnd <><
