Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAE9ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 13:02:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E236620644
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 13:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lpz/fs9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E236620644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42c5fh3hvRzF3c6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Oct 2018 00:02:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="lpz/fs9J";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.91; helo=conssluserg-06.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="lpz/fs9J"; 
 dkim-atps=neutral
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42c5YS3BWVzDrP2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 23:57:47 +1100 (AEDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id w9JCvBMo026704
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 21:57:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w9JCvBMo026704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1539953832;
 bh=Gq+3Ld2a9I8XpUsYwDmPMl4YFsFY0o/2/Az/R14YyMk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=lpz/fs9Jy4/Y7041ZzGJbETYaWGtKcQJGM+GaCZpEwCnYYFcmS+6tuqmsFrpurFC6
 OL0ZftqDx2mi6cmGYFV78uuS+cY6S9fZRk6D0IzPBagyOidF8RCbPwdQe1pWoAa3TM
 C/PSWoSn0bf1ZsyUotvwbkEmisQtEn+2qJmcsIMCjcKEWUF7JTqk8CROWgjKHFpsMv
 ZVa2g1SpxD3YXzywmn/jpIsL64GKJvsHLfXk2Y6nScPp9tVTGX9os/A1lVokiScl53
 6XycF6P2344x9N5OqQloXeVgb4D0EvjXtdaeP23slNdJWH7m12xfZ2Tu6VomNMzJzf
 +1szLlWpaNb+g==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id o17so4655286uad.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 05:57:11 -0700 (PDT)
X-Gm-Message-State: ABuFfohCyPOc2HczGYwPTgtPmvbDuWtMQkJcNiUyNP7Mk8JrSM/wz2kc
 mG7BgNF6Li2D2TF+hCdEtqbOro5534re8tf6Buo=
X-Google-Smtp-Source: ACcGV61X1bzrIsFQWEoWVcGsHYTpyfbXhPp5BlcP63vGcyIM6DnI7rbGVuMZiHaMY+tzDAeaKL5s36q2zXrOfzloNDc=
X-Received: by 2002:ab0:115b:: with SMTP id g27mr15609617uac.89.1539953830707; 
 Fri, 19 Oct 2018 05:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181019120952.32763-1-hch@lst.de>
 <20181019120952.32763-3-hch@lst.de>
In-Reply-To: <20181019120952.32763-3-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 19 Oct 2018 21:56:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNATc54ZMaKLzabW=NqCQ+WSr-3C7PNAGL6OmOnQf_kgOyQ@mail.gmail.com>
Message-ID: <CAK7LNATc54ZMaKLzabW=NqCQ+WSr-3C7PNAGL6OmOnQf_kgOyQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] arm: remove EISA kconfig option
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
 Russell King <linux@armlinux.org.uk>, Alex Bounine <alex.bou9@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 19, 2018 at 9:10 PM Christoph Hellwig <hch@lst.de> wrote:
>
> No arm config enables EISA, and arm does not include drivers/eisa/Kconfig
> which provides support for things like PCI to EISA bridges, so it is most
> likely dead.
>
> If this is wrong we will be able to resurrect it easily by selecting
> HAVE_EISA for the right arm configs after this series.

What is your concern?

This absolutely looks dead to me.


> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/Kconfig | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e8cd55a5b04c..e33735ce1c14 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -165,21 +165,6 @@ config HAVE_PROC_CPU
>  config NO_IOPORT_MAP
>         bool
>
> -config EISA
> -       bool

There is no prompt for this symbol.
Hence, there is no way for a user to enable this directly.

'select EISA' is the only way to enable it.

git grep 'select EISA'
gave no hit.

So, we can say it is dead.





> -       ---help---
> -         The Extended Industry Standard Architecture (EISA) bus was
> -         developed as an open alternative to the IBM MicroChannel bus.
> -
> -         The EISA bus provided some of the features of the IBM MicroChannel
> -         bus while maintaining backward compatibility with cards made for
> -         the older ISA bus.  The EISA bus saw limited use between 1988 and
> -         1995 when it was made obsolete by the PCI bus.
> -
> -         Say Y here if you are building a kernel for an EISA-based machine.
> -
> -         Otherwise, say N.
> -
>  config SBUS
>         bool



I guess the situation is the same as powerpc.

The difference between arm and powerpc is the presence of help.

You fold the powerpc change in 9/9.


-- 
Best Regards
Masahiro Yamada
