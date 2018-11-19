Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38123C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 18:56:36 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC5320659
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 18:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="shIIQCsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC5320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zJ343rZHzF3N5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 05:56:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="shIIQCsm";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="shIIQCsm"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zJ0B44c9zF3MV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 05:54:02 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id g189so2509190pgc.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 10:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EVUnGFQihmAP7gbZdUMy7kNRAkfmVy6crJeuOiI3dSQ=;
 b=shIIQCsm4m4NesH9KaUNET+mbwiAW4L38tSLheClVAk3XL2uxmTjst8FUJ9k8N/nL0
 AgOotSI2En7oxdZzwsUYwhfKNjuyj7+AWwjhxGFx5dNYh3uYCvYKpjmjpA0NIAdh9yLu
 P8R8RqbXDKQ2tQP0cXwOMOxNM3yXny2rs9xAhRylL4qUdjQzu9ebGTp0urGy6oIA9oJG
 4TH5bNAsjX366tx4exHRdYRIvqmPAgAZMnUKrjUR/rA7HW7+tBwmCl9BEEPFWzq3ksDA
 DtlVD7lzLKJnO0JrYbky9/EwCvU7rZqXbIvUVT2MTrmbDBpezn4vKYeNDt6G2ZCkF78H
 o6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EVUnGFQihmAP7gbZdUMy7kNRAkfmVy6crJeuOiI3dSQ=;
 b=qYVMux4n8h/plOPAYYrpK+jbmR6MBgalI2DUXteNDbM357o/0PzK/C7zvXROWObZtm
 TcrQLIT6k6598Z814dum1BkVC4vtZ7nbWJSP5ZWgtFpCyMSr6li6dmPz7nVluXAcBRuh
 FbRGNZGTvjfoEfL02q4WnM6eaTOhh/OR/GyFTL8i9fvrz2KWPBSkP6TlFEYVR24CP0cP
 V8LHwda5RuNuiiEJOMYjMTyt/XDG0kNSq6CuTurklVAa8XN/ta/FZr9RcRCEnHcbjrb7
 4y1Wtz11bFjiw3G3lOgjzGOzWm32NpNUVcmuETeoGWG24MG0gqrbBMfK8Ruez/6tFESE
 50ZQ==
X-Gm-Message-State: AGRZ1gLdO+r8pZR7fzIwdpzgI85JEcE4ZOnBqK4DvaPL3v1tfm8Dj749
 fX8H/zlME8fi5gUwKIWjcbeU0lLI1BZIs+4Q9vsYMXgF0SJfUA==
X-Google-Smtp-Source: AJdET5fn+M8MNfHisqHjq5Hyk2g7Q/trcPW4y9B/ACChG6WjRUejSFp0NanmoH3yuw/OWpUrA/uBpB7vbq0fD3fY+DM=
X-Received: by 2002:a62:13c3:: with SMTP id 64mr24084897pft.93.1542653639779; 
 Mon, 19 Nov 2018 10:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20181114024412.19368-1-joel@jms.id.au>
