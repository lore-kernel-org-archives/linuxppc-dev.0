Date: Tue, 25 Jun 2002 07:39:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: consistent_free()
Message-ID: <20020625143937.GN3489@opus.bloom.county>
References: <20020614042928.GK26146@zax> <20020614055711.GA1124@zax> <20020624021538.GX9087@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020624021538.GX9087@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jun 24, 2002 at 12:15:38PM +1000, David Gibson wrote:
>
> On Fri, Jun 14, 2002 at 03:57:11PM +1000, David Gibson wrote:
> >
> > On Fri, Jun 14, 2002 at 02:29:28PM +1000, David Gibson wrote:
> > >
> > > In attempting to make consistent_alloc/free() work sensibly on
> > > processors which are cache coherent I ran into a problem.
> > > consistent_free() doesn't take a size argument.  We don't need it in
> > > the case of not cache coherent processors - in that case
> > > consistent_alloc() sets up a vm_area() so there's enough information
> > > to get the size.  However for cache coherent processors we probably
> > > want consistent_alloc() to degenerate to __get_free_pages(), in which
> > > case consistent_free() must degenerate to free_pages(), which takes a
> > > size argument.
> > >
> > > I suggest we change consistent_free() to take the virtual addresss,
> > > size and the physical address (dma_addr_t), which will make our
> > > consistent_free() match the one on ARM.  I know we don't need the
> > > third argument in any existing situation.
> > >
> > > Patch coming...
> >
> > As promised...
> >
> > This boots up fine on my EP405PC board, and I'm sending this mail from
> > my TiBook running 2_4_devel with this patch and also the 40x large
> > page PMD patch.
>
> Again, silence reigns.  Anyone who would object to this being applied
> to the linuxppc-2.5 tree, speak up now.

If we're going to touch this, can you look at the current ARM version of
it and grab all of the goodies they've got now?  I almost had this going
(and I can shoot you the patch off the list if you like) but haven't had
time to go back to it.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
