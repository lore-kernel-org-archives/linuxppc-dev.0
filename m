Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F59C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:30:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9199D21916
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="R6QmViST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9199D21916
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4415zz41DPzDqBl
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 19:30:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::144; helo=mail-it1-x144.google.com;
 envelope-from=dvyukov@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="R6QmViST"; 
 dkim-atps=neutral
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4415yD0l7ZzDqB3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 19:28:51 +1100 (AEDT)
Received: by mail-it1-x144.google.com with SMTP id z7so22331835iti.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 00:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aOVlIgLRRp8+76K8+1nXkBL99MeFkOOhRb4568jM7hQ=;
 b=R6QmViSTqDsGEn3dFfycn27WYU8MlE7oATrHJ61q+JUqhMzwvXuDTPT/Pt1QzdIFEi
 yLLwpges2MIvmsFx1REWNfVJcNh7ti4kHB3nYzWh6aLMPmjtGMoTgioEKNAtIu89kStu
 I2SbWCs03JlSDD09hoL1ddeo4QR/OgwCYoYJ2Xp+upEMiHBh2K4oW4HFCT6G1A0qA7sq
 Yj1iiHmi/KltZQUQaLLI702y/iBA//OfgASs8rQtAXtbLnkvpfRz1oAUke0WnsUk4UhA
 pxqU1u8YyMfGSLbVbgmBnTq6KtOOHzWq/UU+pmQFcVHVVRcZ9r1/l9/utJdi+VU2L8Je
 giMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aOVlIgLRRp8+76K8+1nXkBL99MeFkOOhRb4568jM7hQ=;
 b=gUlEnsIHjz0YDAuiK6x4uVFpY0mZIuyTVSNP9/KqPwwOK3GalCdEaVx6KQWa3HzWWB
 bwbQaOBw3+FtcIHlBChjGQ64f1vEtSG5AmtFewzvu4N7iX3eJJWaCC7g6qvf80YiJY50
 h146KcRAOyqgH/g29sV8QsFjjbWzyfJKmyPWWHHVgsNamRKKmyyTUngSULtZgDP8nZyX
 zA3gT02J/hMhhjxvXrdsEQ3UmmKBeqLPm2OVfAtrQCp32423W+cV04Lyc75azC/Re1uP
 XOHM/X1ZO+/pEbM0K/VmgMZg0FjL6csKjMyeYiEyeuGelVblnJ5JhLuT9JUowBxnHHTW
 Kzog==
X-Gm-Message-State: AHQUAuZaXm4gqEOyiKmLoEwkS3cXlmd0fcJ3bPEH25DQmzr1bLOjBfS0
 jcjmqC/Z5isKVjIcDS03t3JXR1Lh6YvzKtG94vowCw==
X-Google-Smtp-Source: AHgI3IbBayuLZbHwoTO/3c94LAx6elJoLEbBchsOtwAb8E7jJlLJIFbNZA1yxb8HSDcWn5GAH4HnJHaqU3UGdMzeZlg=
X-Received: by 2002:a24:7351:: with SMTP id y78mr4285831itb.12.1550219329756; 
 Fri, 15 Feb 2019 00:28:49 -0800 (PST)
MIME-Version: 1.0
References: <20190215000441.14323-1-dja@axtens.net>
 <20190215000441.14323-6-dja@axtens.net>
