Date: Mon, 28 Aug 2000 22:04:46 +0200 (MET DST)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Dan Malek <dan@netx4.com>
cc: Ronald Wahl <rwa@peppercon.de>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: allocating uncachable memory
In-Reply-To: <39A99B95.6F0109D8@embeddededge.com>
Message-ID: <Pine.GSO.4.10.10008282130010.10747-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> > If you mark the page(s) as reserved it should already do the right thing
> > on most architectures. The only problem is ioremap doesn't take an array
> > of pages.
>
> Hmmm...I thought reserved didn't imply that much information.  The 8xx
> allocates some memory early to get is reserved, but you still have to
> perform the PTE updates to get the cache attributes.

It's only needed because iounmap would otherwise also automatically free
the pages (since it simply calls vfree()).

> > Another possibility is __vmalloc(), that already has a protection
> > argument and you only need a virt_to_xxx() to get the address of the
> > allocated pages.
>
> That's the current plan.  If all you need is virt_to_xxx() it's easy.
> The xxx_to_virt() is nearly impossible.

xxx_to_virt() is completly impossible (with a decent performance) and IMO
shouldn't be needed. It's similiar to ioremap() - the driver has to
remember both, what of course is more complex with more pages.
If there is room in the page (e.g. at the end), it should also be possible
to do:

	kerneladdr = phys_to_virt(physaddr);
	virtaddr = kerneladdr->virtaddr;
	invalidate_cache(kerneladdr);

after that the driver can continue using the uncached virtual address.

> I'm waiting for some of the PCI mapping discussions to make
> sufficient changes to the I/O subsystem so I can just use those.

Usually one simply posts a patch and gets flamed to death, but then you
mostly get the best answers :-), where discussions without patches (that
could endanger the source) often lead nowhere...

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
