Message-ID: <39A99B95.6F0109D8@embeddededge.com>
Date: Sun, 27 Aug 2000 18:52:05 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Roman Zippel <zippel@fh-brandenburg.de>
CC: Dan Malek <dan@netx4.com>, Ronald Wahl <rwa@peppercon.de>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: allocating uncachable memory
References: <Pine.GSO.4.10.10008272258170.29427-100000@zeus.fh-brandenburg.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel wrote:

> If you mark the page(s) as reserved it should already do the right thing
> on most architectures. The only problem is ioremap doesn't take an array
> of pages.

Hmmm...I thought reserved didn't imply that much information.  The 8xx
allocates some memory early to get is reserved, but you still have to
perform the PTE updates to get the cache attributes.

> Another possibility is __vmalloc(), that already has a protection
> argument and you only need a virt_to_xxx() to get the address of the
> allocated pages.

That's the current plan.  If all you need is virt_to_xxx() it's easy.
The xxx_to_virt() is nearly impossible.  I have a VM implementation that
uses (or tries to) mixed large pages, but all of the existing assumptions
about memory mapping fail.  Everything will have to vmalloc() and then
use virt_to_xxx/xxx_to_virt() (which are much more than simple addition
macros).  I'm waiting for some of the PCI mapping discussions to make
sufficient changes to the I/O subsystem so I can just use those.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
