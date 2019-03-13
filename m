Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFC9C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 20:19:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EDF5206DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 20:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDF5206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KNV65BgPzDqJ7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 07:19:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KNSH4xYjzDqGL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 07:17:51 +1100 (AEDT)
Received: by mail-ot1-f68.google.com with SMTP id i5so2986442oto.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 13:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g/mXpmakv6imNbTS8MmVhOFORBB0KE0VQhcEqeFl01w=;
 b=Y/J6ajwWVnbrmdn4D60Sq/ic2PCUH4m1usF0Jdap089vjjC2UsE22stli3+JilGstq
 DJQpoX19L0fOjT0F04Knvq+F2vmgS8hG3Zyicx9hTFsdP/Wb4LjS1DfpRI+28YO53MQN
 83AzkeVLnpw3qeE7zp0wASEShJETYGYmu+p4eF4m8j25mhrJPEL1/qSMzrzg5wBKqVdv
 pkhFTBjEelG36J1ItiYvYXxkdehF3XxsJe5uizWkjus5DBk01UC9fz+OnK+jJEXo890Z
 AiAzQcHjvhg5bK8o+sfX79ey0RCyUJgKRXGcRLrmkrLcORWf3TeepxRwEZtXpWXSRzv3
 B2qg==
X-Gm-Message-State: APjAAAXCEU06er/xlskSzQNp9uhv8ahmUfDJsTMhgbPUUMjUt6aP6wW+
 MoYVmfQUrke6LnqS6DY+1eg/+UhlTtUoLt+cCHvQdw==
X-Google-Smtp-Source: APXvYqx24alyJ3Yt4w8D8c4j43I99OkdaVG7ntyqaOkKqOAwOclQEbGJQ4yCCPfaIzDOm0+GQ5xFszCNoRUzg/XZ2pw=
X-Received: by 2002:a9d:7841:: with SMTP id c1mr29656545otm.354.1552508268714; 
 Wed, 13 Mar 2019 13:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <1550223519-18290-1-git-send-email-yamada.masahiro@socionext.com>
 <CA+7wUswJ5+nb3OdZYrx6++batRMUcnje3jLTgdN4zAQo=--xBg@mail.gmail.com>
 <CAK7LNAQUEivnhFnmkP+5uCHRJcYWDtK_fm2gB0rsbzGv1taBCg@mail.gmail.com>
In-Reply-To: <CAK7LNAQUEivnhFnmkP+5uCHRJcYWDtK_fm2gB0rsbzGv1taBCg@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 13 Mar 2019 21:17:37 +0100
Message-ID: <CA+7wUsxruu0GdyRGJ3vsjRvSBAptMn8_f5BmeMo=-E3zbhGGxQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: use $(origin ARCH) to select KBUILD_DEFCONFIG
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Feb 16, 2019 at 3:26 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Sat, Feb 16, 2019 at 1:11 AM Mathieu Malaterre <malat@debian.org> wrote:
> >
> > On Fri, Feb 15, 2019 at 10:41 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > I often test all Kconfig commands for all architectures. To ease my
> > > workflow, I want 'make defconfig' at least working without any cross
> > > compiler.
> > >
> > > Currently, arch/powerpc/Makefile checks CROSS_COMPILE to decide the
> > > default defconfig source.
> > >
> > > If CROSS_COMPILE is unset, it is likely to be the native build, so
> > > 'uname -m' is useful to choose the defconfig. If CROSS_COMPILE is set,
> > > the user is cross-building (i.e. 'uname -m' is probably x86_64), so
> > > it falls back to ppc64_defconfig. Yup, make sense.
> > >
> > > However, I want to run 'make ARCH=* defconfig' without setting
> > > CROSS_COMPILE for each architecture.
> > >
> > > My suggestion is to check $(origin ARCH).
> > >
> > > When you cross-compile the kernel, you need to set ARCH from your
> > > environment or from the command line.
> > >
> > > For the native build, you do not need to set ARCH. The default in
> > > the top Makefile is used:
> > >
> > >   ARCH            ?= $(SUBARCH)
> > >
> > > Hence, $(origin ARCH) returns 'file'.
> > >
> > > Before this commit, 'make ARCH=powerpc defconfig' failed:
> >
> > In case you have not seen it, please check:
> >
> > http://patchwork.ozlabs.org/patch/1037835/
>
>
> I did not know that because I do not subscribe to ppc ML.
>
>
> Michael's patch looks good to me.

OK

>
> If you mimic x86, the following will work:
>

Nice! Michael do you have a preference ?

>
>
> diff --git a/Makefile b/Makefile
> index 86cf35d..eb9552d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -356,6 +356,11 @@ ifeq ($(ARCH),sh64)
>         SRCARCH := sh
>  endif
>
> +# Additional ARCH settings for powerpc
> +ifneq ($(filter ppc%,$(ARCH)),)
> +       SRCARCH := powerpc
> +endif
> +
>  KCONFIG_CONFIG ?= .config
>  export KCONFIG_CONFIG
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 488c9ed..ff01fef 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -34,10 +34,10 @@ ifdef CONFIG_PPC_BOOK3S_32
>  KBUILD_CFLAGS          += -mcpu=powerpc
>  endif
>
> -ifeq ($(CROSS_COMPILE),)
> -KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
> -else
> +ifeq ($(ARCH),powerpc)
>  KBUILD_DEFCONFIG := ppc64_defconfig
> +else
> +KBUILD_DEFCONFIG := $(ARCH)_defconfig
>  endif
>
>  ifdef CONFIG_PPC64
> diff --git a/scripts/subarch.include b/scripts/subarch.include
> index 6506828..c98323f 100644
> --- a/scripts/subarch.include
> +++ b/scripts/subarch.include
> @@ -8,6 +8,6 @@ SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e
> s/x86_64/x86/ \
>                                   -e s/sun4u/sparc64/ \
>                                   -e s/arm.*/arm/ -e s/sa110/arm/ \
>                                   -e s/s390x/s390/ -e s/parisc64/parisc/ \
> -                                 -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
> +                                 -e s/mips.*/mips/ \
>                                   -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
>                                   -e s/riscv.*/riscv/)
>
>
>
>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada
