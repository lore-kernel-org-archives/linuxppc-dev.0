Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w34v30k4pzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 23:45:50 +1000 (AEST)
Message-ID: <1492004742.7236.58.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64s: catch external interrupts going to host in
 POWER9
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Apr 2017 23:45:42 +1000
In-Reply-To: <20170412131123.17445-1-npiggin@gmail.com>
References: <20170412131123.17445-1-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-12 at 23:11 +1000, Nicholas Piggin wrote:
> After setting LPES0 in the host on POWER9, the host external interrupt
> handler no longer works correctly, because it's set to HV mode (HSRR)
> for POWER7/8 with LPES0 clear. We don't expect to get any EE in the host
> with XIVE, but it seems preferable to catch unexpected interrupts in case
> there are bugs or unexpected behaviour.
> 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

No. Let's just get LPES back to P8 value in the host, we don't care as
we don't get those EEs on normal systems. Then make sure KVM properly
sets it the way we want when setting up the guest LPCR (which it should
be doing with my patches).

Much simpler patch...

Cheers,
Ben.


> Hi,
> 
> I was testing the LPES0 code on POWER9 under mambo, which exploded
> because I didn't use --enable-xive_interrupts so the host was getting
> EEs.
> 
> Errant 0x500 in the host will end up hrfid'ing to uninitialized HSRR[01]
> which ends up dying in interesting ways. Should we add this patch to
> Ben's xive topic branch that sets LPES0? (Or do you rebase topic branches?
> It could be rolled up with that particular patch if so).
> 
> Thanks,
> Nick
> 
>  arch/powerpc/kernel/exceptions-64s.S | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 857bf7c5b946..2f26a0553a4a 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -718,9 +718,21 @@ hardware_interrupt_hv:
> >  		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
> >  					    EXC_HV, SOFTEN_TEST_HV)
> >  	FTR_SECTION_ELSE
> > +		/*
> > +		 * The POWER9 XIVE interrupt controller should be configured
> > +		 * to send all interrupts to the host as HVI, even with the
> > +		 * OPAL XICS emulation, so HVMODE should never see a 0x500
> > +		 * interrupt. However we catch it in case of a bug.
> > +		 *
> > +		 * POWER9 sets the LPES0 LPCR bit in the host, which
> > +		 * delivers external interrupts to SRR[01] with MSR_HV
> > +		 * unchanged (intended for guest delivery), so these need
> > +		 * to be caught as EXC_STD interrupts in the host.
> > +		 */
> >  		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
> >  					    EXC_STD, SOFTEN_TEST_PR)
> > -	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
> > +	ALT_FTR_SECTION_END(CPU_FTR_HVMODE|CPU_FTR_ARCH_206|CPU_FTR_ARCH_300,
> > +			    CPU_FTR_HVMODE|CPU_FTR_ARCH_206)
>  EXC_REAL_END(hardware_interrupt, 0x500, 0x100)
>  
>  EXC_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x100)
> @@ -730,13 +742,21 @@ hardware_interrupt_relon_hv:
> >  		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_HV, SOFTEN_TEST_HV)
> >  	FTR_SECTION_ELSE
> >  		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_STD, SOFTEN_TEST_PR)
> > -	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
> > +	ALT_FTR_SECTION_END(CPU_FTR_HVMODE|CPU_FTR_ARCH_206|CPU_FTR_ARCH_300,
> > +			    CPU_FTR_HVMODE|CPU_FTR_ARCH_206)
>  EXC_VIRT_END(hardware_interrupt, 0x4500, 0x100)
>  
>  TRAMP_KVM(PACA_EXGEN, 0x500)
>  TRAMP_KVM_HV(PACA_EXGEN, 0x500)
> -EXC_COMMON_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
>  
> +EXC_COMMON_BEGIN(hardware_interrupt_common)
> +BEGIN_FTR_SECTION
> > +	/* See POWER9 comment above */
> > > +	b	unknown_host_ee_common
> +END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_300)
> > +	STD_EXCEPTION_COMMON_ASYNC(0x500, hardware_interrupt_common, do_IRQ)
> +
> +EXC_COMMON_ASYNC(unknown_host_ee_common, 0x500, unknown_exception)
>  
>  EXC_REAL(alignment, 0x600, 0x100)
>  EXC_VIRT(alignment, 0x4600, 0x100, 0x600)
