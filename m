Date: Wed, 30 Dec 1998 12:22:25 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: grackle, patches, MMU, ...
In-Reply-To: <19981230113716.015659@mail.mipsys.com>
Message-ID: <Pine.LNX.4.03.9812301219080.15589-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Dec 1998, Benjamin Herrenschmidt wrote:
> I finally read the pmac_pci.c file and it looks like my grackle.h file
> (which comes from experiments I made on MacOS some time ago for another
> issue) is absolutely not needed, grackle is just device 0 on bus 0 and
> it's register can be accessed by ordinary pci config accesses. However,
> since I know no easy way of knowing which bridge in the list is actually
> grackle, if we want to add power management support for it in idle.c,
> we'll still have to hard code device 0 / bus 0 and hope it will always be
> this way.

Grackle is the host bridge, right? In that case it's always device 0 / bus 0.

> So we have one free BAT (#1) only on pmac and chrp, but if we plan to
> switch BATs along with process contexts (for mapping fbdevs with BATs for
> example), then we would have all BATs free for user processes. Am I correct ?

Note that we cannot map all frame buffers with BATs since there are less free
BATs than possible frame buffers.

> I was wondering if, instead of using the remaining free BAT to map the
> framebuffer for the kernel (to speed up console), why couldn't we use a
> BAT to map the entire assigned PCI memory space for the kernel ? This
> would speed-up accesses to all devices (including framebuffers). We
> already map the entire mac-io (at least the first one on machines with
> two of them).

I think they do this on SPARC64. And then ioremap() because a simple NULL
operation.

But for user space, we're still stuck with a normal mapping. And there speed is
more important, I think, since most people (R5 installers? :-) run X and don't
use the text console that much.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
