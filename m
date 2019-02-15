Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3375DC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 11:02:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CCDB21A80
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 11:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCDB21A80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4419MM6kNJzDqQt
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 22:02:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4419Jx5M2czDqdv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 22:00:17 +1100 (AEDT)
Received: by mail-ot1-f67.google.com with SMTP id m1so15851801otf.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 03:00:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VJ1w0R223NOFMFs8jprELV7OmTbW2Ho0cuabQNPRrxs=;
 b=KcoBuXOxi9jRLOlhRmqjQchRRVCKFCa3+4HhQEX1HScGMtUqzU9l5seBp7YOOol39Y
 iwLGX/AtyfqjtYjnKGp1D7cvY2TCu42yyFvKbPAntzG/FPI1aMzo5teT7o8phkWGLs48
 O9FZCQW3Jkk9ADo8PiQ6fic3vuMYrNzbiRlYPFFo9iSM6CTZ9Qo1ngx3InRzgvurGJ9X
 2TlON9jwPC4oQLrWmwl1jPvFYg+IJOPq14Skaj8Bp/2spMBI09ab6xwAcwNt7U/qG5du
 NZzojxX15Yw4hb64sdTxPy4bFdJUCHEUDKFfHHs67EZLrmZ9MtzidHZoQ9eUeTuxJzn2
 SzvQ==
X-Gm-Message-State: AHQUAubPIY0TC3BsXPegwI0ZZlly3x5haJsa3Ptsw8WMqnAhJplAscc6
 7y7jdXFo0y+ckm6TEziL5On42kHEbNyg/8yOBEU=
X-Google-Smtp-Source: AHgI3IYbfrX7AIolW1V7LYuCoKrAWyKC2jau6gRe6jftYyoteJKqHvv9ysv43HkUNysa0i4dhW/Ns56Ri67xY1q9ZKk=
X-Received: by 2002:a9d:6acc:: with SMTP id m12mr5051127otq.300.1550228415864; 
 Fri, 15 Feb 2019 03:00:15 -0800 (PST)
MIME-Version: 1.0
References: <1550223519-18290-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1550223519-18290-1-git-send-email-yamada.masahiro@socionext.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 15 Feb 2019 12:00:04 +0100
Message-ID: <CA+7wUswJ5+nb3OdZYrx6++batRMUcnje3jLTgdN4zAQo=--xBg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: use $(origin ARCH) to select KBUILD_DEFCONFIG
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 15, 2019 at 10:41 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I often test all Kconfig commands for all architectures. To ease my
> workflow, I want 'make defconfig' at least working without any cross
> compiler.
>
> Currently, arch/powerpc/Makefile checks CROSS_COMPILE to decide the
> default defconfig source.
>
> If CROSS_COMPILE is unset, it is likely to be the native build, so
> 'uname -m' is useful to choose the defconfig. If CROSS_COMPILE is set,
> the user is cross-building (i.e. 'uname -m' is probably x86_64), so
> it falls back to ppc64_defconfig. Yup, make sense.
>
> However, I want to run 'make ARCH=* defconfig' without setting
> CROSS_COMPILE for each architecture.
>
> My suggestion is to check $(origin ARCH).
>
> When you cross-compile the kernel, you need to set ARCH from your
> environment or from the command line.
>
> For the native build, you do not need to set ARCH. The default in
> the top Makefile is used:
>
>   ARCH            ?= $(SUBARCH)
>
> Hence, $(origin ARCH) returns 'file'.
>
> Before this commit, 'make ARCH=powerpc defconfig' failed:

In case you have not seen it, please check:

http://patchwork.ozlabs.org/patch/1037835/

>   $ make ARCH=powerpc defconfig
>   *** Default configuration is based on target 'x86_64_defconfig'
>   ***
>   *** Can't find default configuration "arch/powerpc/configs/x86_64_defconfig"!
>   ***
>
> After this commit, it will succeed:
>
>   $ make ARCH=powerpc defconfig
>   *** Default configuration is based on 'ppc64_defconfig'
>   #
>   # configuration written to .config
>   #
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/powerpc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index ac03334..f989979 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -34,7 +34,7 @@ ifdef CONFIG_PPC_BOOK3S_32
>  KBUILD_CFLAGS          += -mcpu=powerpc
>  endif
>
> -ifeq ($(CROSS_COMPILE),)
> +ifeq ($(origin ARCH), file)
>  KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
>  else
>  KBUILD_DEFCONFIG := ppc64_defconfig
> --
> 2.7.4
>
