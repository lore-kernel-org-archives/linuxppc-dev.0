Return-Path: <ndesaulniers@google.com>
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BjWS5mPGzF315
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 03:41:56 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id f66-v6so4520446plb.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 10:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180914040649.1794-1-joel@jms.id.au>
 <20180914040649.1794-2-joel@jms.id.au>
In-Reply-To: <20180914040649.1794-2-joel@jms.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 14 Sep 2018 10:41:43 -0700
Message-ID: <CAKwvOd=imPGj6=en2uFAW6fa8jRo9siAEwMZzoj023HUa3ihOw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] powerpc/Makefiles: Fix clang/llvm build
To: joel@jms.id.au
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org, anton@ozlabs.org
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
> From: Anton Blanchard <anton@samba.org>
>
> Commit 15a3204d24a3 ("powerpc/64s: Set assembler machine type to POWER4")
> passes -mpower4 to the assembler. We have more recent instructions in our
> assembly files, but gas permits them. The clang/llvm integrated assembler
> is more strict, and we get a build failure.

Note that we disable clang's integrated assembler in the top level
Makefile for now, but it will still validate constraints for inline
assembly.  Do you know which case is meant by "build failure?"

Is there a link to the Clang bug?  It would be good to have that
context in the commit message.

>
> Fix this by calling the assembler with -mcpu=power8 if as supports it,
> else fall back to power4.
>
> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/powerpc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 11a1acba164a..a70639482053 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -238,7 +238,7 @@ cpu-as-$(CONFIG_4xx)                += -Wa,-m405
>  cpu-as-$(CONFIG_ALTIVEC)       += $(call as-option,-Wa$(comma)-maltivec)
>  cpu-as-$(CONFIG_E200)          += -Wa,-me200
>  cpu-as-$(CONFIG_E500)          += -Wa,-me500
> -cpu-as-$(CONFIG_PPC_BOOK3S_64) += -Wa,-mpower4
> +cpu-as-$(CONFIG_PPC_BOOK3S_64) += $(call as-option,-Wa$(comma)-mpower8,-Wa$(comma)-mpower4)
>  cpu-as-$(CONFIG_PPC_E500MC)    += $(call as-option,-Wa$(comma)-me500mc)
>
>  KBUILD_AFLAGS += $(cpu-as-y)
> --
> 2.17.1
>

-- 
Thanks,
~Nick Desaulniers
