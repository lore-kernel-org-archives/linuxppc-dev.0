Message-ID: <3BF1939A.B96072AC@labs.mot.com>
Date: Tue, 13 Nov 2001 15:41:46 -0600
From: Steve Rossi <srossi@labs.mot.com>
MIME-Version: 1.0
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: mmap & no cache regions 
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All -

I'm writing a driver for custom hardware on an 8xx based system. I'm
using MontaVista's Journeyman 2.0 (2.4.2 kernel). The driver uses
consistent_alloc to allocate a region of memory which is used for DMA. I
mmap that region to user space (using remap_page_range) such that the
user-level application can directly access the data that has been DMA'd
from the device. I learned that consistent_alloc is not sufficent to
guarantee cache coherency on the mmaped region - in fact I had to mark
these pages PAGE_NO_CACHE in the user space application's memory map as
well. Having figured that out, it all works great now - but my question
is: do I need to pay attention to how I deallocate and unmap that
space? I use consistent_free in the driver so that takes care of marking
the pages cacheable again in the kernel level mapping - but is it safe
to assume that the application's memory map will be destroyed so I don't
have to worry about marking the pages in that map as cacheable again?

Thanks,
Steve

--
-------------------------------------------------------
Steven K. Rossi                     srossi@labs.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
