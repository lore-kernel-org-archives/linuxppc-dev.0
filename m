Date: Wed, 7 Aug 2002 08:16:50 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: PCI enlightenment follow-up
To: acurtis@onz.com
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <NCBBIINEHIPFGJPLBEIFGEHCDKAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E17cK7s-000080-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   6 Aug, this message from Allen Curtis echoed through cyberspace:
> ======= Board specs ========
> Host phys: 0x40000000 - 0x47ffffff	=>
> PCI I/O space 0x00000000 - 0x07ffffff
>
> Host phys: 0x48000000 - 0x4fffffff =>
> PCI Memory space 0x00000000 - 0x07ffffff
>
> PCI phys: 0x40000000 -  0x47ffffff =>
> Host Memory 0x00000000 - 0x07ffffff
>
> Host Memory:
> phys: 0x00000000
> virt: 0xc0000000
> size: 0x08000000
>
> PCI BAR: (only 1 bus)
> Memory: 0x00000000
> I/O:    0x00000000
>
> ========== Boot Messages ===========
> /* SCSI controller resource allocation is fine */
> PCI:00:0f.0: Resource 0: 47ffff00-47ffffff (f=101)
> PCI:00:0f.0: Resource 1: 4ffffc00-4fffffff (f=200)
> PCI:00:0f.0: Resource 2: 4fffc000-4fffdfff (f=200)

OK, obviously, the pci_dev resource regions get set up with the
necessary offset to get to the right address on the PCI bus.

> /* ==== sym53c8xx version 1 output ==== */
> sym53c8xx: at PCI bus 0, device 15, function 0
> sym53c8xx: 0x07fffc00 = pci_get_base_address(base)
> sym53c8xx: 0x07ffc000 = pci_get_base_address(base_2)

sym should _not_ play with these bus-view addresses. Have a look at the
driver where it gets these from.

> sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
> sym53c8xx: 53c895a detected
> sym53c895a-0: rev 0x1 on pci bus 0 device 15 function 0 irq 19
> sym53c8xx: device->slot.base = 0x07fffc00
> sym53c8xx: device->slot.base_2 = 0x07ffc000

Should contain the offset from host to PCI bus. With these addresses,
there's no way to access the SCSI card from the driver.

> sym53c895a-0: ID 7, Fast-40, Parity Checking
> /* vtobus() mapping looks ok */
> sym53c8xx: 0x404ba000 = vtobus(0xc04ba000)
> sym53c8xx: 0x404bd800 = vtobus(0xc04bd800)

Where do these come from? Is that DMA memory?

> sym53c8xx: np->base2_ba = 0x07ffc000
> /* 1-to-1 BAT mapping */
> sym53c8xx: 0x4fffc000 = remap_pci_mem(0x4fffc000, 0x00002000)

This looks good indeed.

> sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
> sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
> sym53c8xx: 0xf0ccff07 = cpu_to_scr(0x07ffccf0)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Nope, reversed address. That will not work. Don't touch the address,
touch the data if necessary. What needs to be swapped is data going
_over_ the little-endian PCI bus. Addreses don't go _over_ the bus, they
address resources _on_ the bus.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
