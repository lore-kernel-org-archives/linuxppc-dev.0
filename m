Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Thu, 24 Aug 2000 11:14:58 +0200 (CEST)
From: Ronald Wahl <rwa@peppercon.de>
To: Gabriel Paubert <paubert@iram.es>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: allocating uncachable memory
In-Reply-To: <Pine.HPX.4.10.10008231558250.29062-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.21.0008241110480.933-100000@goliath.issistance.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 23 Aug 2000, Gabriel Paubert wrote:
> On Wed, 23 Aug 2000, Ronald Wahl wrote:
> > I'm writing a driver for a PCI controller in a PPC system. That driver
> > "exports" a bit of local ram into the PCI space. Now if some PCI device is
> > writing into this memory the local system won't notice it in all cases
>
> Yes, it will notice, unless there is a _serious_ bug in the host bridge.
> Accesses from the bridge to memory are snooped by the processor and the
> relevant cache lines are invalidated if necessary.
>
> The sequence is the following:
>
> - the PCI device requests the bus,
>
> - the PCI device becomes the master on the bus,
>
> - it puts an address and then data onto the (multiplexed) PCI bus,
>
> - the host bridge writes the data to system RAM at the specified address
> (beware of the difference between kernel, physical and PCI bus addresses),
> but before doing this the bridge signals the processor to invalidate or
> push to memory the corresponding cache lines.
>
> There is still a race with this kind of protocol: you need to read a
> register of you device in order to flush the buffers which might hold
> data on its way to memory in the host bridge.

What register? How do i flush the FIFOs of the PLX 9054? I played around
with the MARBR register but with no success so far. Maybe this register is
only used together with DMA but I need a flush mechanism that works w/o
DMA.

> Here is the code, guaranteed 100% bug-free ;-):
>
> ========================== CUT here ======================================
>
> ========================== CUT here ======================================

Haha. :-)

ron


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
