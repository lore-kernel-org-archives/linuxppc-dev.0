Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF16FC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 03:31:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C272080F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 03:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EH8wJGh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C272080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tbs45JMqzF3Nl
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 14:31:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="EH8wJGh5";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.91; helo=conssluserg-06.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="EH8wJGh5"; 
 dkim-atps=neutral
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tbpV0TCxzF3KD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 14:29:21 +1100 (AEDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com
 [209.85.222.48]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id wAC3T2ER002422
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 12:29:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wAC3T2ER002422
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1541993343;
 bh=rrO05wm73tPB3UeW7NA/fPQEeVRu0RZ8cacGop4OV2s=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=EH8wJGh5uVd04UX2H91lMeVxCUxjCBRfFrjQ2p+kvjq6ZwvEJDq6EVRj+WY0zgQRq
 KBRXAZ8h29IzfnGZvoYwox4rDuB1SPeOPMiApSr6Qkh1SAchmW0nFSiECJkWBg6yc7
 Th+Q0z3xNjb8Afki/gGtezkfriCi3eu39VW067P7RCGmjgsNqePfaVbiIeAcxj3Bmd
 0H4iyxUEKuFRP3qdekqcw0Swbet6dw4078QALisDirqMeKb1nhSjlPjwgCUZU96dZq
 CXTkHs+p8M2UL0tCzG7+t3o4AZzMlmvOdS9T4yGO2iPGFVxO+izFYOdul0jIGoBV/k
 88sQMfbi6iUJQ==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id z24so2565665ual.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Nov 2018 19:29:03 -0800 (PST)
X-Gm-Message-State: AGRZ1gK9W4P2wRCwosXZrMu8TdStk1v/a25xA3BE24Udt9iZZVVOcX2o
 BX87WNv7ZeUXf9ssw3haSatQgTxB0/Hyb6lGB6k=
X-Google-Smtp-Source: AJdET5eSJ2GGwQ7szfWe7yzvy4zHjo2pyUrNK4TsBmHdAEf1dvByD7UGkNvtIN7Ctr0Pl6E530yxIAfu/F3W20OnxOE=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr7548814uaj.42.1541993341942;
 Sun, 11 Nov 2018 19:29:01 -0800 (PST)
MIME-Version: 1.0
References: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com>
 <1541473495-25262-2-git-send-email-yamada.masahiro@socionext.com>
 <CAKwvOd=JwjVu=uk3egVJxTm9vPcF=Jx2Bexx1Wx=Z-PC38X3Uw@mail.gmail.com>
 <9c4868dd-82fa-aa5c-843e-e1f78ffbc7e2@google.com>
 <CAK7LNAR32=QWy4jss3M3VSNj0XY=tvgWWTG5ajVEpyYD2J+Z1Q@mail.gmail.com>
 <87pnvb9kc3.fsf@concordia.ellerman.id.au>
In-Reply-To: <87pnvb9kc3.fsf@concordia.ellerman.id.au>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 12 Nov 2018 12:28:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNATsY3_wy8DL9+g+-AytY6mStwFoeA+CMQdVFkXZ2SKdyA@mail.gmail.com>
Message-ID: <CAK7LNATsY3_wy8DL9+g+-AytY6mStwFoeA+CMQdVFkXZ2SKdyA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: consolidate Clang compiler flags
To: Michael Ellerman <mpe@ellerman.id.au>
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
 Nick Desaulniers <ndesaulniers@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Stefan Agner <stefan@agner.ch>, Matthias Kaehlcke <mka@chromium.org>,
 Joel Stanley <joel@jms.id.au>, Greg Hackmann <ghackmann@google.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 12, 2018 at 10:05 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> > On Sat, Nov 10, 2018 at 3:35 AM Greg Hackmann <ghackmann@google.com> wrote:
> >>
> >> On 11/09/2018 10:29 AM, Nick Desaulniers wrote:
> >> > On Mon, Nov 5, 2018 at 7:05 PM Masahiro Yamada
> >> > <yamada.masahiro@socionext.com> wrote:
> >> >>
> >> >> Collect basic Clang options such as --target, --prefix, --gcc-toolchain,
> >> >> -no-integrated-as into a single variable CLANG_FLAGS so that it can be
> >> >> easily reused in other parts of Makefile.
> >> >>
> >> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >> >> ---
> >> >>
> >> >> Changes in v2:
> >> >>   - Use := flavor instead of = because $(CLANG_FLAGS) is expanded soon anyway
> >> >>
> >> >>   Makefile | 13 ++++++-------
> >> >>   1 file changed, 6 insertions(+), 7 deletions(-)
> >> >>
> >> >> diff --git a/Makefile b/Makefile
> >> >> index da11700..e173a73 100644
> >> >> --- a/Makefile
> >> >> +++ b/Makefile
> >> >> @@ -487,18 +487,17 @@ endif
> >> >>
> >> >>   ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> >> >>   ifneq ($(CROSS_COMPILE),)
> >> >> -CLANG_TARGET   := --target=$(notdir $(CROSS_COMPILE:%-=%))
> >> >> +CLANG_FLAGS    := --target=$(notdir $(CROSS_COMPILE:%-=%))
> >> >>   GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
> >> >> -CLANG_PREFIX   := --prefix=$(GCC_TOOLCHAIN_DIR)
> >> >> +CLANG_FLAGS    += --prefix=$(GCC_TOOLCHAIN_DIR)
> >> >>   GCC_TOOLCHAIN  := $(realpath $(GCC_TOOLCHAIN_DIR)/..)
> >> >>   endif
> >> >>   ifneq ($(GCC_TOOLCHAIN),)
> >> >> -CLANG_GCC_TC   := --gcc-toolchain=$(GCC_TOOLCHAIN)
> >> >> +CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
> >> >>   endif
> >> >> -KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> >> >> -KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> >> >> -KBUILD_CFLAGS += -no-integrated-as
> >> >> -KBUILD_AFLAGS += -no-integrated-as
> >> >> +CLANG_FLAGS    += -no-integrated-as
> >> >> +KBUILD_CFLAGS  += $(CLANG_FLAGS)
> >> >> +KBUILD_AFLAGS  += $(CLANG_FLAGS)
> >> >>   endif
> >> >>
> >> >>   RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
> >> >> --
> >> >> 2.7.4
> >> >>
> >> >
> >> > Thanks for this patch, Masahiro, it's a good simplification.
> >> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> >> >
> >> > Would you mind waiting for a tested-by from Stefan, and maybe an ack
> >> > from Greg (added to cc)?
> >> >
> >>
> >> Acked-by: Greg Hackmann <ghackmann@google.com>
> >
> >
> > Thanks for your review!
> >
> >
> > So, how to organize this series, and Joel's one together?
> >
> > I'd like Joel to use this series as a base for his work.
> > (https://lore.kernel.org/patchwork/patch/1006696/)
> >
> > It will be much cleaner.
> >
> >
> > Shall I merge all the patches to kbuild tree, or
> > maybe will they go through powerpc tree?
>
> Joel's changes are fairly small so you may as well merge them along with
> the rest of the series, if that's OK with you and Joel.


OK, I will.


Joel,
If you send v2, I will merge it to kbuild tree.



Thanks.



-- 
Best Regards
Masahiro Yamada
