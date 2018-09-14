Return-Path: <ndesaulniers@google.com>
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bjk11nzpzF3HN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 03:51:05 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id s15-v6so4733208pgv.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 10:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180914040649.1794-1-joel@jms.id.au>
 <20180914040649.1794-4-joel@jms.id.au>
In-Reply-To: <20180914040649.1794-4-joel@jms.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 14 Sep 2018 10:50:51 -0700
Message-ID: <CAKwvOdkk2BwieZ8rZhVY32H-5qV9sRjrGeY+986uHkTbh6cqQA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] powerpc/boot: Ensure _zimage_start is a weak symbol
To: joel@jms.id.au
Cc: linuxppc-dev@lists.ozlabs.org, anton@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 13, 2018 at 9:07 PM Joel Stanley <joel@jms.id.au> wrote:
>
> When building with clang crt0's _zimage_start is not marked weak, which
> breaks the build when linking the kernel image:
>
>  $ objdump -t arch/powerpc/boot/crt0.o |grep _zimage_start$
>  0000000000000058 g       .text  0000000000000000 _zimage_start
>
>  ld: arch/powerpc/boot/wrapper.a(crt0.o): in function '_zimage_start':
>  (.text+0x58): multiple definition of '_zimage_start';
>  arch/powerpc/boot/pseries-head.o:(.text+0x0): first defined here
>
> Clang requires the .weak directive to appear after the symbol is
> declared. The binutils manual says:
>
>  This directive sets the weak attribute on the comma separated list of
>  symbol names. If the symbols do not already exist, they will be
>  created.
>
> So it appears this is different with clang. The only reference I could
> see for this was an OpenBSD mailing list post[1].
>
> Changing it to be after the declaration fixes building with Clang, and
> still works with GCC.
>
>  $ objdump -t arch/powerpc/boot/crt0.o |grep _zimage_start$
>  0000000000000058  w      .text 0000000000000000 _zimage_start
>
> Reported to clang as https://bugs.llvm.org/show_bug.cgi?id=38921
>
> [1] https://groups.google.com/forum/#!topic/fa.openbsd.tech/PAgKKen2YCY
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2: Add comment explaining this is a workaround for clang. I have also
> opened a clang bug to see if they plan on changing behaviour
> ---
>  arch/powerpc/boot/crt0.S | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
> index e453e011d7e7..4e32bd251b99 100644
> --- a/arch/powerpc/boot/crt0.S
> +++ b/arch/powerpc/boot/crt0.S
> @@ -47,8 +47,10 @@ p_end:               .long   _end
>  p_pstack:      .long   _platform_stack_top
>  #endif
>
> -       .weak   _zimage_start
>         .globl  _zimage_start
> +       /* Clang appears to require the .weak directive to be after the symbol
> +        * is defined. See https://bugs.llvm.org/show_bug.cgi?id=38921  */
> +       .weak   _zimage_start
>  _zimage_start:
>         .globl  _zimage_start_lib
>  _zimage_start_lib:
> --
> 2.17.1
>

Sure, definitely a long tail of binutils/GAS functionality to match
from Clang's integrated assembler, but this is a small fix that
results in no functional change for GCC/binutils and enables
Clang/bfd.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
