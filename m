In-Reply-To: <199904120448.OAA20256@tango.anu.edu.au>
Date: Wed, 14 Apr 1999 15:37:26 +0200
To: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org,
        kbhend@business.wm.edu
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: PPC Kernel Gurus Help?
Message-Id: <19990414153726.018323@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 12, 1999, Paul Mackerras <paulus@cs.anu.edu.au> wrote:

> >I hope Apple's implementation is just overkill.  The linuxthreads
>> >pt-machine.h file in both glibc 1.99 and glibc 2.1 do not have the extra
>> >isyncs (they just use sync both before and after the routine).  They also
>> >do not align things to cache boundaries.  To do that we would have to
>> >change the sem_t because both the spinlock and the semaphore value are
>> >side by side and both are accessed this way meaning that sem_t would have
>> >to be 32 byte aligned and take up 64 bytes to be safe (32 for the
>> >semaphore and 32 for the spinlock).
>
>Does it use lwarx/stwcx. to access both the spinlock and the
>semaphore?  If so that could possibly cause a problem if they are in
>the same cache line (strictly, "reservation granule").

Don't care about what I said, I was just plain wrong (still having
trouble with PPC assembly...). Apple's implementation doesn't watch for
32 byte alignement but for 4 byte alignement, which is a lot more
understandable.

If I understand things correctly, however, there is still a potential
problem in MP, if two atomics are in the same granule, and two processors
are trying to use them at the same time. I beleive we should make sure
the kernel's atomic type takes a whole granule (cache line).

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
