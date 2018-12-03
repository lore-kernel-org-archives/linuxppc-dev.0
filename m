Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0418C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 23:30:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A41E20851
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 23:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="N2koiiIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A41E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4381SV0xVlzDqFh
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 10:30:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="N2koiiIV";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="N2koiiIV"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4381Ls6HCjzDqpq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 10:25:25 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id c123so7180564pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 15:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9x5daYUNsYY7xliELqTFm1BRIrlRBwrZvYpXpcTDtT0=;
 b=N2koiiIV2NRf3lEhJcN/ul09MvRYE9zwomgDblTaYil9qQiX6xc5mXIMC5z0A0VYfI
 m5U2i8uqes588Si/i3P35t3oBm+c6YpMx5zDMQh/DoQRFZFBoOuYZ9XhGBEkp6+x0OOE
 Hrb2Kxe0fWfNhdfFMt9F9dV4bYTZW5zsToXzU3zbZpYT0DCzWmmUCrZIyuLwK4UGy4kE
 H5yyZrMYPPP58tkDUrw0Qx1GZlqTxT8Efi6LO17xOCZiyOA0nxhB4h9WEWc07SbdKMmg
 Mb4+yxEIfOgvfHFxNne8eTkh0cUnzAFGxNa9OCFCnKg9QzdloW4HcSwrKIZyBVbpv6cx
 odMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9x5daYUNsYY7xliELqTFm1BRIrlRBwrZvYpXpcTDtT0=;
 b=R3Ka5VYiHwdDaW7erTuOLl+z1pKoKM0mZq5MUrSItihmLbI/xhUzzVBEuytJK85rnK
 7Zk8QZIZEAKai08nur21tZFjMziKVRB8sOCixp8Q04+CiY2Ad02jjFTRiEzZIjYiwKCl
 KQ77+XqcHMdHuIBmTs1vAW85wKTeAENHfQ4NaZvtskaFDR3gYqRhiLZb09Pdquzy0O4i
 okJBwOyL/01V8fMm5WyACSa5BOf1JHmN9Ju+s46MQNz7Tz8mTr0z8kkQoo1S5Pk/EqQU
 3007TMsa5tur9DC7/LREJ/VvtkICIYl6g/Hn9v8uAEIUKBOpvQ1qXIIp85lNXxAejvwh
 D4NA==
X-Gm-Message-State: AA+aEWaSI1P5lI06IK94yU+Pt5pZd4zrKO9rD/FQvKvxas/IBc+hEJu0
 rGwQIveRG9m1LjXxp56r+H4BHNzpKO8rYrmkJQNu9g==
X-Google-Smtp-Source: AFSGD/U02qzLLWT7cNLriCUmd1H8aESCRpaIpokeqcZ/PePiev2z3ZBKSIYiSLXfmzNz2+LL6dE5yuAZ3TLtT7P42fU=
X-Received: by 2002:a63:a064:: with SMTP id u36mr13839774pgn.145.1543879523350; 
 Mon, 03 Dec 2018 15:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20181203230746.27196-1-joel@jms.id.au>
In-Reply-To: <20181203230746.27196-1-joel@jms.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 3 Dec 2018 15:25:11 -0800
Message-ID: <CAKwvOdnnaGk+WthAoVPwaBLtJbgmsCkEfLNu+m2f_B37s3v-4A@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/math-emu: Update macros from GCC
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

On Mon, Dec 3, 2018 at 3:07 PM Joel Stanley <joel@jms.id.au> wrote:
>
> The add_ssaaaa, sub_ddmmss, umul_ppmm and udiv_qrnnd macros originate
> from GCC's longlong.h which in turn was copied from GMP's longlong.h a
> few decades ago.
>
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
> Update the add_ssaaaa, sub_ddmmss, umul_ppmm and udiv_qrnnd macros to
> the latest GCC version in order to git rid of the invalid casts. These
> were taken as-is from GCC's longlong in order to make future syncs
> obvious. Other parts of sfp-machine.h were left as-is as the file
> contains more features than present in longlong.h.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/260
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v1:
>  https://lore.kernel.org/linuxppc-dev/20181102033713.31916-1-joel@jms.id.au/
> v2:
>  Instead of setting the -fheinous-gnu-extensions for clang, fix the code.
> v3:
>  Sync with GCC version instead of GMP version