In-Reply-To: <20190215000441.14323-6-dja@axtens.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 15 Feb 2019 09:28:38 +0100
Message-ID: <CACT4Y+ZmVs+n7xUeQvZO7Pjabg0LtgzhU=s6CPkeMrs9MV1wwA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] powerpc: KASAN for 64bit Book3E
To: Daniel Axtens <dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 kasan-dev <kasan-dev@googlegroups.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 15, 2019 at 1:05 AM Daniel Axtens <dja@axtens.net> wrote:
>
> Wire up KASAN. Only outline instrumentation is supported.
>
> The KASAN shadow area is mapped into vmemmap space:
> 0x8000 0400 0000 0000 to 0x8000 0600 0000 0000.
> To do this we require that vmemmap be disabled. (This is the default
> in the kernel config that QorIQ provides for the machine in their
> SDK anyway - they use flat memory.)
>
> Only the kernel linear mapping (0xc000...) is checked. The vmalloc and
> ioremap areas (also in 0x800...) are all mapped to a zero page. As
> with the Book3S hash series, this requires overriding the memory <->
> shadow mapping.
>
> Also, as with both previous 64-bit series, early instrumentation is not
> supported.  It would allow us to drop the check_return_arch_not_ready()
> hook in the KASAN core, but it's tricky to get it set up early enough:
> we need it setup before the first call to instrumented code like printk().
> Perhaps in the future.
>
> Only KASAN_MINIMAL works.
>
> Lightly tested on e6500. KVM, kexec and xmon have not been tested.

Hi Daniel,

This is great!

Not related to the patch, but if you booted a real devices and used it
to some degree, I wonder if you hit any KASAN reports?

Thanks

