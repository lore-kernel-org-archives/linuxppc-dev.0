Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9ECC7112A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 06:39:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7EE2086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 06:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Kmy9VPmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7EE2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YTLb6xtwzF39J
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 17:39:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="Kmy9VPmV";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.91; helo=conssluserg-06.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="Kmy9VPmV"; 
 dkim-atps=neutral
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YTHk4jyHzF31R
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 17:36:49 +1100 (AEDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id w9F6aIGt031066
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 15:36:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w9F6aIGt031066
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1539585378;
 bh=WTSQTIo6lZvTTDeUHanOaS24TqjvzaMlov8TsHwIzBs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Kmy9VPmVmJBfJpGD0ojccK03bg6VxL453hwiPT+weWU17/NLhajrsgDxLUDwYFAbI
 QvwUrLYRRYfhuDhJch1PIZvybeDQTrIZufG/Lr+rHFrC+aYfmNKCNSounTDm0mQf/1
 uTyq7PJ8CPGRGRpVVv8izVqMBftbMdxzKvYbDRQxmjJ9ntgwaNx/0vXkzCdKaO6ttB
 +wS/cHyZX+0so7Pnmu87x7fNSXyrUXpptAtoiXm9AeWn652HnncJJ5HU7qjHwSR1F2
 4XNuvZQBOIC784g8FcOvlwhcsybV0nh74xvVhlgaUQunvejFUG4U5HO1MjxIYClUw2
 L+m1SqiWtZnVw==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id i10so15579313vsm.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 23:36:18 -0700 (PDT)
X-Gm-Message-State: ABuFfogJX9fVnuJpJOety62DkhRqtFuyey6h0HPdCLeQiFFzwPXt+dMz
 pIGOzNUISzf0sYC1XfGtkOT1l4+4yp+VY4TEcHI=
X-Google-Smtp-Source: ACcGV61bTrA4Ownqel0P+8B+UG8xFSuByfdf/oRyq6iCpmZPeHKuZIcjxmqqkrLsL+9ptlTNIYcxYD0BF+5qpcMN5yc=
X-Received: by 2002:a67:3793:: with SMTP id j19mr6061000vsi.215.1539585377442; 
 Sun, 14 Oct 2018 23:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151016.31674-1-hch@lst.de>
 <20181013151016.31674-3-hch@lst.de>
In-Reply-To: <20181013151016.31674-3-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 15 Oct 2018 15:35:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxZcBNadLJhfrmxJGj-XJFVaya3Z1eexZp20vRPwrN7A@mail.gmail.com>
Message-ID: <CAK7LNAQxZcBNadLJhfrmxJGj-XJFVaya3Z1eexZp20vRPwrN7A@mail.gmail.com>
Subject: Re: [PATCH 2/8] powerpc: simplify CONFIG_PCI_QSPAN Kconfig magic
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
 Dominik Brodowski <linux@dominikbrodowski.net>, alex.bou9@gmail.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Oct 14, 2018 at 12:11 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The way how CONFIG_PCI_QSPAN selects the CONFIG_PCI default is highly
> unusual and gets in the way of moving CONFIG_PCI into
> drivers/pci/Kconfig.  Simplify it by just having it depend on
> CONFIG_PCI.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a80669209155..6fa6f92edb7f 100644
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
> @@ -971,7 +970,7 @@ config PCI_SYSCALL
>
>  config PCI_QSPAN
>         bool "QSpan PCI"
> -       depends on PPC_8xx
> +       depends on PPC_8xx && PCI
>         select PPC_I8259
>         help
>           Say Y here if you have a system based on a Motorola 8xx-series
> --
> 2.19.1
>



'git grep' did not get any other hit.

masahiro@pug:~/ref/linux$ git grep PCI_QSPAN
arch/powerpc/Kconfig:   default PCI_QSPAN if PPC_8xx
arch/powerpc/Kconfig:config PCI_QSPAN

With your patch, PCI_QSPAN will become
a dead config option.

How about removing it entirely?



--
Best Regards
Masahiro Yamada
