Message-ID: <3E008DE0.2040902@intracom.gr>
Date: Wed, 18 Dec 2002 17:01:52 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Docs for the new style dpalloc/hostalloc patch.
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello.

Since the first mail I've sent hit the mailing list limit
and got deleted, the following with only the patches
are rather confusing.

Here are some pointers about what the patch does and the
rational behind it's creation...

The patch is against the current top linuxppc_2_4_devel tree,
and provides better functions for allocation of dual ported
memory and uncached host memory for the 8xx family of processors.

The problem with the current allocation routines are
that are very simplistic. They only keep a top
pointer to the next memory range to allocate
and never free the allocated memory.

This is fine for any drivers compiled into the kernel,
but brakes down when you want to have your driver
as a module.

The requirement to have a driver as a module is
peculiar when talking about so small systems, but
it is the only way if you want to avoid GPLing all
your design.

As I mentioned we will submit all changes done to
the kernel and the standard drivers, but
we cannot do that for our proprietary hardware.

The new routines get around the problem by
managing the memory properly.

That is the memory allocated can be freed and
then reused for any following requests.

The implementation is done by using something
called a remote heap.
It is called remote because in constrast to
the normal heap management schemes we cannot
use the memory we allocate to implement lists
holding the allocated and free region.
A nice side effect is that there is no overhead
on the managed address ranges.

The enable switches are under 'MPC8xx CPM Options'.
If you don't enable then everything works the same as
before.

The functions are:

void *new_m8xx_cpm_dpalloc(unsigned int size, const char *owner);

   Allocate the given amount of memory from the dual port ram
   and assign a text string describing the owner.
   A future patch that will add a proc interface to the cpm.
   The size is rounded to the next 8 bytes.

   Returns the va of the allocated address on success.
   It is always aligned to an 8 byte boundary.
   NULL otherwise

int new_m8xx_cpm_dpfree(void *start);

   Free the previously allocated memory.
   Returns the size of the freed block, or -EINVAL in
   case the start argument does not lie in any allocated
   block.

void *new_m8xx_cpm_dpalloc_fixed(void *start, int size,
                                  const char *owner);

   The same thins as the previous dpalloc function, but
   you can request memory from a specific address.
   In a future patch, this is used to allocate the
   microcode dpram areas.

void *new_m8xx_cpm_hostalloc(unsigned int size, const char *owner);

   Allocate the given amount of uncached host memory for use by
   the cpm. Typically this memory will used for FIFOs, BDs and
   such when the cost of explicitly calling the invalidate_dcache
   and flush_dcache function is provibitive.
   If no available free memory is already present, it will allocate
   enough pages to satisfy the request. These pages
   will be tracked and when a later free releases all the
   memory allocated from them, they will be freed.
   Return NULL on out of memory.

int   new_m8xx_cpm_hostfree(void *start);

   Frees the given memory by a previous call to the hostalloc function.
   Returns the size of the free memory block or -EINVAL on error.


That's it, please contact my for any more info.

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
