Date: Tue, 28 May 2002 08:08:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	David Gibson <david@gibson.dropbear.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Subject: Re: Another OCP enet patch
Message-ID: <20020528150842.GF1295@opus.bloom.county>
References: <20020527040330.GH16537@zax> <20020527162323.GB32718@opus.bloom.county> <20020528005728.GO16537@zax> <20020528012516.GE1295@opus.bloom.county> <20020528063638.GS16537@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020528063638.GS16537@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 28, 2002 at 04:36:38PM +1000, David Gibson wrote:
> On Mon, May 27, 2002 at 06:25:16PM -0700, Tom Rini wrote:
> > On Tue, May 28, 2002 at 10:57:28AM +1000, David Gibson wrote:
> > > On Mon, May 27, 2002 at 09:23:23AM -0700, Tom Rini wrote:
> > > > On Mon, May 27, 2002 at 02:03:30PM +1000, David Gibson wrote:
> > > >
> > > > > I realise that logically the OCP enet driver, and the
> > > > > consistent_sync() has nothing to do with PCI.  However using the pci.h
> > > > > constants seems a better approach than defining new constants with the
> > > > > same values, when the switch in consistent_sync() explicitly checks
> > > > > against the PCI constants.
> > > > >
> > > > > In the longer term consistent_sync() itself should be changed not to
> > > > > reference the PCI constants - in fact the PCI constants should
> > > > > probably be moved and renamed since they have no inherent connection
> > > > > with PCI at all.
> > > >
> > > > At this point I think I should give my 2 cents, so...
> > > >
> > > > I think we should keep ocp-dma.h around for now (2.4.x timeframe) and
> > > > change consistent_sync() to not check for the PCI versions (which I
> > > > believe happened just because it's a cut&paste&fix of the ARM code) and
> > > > for 2.5 hope that a more general fix comes out..
> > >
> > > I disagree.  Using the constants from pci.h is the least-wrong simple
> > > fix for now - yes it's conceptually wrong, but they're just arbitrary
> > > constants, it doesn't do any real damage.
> >
> > Well, for the moment I think they're less-arbitrary constants than they
> > should be, but yes..
>
> Um, I don't see what you mean by "less arbitrary than they should be".

Well, you *could* pick any number you like for the DMA_* ones, but it'd
be much nicer (and in a sense safer) to pick the same constants
PCI_DMA_* uses.

> > > Changing consistent_sync() to use its own constants isn't completely
> > > trivial, because asm/pci.h calls consistent_sync() with the constants
> > > passed as arguments to pci_map_single() et al, assuming they have the
> > > correct values.  So, to decouple the consistent_sync() constants from
> > > the PCI direction constants we would have to put a switch in every
> > > time consistent_sync() is used in asm/pci.h.  The PCI constants could
> > > be defined in terms of the non-PCI constants, but that means changing
> > > generic code (linux/pci.h).
> >
> > Well, if DMA_* == PCI_DMA_*, we don't have to do anything.  We put a
> > comment saying something like:
> > /* The PCI_DMA_* constants have nothing to do with PCI.  Someone should
> >  * rename this in 2.5... */
> > And while someone could re-number the arbitrary constants, I'd think
> > something like that would be questioned before being accepted.
>
> Well, yes, but calling the function with once constant then testing
> against another within the function gives me the willies.  If the
> constants are changed it will break horribly, and it will give
> misleading results if people try to grep for one constant or the
> other.

Which is why you put up a comment, which people grep'ing for will see.
And again, while someone *could* go and change all of the constants for
fun, it's unlikley in 2.4.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
