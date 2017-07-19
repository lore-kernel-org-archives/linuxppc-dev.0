Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4hy6lV5zDrVg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 15:05:06 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6J53d4D126880
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 01:05:05 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bsxwjc26j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 01:05:04 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 19 Jul 2017 01:05:03 -0400
Date: Wed, 19 Jul 2017 10:34:59 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powernv/powerpc: Clear PECE1 in LPCR via stop-api
 only on Hotplug
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1500361607.git.ego@linux.vnet.ibm.com>
 <a3ba2f2ddfbe0145ca28963b487c14473a396269.1500361607.git.ego@linux.vnet.ibm.com>
 <20170719121412.1d89857c@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170719121412.1d89857c@roar.ozlabs.ibm.com>
Message-Id: <20170719050459.GA30836@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Nicholas,

On Wed, Jul 19, 2017 at 12:14:12PM +1000, Nicholas Piggin wrote:
> Thanks for working on these patches. We really need to get this stuff
> merged and tested asap :)
>

> On Tue, 18 Jul 2017 19:58:49 +0530

[..snip..]

> > diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> > index 40dae96..5f2a712 100644
> > --- a/arch/powerpc/platforms/powernv/smp.c
> > +++ b/arch/powerpc/platforms/powernv/smp.c
> > @@ -143,7 +143,8 @@ static void pnv_smp_cpu_kill_self(void)
> >  {
> >  	unsigned int cpu;
> >  	unsigned long srr1, wmask;
> > -
> > +	uint64_t lpcr_val;
> > +	uint64_t pir;
> >  	/* Standard hot unplug procedure */
> >  	/*
> >  	 * This hard disables local interurpts, ensuring we have no lazy
> > @@ -164,13 +165,17 @@ static void pnv_smp_cpu_kill_self(void)
> >  	if (cpu_has_feature(CPU_FTR_ARCH_207S))
> >  		wmask = SRR1_WAKEMASK_P8;
> >  
> > +	pir = get_hard_smp_processor_id(cpu);
> >  	/* We don't want to take decrementer interrupts while we are offline,
> >  	 * so clear LPCR:PECE1. We keep PECE2 (and LPCR_PECE_HVEE on P9)
> >  	 * enabled as to let IPIs in.
> >  	 */
> > -	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1);
> > +	lpcr_val = mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1;
> > +	mtspr(SPRN_LPCR, lpcr_val);
> >  
> >  	while (!generic_check_cpu_restart(cpu)) {
> > +
> > +
> >  		/*
> >  		 * Clear IPI flag, since we don't handle IPIs while
> >  		 * offline, except for those when changing micro-threading
> > @@ -180,8 +185,15 @@ static void pnv_smp_cpu_kill_self(void)
> >  		 */
> >  		kvmppc_set_host_ipi(cpu, 0);
> >  
> > +		/*
> > +		 * If the CPU gets woken up by a special wakeup,
> > +		 * ensure that the SLW engine sets LPCR with
> > +		 * decrementer bit cleared, else we will get spurious
> > +		 * wakeups.
> > +		 */
> > +		if (cpu_has_feature(CPU_FTR_ARCH_300))
> > +			opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);
> 
> Can you put these details into pnv_cpu_offline? Possibly even from there
> into another special SPR save function? E.g.,

We could move this to pnv_cpu_offline. Except that if we do get
spurious interrupts, we will end up programming the the LPCR via
stop-api again which is not needed.

Even this patch above can be optimized further. We need to program the
LPCR with the PECE1 bit cleared only once, before the while loop, and
once again program the LPCR with PECE1 bit set once we are out of the
while loop.

But then, perhaps getting spurious interrupts when the CPU is
hotplugged is an unlikely event. So I will move this to pnv_cpu_offline.

> 
>   pnv_save_sprs_for_deep_state_decrementer_wakeup(bool decrementer_wakeup)
> 
> I'd like to put the LPCR manipulation for idle wake settings into idle.c
> as well (pnv_cpu_offline), I think it fits better in there.
>

I agree. Will respin this,test and send out the v2.

> Thanks,

Thanks for the review.
> Nick
> 

--
Thanks and Regards
gautham.
