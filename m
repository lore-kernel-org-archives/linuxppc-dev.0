Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id C45942C0316
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 08:58:06 +1000 (EST)
Date: Thu, 11 Jul 2013 15:58:04 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: 21 stable powerpc patches showing up in 3.11-rc1?
Message-ID: <20130711225804.GA19886@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

Why do I have 21 patches from you marked for -stable trees in the
3.11-rc1 merge window, like the one quoted below?  All of these look
serious enough that they should have gone into the 3.10-rc releases,
especially as the date of when they were submitted gave you plenty of
time to get them merged.

So why wait for 3.11-rc1?  Are you not expecting anyone to run a 3.10.0
kernel on powerpc?  If so, why would they want to wait for 3.10.1?

What is broken in our development process that caused this?

greg k-h

> commit: b14b6260efeee6eb8942c6e6420e31281892acb6
> From: Michael Ellerman <michael@ellerman.id.au>
> Date: Tue, 25 Jun 2013 17:47:57 +1000
> Subject: powerpc: Wire up the HV facility unavailable exception
> 
> Similar to the facility unavailble exception, except the facilities are
> controlled by HFSCR.
> 
> Adapt the facility_unavailable_exception() so it can be called for
> either the regular or Hypervisor facility unavailable exceptions.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> CC: <stable@vger.kernel.org> [v3.10]
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/exceptions-64s.S |   15 +++++++++++++++
>  arch/powerpc/kernel/traps.c          |   16 ++++++++++++----
>  2 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 6ee74f8..359d949 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -347,6 +347,12 @@ facility_unavailable_trampoline:
>  	EXCEPTION_PROLOG_0(PACA_EXGEN)
>  	b	facility_unavailable_pSeries
>  
> +hv_facility_unavailable_trampoline:
> +	. = 0xf80
> +	SET_SCRATCH0(r13)
> +	EXCEPTION_PROLOG_0(PACA_EXGEN)
> +	b	facility_unavailable_hv
> +
>  #ifdef CONFIG_CBE_RAS
>  	STD_EXCEPTION_HV(0x1200, 0x1202, cbe_system_error)
>  	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1202)
> @@ -525,6 +531,8 @@ denorm_done:
>  	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf40)
>  	STD_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
>  	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf60)
> +	STD_EXCEPTION_HV_OOL(0xf82, facility_unavailable)
> +	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xf82)
>  
>  /*
>   * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
> @@ -836,6 +844,12 @@ facility_unavailable_relon_trampoline:
>  	EXCEPTION_PROLOG_0(PACA_EXGEN)
>  	b	facility_unavailable_relon_pSeries
>  
> +hv_facility_unavailable_relon_trampoline:
> +	. = 0x4f80
> +	SET_SCRATCH0(r13)
> +	EXCEPTION_PROLOG_0(PACA_EXGEN)
> +	b	facility_unavailable_relon_hv
> +
>  	STD_RELON_EXCEPTION_PSERIES(0x5300, 0x1300, instruction_breakpoint)
>  #ifdef CONFIG_PPC_DENORMALISATION
>  	. = 0x5500
> @@ -1174,6 +1188,7 @@ __end_handlers:
>  	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
>  	STD_RELON_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
>  	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
> +	STD_RELON_EXCEPTION_HV_OOL(0xf80, facility_unavailable)
>  
>  #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
>  /*
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 11f4488..4a87fcb 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1299,10 +1299,18 @@ void facility_unavailable_exception(struct pt_regs *regs)
>  		"EBB",
>  		"TAR",
>  	};
> -	char *facility;
> +	char *facility, *prefix;
>  	u64 value;
>  
> -	value = mfspr(SPRN_FSCR) >> 56;
> +	if (regs->trap == 0xf60) {
> +		value = mfspr(SPRN_FSCR);
> +		prefix = "";
> +	} else {
> +		value = mfspr(SPRN_HFSCR);
> +		prefix = "Hypervisor ";
> +	}
> +
> +	value = value >> 56;
>  
>  	/* We restore the interrupt state now */
>  	if (!arch_irq_disabled_regs(regs))
> @@ -1313,8 +1321,8 @@ void facility_unavailable_exception(struct pt_regs *regs)
>  	else
>  		facility = "unknown";
>  
> -	pr_err("Facility '%s' unavailable, exception at 0x%lx, MSR=%lx\n",
> -		facility, regs->nip, regs->msr);
> +	pr_err("%sFacility '%s' unavailable, exception at 0x%lx, MSR=%lx\n",
> +		prefix, facility, regs->nip, regs->msr);
>  
>  	if (user_mode(regs)) {
>  		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
> -- 
> 1.7.10.4