> The test_kasan module fires warnings as expected, except for the
> following tests:
>
>  - Expected/by design:
> kasan test: memcg_accounted_kmem_cache allocate memcg accounted object
>
>  - Due to only supporting KASAN_MINIMAL:
> kasan test: kasan_stack_oob out-of-bounds on stack
> kasan test: kasan_global_oob out-of-bounds global variable
> kasan test: kasan_alloca_oob_left out-of-bounds to left on alloca
> kasan test: kasan_alloca_oob_right out-of-bounds to right on alloca
> kasan test: use_after_scope_test use-after-scope on int
> kasan test: use_after_scope_test use-after-scope on array
>
> Thanks to those who have done the heavy lifting over the past several years:
>  - Christophe's 32 bit series: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-February/185379.html
>  - Aneesh's Book3S hash series: https://lwn.net/Articles/655642/
>  - Balbir's Book3S radix series: https://patchwork.ozlabs.org/patch/795211/
>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
>
> ---
>
> While useful if you have a book3e device, this is mostly intended
> as a warm-up exercise for reviving Aneesh's series for book3s hash.
> In particular, changes to the kasan core are going to be required
> for hash and radix as well.
> ---
>  arch/powerpc/Kconfig                         |  1 +
>  arch/powerpc/Makefile                        |  2 +
>  arch/powerpc/include/asm/kasan.h             | 77 ++++++++++++++++++--
>  arch/powerpc/include/asm/ppc_asm.h           |  7 ++
>  arch/powerpc/include/asm/string.h            |  7 +-
>  arch/powerpc/lib/mem_64.S                    |  6 +-
>  arch/powerpc/lib/memcmp_64.S                 |  5 +-
>  arch/powerpc/lib/memcpy_64.S                 |  3 +-
>  arch/powerpc/lib/string.S                    | 15 ++--
>  arch/powerpc/mm/Makefile                     |  2 +
>  arch/powerpc/mm/kasan/Makefile               |  1 +
>  arch/powerpc/mm/kasan/kasan_init_book3e_64.c | 53 ++++++++++++++
>  arch/powerpc/purgatory/Makefile              |  3 +
>  arch/powerpc/xmon/Makefile                   |  1 +
>  14 files changed, 164 insertions(+), 19 deletions(-)
>  create mode 100644 arch/powerpc/mm/kasan/kasan_init_book3e_64.c
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 850b06def84f..2c7c20d52778 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -176,6 +176,7 @@ config PPC
>         select HAVE_ARCH_AUDITSYSCALL
>         select HAVE_ARCH_JUMP_LABEL
>         select HAVE_ARCH_KASAN                  if PPC32
> +       select HAVE_ARCH_KASAN                  if PPC_BOOK3E_64 && !SPARSEMEM_VMEMMAP
>         select HAVE_ARCH_KGDB
>         select HAVE_ARCH_MMAP_RND_BITS
>         select HAVE_ARCH_MMAP_RND_COMPAT_BITS   if COMPAT
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index f0738099e31e..21c2dadf0315 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -428,11 +428,13 @@ endif
>  endif
>
>  ifdef CONFIG_KASAN
> +ifdef CONFIG_PPC32
>  prepare: kasan_prepare
>
>  kasan_prepare: prepare0
>         $(eval KASAN_SHADOW_OFFSET = $(shell awk '{if ($$2 == "KASAN_SHADOW_OFFSET") print $$3;}' include/generated/asm-offsets.h))
>  endif
> +endif
>
>  # Check toolchain versions:
>  # - gcc-4.6 is the minimum kernel-wide version so nothing required.
> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
> index 5d0088429b62..c2f6f05dfaa3 100644
> --- a/arch/powerpc/include/asm/kasan.h
> +++ b/arch/powerpc/include/asm/kasan.h
> @@ -5,20 +5,85 @@
>  #ifndef __ASSEMBLY__
>
>  #include <asm/page.h>
> +#include <asm/pgtable.h>
>  #include <asm/pgtable-types.h>
> -#include <asm/fixmap.h>
>
>  #define KASAN_SHADOW_SCALE_SHIFT       3
> -#define KASAN_SHADOW_SIZE      ((~0UL - PAGE_OFFSET + 1) >> KASAN_SHADOW_SCALE_SHIFT)
>
> -#define KASAN_SHADOW_START     (ALIGN_DOWN(FIXADDR_START - KASAN_SHADOW_SIZE, \
> -                                           PGDIR_SIZE))
> -#define KASAN_SHADOW_END       (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
>  #define KASAN_SHADOW_OFFSET    (KASAN_SHADOW_START - \
>                                  (PAGE_OFFSET >> KASAN_SHADOW_SCALE_SHIFT))
> +#define KASAN_SHADOW_END       (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
> +
> +
> +#ifdef CONFIG_PPC32
> +#include <asm/fixmap.h>
> +#define KASAN_SHADOW_START     (ALIGN_DOWN(FIXADDR_START - KASAN_SHADOW_SIZE, \
> +                                           PGDIR_SIZE))
> +#define KASAN_SHADOW_SIZE      ((~0UL - PAGE_OFFSET + 1) >> KASAN_SHADOW_SCALE_SHIFT)
>
>  void kasan_early_init(void);
> +
> +#endif /* CONFIG_PPC32 */
> +
> +#ifdef CONFIG_PPC_BOOK3E_64
> +#define KASAN_SHADOW_START VMEMMAP_BASE
> +#define KASAN_SHADOW_SIZE      (KERN_VIRT_SIZE >> KASAN_SHADOW_SCALE_SHIFT)
> +
> +extern struct static_key_false powerpc_kasan_enabled_key;
> +#define check_return_arch_not_ready() \
> +       do {                                                            \
> +               if (!static_branch_likely(&powerpc_kasan_enabled_key))  \
> +                       return;                                         \
> +       } while (0)
> +
> +extern unsigned char kasan_zero_page[PAGE_SIZE];
> +static inline void *kasan_mem_to_shadow_book3e(const void *addr)
> +{
> +       if ((unsigned long)addr >= KERN_VIRT_START &&
> +               (unsigned long)addr < (KERN_VIRT_START + KERN_VIRT_SIZE)) {
> +               return (void *)kasan_zero_page;
> +       }
> +
> +       return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
> +               + KASAN_SHADOW_OFFSET;
> +}
> +#define kasan_mem_to_shadow kasan_mem_to_shadow_book3e
> +
> +static inline void *kasan_shadow_to_mem_book3e(const void *shadow_addr)
> +{
> +       /*
> +        * We map the entire non-linear virtual mapping onto the zero page so if
> +        * we are asked to map the zero page back just pick the beginning of that
> +        * area.
> +        */
> +       if (shadow_addr >= (void *)kasan_zero_page &&
> +               shadow_addr < (void *)(kasan_zero_page + PAGE_SIZE)) {
> +               return (void *)KERN_VIRT_START;
> +       }
> +
> +       return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET)
> +               << KASAN_SHADOW_SCALE_SHIFT);
> +}
> +#define kasan_shadow_to_mem kasan_shadow_to_mem_book3e
> +
> +static inline bool kasan_addr_has_shadow_book3e(const void *addr)
> +{
> +       /*
> +        * We want to specifically assert that the addresses in the 0x8000...
> +        * region have a shadow, otherwise they are considered by the kasan
> +        * core to be wild pointers
> +        */
> +       if ((unsigned long)addr >= KERN_VIRT_START &&
> +               (unsigned long)addr < (KERN_VIRT_START + KERN_VIRT_SIZE)) {
> +               return true;
> +       }
> +       return (addr >= kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
> +}
> +#define kasan_addr_has_shadow kasan_addr_has_shadow_book3e
> +
> +#endif /* CONFIG_PPC_BOOK3E_64 */
> +
>  void kasan_init(void);
>
> -#endif
> +#endif /* CONFIG_KASAN */
>  #endif
> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
> index dba2c1038363..fd7c9fa9d307 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -251,10 +251,17 @@ GLUE(.,name):
>
>  #define _GLOBAL_TOC(name) _GLOBAL(name)
>
> +#endif /* 32-bit */
> +
> +/* KASAN helpers */
>  #define KASAN_OVERRIDE(x, y) \
>         .weak x;             \
>         .set x, y
>
> +#ifdef CONFIG_KASAN
> +#define EXPORT_SYMBOL_NOKASAN(x)
> +#else
> +#define EXPORT_SYMBOL_NOKASAN(x) EXPORT_SYMBOL(x)
>  #endif
>
>  /*
> diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
> index 64d44d4836b4..e2801d517d57 100644
> --- a/arch/powerpc/include/asm/string.h
> +++ b/arch/powerpc/include/asm/string.h
> @@ -4,13 +4,16 @@
>
>  #ifdef __KERNEL__
>
> +#ifndef CONFIG_KASAN
>  #define __HAVE_ARCH_STRNCPY
>  #define __HAVE_ARCH_STRNCMP
> +#define __HAVE_ARCH_MEMCHR
> +#define __HAVE_ARCH_MEMCMP
> +#endif
> +
>  #define __HAVE_ARCH_MEMSET
>  #define __HAVE_ARCH_MEMCPY
>  #define __HAVE_ARCH_MEMMOVE
> -#define __HAVE_ARCH_MEMCMP
> -#define __HAVE_ARCH_MEMCHR
>  #define __HAVE_ARCH_MEMSET16
>  #define __HAVE_ARCH_MEMCPY_FLUSHCACHE
>
> diff --git a/arch/powerpc/lib/mem_64.S b/arch/powerpc/lib/mem_64.S
> index 3c3be02f33b7..3ff4c6b45505 100644
> --- a/arch/powerpc/lib/mem_64.S
> +++ b/arch/powerpc/lib/mem_64.S
> @@ -30,7 +30,8 @@ EXPORT_SYMBOL(__memset16)
>  EXPORT_SYMBOL(__memset32)
>  EXPORT_SYMBOL(__memset64)
>
> -_GLOBAL(memset)
> +_GLOBAL(__memset)
> +KASAN_OVERRIDE(memset, __memset)
>         neg     r0,r3
>         rlwimi  r4,r4,8,16,23
>         andi.   r0,r0,7                 /* # bytes to be 8-byte aligned */
> @@ -97,7 +98,8 @@ _GLOBAL(memset)
>         blr
>  EXPORT_SYMBOL(memset)
>
> -_GLOBAL_TOC(memmove)
> +_GLOBAL_TOC(__memmove)
> +KASAN_OVERRIDE(memmove, __memmove)
>         cmplw   0,r3,r4
>         bgt     backwards_memcpy
>         b       memcpy
> diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
> index 844d8e774492..21aee60de2cd 100644
> --- a/arch/powerpc/lib/memcmp_64.S
> +++ b/arch/powerpc/lib/memcmp_64.S
> @@ -102,7 +102,8 @@
>   * 2) src/dst has different offset to the 8 bytes boundary. The handlers
>   * are named like .Ldiffoffset_xxxx
>   */
> -_GLOBAL_TOC(memcmp)
> +_GLOBAL_TOC(__memcmp)
> +KASAN_OVERRIDE(memcmp, __memcmp)
>         cmpdi   cr1,r5,0
>
>         /* Use the short loop if the src/dst addresses are not
> @@ -630,4 +631,4 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>         b       .Lcmp_lt32bytes
>
>  #endif
> -EXPORT_SYMBOL(memcmp)
> +EXPORT_SYMBOL_NOKASAN(memcmp)
> diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
> index 273ea67e60a1..e9092a0e531a 100644
> --- a/arch/powerpc/lib/memcpy_64.S
> +++ b/arch/powerpc/lib/memcpy_64.S
> @@ -18,7 +18,8 @@
>  #endif
>
>         .align  7
> -_GLOBAL_TOC(memcpy)
> +_GLOBAL_TOC(__memcpy)
> +KASAN_OVERRIDE(memcpy, __memcpy)
>  BEGIN_FTR_SECTION
>  #ifdef __LITTLE_ENDIAN__
>         cmpdi   cr7,r5,0
> diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
> index 4b41970e9ed8..09deaac6e5f1 100644
> --- a/arch/powerpc/lib/string.S
> +++ b/arch/powerpc/lib/string.S
> @@ -16,7 +16,8 @@
>
>  /* This clears out any unused part of the destination buffer,
>     just as the libc version does.  -- paulus */
> -_GLOBAL(strncpy)
> +_GLOBAL(__strncpy)
> +KASAN_OVERRIDE(strncpy, __strncpy)
>         PPC_LCMPI 0,r5,0
>         beqlr
>         mtctr   r5
> @@ -34,9 +35,10 @@ _GLOBAL(strncpy)
>  2:     stbu    r0,1(r6)        /* clear it out if so */
>         bdnz    2b
>         blr
> -EXPORT_SYMBOL(strncpy)
> +EXPORT_SYMBOL_NOKASAN(strncpy)
>
> -_GLOBAL(strncmp)
> +_GLOBAL(__strncmp)
> +KASAN_OVERRIDE(strncmp, __strncmp)
>         PPC_LCMPI 0,r5,0
>         beq-    2f
>         mtctr   r5
> @@ -52,9 +54,10 @@ _GLOBAL(strncmp)
>         blr
>  2:     li      r3,0
>         blr
> -EXPORT_SYMBOL(strncmp)
> +EXPORT_SYMBOL_NOKASAN(strncmp)
>
> -_GLOBAL(memchr)
> +_GLOBAL(__memchr)
> +KASAN_OVERRIDE(memchr, __memchr)
>         PPC_LCMPI 0,r5,0
>         beq-    2f
>         mtctr   r5
> @@ -66,4 +69,4 @@ _GLOBAL(memchr)
>         beqlr
>  2:     li      r3,0
>         blr
> -EXPORT_SYMBOL(memchr)
> +EXPORT_SYMBOL_NOKASAN(memchr)
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index 457c0ea2b5e7..d974f7bcb177 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -7,6 +7,8 @@ ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
>
>  CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
>
> +KASAN_SANITIZE_fsl_booke_mmu.o := n
> +
>  obj-y                          := fault.o mem.o pgtable.o mmap.o \
>                                    init_$(BITS).o pgtable_$(BITS).o \
>                                    init-common.o mmu_context.o drmem.o
> diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
> index 6577897673dd..f8f164ad8ade 100644
> --- a/arch/powerpc/mm/kasan/Makefile
> +++ b/arch/powerpc/mm/kasan/Makefile
> @@ -3,3 +3,4 @@
>  KASAN_SANITIZE := n
>
>  obj-$(CONFIG_PPC32)           += kasan_init_32.o
> +obj-$(CONFIG_PPC_BOOK3E_64)   += kasan_init_book3e_64.o
> diff --git a/arch/powerpc/mm/kasan/kasan_init_book3e_64.c b/arch/powerpc/mm/kasan/kasan_init_book3e_64.c
> new file mode 100644
> index 000000000000..93b9afcf1020
> --- /dev/null
> +++ b/arch/powerpc/mm/kasan/kasan_init_book3e_64.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define DISABLE_BRANCH_PROFILING
> +
> +#include <linux/kasan.h>
> +#include <linux/printk.h>
> +#include <linux/memblock.h>
> +#include <linux/sched/task.h>
> +#include <asm/pgalloc.h>
> +
> +DEFINE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
> +EXPORT_SYMBOL(powerpc_kasan_enabled_key);
> +unsigned char kasan_zero_page[PAGE_SIZE] __page_aligned_bss;
> +
> +static void __init kasan_init_region(struct memblock_region *reg)
> +{
> +       void *start = __va(reg->base);
> +       void *end = __va(reg->base + reg->size);
> +       unsigned long k_start, k_end, k_cur;
> +
> +       if (start >= end)
> +               return;
> +
> +       k_start = (unsigned long)kasan_mem_to_shadow(start);
> +       k_end = (unsigned long)kasan_mem_to_shadow(end);
> +
> +       for (k_cur = k_start; k_cur < k_end; k_cur += PAGE_SIZE) {
> +               void *va = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +               map_kernel_page(k_cur, __pa(va), PAGE_KERNEL);
> +       }
> +       flush_tlb_kernel_range(k_start, k_end);
> +}
> +
> +void __init kasan_init(void)
> +{
> +       struct memblock_region *reg;
> +
> +       for_each_memblock(memory, reg)
> +               kasan_init_region(reg);
> +
> +       /* map the zero page RO */
> +       map_kernel_page((unsigned long)kasan_zero_page,
> +                                       __pa(kasan_zero_page), PAGE_KERNEL_RO);
> +
> +       kasan_init_tags();
> +
> +       /* Turn on checking */
> +       static_branch_inc(&powerpc_kasan_enabled_key);
> +
> +       /* Enable error messages */
> +       init_task.kasan_depth = 0;
> +       pr_info("KASAN init done (64-bit Book3E)\n");
> +}
> diff --git a/arch/powerpc/purgatory/Makefile b/arch/powerpc/purgatory/Makefile
> index 4314ba5baf43..7c6d8b14f440 100644
> --- a/arch/powerpc/purgatory/Makefile
> +++ b/arch/powerpc/purgatory/Makefile
> @@ -1,4 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> +
> +KASAN_SANITIZE := n
> +
>  targets += trampoline.o purgatory.ro kexec-purgatory.c
>
>  LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined
> diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
> index 878f9c1d3615..064f7062c0a3 100644
> --- a/arch/powerpc/xmon/Makefile
> +++ b/arch/powerpc/xmon/Makefile
> @@ -6,6 +6,7 @@ subdir-ccflags-y := $(call cc-disable-warning, builtin-requires-header)
>
>  GCOV_PROFILE := n
>  UBSAN_SANITIZE := n
> +KASAN_SANITIZE := n
>
>  # Disable ftrace for the entire directory
>  ORIG_CFLAGS := $(KBUILD_CFLAGS)
> --
> 2.19.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20190215000441.14323-6-dja%40axtens.net.
> For more options, visit https://groups.google.com/d/optout.
