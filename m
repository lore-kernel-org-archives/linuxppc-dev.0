Message-ID: <3A770C98.816516F1@mvista.com>
Date: Tue, 30 Jan 2001 13:48:56 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Jan Rovins <jrovins@ss7-link.com>
CC: "Linux PPC Embeded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>,
        "'Adrian Cox'" <apc@agelectronics.co.uk>
Subject: Re: Questions on PCI & Linux Kernel
References: <F1BD619B2A58D41197990050DA2C08E40258B1@SLINK12>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jan Rovins wrote:

> Our boards memory map is as follows
> PCI chip interface registers:   0xC100,0000 - 0xC101,0000
> PCI I/O Space:                  0x6000,0000 - 0x8000,0000
> PCI Mem Space:          0x4000,0000 - 0x5FFF,FFFF

OK.

>
> I am looking for some clear explanations of the following io.h conventions:

For 8xx, these definitions should go into your board specific file,
see mbx.h for example.  On MPC8xx boards, these addresses are all over
the place, and it is not appropriate to hack up io.h for this.

> PCI_ISA_IO_ADDR: 0x60000000
>         is it ok to have a physical address here?

Yes, that is what it is supposed to be (and should match the BARs
in your PCI devices....well must match :-).

>         I do a  ioremap of the this physical into isa_io_base is that
> correct?

Yes, but.......

> PCI_ISA_IO_SIZE:0x20000000
> PCI_ISA_MEM_ADDR: 0x40000000
> PCI_ISA_MEM_SIZE: 0x20000000

OK, but......

> PCI_CSR_ADDR: 0xc1000000
>         I take this to be the beginning of local access to our PCI chip,
>          or should it be the beginning of a specific register of the chip?

Depends how you want to access it.  It has to be properly aligned.

>         Physical address Ok? or do we need to ioremap again?

You MUST ioremap to access it.

> PCI_CSR_SIZE: 0x10000
> _IO_BASE: 0x60000000
>         Should this be a Physical or virtual address?
>         should it correspond to isa_io_base?

It should be #define _IO_BASE isa_io_base

> isa_io_base: 0xc4011000
>         an ioremap of PCI_ISA_IO_ADDR
> isa_mem_base: 0xc4017000
>         an ioremap of PCI_ISA_MEM_ADDR
> pci_dram_offset: 0x8000000
> PCI_DRAM_OFFSET: 0x80000000

Which is it?  This is the address of the physical memory as seen from
a PCI master viewpoint.

>         This is being Hard set somewhere in the CONFIG_8XX code path, and I
> need to grab control of it. (TBD)


OK, here is the 'but' part.......You can only ioremap the CSR address
in the MMU_init code.  The others must wait until the kernel VM is
initialized (mem_init_done is set, like later in 'm8xx_setup').  You
can only access your PCI memory and I/O space through VM windows in
the kernel space.  If you map these too early, you get a 1:1 mapping
virt:phys which will break everything because those virtual addresses
belong to user application space.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
