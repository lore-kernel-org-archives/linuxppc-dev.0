Return-Path: <dgibson@ozlabs.org>
Date: Sat, 24 Feb 2007 09:47:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: libfdt: a fix but still broken
Message-ID: <20070223224741.GD21625@localhost.localdomain>
References: <45DD9A41.7060900@smiths-aerospace.com>
	<20070223034734.GA18698@localhost.localdomain>
	<E1HKc1x-0001ze-0b@jdl.com> <45DF0696.80301@smiths-aerospace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45DF0696.80301@smiths-aerospace.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 23, 2007 at 10:21:58AM -0500, Jerry Van Baren wrote:
> Jon Loeliger wrote:
> > So, like, the other day David Gibson mumbled:
> >> On Thu, Feb 22, 2007 at 08:27:29AM -0500, Jerry Van Baren wrote:
> >>> Hi Dave,
> >>>
> >>> I have good news and bad news. ;-)  The good news is that the 
> >>> incompatibility between libfdt and jdl's dtc is that libfdt has the name 
> >>> offset and the length of the name switched.  booting_without_of.txt says 
> >>> the length comes first, so libfdt is in the wrong.
> >> Ouch.  That's.. a very embarrassing bug.  Actually, I know where it
> >> came from: I was looking at flat_dt.h from dtc, which also gets this
> >> wrong (but the declaration in question is unused).  Of course, I also
> >> wrote flat_dt.h ...
> >>
> >>> The bad news is that, when I fix this, nearly all of the tests fail (but 
> >>> they fail the same way for both tree.S and jdl's dtc).  I have not 
> >>> started on that layer of the onion yet.
> >> Found it, there was a direct use of the position of the length in
> >> _fdt_next_tag().  Just pushed out a fix for this in the libfdt tree,
> >> along with some other small fixes which I found while tracking this
> >> one down.
> >>
> >> Oh, incidentally, I applied your patch by eye rather than with
> >> patch(1), which was handy, because it appears to have been whitespace
> >> damaged.
> > 
> > And amidst all of this, is there an actual DTC change needed?
> > I've not detected one yet, but I'm watching... :-)
> > 
> > jdl
> 
> Hi Jon,
> 
> Your dtc is the "gold standard."  Gold doesn't tarnish.  ;-)

No, the kernel's parser is the gold standard.

> David's libfdt supports version 17 that dtc doesn't - I'm not sure where 
> version 17 came from, David or elsewhere.  Version 17 adds one more size 
> to the blob header structure and is suppose to be backward compatible 
> with version 16. (A couple of the current libfdt tests fail when run 
> against a dtc-generated version 16 blob - don't know where the fault 
> lies yet.)

Version 17 is my invention, though the extension in question was also
planned by BenH.  And yes, V17 needs to be documented in
booting-without-of.txt and support needs to go into dtc.

The V17 extension allows us to do resizing modifications to the device
tree without having to allocate an extra context structure somewhere.
Your testcase failures are probably because the fdt_rw.c functions are
incapable of operating on a V16 tree.  fdt_open_into() is supposed to
convert a V16 tree into a V17 tree with the correct layout, allowing
those functions to operate, but I haven't gotten around to
implementing it yet.

Incidentally, jdl took over maintainership of dtc from me when I went
on extended leave last year, but the bulk of it is my code.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
