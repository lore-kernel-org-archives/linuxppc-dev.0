Message-Id: <200003242239.XAA00513@piglet.grunz.lu>
Date: Fri, 24 Mar 2000 23:39:45 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: PCI bus numbering?
To: mj@ucw.cz
cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Martin,

I have a few questions about the new 2.3 PCI code. I may have asked the
first one before, I don't remember...

Anyway, here they are:

1. I there an easy way to get at the struct pci_bus from the bus
number? I need to go and update resources on a bus I only know the
number of. Do I have to walk the list of buses?

2. Is there an easy way (again, short of walking the list of buses) to
get the next free bus number? Problem is: the newer Macs have a weired
host bridge called UNI-North, which in fact has three separate PCI
buses, but they are all labeled bus 0. In the PMac PCI ficup code, we
may want to renumber that and make them three separate buses.

Obviously, we'd like to leave the bus with the slots alone, so that any
cards with P2P bridges don't need to be renumbered. That leaves two
buses with a handful of (known) devices to put on to new buses, which we
need to number...

3. What addresses are IO-space resources supposed to contain? Bus
physical? Kernel virtual? On x86 platforms, it doesn't matter, but all
other platforms lack anything special about IO space, so they access it
as normal memory-mapped IO (albeit in very small chunks ;-).

On PowerMacs, the IO space on a PCI bus is mapped by the host bridge to
a regular memory region; so obviously there's an address translation
involved. With multiple host bridges (or UNI-North, for that
matter), there can be multiples of such translations. Hence, a simple
offset applied in inb() and friends doesn't help. The bridge init code
ioremap()s the IO space, and those are the addresses you want a driver
to use to acces the IO ports. Therefore it makes sense to put those
addresses into pci_dev's resources.

Which means that the hotplug resource (re)allocation code needs to know
about this, so it can convert the IO-port virtual address into physical,
de-offset it and write it into the BAR's.

Coments?

Michel

PS Anybody wants to take the subject to Linux-kernel and have other
archs' comments about it? I'm not on that list....

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
