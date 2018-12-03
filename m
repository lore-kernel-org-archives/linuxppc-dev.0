Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86988C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 10:27:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CC62087F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 10:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="M5Ps/4Wl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CC62087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437h5G5TLlzDqV7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 21:27:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="M5Ps/4Wl";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="M5Ps/4Wl"; 
 dkim-atps=neutral
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437h2F70mZzDqKW
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2018 21:24:53 +1100 (AEDT)
Received: by mail-qt1-x842.google.com with SMTP id p17so13037121qtl.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 02:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VOwRlFEtKUX0nfoeZ2XPbc477wBa9aEEuwSfpux+fcc=;
 b=M5Ps/4WlD8OWnqjLkvlE9jOoK4B/1n5XftBvYEP5DufCDRy6rLzqWfQ59gIcJ3O1uO
 eMjbm7qplwMDfhZsGqvqbdKtQASxbcqfmY47xUCDv801HJDxs/VRuoPEWetMDVBtKe9O
 H9wwAccrEEm0Ha9aqeDkMrR7UTCkZKkkKHvc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VOwRlFEtKUX0nfoeZ2XPbc477wBa9aEEuwSfpux+fcc=;
 b=pBvbhHj/bB34OKCFvUkl+XbMjaw6DgxLl2G8GG8Cz2vOaq/EM7SQHgd8oAv9d7KQXa
 JzqmB4ZJDiYoVudgGAxFwrwHxPr0gyJw5B9AGOLUneLgSMRkhqNrsI204V3rm/JFzBtC
 2EHW1u8GgRGks0PhrJRjJzGQnvw2gu+BwdP4CLwU57cOJCP5xdJ3B6tognFg2O8lN51o
 b5BUMoYrudIuEa7PnQBYshol0i4X7avHu+UWOrP16W2GBORPCiUMLZSttMr7arFQKC3J
 MRmC/CsgjFpoa9oxrKKP7EGgiOCOCqAmud2sMNISnwqbuZuJzdUkUoO5d7fnMSipl0nN
 jACg==
X-Gm-Message-State: AA+aEWZro3Ks0AbaRwUg1UVXBT+S5MrDH5ppr7ORDQoQ5UvpP+jESIHI
 /ac13167jh6jnOhbqZUDXLo+UBd416+G3e5+Yg8=
X-Google-Smtp-Source: AFSGD/Uf27UBNgRJGqS5PdA5FZJL9TiF5oJTx8q3CD1OFjdv4rG5tkyf3M+ki8nQsSex7S8FlaAvWtc6WE+QB3LOHIQ=
X-Received: by 2002:ac8:29b7:: with SMTP id 52mr14602422qts.266.1543832691764; 
 Mon, 03 Dec 2018 02:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20181102004455.10157-1-joel@jms.id.au>
 <CAKwvOdni_iJ4beAWYkUUpZss_PYZezMGR7hN9k1rm9J0iB0gHQ@mail.gmail.com>
In-Reply-To: <CAKwvOdni_iJ4beAWYkUUpZss_PYZezMGR7hN9k1rm9J0iB0gHQ@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 3 Dec 2018 20:54:40 +1030
Message-ID: <CACPK8XdbWzb=52iFV_fj0Y5KMWPgsRv_A8PZgfKn9vm96y3LOw@mail.gmail.com>
Subject: Re: [PATCH v2] raid6/ppc: Fix build for clang
To: Nick Desaulniers <ndesaulniers@google.com>
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
 Jinsong Ji <jji@us.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 3 Nov 2018 at 04:04, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Thu, Nov 1, 2018 at 5:45 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > We cannot build these files with clang as it does not allow altivec
> > instructions in assembly when -msoft-float is passed.
> >
> > Jinsong Ji <jji@us.ibm.com> wrote:
> > > We currently disable Altivec/VSX support when enabling soft-float.  So
> > > any usage of vector builtins will break.
> > >
> > > Enable Altivec/VSX with soft-float may need quite some clean up work, so
> > > I guess this is currently a limitation.
> > >
> > > Removing -msoft-float will make it work (and we are lucky that no
> > > floating point instructions will be generated as well).
> >
> > This is a workaround until the issue is resolved in clang.
> >
> > Link: https://bugs.llvm.org/show_bug.cgi?id=31177
> > Link: https://github.com/ClangBuiltLinux/linux/issues/239
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > v2: fix typo in comment, thanks Jinsong
> >
> >  lib/raid6/Makefile | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
> > index 2f8b61dfd9b0..7ed43eaa02ef 100644
> > --- a/lib/raid6/Makefile
> > +++ b/lib/raid6/Makefile
> > @@ -18,6 +18,21 @@ quiet_cmd_unroll = UNROLL  $@
> >
> >  ifeq ($(CONFIG_ALTIVEC),y)
> >  altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
> > +
> > +ifdef CONFIG_CC_IS_CLANG
> > +# clang ppc port does not yet support -maltivec when -msoft-float is
> > +# enabled. A future release of clang will resolve this
> > +# https://bugs.llvm.org/show_bug.cgi?id=31177
> > +CFLAGS_REMOVE_altivec1.o  += -msoft-float
> > +CFLAGS_REMOVE_altivec2.o  += -msoft-float
> > +CFLAGS_REMOVE_altivec4.o  += -msoft-float
> > +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> > +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> > +CFLAGS_REMOVE_vpermxor1.o += -msoft-float
> > +CFLAGS_REMOVE_vpermxor2.o += -msoft-float
> > +CFLAGS_REMOVE_vpermxor4.o += -msoft-float
> > +CFLAGS_REMOVE_vpermxor8.o += -msoft-float
> > +endif
>
> Hi Joel, thanks for this patch!  My same thoughts about
> CONFIG_CC_IS_CLANG vs cc-option from
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-November/180939.html
> apply here as well.  I don't feel strongly about either though.  What
> are your thoughts?

I'm not sure that we can test for this one with cc-option. The result
of having -maltivec with -msoft-float is a error about the internals
of clang, which isn't something that kbuild is set up to test for.

When clang is fixed to allow this combination we will still build this
code in the same way, so in that sense it fails "open".

Cheers,

Joel
