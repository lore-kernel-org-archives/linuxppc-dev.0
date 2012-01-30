Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3F0C0B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2012 09:17:00 +1100 (EST)
Message-ID: <1327961726.28487.60.camel@pasglop>
Subject: Re: [PATCH] powerpc/booke64: Configurable lazy interrupt disabling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 31 Jan 2012 09:15:26 +1100
In-Reply-To: <4F270FDC.8030906@freescale.com>
References: <1326897306-3924-1-git-send-email-Laurentiu.Tudor@freescale.com>
 <1326921026.26116.34.camel@pasglop>
 <CALRxmdC_E4Z==4R_2MGHAi3T7mdF9oHx3rBE6Meb+3R1gWF5VQ@mail.gmail.com>
 <CALRxmdA9mh6x5YGK1oFHvgmV-RsnN6WkxhpZbcRJv1S8Y0RH1w@mail.gmail.com>
 <1327100755.2923.6.camel@pasglop> <4F1DB344.9030709@freescale.com>
 <1327351831.19850.9.camel@pasglop> <4F270FDC.8030906@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Stuart Yoder <b08248@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-01-30 at 15:47 -0600, Scott Wood wrote:

> Only the first one will happen in a context where we want to store.  The
> issue is if we get another higher priority interrupt when we enable, and
> that enables interrupts and we get the doorbell that wants to run the
> saved irq.  If we get priorities out of order we'll EOI the wrong interrupt.

Hrm, ok, what about in handle_masked we just "save" it onto some kind of
PACA local stack ? Then on enable, before actually turning EE back, we
see if there's something there and we hit do_IRQ() if there is. Your
get_irq() would preferrably pop things out of that little stack.

Any hole in that scheme ?

I'm thinking about reworking the lazy EE code, so maybe leave me a
couple of days. You did find a real bug on PS3 I believe and potentially
with Anton's dec replay stuff as well, when the enable is implicit in
the exception return path.

I'm thinking about breaking down that into a lower level function
returning whether we need a DEC replay, IRQ replay or nothing, and call
it in two contexts:

 - From arch...restore(), if we need to replay, we then tail-call an asm
helper which will generate an irq stack frame and call do_IRQ() or
timer_interrupt().

 - From exception restore, if we need to replay, we re-use the existing
stack frame, change the TRAP value and move on to
do_IRQ/timer_interrupt.

I may not have time to do that this week (hint hint, if you have
time ... :-) but that's what's on my mind atm.

> IIRC we now never enable interrupts while servicing one (are individual
> handlers banned from doing this too?), 

No I think they still can.

> in which case it shouldn't be an issue. 

> I'm a bit hesitant to rely on that, but oh well.  Beats having
> to add CTPR support to the hypervisor just for this.  We could throw a
> WARN_ONCE if we see a stored interrupt when we take an external
> interrupt exception.
>
> >> and book3s decrementers 
> > 
> > Book3s decrementer is level sensitive based on the sign bit of the
> > decrementer (a bit odd but heh....) at least on 64-bit processors.
> 
> So what's up with "On server, re-trigger the decrementer if it went
> negative since some processors only trigger on edge transitions of the
> sign bit" in arch_local_irq_restore()?

Ask Anton or Paulus, at least on P7 it's level :-) I think maybe old
Power3 had it different.

> >> and other hypervisors... 
> > 
> > I wouldn't take the PS3 HV and legacy iseries HV as good design
> > examples :-) The later was working around limited HW functionality at
> > the time as well. 
> 
> Just pointing out we're not the first. :-)

Yeah yeah ok :-) I hope you do see my point however of not wanting to
get into an ifdef mess all over again... If we can get that stuff
reasonably efficiently NOP'ed out, that would do, tho I suppose one of
your concerns is the generation of a stack frame for re-enabling.

One possibility would be to inline the part that tests if the hw irq
happened, and use asm to branch out of line to something that will then
make up a stack frame separately. It's a bit gross but would remove the
cost of creating stack frames in callers.

> >> and you force
> >> all functions that enable interrupts to create a stack frame to deal
> >> with this.
> > 
> > Right, but overall this is still more efficient performance wise on most
> > processors than whacking the MSR.
> 
> Laurentiu ran lmbench on e5500 with/without lazy EE and the results were
> mixed.  No large differences either way, but probably at least as many
> tests were slower with lazy EE as were faster with lazy EE.  Or possibly
> there was no significant difference and it was just noise from one run
> to another (I'm not sure how many times he ran it or what the variation
> was).
> 
> He did claim a noticeable increase in networking performance with
> external proxy enabled.

Hrm, any decent networking HW should mitigate interrupts and mostly rely
on polling... you must have been doing something wrong :-)

> I guess hard-EE is worse on some other chips?

Hard EE is bad on server chips afaik, tho mtmsrd x,1 does mitigate the
damage.

> > However the main thing is that this significantly improves the quality
> > of the samples obtained from performance interrupts which can now act as
> > pseudo-NMI up to a certain point.
> 
> Which is compensation for the hardware not doing it right with a proper
> critical interrupt or equivalent, but yeah, that's a benefit.

Right, server has no concept really of critical interrupts.

> >> What is the compelling reason for forcing lazy EE on us?  Why is it tied
> >> to 64-bit?
> > 
> > Because that's where we historically implemented it and because iSeries
> > more/less required to begin with. And I don't want to have a split
> > scheme, especially not a compile time one.
> 
> We can probably live with it in this case -- the patch to disable lazy
> EE was largely an artifact of my not having time to try a new approach,
> and other people here wanting some fix sooner.
> 
> In general, though, I hope that the history of previously having 64-bit
> to yourself doesn't mean that our 64-bit chips are treated second class
> citizens, having to live with design decisions oriented around the chips
> that got there first, with a mandate that there be no special kernel
> builds, even just for optimization[1]. 

You can always do your own one-processor one-arch build of course, I
want to keep the -possiblity- of a common build as much as possible (tho
I do know that we can't do a common build with 64E and 64S today, I'm
still trying to keep that door open). Oh and we do have 64E chips too
btw :-)

So don't worry too much there, and if you really can't fix the problem
with Lazy EE in a satifactory way we can re-visit. But I dislike too
much conditional in those code path, it just makes things harder to
maintain.

>  No, I don't want to go back to
> one kernel per board, but some build-time configuration is reasonable on
> embedded IMHO, as long as the possibilities are limited.  We're already
> running a different build from book3s.
> 
> If the issue is just that you think making this particular feature
> configurable would be a mess, fine (though I think it would have been
> managable).
> 
> -Scott
> 
> [1] The hypervisor's issues with guest IACK should be fixable with an
> hv-internal CTPR hack if anyone cares enough, but there would be a
> performance cost to not using external proxy.

Cheers,
Ben.
