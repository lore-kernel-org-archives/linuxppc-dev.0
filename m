Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C567C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 18:32:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9DD020827
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 18:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EHwfvC4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DD020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42s7zV5lRbzF3Zg
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 05:32:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="EHwfvC4p";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="EHwfvC4p"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42s7ws3zCNzF3YD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 05:29:49 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id u13-v6so1294771pfm.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Nov 2018 10:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oO+HpkLidr/CeyCYN5af7zvbZoEkI1LAH8/hbiIoRMM=;
 b=EHwfvC4pP8WkPe68hfbEAlVnco5DhCMjbh+GSZdeTxVtAZow7aqK1QlpCWf+RMiA0r
 UmwFD9sxQHOA5xxQYZxl4xlAgdH5gMb3Igyg8TlrMuW8GJV/5+BXDMAzWK0cojjDnOGB
 QnY/OB6V42G+e2b1TfFGdl7XafFOssUJj7rhArVct5Mh9tWqoVdFXuWVTiRus+5ZKa9Q
 ADyddMBbA2IOqpVTkJhWCMx1RQwEYD2hiLp3SiYyymNj6Sk+bNhhHgpPcclvuMFWil3l
 QvP0Mm6GgXKaVFZv6JFsZvubzCxB2BYhsIaYsGPue2VmG/OYbWTXN1ynRwpYzYXOPdYn
 L09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oO+HpkLidr/CeyCYN5af7zvbZoEkI1LAH8/hbiIoRMM=;
 b=JMQ9adEctbr2mG6aZltBLj8wt5xRxc5MevU81oyZ2F/Jbao4eA8pv4cYSm5dzXBxaf
 2BkSnpTZik28gVG9nRRoq0oXh3wTJItUW4dL3TTkPkjsaE1wlrBXBpFuXnZ0Fq/dwlGR
 Hzs4ViT9AnMSSd6eZwk4l5nV4wC6hWtGia5iCo0TQaVjqjx0aEO6/WShkoGe3kXbzwQq
 XvVQq4lqC6Y4hi1w7vmN53Hw0gB9efswBet02T4XHrCgNec30Vwt7Atk0Ui7c16Yvgeu
 rYOJ4tEsfNihYBNwx+jiCS9FbIL+6oJV4ypm372jmm08LTGkBv+qKLHdZTVgk2vZDsHA
 VQDw==
X-Gm-Message-State: AGRZ1gLAs57iu41p5IDv5jjhadpAlxDjnsmzPjmrK6NJ+nG+ti3+ypRH
 8bW+UmvoKS3fbYQdiPuJWGQeLH0+WMoSqV8GkQs1MQ==
X-Google-Smtp-Source: AJdET5fwVRo+ONH8SN2tKhWFTUuEhLBx/GtTiqw6NU31rCHI1fKcO2geN6e0Lgx5d4PhmdX/qIhsel1HxbvbkC36A1I=
X-Received: by 2002:a62:1095:: with SMTP id
 21-v6mr9933616pfq.227.1541788186599; 
 Fri, 09 Nov 2018 10:29:46 -0800 (PST)
MIME-Version: 1.0
References: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com>
 <1541473495-25262-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1541473495-25262-2-git-send-email-yamada.masahiro@socionext.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 9 Nov 2018 10:29:35 -0800
Message-ID: <CAKwvOd=JwjVu=uk3egVJxTm9vPcF=Jx2Bexx1Wx=Z-PC38X3Uw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: consolidate Clang compiler flags
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
 Greg Hackmann <ghackmann@google.com>,
 Nathan Chancellor <natechancellor@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 5, 2018 at 7:05 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Collect basic Clang options such as --target, --prefix, --gcc-toolchain,
> -no-integrated-as into a single variable CLANG_FLAGS so that it can be
> easily reused in other parts of Makefile.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>  - Use := flavor instead of = because $(CLANG_FLAGS) is expanded soon anyway
>
>  Makefile | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index da11700..e173a73 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -487,18 +487,17 @@ endif
>
>  ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
>  ifneq ($(CROSS_COMPILE),)
> -CLANG_TARGET   := --target=$(notdir $(CROSS_COMPILE:%-=%))
> +CLANG_FLAGS    := --target=$(notdir $(CROSS_COMPILE:%-=%))
>  GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
> -CLANG_PREFIX   := --prefix=$(GCC_TOOLCHAIN_DIR)
> +CLANG_FLAGS    += --prefix=$(GCC_TOOLCHAIN_DIR)
>  GCC_TOOLCHAIN  := $(realpath $(GCC_TOOLCHAIN_DIR)/..)
>  endif
>  ifneq ($(GCC_TOOLCHAIN),)
> -CLANG_GCC_TC   := --gcc-toolchain=$(GCC_TOOLCHAIN)
> +CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
> -KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> -KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> -KBUILD_CFLAGS += -no-integrated-as
> -KBUILD_AFLAGS += -no-integrated-as
> +CLANG_FLAGS    += -no-integrated-as
> +KBUILD_CFLAGS  += $(CLANG_FLAGS)
> +KBUILD_AFLAGS  += $(CLANG_FLAGS)
>  endif
>
>  RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
> --
> 2.7.4
>

Thanks for this patch, Masahiro, it's a good simplification.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Would you mind waiting for a tested-by from Stefan, and maybe an ack
from Greg (added to cc)?
-- 
Thanks,
~Nick Desaulniers
