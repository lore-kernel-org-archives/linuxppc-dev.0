Return-Path: <SRS0=a/z+=75=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF9CC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2020 03:25:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5310208C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2020 03:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wYYIk0FO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5310208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49mD9P1vcBzDqkq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2020 13:25:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (domain owner discourages use of this
 host) smtp.mailfrom=kernel.org (client-ip=210.131.2.83;
 helo=conssluserg-04.nifty.com; envelope-from=masahiroy@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.a=rsa-sha256
 header.s=dec2015msa header.b=wYYIk0FO; 
 dkim-atps=neutral
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49mD716bmJzDqdr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2020 13:23:25 +1000 (AEST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
 [209.85.222.52]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 05G3MwVZ003766
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2020 12:22:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 05G3MwVZ003766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1592277779;
 bh=2/462jbz7jQVLiDVVWzKKcGk4qeztCSU3uhhsd45JF4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=wYYIk0FO0sb92e2n/k8NDpk1fopYb/hY4bojA+HZaTpXZg8QWF10eTYMBVFJzMMts
 f6EP6j6l/ayQFmsSHbv35ZUgEO5uZBLAiG+yQ3qkg5VNjtCekxFiQxOuCZdOkn6Biv
 J88nBCSBkcZX7wW+UcHl+pvbb6APUvlSs97EBsX4+eQbtoMorRPN72yAiHi/9u4yk1
 edXCX7WUDLOUIPyLAlUy8+5+TK/+ZysRuznDOeFpo4usH05y5bIyRCBh6EQ2JhBNho
 WBI473G6N9PPZ84EIDgMSY6irJ5wRVKJ2ZigU9k80QpP0XLXVIZhTnGMZF4OE4l6f9
 xG3ihqbqga5Gw==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id a10so6430952uan.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2020 20:22:58 -0700 (PDT)
X-Gm-Message-State: AOAM530Uw8Faw38ACZqy+IoF5zWkQmLQuhD967JL1Rac5go7MydI/6ua
 W0UIuz2xgEtWcUrP/a/X8ElPHezAEJBsTBstkNs=
X-Google-Smtp-Source: ABdhPJylS2uk1OU4K6oY6oUB9JpzLgAK28MZHSy9Ieuy0bzPvPbnNVm5vCKIc+H1HptOGXkvcNfJXLqC1s/sVZgEnTE=
X-Received: by 2002:ab0:156d:: with SMTP id p42mr462901uae.121.1592277777648; 
 Mon, 15 Jun 2020 20:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200521202716.193316-1-samitolvanen@google.com>
 <CAK7LNARq3g5vA6vy9449SHsKQmbwJrQDSBz4ZbH1pBEvPmusuA@mail.gmail.com>
 <CAK7LNASm2t-Dkr+p_EWvqf_eoKn5R2iXWuBHnTB9n6MUxr3-pQ@mail.gmail.com>
 <1590226253.lnkg0jun9x.astroid@bobo.none>
 <CAK7LNAR_-q3jhaUzDpkC3ej_DpAerzMsORT-tFw_3AwX7xM0Yw@mail.gmail.com>
 <CABCJKufaMU1z-s4S+dHhg0iCyVynLGwsFJgYnYyiBaR=mZt-8w@mail.gmail.com>
In-Reply-To: <CABCJKufaMU1z-s4S+dHhg0iCyVynLGwsFJgYnYyiBaR=mZt-8w@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 16 Jun 2020 12:22:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNARbZhoaA=Nnuw0=gBrkuKbr_4Ng_Ei57uafujZf7Xazgw@mail.gmail.com>
Message-ID: <CAK7LNARbZhoaA=Nnuw0=gBrkuKbr_4Ng_Ei57uafujZf7Xazgw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: reuse vmlinux.o in vmlinux_link
To: Sami Tolvanen <samitolvanen@google.com>
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
Cc: Michal Marek <michal.lkml@markovi.net>, Kees Cook <keescook@chromium.org>,
 Sam Ravnborg <sam@ravnborg.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 16, 2020 at 6:47 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Sat, May 23, 2020 at 8:13 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Hi Nicholas,
> > (+CC: Sam Ravnborg)
> >
> >
> > On Sat, May 23, 2020 at 7:06 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> > >
> > > Excerpts from Masahiro Yamada's message of May 23, 2020 3:44 am:
> > > > + Michael, and PPC ML.
> > > >
> > > > They may know something about the reason of failure.
> > >
> > > Because the linker can't put branch stubs within object code sections,
> > > so when you incrementally link them too large, the linker can't resolve
> > > branches into other object files.
> >
> >
> > Ah, you are right.
> >
> > So, this is a problem not only for PPC
> > but also for ARM (both 32 and 64 bit), etc.
> >
> > ARM needs to insert a veneer to jump far.
> >
> > Prior to thin archive, we could not compile
> > ARCH=arm allyesconfig because
> > drivers/built-in.o was too large.
> >
> > This patch gets us back to the too large
> > incremental object situation.
> >
> > With my quick compile-testing,
> > ARCH=arm allyesconfig
> > and ARCH=arm64 allyesconfig are broken.
>
> Thanks for looking into this! Clang doesn't appear to have this issue
> with LTO because it always enables both -ffunction-sections and
> -fdata-sections. I confirmed that -ffunction-sections also fixes arm64
> allyesconfig with this patch. While I'm fine with reusing vmlinux.o
> only with LTO, how would you feel about enabling -ffunction-sections
> in the kernel by default?


I am OK if it works.

Please do compile tests for some architectures.
(especially, ARCH=powerpc defconfig, and ARCH=arm(64) allyesconfig)


Thank you.




-- 
Best Regards
Masahiro Yamada
