Return-Path: <SRS0=zuPs=OR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAE6C64EB1
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 06:39:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB4C20892
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 06:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mZf+U1Xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB4C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Bfnf3TWJzDqLl
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 17:39:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="mZf+U1Xt";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.80; helo=conssluserg-01.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="mZf+U1Xt"; 
 dkim-atps=neutral
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Bfkt1LczzF09n
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 17:36:53 +1100 (AEDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id wB86aOIr011937
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Dec 2018 15:36:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wB86aOIr011937
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544250984;
 bh=6fX3xVjwCchO1nhpz25rURfoq1T4iKEXomymFDqmhO8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=mZf+U1XtZqK6GLyIJv8H4y8qALP9wLHggjbapGBaM+EhhKHg3mv4XAFhYdyY5IXRJ
 YkEJjz3N3GsVl8BkzSweBRjGpLEewLVop9BK5z2l4Au6thxHJl80aZDiNhS1ogt9u1
 EbxvZw2NtHni0XN31udJeqGeSr1/Erg/6m2Hoc/5nlxLTpEGEN1fhDDQO4vWmtheNv
 NicGz6Isb/t1ghAWXLYDgVYQ0Qng/DGnzg/3nGxk/k2bY9yJnxFjd6lWl6UifZvaR7
 wp5ENVOzquNN50W/a+mhFgKoUZEbnl/RvoWOYvo963hFW1wNaCTD/ULzGSJY23h8D3
 Uy0J0u3ZQrHmA==
X-Nifty-SrcIP: [209.85.221.181]
Received: by mail-vk1-f181.google.com with SMTP id t127so1453348vke.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Dec 2018 22:36:24 -0800 (PST)
X-Gm-Message-State: AA+aEWav/1hwqrp+nTNzXs8dkhMlLykMXeNhzuqDBZMkudCoymmByVtb
 vI4ulHBesAQxf9pe/sLxApIKLajkOhutkI1AZM8=
X-Google-Smtp-Source: AFSGD/X+m7N/Mg+EFKExbJTUTujo3qCKF2DZB9DBxFPnRC7lLZjJunWqzYJVM5n1WNHvp5d1WWXERiVqwv4n9VfLAYI=
X-Received: by 2002:a1f:6bc8:: with SMTP id k69mr2067083vki.84.1544250983350; 
 Fri, 07 Dec 2018 22:36:23 -0800 (PST)
MIME-Version: 1.0
References: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
 <1541990120-9643-2-git-send-email-yamada.masahiro@socionext.com>
 <2624257.jg98z2FPBI@blindfold>
In-Reply-To: <2624257.jg98z2FPBI@blindfold>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 8 Dec 2018 15:35:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQjyWgpnu=qv-55gTL2DWpE93muu3Ksey8wFnWtLOzpbA@mail.gmail.com>
Message-ID: <CAK7LNAQjyWgpnu=qv-55gTL2DWpE93muu3Ksey8wFnWtLOzpbA@mail.gmail.com>
Subject: Re: [PATCH 1/2] um: remove -fno-unit-at-a-time workaround for pre-4.0
 GCC
To: Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
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
Cc: "H. Peter Anvin" <hpa@zytor.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>, Richard Weinberger <richard@nod.at>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

x86 maintainers,


Ping.



On Tue, Nov 13, 2018 at 6:48 PM Richard Weinberger <richard@nod.at> wrote:
>
> Am Montag, 12. November 2018, 03:35:19 CET schrieb Masahiro Yamada:
> > Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> > bumped the minimum GCC version to 4.6 for all architectures.
> >
> > '$(call cc-option,-fno-unit-at-a-time)' is now dead code since
> > '$(cc-version) -lt 0400' is always false.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/x86/Makefile.um | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
> > index 91085a0..577976b 100644
> > --- a/arch/x86/Makefile.um
> > +++ b/arch/x86/Makefile.um
> > @@ -26,12 +26,8 @@ cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
> >  # an unresolved reference.
> >  cflags-y += -ffreestanding
> >
> > -# Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
> > -# a lot more stack due to the lack of sharing of stacklots.  Also, gcc
> > -# 4.3.0 needs -funit-at-a-time for extern inline functions.
> > -KBUILD_CFLAGS += $(shell if [ $(cc-version) -lt 0400 ] ; then \
> > -                     echo $(call cc-option,-fno-unit-at-a-time); \
> > -                     else echo $(call cc-option,-funit-at-a-time); fi ;)
> > +# gcc 4.3.0 needs -funit-at-a-time for extern inline functions.
> > +KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
>
> Acked-by: Richard Weinberger <richard@nod.at>
>
> Thanks,
> //richard
>
>
>


-- 
Best Regards
Masahiro Yamada
