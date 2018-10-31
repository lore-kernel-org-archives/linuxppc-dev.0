Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39202ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 15:31:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9AD520664
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 15:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="O/k2mZY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9AD520664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lXNc6pKwzF3Jt
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 02:30:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="O/k2mZY4";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.82; helo=conssluserg-03.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="O/k2mZY4"; 
 dkim-atps=neutral
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lXKl5vhdzDr87
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 02:28:27 +1100 (AEDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id w9VFS7R6029563
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Nov 2018 00:28:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w9VFS7R6029563
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1540999688;
 bh=6/0JrO5Fsi7fcZEs3g6nojQbiitMFQ8VGesiOyT1KNE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=O/k2mZY484Z5v22jO5eHcNKYZgJcRAbXaOTJqm48DZz/DGAMOdfJ9jewOJsDJFmqK
 EaR8Q51Naq1mxyyh7R4q/SCW8C2Y6GzYGwfn9zjhstAuQql+4F3Kpd+9HCGTba/UN1
 gbo2LbgiF9ttTLmDKYVJNyQyULe8ZtyEAagXRHreLjQtynZKgOPf8H+Q9A00yfzcV0
 38FyP+4eNAH22S5nT9JQrfwOf+wvF9BWlL/Htk54NTHr/t2SI8lUEbSkm41xyL1Mv6
 eDxHc0cSEZkWF+KzVZy3Q7c0PufZA8S9KR74XkEUFlvdAx/8L/Lo2Z4fWH8G+gS0H2
 adXJB1lz9JI0A==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id d62so8523207vsd.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 08:28:08 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJGQTsMuANCgq0XQ/tZuypyFU4uW4zg3sP9FrhUyl72je3z6bOk
 zc3On13sjgTn7PKRiWMnB32KxQDUMARyqH2xg3o=
X-Google-Smtp-Source: AJdET5eLO5x7laBy+4Wwo3163CPWmgrOSV8/YNW9hS+mzsS8i41q/U+PHCF2htix5TYv7HMghOtrm80EBg4e/8Bdn0c=
X-Received: by 2002:a67:6101:: with SMTP id v1mr1536207vsb.54.1540999687154;
 Wed, 31 Oct 2018 08:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181019120952.32763-1-hch@lst.de>
 <20181019120952.32763-4-hch@lst.de>
In-Reply-To: <20181019120952.32763-4-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 1 Nov 2018 00:27:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATPnn=8B2jisxfwOg5KWr1YSkBJEtiquzK9GQ8s-D2Q9g@mail.gmail.com>
Message-ID: <CAK7LNATPnn=8B2jisxfwOg5KWr1YSkBJEtiquzK9GQ8s-D2Q9g@mail.gmail.com>
Subject: Re: [PATCH 3/9] powerpc: remove CONFIG_PCI_QSPAN
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Alex Bounine <alex.bou9@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 19, 2018 at 9:10 PM Christoph Hellwig <hch@lst.de> wrote:
>
> This option isn't actually used anywhere.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---


Applied to linux-kbuild.




>  arch/powerpc/Kconfig | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a80669209155..e8c8970248bc 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -955,7 +955,6 @@ config PCI
>         bool "PCI support" if PPC_PCI_CHOICE
>         default y if !40x && !CPM2 && !PPC_8xx && !PPC_83xx \
>                 && !PPC_85xx && !PPC_86xx && !GAMECUBE_COMMON
> -       default PCI_QSPAN if PPC_8xx
>         select GENERIC_PCI_IOMAP
>         help
>           Find out whether your system includes a PCI bus. PCI is the name of
> @@ -969,14 +968,6 @@ config PCI_DOMAINS
>  config PCI_SYSCALL
>         def_bool PCI
>
> -config PCI_QSPAN
> -       bool "QSpan PCI"
> -       depends on PPC_8xx
> -       select PPC_I8259
> -       help
> -         Say Y here if you have a system based on a Motorola 8xx-series
> -         embedded processor with a QSPAN PCI interface, otherwise say N.
> -
>  config PCI_8260
>         bool
>         depends on PCI && 8260
> --
> 2.19.1
>


-- 
Best Regards
Masahiro Yamada
