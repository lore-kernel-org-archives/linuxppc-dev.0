Date: Wed, 26 Jun 2002 15:59:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: consistent_free()
Message-ID: <20020626055906.GN9087@zax>
References: <20020614042928.GK26146@zax> <20020614055711.GA1124@zax> <20020624021538.GX9087@zax> <20020625143937.GN3489@opus.bloom.county> <20020626051735.GM9087@zax> <3D195243.5090408@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D195243.5090408@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 26, 2002 at 01:33:55AM -0400, Dan Malek wrote:
> David Gibson wrote:
>
> >(2) seems very strange.  It doesn't seem in keeping with the meaning
> >of PageReserved (well my best guess at the meaning from only slightly
> >illuminating comments in page.h).
>
> It looks strange to me as well, and wouldn't do that part.  I called
> map_page() directly to avoid doing this, and in return we can just
> call vfree() to get rid of the space.

Well that's the doubly odd thing.  After marking the pages reserved
the ARM consistent_alloc() then uses its own functions, not
remap_page_range() to do the remapping.  From the looks of it they
have the same structure as the remap_page_range(), but are without the
(broken?) test and I think have little effective difference to our
direct calling of map_page().

So the setting of PG_reserved will only affect attempts to
remap_page_range() on the physical pages after they have already been
consistent_alloc()ed.  I can't see why you'd want to do that.

> >.... Which makes me
> >wonder how the hell anything works now, since remap_page_range() is
> >apparently called from several places.
>
> I could only find a few places where it is called, and it seems to always
> be called on pages that have been previously reserved (kernel ram or I/O
> space).

Hmm.. ok.  That does seem a bit odd - the comment above
remap_page_range() says that it will create null mappings if the page
doesn't exist.  But it seems from the code that it will create null
mappings if the page *does* exist and will only create real mappings
if the page doesn't exist or is reserved.

AFAICT most kernel ram is not PageReserved, only leftover bootmem.  IO
memory won't usually be reserved - in general it won't even have a
struct page at all.

> One of the advantages of making the page reserved in this case is you can
> then mmap() it from a user application and get DMA to/from user space to
> work.
> Normally, an mmap() from user space on memory gets you new, zeroed pages.

I don't see how PG_reserved helps this particularly.  As long as the
driver implementing the mmap() allocates the physical memory (so the
VM won't take it away from us) before mapping it into user space.
It's probably also a good idea for the driver to maintain its own
virtual (uncached) mapping as well as the userspace one.  So using
consistent_alloc() and then remapping the physical addresses into
userspace should suffice.

> My only concern about not marking the pages reserved is ensuring they are
> not
> eligible for swapping.  That would kind of suck if it happened :-)

It certainly would.  I don't think pages that we've allocated with
get_free_pages() will be swapped (just like kmalloc()ed pages won't
be), but I don't know enough about the VM to be sure.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
