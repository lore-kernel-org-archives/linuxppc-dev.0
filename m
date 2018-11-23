Return-Path: <SRS0=n2Bs=OC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775ADC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 04:01:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBC520664
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 04:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UaV28s2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBC520664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431Mzy6NHPzDqSD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 15:01:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="UaV28s2h";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.82; helo=conssluserg-03.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="UaV28s2h"; 
 dkim-atps=neutral
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431LBG33t4zDqSV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 13:39:50 +1100 (AEDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id wAN2dWJ9027428
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 11:39:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wAN2dWJ9027428
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1542940772;
 bh=VWjvovRoFgpdnSblsfRHe1lJMd1lOaF4s9MvxqgDVX4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=UaV28s2h8BQzA1pDTWxCUh5ZYiBRZhcc8sm1zE5Lk/oLXXLwlYQaHyDttdv5y8cJg
 +dEMRnx5XBXXqe/XTE5a5L8EHo6I96VXl4u3yWgclDEzQzJndT1fP8lLeV08kUYOMo
 etXslrjgdIh4bSO/w6gF4eTq4F02L9Ua75Pgw1VU/638dxvffSy9QETgHsKiIbvbI/
 2VCO0zxEncWyAXR7vKU/xWt3P5NMK8/wg2kFCxx3i0FU5+q3GMTplO6M+PdUPk7vWR
 niNTDrcO24KqlH66fO9fZ9V12J834r/SY6MG1HMl2R8ln5L732B5GBoblQxsIGv4Id
 afmia0/k+PI3A==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id y27so6394137vsi.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 18:39:32 -0800 (PST)
X-Gm-Message-State: AGRZ1gKrOhCfrVAlQmYwli82ziJ0rprkMDBQqJwYtIDD3h2k8cog58BD
 yObxtQNNka6CUEPvRNkm2icZM6pnb0GvRBpCj5M=
X-Google-Smtp-Source: AJdET5e1srPuacSBSRnMpISFk7oo2hmgsX3nPv3251fAuBn7xd1X1soEXtNFB6//3SgosqKKtXuMKOS97o9NQ43BUOQ=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr5691305vsm.181.1542940771602; 
 Thu, 22 Nov 2018 18:39:31 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de>
 <20181115190538.17016-3-hch@lst.de>
In-Reply-To: <20181115190538.17016-3-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Nov 2018 11:38:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQrOHhd-=BHtc1PQ4SCo=fUPaqOQsbxzv+VF8Zu4bJohA@mail.gmail.com>
Message-ID: <CAK7LNAQrOHhd-=BHtc1PQ4SCo=fUPaqOQsbxzv+VF8Zu4bJohA@mail.gmail.com>
Subject: Re: [PATCH 2/9] alpha: force PCI on for non-jensen configs
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
> Without PCI support the kernel won't even compile, so force it on.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---


I do not understand this patch
because alpha already enables PCI forcibly.

'No prompt' + 'default y' means always on.

config PCI
        bool
        depends on !ALPHA_JENSEN
        select GENERIC_PCI_IOMAP
        default y


I squashed this patch to "PCI: consolidate PCI config entry ..."
because you will replace it to FORCE_PCI anyway.







>  arch/alpha/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 5b4f88363453..65f6d0bf69d4 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -6,6 +6,7 @@ config ALPHA
>         select ARCH_MIGHT_HAVE_PC_SERIO
>         select ARCH_NO_PREEMPT
>         select ARCH_USE_CMPXCHG_LOCKREF
> +       select PCI if !ALPHA_JENSEN
>         select HAVE_AOUT
>         select HAVE_IDE
>         select HAVE_OPROFILE
> --
> 2.19.1
>


--
Best Regards
Masahiro Yamada
