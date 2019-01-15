Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D97AC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:05:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A2820656
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CkoXq0Al"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A2820656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fDDQ1Km5zDqfp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 02:05:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.83; helo=conssluserg-04.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="CkoXq0Al"; 
 dkim-atps=neutral
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fD8T5n5gzDqYY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 02:02:17 +1100 (AEDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id x0FF1ihp015701
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 00:01:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x0FF1ihp015701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1547564505;
 bh=ORvUJeYfdFDrcDEJahOg9VUCtLZ2xiu2Oy8mXwaaIds=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CkoXq0AlQFcK1L0PN0tH0nyfP75iEVVxlzJvrfq2DzwFQd+amiOZ5uoqkKsYVubRq
 T0D9c66F6WzDaymeq7pRw64GMJY0GiU0nmPBsZgB1w3av8FeihesqQ0LIBfyrLOWKb
 0eq8z90Nud32hBdZuxEN9LrPyptjh0o1d10XE8LJ0mCXOM+ywzAB21xw1UcbzZcJLe
 hdQciUUPrmAScpxNrBSZxk/cEtZ9NPbpWQpFr3KJlyKlERzZkxKpcW6O2Q7YoQSVKN
 Dkt8sciIQ+8iCYqOEmUc+GkKGubIQsSpCzumPuAGYdCFgHKlXr7oII91VELxEjp+St
 9ZkaimboShrVA==
X-Nifty-SrcIP: [209.85.221.179]
Received: by mail-vk1-f179.google.com with SMTP id v70so654528vkv.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 07:01:45 -0800 (PST)
X-Gm-Message-State: AJcUukdfXsEW9XSIZD15/eVGjNuwW+GDdQ0jA6rHE+0xITdsPtPCqNxx
 ukExX7IjeRjCIuFuSo09Gcc4NJBsRJ5dx5dm57U=
X-Google-Smtp-Source: ALg8bN4YfC6UsLXiw39L4cdipSwrzdTR3i5ZeLonmxft1fWewN9xTwsZCNcM6LLWFXGv7Z5sLmjNdW33vmmneD91rKI=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr1614598vkd.74.1547564504148; 
 Tue, 15 Jan 2019 07:01:44 -0800 (PST)
MIME-Version: 1.0
References: <1547536740-1572-1-git-send-email-yamada.masahiro@socionext.com>
 <54f84ad6-279f-aa64-8c2c-59becd64a6ad@ozlabs.ru>
In-Reply-To: <54f84ad6-279f-aa64-8c2c-59becd64a6ad@ozlabs.ru>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 16 Jan 2019 00:01:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8xkZCK5keS9SEdNTUsVRb+_hac4yvBG=1HebrkheAqw@mail.gmail.com>
Message-ID: <CAK7LNAS8xkZCK5keS9SEdNTUsVRb+_hac4yvBG=1HebrkheAqw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: mark prepare0 as PHONY to fix external module
 build
To: Alexey Kardashevskiy <aik@ozlabs.ru>
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
Cc: Michal Marek <michal.lkml@markovi.net>,
 Samuel Holland <samuel@sholland.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-stable # v4 . 20" <stable@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 15, 2019 at 7:45 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
>
>
> On 15/01/2019 18:19, Masahiro Yamada wrote:
> > Commit c3ff2a5193fa ("powerpc/32: add stack protector support")
> > caused kernel panic on PowerPC if an external module is used with
> > CONFIG_STACKPROTECTOR because the 'prepare' target was not executed
> > for the external module build.
> >
> > Commit e07db28eea38 ("kbuild: fix single target build for external
> > module") turned it into a build error because the 'prepare' target is
> > now executed but the 'prepare0' target is missing for the external
> > module build.
> >
> > External module on arm/arm64 with CONFIG_STACKPROTECTOR_PER_TASK is
> > also broken in the same way.
> >
> > Move 'PHONY += prepare0' to the common place. Make is fine with missing
> > rule for phony targets.
> >
> > I minimize the change so it can be easily backported to 4.20.x
> >
> > To fix v4.20 for external modules of PowerPC, please backport
> > e07db28eea38 ("kbuild: fix single target build for external module"),
> > and then this commit.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=201891
> > Fixes: e07db28eea38 ("kbuild: fix single target build for external module")
> > Fixes: c3ff2a5193fa ("powerpc/32: add stack protector support")
> > Fixes: 189af4657186 ("ARM: smp: add support for per-task stack canaries")
> > Fixes: 0a1213fa7432 ("arm64: enable per-task stack canaries")
> > Cc: linux-stable <stable@vger.kernel.org> # v4.20
> > Reported-by: Samuel Holland <samuel@sholland.org>
> > Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
>
> Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
> Thanks for fixing this! Out of curiosity - how does this work?
> arch/powerpc/Makefile's stack_protector_prepare still depends on
> prepare0 which is still defined only if KBUILD_EXTMOD=="" but somehow it
> does not bother ./Makefile? Thanks,


Missing phony targets are ignored.


I do not know if it is officially documented,
but GNU Make works like that.

Is the following test code helpful?


[Test Makefile]

prepare: prepare0
        @echo hello world

.PHONY: prepare prepare0


[Result]
$ make
hello world



-- 
Best Regards
Masahiro Yamada
