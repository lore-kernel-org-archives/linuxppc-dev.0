Return-Path: <michael@ellerman.id.au>
Message-ID: <1372333922.29229.25.camel@concordia>
Subject: Re: [PATCH 7/8] powerpc/perf: Core EBB support for 64-bit book3s
From: Michael Ellerman <michael@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 27 Jun 2013 21:52:02 +1000
In-Reply-To: <51CAA885.8060406@linux.vnet.ibm.com>
References: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
 <1372073336-8189-7-git-send-email-michael@ellerman.id.au>
 <51CAA885.8060406@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sukadev@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Wed, 2013-06-26 at 14:08 +0530, Anshuman Khandual wrote:
> On 06/24/2013 04:58 PM, Michael Ellerman wrote:
> > Add support for EBB (Event Based Branches) on 64-bit book3s. See the
> > included documentation for more details.
..
> > +
> > +
> > +Terminology
> > +-----------
> > +
> > +Throughout this document we will refer to an "EBB event" or "EBB events". This
> > +just refers to a struct perf_event which has set the "EBB" flag in its
> > +attr.config. All events which can be configured on the hardware PMU are
> > +possible "EBB events".
> > +
> 
> Then why we have a condition like this where the event code must have the PMC
> value inside it (in the next patch) ?

Those two things are not contradictory.

> +	if (!pmc && ebb)
> +		/* EBB events must specify the PMC */
> +		return -1;

This does not exclude any events. It just means if you're using one of
the any-PMC events you must choose a PMC for the event before opening
it.

The reason we do this is because userspace needs to know which PMC each
event is on, in order to read the PMCs and count them correctly. There
is a mechanism for the kernel to communicate to userspace which event is
on which PMC, but it is vastly simpler for userspace if it just
specifies the PMC in the event to begin with.

We could relax this restriction in future if someone comes up with a
really good reason to, but I don't see one.

I will add it to the documentation though.

> > +
> > +Background
> > +----------
> > +
> > +When a PMU EBB occurs it is delivered to the currently running process. As such
> > +EBBs can only sensibly be used by programs for self-monitoring.
> > +
> > +It is a feature of the perf_events API that events can be created on other
> > +processes, subject to standard permission checks. This is also true of EBB
> > +events, however unless the target process enables EBBs (via mtspr(BESCR)) no
> > +EBBs will ever be delivered.
> > +
> > +This makes it possible for a process to enable EBBs for itself, but not
> > +actually configure any events. At a later time another process can come along
> > +and attach an EBB event to the process, which will then cause EBBs to be
> > +delivered to the first process. It's not clear if this is actually useful.
> > +
> 
> May be useful when a "master process" wants each of the thread to collect statistics
> (about the same thread) on various dynamically configured events (as and when it
> wishes) and report it back to the master process. Just a thought about a case where
> it can be useful.

Yeah sort of.

I was thinking more of a long running process which sets up an EBB
handler and is therefore prepared to monitor itself, but you use an
external program to turn the event collection on and off.

> > +When the PMU is configured for EBBs, all PMU interrupts are delivered to the
> > +user process. This means once an EBB event is scheduled on the PMU, no non-EBB
> > +events can be configured. This means that EBB events can not be run
> > +concurrently with regular 'perf' commands.
> > +
> > +It is however safe to run 'perf' commands on a process which is using EBBs. In
> > +general the EBB event will take priority, though it depends on the exact
> > +options used on the perf_event_open() and the timing.
> > +
> 
> This is confusing. 

I don't think it is.

> If a process A is using EBB for itself on event "p" and gets scheduled
> on CPU X. Process B has started perf session on process A for event "q". Now the PMU of
> CPU X would to be programmed for both the events "p" and "q" on different PMCs at the same
> point of time (with a condition checking that they dont collide on the same PMC though).

No that's not correct.

> What you are saying is that when the event "p" overflows, the PMU interrupt (CPU X) would
> be delivered to the process A user space and when the event "q" overflows, the PMU interrupt
> (CPU X) would be delivered inside the perf kernel component "perf_event_interrupt()" and would
> be processed for the perf session initiated by the second process B on process A.

I'm not saying that, I don't know how you got that idea.

> But again this contradicts your previous statement that when PMU is configured for EBB, *all*
> PMU interrupts would be delivered to the user space. Could you please kindly clarify this
> scenario.

To paraphrase you above:

        Process A is using EBB with event "p" on CPU x, and process B
        starts running perf on process A with event "q".
        
        The PMU of CPU x will be programmed to count event "p" _and
        nothing else_. All PMU interrupts will be delivered to
        userspace.
        
        When the perf session reads its counter it will see that event
        "q" was unable to run for some of the time it was enabled.


There is one caveat to this which is that the EBB event gets priority
because it is pinned and exclusive. If there is another event that is
also pinned then there is a race between which event is opened on the
process first. This is what I talk about below in the "Enabling an EBB
event" section.

In general perf the tool doesn't pin events, so I don't see this as
being a problem.


> > +
> > +Creating an EBB event
> > +---------------------
> > +
> > +To request that an event is counted using EBB, the event code should have bit
> > +63 set.
> > +
> 
> This macro (defined in arch header) identifies any event as an EBB event
> 
> +/*
> + * We use the event config bit 63 as a flag to request EBB.
> + */
> +#define EVENT_CONFIG_EBB_SHIFT	63
> +
> 
> So any user program would have to include the arch header to be able to set EBB bit.
> Numeric 63 will not be a clean ABI.

I think you mean we should put that in an exported header and expose it
to userspace?

If so I'm not sure yet.

Doing so would mean we were guaranteeing that bit 63 would always mean
"EBB please" (on processors that support EBB). I /think/ that's probably
OK, but I want to confirm that with the HW folks first.

