From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
Date: Thu, 28 Sep 2000 21:19:28 +0200
Message-Id: <19340823125112.7591@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.10.10009281150130.3468-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10009281150130.3468-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I'm not sure it would help. It would probably allow a kind of "mapping on
>> demand" of the IO region on memory mapped IOs platforms, but unless we
>> add another parameter to ioportremap telling it the pci_dev (or at least
>> the bus number), we can't "guess" on which IO bus the device is and which
>> physical base we must use.
>
>But we can find out the IO bus by looking in which region the physical
address
>is located, right? Or do we have the same region on different IO busses?
>That would be really weird! Different IO busses should decode different
>regions.

That mean that you intend to feed a physical address to ioportremap and
not an IO address ? Hrm... that mean we need to have the physical address
in the device IO resources instead of the content of the IO BAR. Well,
how should this work for legacy devices, then ? By assuming addresses
below 64k are legacy IO (hard coded) addresses ? I don't like it too much.

The more I think about it, the more I want to separate legacy IO macros
and PCI IO macros :)

I personally would like is:

Each bus define resources which are made of bus addresses on this bus
(not CPU physical address). This is true for both IO and memory
resources. The resources would contain the exact content of the BARs and
this would probably allow to keep the resource management on a given bus
a lot simpler (without fixup's, hooks, tricky calculations, ...)

On most archs, the PCI mem bus address and CPU physical mem address will
be the same (but not on some PRePs, AFAIK).

Then, we can have separate:
 - isa_io_remap(range),
 - isa_mem_remap(range),
 - pci_io_remap(pci_bus, resource_addr)
 - pci_mem_remap(pci_bus, resource_addr)

On most platforms, pci_mem_remap would be a simple #define of ioremap.
PReP could handle adding 0xc0000000 there (well, if I understand how PReP
work correctly), and all weird combinations can be handled just fine.

This also allow us to have the platform support code for isa_io_remap()
and isa_mem_remap() artificially put slices of the ISA IO space on
various PCI IO busses & devices (for ex. the VGA ranges could be on an
AGP bus while the legacy serial port ranges would be on a PCI bus with an
ISA bridge).

AFAIK, this scheme should be able to handle pretty much all kind of PCI/
ISA busses out there, including multiple hosts with PCI mem at different
locations, etc...

The BIG issue here is to adapt all drivers...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
