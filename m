Date: Wed, 29 May 2002 14:16:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Another OCP enet patch
Message-ID: <20020529041626.GD16537@zax>
References: <20020527040330.GH16537@zax> <20020527162323.GB32718@opus.bloom.county> <20020528005728.GO16537@zax> <3CF35E49.60203@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CF35E49.60203@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 28, 2002 at 06:39:05AM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
>
>
> >Changing consistent_sync() to use its own constants isn't completely
> >trivial, because asm/pci.h calls consistent_sync() with the constants
> >passed as arguments to pci_map_single() et al, ....
>
> The constent_sync() is not unique to 4xx and it absolutely must not
> be required to use pci headers/functions for it to work properly.
> These lower level functions are common to other platforms, other drivers
> will call consistent_* functions directly, and in some cases the platforms
> or drivers that use these functions will not require (nor compile correctly)
> if PCI is enabled.  Unfortunately, making some of these drivers work without
> PCI defined was the great challenge, so changing these constant the time I
> put these functions into PowerPC was the least of the problem :-)

I agree it must not depend on PCI functions, but I don't see the
problem with PCI headers (well, I do, but it seems less important than
other considerations).  consistent_sync() relies on the PCI direction
constants defined in linux/pci.h *now* - it checks them explicitly in
its switch statement (so does the ARM version).  That works fine,
because pci.h defines the direction constants even if CONFIG_PCI=n.
The constants don't really have anything to do with PCI, and are
already used for SBUS DMA directions on Sparc and IIRC for ISA DMA in
some places.  We're talking about whether the *callers* of
consistent_sync() should need pci.h.

> >.....  So, to decouple the consistent_sync() constants from
> >the PCI direction constants we would have to put a switch in every
> >time consistent_sync() is used in asm/pci.h.
>
> Just define them so they have the same value as their PCI counterparts.

Well, it looks like I'm not going to win this argument, but calling
with one name for a constant and checking for another in the
implementation, relying on them to have the same value bothers me
much, much more that a few irrelevant PCI_ on the front of constant
names (which is not to say that the latter doesn't bother me at all).

> >... In io.h along with the prototype for
> >consistent_sync() would be a better idea.
>
> Yes, thank you :-)

Ok, well if we have to have the two sets of constants, please lets put
them in io.h and not in ocp-dma.h.  They have nothing to do with OCP
(just as they have nothing to do with PCI).

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
