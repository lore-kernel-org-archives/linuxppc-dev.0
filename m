Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvbG24ChLzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 07:05:14 +1000 (AEST)
Message-ID: <1461704701.3135.68.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Use jump label to speed up radix_enabled check
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 27 Apr 2016 07:05:01 +1000
In-Reply-To: <1461687855-23017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1461687855-23017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Tue, 2016-04-26 at 21:54 +0530, Aneesh Kumar K.V wrote:
> This add generic mmu_feature_enabled() function that get patched
> to take right code path based on the feature bit enabled. The main
> difference between the existing mmu_has_feature() function is the
> hot patching using jump label framework.
> 
> The implementation wraps around mmu_has_feature so that we can use
> this in early bootup code before we do the hotpatching.

I'd rather we make mmu_has_feature() use jump labels and is the "main"
API to be used by most code. If we have a need for a lower-level
version for use by early boot code, call it __mmu_has_feature().

This is more in-line with existing kernel practices and avoids having
two APIs that somewhat look the same where it's not clear which one
should be used.

Ben.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu.h |  2 +-
>  arch/powerpc/include/asm/mmu.h           | 28
> ++++++++++++++++++++++++
>  arch/powerpc/include/asm/synch.h         |  1 +
>  arch/powerpc/kernel/module.c             |  5 +++++
>  arch/powerpc/kernel/setup_64.c           |  3 +++
>  arch/powerpc/kernel/vmlinux.lds.S        |  7 ++++++
>  arch/powerpc/lib/feature-fixups.c        | 37
> ++++++++++++++++++++++++++++++++
>  7 files changed, 82 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h
> b/arch/powerpc/include/asm/book3s/64/mmu.h
> index 0835a8f9904b..696b7c5cc31f 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -23,7 +23,7 @@ struct mmu_psize_def {
>  };
>  extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
>  
> -#define radix_enabled() mmu_has_feature(MMU_FTR_RADIX)
> +#define radix_enabled() mmu_feature_enabled(MMU_FTR_RADIX)
>  
>  #endif /* __ASSEMBLY__ */
>  
> diff --git a/arch/powerpc/include/asm/mmu.h
> b/arch/powerpc/include/asm/mmu.h
> index 9e8c05f9c562..fdb70dc218e5 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -3,6 +3,7 @@
>  #ifdef __KERNEL__
>  
>  #include <linux/types.h>
> +#include <linux/jump_label.h>
>  
>  #include <asm/asm-compat.h>
>  #include <asm/feature-fixups.h>
> @@ -125,6 +126,7 @@ static inline void mmu_clear_feature(unsigned
> long feature)
>  }
>  
>  extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
> +extern unsigned int __start___mmu_ftr_fixup_c,
> __stop___mmu_ftr_fixup_c;
>  
>  #ifdef CONFIG_PPC64
>  /* This is our real memory area size on ppc64 server, on embedded,
> we
> @@ -142,6 +144,32 @@ static inline void assert_pte_locked(struct
> mm_struct *mm, unsigned long addr)
>  }
>  #endif /* !CONFIG_DEBUG_VM */
>  
> +#ifdef HAVE_JUMP_LABEL
> +static __always_inline bool mmu_feature_enabled(unsigned long
> feature)
> +{
> +	asm_volatile_goto("1:\n\t"
> +			  ".pushsection
> __mmu_ftr_fixup_c,  \"a\"\n\t"
> +			  JUMP_ENTRY_TYPE "%0\n\t" /* feature bit */
> +			  JUMP_ENTRY_TYPE "1b\n\t"
> +			  JUMP_ENTRY_TYPE "%l[l_true]\n\t"
> +			  JUMP_ENTRY_TYPE "%l[l_false]\n\t"
> +			  ".popsection\n\t"
> +			  : : "i"(feature) : : l_true, l_false);
> +	if (mmu_has_feature(feature))
> +l_true:
> +		return true;
> +l_false:
> +	return false;
> +}
> +#else
> +static __always_inline bool mmu_feature_enabled(unsigned long
> feature)
> +{
> +	if (mmu_has_feature(feature))
> +		return true;
> +	return false;
> +}
> +#endif
> +
>  #endif /* !__ASSEMBLY__ */
>  
>  /* The kernel use the constants below to index in the page sizes
> array.
> diff --git a/arch/powerpc/include/asm/synch.h
> b/arch/powerpc/include/asm/synch.h
> index c50868681f9e..c34dd7ae176f 100644
> --- a/arch/powerpc/include/asm/synch.h
> +++ b/arch/powerpc/include/asm/synch.h
> @@ -14,6 +14,7 @@ extern unsigned int __start___lwsync_fixup,
> __stop___lwsync_fixup;
>  extern void do_lwsync_fixups(unsigned long value, void *fixup_start,
>  			     void *fixup_end);
>  extern void do_final_fixups(void);
> +extern void do_feature_fixups_in_c(unsigned long value, void
> *fixup_start, void *fixup_end);
>  
>  static inline void eieio(void)
>  {
> diff --git a/arch/powerpc/kernel/module.c
> b/arch/powerpc/kernel/module.c
> index d1f1b35bf0c7..ea109d0b9494 100644
> --- a/arch/powerpc/kernel/module.c
> +++ b/arch/powerpc/kernel/module.c
> @@ -80,5 +80,10 @@ int module_finalize(const Elf_Ehdr *hdr,
>  				 (void *)sect->sh_addr,
>  				 (void *)sect->sh_addr + sect-
> >sh_size);
>  
> +	sect = find_section(hdr, sechdrs, "__mmu_ftr_fixup_c");
> +	if (sect != NULL)
> +		do_feature_fixups_in_c(cur_cpu_spec->mmu_features,
> +				       (void *)sect->sh_addr,
> +				       (void *)sect->sh_addr + sect-
> >sh_size);
>  	return 0;
>  }
> diff --git a/arch/powerpc/kernel/setup_64.c
> b/arch/powerpc/kernel/setup_64.c
> index 5c03a6a9b054..79ab96ea7a6e 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -479,6 +479,9 @@ void __init setup_system(void)
>  			  &__start___mmu_ftr_fixup,
> &__stop___mmu_ftr_fixup);
>  	do_feature_fixups(powerpc_firmware_features,
>  			  &__start___fw_ftr_fixup,
> &__stop___fw_ftr_fixup);
> +	do_feature_fixups_in_c(cur_cpu_spec->mmu_features,
> +			       &__start___mmu_ftr_fixup_c,
> +			       &__stop___mmu_ftr_fixup_c);
>  	do_lwsync_fixups(cur_cpu_spec->cpu_features,
>  			 &__start___lwsync_fixup,
> &__stop___lwsync_fixup);
>  	do_final_fixups();
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S
> b/arch/powerpc/kernel/vmlinux.lds.S
> index d41fd0af8980..ffeed71987f6 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -147,6 +147,13 @@ SECTIONS
>  		*(__fw_ftr_fixup)
>  		__stop___fw_ftr_fixup = .;
>  	}
> +
> +	. = ALIGN(8);
> +	__mmu_ftr_fixup_c :  AT(ADDR(__mmu_ftr_fixup_c) -
> LOAD_OFFSET) {
> +		__start___mmu_ftr_fixup_c = .;
> +		*(__mmu_ftr_fixup_c)
> +		__stop___mmu_ftr_fixup_c = .;
> +	}
>  #endif
>  	.init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) {
>  		INIT_RAM_FS
> diff --git a/arch/powerpc/lib/feature-fixups.c
> b/arch/powerpc/lib/feature-fixups.c
> index 7ce3870d7ddd..8e5fd8c71b0c 100644
> --- a/arch/powerpc/lib/feature-fixups.c
> +++ b/arch/powerpc/lib/feature-fixups.c
> @@ -31,6 +31,13 @@ struct fixup_entry {
>  	long		alt_end_off;
>  };
>  
> +struct ftr_fixup_entry {
> +	unsigned long feature_bit;
> +	int *code;
> +	unsigned long true_target;
> +	unsigned long false_target;
> +};
> +
>  static unsigned int *calc_addr(struct fixup_entry *fcur, long
> offset)
>  {
>  	/*
> @@ -151,6 +158,36 @@ void do_final_fixups(void)
>  #endif
>  }
>  
> +void do_feature_fixups_in_c(unsigned long value, void *fixup_start,
> +			    void *fixup_end)
> +{
> +	unsigned long target;
> +	struct ftr_fixup_entry *fcur, *fend;
> +
> +	fcur = fixup_start;
> +	fend = fixup_end;
> +
> +	for (; fcur < fend; fcur++) {
> +		if (fcur->code &&
> +		    kernel_text_address((unsigned long)fcur->code))
> {
> +			if (value & fcur->feature_bit)
> +				target = fcur->true_target;
> +			else
> +				target = fcur->false_target;
> +
> +			/* Are we looping ? */
> +			if ((unsigned long)fcur->code == target)
> +				continue;
> +
> +			if (patch_branch(fcur->code, target, 0)) {
> +				WARN_ON(1);
> +				pr_err("Unable to patch radix
> section at %p\n",
> +				       fcur->code);
> +			}
> +		}
> +	}
> +}
> +
>  #ifdef CONFIG_FTR_FIXUP_SELFTEST
>  
>  #define check(x)	\
