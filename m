Message-ID: <3A705D92.682A6FEF@mvista.com>
Date: Thu, 25 Jan 2001 12:08:34 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Roman Zippel <zippel@fh-brandenburg.de>
CC: mgreer@mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_HIGHMEM on PPC
References: <Pine.GSO.4.10.10101251016230.20829-100000@zeus.fh-brandenburg.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel wrote:

> And they don't have to.

So, why do we have so damn many ways and hacks to do stuff like
this?  If a page or I/O is mapped into the VM space, there should
be a set of common functions to manage this space, and exactly one
function to do the virt_to_phys.

> .... If you have a highmem page, use kmap to get
> temporary virtual mapping. On the other hand most of the drivers should
> never see a highmem page.

On the other hand, if highmem was designed properly the kernel
should just fault in the needed pages and virt_to_phys and friends
should just work in this space, too.  Yet another set of functions
to use and restrictions just because a physical page exists beyond
some arbitrary boundary?  Geeze, I thought we learned from Mush-DOS
back in the mid-80's this was not a good design........


> I do currently.

I removed the #ifdef APUS in the virt_to_phys and friends macros
and made everyone call iopa which is going to move to a new file
called arch/ppc/mm/ioremap.c (like other architectures do).  I
don't think the mm_ptov() function works on anything because the
kmap_chunks is gone (at least in the linuxppc_2_5 I am using).
Perhaps I'm just missing some updates from you.  I'll delete
these functions from apus_setup.c since they are common to everyone
now.  I'm almost done with this first phase of IBM4xx merge, which
I will probably start checking in later today.  I'm just testing
on as many other platforms as I can to ensure I didn't break other
stuff.

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
