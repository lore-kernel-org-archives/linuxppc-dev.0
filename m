Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Ppc Developers" <linuxppc-dev@lists.linuxppc.org>
Subject: PCI architecture enlightenment
Date: Tue, 6 Aug 2002 07:43:30 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFKEGJDKAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was wondering if anyone could provide enlightenment on the PCI address
translation architecture. I have been looking at the code and it is not
obvious how all the different pieces fit together. I read
Documentation/pci.txt and it refers to device drivers not host controller
configuration and resource allocation.0

Our board:
Host phys: 0x40000000 - 0x47ffffff	=>
PCI I/O space 0x00000000 - 0x07ffffff

Host phys: 0x48000000 - 0x4fffffff =>
PCI Memory space 0x00000000 - 0x07ffffff

PCI phys: 0x40000000 -  0x47ffffff =>
Host Memory 0x00000000 - 0x07ffffff

Host Memory:
phys: 0x00000000
virt: 0xc0000000
size: 0x08000000

PCI BAR: (only 1 bus)
Memory: 0x00000000
I/O:    0x00000000

======================

When initializing a host controller how do the following interact?

hose->io_start/io_end
host->mem_start/mem_end
host->virt_io_addr

pci_init_resource(IO)
pci_init_resource(MEM)

PCI_ISA_IO...
PCI_ISA_MEM...
PCI_DRAM_OFFSET
_IO_BASE

Somehow the above information is used to create a host->PCI memory map,
PCI->host memory map and PCI->PCI memory map.

TIA


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
