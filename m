Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6A2C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 02:52:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C607620855
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 02:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wRz7gkXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C607620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43glqJ3ktgzDqv2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 13:52:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.90; helo=conssluserg-05.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="wRz7gkXb"; 
 dkim-atps=neutral
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43glnQ0cbHzDqpk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 13:51:04 +1100 (AEDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id x0I2oenU032051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 11:50:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x0I2oenU032051
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1547779842;
 bh=1yQKC2/NLxoALDEYQCVUGmittS8HAoFkA3tzO41eZ+I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=wRz7gkXblDEake5qNuvdooNwZjrlCvspnPv0ObVx/iQj9QcyowIQtPAR0xmcAXfH1
 TAGqh3p68yDXvTF8kyL7zay/m7+6asSZ37mRcuP1IjCa9hNoDiJNTLAlygONvXDlNo
 oCWfN2L4olOTHPsVPSc1o+sWhB8W+qWRTXaoEpo/0pUCNO7tYqus3KXm/xSjvc3+6+
 PayXwaTEI0eYauUN9us6AdxxuMgQ5CNpHG2VQm76M9G/I1sVn6mPaqMRgUDibvOiem
 3mBNk197Wxyf6lBIM2I4gKQ6kogPxTM1SGI80c87f9uIjdv9UrwoGPa4C1pMyuMip+
 sRhOhwaJ5/O/A==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id e7so7593789vsc.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 18:50:41 -0800 (PST)
X-Gm-Message-State: AJcUukdOlr1H8lrdleGKFDYjluWOe+yWAJBPHxFtuyNC0koeBDVAN2KU
 ZWES6AzaDClAlKOvhjMAtD+OqMSsh72uoZexT7k=
X-Google-Smtp-Source: ALg8bN41c2mw6CErAw0XXhGvoTvCytzaHn7YT6XQlOW2YEr1Umc0fAJ2j01AFMEzCnP4FutT7gPYsien25DGh4gFg7U=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr6972963vsb.155.1547779840012; 
 Thu, 17 Jan 2019 18:50:40 -0800 (PST)
MIME-Version: 1.0
References: <1547176954-17739-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1547176954-17739-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 18 Jan 2019 11:50:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNATkYYaZ68dmYACfadp+sPVbxWJ3r2KdX-7wJdzaCsKD+A@mail.gmail.com>
Message-ID: <CAK7LNATkYYaZ68dmYACfadp+sPVbxWJ3r2KdX-7wJdzaCsKD+A@mail.gmail.com>
Subject: Re: [PATCH 0/3] powerpc: some header search path cleanups
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
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
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,


On Fri, Jan 11, 2019 at 2:20 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I am trying to get rid of crappy magic from Kbuild core makefiles.
>
> Before that, I want to drop as many useless paths as possible.
> Actually, many Makefiles are adding around pointless options.
>
> This series cleans some powerpc Makefiles.
> (only compile-tested by 0day bot)


Could you apply this series to ppc tree if you are fine with it?





> Masahiro Yamada (3):
>   KVM: powerpc: remove -I. header search paths
>   powerpc: remove redundant header search path additions
>   powerpc: math-emu: remove unneeded header search paths
>
>  arch/powerpc/Makefile          | 4 ++--
>  arch/powerpc/kvm/Makefile      | 5 -----
>  arch/powerpc/math-emu/Makefile | 2 +-
>  3 files changed, 3 insertions(+), 8 deletions(-)
>
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
