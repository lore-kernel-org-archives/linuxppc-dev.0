In-Reply-To: <1080978857.7999.813.camel@newt>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com> <20040401185956.GB3786@gate.ebshome.net> <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com> <20040401191715.GC3786@gate.ebshome.net> <406C8104.9050609@acm.org> <20040401220018.GA4130@gate.ebshome.net> <D7F4C570-84C5-11D8-9FF0-000A95A07384@sands-edge.com> <406DB5DC.6060508@acm.org> <C9A11702-84DB-11D8-9FF0-000A95A07384@sands-edge.com> <406DCAF1.1040602@acm.org> <F6294392-84E8-11D8-9FF0-000A95A07384@sands-edge.com> <1080978857.7999.813.camel@newt>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <811D8989-856C-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: Re: Problems with dma_alloc_coherent()
Date: Sat, 3 Apr 2004 07:43:27 -0500
To: Adrian Cox <adrian@humboldt.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> 1. dma_addr_t should be changed from a flat physical address variable
>> to a structure, containing both the physical address and the device it
>> corresponds to.
>
> Why not leave dma_addr_t alone, and create a new type for this class of
> DMA engine. The new type would be a structure. The API then would be:
>

One reason I wanted them to be in the same system was for the following
scenario:

I created a standard DMA memory area, passed the dma_addr_t to an
ethernet controller, and received a packet.  Now I want to pass that
packet to a decryption engine via an onboard DMA controller.  If I
could convert the DMA address suitable for the ethernet controller to
one suitable for the DMA controller, nothing else would be necessary.
Otherwise, I'll possibly have to walk the page table to convert the
virtual address to the area they got back to a physical address
suitable for the DMA controller.

> dma_move(struct gen_dma *src, struct gen_dma *dest, unsigned len);
>
> Then struct gen_dma contains a union, to allow it to refer to memory
> (using the current DMA api), PCI devices, or on-chip peripherals:
> struct gen_dma {
> 	int bus_type;
> 	union {
> 		dma_addr_t memory_address;
> 		unsigned long bus_address;
>         }
> }

This is effectively my interface, although I take an array of
src/dst/length/flag entries for scatter-gather type DMAs.  Flags allow
specification of special transfers such as "destination-held 1 byte".

> #define DMA_BUS_TYPE_MEM    0
> #define DMA_BUS_TYPE_PCI    1
>
> And each platform can define extra bus types
> #define DMA_BUS_TYPE_ODDBUS 2
>

You used dma_addr_t in your gen_dma struct type.  From what I have
seen, a dma_addr_t is ALWAYS in the PCI-bus address space.  Perhaps
just an "unsigned long" to contain a physical address in the local-bus
memory space, and the DMA driver converts this to its own address space
(more on this below)?

>> 2. A macro should exist to convert this to a flat physical address:
>> unsigned long dma_addr_to_phys (dma_addr_t *address);
>
> The macro to convert a struct gen_dma to a flat address would be
> specific to the platform. It wouldn't be in any global header. The
> conversion would only happen one line of code before writing the flat
> address into the DMA engine's register.

Are there any multi-platform DMA controllers that might make this
difficult, I wonder?

>> 5. There should be a way of taking a local bus physical address, and
>> converting it to the device's address space (dma_addr_t):
>> dma_convert_phys (device *to_dev, dma_addr_t *address, unsigned long
>> phys_addr).  Again, this could return an error indicator if the
>> dma_mask shows the address won't work.
>
> I don't really see why we need this.

To convert a PLB specific address to another device's address-space.
With the current DMA API, you can't do this without the address being
in RAM (otherwise, it wouldn't have a semi-virtual address).  On the
PowerPC side, this would usualy have been a no-op, or an addition of
PCI_DRAM_OFFSET to the given address.  Whether this is needed for the
"new" API we are discussing is another matter.

> Leave the current API alone. It's fine for the common class of
> peripherals. This is a completely new API for embedded devices.
>
> I've not encountered a chip with more than one platform DMA controller.
> Rather than having a top level API with low-level providers, consider
> picking the implementation at Kconfig time.
>

As long as each driver has a common interface, so that I could write a
module that uses that interface, and works with different DMA
controllers on different platforms, I don't have a problem with doing
it this way.

One of the nice things about having the DMA-core, however, was that it
accepted virtual addresses and handled cache consistency.  If the
driver is accepting physical addresses only, it can't do that.  This
means the client would have to allocate space using the DMA/PCI to get
the same coherency, which means all addresses will be
PCI-address-space.  Should the individual drivers accept this and just
subtract off PCI_DRAM_OFFSET (or equivalent) to get back to a physical
address?  This is what would make life hell for a cross-platform DMA
controller.

Good suggestions, thanks!

John


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
