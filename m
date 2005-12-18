Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <3a8648f28b591dee596d6cb195f1cad1@kernel.crashing.org>
References: <1133816807.8577.50.camel@cashmere.sps.mot.com>
	<200512062048.56131.arnd@arndb.de> <1134856762.6102.54.camel@gaston>
	<3a8648f28b591dee596d6cb195f1cad1@kernel.crashing.org>
Content-Type: text/plain
Date: Sun, 18 Dec 2005 18:18:32 +1100
Message-Id: <1134890313.6102.78.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: RFC: Rev 0.5 Booting the Linux/ppc kernel without Open Firmware
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> No.  Their name can be whatever is required.  The "device_type" should
> be "pci", for conventional PCI busses; and it should be whatever is
> defined by the appropriate OF binding for newer, mostly PCI-comnpatible,
> busses (like HT, PCIe, PCI-X, etc.)

Yes, but the recommended practice is still to call them "pci" :) The
device_type of "pci" defines the fact that it's providing a PCI bus, but
is not unique to PCI hosts, p2p bridges share it. It's a convention for
a pci host bridge however to be named "pci" while a p2p bridge is named
"pci-bridge".

As for HT, PCI-X, PCI-E etc... I don't think there are much bindings
around, but I would recommend sticking strictly to the PCI one, only
adding something to either model or compatible. We may want to
standardize some additional things that aren't in the binding, like a
pci-family (pci, pci-e, pci-x, ht) property, or a extended-config-space
to advertise support for config space > 4096, etc.

At this point, I would really like to find out the remains of the OF
working group an kick that back into life to properly define those
things.

> It is up to a device's parent bus to find the correct driver; for
> the parent bus, device_type and/or compatible are normally enough
> to do the matching.  "model" is useful to disambiguate sometimes,
> but it normally is _too_ exact to do useful driver matching.

Except that OF platform devices don't really have a parent bus, they
expose a bus_type structure that can be used to match any device node in
the OF tree. There is no and there will not be a 1:1 relationship
between the OF device-tree and the linux one, so we must do compromises.

> Interrupts are evil evil evil as always ;-)

Yah, and I need to design something smart on the linux side to backup my
promise of not requiring device-nodes per PCI devices, since that means
not requiring nodes for p2p bridges neither, and thus impementing a
generic interrupt mapping algorithm that works both with full of
parsing, but also with partial one, doing standard swizzling for bridges
without a node (and with a platform hook to override that optionally).
On my todo list but not done yet.

> Yes, almost every SoC has at least two busses; e.g., you often see
> a high-speed coherent "system" bus, and a lower-speed non-coherent
> I/O bus connected to it.  But there are lots of variations to this
> theme.

That shouldn't be a problem anyway. Just cascade them and don't forget
the "ranges" property :)

> SMT threads should not be represented as separate CPUs.  But some
> CPU resources that are described in a CPU node are non-shared between
> SMT threads; we need to find a way to describe those.
> 
> The biggest problem is interrupts (as always); the unit-id for a
> "cpu" node in OF is the IPI number of that CPU, but on SMT, IPIs
> are per thread.

Yes, that's a problem

Ben.
