Date: Mon, 12 Apr 1999 14:48:17 +1000
Message-Id: <199904120448.OAA20256@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: kbhend@business.wm.edu
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <v03010d02b3369714fb07@[209.96.179.41]> (kbhend@business.wm.edu)
Subject: Re: PPC Kernel Gurus Help?
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <v03010d02b3369714fb07@[209.96.179.41]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin B. Hendricks <kbhend@business.wm.edu> wrote:

> >I hope Apple's implementation is just overkill.  The linuxthreads
> >pt-machine.h file in both glibc 1.99 and glibc 2.1 do not have the extra
> >isyncs (they just use sync both before and after the routine).  They also
> >do not align things to cache boundaries.  To do that we would have to
> >change the sem_t because both the spinlock and the semaphore value are
> >side by side and both are accessed this way meaning that sem_t would have
> >to be 32 byte aligned and take up 64 bytes to be safe (32 for the
> >semaphore and 32 for the spinlock).

Does it use lwarx/stwcx. to access both the spinlock and the
semaphore?  If so that could possibly cause a problem if they are in
the same cache line (strictly, "reservation granule").

> >By the way,  I looked in that arch/ppc kernel for 2.2.1 and their
> >implementation of testandset and compare_and_swap does not use either sync
> >or isync or any cache alignment!!!!! (see bitops, misc.S and head.S for
> >examples)

The way I understand it is that the syncs aren't necessary for the
atomic nature of the read/modify/write on the location you're
accessing with lwarx/stwcx.  The reason you would have syncs there is
if you additionally want some ordering (WRT other cpus) between the
atomic R/M/W and other memory accesses you do before or after it.
Thus in the kernel source you will see syncs in the semaphore code but
not in the atomic operations.  An atomic operation doesn't of itself
imply anything about other memory accesses, whereas a semaphore
lock/unlock does.

> >The PowerPC manual in Appendix G mentions the cache grain resolution
> >problem but does not include it in their examples of testandset and
> >compare_and_swap.  Also there examples only use isync and not sync but
> >point out that for SMP, you should use sync.  They also only use sync
> >before and after the routines and not in the middle.
> >
> >
> >So are the isync and syncs needed?

I don't understand why an isync should be needed.  I believe a sync is
only needed if you want a constraint on the order in which other CPUs
will see the atomic operation compared to other memory references (I'm
not dogmatic about that, I could be wrong, but that's my current
understanding.)

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
