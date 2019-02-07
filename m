Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F66BC282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 10:21:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D45218FE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 10:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D45218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wDqk0dTLzDqQl
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 21:21:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wDns1TMZzDqM6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 21:19:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43wDnr3w9dz8tCk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 21:19:44 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43wDnr2KTXz9sMM; Thu,  7 Feb 2019 21:19:44 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.66; helo=mail-ot1-f66.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43wDnq5kghz9s9G
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2019 21:19:43 +1100 (AEDT)
Received: by mail-ot1-f66.google.com with SMTP id n8so17318734otl.6
 for <linuxppc-dev@ozlabs.org>; Thu, 07 Feb 2019 02:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z1TQA43Or/JMmx3Zll3LzZ6LZ9V35nYNuUMDMhqrmhs=;
 b=cpfoW2i84Tyj896oe4Yp5JPXmJaksmPZ7ob1tr47XRag+32FjB5207Zww74XHoW46R
 p3tbQ5gDmvBI7ZexIiIP+lSKz5Bcvv5Bt4XL83x3zV76cF+RJWo1r0VXn12F49vjxkwM
 h/MmJKUgYe6O4akZzsV+Cr4QqwOtDzKu0kOniIrJNNhEGZsdaYnmIvIPbEV6kRqMiR4h
 7cPkL8lyopga20yVI8PODfEQUi4470au+H8RADepdMY1zOzkBD7N6KWH12FtQ56lh8ou
 7ZWtuIfteI3idMoacZJa2q9Fi2p8CqjL6lyCMtieFS3lauiZOLMuZRbkixk+8Uvq9pVN
 /DhA==
X-Gm-Message-State: AHQUAuabGQqkblGux3rHPtnmcx30wV+MppQAEhdSuphvWBMfkzRJMtpl
 GY770aa0sNN8+AwXvoIsTaljgVY5rb6FFjUkNXU=
X-Google-Smtp-Source: AHgI3Ia9zRENg68orgLXl758Jruc611ewww2nnaBcgDNgUZuXFSTediq2T7jiFBNzLqAEL7X8Kvd/dkaDAejTMryfgs=
X-Received: by 2002:a9d:348:: with SMTP id 66mr7846706otv.300.1549534782004;
 Thu, 07 Feb 2019 02:19:42 -0800 (PST)
MIME-Version: 1.0
References: <20190207051652.11380-1-mpe@ellerman.id.au>
 <20190207051652.11380-2-mpe@ellerman.id.au>
In-Reply-To: <20190207051652.11380-2-mpe@ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 7 Feb 2019 11:19:30 +0100
Message-ID: <CA+7wUsw-J72ZKFLFr+sK2sqpbbqdh-S-3hdLGAkCjfvT0ToQhQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc: Fix defconfig choice logic when cross
 compiling
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 7, 2019 at 6:20 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Our logic for choosing defconfig doesn't work well in some situations.
>
> For example if you're on a ppc64le machine but you specify a non-empty
> CROSS_COMPILE, in order to use a non-default toolchain, then defconfig
> will give you ppc64_defconfig (big endian):
>
>   $ make CROSS_COMPILE=~/toolchains/gcc-8/bin/powerpc-linux- defconfig
>   *** Default configuration is based on 'ppc64_defconfig'
>
> This is because we assume that CROSS_COMPILE being set means we
> can't be on a ppc machine and rather than checking we just default to
> ppc64_defconfig.
>
> We should just ignore CROSS_COMPILE, instead check the machine with
> uname and if it's one of ppc, ppc64 or ppc64le then use that
> defconfig. If it's none of those then we fall back to ppc64_defconfig.

How about shamelessly copying x86:

diff --git a/Makefile b/Makefile
index 3142e67d03f1..041616742142 100644
--- a/Makefile
+++ b/Makefile
@@ -351,6 +351,14 @@ ifeq ($(ARCH),sparc64)
        SRCARCH := sparc
 endif

+# Additional ARCH settings for ppc
+ifeq ($(ARCH),ppc64)
+       SRCARCH := powerpc
+endif
+ifeq ($(ARCH),ppc64el)
+       SRCARCH := powerpc
+endif
+
 # Additional ARCH settings for sh
 ifeq ($(ARCH),sh64)
        SRCARCH := sh
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 10bf5dc7cdf0..cbb679fb7162 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -34,10 +34,17 @@ ifdef CONFIG_PPC_BOOK3S_32
 KBUILD_CFLAGS          += -mcpu=powerpc
 endif

-# If we're on a ppc/ppc64/ppc64le machine use that defconfig,
otherwise just use
-# ppc64_defconfig because we have nothing better to go on.
-uname := $(shell uname -m)
-KBUILD_DEFCONFIG := $(if $(filter ppc%,$(uname)),$(uname),ppc64)_defconfig
+# select defconfig based on actual architecture
+ifeq ($(ARCH),powerpc)
+  ifeq ($(shell uname -m),ppc64)
+        KBUILD_DEFCONFIG := ppc64_defconfig
+  else
+        KBUILD_DEFCONFIG := ppc_defconfig
+  endif
+else
+        KBUILD_DEFCONFIG := $(ARCH)_defconfig
+endif
+

 ifdef CONFIG_PPC64
 new_nm := $(shell if $(NM) --help 2>&1 | grep -- '--synthetic' >
/dev/null; then echo y; else echo n; fi)


> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/Makefile | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 70e6e8119aeb..81563986a30e 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -34,11 +34,10 @@ ifdef CONFIG_PPC_BOOK3S_32
>  KBUILD_CFLAGS          += -mcpu=powerpc
>  endif
>
> -ifeq ($(CROSS_COMPILE),)
> -KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
> -else
> -KBUILD_DEFCONFIG := ppc64_defconfig
> -endif
> +# If we're on a ppc/ppc64/ppc64le machine use that defconfig, otherwise just use
> +# ppc64_defconfig because we have nothing better to go on.
> +uname := $(shell uname -m)
> +KBUILD_DEFCONFIG := $(if $(filter ppc%,$(uname)),$(uname),ppc64)_defconfig
>
>  ifdef CONFIG_PPC64
>  new_nm := $(shell if $(NM) --help 2>&1 | grep -- '--synthetic' > /dev/null; then echo y; else echo n; fi)
> --
> 2.20.1
>
