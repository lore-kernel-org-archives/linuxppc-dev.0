Date: Thu, 30 May 2002 13:09:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Another OCP enet patch
Message-ID: <20020530030933.GJ16537@zax>
References: <20020527040330.GH16537@zax> <20020527162323.GB32718@opus.bloom.county> <20020528005728.GO16537@zax> <3CF35E49.60203@embeddededge.com> <20020529041626.GD16537@zax> <3CF4ED71.4040706@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CF4ED71.4040706@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 29, 2002 at 11:02:09AM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
>
> >I agree it must not depend on PCI functions, but I don't see the
> >problem with PCI headers (well, I do, but it seems less important than
> >other considerations).
>
> OK.
>
> >...  consistent_sync() relies on the PCI direction
> >constants defined in linux/pci.h *now* - it checks them explicitly in
> >its switch statement (so does the ARM version).  That works fine,
> >because pci.h defines the direction constants even if CONFIG_PCI=n.
>
> OK.
>
> >The constants don't really have anything to do with PCI, and are
> >already used for SBUS DMA directions on Sparc and IIRC for ISA DMA in
> >some places.  We're talking about whether the *callers* of
> >consistent_sync() should need pci.h.
>
> I thought so, too.
>
> >Well, it looks like I'm not going to win this argument,
>
> What argument are you trying to win?  I thought you were arguing
> for changing the flags to consistent_sync(), but didn't like any
> of the solutions?

I'm attempting to argue that changing the callers of consistent_sync()
to use the PCI_DMA_* constants (even if they're not PCI drivers) is a
lesser evil than ever calling consisent_sync() with constants of
different names to the ones checked inside, even if they have the same
values.

I do want to change the flags to consistent_sync() but only if we
change it everywhere, including in all the PCI stuff: that requires
convincing Linus, and probably won't happen at all in 2.4.

> >.... but calling
> >with one name for a constant and checking for another in the
> >implementation, relying on them to have the same value bothers me
> >much, much more that a few irrelevant PCI_ on the front of constant
> >names (which is not to say that the latter doesn't bother me at all).
>
> I was just proposing a solution that addressed one of your other
> concerns.  Requiring some flag values to be the same, but with
> different names, isn't something unique here :-)

No, but it's the only instance I've come across recently in the stuff
I've been doing.  If I knew of other cases I'd think they were a Bad
Thing and want to change them too.

> >Ok, well if we have to have the two sets of constants, please lets put
> >them in io.h and not in ocp-dma.h.  They have nothing to do with OCP
> >(just as they have nothing to do with PCI).
>
> We can't change the PCI names, so I just suggested we change the names to
> consistent_sync(), define those in io.h (so non-PCI systems don't have to
> include pci header files just to get a flag name), and put a big comment
> around the flag definitions that they have to match the PCI_ names.

Well, I hope that we can change the PCI names in time.  When I get a
chance, I'll send a patch (against 2.5) to lkml.

> I'm constantly reminded that Linux is full of hacks to meet its major design
> goal of high performance.  This seems to fit nicely :-)
>
> Or, as you said, just not use consistent_sync() in our PowerPC specific
> software and call the dma_cache_* functions directly.

Or indeed the even more direct flush_dcache_range() etc.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
