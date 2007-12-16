Return-Path: <dgibson@ozlabs.org>
Date: Sun, 16 Dec 2007 22:35:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 1/7] bootwrapper: Add a firmware-independent "raw" target.
Message-ID: <20071216113502.GB26307@localhost.localdomain>
References: <20071213234221.B0BC27D0054@mail142-sin.bigfish.com>
	<f7eb0ae3da29213720e6b0049deca335@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f7eb0ae3da29213720e6b0049deca335@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 14, 2007 at 02:05:56AM -0600, Milton Miller wrote:
> On Fri Dec 14 10:43:27 EST 2007,  Stephen Neuendorffer wrote:
> 
> > From: Grant Likely <grant.likely at secretlab.ca>
> >
> > This target produces a flat binary rather than an ELF file,
> > fixes the entry point at the beginning of the image, and takes
> > a complete device tree with no fixups needed.
> >
> > The device tree must have labels on /#address-cells, the timebase
> > frequency, and the memory size.
> >
> > Signed-off-by: Grant Likely <grant.likely at secretlab.ca>
> > ---
> 
> 
> You indicated in the intro in 0/ that this was not ready, and you 
> didn't include your own s-o-b, but you did not put any statements to 
> that effect in the header.  The intro is not copied into patchwork, 
> which maintainers often use when deciding what to push.
> 
> Now on to why this should not be merged:
> 
> In addition to the above, it changes the build rules.  It tries to 
> change wrapper to assemble the .dtb into a .o from a .S file, but 
> doesn't set any flags to force the assembler into the right mode.  In 
> contrast the linker is controlled by the .lds linker script.
> 
> In addition, the requirement for assembly labels can easily be 
> eliminated.  As mentioned above, they are used for 3 properties.  With 
> the existing library (in 2.6.24 and earlier), call simple_malloc_init 
> with a small bss array (like BSS_STACK does to allocate stack), and 
> then read the properties out of the device tree.  At that point, call 
> simple_malloc_init a second time using the found memory size.   As I 
> said the last time this was posted, my patches to boot from kexec 
> implemented this strategy.
> 
> However, with the new libfdt, which is already in for-2.6.25, we should 
> no longer need malloc() to simple read the tree.   At least that is 
> what was advertised.

That's correct.  No malloc() is necessary for read-only access.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
