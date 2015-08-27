Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com
 [IPv6:2a00:1450:400c:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCAA1A05BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 21:56:00 +1000 (AEST)
Received: by widdq5 with SMTP id dq5so42625807wid.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 04:55:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1440577578-15813-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1440577578-15813-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 27 Aug 2015 14:55:56 +0300
Message-ID: <CAPAsAGyG89ABf4WqvhtDqxF18UnmMh+Kn2gFRqH3-x4guGOiVQ@mail.gmail.com>
Subject: Re: [PATCH V2 07/10] kasan: Make INLINE KASan support arch selectable
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2015-08-26 11:26 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
> Some of the archs, may find it difficult to support inline KASan
> mode. Add HAVE_ARCH_KASAN_INLINE so that we can disable inline
> support at config time.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/x86/Kconfig       |  1 +
>  lib/Kconfig.kasan      |  2 ++
>  scripts/Makefile.kasan | 28 ++++++++++++++--------------
>  3 files changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b3a1a5d77d92..4416f80580fb 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -78,6 +78,7 @@ config X86
>         select HAVE_ARCH_HUGE_VMAP              if X86_64 || X86_PAE
>         select HAVE_ARCH_JUMP_LABEL
>         select HAVE_ARCH_KASAN                  if X86_64 && SPARSEMEM_VMEMMAP
> +       select HAVE_ARCH_KASAN_INLINE                   if X86_64 && SPARSEMEM_VMEMMAP

This will not work because config HAVE_ARCH_KASAN_INLINE is not defined.
Instead of you can just add following in this file:

config HAVE_ARCH_KASAN_INLINE
          def_bool y
          depends on KASAN


>         select HAVE_ARCH_KGDB
>         select HAVE_ARCH_KMEMCHECK
>         select HAVE_ARCH_SECCOMP_FILTER
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 39f24d6721e5..e9d1bb1175b8 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -32,6 +32,7 @@ config KASAN_OUTLINE
>           however it doesn't bloat size of kernel's .text section so
>           much as inline does.
>
> +if HAVE_ARCH_KASAN_INLINE
>  config KASAN_INLINE
>         bool "Inline instrumentation"

 depends on HAVE_ARCH_KASAN_INLINE

>         help
> @@ -40,6 +41,7 @@ config KASAN_INLINE
>           it gives about x2 boost over outline instrumentation), but
>           make kernel's .text size much bigger.
>           This requires a gcc version of 5.0 or later.
> +endif
>
>  endchoice
>
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index 3f874d24234f..c1c06e9e107a 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -1,29 +1,29 @@
>  ifdef CONFIG_KASAN
> -ifdef CONFIG_KASAN_INLINE
> -       call_threshold := 10000
> -else
> -       call_threshold := 0
> -endif
> -
> -CFLAGS_KASAN_MINIMAL := -fsanitize=kernel-address
>
>  CFLAGS_KASAN := $(call cc-option, -fsanitize=kernel-address \
> -               -fasan-shadow-offset=$(CONFIG_KASAN_SHADOW_OFFSET) \
> -               --param asan-stack=1 --param asan-globals=1 \
> -               --param asan-instrumentation-with-call-threshold=$(call_threshold))
> -
> -ifeq ($(call cc-option, $(CFLAGS_KASAN_MINIMAL) -Werror),)
> +                   --param asan-instrumentation-with-call-threshold=0)
> +ifeq ($(CFLAGS_KASAN),)
>     ifneq ($(CONFIG_COMPILE_TEST),y)
>          $(warning Cannot use CONFIG_KASAN: \
>              -fsanitize=kernel-address is not supported by compiler)
>     endif
>  else
> -    ifeq ($(CFLAGS_KASAN),)
> +
> +   ifdef CONFIG_KASAN_INLINE
> +   CFLAGS_KASAN_INLINE := $(call cc-option, -fsanitize=kernel-address \
> +                        -fasan-shadow-offset=$(CONFIG_KASAN_SHADOW_OFFSET) \
> +                        --param asan-stack=1 --param asan-globals=1 \
> +                        --param asan-instrumentation-with-call-threshold=10000)
> +
> +    ifeq ($(CFLAGS_KASAN_INLINE),)
>          ifneq ($(CONFIG_COMPILE_TEST),y)
>              $(warning CONFIG_KASAN: compiler does not support all options.\
>                  Trying minimal configuration)
>          endif
> -        CFLAGS_KASAN := $(CFLAGS_KASAN_MINIMAL)
> +    else
> +        CFLAGS_KASAN := $(CFLAGS_KASAN_INLINE)
>      endif
> +    endif
> +

This removes stack and globals for CONFIG_KASAN_OUTLINE=y. Why?
Those are completely separate features. So this patch shouldn't touch
this Makefile at all.
Depends on HAVE_ARCH_KASAN_INLINE in CONFIG_KASAN_INLINE should be enough.

But you need to disable 'asan-stack' and 'asan-globals' for pcc64.
I'd suggest to introduce CFLAGS_ARCH_KASAN.
Define it in ppc64 Makefile:

CFLAGS_ARCH_KASAN := --param asan-globals=0 --param asan-stack=0

and add these flags to CFLAGS_KASAN_MINIMAL and CFLAGS_KASAN in Makefile.kasan.


>  endif
>  endif
> --
> 2.5.0
>
