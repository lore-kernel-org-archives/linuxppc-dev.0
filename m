Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KbJZ4G4XzF1PM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 17:26:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Diana Craciun <diana.craciun@nxp.com>, linuxppc-dev@lists.ozlabs.org
Cc: oss@buserror.net, leoyang.li@nxp.com, bharat.bhushan@nxp.com,
 Diana Craciun <diana.craciun@nxp.com>
Subject: Re: [PATCH v2 2/3] powerpc/fsl: Add barrier_nospec implementation for
 NXP PowerPC Book3E
In-Reply-To: <1528721608-15443-3-git-send-email-diana.craciun@nxp.com>
References: <1528721608-15443-1-git-send-email-diana.craciun@nxp.com>
 <1528721608-15443-3-git-send-email-diana.craciun@nxp.com>
Date: Tue, 03 Jul 2018 17:26:05 +1000
Message-ID: <87tvpgg4qa.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Diana,

A few comments below ...

Diana Craciun <diana.craciun@nxp.com> writes:
> Implement the barrier_nospec as a isync;sync instruction sequence.
> The implementation uses the infrastructure built for BOOK3S 64.

Do you have any details on why that sequence functions as an effective
barrier on your chips?

In a lot of places we have eg:

 +#if defined(CONFIG_PPC_BOOK3S_64) || defined(CONFIG_PPC_FSL_BOOK3E)

Can you please add a Kconfig symbol to capture that. eg.

config PPC_NOSPEC
	bool
        default y
	depends on PPC_BOOK3S_64 || PPC_FSL_BOOK3E


And then use that everywhere.

> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> index f67b3f6..405d572 100644
> --- a/arch/powerpc/include/asm/barrier.h
> +++ b/arch/powerpc/include/asm/barrier.h
> @@ -86,6 +86,16 @@ do {									\
>  // This also acts as a compiler barrier due to the memory clobber.
>  #define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
>  
> +#elif defined(CONFIG_PPC_FSL_BOOK3E)
> +/*
> + * Prevent the execution of subsequent instructions speculatively using a
> + * isync;sync instruction sequence.
> + */
> +#define barrier_nospec_asm NOSPEC_BARRIER_FIXUP_SECTION; nop; nop
> +
> +// This also acts as a compiler barrier due to the memory clobber.
> +#define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
> +
>  #else /* !CONFIG_PPC_BOOK3S_64 */
>  #define barrier_nospec_asm
>  #define barrier_nospec()

If we have CONFIG_PPC_NOSPEC this can be done something like:

#ifdef CONFIG_PPC_BOOK3S_64
#define NOSPEC_BARRIER_SLOT	nop
#elif defined(CONFIG_PPC_FSL_BOOK3E)
#define NOSPEC_BARRIER_SLOT	nop; nop
#endif /* CONFIG_PPC_BOOK3S_64 */

#ifdef CONFIG_PPC_NOSPEC
/*
 * Prevent execution of subsequent instructions until preceding branches have
 * been fully resolved and are no longer executing speculatively.
 */
#define barrier_nospec_asm NOSPEC_BARRIER_FIXUP_SECTION; NOSPEC_BARRIER_SLOT

// This also acts as a compiler barrier due to the memory clobber.
#define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
#else
#define barrier_nospec_asm
#define barrier_nospec()
#endif /* CONFIG_PPC_NOSPEC */


> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 2b4c40b2..d9dee43 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -76,7 +76,7 @@ endif
>  obj64-$(CONFIG_HIBERNATION)	+= swsusp_asm64.o
>  obj-$(CONFIG_MODULES)		+= module.o module_$(BITS).o
>  obj-$(CONFIG_44x)		+= cpu_setup_44x.o
> -obj-$(CONFIG_PPC_FSL_BOOK3E)	+= cpu_setup_fsl_booke.o
> +obj-$(CONFIG_PPC_FSL_BOOK3E)	+= cpu_setup_fsl_booke.o security.o
>  obj-$(CONFIG_PPC_DOORBELL)	+= dbell.o
>  obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o

Can we instead do:

obj-$(CONFIG_PPC_NOSPEC)	+= security.o

> diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
> index c55e102..797c975 100644
> --- a/arch/powerpc/kernel/security.c
> +++ b/arch/powerpc/kernel/security.c
> @@ -13,7 +13,9 @@
>  #include <asm/setup.h>
>  
>  
> +#ifdef CONFIG_PPC_BOOK3S_64
>  unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
> +#endif /* CONFIG_PPC_BOOK3S_64 */

Why are you making that book3s specific?

By doing that you then can't use the existing versions of
setup_barrier_nospec() and cpu_show_spectre_v1/v2().

> @@ -24,6 +26,7 @@ static void enable_barrier_nospec(bool enable)
>  	do_barrier_nospec_fixups(enable);
>  }
>  
> +#ifdef CONFIG_PPC_BOOK3S_64
>  void setup_barrier_nospec(void)
>  {
>  	bool enable;
> @@ -46,6 +49,15 @@ void setup_barrier_nospec(void)
>  	if (!no_nospec)
>  		enable_barrier_nospec(enable);
>  }
> +#endif /* CONFIG_PPC_BOOK3S_64 */
> +
> +#ifdef CONFIG_PPC_FSL_BOOK3E
> +void setup_barrier_nospec(void)
> +{
> +	if (!no_nospec)
> +		enable_barrier_nospec(true);
> +}
> +#endif /* CONFIG_PPC_FSL_BOOK3E */

