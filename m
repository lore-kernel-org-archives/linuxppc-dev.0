Message-ID: <3CFCFC20.80101@embeddededge.com>
Date: Tue, 04 Jun 2002 13:42:56 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: First cut at large page support on 40x
References: <20020531042153.GD16537@zax> <3CFC0D3F.9030901@embeddededge.com> <20020604035947.GH2762@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> That sounds dangerous to me:

It's not.  All you end up finding are the kernel ram pages and the
early 1:1 mapping of I/O space that never changes. The vmalloc()'ed
space isn't properly ordered to find monotonically increasing page
frame numbers.  It's just a cleaner implementation because you have
processor specific functions to set up the PMD that aren't cluttering
the generic functions.  If necessary, you can sift through the VM ranges
and ensure the things you feel are inappropriate aren't put into the PMD
large page mapping.


> ......  Furthermore this way we
> save a little bit of RAM, because we don't need to store the bottom
> level page tables for the kernel mapping,

If you would allow these to stay, you wouldn't have to change any other
mapping functions, like iopa().  It's only a couple of pages.......

> ..... and the TLB miss handler is
> simpler and faster because like a normal PTE it can load most of the
> TLB_DATA field directly from the PMD entry.

That's the idea :-)

For the MPC8xx I did two simple things.  First, added the function to
scan the usual page tables that were built and update the PMD to indicate
the large pages.  Second, changed the tlb miss handler to load the PMD into
the MMU register with making any modifications to the bits.  The PTE is
then loaded just as it always was (the 8xx has nice support for large pages
following the normal PTE loading path).

This is of course after Paulus modified the page table macros to be aware of
additional control bits in the PMD :-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