Thanks for matching these up.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/powerpc/include/asm/sfp-machine.h | 92 ++++++++------------------
>  1 file changed, 29 insertions(+), 63 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/include/asm/sfp-machine.h
> index d89beaba26ff..8b957aabb826 100644
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
> +      __asm__ ("add%I4c %1,%3,%4\n\taddze %0,%2"               \
> +            : "=r" (sh), "=&r" (sl) : "r" (ah), "%r" (al), "rI" (bl));\
> +    else if (__builtin_constant_p (bh) && (bh) == ~(USItype) 0)                \
> +      __asm__ ("add%I4c %1,%3,%4\n\taddme %0,%2"               \
> +            : "=r" (sh), "=&r" (sl) : "r" (ah), "%r" (al), "rI" (bl));\
>      else                                                               \
> -      __asm__ ("{a%I5|add%I5c} %1,%4,%5\n\t{ae|adde} %0,%2,%3"         \
> -            : "=r" ((USItype)(sh)),                                    \
> -              "=&r" ((USItype)(sl))                                    \
> -            : "%r" ((USItype)(ah)),                                    \
> -              "r" ((USItype)(bh)),                                     \
> -              "%r" ((USItype)(al)),                                    \
> -              "rI" ((USItype)(bl)));                                   \
> +      __asm__ ("add%I5c %1,%4,%5\n\tadde %0,%2,%3"             \
> +            : "=r" (sh), "=&r" (sl)                                    \
> +            : "%r" (ah), "r" (bh), "%r" (al), "rI" (bl));              \
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
> +      __asm__ ("subf%I3c %1,%4,%3\n\tsubfze %0,%2"     \
> +              : "=r" (sh), "=&r" (sl) : "r" (bh), "rI" (al), "r" (bl));\
> +    else if (__builtin_constant_p (ah) && (ah) == ~(USItype) 0)                \
> +      __asm__ ("subf%I3c %1,%4,%3\n\tsubfme %0,%2"     \
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
> +      __asm__ ("subf%I3c %1,%4,%3\n\taddme %0,%2"              \
> +              : "=r" (sh), "=&r" (sl) : "r" (ah), "rI" (al), "r" (bl));\
> +    else if (__builtin_constant_p (bh) && (bh) == ~(USItype) 0)                \
> +      __asm__ ("subf%I3c %1,%4,%3\n\taddze %0,%2"              \
> +              : "=r" (sh), "=&r" (sl) : "r" (ah), "rI" (al), "r" (bl));\
>      else                                                               \
> -      __asm__ ("{sf%I4|subf%I4c} %1,%5,%4\n\t{sfe|subfe} %0,%3,%2"     \
> -              : "=r" ((USItype)(sh)),                                  \
> -                "=&r" ((USItype)(sl))                                  \
> -              : "r" ((USItype)(ah)),                                   \
> -                "r" ((USItype)(bh)),                                   \
> -                "rI" ((USItype)(al)),                                  \
> -                "r" ((USItype)(bl)));                                  \
> +      __asm__ ("subf%I4c %1,%5,%4\n\tsubfe %0,%3,%2"   \
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
> @@ -312,9 +277,10 @@
>   * significant bit of DENOMINATOR must be 1, then the pre-processor symbol
>   * UDIV_NEEDS_NORMALIZATION is defined to 1.
>   */
> -#define udiv_qrnnd(q, r, n1, n0, d)                                    \
> +#define udiv_qrnnd(q, r, n1, n0, d) \
>    do {                                                                 \
> -    UWtype __d1, __d0, __q1, __q0, __r1, __r0, __m;                    \
> +    UWtype __d1, __d0, __q1, __q0;                                     \
> +    UWtype __r1, __r0, __m;                                            \
>      __d1 = __ll_highpart (d);                                          \
>      __d0 = __ll_lowpart (d);                                           \
>                                                                         \
> @@ -325,7 +291,7 @@
>      if (__r1 < __m)                                                    \
>        {                                                                        \
>         __q1--, __r1 += (d);                                            \
> -       if (__r1 >= (d)) /* we didn't get carry when adding to __r1 */  \
> +       if (__r1 >= (d)) /* i.e. we didn't get carry when adding to __r1 */\
>           if (__r1 < __m)                                               \
>             __q1--, __r1 += (d);                                        \
>        }                                                                        \
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
