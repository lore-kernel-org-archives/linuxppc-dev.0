Message-ID: <3D0AE1EE.201@embeddededge.com>
Date: Sat, 15 Jun 2002 02:42:54 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: consistent_free()
References: <20020614042928.GK26146@zax>	<20020614153954.GL13541@opus.bloom.county>	<3D0A1D53.6040205@embeddededge.com> <15626.55930.673731.803194@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

> Interesting.  Using __get_free_pages guarantees that the pages are
> physically contiguous.  Does the new ARM version do something clever
> to get physically contiguous pages?

The  __get_free_pages just does an alloc_pages().  The only difference
is __get_free_pages returns the page address of the first page.  I
think there was a previous version that used page structs to return
unused pages so it was just more convenient to call alloc_pages() directly.
In fact, I guess this is the current implementation.

Oh, I see now........they set the Reserved indicator on pages they allocate.
This is why they can't just vfree() the space anymore.  Pretty sneaky, this
way an application can also mmap() the space and driver can do DMA from
user space.  What a f**king hack when you don't have the features you need
to do it correctly.

 > ....  Or do the callers have to do a
> scatter/gather type of operation if they are using more than 1 page?

No, you still get consecutive physical pages based on the order parameter.



	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
