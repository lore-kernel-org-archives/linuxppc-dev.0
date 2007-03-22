Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Mar 2007 11:29:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 06/17] Document the linux,network-index property.
Message-ID: <20070322002911.GD2295@localhost.localdomain>
References: <20070316172846.GF29784@ld0162-tx32.am.freescale.net>
	<36990c5c3b7de1ab2f65662547641b79@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302B97B1A@az33exm25.fsl.freescale.net>
	<4b0f0296e3beb792337a868c3527c954@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4b0f0296e3beb792337a868c3527c954@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2007 at 07:57:33PM +0100, Segher Boessenkool wrote:
> > Segher, what is the the 'other alias' mechanism you are referring
> > to that should be dropped?  Is it this proposed linux,network-index
> > property?  or something else?
> 
> Just the
> 
> 	pic0: pic@700 {
> 		...
> 	}
> 
> labeling thing -- it becomes redundant when the flat tree
> stuff would support OF-style aliases, so it can be phased
> out then.

dtc labels are *not* an alias mechanism: they're essentially a
compile-time rather than run-time concept and they can reference
properties as well as nodes (and in fact I'd like eventually to extend
them to allow labels inside property values).

> For who doesn't know the aliases thing, it looks like this:
> 
> / {
> 	aliases {
> 		pic0 = "/some/path/to/pic@700";
> 		pic1 = "/some/path/to/pic@800";
> 
> 		enet  = "/some/path/to/some/ethernet";
> 		enet0 = "/some/path/to/some/ethernet";
> 		enet1 = "/some/path/to/some/other/ethernet";
> 		enet2 = "/some/path/to/yet/another/ethernet";

Putting the aliases in a separate node is far less usable for the
things labels are useful for than putting the label directly on the
node.  Replacing labels with the OF alias mechanism is not sensible.

That said, auto-generating OF-style aliases from labels for the
benefit of run-time users might be worthwhile.  And using /aliases
would work about as well as the "linux,network-index" trick.

> etc.  Note you can have multiple aliases to the same
> node, that comes in quite handy sometimes (like "disk"
> is the default boot disk, ...)
> 
> Path name resolution looks at the aliases whenever
> a path name doesn't start with a '/' character.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
