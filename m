Date: Wed, 5 Jun 2002 10:10:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: First cut at large page support on 40x
Message-ID: <20020605001034.GB17752@zax>
References: <20020531042153.GD16537@zax> <3CFC0D3F.9030901@embeddededge.com> <20020604035947.GH2762@zax> <3CFCFC20.80101@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CFCFC20.80101@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 04, 2002 at 01:42:56PM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
> >That sounds dangerous to me:
>
> It's not.  All you end up finding are the kernel ram pages and the
> early 1:1 mapping of I/O space that never changes. The vmalloc()'ed
> space isn't properly ordered to find monotonically increasing page
> frame numbers.  It's just a cleaner implementation because you have
> processor specific functions to set up the PMD that aren't cluttering
> the generic functions.  If necessary, you can sift through the VM ranges
> and ensure the things you feel are inappropriate aren't put into the PMD
> large page mapping.
>
>
> >......  Furthermore this way we
> >save a little bit of RAM, because we don't need to store the bottom
> >level page tables for the kernel mapping,
>
> If you would allow these to stay, you wouldn't have to change any other
> mapping functions, like iopa().  It's only a couple of pages.......
>
> >..... and the TLB miss handler is
> >simpler and faster because like a normal PTE it can load most of the
> >TLB_DATA field directly from the PMD entry.
>
> That's the idea :-)
>
> For the MPC8xx I did two simple things.  First, added the function to
> scan the usual page tables that were built and update the PMD to indicate
> the large pages.  Second, changed the tlb miss handler to load the PMD into
> the MMU register with making any modifications to the bits.  The PTE is
> then loaded just as it always was (the 8xx has nice support for large pages
> following the normal PTE loading path).

Hang on, I'm not clear about this.  Does your PMD contain an entry to
be loaded into the TLB or not?  In my implemention the PMD entry
itself contains the data to load into TLB_DATA (except that we borrow
the top three bits of ZSEL for the page size).  Since we're doing that
there's no room in the entry for a pointer to a page of PTEs.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
