Message-Id: <200003230741.IAA00313@piglet.grunz.lu>
Date: Thu, 23 Mar 2000 08:41:51 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: LongTrail PCI resource assignment
To: bh40@calva.net
cc: geert@linux-m68k.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000322141532.028115@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

On  22 Mar, this message from Benjamin Herrenschmidt echoed through cyberspace:
> Well, ideally, we need the resource allocation/re-allocation mecanism to
> rely on the parent resource node, regardless of it beeing a real PCI bus
> or something else. This way, we can handle the Uni-N case by insterting
> sort of per-bus nodes: (I only report IO ranges below since mem ranges
> seems to be less of a problem)
>
>  Uni-N : IO 0xf0000000 - 0xf5ffffff  (fake range covering all 3 sub-busses)
>    |
>    |-- Uni-N-sub1 : IO 0xf0000000 - 0xf000ffff
>    |      |
>    |      --- ATI AGP
>    |
>    |-- Uni-N-sub2 : IO 0xf2000000 - 0xf200ffff
>    |      |
>    |      --- (external PCI, can be a DEC PCI<->PCI bridge)
>    |
>    |-- Uni-N-sub3 : IO 0xf4000000 - 0xf400ffff
>           |
>           --- GMAC
>           |
>           --- Internal FireWire

How about omitting the base Uni-N, and have each of the three
sub-entities be seen as a separate host bridge, being parent to a
separate pci bus with a separate bus number?

OK, that would mean renumbering stuff (might be quite hard, if you
think about a P2P bridge in a PCI slot...), but it might make config
acesses simpler, as you can register config access functions per bus..

> The pmac specific PCI code would then create the 3 Uni-N-subX nodes. The
> probing code needs to be hacked so that devices are put under the proper
> sub nodes. Then, the reallocation/fixup code will re-assign IO ranges
> based only on the device parent node exposed range.

Would it be possible to insert those sub-nodes at all? Would those be
PCI devices in the global chain of devs, or would you just allocate
resources and insert those in the tree of resources?


Michel

PS Interesting to see Apple still sticks to the original memory map
(from 1st generation PCI Macs)...

------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
