Return-Path: <yamada.masahiro@socionext.com>
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wFHR34NczDr43
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 23:41:06 +1000 (AEST)
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com
 [209.85.213.46]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id w4TDeTJu030707
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 22:40:30 +0900
Received: by mail-vk0-f46.google.com with SMTP id u8-v6so8880463vku.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 06:40:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180516141458.18996-2-npiggin@gmail.com>
References: <20180516141458.18996-1-npiggin@gmail.com>
 <20180516141458.18996-2-npiggin@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 29 May 2018 22:39:48 +0900
Message-ID: <CAK7LNASsx_gDQePtNRdiY8v4RbysQqoKKfr1LW6dsz=7fq-oEQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] powerpc/kbuild: set default generic machine type
 for 32-bit compile
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2018-05-16 23:14 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> Some 64-bit toolchains uses the wrong ISA variant for compiling 32-bit
> kernels, even with -m32. Debian's powerpc64le is one such case, and
> that is because it is built with --with-cpu=power8.
>
> So when cross compiling a 32-bit kernel with a 64-bit toolchain, set
> -mcpu=powerpc initially, which is the generic 32-bit powerpc machine
> type and scheduling model. CPU and platform code can override this
> with subsequent -mcpu flags if necessary.
>
> This is not done for 32-bit toolchains otherwise it would override
> their defaults, which are presumably set appropriately for the
> environment (moreso than a 64-bit cross compiler).
>
> This fixes a lot of build failures due to incompatible assembly when
> compiling 32-bit kernel with th Debian powerpc64le 64-bit toolchain.
>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---


Can you please remove the noise changes?

1/4 adds some blank lines, then 2/4 removes them.




>  arch/powerpc/Makefile | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 95813df90801..15ca4bafad82 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -24,9 +24,20 @@ ifeq ($(HAS_BIARCH),y)
>  ifeq ($(CROSS32_COMPILE),)
>  CROSS32CC      := $(CC) -m32
>  KBUILD_ARFLAGS += --target=elf32-powerpc
> +

This blank line will be removed by the next patch.


> +ifdef CONFIG_PPC32
> +# These options will be overridden by any -mcpu option that the CPU
> +# or platform code sets later on the command line, but they are needed
> +# to set a sane 32-bit cpu target for the 64-bit cross compiler which
> +# may default to the wrong ISA.
> +KBUILD_CFLAGS          += -mcpu=powerpc
> +KBUILD_AFLAGS          += -mcpu=powerpc
> +endif
> +

This blank line will be removed by the next patch.


>  endif
>  endif
>
> +

This blank line will be removed by the next patch.



>  export CROSS32CC CROSS32AR
>
>  ifeq ($(CROSS_COMPILE),)
> --
> 2.17.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
