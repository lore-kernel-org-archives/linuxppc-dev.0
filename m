Return-Path: <yamada.masahiro@socionext.com>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fWLf2MNrzF14r
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 15:26:17 +1000 (AEST)
Received: from mail-ua0-f177.google.com (mail-ua0-f177.google.com
 [209.85.217.177]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id w475PrcS024349
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 14:25:54 +0900
Received: by mail-ua0-f177.google.com with SMTP id y8so17591849ual.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 May 2018 22:25:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180430012351.28814-2-npiggin@gmail.com>
References: <20180430012351.28814-1-npiggin@gmail.com>
 <20180430012351.28814-2-npiggin@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 7 May 2018 14:25:12 +0900
Message-ID: <CAK7LNAT3nowJ=CCE0OARdADyvuXOH+zFyQBBg3HOgp+W=ezT0g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] powerpc/kbuild: Use flags variables rather than
 overriding LD/CC/AS
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi.


2018-04-30 10:23 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> The powerpc toolchain can compile combinations of 32/64 bit and
> big/little endian, so it's convenient to consider, e.g.,
>
>   CC -m64 -mbig-endian
>
> To be the C compiler for the purpose of invoking it to build
> target artifacts.

Right, but this is not possible in the new Kconfig scheme
because CPU_BIG/LITTLE_ENDIAN can be turned on/off
from Kconfig menus.


> Rather than override, use kbuild defined variables to pass these
> flags around. Importantly, they must be passed to things like
> cc-option, so the usual cflags-y is not sufficient. This multitude
> of inconsistently named variables is a mess, but it's marginally
> better than overriding the toolchain because it matches what other
> architectures do.
>
> This allows powerpc builds to work with the new kconfig macro
> language branch. XXX: not exactly sure why it fails in the first
> place.


Without this patch, 'scripts/kconfig/conf  --syncconfig Kconfig'
continues eternally.

This is because the change of environment variable $(CC) will
trigger syncconfig.

So, this patch is the right thing to do.



> XXX: 32-bit builds with 64-bit toolchain gain some additional options
> like -funit-at-a-time from cc-option. Unclear why that is. Build
> appears to be correct otherwise.
> ---
>  arch/powerpc/Makefile | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 95813df90801..046b5dde9ff5 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -74,13 +74,15 @@ endif
>  endif
>
>  ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
> -override LD    += -EL
> +KBUILD_CPPFLAGS        += -mlittle-endian


IMHO, I personally prefer

KBUILD_CFLAGS        += -mlittle-endian
KBUILD_AFLAGS        += -mlittle-endian

like the current arch/powerpc/Makefile add the flag
to cflags-y / aflags-y separately.


Only the difference would be whether -mlittle-endian
is passed to pre-processing the linker script, though.




> +LDFLAGS                += -EL
>  LDEMULATION    := lppc
>  GNUTARGET      := powerpcle
>  MULTIPLEWORD   := -mno-multiple
>  KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-save-toc-indirect)
>  else
> -override LD    += -EB
> +KBUILD_CPPFLAGS += $(call cc-option,-mbig-endian)
> +LDFLAGS                += -EB
>  LDEMULATION    := ppc
>  GNUTARGET      := powerpc
>  MULTIPLEWORD   := -mmultiple
> @@ -93,8 +95,6 @@ aflags-$(CONFIG_CPU_BIG_ENDIAN)               += $(call cc-option,-mabi=elfv1)
>  aflags-$(CONFIG_CPU_LITTLE_ENDIAN)     += -mabi=elfv2
>  endif
>
> -cflags-$(CONFIG_CPU_LITTLE_ENDIAN)     += -mlittle-endian
> -cflags-$(CONFIG_CPU_BIG_ENDIAN)                += $(call cc-option,-mbig-endian)
>  ifneq ($(cc-name),clang)
>    cflags-$(CONFIG_CPU_LITTLE_ENDIAN)   += -mno-strict-align
>  endif
> @@ -103,9 +103,9 @@ aflags-$(CONFIG_CPU_BIG_ENDIAN)             += $(call cc-option,-mbig-endian)
>  aflags-$(CONFIG_CPU_LITTLE_ENDIAN)     += -mlittle-endian
>
>  ifeq ($(HAS_BIARCH),y)
> -override AS    += -a$(BITS)
> -override LD    += -m elf$(BITS)$(LDEMULATION)
> -override CC    += -m$(BITS)
> +KBUILD_CPPFLAGS        += -m$(BITS)


Do you mean this?

KBUILD_CFLAGS        += -m$(BITS)


> +KBUILD_AFLAGS  += -m$(BITS) -Wl,-a$(BITS)


Both KBUILD_CPPFLAGS and KBUILD_AFLAGS are added
to orig_a_flags in scripts/Makefile.lib

So, -m$(BITS) will be doubled for *.S files.


> +LDFLAGS                += -m elf$(BITS)$(LDEMULATION)
>  KBUILD_ARFLAGS += --target=elf$(BITS)-$(GNUTARGET)
>  endif
>



-- 
Best Regards
Masahiro Yamada
