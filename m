Message-Id: <199912041157.MAA00463@piglet.grunz.lu>
Date: Sat, 4 Dec 1999 12:57:03 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Update:  RE: G4 + Linux + PCI device + x86 driver = 0
To: dwp@bluesteelnet.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <NDBBKOPFGLPEGICBJFDIOEDCCDAA.dwp@bluesteelnet.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi David,

On   3 Dec, this message from David W. Patmore echoed through cyberspace:
> I posted a question about getting a PCI device working on LinuxPPC (G4!).
> Thanks to those who responded; your assistance made a big difference.  I
> finally finished my project, and wanted to post a few dribs that I had to
> deal with (that were different from the Linux x86 driver).

;-)

> 1.  I had to enable memory writes (PCI_COMMAND_MEMORY), which was somehow
> handled automataically on x86, but not here.

As far as I understand, i86 BIOS does this by default. However,
OpenFirmware does not. I've heard of numerous people run into this;
I've put together a kernel patch that adds a PCI fixup function on
PowerMacs, which enables memory and IO access if necessary.

>     For good measure, I also set PCI_COMMAND_MASTER, though I also call
> pci_set_master(), which covers the issue.

This, however, should have been enabled by OF. Are you sure setting
master 'sticks'? There is no other way to detect whether a deivce
supports bus mastering other then setting PCI_COMMAND_MASTER, and then
checking it really got set.

> 2.  I had to byte-swap all pointers that I supply to my device.  For
> portability, I made a set of macros, "SYS_TO_LE() and LE_TO_SYS(), etc. so
> that both endian architectures could work out.

Why do you need to pass pointers to your device? For DMA? If so, you
should not only byteswap your pointers, but also convert them between
CPU address space and PCI bus address space. Some PCI host bridges do
address transaltion, so you're not guaranteed both sides see the same
address. I use:

pci_device->dma_target = virt_to_bus(my_buffer);

I'ts defined in asm/io.h

> 3.  I had to byte-swap all data that I supply to my device, except the data
> that is handled as a byte stream.  This involved major discussions with my
> colleagues, because of the need to consider Big Endian, Little Endian, and
> Network Byte Order.

David pointed out le16_to_cpu() et al; personally, I use in_/out_le32
et al for access to PCI memory space like this:

out_le32 (&device->register, val);

These functions are available under both big- and little-endian
systems, and always do 'the right thing'. They are defined in
asm-ppc/io.h, and include I/O barrier instructions (preventing
reordering on the CPU).

If you don't want I/O barriers, there are also ld_/st_le_32 et al,
which are defined in asm-ppc/byteorder.h (included from asm/io.h).

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
