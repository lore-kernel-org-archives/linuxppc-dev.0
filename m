From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
Date: Fri, 29 Sep 2000 17:18:05 +0000
Message-Id: <19340824104949.3513@192.168.1.10>
In-Reply-To: <Pine.LNX.4.10.10009291319510.383-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10009291319510.383-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>No, I meant I/O addresses. Each PCI bus should decode different I/O
addresses,
>just like it decodes different memory addresses.
>
>Say the first bus decodes I/O 0x0000-0x0fff, the second one decodes
>0x1000-0x1fff, and so on. If the different busses have different physical
>addresses, you have to use the region decoding from my previous mail. Hence
>ioportremap() would move the burden (and overhead) of the region
decoding from
>inb() and friends to one single place: ioportremap().

Well, I see why we didn't understand each other then. That's not what
happens actually. At least on Uni-North based Macs, each bus has it's own
IO address space assigned from 0x0000 to 0xffff at least. They are
accessible at different locations in the CPU physical address space, but
they have the same IO address.

So in this case, we need some fixup of the resources too.

>> The more I think about it, the more I want to separate legacy IO macros
>> and PCI IO macros :)
>
>That's impossible since legacy I/O macros _are_ PCI I/O macros.

Provided that those macros all access a single IO space. Which is not the
case. I don't say those macros shouldn't resolve to the same code in most
cases.

>> Well, the ISA space would be on a fixed bus, but not necessarily bus 0
>> (please  ;)
>
>IIRC, it has to be on bus 0, according to the PCI spec.

What Apple does and what the PCI spec says are different things. Users
will want to put legacy serial cards in the PCI slots for example, or
PCMCIA cards with legacy stuffs on them, and on UniNorth machines (at
least), those are on a bus number than can be 0,1 or 2 depending of
various thing (kernel versions, machine model, ...)

>On a PC, the PCI bus (with ISA) is bus 0, while AGP is on bus 1.

Well, Apple decided they didn't need to hard-wire things that way, and so
the AGP is the first hose inside UniNorth and the external PCI is the
second. I could tweak the UniNorth probe code to put the second hose as
bus 0 since I'm doing bus number remapping anyway...

>Hmm, I'm starting to wonder how legacy VGA works then, since the primary
video
>card these days is usually on the AGP bus, i.e. bus 1. But it's quite
possible
>this is some weird legacy quirk again...

Dunno.

>Hence you have to fixup any pci_dev on the non-primary bus so its resources
>reflect the `real' I/O addresses, as seen from the CPU.

There is no choice since the BAR content overlap as I told you. The
machine can have several IO spaces, all having the same 0x0000->0x1ffff
range decoded.

>So I/O address 0x3f8 (CPU view) is decoded by the first bus and accesses
0x3f8
>on the first bus.

It's decoded on whatever bus you decide is the first one, at least on
UniNorth-like machines where you have the choice.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
