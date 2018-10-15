Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8AEC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 06:46:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44C02086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 06:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0+qzGY6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44C02086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YTVq6j8NzF3FF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 17:46:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="0+qzGY6h";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.83; helo=conssluserg-04.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="0+qzGY6h"; 
 dkim-atps=neutral
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YTKx5Ym1zDqZ1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 17:38:45 +1100 (AEDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
 [209.85.222.42]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id w9F6cEGr009471
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 15:38:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w9F6cEGr009471
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1539585495;
 bh=431UDDCt5Nrpvp4Xvgv5e4O/hkJL6PkGKYJoLHYjNgM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=0+qzGY6hIxx91W4W0wzeYuIEW+1c2nDa8JZmFIAqdY8IlGhLJrPoE8EHdm/4LVZ+w
 ra7AhsQZw+n+wtOD6yodA1m0jxqcG3g28whGFs4Gdjg42T6fsmMmQWMbt0Lc7RuIQ3
 eqr6RrmOPPtZH8HSG8SYKMyv/GgP3kaRVlFE+tzCzBomefXLrpU4YeGGn/5ku5qnes
 J5s3OPh6imZkNHFJaXabpQ6CYA1JCooA8MNzeX6+vCLTz5pHjZyQfWgw2PqH6sjYRV
 Itn6ZydzKKUk8vJ5rdn6TBR9VvxlL058hLSJz7iAIA/GvjIczo4Ck4aLbk2nvAQbni
 l/fBybDbp8nvw==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id y5so1620475uap.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 23:38:14 -0700 (PDT)
X-Gm-Message-State: ABuFfojBj3iMDyPG3kiVAGiq+tgbLnLPGzUKr12Hibajhi93ATPHetT0
 TsCYhi31CYW9Vxf13jFlRtEUAGrdIx0WgDDAxKM=
X-Google-Smtp-Source: ACcGV62svXsdBtzLs8uABQOtUzKDz7B4f1pAyar1hAZNMZHRjuPAGdZVj6HDpBWKhMCVhlq/+I/DSudKoxaUcLIw44Y=
X-Received: by 2002:ab0:115b:: with SMTP id g27mr6860514uac.89.1539585493703; 
 Sun, 14 Oct 2018 23:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151016.31674-1-hch@lst.de>
 <20181013151016.31674-8-hch@lst.de>
In-Reply-To: <20181013151016.31674-8-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 15 Oct 2018 15:37:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT8QhVhSiv1bNnp_HbFdLGd_y-YUQqSevZ5eSp4=ZRqhQ@mail.gmail.com>
Message-ID: <CAK7LNAT8QhVhSiv1bNnp_HbFdLGd_y-YUQqSevZ5eSp4=ZRqhQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] eisa: consolidate EISA Kconfig entry in drivers/eisa
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
> Let architectures opt into EISA support by selecting HAS_EISA and
> handle everything else in drivers/eisa.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---


How about HAVE_EISA ?


You forgot to add
source "drivers/eisa/Kconfig" to drivers/Kconfig


You forgot to delete the one
from arch/alpha/Kconfig


>  arch/alpha/Kconfig     |  8 +++-----
>  arch/arm/Kconfig       | 16 +---------------
>  arch/mips/Kconfig      | 31 +++++--------------------------
>  arch/powerpc/Kconfig   |  3 ---
>  arch/x86/Kconfig       | 19 +------------------
>  drivers/eisa/Kconfig   | 21 ++++++++++++++++++++-
>  drivers/parisc/Kconfig | 11 +----------
>  7 files changed, 31 insertions(+), 78 deletions(-)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 73a7558c71bd..6a9be9cb74e6 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -6,6 +6,9 @@ config ALPHA
>         select ARCH_MIGHT_HAVE_PC_SERIO
>         select ARCH_NO_PREEMPT
>         select ARCH_USE_CMPXCHG_LOCKREF
> +       select HAS_EISA if ALPHA_GENERIC || ALPHA_JENSEN || ALPHA_ALCOR || \
> +                               ALPHA_MIKASA || ALPHA_SABLE || ALPHA_LYNX || \
> +                               ALPHA_NORITAKE || ALPHA_RAWHIDE
>         select HAS_PCI if !ALPHA_JENSEN
>         select PCI if !ALPHA_JENSEN
>         select HAVE_AOUT
> @@ -518,11 +521,6 @@ config ALPHA_SRM
>
>           If unsure, say N.
>
> -config EISA
> -       bool
> -       depends on ALPHA_GENERIC || ALPHA_JENSEN || ALPHA_ALCOR || ALPHA_MIKASA || ALPHA_SABLE || ALPHA_LYNX || ALPHA_NORITAKE || ALPHA_RAWHIDE
> -       default y
> -


Better to add CONFIG_EISA=y to arch/alpha/defconfig
to not flip the default?



--
Best Regards
Masahiro Yamada
