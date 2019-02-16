Return-Path: <SRS0=Luu/=QX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2128C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 02:27:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FE9222D9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 02:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="j/2FkjGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FE9222D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 441Ytv6f9mzDqdf
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 13:27:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.82; helo=conssluserg-03.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="j/2FkjGE"; 
 dkim-atps=neutral
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 441Ys41l6JzDqCs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2019 13:25:58 +1100 (AEDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id x1G2PdBf030076
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2019 11:25:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x1G2PdBf030076
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1550283940;
 bh=kYWVuWCPdFD9cz/1DU1jn/YsGrYBPicxpCpcOQRS/wY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=j/2FkjGEcQ4vsg5o6IkCYWmyWxGUDxxjgyx8xdxqGo2WFgEyA487vi+n+Cr8ip16O
 wjUFuCrA/ie5mLl0woCMgmBZhGHl+4qhmv9/BCfbuBZe9nutlC0lI/N/CJljdSq38j
 xZqli8xUPRtaLDfX1HjbOxxQzlaAvxak1bC15rYGoq7DK8NUTUe7cbnmqM+6xM/npa
 je+irbjjKfKdOeBKowvhrjHJuo+yMYNB9iZF3qud8MnHGYbAai7csQ0xv4l2juSCKg
 GzK4ZMjCE3Pr/qxADFT0uVtoPaeLs9PrpfeuO4v38RBwzsDLKehuUzNKdgYYo8+Oke
 7ef3WdvljAUfw==
X-Nifty-SrcIP: [209.85.221.175]
Received: by mail-vk1-f175.google.com with SMTP id f206so2694005vke.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 18:25:40 -0800 (PST)
X-Gm-Message-State: AHQUAubhLCwnOAAlk14S3UKSwc8/zV2VcquJWGjfXageJfRwrjrkdcIW
 uTLPNoAAMuVaAf023Y2/6s4p9QKvXAj20Xu3WXc=
X-Google-Smtp-Source: AHgI3IZclZ5dbPYZ12FlprJt8qA2NuZiiS3TMi9wSTD0Iu4Bfqz98SLsaZbmUmMIJyrOJqJCECqxsaDKAzsgDc9d+vI=
X-Received: by 2002:a1f:9350:: with SMTP id v77mr6703657vkd.64.1550283939252; 
 Fri, 15 Feb 2019 18:25:39 -0800 (PST)
MIME-Version: 1.0
References: <1550223519-18290-1-git-send-email-yamada.masahiro@socionext.com>
 <CA+7wUswJ5+nb3OdZYrx6++batRMUcnje3jLTgdN4zAQo=--xBg@mail.gmail.com>
In-Reply-To: <CA+7wUswJ5+nb3OdZYrx6++batRMUcnje3jLTgdN4zAQo=--xBg@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 16 Feb 2019 11:25:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQUEivnhFnmkP+5uCHRJcYWDtK_fm2gB0rsbzGv1taBCg@mail.gmail.com>
Message-ID: <CAK7LNAQUEivnhFnmkP+5uCHRJcYWDtK_fm2gB0rsbzGv1taBCg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: use $(origin ARCH) to select KBUILD_DEFCONFIG
To: Mathieu Malaterre <malat@debian.org>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Feb 16, 2019 at 1:11 AM Mathieu Malaterre <malat@debian.org> wrote:
>
> On Fri, Feb 15, 2019 at 10:41 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > I often test all Kconfig commands for all architectures. To ease my
> > workflow, I want 'make defconfig' at least working without any cross
> > compiler.
> >
> > Currently, arch/powerpc/Makefile checks CROSS_COMPILE to decide the
> > default defconfig source.
> >
> > If CROSS_COMPILE is unset, it is likely to be the native build, so
> > 'uname -m' is useful to choose the defconfig. If CROSS_COMPILE is set,
> > the user is cross-building (i.e. 'uname -m' is probably x86_64), so
> > it falls back to ppc64_defconfig. Yup, make sense.
> >
> > However, I want to run 'make ARCH=* defconfig' without setting
> > CROSS_COMPILE for each architecture.
> >
> > My suggestion is to check $(origin ARCH).
> >
> > When you cross-compile the kernel, you need to set ARCH from your
> > environment or from the command line.
> >
> > For the native build, you do not need to set ARCH. The default in
> > the top Makefile is used:
> >
> >   ARCH            ?= $(SUBARCH)
> >
> > Hence, $(origin ARCH) returns 'file'.
> >
> > Before this commit, 'make ARCH=powerpc defconfig' failed:
>
> In case you have not seen it, please check:
>
> http://patchwork.ozlabs.org/patch/1037835/


I did not know that because I do not subscribe to ppc ML.


Michael's patch looks good to me.


If you mimic x86, the following will work:




diff --git a/Makefile b/Makefile
index 86cf35d..eb9552d 100644
--- a/Makefile
+++ b/Makefile
@@ -356,6 +356,11 @@ ifeq ($(ARCH),sh64)
        SRCARCH := sh
 endif

+# Additional ARCH settings for powerpc
+ifneq ($(filter ppc%,$(ARCH)),)
+       SRCARCH := powerpc
+endif
+
 KCONFIG_CONFIG ?= .config
 export KCONFIG_CONFIG

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 488c9ed..ff01fef 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -34,10 +34,10 @@ ifdef CONFIG_PPC_BOOK3S_32
 KBUILD_CFLAGS          += -mcpu=powerpc
 endif

-ifeq ($(CROSS_COMPILE),)
-KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
-else
+ifeq ($(ARCH),powerpc)
 KBUILD_DEFCONFIG := ppc64_defconfig
+else
+KBUILD_DEFCONFIG := $(ARCH)_defconfig
 endif

 ifdef CONFIG_PPC64
diff --git a/scripts/subarch.include b/scripts/subarch.include
index 6506828..c98323f 100644
--- a/scripts/subarch.include
+++ b/scripts/subarch.include
@@ -8,6 +8,6 @@ SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e
s/x86_64/x86/ \
                                  -e s/sun4u/sparc64/ \
                                  -e s/arm.*/arm/ -e s/sa110/arm/ \
                                  -e s/s390x/s390/ -e s/parisc64/parisc/ \
-                                 -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
+                                 -e s/mips.*/mips/ \
                                  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
                                  -e s/riscv.*/riscv/)








--
Best Regards
Masahiro Yamada
