Message-Id: <199905071754.KAA09699@soda.CSUA.Berkeley.EDU>
To: Brad Boyer <flar@cegt201.bradley.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Question about SMP 
In-Reply-To: Your message of "Thu, 06 May 1999 23:42:45 CDT."
             <199905070442.XAA11076@cegt201.bradley.edu>
Date: Fri, 07 May 1999 10:54:03 -0700
From: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> I started looking at kernel/sched.c which is where most of this stuff
> is, and I didn't see anything obvious, but I did notice a few things
> that seemed odd.  Do spinlocks only exist in an SMP kernel?  I ask
> because there is a spinlock where the matching unlock is in an #ifdef
> __SMP__ which seemed like a bad idea.  If anyone can help me get this
> running, I'd appreciate it.  I'm more than willing to fiddle around
> with the code if someone can give me some hints on this stuff.
 
My knowledge of SMP is limited, but in general spin locks are required
only on MP machines.  If you use a spin lock (condition variable?) on
a single processor machine, basically your thread ends up spinning
until its time slice runs out, which is not particularly efficient.

I think that on single processors locks are implemented using sem_wait
and sem_post, where these enable and disable interrupts. This is not
possible on MP machines, so spin locks are used instead. (Someone
please correct me if I'm wrong).

>From you post, I take it that my SMP kernel didn't work for you. What
was the exact problem you had?

----ranga <ranga@soda.berkeley.edu>

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
