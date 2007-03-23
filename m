Return-Path: <dgibson@ozlabs.org>
Date: Fri, 23 Mar 2007 14:22:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
Message-ID: <20070323032214.GC28006@localhost.localdomain>
References: <20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
	<20070318115656.GA12765@localhost.localdomain>
	<45FEA7B3.9090304@freescale.com>
	<20070320035957.GC21124@localhost.localdomain>
	<45FFE8FD.9020902@freescale.com>
	<20070321025447.GG27969@localhost.localdomain>
	<460148DC.3020600@freescale.com>
	<20070322000620.GC2295@localhost.localdomain>
	<1174576516.6595.542.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1174576516.6595.542.camel@ld0161-tx32>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 22, 2007 at 10:15:16AM -0500, Jon Loeliger wrote:
> On Wed, 2007-03-21 at 19:06, David Gibson wrote:
> 
> > I mean, does the u-boot source tree have its own copies of the dts
> > files which are built into a dtb during the u-boot build process?
> 
> There are not DTS files in U-Boot anymore.  They are all
> currently in the arch/powerpc/boot/dts directory, or some
> other private home directory. :-)

Ok

> >   Or
> > do you take the dts from the kernel tree and make the dtb from that
> 
> yes.
> 
> > when you build a dtb aware u-boot for a particular machine?
> 
> Do it whenever you want.  But it has to be downloaded
> to RAM or found in flash on the board by U-Boot by the
> time you want to do the hand-off to Linux.  That is,
> there is no need to "combine" it with U-Boot to make
> it "dtb aware".  U-Boot is still built independently of
> any DT[SB] file entirely.
> 
> > > Ok, I understand now, but I don't know what value it has.  I don't see 
> > > the difference, from the DTS point-of-view, between
> > > 
> > > 	local-mac-address = [ 00 00 00 00 00 00 ]
> > > and
> > > 	local-mac-address = [ ? ? ? ? ? ? ];
> > 
> > In terms of the generated dtb output there is no difference.  Well,
> > probably.  It would It's
> > purely syntactic sugar / internal documentation.
> 
> Right.  It is more like "make it clear to the DTS file
> reader that these fields are intended to be filled in by
> the bootloader".

Yes, that's exactly right.

> > Well, no.  You wanted to get rid of the property from the dts, I
> > didn't.  What I'm suggesting here is an idea to addresses at least one
> > possible objection to having the properties in the dts: the fact that
> > with actual values there it looks like the tree is complete and it
> > might not be obvious that a bootloader *must* tweak values to produce
> > a working tree.
> 
> (nit) But let's not forget that there are cases where we _do_ want
> the DTS to be complete too.

Well, that's part of why I'm contemplating this idea:  it makes it
clear to the reader whether this dts is intended to be complete, or
whether it's intended that the bootloader adjust things.

> > I think it's useful to document in the dts that certain properties are
> > expected to be there, even if their actual values have to be
> > determined during boot.  This syntax allows a dts to show to someone
> > reading it that a property is expected, and what its expected size is,
> > but that the value must be filled in later.  It's for the benefit of
> > people reading the dts, not programs.
> 
> Exactly.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
