Subject: Re: Problems with dma_alloc_coherent()
From: Adrian Cox <adrian@humboldt.co.uk>
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: "Michael R. Zucca" <mrz5149@acm.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <F6294392-84E8-11D8-9FF0-000A95A07384@sands-edge.com>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com>
	 <20040401100546.A27472@home.com>
	 <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com>
	 <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com>
	 <20040401185956.GB3786@gate.ebshome.net>
	 <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com>
	 <20040401191715.GC3786@gate.ebshome.net> <406C8104.9050609@acm.org>
	 <20040401220018.GA4130@gate.ebshome.net>
	 <D7F4C570-84C5-11D8-9FF0-000A95A07384@sands-edge.com>
	 <406DB5DC.6060508@acm.org>
	 <C9A11702-84DB-11D8-9FF0-000A95A07384@sands-edge.com>
	 <406DCAF1.1040602@acm.org>
	 <F6294392-84E8-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: text/plain
Message-Id: <1080978857.7999.813.camel@newt>
Mime-Version: 1.0
Date: Sat, 03 Apr 2004 08:54:18 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-04-02 at 22:01, John Whitney wrote:

> I've been thinking about changes to the API that would help this, and
> have come up with the following (for the lists' consideration, with
> possible submission to the kernel mailing list):
>
> 1. dma_addr_t should be changed from a flat physical address variable
> to a structure, containing both the physical address and the device it
> corresponds to.

Why not leave dma_addr_t alone, and create a new type for this class of
DMA engine. The new type would be a structure. The API then would be:

dma_move(struct gen_dma *src, struct gen_dma *dest, unsigned len);

Then struct gen_dma contains a union, to allow it to refer to memory
(using the current DMA api), PCI devices, or on-chip peripherals:
struct gen_dma {
	int bus_type;
	union {
		dma_addr_t memory_address;
		unsigned long bus_address;
        }
}
#define DMA_BUS_TYPE_MEM    0
#define DMA_BUS_TYPE_PCI    1

And each platform can define extra bus types
#define DMA_BUS_TYPE_ODDBUS 2

> 2. A macro should exist to convert this to a flat physical address:
> unsigned long dma_addr_to_phys (dma_addr_t *address);

The macro to convert a struct gen_dma to a flat address would be
specific to the platform. It wouldn't be in any global header. The
conversion would only happen one line of code before writing the flat
address into the DMA engine's register.

> 3. A macro should exist to convert it from one device's address space
> to another's: dma_convert_addr (device *to_dev, dma_addr_t *to_address,
> dma_addr_t *from_address);  If, due to dma_mask reasons the address is
> not valid for the requested device, this could return an error
> indicator, indicating the caller would have to allocate new memory and
> copy the contents over.

Again, easiest to implement inside the platform specific DMA controller
code.

> 4. The processor should have a "device" associated with it, and this
> should be assumed to be the device when it is specified as NULL to the
> DMA API routines: dma_alloc_coherent (NULL, ...) would mean "allocate
> contiguous/coherent memory for me, with the processor's address space
> used for the physical address".

Actually, what might be useful would be a NULL device to indicate the
platform DMA engine.

> 5. There should be a way of taking a local bus physical address, and
> converting it to the device's address space (dma_addr_t):
> dma_convert_phys (device *to_dev, dma_addr_t *address, unsigned long
> phys_addr).  Again, this could return an error indicator if the
> dma_mask shows the address won't work.

I don't really see why we need this.

> The problem I see is that the current API assumes sysmem<->dev, with
> the device itself doing the transfer.  I'm wanting to add a generic
> address-space-translation API to it that will allow other kinds of DMA
> transfers, and handle busses other than the PCI bus.

I think that this generic API can live inside the platform specific
implementation of the DMA controller.

There are three important sorts of address:

local memory - the DMA api gives us a handle to this
PCI devices - addresses found through struct pci_dev
on-chip peripherals, platform buses - addresses defined in platform
header files

> The main impact I see this having on drivers written with the current
> API is that they need to call dma_addr_to_phys() instead of just using
> the dma_addr_t as a physical address.
>
> Comments?

Leave the current API alone. It's fine for the common class of
peripherals. This is a completely new API for embedded devices.

I've not encountered a chip with more than one platform DMA controller.
Rather than having a top level API with low-level providers, consider
picking the implementation at Kconfig time.

- Adrian Cox


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
