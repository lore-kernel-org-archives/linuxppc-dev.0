Message-ID: <3ABA1B6A.87C5FE9B@intrex.net>
Date: Thu, 22 Mar 2001 10:34:03 -0500
From: Ralph Blach <rblach@intrex.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org,
	David Blythe <blythe@routefree.com>
Subject: Proposed new kernel noncaching memory allocator for the 405gp
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David,

This is what I propose,

I propose a kmalloc_noncache and a kfree_noncached.

These would be module and would be loaded when necessary.  They would
operate allocating say 16k (could be any size)  of memory during boot
time
and then mapping it non cached.  The the kmalloc_noncached routine would

carve out little chucks of it and the free routine would release it.  It

would also have a noncached to real routine
to return the real address of a noncached section.

Does this sound interesting?

Chip




David Blythe wrote:

> Ralph Blach wrote:
> >
> > David,
> >
> > Do you have USB working from on OHCI pci card?
> >
> > Would a kmalloc_nocache and kfree_cache be useful to you?
> >
> > Chip
> >
> >
>
> I think something more general then pci_alloc_consistent would be
better
> for devices that are not pci based.  We are still working on getting a

> pci OHCI usb to work with the walnut card and are running into a lot
of
> cache coherency problems.
>         david

--
Ralph "Chip" Blach
KF4WBK
Chapel Hill, North Carolina



--
Ralph "Chip" Blach
KF4WBK
Chapel Hill, North Carolina


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
