In-Reply-To: <406DCAF1.1040602@acm.org>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com> <20040401185956.GB3786@gate.ebshome.net> <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com> <20040401191715.GC3786@gate.ebshome.net> <406C8104.9050609@acm.org> <20040401220018.GA4130@gate.ebshome.net> <D7F4C570-84C5-11D8-9FF0-000A95A07384@sands-edge.com> <406DB5DC.6060508@acm.org> <C9A11702-84DB-11D8-9FF0-000A95A07384@sands-edge.com> <406DCAF1.1040602@acm.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F6294392-84E8-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: Re: Problems with dma_alloc_coherent()
Date: Fri, 2 Apr 2004 16:01:50 -0500
To: "Michael R. Zucca" <mrz5149@acm.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> This is an approach that might have been good a number of years ago,
> but I don't think it's going to cut it these days. DMA engines can be
> anywhere and there can be a lot of intervening bridges. You can't
> always assume that programming a DMA engine is just a matter of doing
> virt_to_phys() and, voila, you're done. These days, you might have
> lots of bridges in the way that might need to have mappings setup, and
> there might be limited mapping resources so you can't just statically
> map the world with the intention that the source or destination will
> have a permanent address on the bus the DMA engine sits on.
>
> A generic DMA API might do something like:
>
> dma_move(main_memory_device, virtual_address,
>          serial_port_device, pci_address, length) ;
>
> or
>
> dma_move(bulk_memory_card, pci_address,
>          serial_port, pci_address, length) ;
> A generic DMA API could then pick the best DMA controller at it's
> disposal to push data from one bus to another. Once it has picked the
> right DMA engine it would know what bridges lie between the DMA engine
> and the source and destination devices. At that point it could
> translate each of the given addresses so that they can be programmed
> into the DMA engine.

In fact, there is only one address translation that is important: the
processor's view of the end-points' physical address to the DMA
controller's view.  The bridges should handle all other necessary
translations transparently (I won't swear to that, but I can't think of
any example that contradicts that, although you might not be able to
"get there" from the DMA controller if it is on a different bus...).

However, I'm not trying to come up with a good interface, really.  I'm
trying to show "you can't get there from here" with the current DMA API
implementation.

> On 2.4, at least, I believe you are supposed to pci_map_* the item if
> it's on PCI, take the address, slam in the DMA engine, and when the
> transfer is complete, pci_unamp_* the item. I think, though, that this
> might even be some hackery since I think the address you get from
> pci_map may or may not be appropriate for the DMA engine depending on
> where it lives.

That's the problem.  pci_map_* and dma_map_* are not ALLOWED to take
fully-virtual addresses, the kind that ioremap() produces (they produce
totally bogus DMA addresses, as they just subtract off PCI_DRAM_OFFSET
currently).  Without that being allowed, how do I convert the
processor-local-bus physical address I have for a direct memory mapped
device, and generically translate it to the DMA controller's address
space?

I've been thinking about changes to the API that would help this, and
have come up with the following (for the lists' consideration, with
possible submission to the kernel mailing list):

1. dma_addr_t should be changed from a flat physical address variable
to a structure, containing both the physical address and the device it
corresponds to.
2. A macro should exist to convert this to a flat physical address:
unsigned long dma_addr_to_phys (dma_addr_t *address);
3. A macro should exist to convert it from one device's address space
to another's: dma_convert_addr (device *to_dev, dma_addr_t *to_address,
dma_addr_t *from_address);  If, due to dma_mask reasons the address is
not valid for the requested device, this could return an error
indicator, indicating the caller would have to allocate new memory and
copy the contents over.
4. The processor should have a "device" associated with it, and this
should be assumed to be the device when it is specified as NULL to the
DMA API routines: dma_alloc_coherent (NULL, ...) would mean "allocate
contiguous/coherent memory for me, with the processor's address space
used for the physical address".
5. There should be a way of taking a local bus physical address, and
converting it to the device's address space (dma_addr_t):
dma_convert_phys (device *to_dev, dma_addr_t *address, unsigned long
phys_addr).  Again, this could return an error indicator if the
dma_mask shows the address won't work.
6. With the above changes, the device or bus objects would have to
include their address-space offset from the PLB address space.  This
would handle non-PCI buses, and allow you to convert from one to
another (device1->PLB->device2).
7. It would also be REALLY nice if the DMA/PCI API could take fully
virtual addresses with the ..._map_single()/_map_sg() calls.  They are
implemented in architecture-specific areas that know how to walk their
own page tables, so why NOT allow them?  I understand the dangers of
having contiguous pages mapped to non-contiguous physical addresses,
but that's a lot easier to explain than "virtual addresses from here
will work, but not from there, and also not from THERE if your platform
is not cache-coherent).


The problem I see is that the current API assumes sysmem<->dev, with
the device itself doing the transfer.  I'm wanting to add a generic
address-space-translation API to it that will allow other kinds of DMA
transfers, and handle busses other than the PCI bus.

The main impact I see this having on drivers written with the current
API is that they need to call dma_addr_to_phys() instead of just using
the dma_addr_t as a physical address.

Comments?

John


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
