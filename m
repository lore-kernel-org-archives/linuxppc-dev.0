Message-ID: <3A6CCBDC.3D7B722A@mvista.com>
Date: Mon, 22 Jan 2001 19:10:04 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: tom_gall@vnet.ibm.com
CC: Tom Gall <tgall@rochcivictheatre.org>, Troy Benjegerdes <hozer@drgw.net>,
        linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
References: <3A68F7A0.693639F1@mvista.com> <20010121222842.A27103@altus.drgw.net> <3A6BB971.7F128273@rochcivictheatre.org> <3A6C822F.7DB50A58@vnet.ibm.com> <3A6C9135.F542F0FA@mvista.com> <3A6CAF58.FB1643F1@vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


tom_gall@vnet.ibm.com wrote:

>   active_mm represents the current context of USER space,

Not exactly.  The mm object may only contain page tables for a
user thread, but it also contains information about the MMU context
in general for any thread running on the processor.

> ..........If a task doesn't have a current->mm it's
> a kernel task. It shouldn't be using the Segment Registers in the context.
> Right? A kernel task should only be concerned with addresses in the range of
> C0000000-FFFFFFFF which aren't in the context.

No, you are confusing MMU context with kernel memory mapping and
our (mostly incorrect) use of VSIDs on the 7xx processors.

>   If what you say is true that incorrect VSID/ASID etc could be handed out, I'm
> wondering how my box has been up running and stable since last week.

Because you are not running something like an MPC8xx or IBM4xx that
cares whether it is correct in kernel space.  Some processors do care.


>   Since current->mm is NULL, it's a kernel task... granted it doesn't have to be
> the idle task but it shouldn't matter. Or when you say any task, are you saying
> that user tasks as well?

The MMU context switching logic doesn't make any assumptions about
the meaning of current->mm.  If there is a current->mm, it switches
to that as the active_mm for the thread.  If there isn't a current->mm,
it locates something to use as the active_mm.  The rules for selecting
an active_mm can be whatever makes sense for reducing MMU management
or implementing features.


>   Correct me if I'm wrong but from the code we were looking at the sched.c when
> you pass through switch_mm from a kernel task to a user task, it catches it and
> you go from state of NO CONTEXT to the correct context.

Yes, but the problem is the context overflowed you did not select a
new one.  You allowed the thread to run on the processor (regardless of
what it was) with an expired context, that doesn't match the context
of active_mm.  Then later, you find yet another context to switch to
for the same thread that was using the wrong one.

>   Beat me over the head with a crowbar please if I'm missing something.

What's the big deal?  I'm going to say it for the third time.  The
active_mm is supposed to represent the mmu context for the thread
currently running on the processor.  When the context overflows, we
should get (pick a number) and set (in the MMU) the new context for
the active_mm running on each processor.  It is logically incorrect
to test current->mm and skip the get/set.  By doing so, you have a
stale MMU hardware context and an mm object that shouldn't be running
on a processor.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
