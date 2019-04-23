Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12BDC10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 03:42:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68184206BA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 03:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rpBNEm11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68184206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44p8R02sKrzDqP7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 13:42:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.80; helo=conssluserg-01.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="rpBNEm11"; 
 dkim-atps=neutral
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44p8545XwyzDqMl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 13:27:04 +1000 (AEST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id x3N3QeZC028154
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 12:26:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x3N3QeZC028154
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1555990001;
 bh=+sM4okn7en/aXLTxk39Iv8cVSFLO5kMp2OmxveFMPqA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=rpBNEm11sedr4ZTTqn4DWKErS1jmsxU0wCFi0W4J5QIhcrg6UGyXJ0GPxeGxBm2Jk
 N7PzxyYAsMY4p5A9/yTYYmkUiTB/C40RxrMyYLm0K/gSEp1+Sdckyco7gus660Fi4g
 hgd9pqYd3Vm0IzUma7z1q8AyPdVLgj2QT6VDXVlH+pMpEzVZlRC+ecL0v37PFOYYVs
 IJ8mDqVFUteeWnZ5OpEcPkL3bDFH5tIMVernuNZGtxY9FSVumMNFqIUs5StTOolLap
 eGnxFSaCr2Z9sKcTYd4qXq1WFFQTcMV4kS7yRB9DDQWVOyaQo01I/QkYsKcqnkLrTK
 rPxED8Ccb4PXQ==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id t23so7427416vso.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 20:26:40 -0700 (PDT)
X-Gm-Message-State: APjAAAUhxRpWtWgwdLhuIVWUoXGnjf6CV4vpfzINueZUe6/4l7PeGR7n
 vfjVxXKPyJdDog3ZhwX7fwY1UtDbe6ypbvLd8jY=
X-Google-Smtp-Source: APXvYqx2ley7uSFnGGyGDabU1ZUfPiuLyEbp0qC3i0OaiObNnBFjDDjfzPzXXacVJD6LAmdWjocvMILtntWiqRva/Zw=
X-Received: by 2002:a67:ea89:: with SMTP id f9mr1367458vso.179.1555989999934; 
 Mon, 22 Apr 2019 20:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
 <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
 <20190323092640.Horde.2lm4u26aZox5ialxuIRcYw2@messagerie.si.c-s.fr>
 <CAK7LNAQGifytZRQXcqma9VuvQPfL2w8NjzLRt7CxzFgvaMhyRw@mail.gmail.com>
 <686abdd5-863a-02ce-5ac9-f573208b8315@c-s.fr>
In-Reply-To: <686abdd5-863a-02ce-5ac9-f573208b8315@c-s.fr>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 23 Apr 2019 12:26:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQyjhDaLk_9W65=s4jfPN_AAELuGSZRAs4Xup4Xj79CGQ@mail.gmail.com>
Message-ID: <CAK7LNAQyjhDaLk_9W65=s4jfPN_AAELuGSZRAs4Xup4Xj79CGQ@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
To: Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Dave Hansen <dave@sr71.net>,
 Arnd Bergmann <arnd@arndb.de>, the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 Ingo Molnar <mingo@redhat.com>, linux-mtd <linux-mtd@lists.infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christophe,

On Tue, Mar 26, 2019 at 3:03 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> Hi Masahiro,
>
> Le 25/03/2019 =C3=A0 07:44, Masahiro Yamada a =C3=A9crit :
> > Hi Christophe,
> >
> >
> > On Sat, Mar 23, 2019 at 5:27 PM LEROY Christophe
> > <christophe.leroy@c-s.fr> wrote:
> >>
> >> Arnd Bergmann <arnd@arndb.de> a =C3=A9crit :
> >>
> >>> On Wed, Mar 20, 2019 at 10:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >>>>
> >>>> I've added your patch to my randconfig test setup and will let you
> >>>> know if I see anything noticeable. I'm currently testing clang-arm32=
,
> >>>> clang-arm64 and gcc-x86.
> >>>
> >>> This is the only additional bug that has come up so far:
> >>>
> >>> `.exit.text' referenced in section `.alt.smp.init' of
> >>> drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section
> >>> `exit.text' of drivers/char/ipmi/ipmi_msghandler.o
> >>
> >> Wouldn't it be useful to activate -Winline gcc warning to ease finding
> >> out problematic usage of inline keyword ?
> >
> >
> > Yes, it is useful to find out
> > which function is causing the error.
> > Thanks for the tip.
> >
>
> I did a mass build on kisskb. Almost ok, see results at
> http://kisskb.ellerman.id.au/kisskb/head/203d912edf8dde291977c71aa6402406=
5e197f79/
>
> ps3_defconfig with GCC 5 fails
> (http://kisskb.ellerman.id.au/kisskb/buildresult/13742711/) with:
>
> arch/powerpc/mm/tlb-radix.c:148:2: error: asm operand 3 probably doesn't
> match constraints [-Werror]
> arch/powerpc/mm/tlb-radix.c:148:2: error: impossible constraint in 'asm'
> arch/powerpc/mm/tlb-radix.c:118:2: error: asm operand 3 probably doesn't
> match constraints [-Werror]
> arch/powerpc/mm/tlb-radix.c:104:2: error: asm operand 3 probably doesn't
> match constraints [-Werror]
>
> ps3_defconfig with GCC 4.6 fails
> (http://kisskb.ellerman.id.au/kisskb/buildresult/13742591/) with:
>
> arch/powerpc/mm/tlb-radix.c:148:2: error: asm operand 3 probably doesn't
> match constraints [-Werror]
> arch/powerpc/mm/tlb-radix.c:118:2: error: asm operand 3 probably doesn't
> match constraints [-Werror]
> arch/powerpc/mm/tlb-radix.c:104:2: error: asm operand 3 probably doesn't
> match constraints [-Werror]
>
> randconfig with GCC 4.6 fails
> (http://kisskb.ellerman.id.au/kisskb/buildresult/13742698/) with:
>
> arch/powerpc/mm/tlb-radix.c:104:2: error: impossible constraint in 'asm'


Thanks.

I fixed these ppc errors,
and separate out arch-fixes.

Now, the latest version is v3.


--=20
Best Regards
Masahiro Yamada
