Message-ID: <3CF4ED71.4040706@embeddededge.com>
Date: Wed, 29 May 2002 11:02:09 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Another OCP enet patch
References: <20020527040330.GH16537@zax> <20020527162323.GB32718@opus.bloom.county> <20020528005728.GO16537@zax> <3CF35E49.60203@embeddededge.com> <20020529041626.GD16537@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:


> I agree it must not depend on PCI functions, but I don't see the
> problem with PCI headers (well, I do, but it seems less important than
> other considerations).

OK.

> ...  consistent_sync() relies on the PCI direction
> constants defined in linux/pci.h *now* - it checks them explicitly in
> its switch statement (so does the ARM version).  That works fine,
> because pci.h defines the direction constants even if CONFIG_PCI=n.

OK.

> The constants don't really have anything to do with PCI, and are
> already used for SBUS DMA directions on Sparc and IIRC for ISA DMA in
> some places.  We're talking about whether the *callers* of
> consistent_sync() should need pci.h.

I thought so, too.


> Well, it looks like I'm not going to win this argument,

What argument are you trying to win?  I thought you were arguing
for changing the flags to consistent_sync(), but didn't like any
of the solutions?

> .... but calling
> with one name for a constant and checking for another in the
> implementation, relying on them to have the same value bothers me
> much, much more that a few irrelevant PCI_ on the front of constant
> names (which is not to say that the latter doesn't bother me at all).

I was just proposing a solution that addressed one of your other
concerns.  Requiring some flag values to be the same, but with
different names, isn't something unique here :-)


> Ok, well if we have to have the two sets of constants, please lets put
> them in io.h and not in ocp-dma.h.  They have nothing to do with OCP
> (just as they have nothing to do with PCI).

We can't change the PCI names, so I just suggested we change the names to
consistent_sync(), define those in io.h (so non-PCI systems don't have to
include pci header files just to get a flag name), and put a big comment
around the flag definitions that they have to match the PCI_ names.

I'm constantly reminded that Linux is full of hacks to meet its major design
goal of high performance.  This seems to fit nicely :-)

Or, as you said, just not use consistent_sync() in our PowerPC specific
software and call the dma_cache_* functions directly.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
