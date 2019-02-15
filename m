Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03511C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 07:47:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0AB1206DD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 07:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mZQivuqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AB1206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44152014tQzDqcG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 18:47:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.80; helo=conssluserg-01.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="mZQivuqn"; 
 dkim-atps=neutral
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4415083JzMzDqWS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 18:45:27 +1100 (AEDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id x1F7iuWV004438
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 16:44:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x1F7iuWV004438
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1550216696;
 bh=Y4dNF/RxX3MyGbFoqnUshXrtG1OoIFFX3Cshg6WbBGo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=mZQivuqndoWZPO3FGD/2VcBZ4SrcUolGHDxZzAyo5AjFFiyO12/MUnDXYMk4cg6vq
 Pwmta99F/Ixwdtv6vdYkwgbqMJP2ATMw5Z9IHoOP0nxxX+h/8kF0qpf5FjA72O4mdo
 0XQeVNxvdHPij+6w8tdGqdOevSoUk+C6f2Yop1YZHlXGKFUVAiIrlErt0+ACAamODJ
 5qosd420OgFyLQNXgrZFN0H0zFrCIEoQtd/l3smZDyyA56+kwEZIOMRv4SQhgRQ49f
 RBUw8aSzati67TYDpU5zPA6rpl8VxjjYjcnf/dieTBxKl15Lsrxgi8gHhSdpBzxII+
 lbGUKIYoKMd3A==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id j8so2911002uae.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 23:44:56 -0800 (PST)
X-Gm-Message-State: AHQUAuZ7EsdSigneGzHRjJ+9EvIgSExeQe4bOWzxP43aQnHHvG9xKgLB
 Zhv4LLVrvmxGJiUGCzApyC/BNcj6MErfOG0kJBk=
X-Google-Smtp-Source: AHgI3Ia57sZJUh0aDDMa4VhfpTpdjrTfmUBZjQBSj2E7ZBi3yv9XX3+lVFomDn/M0BocUuSx0lJsybIQCmRYC5ggw7A=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr3963841uaj.42.1550216695582;
 Thu, 14 Feb 2019 23:44:55 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de>
 <20190213174005.28785-12-hch@lst.de>
In-Reply-To: <20190213174005.28785-12-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 15 Feb 2019 16:44:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQRv4ksk_bryE_PsHtiojEQos2BY8vQQ1sDcKkdypYH8A@mail.gmail.com>
Message-ID: <CAK7LNAQRv4ksk_bryE_PsHtiojEQos2BY8vQQ1sDcKkdypYH8A@mail.gmail.com>
Subject: Re: [PATCH 11/11] s390: don't redefined the HAS_IOMEM symbol
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
> Rely on the common defintion instead.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/s390/Kconfig | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 9a25e19364f5..0f62e33ffcb2 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -159,6 +159,7 @@ config S390
>         select MODULES_USE_ELF_RELA
>         select NEED_DMA_MAP_STATE       if PCI
>         select NEED_SG_DMA_LENGTH       if PCI
> +       select NO_IOMEM                 if !PCI


This does not work because NO_IOMEM is defined
in arch/um/Kconfig.


If you want to do this,
you must move NO_IOMEM  to lib/Kconfig.



>         select OLD_SIGACTION
>         select OLD_SIGSUSPEND3
>         select PCI_DOMAINS              if PCI
> @@ -708,9 +709,6 @@ config PCI_NR_FUNCTIONS
>
>  endif  # PCI
>
> -config HAS_IOMEM
> -       def_bool PCI
> -
>  config CHSC_SCH
>         def_tristate m
>         prompt "Support for CHSC subchannels"
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
