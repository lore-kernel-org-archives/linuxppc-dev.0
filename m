Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B85362C007A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2012 18:23:49 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 22 Oct 2012 12:53:44 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9M7NSAu36372586
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2012 12:53:28 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9MCrKk0032669
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2012 12:53:20 GMT
Message-ID: <1350890599.2904.40.camel@ThinkPad-T420>
Subject: Re: [RFC PATCH powerpc] Fix a lazy irq related WARING in
 arch_local_irq_restore()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 22 Oct 2012 15:23:19 +0800
In-Reply-To: <1350518056.4678.113.camel@pasglop>
References: <1348458962.2475.8.camel@ThinkPad-T420>
 <1348464657.1132.86.camel@pasglop> <1348654234.2635.31.camel@ThinkPad-T420>
 <1350518056.4678.113.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-10-18 at 10:54 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2012-09-26 at 18:10 +0800, Li Zhong wrote:
> 
>  ../...
> 
> Sorry got distracted, got back on this patch today:
> 
> > > We might need to "sanitize" the enable state in the PACA before we
> > > actually enter NAP or in the return from NAP code, like we do for normal
> > > idle code...
> > 
> > Hi Ben, 
> > 
> > After some further reading of the code, I updated the code as following,
> > but I'm not very sure, and guess it most probably has some issues ...
> > Could you please help to review and give your comments? 
> 
> I think it's still not right, see below
> 
> > In extended_cede_processor(), if there is still lazy irq pending, I used
> > local_irq_enable() to make sure the irq replayed and flags cleared, but
> > I'm not sure whether it is a proper way. 
> 
> Right but that will break things for idle. In idle, if you have
> re-enabled interrupts, you need to return and essentially abort the
> attempt at going to nap mode, because the interrupt might have set need
> resched. That's why we normally just check if something's pending and
> return, letting the upper levels re-enable interrupts and do all the
> dirty work for us.
> 
> Now, hotplug might differ here in what it needs, but in any case,
> extended_cede_processor doesn't seem to be the right place to handle it,
> at best that function should return if it thinks there's something that
> needs to be done and let the upper layers deal with it appropriately.
> 
> > In pseries_mach_cpu_die(), I added local_irq_disable() after cede, and
> > prepare for the start_secondary_resume(), but I'm not sure whether we
> > also need a hard_irq_disable() here. 
> 
> You probably do if it's going to go back to the start secondary path. It
> shouldn't hurt in any case as long as start_secondary_resume()
> eventually does a local_irq_enable().
> 
> > I'm still a little confused by the meaning of PACA_IRQ_HARD_DIS in
> > irq_happened. From the checking at the warning point, it seems only
> > irq_happened equaling 0x1(PACA_IRQ_HARD_DIS) means hard irqs are
> > disabled.

Hi Ben, 

Below are my current understandings and a few more questions, please
correct me if there are any misunderstandings. Thank you. 

> No. They are disabled if any bit in there corresponding to a "level"
> interrupt is set as well. Only the "edge" interrupts (and decrementer
> which we treat as edge and reset to a high value when it kicks) are
> ignored for the sake of HW irq state.

>From the code, it seems that the hardware_interrupt/external_input
(corresponding to PACA_IRQ_EE) are "level" interrupts. For "level"
interrupts, is it because we will see it again, so we need to hard
disable? or else we might enter into an infinite loop? 

> The reason we have this IRQ_HARD_DIS bit is to indicate that a 'manual'
> hard disabling occurred (by opposition to one happening as a result of
> an external interrupt).

The external interrupt causing the hard disabling, is done in the code
of masked_##_H##interrupt: for book3s, or masked_interrupt_book3e
PACA_IRQ_EE 1 for book3e ?
 
> We need that so we can avoid doing an mfspr() in local_irq_enable() and
> entirely rely on the content of irq_happened to know whether interrupts
> are hard enabled or hard disabled.

Is this about the code in arch_local_irq_restore()? so if (!
irq_happended), we could return directly as we know it is hard enabled. 

And here
        if (unlikely(irq_happened != PACA_IRQ_HARD_DIS))
                __hard_irq_disable();

We don't need to hard disable if (irq_happened == PACA_IRQ_HARD_DIS), as
we know it is hard disabled ('manual'). 

Then here, can we save a few more mtmsrd by also checking PACA_IRQ_EE
bit? like following: 

-	if (unlikely(irq_happened != PACA_IRQ_HARD_DIS))
+	if (unlikely(!(irq_happened & (PACA_IRQ_HARD_DIS | PACA_IRQ_EE))))
 
> We do that because mfspr is a fairly expensive instruction. But that
> means that we need to make sure we always have a consistent content in
> irq_happened. That's also why I've added all those sanity checks if you
> enable IRQ tracing.

See. 
 
> > Is it possible to set this bit at anyplace the hard irqs are disabled,
> > so then we could check whether this bit is set to know whether hard irqs
> > are disabled? Then it seems that in MASKED_INTERRUPT, we need set this
> > bit where MSR_EE is cleared for something other than decrementer. Maybe
> > I missed too much things?
> 
> Either that bit or PACA_IRQ_EE. Both indicate that interrupts are hard
> disabled.
> 
> There are some rare cases where do do change MSR:EE without touching
> those bits, only when we're going to restore it shortly afterward in the
> kernel asm exception entry/exit path for example.

I don't get it very clearly here. I might need some more time to read
and understand all the related asm codes. 

Currently, it seems to me in EXCEPTION_COMMON,  SOFT_DISABLE_INTS is
called to set PACA_IRQ_HARD_DIS, and other bits might be set when
__SOFTEN_TEST (or masked_interrupt_book3e) is called. And in the
exception exit path,  something like
SOFT_DISABLE_INTS, .restore_interrupts, restore_check_irq_replay, etc
are called to handle the irq_happened bits. 

