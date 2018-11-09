Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB3CC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 18:11:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6E520825
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 18:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UcSV4n3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6E520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42s7Wp4553zF3dq
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 05:11:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="UcSV4n3k";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="UcSV4n3k"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42s7Sz3GltzF3fB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 05:09:07 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id z10so1166256pgp.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Nov 2018 10:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nTDuuew0NsZhhb2bxhxcr153BE8+fnPPLRQbpDhPrd4=;
 b=UcSV4n3kcdGjr2QJ2lfpleDryWk897/SqMXB+J+CzIh/OoE5iDWlj5xREz6Vk6Zg4G
 9z+uKTR8jM7ZHVkP0TLX1oNQJPYCy7hVjdqftFlCJTA1gZtpiF15c6dgDqipzzEhI4V3
 2QhV+qzP/OwHFyIZLLNwr8KG8l03xKtq+kN9kH1NMYABYnlyckU7Rfi23IHJvBqiM1/S
 VbNcG1cLdh+fJrCm9owbcM9nAU0kO1G/+kxMqsqqKuWeWUjraUy81fCvOakNJVQHG3yK
 s1I8L+1vVFUgtyRwZErYVaXBYxMEwCKP4Qp5dwd0FbTpsHI25Adhmnzz/sfFxqiM/9Yv
 KjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nTDuuew0NsZhhb2bxhxcr153BE8+fnPPLRQbpDhPrd4=;
 b=jgyxcu/PykMM2k65IZngAeGRvelJQwdK3KmaHtsD68xDOIBAADpMmQuT/7KbKKn8yD
 9nlN2YHCvCy+V2wP7JqVSfYAdOV85c4jRtKqxsFv77KSbVFke1QLfoaO8sgllUKIiwsY
 d7Mge0CY7hj9UXOKGN4bLgnZzO85tC0wvGuoE7k+w4JfWbzAF188cBcWPcnYl2Kx4Ir4
 qBEgJdsnA8Mk2H1lThH39IP9RN6C3RFS5BAxvin9IRu9AoXwWGAfy9tOc8+oJi9zOJ8b
 yM/V2GlYZbX6pFigxLgLiF3oETpBX3Q00ruqAPtTRRCfO7sP+aT2O8BSQB2biygLH1TK
 hH0Q==
X-Gm-Message-State: AGRZ1gLXeWqrSYT685vA0DCzfN9euQ2x9yiG4CA36LKni3ttPRbvetqY
 FTfsU1/UKBzOPsZE2n24V4wov5hin5hG1XyBTRI4mA==
X-Google-Smtp-Source: AJdET5dldSw9wyZPWg7QhrkDHD/f3FbXQ8IIL4M48Yia0wV6zoP78APvYBX63QOd7GjaUk4kWrvQTbPPZfVcBCdQaZM=
X-Received: by 2002:a62:1095:: with SMTP id
 21-v6mr9868632pfq.227.1541786944730; 
 Fri, 09 Nov 2018 10:09:04 -0800 (PST)
MIME-Version: 1.0
References: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 9 Nov 2018 10:08:53 -0800
Message-ID: <CAKwvOdkfGZDWr5vjNTvn707+Muna3JNKObwOfjjvS2-tAXK2QA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: add -no-integrated-as Clang option
 unconditionally
To: Masahiro Yamada <yamada.masahiro@socionext.com>
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
Cc: Michal Marek <michal.lkml@markovi.net>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>,
 Matthias Kaehlcke <mka@chromium.org>, joel@jms.id.au,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 5, 2018 at 7:05 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> We are still a way off the Clang's integrated assembler support for
> the kernel. Hence, -no-integrated-as is mandatory to build the kernel
> with Clang. If you had an ancient version of Clang that does not
> recognize this option, you would not be able to compile the kernel
> anyway.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - New patch
>
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 93315eb..da11700 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -497,8 +497,8 @@ CLANG_GCC_TC        := --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
>  KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>  KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> -KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
> -KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
> +KBUILD_CFLAGS += -no-integrated-as
> +KBUILD_AFLAGS += -no-integrated-as

Sorry for the delay in review.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

>  endif
>
>  RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
> --
> 2.7.4
>


-- 
Thanks,
~Nick Desaulniers
