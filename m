Message-Id: <5.1.0.14.2.20030905220237.00b084b8@mail.ebshome.net>
Date: Fri, 05 Sep 2003 23:07:14 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Copy prefetch optimizations and non-coherent caches
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all!

There are read prefetch optimization in several PPC specific functions
responsible for copying memory (copy_page, __copy_tofrom_user). Current
implementations will try to prefetch up to 4 (MAX_COPY_PREFETCH) cache
lines _after_ the end of the source buffer.

Unfortunately, it's not a good idea on non-coherent cache CPUs. This
prefetching may establish cache lines for memory ranges that require
exactly the opposite (e.g. DMA read buffer).

Here is one example of the incorrect behavior (from the real life :()

Let's consider two adjacent pages in RAM. First page contains some data and
the second one is used as target for DMA read. Please, note that these two
pages are completely unrelated to each other.

Before initiating "read" we invalidate cache lines for addresses in the
second page range (e.g. with consistent_sync_page(...., PCI_DMA_FROMDEVICE)).

Then somewhere else in the kernel we initiate copying from the _first_
page, e.g. to the user space with __copy_tofrom_user. During copying, this
function calls dcbt to prefetch up to 4 cache lines of the source data.

This will also result in prefetching 4 cache lines _after_ the end of the
source buffer, e.g. _first_ 4 cache lines of the _second_ page. If DMA read
hasn't started filling this memory, we'll may get old data instead of real
DMA read.

I think we should disable prefetch if CONFIG_NONCOHERENT_CACHE is defined.
Other more complex solutions are possible, e.g. we can still prefetch our
own buffer but don't touch anything outside (I'll try to do some
performance testing to determine whether it's worth the effort :).

Patch against linuxppc-2.4: http://kernel.ebshome.net/read_prefetch-2.4.diff

Patch against linuxppc-2.5 (not tested, but compiles):
http://kernel.ebshome.net/read_prefetch-2.6.diff

Comments, suggestions...

Eugene.

P.S. I suspect that "speculative" dcache fetch past the end of the memory
on 440 is really copy_page() prefetching source data. I'm guilty :), it was
my interpretation of the strange machine check we saw a year ago ...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
