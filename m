Message-ID: <406DCAF1.1040602@acm.org>
Date: Fri, 02 Apr 2004 15:20:01 -0500
From: "Michael R. Zucca" <mrz5149@acm.org>
MIME-Version: 1.0
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problems with dma_alloc_coherent()
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com> <20040401185956.GB3786@gate.ebshome.net> <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com> <20040401191715.GC3786@gate.ebshome.net> <406C8104.9050609@acm.org> <20040401220018.GA4130@gate.ebshome.net> <D7F4C570-84C5-11D8-9FF0-000A95A07384@sands-edge.com> <406DB5DC.6060508@acm.org> <C9A11702-84DB-11D8-9FF0-000A95A07384@sands-edge.com>
In-Reply-To: <C9A11702-84DB-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


John Whitney wrote:

> I'm not trying to handle wierd bus scenarios... I'm just trying to
> figure out how to go from a virtual address to a DMA-controller specific
> one, with the constraints I have been told about with the LinuxPPC
> kernel, in an abstracted interface.  As I outlined in the previous
> message, I can't see a way to do this.

This is an approach that might have been good a number of years ago, but
I don't think it's going to cut it these days. DMA engines can be
anywhere and there can be a lot of intervening bridges. You can't always
assume that programming a DMA engine is just a matter of doing
virt_to_phys() and, voila, you're done. These days, you might have lots
of bridges in the way that might need to have mappings setup, and there
might be limited mapping resources so you can't just statically map the
world with the intention that the source or destination will have a
permanent address on the bus the DMA engine sits on.

A generic DMA API might do something like:

dma_move(main_memory_device, virtual_address,
          serial_port_device, pci_address, length) ;

or

dma_move(bulk_memory_card, pci_address,
          serial_port, pci_address, length) ;

A generic DMA API could then pick the best DMA controller at it's
disposal to push data from one bus to another. Once it has picked the
right DMA engine it would know what bridges lie between the DMA engine
and the source and destination devices. At that point it could translate
each of the given addresses so that they can be programmed into the DMA
engine.

> Heck, let's make it simple.  Let's say I have a high-speed serial port,
> and I want to DMA data to it with a known DMA controller (not
> abstracted) with a standard "device" structure associated with it.  The
> serial driver has the physical address of the 1-byte transmit register
> of the serial port that it wants to DMA to.  How does he make this into
> a physical address the known DMA controller device can use?  There is no
> phys_to_bus() macro, and it would be deprecated if it existed.  There is
> no DMA/PCI API for taking a physical address and converting it to a
> dma_addr_t for a specific device (the DMA controller).  I can't
> ioremap() the device, and pass that virtual address to the DMA API, as
> it will produce a bad physical address and I have been told this is the
> desired way for the API to work.

On 2.4, at least, I believe you are supposed to pci_map_* the item if
it's on PCI, take the address, slam in the DMA engine, and when the
transfer is complete, pci_unamp_* the item. I think, though, that this
might even be some hackery since I think the address you get from
pci_map may or may not be appropriate for the DMA engine depending on
where it lives.

Good bus support is kind of lacking in Linux :( It would be nice if
Linux had something more like NetBSD's bus_space/bus_dma stuff, or
something even better.

If what you need is generic address translation, I don't think that
exists yet in Linux. If you need it, you may have to cook it up yourself.

--
----------------------------------------------
  Michael Zucca - mrz5149@acm.org
----------------------------------------------
  "I'm too old to use Emacs." -- Rod MacDonald
----------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
