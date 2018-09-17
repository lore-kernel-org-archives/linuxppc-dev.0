Return-Path: <ndesaulniers@google.com>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DXlT5tHgzF12l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 03:13:41 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id j26-v6so7847901pfi.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 10:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180917074621.25066-1-joel@jms.id.au>
In-Reply-To: <20180917074621.25066-1-joel@jms.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 17 Sep 2018 10:13:27 -0700
Message-ID: <CAKwvOdnj7pBwkXe953iMYpt65WNnTqDKEq-p90RVeYBMSpyTSQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Disable -Wbuiltin-requires-header when setjmp is
 used
To: joel@jms.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Stephen Hines <srhines@google.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 17, 2018 at 12:46 AM Joel Stanley <joel@jms.id.au> wrote:
>
> The powerpc kernel uses setjmp which causes a warning when building with
> clang:
>
>     CC      arch/powerpc/xmon/xmon.o
>   In file included from arch/powerpc/xmon/xmon.c:51:
>   ./arch/powerpc/include/asm/setjmp.h:15:13: error: declaration of
>   built-in function 'setjmp' requires inclusion of the header <setjmp.h>
>         [-Werror,-Wbuiltin-requires-header]
>   extern long setjmp(long *);
>               ^
>   ./arch/powerpc/include/asm/setjmp.h:16:13: error: declaration of
>   built-in function 'longjmp' requires inclusion of the header <setjmp.h>
>         [-Werror,-Wbuiltin-requires-header]
>   extern void longjmp(long *, long);
>               ^
>
> This *is* the header and we're not using the built-in setjump but
> rather the one in arch/powerpc/kernel/misc.S. As the compiler warning
> does not make sense, it for the files where setjmp is used.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Joel, thanks for reporting the issue in
https://github.com/ClangBuiltLinux/linux/issues/59
and sending the patch to fix.  I think it would be good to credit
Stephen with the Suggested-by tag:

Suggested-by: Stephen Hines <srhines@google.com>

> ---
> We could instead disable this for all of the kernel as I don't think the
> warning is going to ever provide useful information for the kernel.

I'd be curious to see more than one failure to be able to discern
whether this flag should always be disabled or if it could flag actual
bugs.  I assume the intent of the flag is "don't name
functions/headers that would conflict with the C standard library."
While the kernel uses `-nostdinc`, I still kind of empathize with the
intent of the flag.  I worry about system headers somehow getting
included rather than the kernel provided ones, especially because some
Makefiles in the kernel overwrite KBUILD_CFLAGS.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>  arch/powerpc/kernel/Makefile | 3 +++
>  arch/powerpc/xmon/Makefile   | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 1e64cfe22a83..9845a94f5f68 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -7,6 +7,9 @@ CFLAGS_ptrace.o         += -DUTS_MACHINE='"$(UTS_MACHINE)"'
>
>  subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
>
> +# Disable clang warning for using setjmp without setjmp.h header
> +CFLAGS_crash.o         += $(call cc-disable-warning, builtin-requires-header)
> +
>  ifdef CONFIG_PPC64
>  CFLAGS_prom_init.o     += $(NO_MINIMAL_TOC)
>  endif
> diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
> index 93cc1f1b8b61..a38db48f9f6d 100644
> --- a/arch/powerpc/xmon/Makefile
> +++ b/arch/powerpc/xmon/Makefile
> @@ -14,6 +14,9 @@ ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
>
>  obj-y                  += xmon.o nonstdio.o spr_access.o
>
> +# Disable clang warning for using setjmp without setjmp.h header
> +subdir-ccflags-y := $(call cc-disable-warning, builtin-requires-header)
> +
>  ifdef CONFIG_XMON_DISASSEMBLY
>  obj-y                  += ppc-dis.o ppc-opc.o
>  obj-$(CONFIG_SPU_BASE) += spu-dis.o spu-opc.o
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
