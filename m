Return-Path: <scottwood@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7C4F0B7116
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jan 2011 06:09:25 +1100 (EST)
Date: Wed, 26 Jan 2011 13:09:00 -0600
From: Scott Wood <scottwood@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: FSL DMA engine transfer to PCI memory
Message-ID: <20110126130900.7d38ba83@udp111988uds.am.freescale.net>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AC2A@saturn3.aculab.com>
References: <20110125135706.45f351a2@udp111988uds.am.freescale.net>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AC2A@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 26 Jan 2011 10:18:01 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

>  
> > What was the ppc you used?
> 
> The 8315E PowerQUIICC II

Ah.  The interconnect between the DMA engine and PCIe is different on
83xx.

> > The DMA engine and PCIe are both on OCeaN, so the traffic 
> > does not need to pass through the e500 Coherency Module.
> > My understanding -- for what it's worth, coming from a
> > software person :-) -- is that you should
> > be able to get large transfer chunks using the DMA engine.
> 
> It might be possible - but the ppc's pcie would need to know
> the length of the dma (or at least be told that there was more
> data to arrive) before even starting the pcie transfer.

On 85xx/QorIQ, I believe the connection between the DMA engine and the
PCIe controller allows the data to arrive in suitably large chunks.

> > I suggest getting things working, and then seeing whether the
> > performance is acceptable.
> 
> The only reason for using dma (instead of pio) is to get
> long pcie transfers - otherwise it isn't really worth the
> effort. Transfers are unlikely to take long enough to make
> it worth taking an interrupt at the end of the dma.

But in the absence of specific knowledge about this specific
chip, implementing it and testing is a good way of determining whether
you get those large PCIe transactions on this particular hardware.

And even if the transfers aren't particularly fast, if the total
transfer size (not the size of the chunks that go on the bus) is large
enough, it could be worth freeing up the core to do something else.  It
could also avoid running the data through the core's caches, or be a
transfer from one PCIe device to another, etc.  Don't be too quick to
say don't bother. :-)

> > > The generic dma controller can't even generate 64bit
> > > cycles into the ppc's PCIe engine.
> > 
> > Could you elaborate?
> 
> The pcie is (apparantly) a 64bit interface, to a single 32bit
> transfer is actually a 64bit one with only 4 byte enables driven.

My understanding is that PCIe is an aggregation of one or more
serial links, over which packets are sent.  I'm not sure to what extent
it makes sense to call it a 64-bit interface, other than addressing.

> I couldn't see anything that would allow a CSB master to generate
> two 32bit cycles (since it is a 32bit bus) that the pcie hardware
> could convert into a single 64bit pcie transfer.

Again, that's an 83xx thing, 85xx/QorIQ is different.

Though from the 8315 manual it looks like the CSB can do 64-bit data
(but not addresses).

-Scott
