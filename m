Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A192DDF0B
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 09:23:21 +1000 (EST)
Subject: Re: [PATCH][WIP][RFC] powerpc: fixup lwsync at runtime
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0806201131040.17834@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0806201131040.17834@blarg.am.freescale.net>
Content-Type: text/plain
Date: Sat, 21 Jun 2008 09:23:13 +1000
Message-Id: <1214004193.8011.184.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-06-20 at 11:36 -0500, Kumar Gala wrote:
> This is a work in progress towards make lwsync fixed up at runtime.  The
> patch is based (requires) the module refactoring patch.  Some of this code
> should be reworked based on the code patching work from Michael.  Also,
> ppc64 and vdso support needs a bit of cleaning up.
> 
> Some questions:
> * How do we determine at runtime if we need to convert sync to lwsync.
> This is simliar to cpu_feature but has the issue that cpu_feature is about
> either having code in or not.
> 
> * Do we simplify the section of fixup information and remove the mask and
> value since we don't use them and they double the size of the section

Remind me why we want to do that ? ie. can't we just use lwsync
unconditionally ? It's supposed to degrade to sync on CPUs that don't
support it, or is that broken on some parts ?

Ben.

> - k
> 
>  arch/powerpc/kernel/cputable.c    |   17 +++++++++++++++--
>  arch/powerpc/kernel/module.c      |    5 +++++
>  arch/powerpc/kernel/setup_32.c    |    3 +++
>  arch/powerpc/kernel/vmlinux.lds.S |    6 ++++++
>  include/asm-powerpc/synch.h       |   26 +++++++++++++++++---------
>  include/asm-powerpc/system.h      |    2 +-
>  6 files changed, 47 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index c5397c1..4905f1d 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -1600,7 +1600,7 @@ struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
>  	return NULL;
>  }
> 
> -void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
> +static inline void __do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end, u32 insn)
>  {
>  	struct fixup_entry {
>  		unsigned long	mask;
> @@ -1625,7 +1625,7 @@ void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
>  		pend = ((unsigned int *)fcur) + (fcur->end_off / 4);
> 
>  		for (p = pstart; p < pend; p++) {
> -			*p = 0x60000000u;
> +			*p = insn;
>  			asm volatile ("dcbst 0, %0" : : "r" (p));
>  		}
>  		asm volatile ("sync" : : : "memory");
> @@ -1634,3 +1634,16 @@ void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
>  		asm volatile ("sync; isync" : : : "memory");
>  	}
>  }
> +
> +void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
> +{
> +	__do_feature_fixups(value, fixup_start, fixup_end, 0x60000000u);
> +}
> +
> +#define PPC_LWSYNC_INSTR	0x7c2004ac
> +void do_lwsync_fixups(void *fixup_start, void *fixup_end)
> +{
> +#if defined(__powerpc64__) || defined(CONFIG_PPC_E500MC)
> +	__do_feature_fixups(0, fixup_start, fixup_end, PPC_LWSYNC_INSTR);
> +#endif
> +}
> diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
> index 40dd52d..34905b8 100644
> --- a/arch/powerpc/kernel/module.c
> +++ b/arch/powerpc/kernel/module.c
> @@ -86,6 +86,11 @@ int module_finalize(const Elf_Ehdr *hdr,
>  				  (void *)sect->sh_addr + sect->sh_size);
>  #endif
> 
> +	sect = find_section(hdr, sechdrs, "__lwsync_fixup");
> +	if (sect != NULL)
> +		do_lwsync_fixups((void *)sect->sh_addr,
> +				 (void *)sect->sh_addr + sect->sh_size);
> +
>  	return 0;
>  }
> 
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index 9e83add..d1e498f 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -101,6 +101,9 @@ unsigned long __init early_init(unsigned long dt_ptr)
>  			  PTRRELOC(&__start___ftr_fixup),
>  			  PTRRELOC(&__stop___ftr_fixup));
> 
> +	do_lwsync_fixups(PTRRELOC(&__start___lwsync_fixup),
> +			 PTRRELOC(&__stop___lwsync_fixup));
> +
>  	return KERNELBASE + offset;
>  }
> 
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index 0c3000b..d4d351a 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -127,6 +127,12 @@ SECTIONS
>  		*(__ftr_fixup)
>  		__stop___ftr_fixup = .;
>  	}
> +	. = ALIGN(8);
> +	__lwsync_fixup : AT(ADDR(__lwsync_fixup) - LOAD_OFFSET) {
> +		__start___lwsync_fixup = .;
> +		*(__lwsync_fixup)
> +		__stop___lwsync_fixup = .;
> +	}
>  #ifdef CONFIG_PPC64
>  	. = ALIGN(8);
>  	__fw_ftr_fixup : AT(ADDR(__fw_ftr_fixup) - LOAD_OFFSET) {
> diff --git a/include/asm-powerpc/synch.h b/include/asm-powerpc/synch.h
> index 42a1ef5..c031808 100644
> --- a/include/asm-powerpc/synch.h
> +++ b/include/asm-powerpc/synch.h
> @@ -3,20 +3,28 @@
>  #ifdef __KERNEL__
> 
>  #include <linux/stringify.h>
> +#include <asm/asm-compat.h>
> 
> -#if defined(__powerpc64__) || defined(CONFIG_PPC_E500MC)
> -#define __SUBARCH_HAS_LWSYNC
> -#endif
> +#ifndef __ASSEMBLY__
> +extern unsigned int __start___lwsync_fixup, __stop___lwsync_fixup;
> +extern void do_lwsync_fixups(void *fixup_start, void *fixup_end);
> +#endif /* __ASSEMBLY__ */
> 
> -#ifdef __SUBARCH_HAS_LWSYNC
> -#    define LWSYNC	lwsync
> -#else
> -#    define LWSYNC	sync
> -#endif
> +#define BEGIN_LWSYNC_SECTION_NESTED(label)	label:
> +#define BEGIN_LWSYNC_SECTION		BEGIN_LWSYNC_SECTION_NESTED(97)
> +#define END_LWSYNC_SECTION_NESTED(msk, val, label) \
> +	MAKE_FTR_SECTION_ENTRY(msk, val, label, __lwsync_fixup)
> +#define END_LWSYNC_SECTION \
> +	END_LWSYNC_SECTION_NESTED(1, 1, 97)
> +
> +#    define LWSYNC		\
> +	BEGIN_LWSYNC_SECTION;	\
> +	sync;			\
> +	END_LWSYNC_SECTION;
> 
>  #ifdef CONFIG_SMP
>  #define ISYNC_ON_SMP	"\n\tisync\n"
> -#define LWSYNC_ON_SMP	__stringify(LWSYNC) "\n"
> +#define LWSYNC_ON_SMP	stringify_in_c(LWSYNC) "\n"
>  #else
>  #define ISYNC_ON_SMP
>  #define LWSYNC_ON_SMP
> diff --git a/include/asm-powerpc/system.h b/include/asm-powerpc/system.h
> index df781ad..15218bb 100644
> --- a/include/asm-powerpc/system.h
> +++ b/include/asm-powerpc/system.h
> @@ -34,7 +34,7 @@
>   * SMP since it is only used to order updates to system memory.
>   */
>  #define mb()   __asm__ __volatile__ ("sync" : : : "memory")
> -#define rmb()  __asm__ __volatile__ (__stringify(LWSYNC) : : : "memory")
> +#define rmb()  __asm__ __volatile__ (stringify_in_c(LWSYNC) : : : "memory")
>  #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
>  #define read_barrier_depends()  do { } while(0)
> 
