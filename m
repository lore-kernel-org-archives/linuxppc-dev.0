Mime-Version: 1.0 (Apple Message framework v613)
In-Reply-To: <20040401220018.GA4130@gate.ebshome.net>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com> <20040401185956.GB3786@gate.ebshome.net> <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com> <20040401191715.GC3786@gate.ebshome.net> <406C8104.9050609@acm.org> <20040401220018.GA4130@gate.ebshome.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D7F4C570-84C5-11D8-9FF0-000A95A07384@sands-edge.com>
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: Re: Problems with dma_alloc_coherent()
Date: Fri, 2 Apr 2004 11:50:27 -0500
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


As an exemplification of the problem I am having with the current
DMA/PCI API:

I am developing a Generic DMA driver.  DMA providers register
themselves with it.  Clients ask the DMA core driver to please have a
registered driver transfer the data from one location to another, and
call them back when it is complete.

Now, let's look at my options:

1. The DMA-core API accepts physical addresses only for source and
destination.

This technically can't be done.  The virt_to_phys() API, I am told, is
deprecated and shouldn't be used by the kernel.  However, the client
code can't call dma_map_single() or dma_alloc_coherent(), because it
doesn't KNOW which providers are available and will be servicing the
request.

2. Okay, we'll make the DMA-core API accept only virtual addresses,
which it can map itself to the final driver.

Okay... this works well for the local memory (__get_free_pages() and
all), but the client has a physical address of a device it wants to
write to... how does it get a virtual address?  ioremap().  Bzzt!  The
address returned by ioremap is fully virtual, which dma_map_single()
can't accept (as it calls virt_to_bus(), which doesn't handle
fully-virtual addresses).

3. Well, darn.  How about the client calls
dma_map_single/dma_alloc_coherent with a NULL device, to get a physical
address for allocated local memory to pass to the DMA core?

Well, that sort of works.  However, do ALL platforms add the PCI bus
address-map-offset to the value?  How does the core (processor
independent) code know what to subract off to get back to the base
physical address?  There is no bus_to_phys() to phys_to_bus() routines,
and these would be deprecated even if they did exist.  How does it know
what to add to get back a bus-offset-phys-address suitable for the DMA
controller?  I guess the DMA core COULD call bus_to_virt() (although it
is deprecated), and then call dma_map_single() for the appropriate
device...

4. I suppose I COULD have a far more complicated dma_mem_to_dev() and
dma_dev_to_mem() and dma_dev_to_dev() and dma_mem_to_mem() kind of
interface, which mixed virtual and physical addresses.  Ugh.

Am I missing anything that should have made this all simpler?  If the
DMA/PCI API routines simply accepted ANY virtual address (fully-virtual
or semi-virtual), I wouldn't have this problem.  I'd simply accept
virtual addresses for the source and destination.

John


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
