Date: Thu, 30 May 2002 14:30:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Another OCP enet patch
Message-ID: <20020530043043.GS16537@zax>
References: <20020527040330.GH16537@zax> <20020527162323.GB32718@opus.bloom.county> <20020528005728.GO16537@zax> <3CF35E49.60203@embeddededge.com> <20020529041626.GD16537@zax> <3CF4ED71.4040706@embeddededge.com> <20020530030933.GJ16537@zax> <3CF5A798.3010500@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CF5A798.3010500@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 30, 2002 at 12:16:24AM -0400, Dan Malek wrote:
> David Gibson wrote:
>
> >I'm attempting to argue that changing the callers of consistent_sync()
> >to use the PCI_DMA_* constants ....
>
> I see.  I think that would be fine as long as we can compile and get
> these constants defined without having to enable CONFIG_PCI.  It is
> a little weird to include pci header files in drivers that don't use it :-)

That's what the tree does right now (since Tom backed out his changes
in this area, anyway).  ibp_ocp_enet.c includes linux/pci.h, but in no
way requires CONFIG_PCI.

> >I do want to change the flags to consistent_sync() but only if we
> >change it everywhere, including in all the PCI stuff: that requires
> >convincing Linus, and probably won't happen at all in 2.4.
>
> But, doesn't that involve adding code to test PCI flags and convert
> them to consistent_sync() flags that you didn't want to do?

No, I mean to essentially abolish PCI_DMA_* and replace them with
DMA_*, say in linux/dma.h and use them everywhere that currently uses
the PCI_DMA_* constants - in PCI drivers, in OCP drivers in SBUS
drivers.  Or as an intermediate step we could define the new constants
then define the PCI_DMA_ constants in terms of them.

> How about this, we just add another set of flags that are disjoint
> from the PCI flags, and just test for both in consistent_sync()?

Hmm... IMO marginally better than different names for things which
must be the same, but still worse than using the pci.h constants.
Changing the constants so they weren't disjoint is perhaps less likely
than (in the other case) changing them so they weren't equal, but
would have more confusing consequences.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
