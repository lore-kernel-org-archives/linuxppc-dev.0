Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC5352zmMzDrW0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 15:20:49 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id e199so5165519pfh.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 22:20:49 -0700 (PDT)
Date: Wed, 19 Jul 2017 15:20:32 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powernv/powerpc: Clear PECE1 in LPCR via stop-api
 only on Hotplug
Message-ID: <20170719152032.7724085f@roar.ozlabs.ibm.com>
In-Reply-To: <20170719050459.GA30836@in.ibm.com>
References: <cover.1500361607.git.ego@linux.vnet.ibm.com>
 <a3ba2f2ddfbe0145ca28963b487c14473a396269.1500361607.git.ego@linux.vnet.ibm.com>
 <20170719121412.1d89857c@roar.ozlabs.ibm.com>
 <20170719050459.GA30836@in.ibm.com>
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

On Wed, 19 Jul 2017 10:34:59 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hello Nicholas,
> 
> On Wed, Jul 19, 2017 at 12:14:12PM +1000, Nicholas Piggin wrote:
> > Thanks for working on these patches. We really need to get this stuff
> > merged and tested asap :)
> >  
> 
> > On Tue, 18 Jul 2017 19:58:49 +0530  
> 
> [..snip..]
> 
> > > diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> > > index 40dae96..5f2a712 100644
> > > --- a/arch/powerpc/platforms/powernv/smp.c
> > > +++ b/arch/powerpc/platforms/powernv/smp.c
> > > @@ -143,7 +143,8 @@ static void pnv_smp_cpu_kill_self(void)
> > >  {
> > >  	unsigned int cpu;
> > >  	unsigned long srr1, wmask;
> > > -
> > > +	uint64_t lpcr_val;
> > > +	uint64_t pir;
> > >  	/* Standard hot unplug procedure */
> > >  	/*
> > >  	 * This hard disables local interurpts, ensuring we have no lazy
> > > @@ -164,13 +165,17 @@ static void pnv_smp_cpu_kill_self(void)
> > >  	if (cpu_has_feature(CPU_FTR_ARCH_207S))
> > >  		wmask = SRR1_WAKEMASK_P8;
> > >  
> > > +	pir = get_hard_smp_processor_id(cpu);
> > >  	/* We don't want to take decrementer interrupts while we are offline,
> > >  	 * so clear LPCR:PECE1. We keep PECE2 (and LPCR_PECE_HVEE on P9)
> > >  	 * enabled as to let IPIs in.
> > >  	 */
> > > -	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1);
> > > +	lpcr_val = mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1;
> > > +	mtspr(SPRN_LPCR, lpcr_val);
> > >  
> > >  	while (!generic_check_cpu_restart(cpu)) {
> > > +
> > > +
> > >  		/*
> > >  		 * Clear IPI flag, since we don't handle IPIs while
> > >  		 * offline, except for those when changing micro-threading
> > > @@ -180,8 +185,15 @@ static void pnv_smp_cpu_kill_self(void)
> > >  		 */
> > >  		kvmppc_set_host_ipi(cpu, 0);
> > >  
> > > +		/*
> > > +		 * If the CPU gets woken up by a special wakeup,
> > > +		 * ensure that the SLW engine sets LPCR with
> > > +		 * decrementer bit cleared, else we will get spurious
> > > +		 * wakeups.
> > > +		 */
> > > +		if (cpu_has_feature(CPU_FTR_ARCH_300))
> > > +			opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);  
> > 
> > Can you put these details into pnv_cpu_offline? Possibly even from there
> > into another special SPR save function? E.g.,  
> 
> We could move this to pnv_cpu_offline. Except that if we do get
> spurious interrupts, we will end up programming the the LPCR via
> stop-api again which is not needed.
> 
> Even this patch above can be optimized further. We need to program the
> LPCR with the PECE1 bit cleared only once, before the while loop, and
> once again program the LPCR with PECE1 bit set once we are out of the
> while loop.
> 
> But then, perhaps getting spurious interrupts when the CPU is
> hotplugged is an unlikely event. So I will move this to pnv_cpu_offline.

Yeah, I think it just tidies it up a bit. You're right, but as you say
it's not really a critical path.


> >   pnv_save_sprs_for_deep_state_decrementer_wakeup(bool decrementer_wakeup)
> > 
> > I'd like to put the LPCR manipulation for idle wake settings into idle.c
> > as well (pnv_cpu_offline), I think it fits better in there.
> >  
> 
> I agree. Will respin this,test and send out the v2.

Great thanks. The first patch seemed okay to me.

I wonder if we should think about a more structured kernel API for
modifying these kind of system registers so we always have the
up-to-date values stored in memory. Many of them do need to be
restored after sleep, but they don't need to be saved per-thread
or saved every time we go to sleep.

That's far more work of course, but it might be something we want
to think about for the future.

Thanks,
Nick
