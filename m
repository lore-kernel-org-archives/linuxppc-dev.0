Message-ID: <3F147CEF.3030803@embeddededge.com>
Date: Tue, 15 Jul 2003 18:15:11 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Blythe <blythe@broadon.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [RFC] consistent_sync and non L1 cache line aligned buffers
References: <5.1.0.14.2.20030715133146.030d2e60@mail.ebshome.net> <3F14719F.7080105@broadon.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Blythe wrote:

> 2) change the definition to allow non-aligned addresses and handle them
> gracefully

What's your implementation proposal?  I contend you can't guarantee
a perfectly working solution due to the race conditions surrounding
the software managment of a cache line, the processor potentially
accessing that cache line, and the DMA that is in progress.  In any
case, you are going to require the programmer has knowledge of something
associated with the cache line, either the alignment or other processor
accessed data that will reside there.  Although the DMA buffers on
the stack are a very poor programming practice, the main problem for
us is that it immediately shows the programmer requires proper buffer
alignment or assignment of other objects to the cache line that won't
cause problems.  If you aligned those stack DMA buffers, you wouldn't
see this problem.

A design constraint of non-coherent cache is the operations on the
cache lines are whole and atomic.  IMHO, the easiest solution is
alignment of buffers.....plus it's likely to be a performance improvement.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
