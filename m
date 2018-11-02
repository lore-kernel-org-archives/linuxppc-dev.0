Return-Path: <SRS0=pcIm=NN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84153C65C22
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 16:56:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7D82082E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 16:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DgLksOhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7D82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mpBZ4q4XzF389
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 03:56:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="DgLksOhe";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="DgLksOhe"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mp8445b3zF35y
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Nov 2018 03:54:28 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id w7so1213719pgp.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Nov 2018 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9WNOZCKj6peeyNKP+UaQ8WwdNYWZMKGYZ6GZi+ZsIac=;
 b=DgLksOhetWgDxWZbhwxhj0kuLVRAM+OZvLkdIDqPY5shzgGQpiCOSsk3JOVHdzRZdG
 xk1vCIac56dxVl39FLxRdHufRa20v5nspdyk4uCSl4chSKiR9SYRviu1/AoHIgnLix4o
 FBYbcuiseZjLIqz6BLPPDsIaiGj3V/Gcpc+qwb3Or4DGkYYsVwUY2m92lVhy7VLE8x3x
 a9lyWzM7iQCPqFNGWesekYvKvcr+PiBhR8Fyd8V28UBaQsr3E8olB4T8GfQ/MKes2Ewb
 iydNQ+dsROYOaAvItkM5mp8EU1TPqs6gS8OGzOZHqFjSJ1+6rOtL9YaFAJu4UKPTBoy1
 jjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9WNOZCKj6peeyNKP+UaQ8WwdNYWZMKGYZ6GZi+ZsIac=;
 b=ijed3RRBTAlSjRnp1LlnTBT7ip7Gb0S0Or7h/zOvFF30NEdWwavFUQj5yg4U4CRoWX
 ExyI5Xt7/e0Dpe1BLs4T1m7DsI++i59nE6rm2Ki4r41mJ5nhNsEX4u/mIk/sElNQCVZ6
 XzxRqhU+vo3uYuGQ+0ovBLASjFKWBZtNOuvLuxNVsHwtx7qfK/aIB+e6yrsrD9DqmE9t
 Jupv+PhvPgB3LnH1Pa9J4YFe7qnTiyoWqYW+S9O2Hs95JGdOJj6xneAOKdzYBlPsj4A3
 If/m8XA9mCmn+n/yeRuyA1AxfympCct9yYsxcOtuicJcLHtKk1bqUK8KftQEzRuFvm6/
 776Q==
X-Gm-Message-State: AGRZ1gL7yDID5dGgGES5htWk9rMPoyUd1pzAmsPSD0CrkmGP0e8oQ6i7
 GKIWe4j/Nv/1qCaVQklPatbuZO/jtQpzaRgJ46voUOoYQrH8+w==
X-Google-Smtp-Source: AJdET5fUBUm7SHXWR8H6U6mOFNdyz36HukPCsHMYj0qmOpvpTQ6MUhtbm2ZplGPXUMR+ym8iviuo+fW22gqTx/tNY5k=
X-Received: by 2002:a62:1095:: with SMTP id
 21-v6mr12298541pfq.227.1541177666055; 
 Fri, 02 Nov 2018 09:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181102033713.31916-1-joel@jms.id.au>
In-Reply-To: <20181102033713.31916-1-joel@jms.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 2 Nov 2018 09:54:14 -0700
Message-ID: <CAKwvOdnVr8_bg-ND29PWihzdD_YVcGH6z+0zHZhK8nEv-k0-2A@mail.gmail.com>
Subject: Re: [PATCH] powerpc/math-emu: Fix building with clang
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

On Thu, Nov 1, 2018 at 8:37 PM Joel Stanley <joel@jms.id.au> wrote:
>
>   make CC=clang-8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-  ppc44x_defconfig
>   make CC=clang-8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-
>
>   ...
>
>   arch/powerpc/math-emu/fnmsub.c:46:2: error: invalid use of a cast in a
>   inline asm context requiring an l-value: remove the cast or build with
>   -fheinous-gnu-extensions
>           FP_ADD_D(R, T, B);
>           ^~~~~~~~~~~~~~~~~
>   ./include/math-emu/double.h:110:27: note: expanded from macro 'FP_ADD_D'
>   #define FP_ADD_D(R,X,Y)                 _FP_ADD(D,2,R,X,Y)
>                                           ^~~~~~~~~~~~~~~~~~
>   ./include/math-emu/op-common.h:367:34: note: expanded from macro '_FP_ADD'
>   #define _FP_ADD(fs, wc, R, X, Y) _FP_ADD_INTERNAL(fs, wc, R, X, Y, '+')
>                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ./include/math-emu/op-common.h:264:4: note: expanded from macro '_FP_ADD_INTERNAL'
>             _FP_FRAC_ADD_##wc(R, X, Y);                                        \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~
>   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)

^^^ Hi Joel, would you mind recompiling with
`-fmacro-backtrace-limit=0` hacked in and including the full
backtrace?  I'm curious if there's a more appropriate fix, but can't
tell where the inline asm is that clang is complaining about.

>   ./include/math-emu/op-2.h:94:27: note: expanded from macro '_FP_FRAC_ADD_2'
>     __FP_FRAC_ADD_2(R##_f1, R##_f0, X##_f1, X##_f0, Y##_f1, Y##_f0)
>     ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/260
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/powerpc/math-emu/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/math-emu/Makefile b/arch/powerpc/math-emu/Makefile
> index 494df26c5988..b9cb797445ac 100644
> --- a/arch/powerpc/math-emu/Makefile
> +++ b/arch/powerpc/math-emu/Makefile
> @@ -18,3 +18,7 @@ CFLAGS_fabs.o = -fno-builtin-fabs
>  CFLAGS_math.o = -fno-builtin-fabs
>
>  ccflags-y = -I. -Iinclude/math-emu -w
> +
> +ifdef CONFIG_CC_IS_CLANG
> +ccflags-y += -fheinous-gnu-extensions
> +endif
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
