Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E848C10F0F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 09:43:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC98521A80
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 09:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZEMultMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC98521A80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4417Qb0Qm5zDqgS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 20:35:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.80; helo=conssluserg-01.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="ZEMultMu"; 
 dkim-atps=neutral
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4417NC3yY4zDqfZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 20:32:58 +1100 (AEDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id x1F9WiNa021102
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 18:32:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x1F9WiNa021102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1550223165;
 bh=HfSfrFBcRoJyhIErWqGfFXClcePQGFMvuVUjWFMMlwc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ZEMultMubw6PTbXnOiQ4j3Am7weTwSeLXQS5wA15OdLXom6Z7hqHzkekuo+I2blcO
 vAR+pDmWobHMj4YUEW96gHKUa+tKtSTGAu170G6lj+erX2FPQRTcRO2swsBMHbJD+j
 zsiA9oDXMV/yqZsTbGuAFg0JgYMh42veLkJsQeO38UQ2pHT91bqAtmTKn0WfrC0De8
 uKPfhF/si37hpmFxGXDIJ08rmHgx4ntU77RGTUARpl/zVj5ubm6rTCbKKoCfPqjwZh
 fjjQWhOVbHdHKVy4G7GRG5DiO6qO87ZFj59ejtNXraidnHh1tZMa7Zz9wbFqKM7sDZ
 p4yvvsn7gUjvQ==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id v26so3010181uap.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 01:32:44 -0800 (PST)
X-Gm-Message-State: AHQUAuZ38CyDJPXs2nD+mjDXFqnQVH4iE8EeV+AX7ztFfeynVrxGKtb3
 PG7eim1NHoFvyI6lJ4sSAePOveUFnhKYcfjZOqs=
X-Google-Smtp-Source: AHgI3Iad6W2GsRyuHvKDtKafwtV+B2R19XzTGZgV2/dVRurEYChtPO2shkuyCewm1zFfnDvGU1M6QFYs6DCodW81UKs=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr4355489uap.6.1550223163654;
 Fri, 15 Feb 2019 01:32:43 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de>
 <20190213174005.28785-3-hch@lst.de>
In-Reply-To: <20190213174005.28785-3-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 15 Feb 2019 18:32:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQFSQN=42X1dqt5io+gOG8mUpwXhLmspqryvmzakUCSWw@mail.gmail.com>
Message-ID: <CAK7LNAQFSQN=42X1dqt5io+gOG8mUpwXhLmspqryvmzakUCSWw@mail.gmail.com>
Subject: Re: [PATCH 02/11] riscv: remove the HAVE_KPROBES option
To: Christoph Hellwig <hch@lst.de>
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
Cc: linux-xtensa@linux-xtensa.org,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
>
> HAVE_KPROBES is defined genericly in arch/Kconfig and architectures
> should just select it if supported.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Do you want this patch picked up by me?

Or, by Palmer?



> ---
>  arch/riscv/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 515fc3cc9687..b60f4e3e36f4 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -94,9 +94,6 @@ config PGTABLE_LEVELS
>         default 3 if 64BIT
>         default 2
>
> -config HAVE_KPROBES
> -       def_bool n
> -
>  menu "Platform type"
>
>  choice
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Best Regards
Masahiro Yamada
