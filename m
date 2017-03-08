Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdXdj4Vr2zDqYx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 23:19:37 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id b5so3325080pgg.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Mar 2017 04:19:37 -0800 (PST)
Date: Wed, 8 Mar 2017 22:19:19 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego.lkml@gmail.com>
Cc: ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, Vaidyanathan
 Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/5] powerpc/64s: fix POWER9 machine check handler from
 stop state
Message-ID: <20170308221919.732986fd@roar.ozlabs.ibm.com>
In-Reply-To: <CAHZ_5WxicD=W6wqVdtEVRrewCgszO-S5mmdsiGWPm4wvUCOE-A@mail.gmail.com>
References: <20170216183901.28611-1-npiggin@gmail.com>
 <20170216183901.28611-6-npiggin@gmail.com>
 <CAHZ_5WxicD=W6wqVdtEVRrewCgszO-S5mmdsiGWPm4wvUCOE-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Gautham,

I'm just getting back to this. Sorry for the late reply, and
thanks for the reviews.

On Tue, 28 Feb 2017 22:45:46 +0530
Gautham R Shenoy <ego.lkml@gmail.com> wrote:

> Hi Nick,
> 
> On Fri, Feb 17, 2017 at 12:09 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > The ISA specifies power save wakeup can cause a machine check interrupt.
> > The machine check handler currently has code to handle that for POWER8,
> > but POWER9 crashes when trying to execute the P8 style sleep
> > instructions.
> >
> > So queue up the machine check, then call into the idle code to wake up
> > as the system reset interrupt does, rather than attempting to sleep
> > again without going through the main idle path.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/kernel/exceptions-64s.S | 71 ++++++++++++++++++------------------
> >  1 file changed, 36 insertions(+), 35 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> > index 5f775783f744..0388843c8d12 100644
> > --- a/arch/powerpc/kernel/exceptions-64s.S
> > +++ b/arch/powerpc/kernel/exceptions-64s.S
> > @@ -329,6 +329,35 @@ EXC_COMMON_BEGIN(machine_check_common)
> >         /* restore original r1. */                      \
> >         ld      r1,GPR1(r1)
> >
> > +#ifdef CONFIG_PPC_P7_NAP
> > +EXC_COMMON_BEGIN(machine_check_idle_common)
> > +       bl      machine_check_queue_event
> > +       /*
> > +        * Queue the machine check, then reload SRR1 and use it to set
> > +        * CR3 according to pnv_powersave_wakeup convention.
> > +        */
> > +       ld      r12,_MSR(r1)
> > +       rlwinm  r11,r12,47-31,30,31
> > +       cmpwi   cr3,r11,2
> > +
> > +       /*
> > +        * Now have to make SRR1 wake up reason look like a system reset
> > +        * interrupt. Put 0xf in there, which is reserved (and does not
> > +        * match HMI).  
> 
> The only places where the wakeup reason is presently checked on the way out
> of idle-exit are in KVM guest entry path in kvmppc_check_wake_reason()
>  and on the CPU-Hotplug exit path pnv_smp_cpu_kill_self(). In both places
> we do a positive check for EE, Doorbell, HVEE . The kvm case is also
> interested in
> HMI. We ignore all the other reasons at the moment.
> 
> So this should be fine.

Okay, thanks for confirming. We will have to be careful about this I
suppose if the wakeup reasons are expanded. I'll make a note of it
in asm/reg.h with the WAKEMASK definitions.

> > +        */
> > +       li      r11,0xf
> > +       insrdi  r12,r11,4,45  
> 
> 
> Shouldn't this be insrdi r12,r11,4,42? The exception bits are 42:45.
> I always have trouble wrapping my head around these nifty
> rotate-shift-mask-insert instructions. So I might as well be wrong!

Ah I think you're right, good catch. Maybe oris r12,r12,0x3c is a better
choice than that insrdi?


> 
> Otherwise, the patch looks correct to me.
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Very much appreciate the reviews. I'm just getting some time to work on
the winkle count patch, so I'll repost with your suggestions when that's
done.

Thanks,
Nick
