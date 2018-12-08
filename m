Return-Path: <SRS0=zuPs=OR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DF8C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 06:41:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 653ED2083D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 06:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gXf1oRGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653ED2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BfrV4bGpzDqKg
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 17:41:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="gXf1oRGj";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.83; helo=conssluserg-04.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="gXf1oRGj"; 
 dkim-atps=neutral
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Bflz1KcmzDsNT
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 17:37:50 +1100 (AEDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id wB86bS0j000353
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Dec 2018 15:37:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wB86bS0j000353
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544251049;
 bh=u+LqDjndI1J1T/fE+BGNpV/dpMJg6P4JHzUUFBEVtSk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=gXf1oRGj6aGAqIkLCJ1PuYJB7x4YDArGViFt5RsES3eeI7sijuwm/biYBTQROWdN4
 HdswTdlEQSOzDXR+4I5Z90X5oX5r6Et5kc1fj524ZUEztc8q4ZiMjj0Sgm1WXS4fJV
 va5MVH0FwWlVOw/lel2g7uXFApaGTZ0Rx1bgO/Ctv1YcamLd39vs80CAzIh5IL2mKF
 U5Wd+yF3OXKG+qsF0PK3Gy/aQrOeFlLo9iISo32/qnrksOApLVy6ftsiJcxvOEBQUI
 Hfs7xw/8afrFqQkGAEYZCcqE76JN/PAAxaJ05pOSaHyam3Vqsv7obE9j/5pISJrK9w
 S8BxZk+ungz7g==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id x1so3763744vsc.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Dec 2018 22:37:28 -0800 (PST)
X-Gm-Message-State: AA+aEWYdcrgLMb3qtEkcT1GvuTdc5PH6R8mSXSdmKIcfgaq2MZUuCCto
 fZCcX8rTcinIZtgbioRaJl6FAWTDGx2yIKyihA0=
X-Google-Smtp-Source: AFSGD/W/+6h6GwFwtUOM8s0q2Y+xsVrOm9dNcSeXgEldbnx4vQYui5QdzKdjTQcv9Q2+1nfQ8FFSgsxe3EBOgxlhiHQ=
X-Received: by 2002:a67:a858:: with SMTP id r85mr2099845vse.215.1544251047871; 
 Fri, 07 Dec 2018 22:37:27 -0800 (PST)
MIME-Version: 1.0
References: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
 <1541990120-9643-3-git-send-email-yamada.masahiro@socionext.com>
 <87k1lia6bd.fsf@concordia.ellerman.id.au>
In-Reply-To: <87k1lia6bd.fsf@concordia.ellerman.id.au>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 8 Dec 2018 15:36:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNARbzF9-ZYvX7U76HqC957Fj=U3rmQfCEYXKqZNV8SFmNg@mail.gmail.com>
Message-ID: <CAK7LNARbzF9-ZYvX7U76HqC957Fj=U3rmQfCEYXKqZNV8SFmNg@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86,
 powerpc: remove -funit-at-a-time compiler option entirely
To: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 X86 ML <x86@kernel.org>
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Paul Mackerras <paulus@samba.org>, Richard Weinberger <richard@sigma-star.at>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

x86 maintainers,

Ping.



On Mon, Nov 12, 2018 at 8:23 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>
> > GCC 4.6 manual says:
> >
> > -funit-at-a-time
> >   This option is left for compatibility reasons. -funit-at-a-time has
> >   no effect, while -fno-unit-at-a-time implies -fno-toplevel-reorder
> >   and -fno-section-anchors.
> >   Enabled by default.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/powerpc/Makefile | 4 ----
> >  arch/x86/Makefile     | 4 ----
> >  arch/x86/Makefile.um  | 5 -----
> >  3 files changed, 13 deletions(-)
> >
> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index 8a2ce14..854199c 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -228,10 +228,6 @@ KBUILD_CFLAGS += $(call cc-option,-mno-vsx)
> >  KBUILD_CFLAGS += $(call cc-option,-mno-spe)
> >  KBUILD_CFLAGS += $(call cc-option,-mspe=no)
> >
> > -# Enable unit-at-a-time mode when possible. It shrinks the
> > -# kernel considerably.
> > -KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
> > -
>
> Thanks for cleaning it up.
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>
> cheers



-- 
Best Regards
Masahiro Yamada
