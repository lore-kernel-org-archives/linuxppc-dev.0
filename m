Return-Path: <SRS0=zuPs=OR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26297C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 19:25:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4BB20837
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 19:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dWJNxF5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4BB20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Bzn82zFdzDrDN
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 06:25:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="dWJNxF5u";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.81; helo=conssluserg-02.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="dWJNxF5u"; 
 dkim-atps=neutral
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Bzg63mdkzDrgC
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Dec 2018 06:19:46 +1100 (AEDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id wB8JJTfw015373
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Dec 2018 04:19:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wB8JJTfw015373
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544296770;
 bh=E/4MwRgLGLDh7pOhq5IHJUWOQywDWsxtqGjIY3Y/aNM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=dWJNxF5uH0ifMpGtUH1hPZZmZP4BShL4oJhzf9xvsCrdoY/Ue7sRNn7Y5cL19+doY
 7w5F2Sn4hR8p7SOCbv9J0l2o2XVrYt4u4yL4tXgxxY6el0HBw/lXFKhtI0BFjDbQY1
 YM2imP7JfTK69sRiHfOsduMrsM5MaqqKDoC7pcNyNcJRrvLa+rR0eku4RYxmZdFdXm
 jn6AuhaKBOjcGiqWU/YfA9AZvEWVaDsZ6qEJi5XCEQAKtzDZBagSpbk4tOPaspz0sJ
 BHjhvdSo8CRO3iHAuezAgIAMaW+B9mcCtX2AJBD7Mu3m7bd9gE3TMSTV2RWmXFOWIy
 gEiaDFMV/aFCg==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id x64so4425249vsa.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Dec 2018 11:19:30 -0800 (PST)
X-Gm-Message-State: AA+aEWZC98FD3B6VStyrgaA3sIWsNxRAsA7C91W/GmlzpbxrfT/2f2K8
 FiAN9KFtULcQwfOczNerKJE1WWZhbGdYLtxBiSg=
X-Google-Smtp-Source: AFSGD/UCURCMphoiLVeYHR5V/QWrOc0Rbt31F3zKueqWYM1VCFb6tIT0v0Qu8PQhHd5LNrtBTi2SdPP4TzSgxJlKuHc=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr2974586vsb.155.1544296768991; 
 Sat, 08 Dec 2018 11:19:28 -0800 (PST)
MIME-Version: 1.0
References: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
 <2624257.jg98z2FPBI@blindfold>
 <CAK7LNAQjyWgpnu=qv-55gTL2DWpE93muu3Ksey8wFnWtLOzpbA@mail.gmail.com>
 <1855895.dlXT8REgUo@blindfold>
In-Reply-To: <1855895.dlXT8REgUo@blindfold>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 9 Dec 2018 04:18:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNATkxBbOMAOXUfVbD_Osz2wuQvd=7Afp_7j1Lihrktxa3w@mail.gmail.com>
Message-ID: <CAK7LNATkxBbOMAOXUfVbD_Osz2wuQvd=7Afp_7j1Lihrktxa3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] um: remove -fno-unit-at-a-time workaround for pre-4.0
 GCC
To: Richard Weinberger <richard@nod.at>
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
Cc: X86 ML <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Richard,

On Sat, Dec 8, 2018 at 5:55 PM Richard Weinberger <richard@nod.at> wrote:
>
> Am Samstag, 8. Dezember 2018, 07:35:47 CET schrieb Masahiro Yamada:
> > x86 maintainers,
> >
> >
> > Ping.
>
> I thought you carry this via your kbuild tree.
> That said, I can merge it also via the um tree.
> x86 is of course also fine. :-)


The second patch also touches x86 Makefiles.

So, I think both should be applied to x86 tree.

Thanks.




> >
> >
> > On Tue, Nov 13, 2018 at 6:48 PM Richard Weinberger <richard@nod.at> wrote:
> > >
> > > Am Montag, 12. November 2018, 03:35:19 CET schrieb Masahiro Yamada:
> > > > Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> > > > bumped the minimum GCC version to 4.6 for all architectures.
> > > >
> > > > '$(call cc-option,-fno-unit-at-a-time)' is now dead code since
> > > > '$(cc-version) -lt 0400' is always false.
> > > >
> > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > ---
> > > >
> > > >  arch/x86/Makefile.um | 8 ++------
> > > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
> > > > index 91085a0..577976b 100644
> > > > --- a/arch/x86/Makefile.um
> > > > +++ b/arch/x86/Makefile.um
> > > > @@ -26,12 +26,8 @@ cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
> > > >  # an unresolved reference.
> > > >  cflags-y += -ffreestanding
> > > >
> > > > -# Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
> > > > -# a lot more stack due to the lack of sharing of stacklots.  Also, gcc
> > > > -# 4.3.0 needs -funit-at-a-time for extern inline functions.
> > > > -KBUILD_CFLAGS += $(shell if [ $(cc-version) -lt 0400 ] ; then \
> > > > -                     echo $(call cc-option,-fno-unit-at-a-time); \
> > > > -                     else echo $(call cc-option,-funit-at-a-time); fi ;)
> > > > +# gcc 4.3.0 needs -funit-at-a-time for extern inline functions.
> > > > +KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
> > >
> > > Acked-by: Richard Weinberger <richard@nod.at>
>
> Thanks,
> //richard
>
>


-- 
Best Regards
Masahiro Yamada
