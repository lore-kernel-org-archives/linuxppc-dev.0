In-Reply-To: <Pine.GSO.4.10.10003221130220.29557-100000@dandelion.sonytel.be>
Date: Wed, 22 Mar 2000 14:15:32 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org,
        mlan@mcp.cpu.lu
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: LongTrail PCI resource assignment
Message-Id: <20000322141532.028115@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 22, 2000, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>> Hmmm.. bad solution. At least on a number of PowerMacs, there are multiple
>IO
>> windows, out of which IO resources need to be allocated (depends on the
>parent
>> bridge, in fact). So a single static definition doesn't do the job.
>>
>> Can't we replace this with a seed to the resource tree, defined per host
>bridge
>> in arch-specific code? On PowerMacs, there's a function that scans for
known
>> host bridges; that code could (either dynamically or based on hardcoded
>> knowledge) put the available IO window into some resource of the host
bridge
>> pci_dev struct. The tree of IO resources could then be built from there.
>
>The PCI resource allocation code allocates from the parent of the
device. So I
>think it must be possible to put bus-specific resource nodes in between the
>general io{port,mem}_resource that covers the whole address space and the
>device itself.

Well, ideally, we need the resource allocation/re-allocation mecanism to
rely on the parent resource node, regardless of it beeing a real PCI bus
or something else. This way, we can handle the Uni-N case by insterting
sort of per-bus nodes: (I only report IO ranges below since mem ranges
seems to be less of a problem)

 Uni-N : IO 0xf0000000 - 0xf5ffffff  (fake range covering all 3 sub-busses)
   |
   |-- Uni-N-sub1 : IO 0xf0000000 - 0xf000ffff
   |      |
   |      --- ATI AGP
   |
   |-- Uni-N-sub2 : IO 0xf2000000 - 0xf200ffff
   |      |
   |      --- (external PCI, can be a DEC PCI<->PCI bridge)
   |
   |-- Uni-N-sub3 : IO 0xf4000000 - 0xf400ffff
          |
          --- GMAC
          |
          --- Internal FireWire

Note that I don't think we need IOs at all on the GMAC/InternalFW bus.

The pmac specific PCI code would then create the 3 Uni-N-subX nodes. The
probing code needs to be hacked so that devices are put under the proper
sub nodes. Then, the reallocation/fixup code will re-assign IO ranges
based only on the device parent node exposed range.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
