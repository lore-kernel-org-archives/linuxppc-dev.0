Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id CA7E2DDDFE
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 18:17:17 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH] [RFC][POWERPC] Merge 32 and 64 bit
	pci_process_bridge_OF_ranges() instances
Date: Wed, 12 Sep 2007 10:13:50 +0200
References: <20070911224952.9838.46644.stgit@localhost.localdomain>
	<200709120057.18873.arnd@arndb.de>
	<20070912035602.0be0d47e@localhost.localdomain>
In-Reply-To: <20070912035602.0be0d47e@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709121013.51500.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 12 September 2007, Vitaly Bordug wrote:

> 
> Well, it's more a rewrite than a move, based on 64-bit implementation.

ok.

> > Could you perhaps split the patch into two separate changesets, one
> > that makes both functions identical in place, and one that merges
> > them to live in a common location?
> > 
> I'm not sure I'm following what you are requesting. What is a benefit of
> code duplication? I was thinking about, if it will look good enough, to
> provide this function at generic level but changing its name a little,
> while leaving old stuff in place, and encouraging people to use it in
> favour of 32 or 64-bit-specific approaches. That way we won't kill many
> boards at once(in case, for example,odd dts with missed ranges for
> pci subnode).     

I wasn't suggesting to leave the duplicated code in, but rather to
make the review easier by first modifying the code in place.

If you're taking the 64 bit code as a base, you can for instance make
the first patch leave pci_32 alone, and modify the 64 bit 
pci_process_bridge_OF_ranges to look exactly like the merged version.
That allows us to see what changed in the 64 bit case.

The second patch would then move the functions over, but leave the
code identical to the result of the first patch.

> > > diff --git a/include/asm-powerpc/ppc-pci.h
> > > b/include/asm-powerpc/ppc-pci.h index b847aa1..882b8bc 100644
> > > --- a/include/asm-powerpc/ppc-pci.h
> > > +++ b/include/asm-powerpc/ppc-pci.h
> > > @@ -15,6 +15,13 @@
> > >  #include <linux/pci.h>
> > >  #include <asm/pci-bridge.h>
> > >  
> > > +struct ranges_pci {
> > > +	unsigned int pci_space;
> > > +	u64 pci_addr;
> > > +	phys_addr_t phys_addr;
> > > +	u64 size;
> > > +} __attribute__((packed));
> > > +
> > 
> > This structure definition uses unaligned members because of the
> > 'packed' attribute. Is that really what you intended?
> > 
> yes, exactly, because I'm mapping this struct on ranges extracted from
> the dts instead of juggling with ranges[foo] offsets.

I see. It does however look wrong to me, because you are using a hardcoded
phys_addr_t type. This breaks when phys_addr has a different size from what
you expect, e.g. when booting a pure 32 bit kernel on a machine that has
a 64 bit physical address space.

	Arnd <><
