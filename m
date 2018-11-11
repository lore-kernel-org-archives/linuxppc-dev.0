Return-Path: <SRS0=qVND=NW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6CDC43441
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Nov 2018 14:07:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E85420866
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Nov 2018 14:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pq0RY8UA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E85420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tG0l5dvbzF3Sq
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 01:07:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="pq0RY8UA";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.83; helo=conssluserg-04.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="pq0RY8UA"; 
 dkim-atps=neutral
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tFyB47B8zF3RK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 01:04:49 +1100 (AEDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id wABE4BWD015534
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Nov 2018 23:04:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wABE4BWD015534
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1541945052;
 bh=kGjnAxcaEdU5iOxpNNvXA/L0FC0uvXp1eA+Et/kr9W4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=pq0RY8UAfc1b92qez0/aYUQrDFBsacMgZPVrCH9irpmEY3GEVKdXCmuQgAkiAW6jU
 Fz3UgGsStzCHfGKUiVUUpn1t74glQzNLGVVOI0EXzvRuLy2tqSClQqpVghL9sRnH3j
 4InTa/QXqeNPRZTlSWS3ONmghZyQucgGjC15WwXo7ev04m7HtKEw/S5w1aX7e7TMB9
 uaBXBuIxEXbeFgoTGoLeTH41O20QmPQtimiXnx+XyzEfSapufr+IICVTABXpQYks7N
 x6NmZByFGfG/2TDqSGWDWzE/E2CIsj8PGoCWJZqsbhNmu8Sy/FZwY6XCCxoK9787gP
 U227ChpavTRcg==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id y27so3677852vsi.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Nov 2018 06:04:11 -0800 (PST)
X-Gm-Message-State: AGRZ1gKkCdK7VHfYvNOpbAd37A7ekivxgwDzGe+js3QwV7/gAPvHnuXp
 IxRxTSAkz96ZU0nWM834JukEzuLjC8+vFkBAYUo=
X-Google-Smtp-Source: AJdET5dAuf4JPwOoOYPeE4hhQQx4yZ+G/RpKoBSNi16WWfHBcVrP0cYuAVriuXex0IEepPXL10nl/gDO5M2sweyVCaI=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr6690623vsm.181.1541945050069; 
 Sun, 11 Nov 2018 06:04:10 -0800 (PST)
MIME-Version: 1.0
References: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com>
 <1541473495-25262-2-git-send-email-yamada.masahiro@socionext.com>
 <CAKwvOd=JwjVu=uk3egVJxTm9vPcF=Jx2Bexx1Wx=Z-PC38X3Uw@mail.gmail.com>
 <9c4868dd-82fa-aa5c-843e-e1f78ffbc7e2@google.com>
In-Reply-To: <9c4868dd-82fa-aa5c-843e-e1f78ffbc7e2@google.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 11 Nov 2018 23:03:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR32=QWy4jss3M3VSNj0XY=tvgWWTG5ajVEpyYD2J+Z1Q@mail.gmail.com>
Message-ID: <CAK7LNAR32=QWy4jss3M3VSNj0XY=tvgWWTG5ajVEpyYD2J+Z1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: consolidate Clang compiler flags
To: Greg Hackmann <ghackmann@google.com>, Joel Stanley <joel@jms.id.au>,
 Nick Desaulniers <ndesaulniers@google.com>
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
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Stefan Agner <stefan@agner.ch>, Matthias Kaehlcke <mka@chromium.org>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Nov 10, 2018 at 3:35 AM Greg Hackmann <ghackmann@google.com> wrote:
>
> On 11/09/2018 10:29 AM, Nick Desaulniers wrote:
> > On Mon, Nov 5, 2018 at 7:05 PM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >>
> >> Collect basic Clang options such as --target, --prefix, --gcc-toolchain,
> >> -no-integrated-as into a single variable CLANG_FLAGS so that it can be
> >> easily reused in other parts of Makefile.
> >>
> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >> ---
> >>
> >> Changes in v2:
> >>   - Use := flavor instead of = because $(CLANG_FLAGS) is expanded soon anyway
> >>
> >>   Makefile | 13 ++++++-------
> >>   1 file changed, 6 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/Makefile b/Makefile
> >> index da11700..e173a73 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -487,18 +487,17 @@ endif
> >>
> >>   ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> >>   ifneq ($(CROSS_COMPILE),)
> >> -CLANG_TARGET   := --target=$(notdir $(CROSS_COMPILE:%-=%))
> >> +CLANG_FLAGS    := --target=$(notdir $(CROSS_COMPILE:%-=%))
> >>   GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
> >> -CLANG_PREFIX   := --prefix=$(GCC_TOOLCHAIN_DIR)
> >> +CLANG_FLAGS    += --prefix=$(GCC_TOOLCHAIN_DIR)
> >>   GCC_TOOLCHAIN  := $(realpath $(GCC_TOOLCHAIN_DIR)/..)
> >>   endif
> >>   ifneq ($(GCC_TOOLCHAIN),)
> >> -CLANG_GCC_TC   := --gcc-toolchain=$(GCC_TOOLCHAIN)
> >> +CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
> >>   endif
> >> -KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> >> -KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> >> -KBUILD_CFLAGS += -no-integrated-as
> >> -KBUILD_AFLAGS += -no-integrated-as
> >> +CLANG_FLAGS    += -no-integrated-as
> >> +KBUILD_CFLAGS  += $(CLANG_FLAGS)
> >> +KBUILD_AFLAGS  += $(CLANG_FLAGS)
> >>   endif
> >>
> >>   RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
> >> --
> >> 2.7.4
> >>
> >
> > Thanks for this patch, Masahiro, it's a good simplification.
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Would you mind waiting for a tested-by from Stefan, and maybe an ack
> > from Greg (added to cc)?
> >
>
> Acked-by: Greg Hackmann <ghackmann@google.com>


Thanks for your review!


So, how to organize this series, and Joel's one together?

I'd like Joel to use this series as a base for his work.
(https://lore.kernel.org/patchwork/patch/1006696/)

It will be much cleaner.


Shall I merge all the patches to kbuild tree, or
maybe will they go through powerpc tree?




--
Best Regards
Masahiro Yamada
