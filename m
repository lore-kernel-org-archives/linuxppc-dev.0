Message-Id: <200003231922.UAA00358@piglet.grunz.lu>
Date: Thu, 23 Mar 2000 20:22:26 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: LongTrail PCI resource assignment
To: bh40@calva.net
cc: linuxppc-dev@lists.linuxppc.org, geert@linux-m68k.org
In-Reply-To: <20000323111309.004718@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  23 Mar, this message from Benjamin Herrenschmidt echoed through cyberspace:
>>How about omitting the base Uni-N, and have each of the three
>>sub-entities be seen as a separate host bridge, being parent to a
>>separate pci bus with a separate bus number?

> Well, that's what I originally wanted to do. But it causes a number of
> problems and I felt it could be simpler to actually use the resource trick:
>
>  - Renumbering, reconfiguring PCI<->PCI bridges (and all G4s have one), etc..

You can probably avoid that by leaving the 'real' PCI bus (the one with
the slots) as bus 0 with all its subordinates, and have the other two
buses renumbered after those. Unfortunately (don't know whether it
really matters) those bus numbers might change depending on what you
put into the slots...

>  - Re-sync'ing the OF tree or else, the functions for matching PCI
> devices with
>    OF entries will break, causing some problems here or there

That's obviously an issue. I think we should decide once and for all
whether the OF tree is supposed to be up-to-date once the system is
running. If so, then all fixups (also changing base address) need to be
re-sync'ed into the OF tree, which is not done now... Or we just leave
the OF tree alone and work only with the PCI_dev list.

>  - What about devices that issue config access to other devices ? I don't
> know if
>    such device actually exist, but I beleive it's theorically possible. If for
>    any reason they rely on a devfn/bus_number send to them by the driver, they
>    will break.

I doubt that would be done... except maybe a DMA engine modifying it's
own config. But then again, that code is supposed to be set up by the
driver, who knows the right bus number from struct pci_dev.

> Well, my main problem is with PCI<->PCI bridges and re-numbering since I
> don't have the PCI bridge spec (looks like it's paying). I do have the
> PCI 2.1 and 2.2 specs but they don't include the PCI<->PCI bridge section.

Yes, easiest would be to leave P2P bridges alone.

>>Would it be possible to insert those sub-nodes at all? Would those be
>>PCI devices in the global chain of devs, or would you just allocate
>>resources and insert those in the tree of resources?
>
> Well, I was thinking about only adding them to the tree of resources. If
> there a problem with that ? (I'm not too familiar with the new resource
> management).

Neither am I... it might not be the most 'clean' way, but should work
nevertheless. You'll just have three resources with no corresponding
PCI dev...


Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
