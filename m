Date: Wed, 23 Apr 2003 15:55:55 +0200
Message-Id: <200304231355.h3NDttq00868@mailgate5.cinetic.de>
MIME-Version: 1.0
From: "Frank Haverkamp" <f.haverkamp@web.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Behaviour of consistent_{alloc|free}
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am working with a PowerPC 405 based asic having PCI_DRAM_OFFSET to be defined not to be zero.
I was using consistent_alloc to get a memory area to be used by my ethernet driver for its descriptor tables.

consistent_alloc returned a virtual address and the address on my pci bus. The address on the bus was
returned correctly, but the mapping consistent_alloc was working was not like I expected it.
It maps the virtual address to an address on the bus and not to the real address of my DRAM.
A mapping to the real address in DRAM is, what I wanted to have. I tried to do a virt_to_phys
on the virtual address, but got, again, the address on the bus. And a bus_to_phys I could not find ;-)

Now I wondered, how consistent_free could work, since consistent_alloc did a get_free_pages, but did not store the physical address of that buffer somewhere. Instead it stored the bus address. I did the following experiment:

TEST TEST TEST ...
DESCR: virt_addr=0xc7b82000 bus_addr=0xf6e6b000
       phys_addr=0xf6e6b000 pci_dram_offset=0xf4000000
DESCR: virt_addr=0xc7b82000 bus_addr=0xf6e6a000
       phys_addr=0xf6e6a000 pci_dram_offset=0xf4000000
DESCR: virt_addr=0xc7b82000 bus_addr=0xf6e91000
       phys_addr=0xf6e91000 pci_dram_offset=0xf4000000
DESCR: virt_addr=0xc7b82000 bus_addr=0xf6e90000
       phys_addr=0xf6e90000 pci_dram_offset=0xf4000000
DESCR: virt_addr=0xc7b82000 bus_addr=0xf6e29000
       phys_addr=0xf6e29000 pci_dram_offset=0xf4000000
DESCR: virt_addr=0xc7b82000 bus_addr=0xf6e28000
       phys_addr=0xf6e28000 pci_dram_offset=0xf4000000

I was wondering if that can be correct, since I am allocating the same amount of memory all the time and returning it immediatly after doing that. So I would expect, that the function returns the same physical and bus addresses again, since I expect it to be deterministic.

After thinking about it I modified consistent_alloc in the following way:

        ....
        /* Allocate some common virtual space to map the new pages.
        */
        area = get_vm_area(size, VM_ALLOC);
        if (area == 0) {
                free_pages(page, order);
                return NULL;
        }
        va = VMALLOC_VMADDR(area->addr);
        ret = (void *)va;

        /* This gives us the real physical address of the first page.
        */
#if defined(WITH_MY_FIX)
        *dma_handle = virt_to_bus(page);
        pa = virt_to_phys(page);
#else
        *dma_handle = pa = virt_to_bus(page);
#endif

        flags = _PAGE_KERNEL | _PAGE_NO_CACHE;

        err = 0;
        for (i = 0; i < size && err == 0; i += PAGE_SIZE)
                err = map_page(va+i, pa+i, flags);
        ....

Now the returned mapping done to the physical memory instead of the bus addresses, which I cannot access directly on my system. Now my system can perform the consistent_free function correctly and it prints:

DESCR: virt_addr=0xc7b82000 bus_addr=0xf6e53000
       phys_addr=0x02e53000 pci_dram_offset=0xf4000000
DESCR: virt_addr=0xc7b82000 bus_addr=0xf6e53000
       phys_addr=0x02e53000 pci_dram_offset=0xf4000000
DESCR: virt_addr=0xc7b82000 bus_addr=0xf6e53000
       phys_addr=0x02e53000 pci_dram_offset=0xf4000000
DESCR: virt_addr=0xc7b82000 bus_addr=0xf6e53000
       phys_addr=0x02e53000 pci_dram_offset=0xf4000000
DESCR: virt_addr=0xc7b82000 bus_addr=0xf6e53000
       phys_addr=0x02e53000 pci_dram_offset=0xf4000000
DESCR: virt_addr=0xc7b82000 bus_addr=0xf6e53000
       phys_addr=0x02e53000 pci_dram_offset=0xf4000000

Which I consider to be ok. If I observed that correctly, consistent_alloc has a memory leak and strange things may happen if consistent_free is called. Any opinions on that?


Frank Haverkamp

--
Frank Haverkamp
f.haverkamp@web.de
______________________________________________________________________________
UNICEF bittet um Spenden für die Kinder im Irak! Hier online an
UNICEF spenden: https://spenden.web.de/unicef/special/?mc=021101


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
