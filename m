Message-ID: <3C4A96D7.9010501@embeddededge.com>
Date: Sun, 20 Jan 2002 05:07:19 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: consistent_alloc changes for 4xx/8xx
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi folks.

If you don't care about 4xx/8xx and incoherent caches, you can stop
reading now.

At the request of some people that wanted a pinned TLB feature, I had
to modify the consistent_alloc() function to allocate virtual space out
of the kernel's vmalloc pool and assign individual pages with uncached
attributes.  This has created some problems with the Linux VM subsystem,
most notably you can't call consistent_alloc() from an interrupt handler
as the documentation indicates.  There was some discussion on l-k about
this (calling from interrupt in general) over the last few days.  Since
consistent_alloc() (or pci_consistent_alloc(), the source of discussion)
can return errors and not allocate the space, I questioned the value of
adding this complexity to a driver, but I was simply told "this is the
way it is."  Well, unfortunately it isn't on the 4xx and 8xx now.

The problem arises when you try to allocate out of an interrupt handler
and the vmalloc() (well, map_pages() actually) needs to allocate a page
table and a free page doesn't exist.  The page table allocator will try
to sleep at this point, which you obviously can't do from an interrupt.

Another, more challenging, situation also exists because you can't use
the __va()/__pa() macros on the addresses returned from consistent_alloc().
On the 4xx/8xx, the virt_to_* macros will call iopa() which will track down
the real physical address in the page table, which continues to work.  It
isn't possible to find the virtual address from the physical one, so drivers
need to be changed to keep the addresses returned from consistent_alloc()
and use them.  It also means that drivers requiring uncached memory very
early in the kernel, like the serial console on the 8xx, can't get the
memory and must do something different.  I don't think any other drivers
are affected by this.

My original implementation of consistent_alloc() assumed the kernel was
mapped with 4K pages, and when you wanted an uncached page the attributes
were simply changed in place.  There wasn't any need to allocate page table
pages, so the interrupt problem didn't exist.  You could also use the
fast mapping macros if desired.

For testing, I added the ability on the MPC860 to pin the first 8M of kernel
text (of which there is probably on 512K used), up to 24 Mbytes of kernel
data, and the 8M IMMR space.  Note that this will only work on the 860
processors with a 32 entry TLB.  I added, but couldn't test for lack of
hardware, a similar feature to the 4xx.  I wanted to check this in before the
kernel changed too much, and I have volunteers testing it, so any problems
should be corrected shortly.  Note that this TLB pinning comes at a cost of
taking TLB entries out of use for applications, so IMHO it isn't something
that should be done without verification of total system performance improvement.

I hope someone can find some benchmarks where this feature actually provides
benefit.  On the 8xx with madplay, I gained a whole 0.300 seconds on average
using a 5 minute audio track.  Not worth the hassle in my opinion, but I
congratulate anyone that can design to these extremes :-).  If nothing else,
it made me finally check in the Embedded Planet HIOX audio driver.

If the calling from interrupt handler, out of memory, system crashing
is an issue for someone, we can likely fix this with some minor changes
to the generic Linux VM functions.  Whether they are accepted is another
challenge :-).  We can also consider using the older consistent_alloc()
implementation as an option when this is a problem.

Thanks.  Have fun.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
