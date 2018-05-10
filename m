Return-Path: <yamada.masahiro@socionext.com>
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hMJf09fkzF2TT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 15:30:56 +1000 (AEST)
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com
 [209.85.213.49]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id w4A5UUIJ008644
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 14:30:30 +0900
Received: by mail-vk0-f49.google.com with SMTP id i185-v6so506008vkg.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 22:30:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180510051659.15356-4-npiggin@gmail.com>
References: <20180510051659.15356-1-npiggin@gmail.com>
 <20180510051659.15356-4-npiggin@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 10 May 2018 14:29:49 +0900
Message-ID: <CAK7LNATnJ_xi7nFLA5-MeP=86bK19Z9-L=muCW8LKoDYBpDHGA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] kbuild: call cc-option with the current set of
 KBUILD_CFLAGS
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

2018-05-10 14:16 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> In some cases, the options that gcc will accept depend on options it
> has already been given. For example -m32 / -m64 and -mbig-endian /
> -mlittle-endian can have this affect.

Is cc-option not working for you?


> Passing in KBUILD_CFLAGS to cc-option allows an architecture to
> set such basic machine types at the beginning, rather than override
> CC itself.

KBUILD_CFLAGS is passed to cc-option already
because CC_OPTION_CFLAGS includes it:

CC_OPTION_CFLAGS = $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))



This patch drops KBUILD_CPPFLAGS,
and adds KBUILD_CFLAGS twice, doesn't it?



> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  scripts/Kbuild.include | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 9f7eb10079cc..66869bb815d2 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -121,7 +121,7 @@ CC_OPTION_CFLAGS = $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))
>  # Usage: cflags-y += $(call cc-option,-march=winchip-c6,-march=i586)
>
>  cc-option = $(call __cc-option, $(CC),\
> -       $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS),$(1),$(2))
> +       $(KBUILD_CFLAGS) $(CC_OPTION_CFLAGS),$(1),$(2))
>
>  # hostcc-option
>  # Usage: cflags-y += $(call hostcc-option,-march=winchip-c6,-march=i586)
> @@ -131,12 +131,12 @@ hostcc-option = $(call __cc-option, $(HOSTCC),\
>  # cc-option-yn
>  # Usage: flag := $(call cc-option-yn,-march=winchip-c6)
>  cc-option-yn = $(call try-run,\
> -       $(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) $(1) -c -x c /dev/null -o "$$TMP",y,n)
> +       $(CC) -Werror $(KBUILD_CFLAGS) $(CC_OPTION_CFLAGS) $(1) -c -x c /dev/null -o "$$TMP",y,n)
>
>  # cc-disable-warning
>  # Usage: cflags-y += $(call cc-disable-warning,unused-but-set-variable)
>  cc-disable-warning = $(call try-run,\
> -       $(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
> +       $(CC) -Werror $(KBUILD_CFLAGS) $(CC_OPTION_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
>
>  # cc-name
>  # Expands to either gcc or clang
> @@ -160,7 +160,7 @@ cc-if-fullversion = $(shell [ $(cc-fullversion) $(1) $(2) ] && echo $(3) || echo
>  # cc-ldoption
>  # Usage: ldflags += $(call cc-ldoption, -Wl$(comma)--hash-style=both)
>  cc-ldoption = $(call try-run,\
> -       $(CC) $(1) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
> +       $(CC) $(1) $(KBUILD_CFLAGS) $(CC_OPTION_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
>
>  # ld-option
>  # Usage: LDFLAGS += $(call ld-option, -X)
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
