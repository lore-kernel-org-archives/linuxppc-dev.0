Return-Path: <dgibson@ozlabs.org>
Date: Sat, 24 Mar 2007 10:59:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 06/17] Document the linux,network-index property.
Message-ID: <20070323235900.GH4459@localhost.localdomain>
References: <20070316172846.GF29784@ld0162-tx32.am.freescale.net>
	<36990c5c3b7de1ab2f65662547641b79@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302B97B1A@az33exm25.fsl.freescale.net>
	<4b0f0296e3beb792337a868c3527c954@kernel.crashing.org>
	<20070322002911.GD2295@localhost.localdomain>
	<28ff7492856c7220f060cd113329e62f@kernel.crashing.org>
	<20070323031956.GB28006@localhost.localdomain>
	<1f513f9b14cfe469ffee3d8e10901776@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1f513f9b14cfe469ffee3d8e10901776@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 23, 2007 at 12:36:58PM +0100, Segher Boessenkool wrote:
> [...flat device tree labels...]
> 
> > They're of no use at present if you compile direct to dtb.  They're
> > potentially useful, however, if you compile to asm output, because the
> > labels are transcribed into symbols within the asm.
> >
> > The idea is intended to be useful for systems where the bootloader has
> > to do some poking of the device tree, but doesn't need to change the
> > size of any properties.
> 
> Nor needs to change any device tree structure (add/remove
> properties / nodes).

Of course.

> > In that case the bootloader can do all the
> > necessary fixups on the tree without *any* understanding of the flat
> > tree structure.
> 
> Well it still needs to know property encoding...

Well, yes, but in the most likely fixup cases that's trivial:
clock-frequency properties are u32, memory address/size are u32 or
u64, mac addresses are char[6].

> > It simply links in the device tree structure, and
> > symbols within it reference all the necessary points for adjustment.
> 
> Yeah.  That would be useful if you really only need to change
> the contents of a few fixed-size properties.
> 
> It would be interesting to see if anyone actually uses this
> feature ;-)

Yes, it will.

Oh, I have been planning for ages to make it possible (if less
convenient) to use this with dtb as well as asm output, by
(optionally) generating a "map file" (possibly in the form of a .h
with #defines) alongside the dtb, giving the offsets of all the
labels.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
