Return-Path: <dgibson@ozlabs.org>
Date: Fri, 10 Aug 2007 11:07:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Message-ID: <20070810010723.GB17370@localhost.localdomain>
References: <20070801054751.GM31391@localhost.localdomain>
	<46B1F6D4.3070707@ru.mvista.com>
	<20070803031349.GD6418@localhost.localdomain>
	<46B34E1F.5060009@ru.mvista.com>
	<20070806042109.GB6103@localhost.localdomain>
	<163e1bcdc507ddcde3193e842c96da43@kernel.crashing.org>
	<20070807041259.GF13522@localhost.localdomain>
	<b055a84cbb23ef7287c1d585c1810a74@kernel.crashing.org>
	<20070808011324.GD25082@localhost.localdomain>
	<019ae19815eb3301065ba732e3e72f44@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <019ae19815eb3301065ba732e3e72f44@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 09, 2007 at 09:53:41PM +0200, Segher Boessenkool wrote:
> >>>> I haven't heard or thought of anything better either.  Using 
> >>>> "ranges"
> >>>> is conceptually wrong, even ignoring the technical problems that 
> >>>> come
> >>>> with it.
> >>>
> >>> Why is "ranges" conceptually wrong?
> >>
> >> The flash partitions aren't separate devices sitting on a
> >> "flash bus", they are "sub-devices" of their parent.
> >
> > Well, yes, but nonetheless the partitions show up as part of the
> > overall physical address space.  How do you encode that other than in
> > 'ranges'?
> 
> All that address space shows up in the flash node already.  To
> access the partitions you have to go via that "master" node
> anyway (some commands have to be sent to address 0 on the flash,
> or similar).

Hrm, I suppose.  Although for read-only access that's not relevant.

> It is a very nice feature to not only be able to translate addresses
> "up" the device tree, but also "down".

I don't follow, sorry.

> Also, it mimics reality, just like a good OF citizen should:
> those partitions aren't actually devices at all, so they
> certainly shouldn't be assigned a part of the host address
> space.

Hrm.  I'm not entirely convinced that the distinction between
"actually a device" and "not actually a device" is really as clear cut
as you imply.

> >>> To be honest this looks rather to me like another case where having
> >>> overlapping 'reg' and 'ranges' would actually make sense.
> >>
> >> It never makes sense.  You should give the "master" device
> >> the full "reg" range it covers, and have it define its own
> >> address space; "sub-devices" can carve out their little hunk
> >> from that.  You don't want more than one device owning the
> >> same address range in the same address space.
> >
> > Why not?  After all, the physical address ranges of the flash
> > partitions really do overlap with that of the flash device as a whole.
> 
> They don't overlap, a partition is a proper subset of the flash.

A proper subset is a form of overlapping (indeed cases of being a
proper subset form a proper subset of cases of overlapping, to be
gratuitously meta-set-theoretic).

> Which as usual is shown as "reg" in the child node and #a,#s in
> the parent node.

That in no way encodes that the child addresses are a subset of the
parent address space.  Instead #a and #s establish a new, separate
address space for the children, and without 'ranges', there's no
information about any sort of connection, overlapping, proper-subset
or otherwise, with the parent address space.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
