Date: Thu, 25 Jan 2001 19:37:20 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Dan Malek <dan@mvista.com>
cc: mgreer@mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_HIGHMEM on PPC
In-Reply-To: <3A705D92.682A6FEF@mvista.com>
Message-ID: <Pine.GSO.4.10.10101251858330.22965-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Thu, 25 Jan 2001, Dan Malek wrote:

> > .... If you have a highmem page, use kmap to get
> > temporary virtual mapping. On the other hand most of the drivers should
> > never see a highmem page.
>
> On the other hand, if highmem was designed properly the kernel
> should just fault in the needed pages and virt_to_phys and friends
> should just work in this space, too.  Yet another set of functions
> to use and restrictions just because a physical page exists beyond
> some arbitrary boundary?  Geeze, I thought we learned from Mush-DOS
> back in the mid-80's this was not a good design........

The problem is the ia32 guys want to address 64GByte, what requires a
64bit physical address, what nobody can handle on 32bit Systems.

> I removed the #ifdef APUS in the virt_to_phys and friends macros
> and made everyone call iopa which is going to move to a new file
> called arch/ppc/mm/ioremap.c (like other architectures do).  I
> don't think the mm_ptov() function works on anything because the
> kmap_chunks is gone (at least in the linuxppc_2_5 I am using).
> Perhaps I'm just missing some updates from you.  I'll delete
> these functions from apus_setup.c since they are common to everyone
> now.  I'm almost done with this first phase of IBM4xx merge, which
> I will probably start checking in later today.  I'm just testing
> on as many other platforms as I can to ensure I didn't break other
> stuff.

Please be careful with what you're doing, otherwise you have to rewrite it
again for the real 2.5.
For what exactly do you need such generic virt_to_phys? AFAIK 2.5 will go
more page oriented, so drivers get a set of pages to work on. That will
mean bounce buffer management will be moved into the drivers. So I expect
at some point virt_to_phys will become obsolete or at least private to the
architecture specific part. Either everything is done with pages or one
has to store a virtual/physical address pair. Doing a generic conversion
functions for the latter is often slower, so it's currently expected that
drivers just store it themselves.
That's at least my understanding of the developments to come, what can be
of course completely wrong. :-) To be sure you had to ask one the kernel
gurus.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