If we don't think we want to guarantee that then we would export the EBB
bit information using the existing format attrs in the perf code, and
userspace would have to look that up in sysfs.


> > +Enabling an EBB event
> > +---------------------
> > +
> > +Once an EBB event has been successfully opened, it must be enabled with the
> > +perf_events API. This can be achieved either via the ioctl() interface, or the
> > +prctl() interface.
> > +
> > +However, due to the design of the perf_events API, enabling an event does not
> > +guarantee that it has been scheduled on the PMU. To ensure that the EBB event
> > +has been scheduled on the PMU, you must perform a read() on the event. If the
> > +read() returns EOF, then the event has not been scheduled and EBBs are not
> > +enabled.
...
> > +EBB Handler
> > +-----------
> > +
> > +The EBB handler is just regular userspace code, however it must be written in
> > +the style of an interrupt handler. When the handler is entered all registers
> > +are live (possibly) and so must be saved somehow before the handler can invoke
> > +other code.
> > +
> > +It's up to the program how to handle this. For C programs a relatively simple
> > +option is to create an interrupt frame on the stack and save registers there.
> > +
> 
> Would be a great if you could give sample framework here on how to save and restore
> registers. Moreover we could actually put the various essential parts of the EBB
> handler construct in the perf_event_server.h file, so that the user would be able
> to user them directly and only focus on core part of the event handling.

I will eventually merge some test programs and example code.

But they definitely don't belong in the kernel headers.

And as an aside perf_event_server.h isn't exported to userspace.


> > diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> > index 48af5d7..f9a4cdc 100644
> > --- a/arch/powerpc/include/asm/processor.h
> > +++ b/arch/powerpc/include/asm/processor.h
> > @@ -287,8 +287,9 @@ struct thread_struct {
> >  	unsigned long	siar;
> >  	unsigned long	sdar;
> >  	unsigned long	sier;
> > -	unsigned long	mmcr0;
> >  	unsigned long	mmcr2;
> > +	unsigned 	mmcr0;
> > +	unsigned 	used_ebb;
> >  #endif
> >  };
> > 
> 
> Why mmrc0 has to change position here.

So the structure packs properly.


> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> > index 362142b..5d7d9c2 100644
> > --- a/arch/powerpc/include/asm/reg.h
> > +++ b/arch/powerpc/include/asm/reg.h
> > @@ -621,6 +621,9 @@
> >  #define   MMCR0_PMXE	0x04000000UL /* performance monitor exception enable */
> >  #define   MMCR0_FCECE	0x02000000UL /* freeze ctrs on enabled cond or event */
> >  #define   MMCR0_TBEE	0x00400000UL /* time base exception enable */
> > +#define   MMCR0_EBE	0x00100000UL /* Event based branch enable */
> > +#define   MMCR0_PMCC	0x000c0000UL /* PMC control */
> > +#define   MMCR0_PMCC_U6	0x00080000UL /* PMC1-6 are R/W by user (PR) */
> >  #define   MMCR0_PMC1CE	0x00008000UL /* PMC1 count enable*/
> >  #define   MMCR0_PMCjCE	0x00004000UL /* PMCj count enable*/
> >  #define   MMCR0_TRIGGER	0x00002000UL /* TRIGGER enable */
> > @@ -674,6 +677,11 @@
> >  #define   SIER_SIAR_VALID	0x0400000	/* SIAR contents valid */
> >  #define   SIER_SDAR_VALID	0x0200000	/* SDAR contents valid */
> > 
> > +/* When EBB is enabled, some of MMCR0/MMCR2/SIER are user accessible */
> > +#define MMCR0_USER_MASK	(MMCR0_FC | MMCR0_PMXE | MMCR0_PMAO)
> > +#define MMCR2_USER_MASK	0x4020100804020000UL /* (FC1P|FC2P|FC3P|FC4P|FC5P|FC6P) */
> > +#define SIER_USER_MASK	0x7fffffUL
> > +
> 
> Ohh these are the bits in SPR which are available in user space to read and write as well ?

Yes. See section 9.4.10 of PowerISA v2.07.

> Better to have macros instead of hex codes here.

We don't have macros for the other fields. If we add macros for FCxP then we can redo it then.


> >  #endif /* _ASM_POWERPC_SWITCH_TO_H */
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> > index 076d124..c517dbe 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -916,7 +916,11 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
> >  	flush_altivec_to_thread(src);
> >  	flush_vsx_to_thread(src);
> >  	flush_spe_to_thread(src);
> > +
> >  	*dst = *src;
> > +
> > +	clear_task_ebb(dst);
> > +
> >  	return 0;
> >  }
> 
> Blank lines are not necessary here.

Blank lines are never necessary.

But they highlight parts of the code that are important and make it more
readable. In this case I'm highlighting that we do the structure
assignment and then clear the EBB info of the destination task, vs the
other routines which operate on the src.


> > +static void ebb_switch_out(unsigned long mmcr0)
> > +{
> > +	if (!(mmcr0 & MMCR0_EBE))
> > +		return;
> > +
> > +	current->thread.siar  = mfspr(SPRN_SIAR);
> > +	current->thread.sier  = mfspr(SPRN_SIER);
> > +	current->thread.sdar  = mfspr(SPRN_SDAR);
> > +	current->thread.mmcr0 = mmcr0 & MMCR0_USER_MASK;
> > +	current->thread.mmcr2 = mfspr(SPRN_MMCR2) & MMCR2_USER_MASK;
> > +}
> > +
> 
> We also need to filter sier value for SIER_USER_MASK, right ? 

We don't need to, the hardware does it for us.

We are filtering the others because we do (in the case of MMCR0) or
might (MMCR2) use those inside the perf code, and we don't want to
confuse values we've set with values the user has set.

cheers
