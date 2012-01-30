Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
 [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 29737B6F65
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2012 08:47:21 +1100 (EST)
Message-ID: <4F270FDC.8030906@freescale.com>
Date: Mon, 30 Jan 2012 15:47:08 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/booke64: Configurable lazy interrupt disabling
References: <1326897306-3924-1-git-send-email-Laurentiu.Tudor@freescale.com>
 <1326921026.26116.34.camel@pasglop>
 <CALRxmdC_E4Z==4R_2MGHAi3T7mdF9oHx3rBE6Meb+3R1gWF5VQ@mail.gmail.com>
 <CALRxmdA9mh6x5YGK1oFHvgmV-RsnN6WkxhpZbcRJv1S8Y0RH1w@mail.gmail.com>
 <1327100755.2923.6.camel@pasglop> <4F1DB344.9030709@freescale.com>
 <1327351831.19850.9.camel@pasglop>
In-Reply-To: <1327351831.19850.9.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
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

On 01/23/2012 02:50 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2012-01-23 at 13:21 -0600, Scott Wood wrote:
>> Perhaps the issues with a higher priority interrupt intervening can be
>> addressed by messing around with current task priority at the MPIC (with
>> an hcall introduced for the hv case, since currently task priority is
>> not exposed to the guest).  I haven't had time to revisit this, and
>> don't expect to soon.  If someone else wants to try, fine.  In the
>> meantime, lazy EE is causing problems.
> 
> Or by storing pending interrupts in an array.

Only the first one will happen in a context where we want to store.  The
issue is if we get another higher priority interrupt when we enable, and
that enables interrupts and we get the doorbell that wants to run the
saved irq.  If we get priorities out of order we'll EOI the wrong interrupt.

IIRC we now never enable interrupts while servicing one (are individual
handlers banned from doing this too?), in which case it shouldn't be an
issue.  I'm a bit hesitant to rely on that, but oh well.  Beats having
to add CTPR support to the hypervisor just for this.  We could throw a
WARN_ONCE if we see a stored interrupt when we take an external
interrupt exception.

>> and book3s decrementers 
> 
> Book3s decrementer is level sensitive based on the sign bit of the
> decrementer (a bit odd but heh....) at least on 64-bit processors.

So what's up with "On server, re-trigger the decrementer if it went
negative since some processors only trigger on edge transitions of the
sign bit" in arch_local_irq_restore()?

>> and other hypervisors... 
> 
> I wouldn't take the PS3 HV and legacy iseries HV as good design
> examples :-) The later was working around limited HW functionality at
> the time as well. 

Just pointing out we're not the first. :-)

>> and you force
>> all functions that enable interrupts to create a stack frame to deal
>> with this.
> 
> Right, but overall this is still more efficient performance wise on most
> processors than whacking the MSR.

Laurentiu ran lmbench on e5500 with/without lazy EE and the results were
mixed.  No large differences either way, but probably at least as many
tests were slower with lazy EE as were faster with lazy EE.  Or possibly
there was no significant difference and it was just noise from one run
to another (I'm not sure how many times he ran it or what the variation
was).

He did claim a noticeable increase in networking performance with
external proxy enabled.

I guess hard-EE is worse on some other chips?

> However the main thing is that this significantly improves the quality
> of the samples obtained from performance interrupts which can now act as
> pseudo-NMI up to a certain point.

Which is compensation for the hardware not doing it right with a proper
critical interrupt or equivalent, but yeah, that's a benefit.

>> What is the compelling reason for forcing lazy EE on us?  Why is it tied
>> to 64-bit?
> 
> Because that's where we historically implemented it and because iSeries
> more/less required to begin with. And I don't want to have a split
> scheme, especially not a compile time one.

We can probably live with it in this case -- the patch to disable lazy
EE was largely an artifact of my not having time to try a new approach,
and other people here wanting some fix sooner.

In general, though, I hope that the history of previously having 64-bit
to yourself doesn't mean that our 64-bit chips are treated second class
citizens, having to live with design decisions oriented around the chips
that got there first, with a mandate that there be no special kernel
builds, even just for optimization[1].  No, I don't want to go back to
one kernel per board, but some build-time configuration is reasonable on
embedded IMHO, as long as the possibilities are limited.  We're already
running a different build from book3s.

If the issue is just that you think making this particular feature
configurable would be a mess, fine (though I think it would have been
managable).

-Scott

[1] The hypervisor's issues with guest IACK should be fixable with an
hv-internal CTPR hack if anyone cares enough, but there would be a
performance cost to not using external proxy.
