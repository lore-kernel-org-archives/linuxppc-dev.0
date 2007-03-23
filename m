Return-Path: <dgibson@ozlabs.org>
Date: Fri, 23 Mar 2007 14:19:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 06/17] Document the linux,network-index property.
Message-ID: <20070323031956.GB28006@localhost.localdomain>
References: <20070316172846.GF29784@ld0162-tx32.am.freescale.net>
	<36990c5c3b7de1ab2f65662547641b79@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302B97B1A@az33exm25.fsl.freescale.net>
	<4b0f0296e3beb792337a868c3527c954@kernel.crashing.org>
	<20070322002911.GD2295@localhost.localdomain>
	<28ff7492856c7220f060cd113329e62f@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <28ff7492856c7220f060cd113329e62f@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 22, 2007 at 12:11:45PM +0100, Segher Boessenkool wrote:
> >>> Segher, what is the the 'other alias' mechanism you are referring
> >>> to that should be dropped?  Is it this proposed linux,network-index
> >>> property?  or something else?
> >>
> >> Just the
> >>
> >> 	pic0: pic@700 {
> >> 		...
> >> 	}
> >>
> >> labeling thing -- it becomes redundant when the flat tree
> >> stuff would support OF-style aliases, so it can be phased
> >> out then.
> >
> > dtc labels are *not* an alias mechanism: they're essentially a
> > compile-time rather than run-time concept
> 
> Sure.  For flat device trees, you can evaluate the OF-style
> aliases at compile time, too.
> 
> > and they can reference
> > properties as well as nodes
> 
> I didn't know this though.  If that's useful (I don't see how
> right now), you want to keep labels I suppose.

They're of no use at present if you compile direct to dtb.  They're
potentially useful, however, if you compile to asm output, because the
labels are transcribed into symbols within the asm.

The idea is intended to be useful for systems where the bootloader has
to do some poking of the device tree, but doesn't need to change the
size of any properties.  In that case the bootloader can do all the
necessary fixups on the tree without *any* understanding of the flat
tree structure.  It simply links in the device tree structure, and
symbols within it reference all the necessary points for adjustment.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
