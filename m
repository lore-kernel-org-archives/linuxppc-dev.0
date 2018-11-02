Return-Path: <SRS0=pcIm=NN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0A6C32789
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 17:39:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670FC2081B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 17:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="B+V/DVKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670FC2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mq7Z3B5mzF37M
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 04:39:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="B+V/DVKz";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="B+V/DVKz"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mq2n6mrmzF37B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Nov 2018 04:34:57 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id h4-v6so1326308pfi.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Nov 2018 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W5cpov5BUBzUk05UG86XRpq/4qB8M3Cgo8tsQRLRHzI=;
 b=B+V/DVKzBFgI/iaBjPgFGYEahDPwrCF8G6iKlIXoDDyoEf5uFJGomwv2ycltuvSdXg
 ID3XjWRKO56PW4AoQudq+a1S+8a9LQ4Iv8+xCYjC5D8ELYEoOZpey/Rfm8MTzpKb2FwB
 dmJk1ih4+Xy89imU7rllOYbpG4pzhy1OEObE8tZdv/FLPNaDa4wGPAp3/FH/OihJrOI8
 9lFGFjYbKC7qhOTE5Z516hpr+yb75N/ABON/wfxJnn39O//WTOzWJoS/2zmYduCVX1Oe
 j8w6SBH/y3TH7iesrdY9byi0G7aazEtjiIwes8MQbNVmSFacXnCcXcwZHLBXOFx71p2p
 MZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W5cpov5BUBzUk05UG86XRpq/4qB8M3Cgo8tsQRLRHzI=;
 b=lArCLkfsB0GkD+rFKSRq/d6aHTEjT6cA6k4JvOe/xwDcR1di1JhG3l1UwL7PXwjUhk
 9vabCXcGnBqgM6C4tTheIhKtUv+bcIV/khbcKgj5jk6G8kKawdt4usXbDN3LMTU3Stwb
 JvlWhgZUQMyd3oQJN0tUtwOrzR9cklbBpxURSIgskQe2vnKeXDbhLOVG/wnqxfNiq/kw
 wzIJ6MQODHuxzqeCqO4i6q/64/eKNfCIQvYFKsNP73JSfmslfkRfBegtXMS9QNKh4g4f
 IF9zXr0Lb+xJVWQeaM5pdfZYiEFGIl2KHx/wMYitSizjF9QmWqCmrreS3brl8lN5zrpB
 U1hQ==
X-Gm-Message-State: AGRZ1gIaR11KDm0Dn9rcgeYABrRXq3v1rSMl7NVVvO031KnAzSjk34kW
 U7l3Mwx0IXQzF8uq2wFKuWk+tWqqLiYDYBnFlXMhaA==
X-Google-Smtp-Source: AJdET5e8mhIia7P6TY25XmjwcH1EZYCgIR2kvu1kTOuAVTmp0Q6K+ht8NlaSUkYffmST9kNZmYEqkb+Wt06HbYA/YUc=
X-Received: by 2002:a62:4b09:: with SMTP id
 y9-v6mr12626347pfa.93.1541180095479; 
 Fri, 02 Nov 2018 10:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181102004455.10157-1-joel@jms.id.au>
In-Reply-To: <20181102004455.10157-1-joel@jms.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 2 Nov 2018 10:34:44 -0700
Message-ID: <CAKwvOdni_iJ4beAWYkUUpZss_PYZezMGR7hN9k1rm9J0iB0gHQ@mail.gmail.com>
Subject: Re: [PATCH v2] raid6/ppc: Fix build for clang
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
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 jji@us.ibm.com, LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 1, 2018 at 5:45 PM Joel Stanley <joel@jms.id.au> wrote:
>
> We cannot build these files with clang as it does not allow altivec
> instructions in assembly when -msoft-float is passed.
>
> Jinsong Ji <jji@us.ibm.com> wrote:
> > We currently disable Altivec/VSX support when enabling soft-float.  So
> > any usage of vector builtins will break.
> >
> > Enable Altivec/VSX with soft-float may need quite some clean up work, so
> > I guess this is currently a limitation.
> >
> > Removing -msoft-float will make it work (and we are lucky that no
> > floating point instructions will be generated as well).
>
> This is a workaround until the issue is resolved in clang.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=31177
> Link: https://github.com/ClangBuiltLinux/linux/issues/239
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2: fix typo in comment, thanks Jinsong
>
>  lib/raid6/Makefile | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
> index 2f8b61dfd9b0..7ed43eaa02ef 100644
> --- a/lib/raid6/Makefile
> +++ b/lib/raid6/Makefile
> @@ -18,6 +18,21 @@ quiet_cmd_unroll = UNROLL  $@
>
>  ifeq ($(CONFIG_ALTIVEC),y)
>  altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
> +
> +ifdef CONFIG_CC_IS_CLANG
> +# clang ppc port does not yet support -maltivec when -msoft-float is
> +# enabled. A future release of clang will resolve this
> +# https://bugs.llvm.org/show_bug.cgi?id=31177
> +CFLAGS_REMOVE_altivec1.o  += -msoft-float
> +CFLAGS_REMOVE_altivec2.o  += -msoft-float
> +CFLAGS_REMOVE_altivec4.o  += -msoft-float
> +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> +CFLAGS_REMOVE_vpermxor1.o += -msoft-float
> +CFLAGS_REMOVE_vpermxor2.o += -msoft-float
> +CFLAGS_REMOVE_vpermxor4.o += -msoft-float
> +CFLAGS_REMOVE_vpermxor8.o += -msoft-float
> +endif

Hi Joel, thanks for this patch!  My same thoughts about
CONFIG_CC_IS_CLANG vs cc-option from
https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-November/180939.html
apply here as well.  I don't feel strongly about either though.  What
are your thoughts?

>  endif
>
>  # The GCC option -ffreestanding is required in order to compile code containing
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
