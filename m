Return-Path: <keescook@google.com>
Received: from mail-ob0-x233.google.com (mail-ob0-x233.google.com
 [IPv6:2607:f8b0:4003:c01::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F9B41A0D2C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 06:34:39 +1100 (AEDT)
Received: by mail-ob0-f179.google.com with SMTP id wp4so38684579obc.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 11:34:36 -0800 (PST)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <54EB735F.5030207@upv.es>
References: <54EB735F.5030207@upv.es>
Date: Mon, 23 Feb 2015 11:34:36 -0800
Message-ID: <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
Subject: Re: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
From: Kees Cook <keescook@chromium.org>
To: Hector Marco <hecmargi@upv.es>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 ismael Ripoll <iripoll@upv.es>, linuxppc-dev@lists.ozlabs.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(I've added some additional CCs to make sure the arch maintainers
notice this patch.)

This patch seems white-space damaged to me. I had to do a lot of
manual editing to get it to apply. Please use "git format-patch", if
you're not already. What version of the kernel was this based on?

On Mon, Feb 23, 2015 at 10:37 AM, Hector Marco <hecmargi@upv.es> wrote:
> [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
>
> The issue appears on PIE linked executables when all memory areas of a
> process are randomized. In this case, the attack "offset2lib" de-randomizes
> all library areas on 64 bit Linux systems in less than one second.
>
>
> Further details of the PoC attack at:
> http://cybersecurity.upv.es/attacks/offset2lib/offset2lib.html
>
>
> This patch loads the PIE linked executable in a different area than the
> libraries. The successful fix can be tested with a simple pie compiled
> application:
>
>
> $ ./show_mmaps_pie
> 54859ccd6000-54859ccd7000 r-xp  ...  /tmp/show_mmaps_pie
> 54859ced6000-54859ced7000 r--p  ...  /tmp/show_mmaps_pie
> 54859ced7000-54859ced8000 rw-p  ...  /tmp/show_mmaps_pie
> 7f75be764000-7f75be91f000 r-xp  ...  /lib/x86_64-linux-gnu/libc.so.6
> 7f75be91f000-7f75beb1f000 ---p  ...  /lib/x86_64-linux-gnu/libc.so.6
> 7f75beb1f000-7f75beb23000 r--p  ...  /lib/x86_64-linux-gnu/libc.so.6
> 7f75beb23000-7f75beb25000 rw-p  ...  /lib/x86_64-linux-gnu/libc.so.6
> 7f75beb25000-7f75beb2a000 rw-p  ...
> 7f75beb2a000-7f75beb4d000 r-xp  ...  /lib64/ld-linux-x86-64.so.2
> 7f75bed45000-7f75bed46000 rw-p  ...
> 7f75bed46000-7f75bed47000 r-xp  ...
> 7f75bed47000-7f75bed4c000 rw-p  ...
> 7f75bed4c000-7f75bed4d000 r--p  ...  /lib64/ld-linux-x86-64.so.2
> 7f75bed4d000-7f75bed4e000 rw-p  ...  /lib64/ld-linux-x86-64.so.2
> 7f75bed4e000-7f75bed4f000 rw-p  ...
> 7fffb3741000-7fffb3762000 rw-p  ...  [stack]
> 7fffb377b000-7fffb377d000 r--p  ...  [vvar]
> 7fffb377d000-7fffb377f000 r-xp  ...  [vdso]
>
>
> Once corrected, the PIE linked application is loaded in a different area.

Thanks for working on this!

>
> We updated the "Fixing Offset2lib weakness" page:
> http://cybersecurity.upv.es/solutions/aslrv2/aslrv2.html
>
>
> Signed-off-by: Hector Marco-Gisbert <hecmargi@upv.es>
> Signed-off-by: Ismael Ripoll <iripoll@upv.es>

Acked-by: Kees Cook <keescook@chromium.org>

>
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 97d07ed..ee7ea7e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1,7 +1,6 @@
>  config ARM
>         bool
>         default y
> -       select ARCH_BINFMT_ELF_RANDOMIZE_PIE
>         select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>         select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>         select ARCH_HAVE_CUSTOM_GPIO_H
> diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
> index afb9caf..6755cd8 100644
> --- a/arch/arm/include/asm/elf.h
> +++ b/arch/arm/include/asm/elf.h
> @@ -115,7 +115,8 @@ int dump_task_regs(struct task_struct *t, elf_gregset_t
> *elfregs);
>     the loader.  We need to make sure that it is out of the way of the
> program
>     that it will "exec", and that there is sufficient room for the brk.  */
>
> -#define ELF_ET_DYN_BASE        (2 * TASK_SIZE / 3)
> +extern unsigned long randomize_et_dyn(unsigned long base);
> +#define ELF_ET_DYN_BASE        (randomize_et_dyn(2 * TASK_SIZE / 3))
>
>  /* When the program starts, a1 contains a pointer to a function to be
>     registered with atexit, as per the SVR4 ABI.  A value of 0 means we
> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
> index 5e85ed3..9177100 100644
> --- a/arch/arm/mm/mmap.c
> +++ b/arch/arm/mm/mmap.c
> @@ -30,6 +30,17 @@ static int mmap_is_legacy(void)
>         return sysctl_legacy_va_layout;
>  }
>
> +static unsigned long mmap_rnd(void)
> +{
> +       unsigned long rnd = 0;
> +
> +       /* 8 bits of randomness in 20 address space bits */
> +       if (current->flags & PF_RANDOMIZE)
> +               rnd = (long)get_random_int() % (1 << 8);
> +
> +       return rnd << PAGE_SHIFT;
> +}
> +
>  static unsigned long mmap_base(unsigned long rnd)
>  {
>         unsigned long gap = rlimit(RLIMIT_STACK);
> @@ -230,3 +241,13 @@ int devmem_is_allowed(unsigned long pfn)
>  }
>
>  #endif
> +
> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +       unsigned long ret;
> +       if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +               !(current->flags & PF_RANDOMIZE))
> +               return base;
> +       ret = base + mmap_rnd();
> +       return (ret > base) ? ret : base;
> +}
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b1f9a20..5580d90 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1,6 +1,5 @@
>  config ARM64
>         def_bool y
> -       select ARCH_BINFMT_ELF_RANDOMIZE_PIE
>         select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>         select ARCH_HAS_GCOV_PROFILE_ALL
>         select ARCH_HAS_SG_CHAIN
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 1f65be3..01d3aab 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -126,7 +126,7 @@ typedef struct user_fpsimd_state elf_fpregset_t;
>   * that it will "exec", and that there is sufficient room for the brk.
>   */
>  extern unsigned long randomize_et_dyn(unsigned long base);
> -#define ELF_ET_DYN_BASE        (2 * TASK_SIZE_64 / 3)
> +#define ELF_ET_DYN_BASE        (randomize_et_dyn(2 * TASK_SIZE_64 / 3))
>
>  /*
>   * When the program starts, a1 contains a pointer to a function to be
> @@ -169,7 +169,7 @@ extern unsigned long arch_randomize_brk(struct mm_struct
> *mm);
>  #define COMPAT_ELF_PLATFORM            ("v8l")
>  #endif
>
> -#define COMPAT_ELF_ET_DYN_BASE         (2 * TASK_SIZE_32 / 3)
> +#define COMPAT_ELF_ET_DYN_BASE         (randomize_et_dyn(2 * TASK_SIZE_32 /
> 3))
>
>  /* AArch32 registers. */
>  #define COMPAT_ELF_NGREG               18
> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index 54922d1..980110c50 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -89,6 +89,16 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
>  }
>  EXPORT_SYMBOL_GPL(arch_pick_mmap_layout);
>
> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +       unsigned long ret;
> +       if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +               !(current->flags & PF_RANDOMIZE))
> +               return base;
> +       ret = base + mmap_rnd();
> +       return (ret > base) ? ret : base;
> +}
> +
>
>  /*
>   * You really shouldn't be using read() or write() on /dev/mem.  This might
> go
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 3289969..31cc248 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -23,7 +23,6 @@ config MIPS
>         select HAVE_KRETPROBES
>         select HAVE_DEBUG_KMEMLEAK
>         select HAVE_SYSCALL_TRACEPOINTS
> -       select ARCH_BINFMT_ELF_RANDOMIZE_PIE
>         select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES &&
> 64BIT
>         select RTC_LIB if !MACH_LOONGSON
>         select GENERIC_ATOMIC64 if !64BIT
> diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
> index eb4d95d..fcac4c99 100644
> --- a/arch/mips/include/asm/elf.h
> +++ b/arch/mips/include/asm/elf.h
> @@ -402,7 +402,8 @@ extern const char *__elf_platform;
>     that it will "exec", and that there is sufficient room for the brk. */
>
>  #ifndef ELF_ET_DYN_BASE
> -#define ELF_ET_DYN_BASE                (TASK_SIZE / 3 * 2)
> +extern unsigned long randomize_et_dyn(unsigned long base);
> +#define ELF_ET_DYN_BASE                (randomize_et_dyn(TASK_SIZE / 3 *
> 2))
>  #endif
>
>  #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
> index f1baadd..20ad644 100644
> --- a/arch/mips/mm/mmap.c
> +++ b/arch/mips/mm/mmap.c
> @@ -196,3 +196,13 @@ int __virt_addr_valid(const volatile void *kaddr)
>         return pfn_valid(PFN_DOWN(virt_to_phys(kaddr)));
>  }
>  EXPORT_SYMBOL_GPL(__virt_addr_valid);
> +
> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +       unsigned long ret;
> +       if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +               !(current->flags & PF_RANDOMIZE))
> +               return base;
> +       ret = base + brk_rnd();
> +       return (ret > base) ? ret : base;
> +}
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a2a168e..fa4c877 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -88,7 +88,6 @@ config PPC
>         select ARCH_MIGHT_HAVE_PC_PARPORT
>         select ARCH_MIGHT_HAVE_PC_SERIO
>         select BINFMT_ELF
> -       select ARCH_BINFMT_ELF_RANDOMIZE_PIE
>         select OF
>         select OF_EARLY_FLATTREE
>         select OF_RESERVED_MEM
> diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
> index 57d289a..4080425 100644
> --- a/arch/powerpc/include/asm/elf.h
> +++ b/arch/powerpc/include/asm/elf.h
> @@ -28,7 +28,8 @@
>     the loader.  We need to make sure that it is out of the way of the
> program
>     that it will "exec", and that there is sufficient room for the brk.  */
>
> -#define ELF_ET_DYN_BASE        0x20000000
> +extern unsigned long randomize_et_dyn(unsigned long base);
> +#define ELF_ET_DYN_BASE        (randomize_et_dyn(0x20000000))
>
>  #define ELF_CORE_EFLAGS (is_elf2_task() ? 2 : 0)
>
> diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
> index cb8bdbe..3e642e7 100644
> --- a/arch/powerpc/mm/mmap.c
> +++ b/arch/powerpc/mm/mmap.c
> @@ -97,3 +97,13 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
>                 mm->get_unmapped_area = arch_get_unmapped_area_topdown;
>         }
>  }
> +
> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +       unsigned long ret;
> +       if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +               !(current->flags & PF_RANDOMIZE))
> +               return base;
> +       ret = base + mmap_rnd();
> +       return (ret > base) ? ret : base;
> +}
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index ba397bd..dcfe16c 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -85,7 +85,6 @@ config X86
>         select HAVE_CMPXCHG_DOUBLE
>         select HAVE_ARCH_KMEMCHECK
>         select HAVE_USER_RETURN_NOTIFIER
> -       select ARCH_BINFMT_ELF_RANDOMIZE_PIE
>         select HAVE_ARCH_JUMP_LABEL
>         select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>         select SPARSE_IRQ
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index ca3347a..92c6ac4 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -249,7 +249,8 @@ extern int force_personality32;
>     the loader.  We need to make sure that it is out of the way of the
> program
>     that it will "exec", and that there is sufficient room for the brk.  */
>
> -#define ELF_ET_DYN_BASE                (TASK_SIZE / 3 * 2)
> +extern unsigned long randomize_et_dyn(unsigned long base);
> +#define ELF_ET_DYN_BASE                (randomize_et_dyn(TASK_SIZE / 3 *
> 2))
>
>  /* This yields a mask that user programs can use to figure out what
>     instruction set this CPU supports.  This could be done in user space,
> diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
> index 919b912..7b86605 100644
> --- a/arch/x86/mm/mmap.c
> +++ b/arch/x86/mm/mmap.c
> @@ -122,3 +122,12 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
>                 mm->get_unmapped_area = arch_get_unmapped_area_topdown;
>         }
>  }
> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +       unsigned long ret;
> +       if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +               !(current->flags & PF_RANDOMIZE))
> +               return base;
> +       ret = base + mmap_rnd();
> +       return (ret > base) ? ret : base;
> +}
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index c055d56..1186190 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -27,8 +27,6 @@ config COMPAT_BINFMT_ELF
>         bool
>         depends on COMPAT && BINFMT_ELF
>
> -config ARCH_BINFMT_ELF_RANDOMIZE_PIE
> -       bool
>
>  config ARCH_BINFMT_ELF_STATE
>         bool
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 02b1691..72f7ff5 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -908,21 +908,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>                          * default mmap base, as well as whatever program
> they
>                          * might try to exec.  This is because the brk will
>                          * follow the loader, and is not movable.  */
> -#ifdef CONFIG_ARCH_BINFMT_ELF_RANDOMIZE_PIE
> -                       /* Memory randomization might have been switched off
> -                        * in runtime via sysctl or explicit setting of
> -                        * personality flags.
> -                        * If that is the case, retain the original non-zero
> -                        * load_bias value in order to establish proper
> -                        * non-randomized mappings.
> -                        */
> -                       if (current->flags & PF_RANDOMIZE)
> -                               load_bias = 0;
> -                       else
> -                               load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE -
> vaddr);
> -#else
>                         load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
> -#endif
>                 }
>
>                 error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,

I think this is much cleaner now without
ARCH_BINFMT_ELF_RANDOMIZE_PIE. I imagine there could be some follow-up
cleanups to standardize (or at least clearly document) the intended
levels of entropy in the 4 ASLR regions on each architecture, as it
currently varies a bit.

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
