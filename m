Date: Sun, 16 May 2004 14:57:36 +0200 (CEST)
From: Oliver Korpilla <okorpil@fh-landshut.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Memory layout question
Message-ID: <Pine.LNX.4.33.0405161456020.1169-100000@lux32.if.fh-landshut.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I'm currently trying out the VMIC Tundra Universe II driver, a PCI-VME bus
bridge quite common in embedded devices (from VMIC and Motorola). VMIC
manufactures mostly x86 boards, but I try to use the driver on a MVME5500
with 7455 Motorola PPC.

There seems to be a memory problem involved, as follows:

The device will react if a PCI cycle contains addresses stored in its
device registers. If you tell the device, that it has a window starting
from 0x40000000 with size 0x100000, it will try to satisfy requests on the
bus for that addresses with data from the VME bus (the VME address, that
is separate from the PCI address, is stored in the device registers as
well).

This seems to work fine and dandy on the x86, and there seems to be
something wrong on the PowerPC.

The device driver module uses allocate_resource (&iomem_resource, ...... )
to request a set of physical addresses, and uses ioremap_nocache to map
those addresses to virtual ones. Idea behind this is, that any request to
the I/O memory will trigger bus cycles, and those bus cycles will be
catched by the device.

There is no actual I/O memory involved in the device - its registers are
read and written elsewhere. The addresses are only used to trigger bus
accesses.

Well, guess what, those accesses don't happen. While the DMA part of the
driver happens to work (relying on a different mechanism), this fails.

Actually the addresses returned by allocate_resource seem to come from
system memory, because ioremap_nocache logs a debug statement that is only
triggered if the remapping is below the high_memory bound. (And there
already seems to be a virtual address associated with it - physical
0x40000000 is RAM 0xc<whatever> - kernel space, I guess)

But the address returned is 0x40000000 !! Isn't that the 2nd GB of address
space? My board only has 512 MB of storage, and is only upgradable to 1GB,
so shouldn't an address starting at 0x40000000 physically never be a
memory address and never be below the high_memory bound?

When calling allocate_resource you can already limit the range of possible
addresses - in my case default is 0x00000000 and 0xffffffff (no limit).
The value returned seems to be consistently 0x40000000. What could be a
safe value for the lower bound, say e.g. 0x80000000 or something?

Can I even dereference an I/O memory pointer on the PowerPC? (It can be
done on x86) I know, I know, I _should_ use readb and friends, but can it
be done? Or _must_ I strictly use the macros because it won't work the
other way round?

Thanks in advance,
Oliver Korpilla


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