eg. that is identical to the existing version except for the feature check:

	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);


Both those bits are enabled by default, so you shouldn't need to elide
that check.

So basically you should be able to use the existing
setup_barrier_nospec() if you just remove the ifdef around
powerpc_security_features. Or am I missing something?


> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index 7445748..80c1e6e 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -116,6 +116,11 @@ notrace void __init machine_init(u64 dt_ptr)
>  	/* Do some early initialization based on the flat device tree */
>  	early_init_devtree(__va(dt_ptr));
>  
> +	/* Apply the speculation barrier fixup */
> +#ifdef CONFIG_PPC_FSL_BOOK3E
> +	setup_barrier_nospec();
> +#endif

This ifdef should be handled in a header with an empty version for the
#else case.

> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 7a7ce8a..b2a644a 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -327,6 +327,12 @@ void __init early_setup(unsigned long dt_ptr)
>  
>  	/* Apply all the dynamic patching */
>  	apply_feature_fixups();
> +
> +	/* Apply the speculation barrier fixup */
> +#ifdef CONFIG_PPC_FSL_BOOK3E
> +	setup_barrier_nospec();
> +#endif /* CONFIG_PPC_FSL_BOOK3E */

Can you call it from ppc_md->setup_arch() like the other platforms?

Failing that we could put it in setup_arch() after the call to
ppc_md->setup_arch(), so we can share it with powernv/pseries.

> diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
> index 2b9173d..bea2b87 100644
> --- a/arch/powerpc/lib/feature-fixups.c
> +++ b/arch/powerpc/lib/feature-fixups.c
> @@ -188,7 +188,40 @@ void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_
>  
>  	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
>  }
> +#endif /* CONFIG_PPC_BOOK3S_64 */
> +
> +#ifdef CONFIG_PPC_FSL_BOOK3E
> +void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_end)
> +{
> +	unsigned int instr[2], *dest;
> +	long *start, *end;
> +	int i;
> +
> +	start = fixup_start;
> +	end = fixup_end;
> +
> +	instr[0] = PPC_INST_NOP;
> +	instr[1] = PPC_INST_NOP;
> +
> +	if (enable) {
> +		pr_info("barrier_nospec; using isync; sync as a speculation barrier\n");
> +		instr[0] = PPC_INST_ISYNC;
> +		instr[1] = PPC_INST_SYNC;
> +	}
> +
> +	for (i = 0; start < end; start++, i++) {
> +		dest = (void *)start + *start;
> +		pr_devel("patching dest %lx\n", (unsigned long)dest);
>  
> +		patch_instruction(dest, instr[0]);
> +		patch_instruction(dest + 1, instr[1]);
> +	}
> +
> +	pr_debug("barrier-nospec: patched %d locations\n", i);
> +}
> +#endif /* CONFIG_PPC_FSL_BOOK3E */

It's a bit unfortunate that we end up with two versions of that, which
are 80% the same. But merging them without ugly ifdefs would require a
bit more refactoring. So I guess it's OK for now.

cheers
