Message-Id: <200108142115.XAA00710@piglet.grunz.lu>
Date: Tue, 14 Aug 2001 23:15:03 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: UniNorth AGP: Some success
To: benh@kernel.crashing.org
Cc: dri-devel@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010814133818.31081@smtp.adsl.oleane.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  14 Aug, this message from Benjamin Herrenschmidt echoed through cyberspace:
>  - Machine is a PowerBook "Pismo" with a rev. of UniNorth that can do x2
> AGP only and no fast write (it does SBA fortunately). I use the alpha
> nopage() code for userland mappings and a home made ioremap_agp() for in-
> kernel mappings. Everything is mapped uncached, which is a performance
> hit on PPC, I'll have to see how I can make things cachable by adding the
> proper flush routines all over the place.

Depending on cache mode and data direction, you might not need cache
flushing. I mapped the 'control' framebuffer write-through; since only
the cpu writes there (it's not accelerated), that's ok without cache
flushing, but it does enable store gathering in the processor (and maybe
also in the PCI bridge; not sure...) Not sure whether that applies to
AGP as well.

>  - It's a bit slower than PCI GART (about 430 fps in gears, but it's not
> stable, while PCI GART gives me a stable 474 fps). This may be partially
> do to the fact that we have all the AGP memory uncachable, I think that
> will prevent the PPC from doing write-combining.

Yes, that's how I understand all the docs I read so far. I'd suggest
tackling cacheing issues first; that will probably provide the biggest
benefit.

Cheers, and happy hacking ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
