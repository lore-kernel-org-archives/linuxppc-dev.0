Date: Tue, 6 Aug 2002 08:06:34 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: PCI/SCSI help
To: acurtis@directvinternet.com
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <NCBBIINEHIPFGJPLBEIFCEGADKAA.acurtis@directvinternet.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E17bxUO-00009x-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   5 Aug, this message from acurtis@directvinternet.com echoed through cyberspace:
[snip]
> PCI Autoconfig: Device 15, Vendor 0x1000, Class 0x1000001
> PCI Autoconfig: Found Bus 0, Device 15, Function 0
> PCI Autoconfig: BAR 0x10, I/O, size=0x100, address=0x7ffff00
> PCI Autoconfig: BAR 0x14, Mem size=0x400, address=0x7fffc00
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
These two overlap. Firmware in Intel mode with separate IO and mem
spaces?

> Fixup res 0 (101) of dev 00:0f.0: 7ffff00 -> 47ffff00 (I/O)
> Fixup res 1 (200) of dev 00:0f.0: 7fffc00 -> 4ffffc00 (Mem)
> Fixup res 2 (200) of dev 00:0f.0: 7ffc000 -> 4fffc000 (Mem)

OK, now they don't overlap anymore.

> sym53c8xx: at PCI bus 0, device 15, function 0
> sym53c8xx: 0x07fffc00 = pci_get_base_address(base)
> sym53c8xx: 0x07ffc000 = pci_get_base_address(base_2)

What's it doing with these values? Where does it get them from? Those
are the original, un-moved addresses. Both BAR and pci_dev should have
been changed by pcibios_fixup_resources(). Have a look at that code and
see why the corrected base addresses are not written back.

> sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^
Sym seems to always do this. Not sure it is OK to set it when the
underlying bus doesn't support parity, as in PowerMacs... Could be OK
here, though.

> sym53c8xx: 53c895a detected
> sym53c895a-0: rev 0x1 on pci bus 0 device 15 function 0 irq 19
> sym53c8xx: device->slot.base = 0x07fffc00
> sym53c8xx: device->slot.base_2 = 0x07ffc000
                                 ^^^^^^^^^^^^
Nope, wrong again.

> sym53c8xx: np->base2_ba = 0x07ffc000 /* as read from BAR */
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Well, BAR is wrong then. This has been remapped elsewhere.

> sym53c8xx: 0x4fffc000 = remap_pci_mem(0x4fffc000, 0x00002000)
             ^^^^^^^^^^
Ah? Now it's right??

> sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
> sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
> sym53c8xx: 0xf0ccff07 = cpu_to_scr(0x07ffccf0) /* just byte swapping */
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I hope it's not byteswapping an address here?

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
