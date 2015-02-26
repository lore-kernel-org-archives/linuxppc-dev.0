Return-Path: <keescook@google.com>
Received: from mail-ob0-x232.google.com (mail-ob0-x232.google.com
 [IPv6:2607:f8b0:4003:c01::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2DE71A0052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 10:34:39 +1100 (AEDT)
Received: by mail-ob0-f178.google.com with SMTP id uz6so14967755obc.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 15:34:36 -0800 (PST)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
References: <54EB735F.5030207@upv.es>
 <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
 <20150223205436.15133mg1kpyojyik@webmail.upv.es>
 <20150224073906.GA16422@gmail.com>
 <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
Date: Thu, 26 Feb 2015 15:34:36 -0800
Message-ID: <CAGXu5jJ8UM5J58CpBwP=+kHi9td0mKP0SV36HjpckEjxCzm45g@mail.gmail.com>
Subject: Re: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 "x86@kernel.org" <x86@kernel.org>, Hector Marco Gisbert <hecmargi@upv.es>,
 LKML <linux-kernel@vger.kernel.org>, ismael Ripoll <iripoll@upv.es>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 26, 2015 at 2:38 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 24 Feb 2015 08:39:06 +0100 Ingo Molnar <mingo@kernel.org> wrote:
>
>>
>> * Hector Marco Gisbert <hecmargi@upv.es> wrote:
>>
>> > +unsigned long randomize_et_dyn(unsigned long base)
>> > +{
>> > +   unsigned long ret;
>> > +   if ((current->personality & ADDR_NO_RANDOMIZE) ||
>> > +           !(current->flags & PF_RANDOMIZE))
>> > +           return base;
>> > +   ret = base + mmap_rnd();
>> > +   return (ret > base) ? ret : base;
>> > +}
>>
>> > +unsigned long randomize_et_dyn(unsigned long base)
>> > +{
>> > +   unsigned long ret;
>> > +   if ((current->personality & ADDR_NO_RANDOMIZE) ||
>> > +           !(current->flags & PF_RANDOMIZE))
>> > +           return base;
>> > +   ret = base + mmap_rnd();
>> > +   return (ret > base) ? ret : base;
>> > +}
>>
>> > +unsigned long randomize_et_dyn(unsigned long base)
>> > +{
>> > +   unsigned long ret;
>> > +   if ((current->personality & ADDR_NO_RANDOMIZE) ||
>> > +           !(current->flags & PF_RANDOMIZE))
>> > +           return base;
>> > +   ret = base + brk_rnd();
>> > +   return (ret > base) ? ret : base;
>> > +}
>>
>> > +unsigned long randomize_et_dyn(unsigned long base)
>> > +{
>> > +   unsigned long ret;
>> > +   if ((current->personality & ADDR_NO_RANDOMIZE) ||
>> > +           !(current->flags & PF_RANDOMIZE))
>> > +           return base;
>> > +   ret = base + mmap_rnd();
>> > +   return (ret > base) ? ret : base;
>> > +}
>>
>> > +unsigned long randomize_et_dyn(unsigned long base)
>> > +{
>> > +   unsigned long ret;
>> > +   if ((current->personality & ADDR_NO_RANDOMIZE) ||
>> > +           !(current->flags & PF_RANDOMIZE))
>> > +           return base;
>> > +   ret = base + mmap_rnd();
>> > +   return (ret > base) ? ret : base;
>> > +}
>>
>> That pointless repetition should be avoided.
>
> That's surprisingly hard!
>
> After renaming mips brk_rnd() to mmap_rnd() I had a shot.  I'm not very
> confident in the result.  Does that __weak trick even work?

In theory, it shouldn't be needed since only randomize_et_dyn will
call mmap_rnd, and only architectures that use randomize_et_dyn will
call it ... and will define mmap_rnd.

>
> Someone tell me how important Hector's patch is?

I consider it a reasonable improvement to userspace ASLR. I look at it
more as a new feature than a bug fix, but it could be argued as a bug
fix too.

>
>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
>
> Consolidate randomize_et_dyn() implementations into fs/binfmt_elf.c.
>
> There doesn't seem to be a compile-time way of making randomize_et_dyn()
> go away on architectures which don't need it, so mark it __weak to cause
> it to be discarded at link time.
>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Hector Marco Gisbert <hecmargi@upv.es>
> Cc: Hector Marco-Gisbert <hecmargi@upv.es>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Ismael Ripoll <iripoll@upv.es>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Russell King <rmk@arm.linux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Kees Cook <keescook@chromium.org>

Thanks for fixing it up!

-Kees

> ---
>
>  arch/arm/include/asm/elf.h        |    3 +--
>  arch/arm/mm/mmap.c                |   13 ++-----------
>  arch/arm64/Kconfig                |    2 +-
>  arch/arm64/include/asm/elf.h      |    3 +--
>  arch/arm64/mm/mmap.c              |   14 ++------------
>  arch/mips/include/asm/elf.h       |    1 -
>  arch/mips/mm/mmap.c               |   13 ++-----------
>  arch/powerpc/include/asm/elf.h    |    2 --
>  arch/powerpc/mm/mmap.c            |   13 ++-----------
>  arch/x86/include/asm/elf.h        |    2 --
>  arch/x86/mm/mmap.c                |   12 ++----------
>  fs/binfmt_elf.c                   |   21 +++++++++++++++++++++
>  include/linux/elf-randomization.h |    7 +++++++
>  13 files changed, 41 insertions(+), 65 deletions(-)
>
> diff -puN arch/arm/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/arm/Kconfig
> diff -puN arch/arm/include/asm/elf.h~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/arm/include/asm/elf.h
> --- a/arch/arm/include/asm/elf.h~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> +++ a/arch/arm/include/asm/elf.h
> @@ -2,7 +2,7 @@
>  #define __ASMARM_ELF_H
>
>  #include <asm/hwcap.h>
> -
> +#include <linux/elf-randomization.h>
>  /*
>   * ELF register definitions..
>   */
> @@ -115,7 +115,6 @@ int dump_task_regs(struct task_struct *t
>     the loader.  We need to make sure that it is out of the way of the program
>     that it will "exec", and that there is sufficient room for the brk.  */
>
> -extern unsigned long randomize_et_dyn(unsigned long base);
>  #define ELF_ET_DYN_BASE        (randomize_et_dyn(2 * TASK_SIZE / 3))
>
>  /* When the program starts, a1 contains a pointer to a function to be
> diff -puN arch/arm/mm/mmap.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/arm/mm/mmap.c
> --- a/arch/arm/mm/mmap.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> +++ a/arch/arm/mm/mmap.c
> @@ -7,6 +7,7 @@
>  #include <linux/shm.h>
>  #include <linux/sched.h>
>  #include <linux/io.h>
> +#include <linux/elf-randomization.h>
>  #include <linux/personality.h>
>  #include <linux/random.h>
>  #include <asm/cachetype.h>
> @@ -30,7 +31,7 @@ static int mmap_is_legacy(void)
>         return sysctl_legacy_va_layout;
>  }
>
> -static unsigned long mmap_rnd(void)
> +unsigned long mmap_rnd(void)
>  {
>         unsigned long rnd = 0;
>
> @@ -241,13 +242,3 @@ int devmem_is_allowed(unsigned long pfn)
>  }
>
>  #endif
> -
> -unsigned long randomize_et_dyn(unsigned long base)
> -{
> -       unsigned long ret;
> -       if ((current->personality & ADDR_NO_RANDOMIZE) ||
> -               !(current->flags & PF_RANDOMIZE))
> -               return base;
> -       ret = base + mmap_rnd();
> -       return (ret > base) ? ret : base;
> -}
> diff -puN arch/arm64/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/arm64/Kconfig
> --- a/arch/arm64/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> +++ a/arch/arm64/Kconfig
> @@ -1,4 +1,4 @@
> -config ARM64
> +qconfig ARM64
>         def_bool y
>         select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>         select ARCH_HAS_GCOV_PROFILE_ALL
> diff -puN arch/arm64/include/asm/elf.h~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/arm64/include/asm/elf.h
> --- a/arch/arm64/include/asm/elf.h~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> +++ a/arch/arm64/include/asm/elf.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2012 ARM Ltd.
> + * Copyright (C) 20q12 ARM Ltd.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -125,7 +125,6 @@ typedef struct user_fpsimd_state elf_fpr
>   * the loader.  We need to make sure that it is out of the way of the program
>   * that it will "exec", and that there is sufficient room for the brk.
>   */
> -extern unsigned long randomize_et_dyn(unsigned long base);
>  #define ELF_ET_DYN_BASE        (randomize_et_dyn(2 * TASK_SIZE_64 / 3))
>
>  /*
> diff -puN arch/arm64/mm/mmap.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/arm64/mm/mmap.c
> --- a/arch/arm64/mm/mmap.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> +++ a/arch/arm64/mm/mmap.c
> @@ -17,6 +17,7 @@
>   */
>
>  #include <linux/elf.h>
> +#include <linux/elf-randomization.h>
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/mman.h>
> @@ -47,7 +48,7 @@ static int mmap_is_legacy(void)
>         return sysctl_legacy_va_layout;
>  }
>
> -static unsigned long mmap_rnd(void)
> +unsigned long mmap_rnd(void)
>  {
>         unsigned long rnd = 0;
>
> @@ -89,17 +90,6 @@ void arch_pick_mmap_layout(struct mm_str
>  }
>  EXPORT_SYMBOL_GPL(arch_pick_mmap_layout);
>
> -unsigned long randomize_et_dyn(unsigned long base)
> -{
> -       unsigned long ret;
> -       if ((current->personality & ADDR_NO_RANDOMIZE) ||
> -               !(current->flags & PF_RANDOMIZE))
> -               return base;
> -       ret = base + mmap_rnd();
> -       return (ret > base) ? ret : base;
> -}
> -
> -
>  /*
>   * You really shouldn't be using read() or write() on /dev/mem.  This might go
>   * away in the future.
> diff -puN arch/mips/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/mips/Kconfig
> diff -puN arch/mips/include/asm/elf.h~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/mips/include/asm/elf.h
> --- a/arch/mips/include/asm/elf.h~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> +++ a/arch/mips/include/asm/elf.h
> @@ -402,7 +402,6 @@ extern const char *__elf_platform;
>     that it will "exec", and that there is sufficient room for the brk. */
>
>  #ifndef ELF_ET_DYN_BASE
> -extern unsigned long randomize_et_dyn(unsigned long base);
>  #define ELF_ET_DYN_BASE                (randomize_et_dyn(TASK_SIZE / 3 * 2))
>  #endif
>
> diff -puN arch/mips/mm/mmap.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/mips/mm/mmap.c
> --- a/arch/mips/mm/mmap.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> +++ a/arch/mips/mm/mmap.c
> @@ -9,6 +9,7 @@
>  #include <linux/compiler.h>
>  #include <linux/errno.h>
>  #include <linux/mm.h>
> +#include <linux/elf-randomization.h>
>  #include <linux/mman.h>
>  #include <linux/module.h>
>  #include <linux/personality.h>
> @@ -164,7 +165,7 @@ void arch_pick_mmap_layout(struct mm_str
>         }
>  }
>
> -static inline unsigned long mmap_rnd(void)
> +unsigned long mmap_rnd(void)
>  {
>         unsigned long rnd = get_random_int();
>
> @@ -196,13 +197,3 @@ int __virt_addr_valid(const volatile voi
>         return pfn_valid(PFN_DOWN(virt_to_phys(kaddr)));
>  }
>  EXPORT_SYMBOL_GPL(__virt_addr_valid);
> -
> -unsigned long randomize_et_dyn(unsigned long base)
> -{
> -       unsigned long ret;
> -       if ((current->personality & ADDR_NO_RANDOMIZE) ||
> -               !(current->flags & PF_RANDOMIZE))
> -               return base;
> -       ret = base + brk_rnd();
> -       return (ret > base) ? ret : base;
> -}
> diff -puN arch/powerpc/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/powerpc/Kconfig
> diff -puN arch/powerpc/include/asm/elf.h~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/powerpc/include/asm/elf.h
> --- a/arch/powerpc/include/asm/elf.h~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> +++ a/arch/powerpc/include/asm/elf.h
> @@ -27,8 +27,6 @@
>     use of this is to invoke "./ld.so someprog" to test out a new version of
>     the loader.  We need to make sure that it is out of the way of the program
>     that it will "exec", and that there is sufficient room for the brk.  */
> -
> -extern unsigned long randomize_et_dyn(unsigned long base);
>  #define ELF_ET_DYN_BASE        (randomize_et_dyn(0x20000000))
>
>  #define ELF_CORE_EFLAGS (is_elf2_task() ? 2 : 0)
> diff -puN arch/powerpc/mm/mmap.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/powerpc/mm/mmap.c
> --- a/arch/powerpc/mm/mmap.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> +++ a/arch/powerpc/mm/mmap.c
> @@ -24,6 +24,7 @@
>
>  #include <linux/personality.h>
>  #include <linux/mm.h>
> +#include <linux/elf-randomization.h>
>  #include <linux/random.h>
>  #include <linux/sched.h>
>
> @@ -53,7 +54,7 @@ static inline int mmap_is_legacy(void)
>         return sysctl_legacy_va_layout;
>  }
>
> -static unsigned long mmap_rnd(void)
> +unsigned long mmap_rnd(void)
>  {
>         unsigned long rnd = 0;
>
> @@ -97,13 +98,3 @@ void arch_pick_mmap_layout(struct mm_str
>                 mm->get_unmapped_area = arch_get_unmapped_area_topdown;
>         }
>  }
> -
> -unsigned long randomize_et_dyn(unsigned long base)
> -{
> -       unsigned long ret;
> -       if ((current->personality & ADDR_NO_RANDOMIZE) ||
> -               !(current->flags & PF_RANDOMIZE))
> -               return base;
> -       ret = base + mmap_rnd();
> -       return (ret > base) ? ret : base;
> -}
> diff -puN arch/x86/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/x86/Kconfig
> diff -puN arch/x86/include/asm/elf.h~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/x86/include/asm/elf.h
> --- a/arch/x86/include/asm/elf.h~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> +++ a/arch/x86/include/asm/elf.h
> @@ -248,8 +248,6 @@ extern int force_personality32;
>     use of this is to invoke "./ld.so someprog" to test out a new version of
>     the loader.  We need to make sure that it is out of the way of the program
>     that it will "exec", and that there is sufficient room for the brk.  */
> -
> -extern unsigned long randomize_et_dyn(unsigned long base);
>  #define ELF_ET_DYN_BASE                (randomize_et_dyn(TASK_SIZE / 3 * 2))
>
>  /* This yields a mask that user programs can use to figure out what
> diff -puN arch/x86/mm/mmap.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/x86/mm/mmap.c
> --- a/arch/x86/mm/mmap.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> +++ a/arch/x86/mm/mmap.c
> @@ -29,6 +29,7 @@
>  #include <linux/random.h>
>  #include <linux/limits.h>
>  #include <linux/sched.h>
> +#include <linux/elf-randomization.h>
>  #include <asm/elf.h>
>
>  struct va_alignment __read_mostly va_align = {
> @@ -65,7 +66,7 @@ static int mmap_is_legacy(void)
>         return sysctl_legacy_va_layout;
>  }
>
> -static unsigned long mmap_rnd(void)
> +unsigned long mmap_rnd(void)
>  {
>         unsigned long rnd = 0;
>
> @@ -122,12 +123,3 @@ void arch_pick_mmap_layout(struct mm_str
>                 mm->get_unmapped_area = arch_get_unmapped_area_topdown;
>         }
>  }
> -unsigned long randomize_et_dyn(unsigned long base)
> -{
> -       unsigned long ret;
> -       if ((current->personality & ADDR_NO_RANDOMIZE) ||
> -               !(current->flags & PF_RANDOMIZE))
> -               return base;
> -       ret = base + mmap_rnd();
> -       return (ret > base) ? ret : base;
> -}
> diff -puN fs/Kconfig.binfmt~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix fs/Kconfig.binfmt
> diff -puN fs/binfmt_elf.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix fs/binfmt_elf.c
> --- a/fs/binfmt_elf.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> +++ a/fs/binfmt_elf.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/personality.h>
>  #include <linux/elfcore.h>
> +#include <linux/elf-randomization.h>
>  #include <linux/init.h>
>  #include <linux/highuid.h>
>  #include <linux/compiler.h>
> @@ -2300,6 +2301,26 @@ out:
>
>  #endif         /* CONFIG_ELF_CORE */
>
> +/* Not all architectures implement mmap_rnd() */
> +unsigned long __weak mmap_rnd(void)
> +{
> +}
> +
> +/*
> + * Not all architectures use randomize_et_dyn(), so use __weak to let the
> + * linker omit it from vmlinux
> + */
> +unsigned long __weak randomize_et_dyn(unsigned long base)
> +{
> +       unsigned long ret;
> +
> +       if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +               !(current->flags & PF_RANDOMIZE))
> +               return base;
> +       ret = base + mmap_rnd();
> +       return max(ret, base);
> +}
> +
>  static int __init init_elf_binfmt(void)
>  {
>         register_binfmt(&elf_format);
> diff -puN include/linux/elf.h~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix include/linux/elf.h
> diff -puN /dev/null include/linux/elf-randomization.h
> --- /dev/null
> +++ a/include/linux/elf-randomization.h
> @@ -0,0 +1,7 @@
> +#ifndef __ELF_RANDOMIZATION_H
> +#define __ELF_RANDOMIZATION_H
> +
> +unsigned long randomize_et_dyn(unsigned long base);
> +unsigned long mmap_rnd(void);
> +
> +#endif /* __ELF_RANDOMIZATION_H */
> _
>



-- 
Kees Cook
Chrome OS Security
