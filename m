Date: Tue, 4 Jun 2002 13:59:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: First cut at large page support on 40x
Message-ID: <20020604035947.GH2762@zax>
References: <20020531042153.GD16537@zax> <3CFC0D3F.9030901@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CFC0D3F.9030901@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jun 03, 2002 at 08:43:43PM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
> >The only large-page PTEs used are created in mapin_ram() for the
> >kernel mapping of system RAM.
>
> I did a similar thing for 8xx, except I didn't change any of the existing
> mapping code.  At the end of the kernel initialization, I added a function
> to scan the page tables looking for areas we could coalesce into larger
> pages.  I would then update the PMD entry to indicate the size of the pages
> (4M or 8M in the case of 8xx) it could use to cover this space.  This way
> I could also get any I/O mapping that was done and I didn't have to
> complicate
> any of the existing mapin_ram() or other code with processor specific
> changes.
> Also, iopa() and any page lookup functions should work since the only change
> was to add control bits to the least significant part of pmd entry.

That sounds dangerous to me:  many of the kernel mappings could change
with vfree() or iounmap().  The mapping of physical RAM established in
mapin_ram() we know will be around forever.  Furthermore this way we
save a little bit of RAM, because we don't need to store the bottom
level page tables for the kernel mapping, and the TLB miss handler is
simpler and faster because like a normal PTE it can load most of the
TLB_DATA field directly from the PMD entry.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
