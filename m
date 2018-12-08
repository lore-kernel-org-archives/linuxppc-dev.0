Return-Path: <SRS0=zuPs=OR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716E5C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 19:22:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEAEF20837
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 19:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VfzkZwKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAEF20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BzkM23DGzDqSy
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 06:22:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="VfzkZwKD";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.91; helo=conssluserg-06.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="VfzkZwKD"; 
 dkim-atps=neutral
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BzdL1tllzDrL3
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Dec 2018 06:18:13 +1100 (AEDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id wB8JHtgN018492
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Dec 2018 04:17:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wB8JHtgN018492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544296676;
 bh=hCPA0RPn5CtjCd+h5IZiCTDhNEqPtCmsBZgqeWznGo4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=VfzkZwKD/q3wwr2duZUJg55E6dEEvCE67LsFedT0UO9lnSf5U+i9lxxQnOsy+qPcB
 fX0olPMiC0zgItLwSVjtLZKzON1Zc5QKx2X8/afsekuWxjvZQgtK8lm4fCnj/EqKxP
 YMofp2yoEbirdGNgmmQpbnBd2rlEVrGEZq3JKcJvF227D58+kcOSU4/hovtFa9RvwQ
 yXUW0h8angnWIfjOtjpXmkELmT/j4cVTkaLl6W923DMiUPQLo/g+kw/RxEDXtzPePy
 yikCRQaWDoH7fndAOGIyFYPFzo2XJ5dXspdF+9RndIyxgCZ4eE9h54UfLhOjQKE54q
 2eEh9l8LVcGmQ==
X-Nifty-SrcIP: [209.85.221.172]
Received: by mail-vk1-f172.google.com with SMTP id t127so1686760vke.8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Dec 2018 11:17:55 -0800 (PST)
X-Gm-Message-State: AA+aEWbdzMNhmTJ2FtgJAwzOHHrNKrXA1qYXC9MfkdtQAjt8jzbyyApc
 jDY9qbyok06txiZuWNNuXptgorBmIw1lUsqAIck=
X-Google-Smtp-Source: AFSGD/Uf2k7L99EsX7VN92HWhN+pEIsKdU8v3UiKpW9ugsPMbA3olifTnODlubDe8gPYmC6ZowJiB+UiJ9zrt1X5aRI=
X-Received: by 2002:a1f:4d47:: with SMTP id a68mr2780127vkb.34.1544296674940; 
 Sat, 08 Dec 2018 11:17:54 -0800 (PST)
MIME-Version: 1.0
References: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
 <1541990120-9643-3-git-send-email-yamada.masahiro@socionext.com>
 <87k1lia6bd.fsf@concordia.ellerman.id.au>
 <CAK7LNARbzF9-ZYvX7U76HqC957Fj=U3rmQfCEYXKqZNV8SFmNg@mail.gmail.com>
 <20181208113313.GD30399@zn.tnic>
In-Reply-To: <20181208113313.GD30399@zn.tnic>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 9 Dec 2018 04:17:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASJKeozY9+65H6xx1uUhwqL=8TOFCQEU-9Lm+Q6dyyQ_Q@mail.gmail.com>
Message-ID: <CAK7LNASJKeozY9+65H6xx1uUhwqL=8TOFCQEU-9Lm+Q6dyyQ_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86,
 powerpc: remove -funit-at-a-time compiler option entirely
To: Borislav Petkov <bp@alien8.de>
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
Cc: X86 ML <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Richard Weinberger <richard@sigma-star.at>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Borislav,


On Sat, Dec 8, 2018 at 8:34 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Dec 08, 2018 at 03:36:52PM +0900, Masahiro Yamada wrote:
> > x86 maintainers,
> >
> > Ping.
>
> You got the required ACKs. If you want me to carry this one and the
> UML one through the tip tree, lemme know. Or you can do what Richard
> suggested. Your call.


Thank you for your help.
I expect both applied through the tip bot.

Thanks.





> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.



-- 
Best Regards
Masahiro Yamada
