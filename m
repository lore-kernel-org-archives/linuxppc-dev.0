Message-Id: <200003242213.XAA00505@piglet.grunz.lu>
Date: Fri, 24 Mar 2000 23:13:29 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: LongTrail PCI resource assignment
To: bh40@calva.net
cc: tas@mindspring.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000324104334.016529@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  24 Mar, this message from Benjamin Herrenschmidt echoed through cyberspace:
>>1. Duplication of information across multiple data structures is
>>evil.  It should be avoided at all costs.
>>
>>If there was a really, really good reason to keep OF up to date
>>(like, say, if we could break back into the OF console like you can
>>on Sparcs), then it would be OK.  Otherwise it is most likely
>>unnecessary bloat, and leads to potential confusion (and bugs).  Is
>>there any such reason on ppc?
>
> The OF tree is still used by devices inside the mac-io chip. But in this
> case, the PCI bus number is not used. There are a few places where we
> need to find the OF entry for a PCI device in order to read some
> properties left by MacOS/OF. This is done at startup to read the
> interrupt tree (but this can be done before the fixup). I don't have
> other specific cases in mind, but there is at least one thing for which
> we need a valid OF tree: to be able to get an OF path from a device in
> order to configure the OF bootloader.

How about integrating the OF tree's data into struct pci_dev's void *sysdata?
That would provide the missing link between OF tree and pci_dev list,
that otherwise forces you to keep both in sync. I'd think about
something like 'all data must taken from PCI dev, except whenn only
available in OF', so that you can safely leave bogus stuff in the OF
device tree.

>>2. Most arch types obviously don't have an OF tree at all.
>>Presumably they just do everything with the pci_dev list.  Therefore,
>>ppc should too -- it's a bad idea to be different in an unnecessary
>>way.
>
> There are cases where we don't have choice:
>
>  - We need some infos from the device tree to identify machine models
>
>  - The interrupt-tree is interleaved in the device tree, so we need it to
>    configure the PIC.
>
>  - We need the device tree to probe ASIC cells inside the various
> incarnations of
>    Apple ASICs. This is currently the way we probe for devices like the PMU,
>    Cuda, AWACS, MESH, OpenPIC, etc... Those drivers also use the tree in
> order to get some
>    infos like the presence of an ADB bus, etc...
>
>  - We retreive the eth. HW address from the tree

All of the above would be left intact in the OF device refenced by
dev->sysdata.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
