Return-Path: <linuxppc-dev+bounces-25420-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4386C55822
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 09:25:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFQ43475jz2xqM;
	Wed, 05 Aug 2026 19:25:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::533" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785921907;
	cv=pass; b=AoXISSn6VpBtA1t0pJKEgZjUrxo6d21+8omE0GtkA2NK9skNN4+ZuQAHSXt9N42y7csYah5iUVk4VA6imhFEG8pPjdJWfKdg+kKArL3/IPXRWfaLvQDNr4l/qYaucZqlcyQNTuI3uMYLcWxcrJh02aWr9v7w7fuW+334xa/OrPk32gFZ8L8hN8kGuM0LcX4Kw7+siWgV2o+IpluPVKgtc5J2Ydefkc1WB0VXZncqpo1FcvfEt4jVNOCKH1YEmYnCoAGrSTPkBMvcp5gygTMb9T3KnF8U1T6jFWsgg2d3IXNUNRIlxnneNoI+ll70J/ymUskmWOZbu3FDn1TTw+8VQg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785921907; c=relaxed/relaxed;
	bh=qSPlmzZwsggqkOekQQNlyHJCqbwcPOcbrrGQp2BzoG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/17yi5IattmyQwmiVPsQYljTasGtjLv9c2SuAarHV+lIZyV3upw5dIMt3zq+5lD/Q9Q/m1+lVy8pJjVXfXPHL55Y0Yzcwd09YntnJac89G0cJUSnn55XDbRSZMQ6/QrBh4kantudQNh8f2S5DUMVRk0ReAKSv2+L2FMGaMcq5dBAiknh3ZaaIoOwBx9qdmIKIB9xOoYdJazMUWMPFgwqZWIMxnpm+EGqkNyIn9SMu9BxMRpQKNgdvfq81qAmIW6JTXlC7ZzYBInzNOkrUWpVVrNp/zMRAUwNzOEuC4nUYZuk1CoyZB3nA5gzpAlNTdM5uUJkieCV/+6ASx95xFuzQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=btIayQB5; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=btIayQB5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFQ414134z2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 19:25:04 +1000 (AEST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a18180so1103297a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 02:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785921901; cv=none;
        d=google.com; s=arc-20260327;
        b=fvwM/JBBqo6QZpZ84HBT59jcl0Xngytn8qBNHKN+gzgzplxO0zLeQyRM1cq+2aYK7W
         ifjGs7PNUZDrFw13FBZxPy46sw+AiQBl9OaGowVK5qzpqlkerlosdcfjmWONWUV62cLH
         5xYwyKrqzLDwDk/NqXJ/livI+NiKONTwg49tWFUS37/qZW3bF4KLgGF1GoNUDQmwXPFH
         zPFYQZRCkO1aKVwcsyfvhB7l9CNeDZjPl5F5Ck6+vOC1hFcbthtCW5BxuhtMrfowd+jq
         Y7U5E6yrQpqy9wskfd25npaIa819OPtMeKWKB3w0f1VIalUed5Iup8GIMY2PtgovliUw
         dumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qSPlmzZwsggqkOekQQNlyHJCqbwcPOcbrrGQp2BzoG0=;
        fh=T8dJOnJyi48EYvMqwzqAy+soNlBi7KEpJwwHGkZOR/w=;
        b=rgiPCw+5bLQCs/Vrn/dMScIHdRSTLP2U2MDtSfyx5sGqFJfdUQ0iwDb2nz8e6/oo+f
         cULYljeelZ/J1YuU/SOCVz/2iV4TCE/M9dRBADoAEIGPAzvOCWwSxBryP38bw8vkc+QO
         6oJhISVWE9wg31scLE7igq8JXLnjgw5UwCcKqJiIkkqzLa5Wi7So8TTRsrlarpTjx3Ak
         wBG69sv++gGuSPsnpcVmjD1wdpoLoHOraiMKPb1rgi5aUfFvL8MHHUPxOOIbxZvIZMDr
         NyCE8GJBTaxdxKgoXVA//a5HYoQPnQMdbuhlpqvXicjY1gTiChH5bLdcuX4uPopCSTBN
         qVLw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785921901; x=1786526701; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qSPlmzZwsggqkOekQQNlyHJCqbwcPOcbrrGQp2BzoG0=;
        b=btIayQB5jsY6SgV8NhKfaelZdjjjy3S1+xYO2iR6A+qEjYVD6K/hUrpe+suJRF+a5/
         /pKrWAsl1ajbGLo4lpfXGlruQFNxutWf3YWCN9eiRnlPt5deW2KYfv9NCHMUhLidoU0z
         t+CiQGkCVgaK1R8l0TLbRTrBs0IegbZud7vzmHf0I8M5LAY9PHKjFwa0XFK+qWs4cbNG
         IvAUEBCeAz4xbhvqaOmKNH+e7u6zNrUFmzkDIuhdU/frnkOpnPlSCqYIE73ig32Ne7vO
         aCXiuvz6ExX8pxNAwNOIs38Djhvsz/L2dCrR83GI98/NhJmeymMw3e+EdX7ClTGEhWle
         XSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785921901; x=1786526701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qSPlmzZwsggqkOekQQNlyHJCqbwcPOcbrrGQp2BzoG0=;
        b=V+fvKq3yYrOFSI+YHlyKa7sNOnI7fFMwF77ox1jVXbOR+7lMXa7pbDKm1xUqJUgleY
         pOWwzkaeIw9T3LNKtupyK/eVwvk074mByLj8ULX7TZxnrQTh2TIEGd1+RT6MbExAKCra
         JpOY1w/xyn74iI2CPOg3IJnIiq14rkHggOIfQtYi0KS5JdS9+3dULJzr6PQ+ZwUJ0sXT
         dWh+IIeeX7MMTV4c409ZQwndQuYaC6y2OLJoVy7CpjeKntUY8tYk578Gv7Q58VMuiSKd
         8t4F6hhetStONI1Dlp8jWItoaKOZjwBV2Pycx0WinF4t6lyLe5rbvW5RIH63Tm2pgolv
         9K2Q==
X-Forwarded-Encrypted: i=1; AHgh+RrFl+FiZKH+zBNCLxh8EujR/4zlpRxeCHzQUq1I3EZD6dQlLIGkd3OFkcjFqW1djmVRTNXkopcnJbfkM/4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxpKC4J1Zs+Dya5sELoCgMOeAWNC4NmsMg23036z6T3hK1LiGHQ
	qj4lG5IDxaWKX/wr1+tEDezDfwKYz0hyvSAm6MxJwCHbMJV9y613A2ez1B+g32u8sRxEW5jJlgq
	44kf4mqHg6Z0i7VajWbSg5tInCmHrtDM=
X-Gm-Gg: AR+sD130XEbOx94NpxdDql5TAUOirs0eHgNaOt6nwnov6+WiQzwMbIfqJTHwNcCCLAH
	A+o2mEXLjnQ9EMgVcHyoZtAdMnm7YbU+Zn66nKg4PFWKsIg42IkLxIRM6KJYAYzAg0e26+uuWTI
	klSVKTkbEaQm7efiLXyiMUh76/sL/RzOm5hAZsdx79H3PseZvEq4jRBTgvkrczV92Y3/tvzpawW
	JfeeZLlCm/u0dl8Cwe1CAAB5UHevt4Ik5LLkNLyVQCX/ig41lX5TQhkeQrfRsoMxjenMNNaSRVr
	4k7wRIf/vXTrnZ4ncbO27CGhC0chYTICiSie/Xyd9PItRPguMC8+BUajvAL38sIgtlxZrMp4Rx5
	EEN5Yp/TKCnG7AbQikeH4HTULkPKQRYw=
X-Received: by 2002:a05:6402:324d:b0:6a0:ecc9:79ad with SMTP id
 4fb4d7f45d1cf-6a14f27eb8cmr2228403a12.20.1785921900591; Wed, 05 Aug 2026
 02:25:00 -0700 (PDT)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com> <20260803-alpha-fp-exceptions-v1-3-c99d75608e60@gmail.com>
In-Reply-To: <20260803-alpha-fp-exceptions-v1-3-c99d75608e60@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 5 Aug 2026 11:24:49 +0200
X-Gm-Features: AUfX_mxgtVLgty6ZSSWmZDWVsSh5RDmDpXo4b-wthWWUZZbeYh47JBHlTiBKreQ
Message-ID: <CA+=Fv5QUxT-T0XgXccAF=1_6Dz=nCpY=NQu=ruOrYjbB+q7YCA@mail.gmail.com>
Subject: Re: [PATCH 3/3] alpha: determine tininess after rounding in the FP emulation
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 1:40=E2=80=AFAM Matt Turner <mattst88@gmail.com> wro=
te:
>
> IEEE 754 lets an architecture determine tininess of a floating-point
> result either before or after rounding, but requires the same choice for
> every operation.  Alpha determines it after rounding, and stdlib's
> tst-tininess confirms the hardware does so for the results it produces
> itself.
>
> The soft-fp emulation has no notion of the distinction and always
> determines tininess before rounding, so a result that the hardware would
> not consider tiny is reported as underflowing whenever the instruction
> happens to trap for software completion.  The two paths then disagree on
> the same machine.  A multiply of the largest subnormal double by
> 1 + 2^-52 rounds up to the smallest normal and raises no underflow when
> the operands are normal, but raises it when an operand is subnormal and
> the instruction traps:
>
>   glibc math testsuite, test-float32x-float64-mul:
>     Failure: mul_double (0x3.ffffffffffffcp-1024, 0x1.0000000000001p+0):
>     Exception "Underflow" set
>
> Add _FP_TININESS_AFTER_ROUNDING, as glibc's copy of soft-fp has, and set
> it for alpha.  It determines tininess by rounding a copy of the result as
> if the exponent range were unbounded, which is what the definition asks
> for; a plain check of whether the rounded result came out normal is not
> equivalent and would be wrong for values that stay tiny under an
> unbounded exponent range but round up to the smallest normal in the
> subnormal grid.  The macro defaults to zero, so powerpc, sh and sparc
> keep determining tininess before rounding as they do now.
>
> Cc: stable@vger.kernel.org # 5.15+
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/include/asm/sfp-machine.h |  4 ++++
>  include/math-emu/op-common.h         | 23 +++++++++++++++++++++--
>  include/math-emu/soft-fp.h           |  8 ++++++++
>  3 files changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/arch/alpha/include/asm/sfp-machine.h b/arch/alpha/include/as=
m/sfp-machine.h
> index 5fe63afbd474..bff1ad963c68 100644
> --- a/arch/alpha/include/asm/sfp-machine.h
> +++ b/arch/alpha/include/asm/sfp-machine.h
> @@ -59,6 +59,10 @@
>      R##_c =3D FP_CLS_NAN;                                               =
 \
>    } while (0)
>
> +/* Alpha determines tininess after rounding, so the emulation must do th=
e
> +   same as the hardware does for the results it produces itself.  */
> +#define _FP_TININESS_AFTER_ROUNDING    1
> +
>  /* Obtain the current rounding mode. */
>  #define FP_ROUNDMODE   mode
>  #define FP_RND_NEAREST (FPCR_DYN_NORMAL >> FPCR_DYN_SHIFT)
> diff --git a/include/math-emu/op-common.h b/include/math-emu/op-common.h
> index 8ce066c035cf..1d1ce5c08efc 100644
> --- a/include/math-emu/op-common.h
> +++ b/include/math-emu/op-common.h
> @@ -135,6 +135,24 @@ do {                                                =
               \
>      else                                                       \
>        {                                                                \
>         /* we've got a denormalized number */                   \
> +       int _FP_PACK_CANONICAL_is_tiny =3D 1;                     \
> +       if (_FP_TININESS_AFTER_ROUNDING && X##_e =3D=3D 0)          \
> +         {                                                     \
> +           /* Architectures that detect tininess after rounding        \
> +              only signal underflow if the result is still             \
> +              subnormal once rounded as if the exponent range  \
> +              were unbounded.  Round a copy to find out.  */   \
> +           FP_DECL_##fs(_FP_PACK_CANONICAL_T);                 \
> +           /* The class field is not used by the rounding below,       \
> +              and is unused entirely where this block is dead.  */     \
> +           (void)_FP_PACK_CANONICAL_T##_c;                     \
> +           _FP_FRAC_COPY_##wc(_FP_PACK_CANONICAL_T, X);        \
> +           _FP_PACK_CANONICAL_T##_s =3D X##_s;                   \
> +           _FP_PACK_CANONICAL_T##_e =3D X##_e;                   \
> +           _FP_ROUND(wc, _FP_PACK_CANONICAL_T);                \
> +           if (_FP_FRAC_OVERP_##wc(fs, _FP_PACK_CANONICAL_T))  \
> +             _FP_PACK_CANONICAL_is_tiny =3D 0;                   \
> +         }                                                     \
>         X##_e =3D -X##_e + 1;                                     \
>         if (X##_e <=3D _FP_WFRACBITS_##fs)                        \
>           {                                                     \
> @@ -161,8 +179,9 @@ do {                                                 =
               \
>                     _FP_FRAC_SRL_##wc(X, _FP_WORKBITS);         \
>                   }                                             \
>               }                                                 \
> -           if ((FP_CUR_EXCEPTIONS & FP_EX_INEXACT) ||          \
> -               (FP_TRAPPING_EXCEPTIONS & FP_EX_UNDERFLOW))     \
> +           if (_FP_PACK_CANONICAL_is_tiny                      \
> +               && ((FP_CUR_EXCEPTIONS & FP_EX_INEXACT) ||      \
> +                   (FP_TRAPPING_EXCEPTIONS & FP_EX_UNDERFLOW)))        \
>                 FP_SET_EXCEPTION(FP_EX_UNDERFLOW);              \
>           }                                                     \
>         else                                                    \
> diff --git a/include/math-emu/soft-fp.h b/include/math-emu/soft-fp.h
> index 5650c1628383..02ada0a9fca1 100644
> --- a/include/math-emu/soft-fp.h
> +++ b/include/math-emu/soft-fp.h
> @@ -31,6 +31,14 @@
>  #include <endian.h>
>  #endif
>
> +/* Whether the architecture determines tininess of a floating-point
> +   result after rounding rather than before it.  IEEE 754 permits either
> +   but requires the same choice for every operation, so this has to agre=
e
> +   with what the hardware does for the results it produces itself.  */
> +#ifndef _FP_TININESS_AFTER_ROUNDING
> +#define _FP_TININESS_AFTER_ROUNDING    0
> +#endif
> +
>  #define _FP_WORKBITS           3
>  #define _FP_WORK_LSB           ((_FP_W_TYPE)1 << 3)
>  #define _FP_WORK_ROUND         ((_FP_W_TYPE)1 << 2)
>
> --
> 2.54.0
>

Hi,

The generic soft-fp policy switch together with the Alpha-specific
selection looks like the right approach. The default preserves the
existing behaviour for the other soft-fp users, so I do not see an
expected behavioural change outside Alpha.

I tested the complete series with CONFIG_MATHEMU=3Dy on the same machine
and using the same glibc build. The kernel boots normally, and the
glibc math testsuite improves from 48 to 28 failing test programs, with
no new failing tests. In particular, math/test-float32x-float64-mul,
which exercises the incorrect tininess handling described in the commit
message, now passes.

Reviewed-by: Magnus Lindholm linmag7@gmail.com
Tested-by: Magnus Lindholm linmag7@gmail.com

