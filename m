Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA70C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 06:15:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDB720879
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 06:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="M5yNkfWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDB720879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SPBg1XSkzDqMw
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 17:15:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.90; helo=conssluserg-05.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="M5yNkfWq"; 
 dkim-atps=neutral
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SP8Y69mwzDqF0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 17:13:33 +1100 (AEDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id x2P6DDat004808
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 15:13:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x2P6DDat004808
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1553494394;
 bh=Sx+F89ZCL+7I7bmEi4KU1fUncjZk/BW8NVT+rzg4YZM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=M5yNkfWqCZM61EfciI7aYwtMPdtHOgHCnWG7sAtBa01Yc3VAyopkSzeXY0q5UTSDx
 xeqhv4xcdKYHOUOagTdXmlsTYoqrxNtVogm4r1yn+OP0WEdrb1tU7NZkE/m14eDLMu
 UTdfbRtROPFjFBs6CgsxACemjQfyyrhRZa67i60+BlqdqVhCjc7Gy0M8A5FF7lcjPz
 WCEdYKv8UXuykajnwJuc7FSjDyFHrSAVPmrWU7yBe5HavbJeYT7zVteHfRn5kDjGmb
 G2Q5FGKAK68/GE3xqtCi3K916oI4lKIdXV6zURC3UF+0KRX4aHrmJjawz5lVS3DOUI
 hw6/1aChaZADw==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id s2so3383338vsi.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Mar 2019 23:13:14 -0700 (PDT)
X-Gm-Message-State: APjAAAW0qdAxLugwNTwlEUElHbVbLEXtCbUrSTWsFHcEhehLGUJmZBx3
 +qmaJmiz1+yqQeCErz0rZ+2QLwZt4APND2RhyUU=
X-Google-Smtp-Source: APXvYqzWUbmmHppt7GkpSeF6ZbIaPWFwcO9J7sA818cft6eG2FytjcwDC97ioibZl4L5MGq/cc4GOoihEgT7zdVYM4U=
X-Received: by 2002:a67:7c04:: with SMTP id x4mr14129809vsc.155.1553494393497; 
 Sun, 24 Mar 2019 23:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
 <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
 <CAK7LNAQvvCVsQtd9ZYkechOSCg4HAeZFaNXCgaBbWWxBYXOgaQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQvvCVsQtd9ZYkechOSCg4HAeZFaNXCgaBbWWxBYXOgaQ@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 25 Mar 2019 15:12:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNASzZVKivBjEa-93Ary=x98WeqMddqTWsqe4U-GXyuHTWQ@mail.gmail.com>
Message-ID: <CAK7LNASzZVKivBjEa-93Ary=x98WeqMddqTWsqe4U-GXyuHTWQ@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
To: Arnd Bergmann <arnd@arndb.de>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Dave Hansen <dave@sr71.net>,
 the arch/x86 maintainers <x86@kernel.org>, linux-mips@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 25, 2019 at 3:10 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Arnd,
>
>
>
>
> On Wed, Mar 20, 2019 at 10:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Mar 20, 2019 at 10:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > I've added your patch to my randconfig test setup and will let you
> > > know if I see anything noticeable. I'm currently testing clang-arm32,
> > > clang-arm64 and gcc-x86.
> >
> > This is the only additional bug that has come up so far:
> >
> > `.exit.text' referenced in section `.alt.smp.init' of
> > drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section
> > `exit.text' of drivers/char/ipmi/ipmi_msghandler.o
> >
> > diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
> > index 201100226301..84b12e33104d 100644
> > --- a/arch/arm/kernel/atags.h
> > +++ b/arch/arm/kernel/atags.h
> > @@ -5,7 +5,7 @@ void convert_to_tag_list(struct tag *tags);
> >  const struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer,
> >         unsigned int machine_nr);
> >  #else
> > -static inline const struct machine_desc *
> > +static __always_inline const struct machine_desc *
> >  setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
> >  {
> >         early_print("no ATAGS support: can't continue\n");
> >
>
>
> I do not know why to reproduce it,

"how to"


> but is "__init __noreturn" more sensible than
> "__always_inline" here?
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
