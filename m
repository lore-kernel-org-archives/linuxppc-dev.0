Date: Fri, 14 Jun 2002 10:10:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: consistent_free()
Message-ID: <20020614171035.GM13541@opus.bloom.county>
References: <20020614042928.GK26146@zax> <20020614153954.GL13541@opus.bloom.county> <3D0A1D53.6040205@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D0A1D53.6040205@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 14, 2002 at 12:44:03PM -0400, Dan Malek wrote:

[snip]
> The newer ARM version only allocates the number of pages necessary to
> cover the request.  The old version, and the one in PowerPC right now,
> would just use __get_free_pages, which was a power-of-two allocator.
> You could end up wasting lots of memory if you weren't allocating power of
> two sized buffers.  There were a couple of implementation iterations
> to make this work, and I guess this is where ARM ended up.  I think
> one version really wanted that page struct, but now it doesn't really
> matter.

I ended up noticing that myself, and have things almost right, I think
(patch shortly, if so..)

> >....  Dan?  Can we get some more insight
> >into the workings of your mind? :)
>
> I've been watching the ARM updates and plan to move their changes into
> the PowerPC sources.  I don't know why they don't call vfree() directly,
> I thought it did the proper clean up.

I'm not sure either.  __iounmap on ARM just is vfree() with the casts.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
