Message-Id: <v03010d02b3369714fb07@[209.96.179.41]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 11 Apr 1999 14:15:26 -0400
To: linuxppc-dev@lists.linuxppc.org, gdt@linuxppc.org
From: "Kevin B. Hendricks" <kbhend@business.wm.edu>
Subject: Re: PPC Kernel Gurus Help?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Date: Sun, 11 Apr 1999 14:13:40 -0400
>To: Benjamin Herrenschmidt <bh40@calva.net>
>From: "Kevin B. Hendricks" <kbhend@business.wm.edu>
>Subject: Re: PPC Kernel Gurus Help?
>Cc:
>Bcc:
>X-Attachments:
>
>Hi,
>
>I hope Apple's implementation is just overkill.  The linuxthreads
>pt-machine.h file in both glibc 1.99 and glibc 2.1 do not have the extra
>isyncs (they just use sync both before and after the routine).  They also
>do not align things to cache boundaries.  To do that we would have to
>change the sem_t because both the spinlock and the semaphore value are
>side by side and both are accessed this way meaning that sem_t would have
>to be 32 byte aligned and take up 64 bytes to be safe (32 for the
>semaphore and 32 for the spinlock).
>
>By the way,  I looked in that arch/ppc kernel for 2.2.1 and their
>implementation of testandset and compare_and_swap does not use either sync
>or isync or any cache alignment!!!!! (see bitops, misc.S and head.S for
>examples)
>
>The PowerPC manual in Appendix G mentions the cache grain resolution
>problem but does not include it in their examples of testandset and
>compare_and_swap.  Also there examples only use isync and not sync but
>point out that for SMP, you should use sync.  They also only use sync
>before and after the routines and not in the middle.
>
>
>So are the isync and syncs needed?
>
>Should the semaphores be aligned to 32 byte address boundaries to take up
>a whole cache line?
>
>>It looks like apple implementation makes sure to always align the value
>>that is c&swapped to a cache line boundary (32 bytes). Also, they do a
>>sync and an isync. Apple's implementation looks like this: (This one
>>comes from some code I use on old PPC macs that don't have a system
>>function for compare&swap).
>>
>>static asm Boolean	s_low_compare_and_swap(	UInt32
>>	inOld,
>>
>>			UInt32				inNew,
>>
>>			volatile UInt32		*outOld)
>>	{
>>	begin:	lwarx	r6,r0,r5
>>			cmpw	r6,r3
>>			bne		failed
>>			sync
>>			stwcx.	r4,r0,r5
>>			bne-	begin
>>			sync
>>			isync
>>			li		r3,1
>>			blr
>>	failed:	sync
>>			stwcx.	r6,r0,r5
>>			li		r3,0
>>			blr
>>	}
>>
>>Regarding the kernel, I beleive signals and context switches (and
>>eventually any interrupt handler) should clear reservations too, but I'm
>>not sure if failure to do so can be the cause of your problems.
>
>Kevin
>
>
>



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
