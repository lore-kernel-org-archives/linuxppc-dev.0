Return-Path: <dgibson@ozlabs.org>
Date: Wed, 8 Aug 2007 11:13:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Message-ID: <20070808011324.GD25082@localhost.localdomain>
References: <65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<46B1F6D4.3070707@ru.mvista.com>
	<20070803031349.GD6418@localhost.localdomain>
	<46B34E1F.5060009@ru.mvista.com>
	<20070806042109.GB6103@localhost.localdomain>
	<163e1bcdc507ddcde3193e842c96da43@kernel.crashing.org>
	<20070807041259.GF13522@localhost.localdomain>
	<b055a84cbb23ef7287c1d585c1810a74@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b055a84cbb23ef7287c1d585c1810a74@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 07, 2007 at 06:51:04PM +0200, Segher Boessenkool wrote:
> >> address-permutation = <0 1 3 2 4 5 7 6 e f d c a b 9 8>;
> >
> > Yes, I was contemplating something like that.
> 
> Let's not define this until we need it though :-)

Indeed.

> >> I haven't heard or thought of anything better either.  Using "ranges"
> >> is conceptually wrong, even ignoring the technical problems that come
> >> with it.
> >
> > Why is "ranges" conceptually wrong?
> 
> The flash partitions aren't separate devices sitting on a
> "flash bus", they are "sub-devices" of their parent.

Well, yes, but nonetheless the partitions show up as part of the
overall physical address space.  How do you encode that other than in
'ranges'?

> > To be honest this looks rather to me like another case where having
> > overlapping 'reg' and 'ranges' would actually make sense.
> 
> It never makes sense.  You should give the "master" device
> the full "reg" range it covers, and have it define its own
> address space; "sub-devices" can carve out their little hunk
> from that.  You don't want more than one device owning the
> same address range in the same address space.

Why not?  After all, the physical address ranges of the flash
partitions really do overlap with that of the flash device as a whole.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
