Date: Fri, 17 May 2002 18:44:42 -0700
From: Ira Weiny <iweiny@acm.org>
Subject: Attempt to remap_page_range a second time.
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Message-id: <20020517184442.39d95880.iweiny@acm.org>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I want to be able to mmap multiple buffers from one device all with basically
an offset of 0.

What I have done is the user process calls read on the device and the data
returned from the read indicates how much data to mmap.  The user process then
mmaps this data processes it and munmaps it.  The next time the user process
calls read the next buffers size is returned and the next mmap call will mmap
this new buffer.

The problem is that if I use the same buffer 2 times in a row I get the
following error:

forget_pte: old mapping existed!

I have a vm_operations_struct defined which allows my buffer to be free'd on
the munmap if necessary but at this time it is only putting it on a free list
and the buffer is being reused for testing.

I can't find a call which "reverses" the remap_page_range function.  For all I
can tell the do_munmap call should take care of cleaning up the old mapping.

Does this sound familiar?  Does anyone know what I am doing wrong?

Do you need more details?  I am using the 2.4 kernel.

Thanks,
Ira Weiny
iweiny@acm.org


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
