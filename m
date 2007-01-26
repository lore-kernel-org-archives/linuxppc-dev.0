Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F9ADDE409
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 09:41:11 +1100 (EST)
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Grundler <grundler@parisc-linux.org>
In-Reply-To: <20070126171928.GA22275@colo.lackof.org>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083417.69895DE3C5@ozlabs.org>
	<20070126064352.GA328@colo.lackof.org>
	<m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
	<5A6F70E0-A8AB-4636-8F41-2EC82A3B13B7@kernel.crashing.org>
	<m1r6thvjdq.fsf@ebiederm.dsl.xmission.com>
	<20070126171928.GA22275@colo.lackof.org>
Content-Type: text/plain
Date: Sat, 27 Jan 2007 09:40:57 +1100
Message-Id: <1169851257.24996.185.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S.Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> What?!!! The whole point of the abstraction ("flat space") is
> to be able to do reverse lookups for additional information.

You may want to look at the virtual irq scheme we implemented for
powerpc, I think it could be useful for other architectures as well in
fact... One mistake I did was to put the documentation in the .h instead
of near the code though :-) asm-powerpc/irq.h is a good start to read.

The main reasons we did it in the first place are two fold:

 - On pSeries and to some extent with other hypervisors, IRQ numbers can
be pretty big, from encoding the geographical informations about the
slot/irq to just being an opaque 64 bits "token" from the hypervisor. So
we need the ability to map that to/from linux smaller and flatter space.

 - On a lot of machines, especially embedded (but not limited to), we
have all sort of crazy setups of cascaded controllers on cascaded
controllers. Maintaining a flat irq model covering all cases is
basically hopeless. So our remapper is designed such that each irq
"host" (or domain) defines it's own HW irq space and linux irqs can be
dynamically assigned to a pair host/hw_number.

The core provides the direct mapping linux irq (or virq) - > host/hw via
a simple array. It also provides 4 different types of reverse mapping
that the controller code can choose from for each controller:

 - Legacy: Since we decided to avoid problems that linux irq 0 is always
illegal and 1...15 area always "reserved" for a 8259 if any is present
in the machine, that's the option that the 8259 uses :-) It provides a
direct 1:1 mapping of 1...15 (enables them for use basically).

 - No reverse mapping: Some hypervisors are nice enough to let you
provide your virq numbers and they return them to you, so you can ask
for nothing

 - Linear reverse maping: for use by things like mpic where a simple
table is good enough

 - Radix tree reverse mapping: for things like pSeries with a very large
HW number space.

> > ia64 is the strong culprit
> > in this regard, and simply picks the next free number it can use
> > when a device asks for an irq.
> 
> I think this is the only viable aproach to support MSI migration.
> Basing the "virq" value on bits in the addr/data pair can't migrate.

Yes. On PowerPC, the virq will stay the same, though we can change
everything underneath (HW number, addr/data pair, etc...).

> It doesn't matter how many systems "do things closer to how x86"
> works since 95% (or more) of the systems running linux are x86.
> Linux MSI support must work on x86.

Most certainly :-)

> Helping Michael make it work would be a constructive way forward.
> I think Michael has the abstraction correct so it's NOT x86 centric
> but still works optimally on x86.

I think too.

> > On x86 the only hardware we have to deal with is the 8 bit number
> > delivered to the cpu at interrupt time and the MSI registers.
> 
> 8 bit number? That's the Intel Interrupt architecture definition.
> The PCI spec defines 16-bit messages for MSI. The chipsets
> can implement any number of bits they want up to that limits.

Indeed and we have MSI controllers that can deal with the full 16 bits
(the Cell Axon one for example).

> > All of
> > the rest of the x86 logic needed to translate MSI interrupts to
> > processor bus messages and the like has no registers we can set
> 
> Are the EID and ID fields defined in Intel adrresses not programmable?
> Those are part of the MSI address.

And thus the logic for doing that is platform specific and in the
backend with Michael's code, I don't see where the problem is there. I
agree Michael's code is missing a few things, mostly helpers for use by
the backend for masking/unmasking via config space and "updating" the
message/address, mostly things to add to the "raw" helpers. Oh, and
MSI-X of course need to be finished.

Ben.