Thanks, Zhong
 
> Cheers,
> Ben.
> 
> > Thanks, Zhong 
> > 
> > ===================
> > diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > index 64c97d8..b5f7597 100644
> > --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > @@ -130,6 +130,8 @@ static void pseries_mach_cpu_die(void)
> >  			extended_cede_processor(cede_latency_hint);
> >  		}
> >  
> > +		local_irq_disable();
> > +
> >  		if (!get_lppaca()->shared_proc)
> >  			get_lppaca()->donate_dedicated_cpu = 0;
> >  		get_lppaca()->idle = 0;
> > diff --git a/arch/powerpc/platforms/pseries/plpar_wrappers.h b/arch/powerpc/platforms/pseries/plpar_wrappers.h
> > index 13e8cc4..07560d8 100644
> > --- a/arch/powerpc/platforms/pseries/plpar_wrappers.h
> > +++ b/arch/powerpc/platforms/pseries/plpar_wrappers.h
> > @@ -2,6 +2,7 @@
> >  #define _PSERIES_PLPAR_WRAPPERS_H
> >  
> >  #include <linux/string.h>
> > +#include <linux/irqflags.h>
> >  
> >  #include <asm/hvcall.h>
> >  #include <asm/paca.h>
> > @@ -41,7 +42,19 @@ static inline long extended_cede_processor(unsigned long latency_hint)
> >  	u8 old_latency_hint = get_cede_latency_hint();
> >  
> >  	set_cede_latency_hint(latency_hint);
> > +
> > +	while (!prep_irq_for_idle()) {
> > +		local_irq_enable();
> > +		local_irq_disable();
> > +	}
> > +
> >  	rc = cede_processor();
> > +#ifdef CONFIG_TRACE_IRQFLAGS
> > +		/* Ensure that H_CEDE returns with IRQs on */
> > +		if (WARN_ON(!(mfmsr() & MSR_EE)))
> > +			__hard_irq_enable();
> > +#endif
> > +
> >  	set_cede_latency_hint(old_latency_hint);
> >  
> >  	return rc;
> > ===================
> > 
> > 
> > > 
> > > Cheers,
> > > Ben.
> > > 
> > > > [   56.618846] WARNING: at arch/powerpc/kernel/irq.c:240
> > > > [   56.618851] Modules linked in: rcutorture ipv6 dm_mod ext3 jbd mbcache sg sd_mod crc_t10dif ibmvscsic scsi_transport_srp scsi_tgt ibmveth
> > > > [   56.618883] NIP: c00000000000ff94 LR: c00000000067a5e0 CTR: 0000000000000001
> > > > [   56.618889] REGS: c0000001fef6bbe0 TRAP: 0700   Not tainted  (3.6.0-rc1-autokern1)
> > > > [   56.618894] MSR: 8000000000029032 <SF,EE,ME,IR,DR,RI>  CR: 42000082  XER: 20000000
> > > > [   56.618913] SOFTE: 1
> > > > [   56.618916] CFAR: c00000000067a5dc
> > > > [   56.618920] TASK = c0000001feed79a0[0] 'swapper/5' THREAD: c0000001fef68000 CPU: 5
> > > > GPR00: 0000000000000001 c0000001fef6be60 c000000000f9ca08 0000000000000001 
> > > > GPR04: 0000000000000001 0000000000000008 0000000000000001 0000000000000000 
> > > > GPR08: 0000000000000000 c0000001feed79a0 0008a80000000000 0000000000000000 
> > > > GPR12: 0000000022000082 c00000000f330f00 c0000001fef6bf90 000000000f394b4c 
> > > > GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> > > > GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> > > > GPR24: c000000000fe8f80 0000000000000008 0000000000000028 0000000000000000 
> > > > GPR28: 0000000000000000 0000000000000020 c000000000f1ab40 0000000000000001 
> > > > [   56.619014] NIP [c00000000000ff94] .arch_local_irq_restore+0x34/0xa0
> > > > [   56.619020] LR [c00000000067a5e0] .start_secondary+0x368/0x37c
> > > > [   56.619025] Call Trace:
> > > > [   56.619030] [c0000001fef6be60] [c000000001ba0500] 0xc000000001ba0500 (unreliable)
> > > > [   56.619038] [c0000001fef6bed0] [c00000000067a5e0] .start_secondary+0x368/0x37c
> > > > [   56.619046] [c0000001fef6bf90] [c000000000009380] .start_secondary_resume+0x10/0x14
> > > > [   56.619052] Instruction dump:
> > > > [   56.619056] f8010010 f821ff91 986d022a 2fa30000 419e0054 880d022b 78000621 41820048 
> > > > [   56.619071] 2f800001 40de0064 7c0000a6 78008fe2 <0b000000> 2fa00000 40de0050 38000000 
> > > > [   56.619088] ---[ end trace 0199c0d783d7f9ba ]---
> > > > 
> > > > Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> > > > ---
> > > >  arch/powerpc/platforms/pseries/hotplug-cpu.c |    2 ++
> > > >  1 files changed, 2 insertions(+), 0 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > > > index 64c97d8..8de539a 100644
> > > > --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > > > +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > > > @@ -137,6 +137,8 @@ static void pseries_mach_cpu_die(void)
> > > >  		if (get_preferred_offline_state(cpu) == CPU_STATE_ONLINE) {
> > > >  			unregister_slb_shadow(hwcpu);
> > > >  
> > > > +			__hard_irq_disable();
> > > > +
> > > >  			/*
> > > >  			 * Call to start_secondary_resume() will not return.
> > > >  			 * Kernel stack will be reset and start_secondary()
> > > 
> > > 
> > 
> 
> 
