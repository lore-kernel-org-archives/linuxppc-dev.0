Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F42EC32789
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 02:56:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ABF620685
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 02:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nVifOrga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABF620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pHPN33NBzDrMC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 13:56:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="nVifOrga";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.82; helo=conssluserg-03.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="nVifOrga"; 
 dkim-atps=neutral
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pHLv1ykqzDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2018 13:53:58 +1100 (AEDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id wA52rIsV002984
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Nov 2018 11:53:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wA52rIsV002984
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1541386399;
 bh=7mMub48cGUd9y2ecHB+M9RPzNI5RzJ+jK2O4TfhTw2M=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=nVifOrga/iaq7YCj52vp1WJPNkDonv8proPF0F6b6eZYJYDTsR1nOoLDMlP9IlG8d
 k74Vu1dikZm2NSCWsWTSL8sjB0AWwiJTpe6jgS59IEJPw4pmYlFG86DVaGiSaLxlu+
 WQumod5WKFUilb+twBlu95UpJO6TbN1/9pf3GPyc63ElJ0idLFz2GoNpdnR3wwH/Ui
 FzUtPNrH4C3hBc6qEKsDFjjNioKQ4RlLP9WsdpUS0/EDI9G7sP8qwWWnHDhdeMVYo2
 XL7VxongXGKhG62nnYnDFjgcvZ6JITaKJGEQzPSvcBvM2npabK9j1+tP2BOND+wqud
 eaantQMyYotnw==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id p74so4263464vsc.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Nov 2018 18:53:19 -0800 (PST)
X-Gm-Message-State: AGRZ1gLj6EWn4b/vFjNY+kiZxFMz79Xxdm/SZsympORpV4Gz5pPMKio0
 NyDHPN1yuTJdnGDOu/2vxLIIeox9kdIFXHjMJvE=
X-Google-Smtp-Source: AJdET5e3ukfcttIa4hIqRgUCmYlNLBflocbnY5cM6KGo7Y9JCer3ywPS50uPO9NeLDVAulCGn0hSiXo68ll2OWYJ5jk=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr8724909vsb.155.1541386398029; 
 Sun, 04 Nov 2018 18:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20181104231133.30848-1-joel@jms.id.au>
 <20181104231133.30848-2-joel@jms.id.au>
In-Reply-To: <20181104231133.30848-2-joel@jms.id.au>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 5 Nov 2018 11:52:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNASeoiNa0Z08KCVhS_nzLEcKE9G6=d_m-dQbX1oep3UPtQ@mail.gmail.com>
Message-ID: <CAK7LNASeoiNa0Z08KCVhS_nzLEcKE9G6=d_m-dQbX1oep3UPtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Makefile: Export clang toolchain variables
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
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Joel,


On Mon, Nov 5, 2018 at 9:53 AM Joel Stanley <joel@jms.id.au> wrote:
>
> The powerpc makefile will use these in it's boot wrapper.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 9aa352b38815..a2db3c885b38 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -495,6 +495,9 @@ endif
>  ifneq ($(GCC_TOOLCHAIN),)
>  CLANG_GCC_TC   := --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
> +export CLANG_TARGET
> +export CLANG_GCC_TC
> +export CLANG_PREFIX
>  KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>  KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>  KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
> --
> 2.19.1
>


Before exporting these compiler flags,
I'd like to do a cleanup work.


Could you take a look at my patch, please?

https://patchwork.kernel.org/patch/10667369/


By using it as a prerequisite,
your patch set will be more simplified.


-- 
Best Regards
Masahiro Yamada
