Return-Path: <SRS0=n2Bs=OC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D203C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 04:03:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C326220664
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 04:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PJhm3VBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C326220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431N3C5pP3zDq5j
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 15:03:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="PJhm3VBy";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.81; helo=conssluserg-02.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="PJhm3VBy"; 
 dkim-atps=neutral
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431LF270bxzDqF1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 13:42:14 +1100 (AEDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id wAN2fusQ028404
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 11:41:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wAN2fusQ028404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1542940916;
 bh=R157I6Dkx5Z2mskSmJELm97OIhgSrKrMbLwBuT6BgNs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=PJhm3VByg1Ah0Bi7mvZ6aiPwxFzUDNfv0jbVmnMBZzEHnuJxJtp/QAYLnvWDXSu2M
 QuP1ZQKL7ToO4PzAeFsIxIz+yFCibIKlF4VnlRnJYfeYVoIVG+S05oouBnn0ONb5rG
 Kfee/avcqdkY3E330NbYuuw5FbkoD2D6upNkIYekasYof8ohbCyFBTO/Yhpnnrsuzn
 lsXgPqoDWpBXpnjs/Qb84UkX7X5MDUplCnFYzkvSS1UohcQD2GEdiE58a0dtSmYiGA
 GxUD7lrTRdVGomPC4dVJBYRczt+OUOR4PGbT25CU1PeSW1QcEwCZmCWuVRYVwOZMZl
 GuTpYQf19Knxg==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id v24so3648632uap.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 18:41:56 -0800 (PST)
X-Gm-Message-State: AA+aEWZDqWhcRHKGpJa+bMP5blSRvKobP2a92UKnmGgUeLsWY4MtY9i5
 xRAfWW5YFWl+QPQegjzZnSHoAAL4yj5iA7ayDf4=
X-Google-Smtp-Source: AFSGD/U0y52k6OkO8mAFNr3ssfm0dIj5t/ic8hflM6hOWd/Ort5n5jrqwIFsps2z1+GeSvz9QtDEt9YhLpwhox0mNvE=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr5501205uaj.42.1542940915649;
 Thu, 22 Nov 2018 18:41:55 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de>
 <20181115190538.17016-6-hch@lst.de>
In-Reply-To: <20181115190538.17016-6-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Nov 2018 11:41:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASYobpeAMqenZXycNieWErRFkNHz6xQUzEruJ0-nNwfdA@mail.gmail.com>
Message-ID: <CAK7LNASYobpeAMqenZXycNieWErRFkNHz6xQUzEruJ0-nNwfdA@mail.gmail.com>
Subject: Re: [PATCH 5/9] PCI: consolidate the PCI_DOMAINS and
 PCI_DOMAINS_GENERIC config options
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

On Fri, Nov 16, 2018 at 4:07 AM Christoph Hellwig <hch@lst.de> wrote:

> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index a8128a1946a2..95812fc4958c 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -21,6 +21,15 @@ menuconfig PCI
>           support for PCI-X and the foundations for PCI Express support.
>           Say 'Y' here unless you know what you are doing.
>
> +config PCI_DOMAINS
> +       depends on PCI
> +       bool
> +
> +config PCI_DOMAINS_GENERIC
> +       depends on PCI
> +       select PCI_DOMAINS
> +       bool
> +
>  source "drivers/pci/pcie/Kconfig"
>
>  config PCI_MSI


I reordered this so it 'bool' comes first.

config PCI_DOMAINS
       bool
       depends on PCI


config PCI_DOMAINS_GENERIC
       bool
       depends on PCI
       select PCI_DOMAINS


Of course, it is just a matter of slight taste.
I just wanted the code to look consistent.




-- 
Best Regards
Masahiro Yamada
