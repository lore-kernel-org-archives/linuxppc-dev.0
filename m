In-Reply-To: <v04220802b500d91f6693@[10.0.0.42]>
Date: Fri, 24 Mar 2000 10:43:34 +0100
To: "Timothy A. Seufert" <tas@mindspring.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: LongTrail PCI resource assignment
Message-Id: <20000324104334.016529@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 24, 2000, Timothy A. Seufert <tas@mindspring.com> wrote:


>1. Duplication of information across multiple data structures is
>evil.  It should be avoided at all costs.
>
>If there was a really, really good reason to keep OF up to date
>(like, say, if we could break back into the OF console like you can
>on Sparcs), then it would be OK.  Otherwise it is most likely
>unnecessary bloat, and leads to potential confusion (and bugs).  Is
>there any such reason on ppc?

The OF tree is still used by devices inside the mac-io chip. But in this
case, the PCI bus number is not used. There are a few places where we
need to find the OF entry for a PCI device in order to read some
properties left by MacOS/OF. This is done at startup to read the
interrupt tree (but this can be done before the fixup). I don't have
other specific cases in mind, but there is at least one thing for which
we need a valid OF tree: to be able to get an OF path from a device in
order to configure the OF bootloader.
This is not used currently since we still need some more kernel support
that I didn't implement yet, but this will definitely be needed if we
want a  way to configure yaboot and OF automatically from Linux without
having to type the full OF path to the boot device.

>2. Most arch types obviously don't have an OF tree at all.
>Presumably they just do everything with the pci_dev list.  Therefore,
>ppc should too -- it's a bad idea to be different in an unnecessary
>way.

Well, If it was only for me, I would have craped PCI probing in favor of
a device-tree only operations ;) But that's not the point. I agree that
to be consistent with other archs and to have portable drivers, we must
rely on PCI probing alone whenever possible.
There are cases where we don't have choice:

 - We need some infos from the device tree to identify machine models

 - The interrupt-tree is interleaved in the device tree, so we need it to
   configure the PIC.

 - We need the device tree to probe ASIC cells inside the various
incarnations of
   Apple ASICs. This is currently the way we probe for devices like the PMU,
   Cuda, AWACS, MESH, OpenPIC, etc... Those drivers also use the tree in
order to get some
   infos like the presence of an ADB bus, etc...

 - We retreive the eth. HW address from the tree


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
