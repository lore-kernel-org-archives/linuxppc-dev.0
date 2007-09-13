Return-Path: <dgibson@ozlabs.org>
Date: Thu, 13 Sep 2007 15:11:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH] [RFC][POWERPC] Merge 32 and 64 bit
	pci_process_bridge_OF_ranges() instances
Message-ID: <20070913051101.GE14905@localhost.localdomain>
References: <20070911224952.9838.46644.stgit@localhost.localdomain>
	<200709120057.18873.arnd@arndb.de>
	<20070912035602.0be0d47e@localhost.localdomain>
	<200709121013.51500.arnd@arndb.de>
	<20070912200706.449fe450@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070912200706.449fe450@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 12, 2007 at 08:07:06PM +0400, Vitaly Bordug wrote:
> On Wed, 12 Sep 2007 10:13:50 +0200
> Arnd Bergmann wrote:
> 
> > On Wednesday 12 September 2007, Vitaly Bordug wrote:
> > 
> > > 
> > > Well, it's more a rewrite than a move, based on 64-bit
> > > implementation.
> > 
> > ok.
> > 
> > > > Could you perhaps split the patch into two separate changesets,
> > > > one that makes both functions identical in place, and one that
> > > > merges them to live in a common location?
> > > > 
> > > I'm not sure I'm following what you are requesting. What is a
> > > benefit of code duplication? I was thinking about, if it will look
> > > good enough, to provide this function at generic level but changing
> > > its name a little, while leaving old stuff in place, and
> > > encouraging people to use it in favour of 32 or 64-bit-specific
> > > approaches. That way we won't kill many boards at once(in case, for
> > > example,odd dts with missed ranges for pci subnode).     
> > 
> > I wasn't suggesting to leave the duplicated code in, but rather to
> > make the review easier by first modifying the code in place.
> > 
> > If you're taking the 64 bit code as a base, you can for instance make
> > the first patch leave pci_32 alone, and modify the 64 bit 
> > pci_process_bridge_OF_ranges to look exactly like the merged version.
> > That allows us to see what changed in the 64 bit case.
> > 
> > The second patch would then move the functions over, but leave the
> > code identical to the result of the first patch.
> 
> ok, makes sense, will do it that way.
> 
> > > > > diff --git a/include/asm-powerpc/ppc-pci.h
> > > > > b/include/asm-powerpc/ppc-pci.h index b847aa1..882b8bc 100644
> > > > > --- a/include/asm-powerpc/ppc-pci.h
> > > > > +++ b/include/asm-powerpc/ppc-pci.h
> > > > > @@ -15,6 +15,13 @@
> > > > >  #include <linux/pci.h>
> > > > >  #include <asm/pci-bridge.h>
> > > > >  
> > > > > +struct ranges_pci {
> > > > > +	unsigned int pci_space;
> > > > > +	u64 pci_addr;
> > > > > +	phys_addr_t phys_addr;
> > > > > +	u64 size;
> > > > > +} __attribute__((packed));
> > > > > +
> > > > 
> > > > This structure definition uses unaligned members because of the
> > > > 'packed' attribute. Is that really what you intended?
> > > > 
> > > yes, exactly, because I'm mapping this struct on ranges extracted
> > > from the dts instead of juggling with ranges[foo] offsets.
> > 
> > I see. It does however look wrong to me, because you are using a
> > hardcoded phys_addr_t type. This breaks when phys_addr has a
> > different size from what you expect, e.g. when booting a pure 32 bit
> > kernel on a machine that has a 64 bit physical address space.
> > 
> I wondered around with "32 bit phys" and "64 bit phys" struct
> definitions first, but, well, it does not look good.  In fact it
> already verified with alike case (on 4xx), and I thought it would be
> fair tradeoff to have 64 bit ranges definition.
> 
> otoh, there might be cases when phys_addr_t is u64 and pci stuff
> resides on some 32-bit SoC bus. I will try to address that next
> iteration.

Yes, I was going to point out this sort of case.  I don't think
including the parent-address in the structure is going to work.

Oh, also, since this structure is only used in this function, it
should go in the .c file, not a .h file.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
