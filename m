Message-ID: <3D7FB97B.9060301@mvista.com>
Date: Wed, 11 Sep 2002 14:45:31 -0700
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: consistent_free re-revisited
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The APIs for consistent_free have diverged between PPC and ARM.  It has,
at least in the past, been a goal to keep the APIs in sync.

Revisiting this is prompted by a couple of new platforms recently added
(Xilinx Virtex II Pro and IBM 405LP/Beech) that use consistent_alloc for
framebuffers mmap'ed to X servers.  It would be nice (but is hardly a
critical need) if consistent_alloc/free would set/clear the reserved bit
on the struct page's allocated, such that the returned memory can be
mmap'ed to userspace without the driver explicitly setting these bits, a
la ARM.

On PPC this is complicated by the fact that consistent_free does not
take a size parameter, describing the size of the allocated area, nor a
dma_handle parameter, which ARM uses to derive struct page's.

Furthermore, consistent_alloc does not fill out vm_struct fields for the
VM area that map it to the struct pages, so consistent_free can't use
those to derive the physical pages.  And neither can vfree(), which is
what consistent_free() calls to do its work.  And so consistent_free()
does not free the physical pages allocated by consistent_alloc(), which
is a potentially more serious matter (although I suppose consistent_free
isn't normally in heavy use, but hi-res framebuffers can get large).

Setting/clearing reserved bits and init'ing the vm_struct fields such
that physical pages are reclaimed by vfree() can be accomplished without
API changes, at the expense of intruding into private VM data structures
and inefficiency of allocating an array of struct page pointers to
describe a contiguous chunk of memory.  So it seems preferable to add
the size and dma_handle params to consistent_free and do the physical
page freeing there (and update the drivers that call it).  Comments?
Thanks,


--
Todd


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