In-Reply-To: <20181114024412.19368-1-joel@jms.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 19 Nov 2018 10:53:48 -0800
Message-ID: <CAKwvOd=P6eQsysnhYVjekbKzVMiGZH8K2nO=Y2gNaH6j+yAhSQ@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/math-emu: Update macros from gmp-6.1.2
To: joel@jms.id.au
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Nov 13, 2018 at 6:44 PM Joel Stanley <joel@jms.id.au> wrote:
>
> The add_ssaaaa, sub_ddmmss, umul_ppmm and udiv_qrnnd macros originate
> from GMP's longlong.h.
> This was found when compiling with clang:
>
>    arch/powerpc/math-emu/fnmsub.c:46:2: error: invalid use of a cast in a
>    inline asm context requiring an l-value: remove the cast or build with
>    -fheinous-gnu-extensions
>            FP_ADD_D(R, T, B);
>            ^~~~~~~~~~~~~~~~~
>    ...
>
>    ./arch/powerpc/include/asm/sfp-machine.h:283:27: note: expanded from
>    macro 'sub_ddmmss'
>                   : "=r" ((USItype)(sh)),                                  \
>                           ~~~~~~~~~~^~~
>
> Segher points out: this was fixed in GCC over 16 years ago
> ( https://gcc.gnu.org/r56600 ), and in GMP (where it comes from)
> presumably before that.
>
> Update to the latest version in order to git rid of the invalid casts.

Hi Joel, thanks for this patch.  It's a much better fix IMO than v1.
One nit below.

>
> The only functional change I noticed was this in udiv_qrnnd.
>
>     __r1 = (n1) % __d1;
>     __q1 = (n1) / __d1;
>
> Becomes this:
>
>     __q1 = (n1) / __d1;
>     __r1 = (n1) - __q1 * __d1;
>
> This is equivalent as it instead of calculating the remainder
> using modulo, it uses the result of integer division to subtract the
> count of 'whole' d1 from r1.

I don't understand this; why was this functional change made?

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/260
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v1:
>  https://lore.kernel.org/linuxppc-dev/20181102033713.31916-1-joel@jms.id.au/
> v2:
>  Instead of setting the -fheinous-gnu-extensions for clang, fix the code.
>
>  arch/powerpc/include/asm/sfp-machine.h | 99 +++++++++-----------------
>  1 file changed, 32 insertions(+), 67 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/include/asm/sfp-machine.h
> index d89beaba26ff..a6353d9dd5ba 100644
> --- a/arch/powerpc/include/asm/sfp-machine.h
> +++ b/arch/powerpc/include/asm/sfp-machine.h
> @@ -213,30 +213,18 @@
>   * respectively.  The result is placed in HIGH_SUM and LOW_SUM.  Overflow
>   * (i.e. carry out) is not stored anywhere, and is lost.
>   */
> -#define add_ssaaaa(sh, sl, ah, al, bh, bl)                             \
> +#define add_ssaaaa(sh, sl, ah, al, bh, bl) \
>    do {                                                                 \
>      if (__builtin_constant_p (bh) && (bh) == 0)                                \
> -      __asm__ ("{a%I4|add%I4c} %1,%3,%4\n\t{aze|addze} %0,%2"          \
> -            : "=r" ((USItype)(sh)),                                    \
> -              "=&r" ((USItype)(sl))                                    \
> -            : "%r" ((USItype)(ah)),                                    \
> -              "%r" ((USItype)(al)),                                    \
> -              "rI" ((USItype)(bl)));                                   \
> -    else if (__builtin_constant_p (bh) && (bh) ==~(USItype) 0)         \
> -      __asm__ ("{a%I4|add%I4c} %1,%3,%4\n\t{ame|addme} %0,%2"          \
> -            : "=r" ((USItype)(sh)),                                    \
> -              "=&r" ((USItype)(sl))                                    \
> -            : "%r" ((USItype)(ah)),                                    \
> -              "%r" ((USItype)(al)),                                    \
> -              "rI" ((USItype)(bl)));                                   \
> +      __asm__ ("add%I4c %1,%3,%4\n\taddze %0,%2"                       \
> +            : "=r" (sh), "=&r" (sl) : "r" (ah), "%r" (al), "rI" (bl)); \
> +    else if (__builtin_constant_p (bh) && (bh) == ~(USItype) 0)                \
> +      __asm__ ("add%I4c %1,%3,%4\n\taddme %0,%2"                       \
> +            : "=r" (sh), "=&r" (sl) : "r" (ah), "%r" (al), "rI" (bl)); \
>      else                                                               \
> -      __asm__ ("{a%I5|add%I5c} %1,%4,%5\n\t{ae|adde} %0,%2,%3"         \
> -            : "=r" ((USItype)(sh)),                                    \
> -              "=&r" ((USItype)(sl))                                    \
> -            : "%r" ((USItype)(ah)),                                    \
> -              "r" ((USItype)(bh)),                                     \
> -              "%r" ((USItype)(al)),                                    \
> -              "rI" ((USItype)(bl)));                                   \
> +      __asm__ ("add%I5c %1,%4,%5\n\tadde %0,%2,%3"                     \
> +            : "=r" (sh), "=&r" (sl)                                    \
> +            : "r" (ah), "r" (bh), "%r" (al), "rI" (bl));               \
>    } while (0)
>
>  /* sub_ddmmss is used in op-2.h and udivmodti4.c and should be equivalent to
> @@ -248,44 +236,24 @@
>   * and LOW_DIFFERENCE.  Overflow (i.e. carry out) is not stored anywhere,
>   * and is lost.
>   */
> -#define sub_ddmmss(sh, sl, ah, al, bh, bl)                             \
> +#define sub_ddmmss(sh, sl, ah, al, bh, bl) \
>    do {                                                                 \
>      if (__builtin_constant_p (ah) && (ah) == 0)                                \
> -      __asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{sfze|subfze} %0,%2"      \
> -              : "=r" ((USItype)(sh)),                                  \
> -                "=&r" ((USItype)(sl))                                  \
> -              : "r" ((USItype)(bh)),                                   \
> -                "rI" ((USItype)(al)),                                  \
> -                "r" ((USItype)(bl)));                                  \
> -    else if (__builtin_constant_p (ah) && (ah) ==~(USItype) 0)         \
> -      __asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{sfme|subfme} %0,%2"      \
> -              : "=r" ((USItype)(sh)),                                  \
> -                "=&r" ((USItype)(sl))                                  \
> -              : "r" ((USItype)(bh)),                                   \
> -                "rI" ((USItype)(al)),                                  \
> -                "r" ((USItype)(bl)));                                  \
> +      __asm__ ("subf%I3c %1,%4,%3\n\tsubfze %0,%2"                     \
> +              : "=r" (sh), "=&r" (sl) : "r" (bh), "rI" (al), "r" (bl));\
> +    else if (__builtin_constant_p (ah) && (ah) == ~(USItype) 0)                \
> +      __asm__ ("subf%I3c %1,%4,%3\n\tsubfme %0,%2"                     \
> +              : "=r" (sh), "=&r" (sl) : "r" (bh), "rI" (al), "r" (bl));\
>      else if (__builtin_constant_p (bh) && (bh) == 0)                   \
> -      __asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{ame|addme} %0,%2"                \
> -              : "=r" ((USItype)(sh)),                                  \
> -                "=&r" ((USItype)(sl))                                  \
> -              : "r" ((USItype)(ah)),                                   \
> -                "rI" ((USItype)(al)),                                  \
> -                "r" ((USItype)(bl)));                                  \
> -    else if (__builtin_constant_p (bh) && (bh) ==~(USItype) 0)         \
> -      __asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{aze|addze} %0,%2"                \
> -              : "=r" ((USItype)(sh)),                                  \
> -                "=&r" ((USItype)(sl))                                  \
> -              : "r" ((USItype)(ah)),                                   \
> -                "rI" ((USItype)(al)),                                  \
> -                "r" ((USItype)(bl)));                                  \
> +      __asm__ ("subf%I3c %1,%4,%3\n\taddme %0,%2"                      \
> +              : "=r" (sh), "=&r" (sl) : "r" (ah), "rI" (al), "r" (bl));\
> +    else if (__builtin_constant_p (bh) && (bh) == ~(USItype) 0)                \
> +      __asm__ ("subf%I3c %1,%4,%3\n\taddze %0,%2"                      \
> +              : "=r" (sh), "=&r" (sl) : "r" (ah), "rI" (al), "r" (bl));\
>      else                                                               \
> -      __asm__ ("{sf%I4|subf%I4c} %1,%5,%4\n\t{sfe|subfe} %0,%3,%2"     \
> -              : "=r" ((USItype)(sh)),                                  \
> -                "=&r" ((USItype)(sl))                                  \
> -              : "r" ((USItype)(ah)),                                   \
> -                "r" ((USItype)(bh)),                                   \
> -                "rI" ((USItype)(al)),                                  \
> -                "r" ((USItype)(bl)));                                  \
> +      __asm__ ("subf%I4c %1,%5,%4\n\tsubfe %0,%3,%2"                   \
> +              : "=r" (sh), "=&r" (sl)                                  \
> +              : "r" (ah), "r" (bh), "rI" (al), "r" (bl));              \
>    } while (0)
>
>  /* asm fragments for mul and div */
> @@ -294,13 +262,10 @@
>   * UWtype integers MULTIPLER and MULTIPLICAND, and generates a two UWtype
>   * word product in HIGH_PROD and LOW_PROD.
>   */
> -#define umul_ppmm(ph, pl, m0, m1)                                      \
> +#define umul_ppmm(ph, pl, m0, m1) \
>    do {                                                                 \
>      USItype __m0 = (m0), __m1 = (m1);                                  \
> -    __asm__ ("mulhwu %0,%1,%2"                                         \
> -            : "=r" ((USItype)(ph))                                     \
> -            : "%r" (__m0),                                             \
> -               "r" (__m1));                                            \
> +    __asm__ ("mulhwu %0,%1,%2" : "=r" (ph) : "%r" (m0), "r" (m1));     \
>      (pl) = __m0 * __m1;                                                        \
>    } while (0)
>
> @@ -312,28 +277,28 @@
>   * significant bit of DENOMINATOR must be 1, then the pre-processor symbol
>   * UDIV_NEEDS_NORMALIZATION is defined to 1.
>   */
> -#define udiv_qrnnd(q, r, n1, n0, d)                                    \
> +#define udiv_qrnnd(q, r, n1, n0, d) \
>    do {                                                                 \
>      UWtype __d1, __d0, __q1, __q0, __r1, __r0, __m;                    \
>      __d1 = __ll_highpart (d);                                          \
>      __d0 = __ll_lowpart (d);                                           \
>                                                                         \
> -    __r1 = (n1) % __d1;                                                        \
>      __q1 = (n1) / __d1;                                                        \
> -    __m = (UWtype) __q1 * __d0;                                                \
> +    __r1 = (n1) - __q1 * __d1;                                         \
> +    __m = __q1 * __d0;                                                 \
>      __r1 = __r1 * __ll_B | __ll_highpart (n0);                         \
>      if (__r1 < __m)                                                    \
>        {                                                                        \
>         __q1--, __r1 += (d);                                            \
> -       if (__r1 >= (d)) /* we didn't get carry when adding to __r1 */  \
> +       if (__r1 >= (d)) /* i.e. we didn't get carry when adding to __r1 */\
>           if (__r1 < __m)                                               \
>             __q1--, __r1 += (d);                                        \
>        }                                                                        \
>      __r1 -= __m;                                                       \
>                                                                         \
> -    __r0 = __r1 % __d1;                                                        \
>      __q0 = __r1 / __d1;                                                        \
> -    __m = (UWtype) __q0 * __d0;                                                \
> +    __r0 = __r1  - __q0 * __d1;                                                \
> +    __m = __q0 * __d0;                                                 \
>      __r0 = __r0 * __ll_B | __ll_lowpart (n0);                          \
>      if (__r0 < __m)                                                    \
>        {                                                                        \
> @@ -344,7 +309,7 @@
>        }                                                                        \
>      __r0 -= __m;                                                       \
>                                                                         \
> -    (q) = (UWtype) __q1 * __ll_B | __q0;                               \
> +    (q) = __q1 * __ll_B | __q0;                                                \
>      (r) = __r0;                                                                \
>    } while (0)


This appears to now differ from the upstream source:
https://github.com/gcc-mirror/gcc/blob/f7289f563a5e447ac21a5901ed75aad0dbd37732/include/longlong.h#L1679
If we're going to borrow implementations from GCC, let's borrow the
same implementation. Otherwise it's hard to have confidence in this
part of the patch.
-- 
Thanks,
~Nick Desaulniers
