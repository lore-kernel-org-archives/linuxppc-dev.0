Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C6F85B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 08:43:26 +1000 (EST)
Message-ID: <1338936198.7150.138.camel@pasglop>
Subject: Re: [PATCH] perf: Don't use SIAR for user addresses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Wed, 06 Jun 2012 08:43:18 +1000
In-Reply-To: <20120605203247.GA1525@us.ibm.com>
References: <20120605203247.GA1525@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mpjohn@us.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-06-05 at 13:32 -0700, Sukadev Bhattiprolu wrote:
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Fri, 1 Jun 2012 20:56:02 -0400
> Subject: [PATCH] perf: Don't use SIAR for user-space addresses
> 
> With the pipelining on Power7, the SIAR can be off by several instructions
> leading to incorrect callgraphs. For user space code at least we can be more
> accurate by just using the next instruction pointer.
> 
> Based on code/input from Anton Blanchard.

Had a chat with him, we still want to use SIAR for marked events, which
I think off the top of my head is mmcra & MMCRA_SAMPLE_ENABLE.

There's a few more considerations we discussed, such as wanting also
more precise backtraces in kernel space, but still capture in pHyp when
SIHV is set and have maybe some kind of sysfs option to revert back to
SIAR kernel-wide if we are trying to track down hard irq off stuff.

I'll let Anton followup. I'm still technically not working for a couple
of weeks :-)

Cheers,
Ben.

> Before this fon Power7, we see callgraphs like:
> 
>      1.90%  sprintft  sprintft           [.] do_my_sprintf
>                |
>                --- 00000011.plt_call.strlen@@GLIBC_2.3+0
>                    do_my_sprintf
>                    main
>                    generic_start_main
>                    __libc_start_main
>                    (nil)
>         ...snip...
> 
>               |
>                --- __random
>                    rand
>                   |
>                   |--63.16%-- do_my_sprintf
>                   |          main
>                   |          generic_start_main
>                   |          __libc_start_main
>                   |          (nil)
>                   |
>                    --36.84%-- rand
>                              do_my_sprintf
>                              main
>                              generic_start_main
>                              __libc_start_main
>                              (nil)
> 
> which seems to indicate the libc __random() calls do_my_sprintf(), instead
> of the other way around.
> 
> After the fix, the same trace looks like this:
> 
>      4.08%  sprintft  sprintft           [.] do_my_sprintf
>             |
>             --- do_my_sprintf
>                 do_my_sprintf
>                 main
>                 generic_start_main
>                 __libc_start_main
>                 (nil)
> 
> Cc: Anton Blanchard <anton@samba.org>
> Reported-by: Maynard Johnson <mpjohn@us.ibm.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/core-book3s.c |   39 ++++++++++++++++++++++++++++++---------
>  1 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 8f84bcb..846bd68 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -116,6 +116,26 @@ static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
>  		*addrp = mfspr(SPRN_SDAR);
>  }
>  
> +static bool mmcra_sihv(unsigned long mmcra)
> +{
> +	unsigned long sihv = MMCRA_SIHV;
> +
> +	if (ppmu->flags & PPMU_ALT_SIPR)
> +		sihv = POWER6_MMCRA_SIHV;
> +
> +	return !!(mmcra & sihv);
> +}
> +
> +static bool mmcra_sipr(unsigned long mmcra)
> +{
> +	unsigned long sipr = MMCRA_SIPR;
> +
> +	if (ppmu->flags & PPMU_ALT_SIPR)
> +		sipr = POWER6_MMCRA_SIPR;
> +
> +	return !!(mmcra & sipr);
> +}
> +
>  static inline u32 perf_flags_from_msr(struct pt_regs *regs)
>  {
>  	if (regs->msr & MSR_PR)
> @@ -128,8 +148,6 @@ static inline u32 perf_flags_from_msr(struct pt_regs *regs)
>  static inline u32 perf_get_misc_flags(struct pt_regs *regs)
>  {
>  	unsigned long mmcra = regs->dsisr;
> -	unsigned long sihv = MMCRA_SIHV;
> -	unsigned long sipr = MMCRA_SIPR;
>  
>  	/* Not a PMU interrupt: Make up flags from regs->msr */
>  	if (TRAP(regs) != 0xf00)
> @@ -156,15 +174,10 @@ static inline u32 perf_get_misc_flags(struct pt_regs *regs)
>  		return PERF_RECORD_MISC_USER;
>  	}
>  
> -	if (ppmu->flags & PPMU_ALT_SIPR) {
> -		sihv = POWER6_MMCRA_SIHV;
> -		sipr = POWER6_MMCRA_SIPR;
> -	}
> -
>  	/* PR has priority over HV, so order below is important */
> -	if (mmcra & sipr)
> +	if (mmcra_sipr(mmcra))
>  		return PERF_RECORD_MISC_USER;
> -	if ((mmcra & sihv) && (freeze_events_kernel != MMCR0_FCHV))
> +	if (mmcra_sihv(mmcra) && (freeze_events_kernel != MMCR0_FCHV))
>  		return PERF_RECORD_MISC_HYPERVISOR;
>  	return PERF_RECORD_MISC_KERNEL;
>  }
> @@ -1340,6 +1353,14 @@ unsigned long perf_instruction_pointer(struct pt_regs *regs)
>  	    !(mmcra & MMCRA_SAMPLE_ENABLE))
>  		return regs->nip;
>  
> +	/*
> +	 * With pipelining on P7, addresses in the SIAR can be off by several
> +	 * instructions. For user space use the next instruction pointer as
> +	 * that will be more accurate.
> +	 */
> +	if (mmcra_sipr(mmcra))
> +		return regs->nip;
> +
>  	return mfspr(SPRN_SIAR) + perf_ip_adjust(regs);
>  }
>  
