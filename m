Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA427C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 06:47:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF5A206C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 06:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="s9SfYvAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF5A206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SPv62hX3zDqLj
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 17:46:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.90; helo=conssluserg-05.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="s9SfYvAe"; 
 dkim-atps=neutral
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SPrw2KJnzDqHF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 17:45:03 +1100 (AEDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id x2P6ig2J017409
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 15:44:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x2P6ig2J017409
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1553496283;
 bh=TBTAAoxc845YLThKvAPkYbBCM6ldvYbj/UGkzwkcQAM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=s9SfYvAeSqIUtAvXRpZnL3fs+fGErLsknf/UM8QsJCd+E31WXSg8W4awFda3+J8Sd
 WnYCHXk2JEsfZepAmv+CysBKLnqmhQEKM0rPUd5KD2d8F16pId5qvhma7zkNPZsmKB
 S85mimjzYlvb94oGamww08hck4dFGnybJirdkvWdc4lzI4qS7j4Vq2VJw92okBS1SW
 4cp7uBLkaV2TA2XvEuSRJhfPIJ/F5W5QoEqhUG7VNrD+ePJdQFf/BshskYshCberRv
 9eFNYSojHTFFxRkki3KpOgnTmA8R4DaBIlnuwpI8MkV4aZ7FSvwlhIrrBChClK4u8A
 jxwnRXEu//UIw==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id o187so1710085vkg.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Mar 2019 23:44:43 -0700 (PDT)
X-Gm-Message-State: APjAAAW/TrCmoPP6dbneCyHm4V83YuIBOG2OsthpNCI/MVhYTxQSYQZr
 MKYJHlBoVEK5VVR1uqN27VbXlwFzJpbna4xrgjM=
X-Google-Smtp-Source: APXvYqwTSFTBYn1wiYBRqHfKdoCVAdr+1/wgpdan2TCSHZXnhVT5/9jZ4MbEQSjIRz89Tdd3klpPpTJYpCQPkyUEguo=
X-Received: by 2002:a1f:b297:: with SMTP id b145mr13805982vkf.74.1553496282456; 
 Sun, 24 Mar 2019 23:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
 <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
 <20190323092640.Horde.2lm4u26aZox5ialxuIRcYw2@messagerie.si.c-s.fr>
In-Reply-To: <20190323092640.Horde.2lm4u26aZox5ialxuIRcYw2@messagerie.si.c-s.fr>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 25 Mar 2019 15:44:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQGifytZRQXcqma9VuvQPfL2w8NjzLRt7CxzFgvaMhyRw@mail.gmail.com>
Message-ID: <CAK7LNAQGifytZRQXcqma9VuvQPfL2w8NjzLRt7CxzFgvaMhyRw@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
To: LEROY Christophe <christophe.leroy@c-s.fr>
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


On Sat, Mar 23, 2019 at 5:27 PM LEROY Christophe
<christophe.leroy@c-s.fr> wrote:
>
> Arnd Bergmann <arnd@arndb.de> a =C3=A9crit :
>
> > On Wed, Mar 20, 2019 at 10:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> I've added your patch to my randconfig test setup and will let you
> >> know if I see anything noticeable. I'm currently testing clang-arm32,
> >> clang-arm64 and gcc-x86.
> >
> > This is the only additional bug that has come up so far:
> >
> > `.exit.text' referenced in section `.alt.smp.init' of
> > drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section
> > `exit.text' of drivers/char/ipmi/ipmi_msghandler.o
>
> Wouldn't it be useful to activate -Winline gcc warning to ease finding
> out problematic usage of inline keyword ?


Yes, it is useful to find out
which function is causing the error.
Thanks for the tip.




--=20
Best Regards
Masahiro Yamada
