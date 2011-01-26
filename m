Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 3F7C4B70EE
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jan 2011 21:20:27 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP id 17749-10 for <linuxppc-dev@ozlabs.org>;
	Wed, 26 Jan 2011 10:20:12 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: FSL DMA engine transfer to PCI memory
Date: Wed, 26 Jan 2011 10:18:01 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AC2A@saturn3.aculab.com>
In-Reply-To: <20110125135706.45f351a2@udp111988uds.am.freescale.net>
From: "David Laight" <David.Laight@ACULAB.COM>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> What was the ppc you used?

The 8315E PowerQUIICC II

> On 85xx/QorIQ-family chips such as P2020, there is no DMA controller
> inside the PCIe controller itself (or are you talking about bus
> mastering by the PCIe device[1]?  "interface" is a bit ambiguous),
> though it was considered part of the PCI controller on 82xx.
>=20
> The DMA engine and PCIe are both on OCeaN, so the traffic=20
> does not need to pass through the e500 Coherency Module.
> My understanding -- for what it's worth, coming from a
> software person :-) -- is that you should
> be able to get large transfer chunks using the DMA engine.

It might be possible - but the ppc's pcie would need to know
the length of the dma (or at least be told that there was more
data to arrive) before even starting the pcie transfer.
I used 128 bytes per pcie transfer (which the altera slave
can handle) but that is longer than you want a burst on
the internal (CSB in my case) bus on the ppc.
It is also longer than a cache line - so the dma engine's
memory reads might induce a cache flush.=20

> I suggest getting things working, and then seeing whether the
> performance is acceptable.

The only reason for using dma (instead of pio) is to get
long pcie transfers - otherwise it isn't really worth the
effort. Transfers are unlikely to take long enough to make
it worth taking an interrupt at the end of the dma.

My device driver implements read() and write() (and poll()
to wait for interrupts). So I do overlap the copy_to/from_user
with the next dma.

> > The generic dma controller can't even generate 64bit
> > cycles into the ppc's PCIe engine.
>=20
> Could you elaborate?

The pcie is (apparantly) a 64bit interface, to a single 32bit
transfer is actually a 64bit one with only 4 byte enables driven.

I couldn't see anything that would allow a CSB master to generate
two 32bit cycles (since it is a 32bit bus) that the pcie hardware
could convert into a single 64bit pcie transfer.
The fpga target is likely to have 32bit targets (it could have
64 bit ones, but if you've instantiated a NiosII cpu it wont!)
so you get a bus width adapter (which carefully does the cycle
with no byte enables driven) as well as the clock crossing bridge.
These both make the slave even slower than it would otherwise be!

IIRC We managed to get 2us for a read and 500ns for a write cycle.
The per byte costs are relatively small in comparison.

	David
