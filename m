Date: Mon, 12 Apr 1999 15:49:20 -0500
Message-Id: <199904122049.PAA27518@kuttanna.ibmoto.com>
From: Edward Swarthout <swarthou@ibmoto.com>
To: linuxppc-dev@lists.linuxppc.org
In-reply-to: message from Paul Mackerras on Mon, 12 Apr 1999 14:48:17 +1000
Subject: Re: PPC Kernel Gurus Help?
References: 
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



>  Date: Mon, 12 Apr 1999 14:48:17 +1000
>  From: Paul Mackerras <paulus@cs.anu.edu.au>
>
>  > >...                Also there examples only use isync and not sync but
>  > >point out that for SMP, you should use sync.  They also only use sync
>  > >before and after the routines and not in the middle.
>  > >
>  > >So are the isync and syncs needed?
>
>  I don't understand why an isync should be needed.  I believe a sync is
>  only needed if you want a constraint on the order in which other CPUs
>  will see the atomic operation compared to other memory references (I'm
>  not dogmatic about that, I could be wrong, but that's my current
>  understanding.)
>
>  Paul.

I believe this discussion comes from the example in appendix E.4 "Lock
Acquisition and Release".  I think the example could use a better
wording to motivate the need for the isync.  It simply makes the
statement: "The processor must not access the shared resource until it
sets the lock".  A better wording: "IF the lock must prevent the
processor from accessing the shared resource until the successful lock
is acquired, a barrier needs to be created between the stwcx and the
access".

The lock code looks like:

  lock: call test_and_set until lock acquired (lwarx/stwcx loop)
        isync
        access_shared_location

Without the isync, nothing prevents the access_shared_location to
happen before the lwarx/stwcx loop returns.  To prevent the access, a
dependency between the stwcx and the access must be created.  Three
ways (with the isync option being the best):

1. isync - instruction-stream is blocked until successful stwcx
2. sync  - memory access is blocked until successful stwcx
3. operand dependency - delay loading register containing shared address
           until lock is acquired.

Only one option needs to be picked.

-Ed Swarthout
Somerset Design Center
Motorola 

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
