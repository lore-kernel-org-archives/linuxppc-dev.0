Return-Path: <SRS0=zuPs=OR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D2FC64EB1
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 08:56:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA0A2083D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 08:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA0A2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BjrF5d0HzF0Vk
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 19:56:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nod.at
 (client-ip=195.201.40.130; helo=lithops.sigma-star.at;
 envelope-from=richard@nod.at; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=nod.at
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Bjnx421FzF0QT
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 19:54:43 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 8CCD4608A3B9;
 Sat,  8 Dec 2018 09:54:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id kfJK3t4E5t8S; Sat,  8 Dec 2018 09:54:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 3604D608A3BA;
 Sat,  8 Dec 2018 09:54:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 6FiBBnNIeLkp; Sat,  8 Dec 2018 09:54:40 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at
 [213.47.184.186])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id A1864608A3B9;
 Sat,  8 Dec 2018 09:54:39 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/2] um: remove -fno-unit-at-a-time workaround for pre-4.0
 GCC
Date: Sat, 08 Dec 2018 09:54:39 +0100
Message-ID: <1855895.dlXT8REgUo@blindfold>
In-Reply-To: <CAK7LNAQjyWgpnu=qv-55gTL2DWpE93muu3Ksey8wFnWtLOzpbA@mail.gmail.com>
References: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
 <2624257.jg98z2FPBI@blindfold>
 <CAK7LNAQjyWgpnu=qv-55gTL2DWpE93muu3Ksey8wFnWtLOzpbA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

Am Samstag, 8. Dezember 2018, 07:35:47 CET schrieb Masahiro Yamada:
> x86 maintainers,
> 
> 
> Ping.

I thought you carry this via your kbuild tree.
That said, I can merge it also via the um tree.
x86 is of course also fine. :-)

> 
> 
> On Tue, Nov 13, 2018 at 6:48 PM Richard Weinberger <richard@nod.at> wrote:
> >
> > Am Montag, 12. November 2018, 03:35:19 CET schrieb Masahiro Yamada:
> > > Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> > > bumped the minimum GCC version to 4.6 for all architectures.
> > >
> > > '$(call cc-option,-fno-unit-at-a-time)' is now dead code since
> > > '$(cc-version) -lt 0400' is always false.
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > ---
> > >
> > >  arch/x86/Makefile.um | 8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
> > > index 91085a0..577976b 100644
> > > --- a/arch/x86/Makefile.um
> > > +++ b/arch/x86/Makefile.um
> > > @@ -26,12 +26,8 @@ cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
> > >  # an unresolved reference.
> > >  cflags-y += -ffreestanding
> > >
> > > -# Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
> > > -# a lot more stack due to the lack of sharing of stacklots.  Also, gcc
> > > -# 4.3.0 needs -funit-at-a-time for extern inline functions.
> > > -KBUILD_CFLAGS += $(shell if [ $(cc-version) -lt 0400 ] ; then \
> > > -                     echo $(call cc-option,-fno-unit-at-a-time); \
> > > -                     else echo $(call cc-option,-funit-at-a-time); fi ;)
> > > +# gcc 4.3.0 needs -funit-at-a-time for extern inline functions.
> > > +KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
> >
> > Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard


