From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15627.4284.922612.834048@argo.ozlabs.ibm.com>
Date: Sat, 15 Jun 2002 20:02:36 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: consistent_free()
In-Reply-To: <3D0AE1EE.201@embeddededge.com>
References: <20020614042928.GK26146@zax>
	<20020614153954.GL13541@opus.bloom.county>
	<3D0A1D53.6040205@embeddededge.com>
	<15626.55930.673731.803194@argo.ozlabs.ibm.com>
	<3D0AE1EE.201@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> > Interesting.  Using __get_free_pages guarantees that the pages are
> > physically contiguous.  Does the new ARM version do something clever
> > to get physically contiguous pages?
>
> The  __get_free_pages just does an alloc_pages().  The only difference
> is __get_free_pages returns the page address of the first page.  I
> think there was a previous version that used page structs to return
> unused pages so it was just more convenient to call alloc_pages() directly.
> In fact, I guess this is the current implementation.

So it still allocates 2^n pages for some n?  That makes sense to me.
Your original comment:

> The newer ARM version only allocates the number of pages necessary to
> cover the request.  The old version, and the one in PowerPC right now,
> would just use __get_free_pages, which was a power-of-two allocator.

implied to me that if you wanted 40kB it only allocated 10 pages, not
16, but in fact it sounds like the ARM implementation will actually
allocate 16 pages too.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
