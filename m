Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E96A91A0153
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 14:51:41 +1000 (AEST)
In-Reply-To: <1437250134-307-15-git-send-email-scottwood@freescale.com>
To: Scott Wood <scottwood@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Scott Wood <scottwood@freescale.com>, Tiejun Chen <tiejun.chen@intel.com>,
 kexec@lists.infradead.org
Subject: Re: [RFC,14/17] powerpc/book3e-64/kexec: Enable SMP release
Message-Id: <20150818045141.D1E8C14032F@ozlabs.org>
Date: Tue, 18 Aug 2015 14:51:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-18-07 at 20:08:51 UTC, Scott Wood wrote:
> booted_from_exec is similar to __run_at_load, except that it is set for
              ^
	      missing k.

Also do you mind using __booted_from_kexec to keep the naming similar to the
other variables down there, and also make it clear it's low level guts.

I see you asked for them to be removed on the original patch but all the other
vars in there are named that way.

> regular kexec as well as kdump.
> 
> The flag is needed because the SMP release mechanism for FSL book3e is
> different from when booting with normal hardware.  In theory we could
> simulate the normal spin table mechanism, but not at the addresses
> U-Boot put in the device tree -- so there'd need to be even more
> communication between the kernel and kexec to set that up.  Since
> there's already a similar flag being set (for kdump only), this seemed
> like a reasonable approach.

Yeah I guess it is. Obviously it'd be nicer if we didn't have to do it though.

> 
> Unlike __run_at_kexec in http://patchwork.ozlabs.org/patch/257657/
> ("book3e/kexec/kdump: introduce a kexec kernel flag"), this flag is at
> a fixed address for ABI stability, and actually gets set properly in
> the kdump case (i.e. on the crash kernel, not on the crashing kernel).
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> This depends on the kexec-tools patch "ppc64: Add a flag to tell the
> kernel it's booting from kexec":
> http://lists.infradead.org/pipermail/kexec/2015-July/014048.html
> ---
>  arch/powerpc/include/asm/smp.h    |  1 +
>  arch/powerpc/kernel/head_64.S     | 15 +++++++++++++++
>  arch/powerpc/kernel/setup_64.c    | 14 +++++++++++++-
>  arch/powerpc/platforms/85xx/smp.c | 16 ++++++++++++----
>  4 files changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
> index 825663c..f9245df 100644
> --- a/arch/powerpc/include/asm/smp.h
> +++ b/arch/powerpc/include/asm/smp.h
> @@ -197,6 +197,7 @@ extern void generic_secondary_thread_init(void);
>  extern unsigned long __secondary_hold_spinloop;
>  extern unsigned long __secondary_hold_acknowledge;
>  extern char __secondary_hold;
> +extern u32 booted_from_kexec;
>  
>  extern void __early_start(void);
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 1b77956..ae2d6b5 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -91,6 +91,21 @@ __secondary_hold_spinloop:
>  __secondary_hold_acknowledge:
>  	.llong	0x0
>  
> +	/* Do not move this variable as kexec-tools knows about it. */
> +	. = 0x58
> +	.globl	booted_from_kexec
> +booted_from_kexec:
> +	/*
> +	 * "nkxc" -- not (necessarily) from kexec by default
> +	 *
> +	 * This flag is set to 1 by a loader if the kernel is being
> +	 * booted by kexec.  Older kexec-tools don't know about this
> +	 * flag, so platforms other than fsl-book3e should treat a value
> +	 * of "nkxc" as inconclusive.  fsl-book3e relies on this to
> +	 * know how to release secondary cpus.
> +	 */
> +	.long	0x6e6b7863

Couldn't we say that "nkxc" (whatever that stands for) means "unknown", and
have kexec-tools write "yes" to indicate yes. I realise that's not 100% bullet
proof, but it seems like it would be good enough. And it would mean we could
use the flag on other platforms if we ever want to.

Also "nkxc" ? "bfkx" ?

> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 505ec2c..baeddcc 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -340,11 +340,23 @@ void early_setup_secondary(void)
>  #endif /* CONFIG_SMP */
>  
>  #if defined(CONFIG_SMP) || defined(CONFIG_KEXEC)
> +static bool use_spinloop(void)
> +{
> +#ifdef CONFIG_PPC_FSL_BOOK3E
> +	return booted_from_kexec == 1;
> +#else
> +	return true;
> +#endif

Ugh, more ifdefs.

What about:

	return IS_ENABLED(CONFIG_PPC_FSL_BOOK3E) && (booted_from_kexec == 1);

If that works, I haven't checked. It's slightly less ugly?

> +}
> +
>  void smp_release_cpus(void)
>  {
>  	unsigned long *ptr;
>  	int i;
>  
> +	if (!use_spinloop())
> +		return;
> +
>  	DBG(" -> smp_release_cpus()\n");
>  
>  	/* All secondary cpus are spinning on a common spinloop, release them
> @@ -524,7 +536,7 @@ void __init setup_system(void)
>  	 * Freescale Book3e parts spin in a loop provided by firmware,
>  	 * so smp_release_cpus() does nothing for them
>  	 */
> -#if defined(CONFIG_SMP) && !defined(CONFIG_PPC_FSL_BOOK3E)
> +#if defined(CONFIG_SMP)

Can you make that just #ifdef CONFIG_SMP.

>  	/* Release secondary cpus out of their spinloops at 0x60 now that
>  	 * we can map physical -> logical CPU ids
>  	 */

cheers
