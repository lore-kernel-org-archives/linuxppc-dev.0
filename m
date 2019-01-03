Return-Path: <SRS0=6Lu7=PL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E08C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 00:39:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70EFB206A3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 00:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="trUrQ4d0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EFB206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43VTZH56RvzDqLH
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 11:39:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="trUrQ4d0";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.82; helo=conssluserg-03.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="trUrQ4d0"; 
 dkim-atps=neutral
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43VTWW1cKSzDqGt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jan 2019 11:36:54 +1100 (AEDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id x030aP4i019725
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Jan 2019 09:36:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x030aP4i019725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1546475786;
 bh=mJlYWSiWeqCZq2fJPK7I50b08OCqBiH7PgNOiO8M/9g=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=trUrQ4d0GJhO3Ji00o7ysJnLg6IbdIjv2lH9K+fNm6Eb/JfGraqu85JH4j6bzHl2m
 03VekhKiMkvrMdhyPGYNohhgmp1GL1btms/aqNntGR8lgQDMl1mXwi38cgt5csr2ZL
 bR+LmhnkzW2aBblu2vFFN47lk1y8k7IkjAnKqWXbbQ02Ii1q7+NA0tL/g1PKSieA0x
 eW8n9yEj7GxC4V5AjKzyOYDnSbuC4YA8EMEsodcLQ9oYAmdVhXhsL1IXMc+a7lfPbQ
 ZTPu6riAnPWyy/IoqC04dxkNapSh5wlaMrZi3M6aTY5B6klUt8TQCiP4N4jOTmi2Mh
 2SB5SHKN4Mjnw==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id t127so6937064vke.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Jan 2019 16:36:26 -0800 (PST)
X-Gm-Message-State: AJcUukcUQklUJgIXtk2Cy19mOUTq3bgbZR2GxwCxBWToFyd3IeCh2+tb
 3yV62Q0q81MWL+iIn9N9Mi6WtkGrbTYOgsBEIuk=
X-Google-Smtp-Source: ALg8bN5FKddHcrGWono5UpsMPLqZ5N1NpHGJZCSJ3hQLIGkLGFV1mgyHFxVQz3xse4vncUMh7jRcVM6IwDWcKpScUP8=
X-Received: by 2002:a1f:27d7:: with SMTP id n206mr17035556vkn.0.1546475785253; 
 Wed, 02 Jan 2019 16:36:25 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUU=1S0Xg3+zWNU-60eknfWyL2kjEPm2BNNTK8Eu-tkTEg@mail.gmail.com>
In-Reply-To: <CA+icZUU=1S0Xg3+zWNU-60eknfWyL2kjEPm2BNNTK8Eu-tkTEg@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 3 Jan 2019 09:35:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNASWScb7Qt0kmV8RyBdix2GPA24gv=eRNYVWu5dGGePbfQ@mail.gmail.com>
Message-ID: <CAK7LNASWScb7Qt0kmV8RyBdix2GPA24gv=eRNYVWu5dGGePbfQ@mail.gmail.com>
Subject: Re: jump_label: move 'asm goto' support test to Kconfig
To: Sedat Dilek <sedat.dilek@gmail.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 X86 ML <x86@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-s390 <linux-s390@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, sparclinux <sparclinux@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S . Miller" <davem@davemloft.net>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 2, 2019 at 9:14 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Hi,
>
> I was not aware that CONFIG_JUMP_LABEL Kconfig setting depends on the
> support of asm-goto.
>
> Currently, I am doing experiments with clang-7 and a snapshot of
> clang-8 on Linux/x86.
> These compilers have no asm-goto support.
>
> What is your recommendation for Linux >= v4.20?
> I am asking as it is possible to set CONFIG_JUMP_LABEL=y when
> compiling with clang - which has no effect.
> This is confusing.
>
> Thanks, this patch makes things clearer and protects users from
> setting "wrong" in the sense of non-functional settings.
>
> I have tested this against recent Linus tree where kbuild/kconfig Git
> pulls were latest commits.
>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> [ x86 with LLVM/Clang
> v7 and v8 (snapshot) ]


Which part was tested?

x86 kernel cannot be compiled with Clang
since it lacks the asm-goto support.


$ make CC=clang
Compiler lacks asm-goto support.
arch/x86/Makefile:293: recipe for target 'checkbin' failed
make: *** [checkbin] Error 1






-- 
Best Regards
Masahiro Yamada
