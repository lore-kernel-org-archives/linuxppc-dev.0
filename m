Message-Id: <200006231224.OAA00765@piglet.grunz.lu>
Date: Fri, 23 Jun 2000 14:24:07 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Accessing IO space via resources
To: linuxppc-dev@lists.linuxppc.org
cc: Martin Mares <mj@suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Lots of discussion lately about IO issues on non-ia32 ;-)

Anyway, here is another problem related to IO space:

Until a few kernel versions ago, ioremap() of the IO region on PCI buses
happened to return the same virtual address as the physical address
requested to be mapped.

This was good, as it kept a potential problem hidden: the fact that
drivers want to access IO regions directly, without going through an
ioremap(). On ia32, with its separate IO address space, it's never a
problem since inb() and friends access the IO space directly, and
there's no remapping involved.

However, on non-ia32 platforms, IO space is regular memory space and
needs to be ioremp()'ed into kernel virtual address space. Now, the way
drivers find out about IO ports is most of the time via pci_dev resource
regions. These regions therefore need to contain kernel virtual
addresses. Strictly speaking, this was not the case. In standard
kernels, they contain the bus physical address, and inb() and friends
apply the needed offset to access the ports relative to kernel virtual
of port 0. In essence, it's this:

inb(port) == in_8(port + ioremap(bridge_offset(port_0)))

bridge_offset being the offset added by the PCI bridge.

Since bridge_offset is static, this works for a single bus only. I had
therefore modified the PCI fixup code to replace (port) in the resources
with (port + bridge_offset). This worked since the IO space was
ioremp()'ed 1:1.

Now, in the latest 2.4.0-ac kernels, ioremap() returns different
addresses, not 1:1 the original address anymore. And of course this
breaks the above scheme. (I've not looked into why this is so... I
suppose it's not a bug?)

Of course, I could fix the resources to show the remapped addresses, but
that would break the resource tree, since the entire tree shows phys
addresses. It would be harder as well to re-assign resources, since
before writing the new addresses out into PCI base regs, the correction
stuff needs to be undone. That would be workable, however.

So, what is the way to go? Let IO resources show kernel virtual, where
MEM resources show phys? Do some (inefficient, if at all possible) magic
in inb()? Something else?

Thanks for all comments, ideas and suggestions.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
