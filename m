Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA61C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 23:37:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D21F2089F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 23:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="afgb2h1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D21F2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vkZS31wbzF35x
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 10:37:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="afgb2h1+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.80; helo=conssluserg-01.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="afgb2h1+"; 
 dkim-atps=neutral
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vkWr36nkzF1db
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 10:35:35 +1100 (AEDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id wADNZHok013719
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 08:35:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wADNZHok013719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1542152118;
 bh=sSXMBgmuxJgcZzkMncWIxAb5vAYpdu3DZF/y0sql7P4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=afgb2h1+ZaZjfXZlkoolypxPd9daW+DJlNqDaz0qBvZHjAFaBgjUguCltYKRDaXuP
 v4e2vafDN1Ywtb0XLOK05VaAFWWIEYmpIl2QnAFSVyo0MMBCfCZg1xTwzpMidvZDuB
 BYab2x3o/F6yTdWZxRUzfpUU27x6BXDT0hlng6tokm1VE/CAkpA/H2UP3fFu+lgMBJ
 iuvl2W6xeHtKeySbyfukqlHzaG01Uf7zAuVyyZ7Fn7n2+WQ/E6L+1H/oTllxapu9O/
 9M0/3AIdxN2bxMQLo7V59x/1dpGE5TB8A8K1WJeRjmfmxf6CoK6UAgPst5JafShbEn
 +zr3x1/P8J6tQ==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id v205so8434068vsc.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 15:35:18 -0800 (PST)
X-Gm-Message-State: AGRZ1gJjti6wRgn/jdV0hDnWKG5KnqWoVnD44IrY+RhxDpwlISeiF/J9
 BK+3JwzQQ73QDsv89uR/tSWD2XDj7QlD1QdGdbU=
X-Google-Smtp-Source: AJdET5dwinbLOTUOJQJfzWMAe4foUc7O0hjZ62BCis1H+Cga9sGHmY0h1spzq8E89MKq8BeSQEanqi93aOUMxRXOQIo=
X-Received: by 2002:a67:385a:: with SMTP id f87mr3309516vsa.179.1542152117086; 
 Tue, 13 Nov 2018 15:35:17 -0800 (PST)
MIME-Version: 1.0
References: <20181112042116.5271-1-joel@jms.id.au>
 <20181112042116.5271-2-joel@jms.id.au>
In-Reply-To: <20181112042116.5271-2-joel@jms.id.au>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 14 Nov 2018 08:34:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUCBbjppeLEm83+y69ySV=d0E-MZ9eheFKznbhf4m9sw@mail.gmail.com>
Message-ID: <CAK7LNASUCBbjppeLEm83+y69ySV=d0E-MZ9eheFKznbhf4m9sw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Makefile: Export clang toolchain variables
To: Joel Stanley <joel@jms.id.au>
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
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 12, 2018 at 1:21 PM Joel Stanley <joel@jms.id.au> wrote:
>
> The powerpc makefile will use these in it's boot wrapper.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---


Applied to linux-kbuild.
Thanks!


>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 09278330282d..840efe6eb54c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -495,6 +495,7 @@ endif
>  ifneq ($(GCC_TOOLCHAIN),)
>  CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
> +export CLANG_FLAGS
>  CLANG_FLAGS    += -no-integrated-as
>  KBUILD_CFLAGS  += $(CLANG_FLAGS)
>  KBUILD_AFLAGS  += $(CLANG_FLAGS)
> --
> 2.19.1
>


-- 
Best Regards
Masahiro Yamada
