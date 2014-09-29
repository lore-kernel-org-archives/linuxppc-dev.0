Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0132.outbound.protection.outlook.com [65.55.169.132])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BA991A017D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 09:31:20 +1000 (EST)
Message-ID: <1412033466.13320.293.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/fsl: Add support for pci(e) machine check
 exception on E500MC / E5500
From: Scott Wood <scottwood@freescale.com>
To: Jojy Varghese <jojyv@juniper.net>
Date: Mon, 29 Sep 2014 18:31:06 -0500
In-Reply-To: <D04F3201.10DEB%jojyv@juniper.net>
References: <D04F3201.10DEB%jojyv@juniper.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "hongtao.jia@freescale.com" <hongtao.jia@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Guenter Roeck <groeck@juniper.net>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-09-29 at 23:03 +0000, Jojy Varghese wrote:
> 
> On 9/29/14 12:06 PM, "Guenter Roeck" <linux@roeck-us.net> wrote:
> 
> >On Mon, Sep 29, 2014 at 01:36:06PM -0500, Scott Wood wrote:
> >> On Mon, 2014-09-29 at 09:48 -0700, Guenter Roeck wrote:
> >> > From: Jojy G Varghese <jojyv@juniper.net>
> >> > 
> >> > For E500MC and E5500, a machine check exception in pci(e) memory space
> >> > crashes the kernel.
> >> > 
> >> > Testing shows that the MCAR(U) register is zero on a MC exception for
> >>the
> >> > E5500 core. At the same time, DEAR register has been found to have the
> >> > address of the faulty load address during an MC exception for this
> >>core.
> >> > 
> >> > This fix changes the current behavior to fixup the result register
> >> > and instruction pointers in the case of a load operation on a faulty
> >> > PCI address.
> >> > 
> >> > The changes are:
> >> > - Added the hook to pci machine check handing to the e500mc machine
> >>check
> >> >   exception handler.
> >> > - For the E5500 core, load faulting address from SPRN_DEAR register.
> >> >   As mentioned above, this is necessary because the E5500 core does
> >>not
> >> >   report the fault address in the MCAR register.
> >> > 
> >> > Cc: Scott Wood <scottwood@freescale.com>
> >> > Signed-off-by: Jojy G Varghese <jojyv@juniper.net>
> >> > [Guenter Roeck: updated description]
> >> > Signed-off-by: Guenter Roeck <groeck@juniper.net>
> >> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> > ---
> >> >  arch/powerpc/kernel/traps.c   | 3 ++-
> >> >  arch/powerpc/sysdev/fsl_pci.c | 5 +++++
> >> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >> > 
> >> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> >> > index 0dc43f9..ecb709b 100644
> >> > --- a/arch/powerpc/kernel/traps.c
> >> > +++ b/arch/powerpc/kernel/traps.c
> >> > @@ -494,7 +494,8 @@ int machine_check_e500mc(struct pt_regs *regs)
> >> >  	int recoverable = 1;
> >> >  
> >> >  	if (reason & MCSR_LD) {
> >> > -		recoverable = fsl_rio_mcheck_exception(regs);
> >> > +		recoverable = fsl_rio_mcheck_exception(regs) ||
> >> > +			fsl_pci_mcheck_exception(regs);
> >> >  		if (recoverable == 1)
> >> >  			goto silent_out;
> >> >  	}
> >> > diff --git a/arch/powerpc/sysdev/fsl_pci.c
> >>b/arch/powerpc/sysdev/fsl_pci.c
> >> > index c507767..bdb956b 100644
> >> > --- a/arch/powerpc/sysdev/fsl_pci.c
> >> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> >> > @@ -1021,6 +1021,11 @@ int fsl_pci_mcheck_exception(struct pt_regs
> >>*regs)
> >> >  #endif
> >> >  	addr += mfspr(SPRN_MCAR);
> >> >  
> >> > +#ifdef CONFIG_E5500_CPU
> >> > +	if (mfspr(SPRN_EPCR) & SPRN_EPCR_ICM)
> >> > +		addr = PFN_PHYS(vmalloc_to_pfn((void *)mfspr(SPRN_DEAR)));
> >> > +#endif
> >> 
> >> Kconfig tells you what hardware is supported, not what hardware you're
> >> actually running on.

Plus, CONFIG_E5500_CPU may not even be set when running on an e5500, as
it is used for selecting GCC optimization settings.  You could have
CONFIG_GENERIC_CPU instead.

And the subject says "E500MC / E5500", not just "E5500". :-)

> >Hi Scott,
> >
> >Good point. Jojy, guess we'll have to check if the CPU is actually an
> >E5500.
> >Can you look into that ?
> 
> 
> "/proc/cpuinfo" shows the cpu as "e5500". Scott, are you suggesting that
> we use a runtime method of determining the cpu type (cpu_spec's cpu_name
> for
> example).  

Yes, if there's a bug to be worked around, and we don't want to apply
the workaround unconditionally, you should use PVR to determine whether
you're running on an affected core.

> >> Can we rely on DEAR or is this just a side effect of likely having taken
> >> a TLB miss for the address recently?  Perhaps we should use the
> >> instruction emulation to determine the effective address instead.
> >> 
> >> Guenter, is this patch intended to deal with an erratum or are you
> >> covering up legitimate errors?
> >> 
>
> >Those are errors related to PCIe hotplug, and are seen with unexpected
> >PCIe
> >device removals (triggered, for example, by removing power from a PCIe
> >adapter).
> >The behavior we see on E5500 is quite similar to the same behavior on
> >E500:
> >If unhandled, the CPU keeps executing the same instruction over and over
> >again
> >if there is an error on a PCIe access and thus stalls. I don't know if
> >this
> >is considered an erratum or expected behavior, but it is one we have to
> >address
> >since we have to be able to handle that condition. 

The reason I ask is that the handling for e500 was described as an
erratum workaround.  If it is an erratum it would be nice to know the
erratum number and the full list of affected chips.

> >Ultimately, we'll want
> >to
> >implement PCIe error handlers for the affected drivers, but that will be
> >a next
> >step.

For now can we at least print a ratelimited error message?  I don't like
the idea of silently ignoring these errors.  I suppose it's a separate
issue from extending the workaround to cover e500mc, though.

> According to the spec, we MCAR is supposed to hold the faulty data address
> but for 5500 core, we found that MCAR is zero.

Which specific chip and revision did you see this on?  What is the value
in MCSR?

> You are right that DEAR entry could
> be a resultOf a TLB miss but that¹s the register we could rely on.

If it's the result of a previous TLB miss then we can't rely on it.  The
translation might have been loaded into the TLB before the hotplug
event, or there might have been an interrupt between loading the
translation into the TLB and using the translation.

> What do you mean by "instruction emulation"? 

mcheck_handle_load()

> Are you suggesting that we
> examine the RD, RS 
> registers for the instruction?

Yes, if we don't have a simpler reliable source of the address.

-Scott
