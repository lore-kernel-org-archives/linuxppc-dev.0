Message-ID: <F1BD619B2A58D41197990050DA2C08E40258B1@SLINK12>
From: Jan Rovins <jrovins@ss7-link.com>
To: "Linux PPC Embeded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Cc: "'Adrian Cox'" <apc@agelectronics.co.uk>
Subject: Questions on PCI & Linux Kernel
Date: Tue, 30 Jan 2001 13:17:57 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are working on a Linux port to 860 cards that have a PLX 9060 & PLX 9054
PCI Bus master chips.
My Co-worker Steve has gotten some advice & example code for a PLX9080
implementation from Adrian Cox, (Thanks loads!).

I have some general basic questions here that I am posting to the list in
general so that others in a similar situation can benefit.
I need a better understanding of the stuff in io.h, & how it needs to be set
up for our PCI chip to work.

Our boards memory map is as follows
PCI chip interface registers:	0xC100,0000 - 0xC101,0000
PCI I/O Space:			0x6000,0000 - 0x8000,0000
PCI Mem Space:		0x4000,0000 - 0x5FFF,FFFF

I am looking for some clear explanations of the following io.h conventions:
PCI_ISA_IO_ADDR: 0x60000000
	is it ok to have a physical address here?
	I do a  ioremap of the this physical into isa_io_base is that
correct?
PCI_ISA_IO_SIZE:0x20000000
PCI_ISA_MEM_ADDR: 0x40000000
PCI_ISA_MEM_SIZE: 0x20000000
PCI_CSR_ADDR: 0xc1000000
	I take this to be the beginning of local access to our PCI chip,
	 or should it be the beginning of a specific register of the chip?
	Physical address Ok? or do we need to ioremap again?
PCI_CSR_SIZE: 0x10000
_IO_BASE: 0x60000000
	Should this be a Physical or virtual address?
	should it correspond to isa_io_base?
isa_io_base: 0xc4011000
	an ioremap of PCI_ISA_IO_ADDR
isa_mem_base: 0xc4017000
	an ioremap of PCI_ISA_MEM_ADDR
pci_dram_offset: 0x8000000
PCI_DRAM_OFFSET: 0x80000000
	This is being Hard set somewhere in the CONFIG_8XX code path, and I
need to grab control of it. (TBD)
Any explanations will be helpful
Thanks,
Jan Rovins
Member Technical Staff
S-Link Corp.
jrovins@ss7-link.com
856-642-9229 X-228


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
