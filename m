In-Reply-To: <200003230741.IAA00313@piglet.grunz.lu>
Date: Thu, 23 Mar 2000 11:13:09 +0100
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org, geert@linux-m68k.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: LongTrail PCI resource assignment
Message-Id: <20000323111309.004718@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 23, 2000, Michel Lanners <mlan@cpu.lu> wrote:

>How about omitting the base Uni-N, and have each of the three
>sub-entities be seen as a separate host bridge, being parent to a
>separate pci bus with a separate bus number?
>
>OK, that would mean renumbering stuff (might be quite hard, if you
>think about a P2P bridge in a PCI slot...), but it might make config
>acesses simpler, as you can register config access functions per bus..

Well, that's what I originally wanted to do. But it causes a number of
problems and I felt it could be simpler to actually use the resource trick:

 - Renumbering, reconfiguring PCI<->PCI bridges (and all G4s have one), etc..
 - Re-sync'ing the OF tree or else, the functions for matching PCI
devices with
   OF entries will break, causing some problems here or there
 - What about devices that issue config access to other devices ? I don't
know if
   such device actually exist, but I beleive it's theorically possible. If for
   any reason they rely on a devfn/bus_number send to them by the driver, they
   will break.

Well, my main problem is with PCI<->PCI bridges and re-numbering since I
don't have the PCI bridge spec (looks like it's paying). I do have the
PCI 2.1 and 2.2 specs but they don't include the PCI<->PCI bridge section.

>Would it be possible to insert those sub-nodes at all? Would those be
>PCI devices in the global chain of devs, or would you just allocate
>resources and insert those in the tree of resources?

Well, I was thinking about only adding them to the tree of resources. If
there a problem with that ? (I'm not too familiar with the new resource
management).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
