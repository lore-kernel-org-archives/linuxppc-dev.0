Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CC6C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 19:57:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7D120657
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 19:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uQY4FgS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7D120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lfJR2MxXzF3KQ
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 06:57:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="uQY4FgS2";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="uQY4FgS2"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lfFc3R8tzF3Lp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 06:55:10 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id k1-v6so6459450pgq.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 12:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=46d64IHoNhXANyIrt6w+MMKJEMStKIEctNagK9GxHFk=;
 b=uQY4FgS2njnX/3V8ewtVEgDS8wNzkB8V5oYN/dli87lTtjSvAQ+iyLokNWSEymakYC
 CuC6nWtVFmPOaZozSgLmIRZTKz4YYUoIUJ60pcM9xzV0YuxyCON/eG0NohxhEjqvSHmf
 kYTRK2fWPdeMN5frR5hzlC14ai1rme4Ct81qLo7Q2PJ6kLMn4JhyS9grZX4QKV2yLtYS
 uMDIssFxArkVuyBRVxiI8fVCRwglhxE6qbafphZEE07ywv661zsB/KP7ukqskl6z4/mo
 lWF+47nreiXvCdxFZUpQ4fSaQNYeCSB3LZGVSIIEzsynZvYOiF1dFp4qXHjM8hcBqV7/
 A38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=46d64IHoNhXANyIrt6w+MMKJEMStKIEctNagK9GxHFk=;
 b=lZy8Sl9fHyEvzMntmQ6V38b+ip5iS/zmqcB+t/Jlr8FwuTRmeIfnPmXh9HTzeSkOtY
 EN3b2Q+/63jndrM7mwmK6jGtp1SsUlqcjykYlcXwPflvHZD0kijTiqmdff9wFnOj3ZMO
 IR9//Bt5f5RMiiP5jh5zr/ddlBGkraYaI9HjBnqUQqjBJ6FRuMDJ32ZQA8ESMmaZcwYu
 0XsbkWVlvGErvx469jMA9fN6HwTPUR+5UiYoyLAENhOt+6uIws1UkjNMok0zD8e9pXQS
 M/kCgrO3oIhHY9QicrlZ9NflZEY0mRrO4DLR8IsOns9wsoCFLVogqfGV9n3NRibzLTUu
 xhCg==
X-Gm-Message-State: AGRZ1gJAEmgcbhPHXJoP6RLt0hvDYZqw4/yDCGuLgAXBVJddkI6QNK8n
 8VPcHfqcKydCdAZyBxJl0cxJp/smD0b0eMw/9areXko36g7g6w==
X-Google-Smtp-Source: AJdET5dgh/Pl8QD0yN8b+eAwtHVBQi4BWLAxP4Bi/jWcMxvHdMeoWSPjXXS0/2y6DVOM2V+CDpha1/UqNOgwVxyZPaU=
X-Received: by 2002:a65:4806:: with SMTP id
 h6-v6mr4512221pgs.302.1541015707933; 
 Wed, 31 Oct 2018 12:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181031032829.18131-1-joel@jms.id.au>
In-Reply-To: <20181031032829.18131-1-joel@jms.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 31 Oct 2018 12:54:57 -0700
Message-ID: <CAKwvOdm8rFNEG39_6f5voZo3nU1g9eC6M8uxeQPVE8=JUoB3mg@mail.gmail.com>
Subject: Re: [PATCH] raid6/ppc: Fix build for clang
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

On Tue, Oct 30, 2018 at 8:28 PM Joel Stanley <joel@jms.id.au> wrote:
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

Hopefully we can have this fixed up soon.  I'll try to see who works
on Clang+PPC here and see if they can help move that bug along. Thanks
for the patch!

> ---
>  lib/raid6/Makefile | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
> index 2f8b61dfd9b0..3a844e6fd01c 100644
> --- a/lib/raid6/Makefile
> +++ b/lib/raid6/Makefile
> @@ -18,6 +18,21 @@ quiet_cmd_unroll = UNROLL  $@
>
>  ifeq ($(CONFIG_ALTIVEC),y)
>  altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
> +
> +ifdef CONFIG_CC_IS_CLANG

Note that the top level makefile detects clang via:

ifeq ($(cc-name),clang)

Does that not work here? I'd prefer to keep compiler detection in
Makefiles consistent, if it works?

> +# clang ppc port does not yet support -maltifec when -msoft-float is
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
>  endif
>
>  # The GCC option -ffreestanding is required in order to compile code containing
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
