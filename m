Date: Tue, 23 Jan 2001 11:00:28 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dan@mvista.com>
cc: tom_gall@vnet.ibm.com, Tom Gall <tgall@rochcivictheatre.org>,
        Troy Benjegerdes <hozer@drgw.net>, linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
In-Reply-To: <3A6CCBDC.3D7B722A@mvista.com>
Message-ID: <Pine.HPX.4.10.10101231050450.3872-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 22 Jan 2001, Dan Malek wrote:

>
> tom_gall@vnet.ibm.com wrote:
>
> >   active_mm represents the current context of USER space,
>
> Not exactly.  The mm object may only contain page tables for a
> user thread, but it also contains information about the MMU context
> in general for any thread running on the processor.
>
> > ..........If a task doesn't have a current->mm it's
> > a kernel task. It shouldn't be using the Segment Registers in the context.
> > Right? A kernel task should only be concerned with addresses in the range of
> > C0000000-FFFFFFFF which aren't in the context.
>
> No, you are confusing MMU context with kernel memory mapping and
> our (mostly incorrect) use of VSIDs on the 7xx processors.

Finally, somebody had to say it. But saying mostly incorrect is the
understatement of the week.

> >   If what you say is true that incorrect VSID/ASID etc could be handed out, I'm
> > wondering how my box has been up running and stable since last week.
>
> Because you are not running something like an MPC8xx or IBM4xx that
> cares whether it is correct in kernel space.  Some processors do care.

Yes they do care, but let us noi add unnecessary baggage to processors who
do not need it. All these games with current_mm and active_mm were
introduced for x86 because of their stupid MMU. 8xx/4xx are unfortunately
almost as braindead while 6xx/7xx do get it right.

The MMU code is so different for 4xx/8xx and 6xx/7xx that adding a few
conditionals for this mm management won't hurt. No kernel will ever run
without a recompile on both kind of MMUs anyawy.

> >   Since current->mm is NULL, it's a kernel task... granted it doesn't have to be
> > the idle task but it shouldn't matter. Or when you say any task, are you saying
> > that user tasks as well?
>
> The MMU context switching logic doesn't make any assumptions about
> the meaning of current->mm.  If there is a current->mm, it switches
> to that as the active_mm for the thread.  If there isn't a current->mm,
> it locates something to use as the active_mm.  The rules for selecting
> an active_mm can be whatever makes sense for reducing MMU management
> or implementing features.

For 6xx/7xx active_mm has not even any reason to exist in the first place,
there are no TLB flush issues when switching tasks when TLB directly
map through an intermediate 52 bit address space. Changing segment
registers if necessary is _cheap_, the operation is local to a processor
and only needs a couple of isync.

> Yes, but the problem is the context overflowed you did not select a
> new one.  You allowed the thread to run on the processor (regardless of
> what it was) with an expired context, that doesn't match the context
> of active_mm.  Then later, you find yet another context to switch to
> for the same thread that was using the wrong one.

A proper implementation on 6xx/7xx would not even know what an expired
context is. It would not even be possible to happen in the first place.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
