Message-ID: <3D195243.5090408@embeddededge.com>
Date: Wed, 26 Jun 2002 01:33:55 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: consistent_free()
References: <20020614042928.GK26146@zax> <20020614055711.GA1124@zax> <20020624021538.GX9087@zax> <20020625143937.GN3489@opus.bloom.county> <20020626051735.GM9087@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> (2) seems very strange.  It doesn't seem in keeping with the meaning
> of PageReserved (well my best guess at the meaning from only slightly
> illuminating comments in page.h).

It looks strange to me as well, and wouldn't do that part.  I called
map_page() directly to avoid doing this, and in return we can just
call vfree() to get rid of the space.

> .... Which makes me
> wonder how the hell anything works now, since remap_page_range() is
> apparently called from several places.

I could only find a few places where it is called, and it seems to always
be called on pages that have been previously reserved (kernel ram or I/O space).
One of the advantages of making the page reserved in this case is you can
then mmap() it from a user application and get DMA to/from user space to work.
Normally, an mmap() from user space on memory gets you new, zeroed pages.

My only concern about not marking the pages reserved is ensuring they are not
eligible for swapping.  That would kind of suck if it happened :-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
