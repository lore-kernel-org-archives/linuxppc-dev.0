Message-ID: <397C7361.3E97D93D@raleigh.ibm.com>
Date: Mon, 24 Jul 2000 12:48:33 -0400
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 405gp pci mapping registers 
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The IBM405gp has 3 sets of PMM registers.  These allow extreme
flexibility in mapping
the where and how the PCI memory is configured into processor memory.

Each set of registers consist of 4 32 bit registers.

register offset 0 is the local address register
		4 is the mask/attribute register
		8 is the PCI low address register
		c is the PCI high address register.

Heres how is works.
The local address in the local address register are translated to the
address PCI address
specified in the PCI high/low address registers.
The mask register specifies the size of the area to be translated with
the least significant bit being an enable bit.



So if the local address register is specified at 0x80000000  and the PCI
low address registers 0x80000000, and the mask register is 0xffff0001,
then the bridge will translate
all address from the PLB bus 0x80000000 to pci address 0x80000000 with a
size of 64k.

This is interesting because since the 405gp has three sets of these
register leading to split mappings.  A good example if this is when a
video card is placed into on of the pci slots along with a card that
needs a memory BAR are placed in a IBM walnut board.

The open bios will map the memory bar to 405 memory 0x80000000 to PCI
memory 0x80000000, and the video card will get the mapping 405 memory
0xa0000000 to  pci memory 0x0.

This leads to a slit address map.

My question is this.  How should we manage this kind of address
flexability?

Chip

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
