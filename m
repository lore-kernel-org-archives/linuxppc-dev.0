Date: Thu, 13 Jun 2002 15:27:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: get_pteptr()
Message-ID: <20020613052745.GF4228@zax>
References: <20020613040345.GD4228@zax> <3D08276D.3080502@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D08276D.3080502@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 13, 2002 at 01:02:37AM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
> >get_pteptr() is used in exactly three places:
> >	- in arch/ppc/8xx_io/commproc.c in the #else side of a #if 1,
> >i.e. not really used at all.
>
> That was one of my earliest cache management hacks, that predated iopa()
> and consistent_alloc().  You can get rid of it.

Ok, I will.

> >	- in do_page_fault() [arch/ppc/mm/fault.c] for the handling of
> >page execute faults on 40x.  It's use here is arguably incorrect if
> >large page pmds are introduced, although we won't ever get execute
> >faults on large pages, so it doesn't really matter.
>
> Hmmmm.....I was always hoping we could use "standard" VM functions to
> find and update PTEs, but I guess that isn't happening.  I would suggest
> just placing a comment around this about the large pages and leave it.

I think this is easier said than done, because depending on what's
being done you often need to do different things at each level of
walking the page tables.

In some ways it would make more sense to handle these exec faults in
handle_mm_fault() (which already implements a page table walk), along
with normal read and write faults.  But that would mean muddying
generic code with exec fault stuff which is only relevant for a few
processors.

> >But given that iopa() is pretty much the only user of this function
> >(do_page_fault() should be done slightly differently, I think), there
> >doesn't seem a lot of point.  Why not just eliminate get_pteptr() and
> >walk the page tables explicitly in iopa().
>
> I sometimes use get_pteptr() for debug.  Make sure xmon doesn't use it
> for printing page table information.

It doesn't.  I know there are only those 3 (really 2) users, because I
grepped the whole source for it.  Debugging is a legitimate use, I
guess, though, so I might leave it in for now, even though little will
use it.

> >[*] Well, apart from removing iopa() entirely, but that's another
> >flamewar^Wdiscussion.
>
> Just remove it for 4xx, or put an #ifdef in iopa() to do the arithmetic
> conversion.  It's only used on 4xx and 8xx, and I would like to ensure
> the 8xx still works correctly before we nuke everything.  I would just
> be a little careful to ensure you have run enough PCI cards to verify
> everything is OK.

Do you mean get_pteptr() or iopa()?  If iopa() I agree with paulus,
removing it from 2.4 would be unwise - it could break (already broken
but kinda working) drivers.  I simply don't have the hardware to test
really thoroughly.  I do think it should go from 2.5. though.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
