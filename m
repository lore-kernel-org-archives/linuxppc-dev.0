Message-ID: <3EA6B8AF.8030005@embeddededge.com>
Date: Wed, 23 Apr 2003 12:00:47 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Frank Haverkamp <f.haverkamp@web.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Behaviour of consistent_{alloc|free}
References: <200304231355.h3NDttq00868@mailgate5.cinetic.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Frank Haverkamp wrote:

> I am working with a PowerPC 405 based asic having PCI_DRAM_OFFSET to be defined not to be zero.

Why?


> consistent_alloc returned a virtual address and the address on my pci bus.

I think you don't understand the value of PCI_DRAM_OFFSET.  This value is the
way system memory is mapped from the PCI bus, it does not represent a processor
mapping to the PCI bus.

> ... The address on the bus was
> returned correctly, but the mapping consistent_alloc was working was not like I expected it.

It did exactly what you asked.  It allocated free memory pages, then adjusted the
physical address by PCI_DRAM_OFFSET.  This address is what you should be giving
a device on the PCI bus for mastering buffers in your system memory.


> It maps the virtual address to an address on the bus and not to the real address of my DRAM.

Then, you don't have PCI_DRAM_OFFSET assigned a proper value.


> A mapping to the real address in DRAM is, what I wanted to have. I tried to do a virt_to_phys
> on the virtual address, but got, again, the address on the bus. And a bus_to_phys I could not find ;-)

You can't use any of the virt_to_* or bus_to_* functions on the addresses returned
by consistent_alloc.  This is why consistent_alloc() returns both a virtual address
for you to use for processor access, and a "bus" address handle to be given to the
device that will perform the DMA.  You have to stash these values in your driver
so you can reference them at later times when necessary.

In fact, if this is a PCI device, you should be using the pci_* functions as
described in Documentation/DMA-mapping.txt, and not using the consistent_alloc()
functions directly.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
