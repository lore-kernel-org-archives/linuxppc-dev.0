Return-Path: <dgibson@ozlabs.org>
Date: Fri, 10 Aug 2007 11:11:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Message-ID: <20070810011136.GC17370@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<59e87834966d80bb143e1683fe751cd1@kernel.crashing.org>
	<20070807034136.GC13522@localhost.localdomain>
	<03211b7766f4a21c90889344f843a564@kernel.crashing.org>
	<20070808015150.GC20565@localhost.localdomain>
	<627e5728e1f0e475f3504529a79ee228@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <627e5728e1f0e475f3504529a79ee228@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 09, 2007 at 10:00:47PM +0200, Segher Boessenkool wrote:
> >> For the JEDEC chips, we need a "vendor-id" and "device-id"
> >> property at least (or similar names -- whatever is general
> >> practice for this); both are a single byte, encoded as with
> >> encode-int.
> >
> > Ok... should those really be separate properties, or should that go in
> > compatible, i.e. something like:
> > 	compatible = "amd,XXXXXX", "jedec,a4-b7", "jedec-flash";
> 
> Good question.  I think we want the separate bytes, if nothing
> else then just for the benefit of drivers that have their own
> table of those already.  But the "compatible" thing also has
> its merits of course.  

Ok.  Well, I guess there's no reason we can't have both.  Separate
properties for convenient access, and a compatible encoding for
unified matching.

>  I'll ask some flash gurus about what's
> special about JEDEC flash, and maybe even read a datasheet or
> two.  We're in no hurry right, CFI flash is lots more common
> nowadays ;-)

Ok.

> >>>> One thing though -- what _exactly_ does "read-only" signify?
> >>>
> >>> That's... a good question.
> >>
> >> Yeah.  It seems to me that the way it is currently used is
> >> pure policy enforcement, which doesn't belong in the device
> >> tree.
> >
> > Well.. not really policy enforcement, but a policy hint.
> 
> So it most likely doesn't belong there.  How the OS userland
> wants to mount those partitions, if at all, and if they even
> contain a filesystem -- that's all its own business and belongs
> in /etc/fstab or whatever the newfangled thing is.

Hrm.  You can argue the same about all the partition information, but
where else does it go.  Encoding suggested platform policy into the
device tree isn't fabulous, but it beats hardcoded per-platform flash
maps.

> On most flash chips, you can actually write-protect some
> sectors; "read-only" sounds more like that.  Although
> "write-protected" would be a better name.
> 
> Or maybe "read-only" is useful and I just don't see why.  In
> that case, please figure out what its semantics are :-)

Heh, well, in practice the semantics are that it passes a read-only
flag through to the mtd layer.  I guess we need to ask the physmap_of
author what he thought the read-only bit in the old binding should be
used for.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
