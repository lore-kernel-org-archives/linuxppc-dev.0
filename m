Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B9CC4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Jul 2021 20:21:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F024A60F36
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Jul 2021 20:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F024A60F36
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GbzLs23p1z3cSd
	for <linuxppc-dev@archiver.kernel.org>; Sat, 31 Jul 2021 06:21:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20161025 header.b=JLaAC3h6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::229;
 helo=mail-lj1-x229.google.com; envelope-from=ndesaulniers@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=JLaAC3h6; dkim-atps=neutral
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GbzLL5V9cz2yMM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jul 2021 06:20:56 +1000 (AEST)
Received: by mail-lj1-x229.google.com with SMTP id h11so13984703ljo.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jul 2021 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6ZdxsXIhfZeShR0BpG7ZM9hlF98/ed3x62uZjV8NOlc=;
 b=JLaAC3h6i7sv+zobgB6FCO8AkNHOnE+QSegQ6bJPG6zSD18coezaJg3a+0CFIZQDfS
 8q2bUhPPeq8m6y39/0m8Oj0eweVmITzggzzvOvTbMRziX1ZII5ODNwmvKf5pQ2aAcIyR
 aejTL5OimVzszTLBmMh/RQY5fS6aDnBUyroYVcmtGcurAfL/38PbaRCFUlL8bEkPg2M6
 iI76uy2PSOch+Xjq8lgsVsP5Q7CyTB9B37NnsW/dBhrfXzwYpdNeOp7Sl5aILWZ13KJ5
 TvQtlXaQ1w+IqLoPVg9nOVqxFjaQA1nx72kNzlQ/DV8S+Ow1gRYts2kwwuBIlJeGLIkG
 Uu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6ZdxsXIhfZeShR0BpG7ZM9hlF98/ed3x62uZjV8NOlc=;
 b=gJ9+927nzUFKZo/a5e778B2C5s0g3uUvS3/q0ExBX7jQ441F65GetOgONZmd710aqo
 hOFDSzgJveKPDXx8cBrxhg9T+96ynmNzpIFmrAC1Xo6g+wVGz0FPOA3i8JXVsRSFSzE/
 mYqoP9aldeqLADxf/p9fOyNl58jjmdrSMl0Njyl4jiKbj5sIsC/zpOdWhqcAh6WggH+c
 KiDITaqi03Ml2alHFEeswGQfK6ZFnvggJldHSosnUr3QuyHiefJ0NZvIpo2ksebSPppz
 WzOirnWWWXDbrPBEPjDSY8velsP0+kWZZqpdiKgGU+SM09QiOAsCkyF025Crt226c2SV
 pkjA==
X-Gm-Message-State: AOAM531OC92r8q0V8jcA7WvQCAV4WLN/cPMqBk9hgJ5F1MLbDPmE9oTS
 jXGwCjpbY/oM9UAlPiXNF/W0wz9K+HUGBts2DjEbrA==
X-Google-Smtp-Source: ABdhPJxOp5UzhKE8mQDqRvlDz8V9c71SjR7m9HyAJLUxJZSu5SbSBuLRrcen1tdS0S3uE6PnU0rTNbtfAOPrHw/7VOw=
X-Received: by 2002:a05:651c:329:: with SMTP id
 b9mr2900217ljp.116.1627676446795; 
 Fri, 30 Jul 2021 13:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210729141937.445051-1-masahiroy@kernel.org>
In-Reply-To: <20210729141937.445051-1-masahiroy@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 30 Jul 2021 13:20:34 -0700
Message-ID: <CAKwvOd=AM1zus+apNQ14oS05bQPoSuhSdjUhPUD-4EU5x2KFSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc: remove unused zInstall target from
 arch/powerpc/boot/Makefile
To: Masahiro Yamada <masahiroy@kernel.org>
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
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jordan Niethe <jniethe5@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org,
 Bill Wendling <morbo@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jul 29, 2021 at 7:22 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Commit c913e5f95e54 ("powerpc/boot: Don't install zImage.* from make
> install") added the zInstall target to arch/powerpc/boot/Makefile,
> but you cannot use it since the corresponding hook is missing in
> arch/powerpc/Makefile.
>
> It has never worked since its addition. Nobody has complained about
> it for 7 years, which means this code was unneeded.
>
> With this removal, the install.sh will be passed in with 4 parameters.
> Simplify the shell script.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  arch/powerpc/boot/Makefile   |  6 +-----
>  arch/powerpc/boot/install.sh | 13 -------------
>  2 files changed, 1 insertion(+), 18 deletions(-)
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index e312ea802aa6..a702f9d1ec0d 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -448,11 +448,7 @@ $(obj)/zImage.initrd:      $(addprefix $(obj)/, $(initrd-y))
>  install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
>         sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)"
>
> -# Install the vmlinux and other built boot targets.
> -zInstall: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
> -       sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $^
> -
> -PHONY += install zInstall
> +PHONY += install
>
>  # anything not in $(targets)
>  clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
> diff --git a/arch/powerpc/boot/install.sh b/arch/powerpc/boot/install.sh
> index b6a256bc96ee..658c93ca7437 100644
> --- a/arch/powerpc/boot/install.sh
> +++ b/arch/powerpc/boot/install.sh
> @@ -15,7 +15,6 @@
>  #   $2 - kernel image file
>  #   $3 - kernel map file
>  #   $4 - default install path (blank if root directory)
> -#   $5 and more - kernel boot files; zImage*, uImage, cuImage.*, etc.
>  #
>
>  # Bail with error code if anything goes wrong
> @@ -41,15 +40,3 @@ fi
>
>  cat $2 > $4/$image_name
>  cp $3 $4/System.map
> -
> -# Copy all the bootable image files
> -path=$4
> -shift 4
> -while [ $# -ne 0 ]; do
> -       image_name=`basename $1`
> -       if [ -f $path/$image_name ]; then
> -               mv $path/$image_name $path/$image_name.old
> -       fi
> -       cat $1 > $path/$image_name
> -       shift
> -done;
> --
> 2.27.0
>


-- 
Thanks,
~Nick Desaulniers
