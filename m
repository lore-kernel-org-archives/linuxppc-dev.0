Message-ID: <38E3DA6C.FE9D528D@m2tech.co.nz>
Date: Fri, 31 Mar 2000 10:51:24 +1200
From: ben bodley <benb@m2tech.co.nz>
MIME-Version: 1.0
To: Mike Wolf <mwolf@sgi.com>, embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 4xx tlb questions
References: <38E3CE55.977E302@cray.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mike Wolf wrote:

> Hi,
>   I'm new to kernel development and have a question
> on the 4xx.  Part of the tlb address is 8 bits from the
> PID register.  I cannot find the code that sets the PID
> register for user code.  I find code that sets the PID reg
> to 0, and I find code that saves the current value of PID reg
> and then setting it to 0 to do some work and then sets
> it back.  I was expecting to see something in sched.c that
> set the PID to some value from the task_struct on a context
> switch.
>
> Its not at all obvious to me how the PID is getting set.  The
> only other option I'm aware of is to invalidate the TLB on
> a context change, but I didnt see that either and the tlb
> handlers imply something else because they save the current
> value of the PID register.  If it was always 0 it wouldnt
> need that
>

mike,

the pid is set with the 'set_context()' function inside arch/ppc/head_4xx.S,
(see also include/asm/mmu_context.h) and some adjustments are needed for 4xx
core (see montavista's latest patch)..

the context (as far as i see it) seems to be based on the running vma's in the
system.. (allocated for process memory req's), when a new process is spawned a
new context is created for memory accessed by that process..

cheers,

ben


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
