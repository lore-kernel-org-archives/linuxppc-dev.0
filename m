Message-Id: <200009270532.HAA00726@piglet.grunz.lu>
Date: Wed, 27 Sep 2000 07:32:44 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: PCI fixups (was: re: xf 4.0.1 with rage II/rage...)
To: bh40@calva.net
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19340821143437.3943@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

On  26 Sep, this message from Benjamin Herrenschmidt echoed through cyberspace:
> Allocating a region is nasty. You must find a free physical region (2.2.x
> has no support for that) and you must find one that is decoded by the
> north bridge (we currently have no code for either reading or writing the
> address space decode enable bits of Bandit and UniNorth).
>
> That's step 2 of my PCI patches. I will a set of regions per hose (pci
> controller, Apple ones can decode several non-contiguous regions).
>
> With this done, we will be able to really allocate PCI space from the
> kernel. I still have to check if the common PCI code provides enough
> hooks so I can even add new decoded regions to Bandit/Uninorth, but
> that's not terribly important.

UniNorth, I don't know; but that should not be a problem. If you look at
my latest published PCI patches for 2.3/2.4 kernels, I've attempted to
do exactly that. It crashed in that code but that's a different issue...

Just allocate memory for up to 4 resources per bus, and fill those with
the regions that the hose decodes, flags included, in any order. The PCI
code will try it's best than to allocate resource demands for that bus
out of the provided bus resources, looking for the closest fit.

FWIW, I am reading the resource regions decoded by the hose from the OF
device tree. The encoding is documented somewhere in the OF to PCI
binding doc. I've also added a struct ranges_property in
include/asm-ppc/prom.h.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
