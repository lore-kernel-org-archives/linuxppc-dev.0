Date: Thu, 27 Jun 2002 12:42:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: consistent_free()
Message-ID: <20020627024206.GU9087@zax>
References: <20020614042928.GK26146@zax> <20020614055711.GA1124@zax> <20020624021538.GX9087@zax> <20020625143937.GN3489@opus.bloom.county> <20020626051735.GM9087@zax> <15641.53391.924751.554517@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15641.53391.924751.554517@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 26, 2002 at 10:32:47AM -0400, Paul Mackerras wrote:
>
> David Gibson writes:
>
> > Well, I had a look at the ARM version and now I'm a bit confused.  As
> > far as I can tell it does two things differently from us:
> > 	1) After making the allocation rounded up to the appropriate
> > order it frees any leftover pages.  That certainly seems worthwhile.
> > 	2) It sets PageReserved on each struct page that it
> > allocates/remaps.
> >
> > (2) seems very strange.  It doesn't seem in keeping with the meaning
> > of PageReserved (well my best guess at the meaning from only slightly
>
> PageReserved means that the VM system shouldn't try to manage this
> page.  In particular, it shouldn't try to do the page aging/move to
> swap cache/swap out stuff that it will do on normal pages.

Ok, it's still not clear to me whether we need to set PageReserved or
not.  Is memory we've allocated with get_free_pages() safe to use
without fear of it being swapped from under us or not?

Surely it couldn't be swapped, since it resides in the kernel lowmem
mapping.

> > illuminating comments in page.h). Apparently it's so that
> > remap_page_range() works - as indeed it wouldn't without this because
> > of a test in remap_pte_range() which that calls.  But that test looks
> > to be precisely inverted from what it should be.  Which makes me
>
> No, it's right.  remap_page_range() is only meant to be used for pages
> that are either memory-mapped I/O (the !VALID_PAGE(page) test) or for
> pages that are "special" (the PageReserved(page) test).  You aren't
> supposed to use remap_page_range on normal RAM that the VM is
> managing.

Ah, ok that makes some sense.  I think the comment above
remap_page_range() needs rewriting, though.

> > wonder how the hell anything works now, since remap_page_range() is
> > apparently called from several places.
>
> It's only called from drivers (such as /dev/mem) or from arch-specific
> code AFAICS.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
