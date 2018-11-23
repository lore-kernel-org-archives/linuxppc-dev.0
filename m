Return-Path: <SRS0=n2Bs=OC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F41C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 03:58:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF6520664
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 03:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MYhJUu0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF6520664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431Mx94RR0zDqSx
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 14:58:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="MYhJUu0L";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.82; helo=conssluserg-03.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="MYhJUu0L"; 
 dkim-atps=neutral
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431L9j2qkWzDqSJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 13:39:20 +1100 (AEDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id wAN2cu2E027092
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 11:38:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wAN2cu2E027092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1542940737;
 bh=RwCL9Ri+CN8GV/mcouXy7Bn2m5DMHOHs2NKrn7tRBFs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=MYhJUu0L0a+CSKTHu66tCSIlEPx+cikVX1ZeeFJJJm+V/LS62+QKlo0YuU3BlAbbw
 AsWTdHqbqdveA+kVvHdFVvyOuwFaH8+owiGVG4pVsSpFbI97zO2nPbIrDm9G8w+JJA
 HQJBZ6OaYZqSTOmFr3ri2G48XmixRLG+GICPONonqugmiLwoeF6GXdpFb+zWI52b3n
 +Y/q6MvJjeUsBEWsY/sIEaEPQ+fX+mycQqY7B6OtENsc5C3eCOVeov8yPQZYqRumiY
 G/yEfSi/YD5kR1o+R1Vy4v9aP/E9epQ21KXaYMb/2lBHJJByu1kQlaB3xOQU5okA1+
 XTsn9lvMF8w/g==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id x1so6359966vsc.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 18:38:56 -0800 (PST)
X-Gm-Message-State: AGRZ1gIz0UfUorAUDpAO3gKLBAAmWuiRnv/WuQNvf3j+U54QAbximdmR
 NGr3Lu0LGNBLY03li+TNUAp7DdBP47w5Z9XXByo=
X-Google-Smtp-Source: AJdET5f4wWYkg8NhA/njL96dQLq3mhUgERT/Zv/ehLhsyoNXgp6lt+kzLsJHDfpawOK7kvxkQQ7+Im2odf8doeLp64Y=
X-Received: by 2002:a67:a858:: with SMTP id r85mr5688337vse.215.1542940735781; 
 Thu, 22 Nov 2018 18:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de>
 <20181115190538.17016-2-hch@lst.de>
In-Reply-To: <20181115190538.17016-2-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Nov 2018 11:38:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT+gHJcxhb=ufzzHHcfWqNOAJXaOAp2aJP9dGYxBkqQFw@mail.gmail.com>
Message-ID: <CAK7LNAT+gHJcxhb=ufzzHHcfWqNOAJXaOAp2aJP9dGYxBkqQFw@mail.gmail.com>
Subject: Re: [PATCH 1/9] arm: remove EISA kconfig option
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
 Linux-MIPS <linux-mips@linux-mips.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Alex Bounine <alex.bou9@gmail.com>, linux-alpha@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 16, 2018 at 4:06 AM Christoph Hellwig <hch@lst.de> wrote:
>
> No arm config enables EISA, and arm does not include drivers/eisa/Kconfig
> which provides support for things like PCI to EISA bridges, so it is most
> likely dead.

As I said before, this is absolutely dead.

Only the difference between arch/powerpc/Kconfig and arch/arm/Kconfig
is the presence of ---help--- property.


I squashed this to "eisa: consolidate EISA ..."


> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/Kconfig | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 91be74d8df65..f24a7435d19a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -163,21 +163,6 @@ config HAVE_PROC_CPU
>  config NO_IOPORT_MAP
>         bool
>
> -config EISA
> -       bool
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
>
> --
> 2.19.1
>


--
Best Regards
Masahiro Yamada
