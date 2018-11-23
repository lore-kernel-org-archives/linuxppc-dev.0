Return-Path: <SRS0=n2Bs=OC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FB5C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 02:37:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10BC20663
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 02:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uNJywPJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10BC20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431L7d1Vr1zDqSS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 13:37:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="uNJywPJ2";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.91; helo=conssluserg-06.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="uNJywPJ2"; 
 dkim-atps=neutral
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431L3Q5TCnzDqRx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 13:33:53 +1100 (AEDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com
 [209.85.221.178]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id wAN2XS6Q027038
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 11:33:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wAN2XS6Q027038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1542940409;
 bh=v6HVFbHmz+zgQDnWdeO9p7xqte9YKegL49VxXFqdC5k=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=uNJywPJ2yLV5U9yma0ObudH5v0rbcZwm7HLKFX1Wu8l+UqdP5PlA95KZmD2sJAVwv
 MR7phm3FXNONKzfrkZ2tfvDWNw/f8I9DLHub+88Y+bqo80tNQy1iJiix7nyLJVOALw
 nd8m2XNoSW/DK0CMW3qp/VictsOdTSO7VNOuAFYL8n+ynWHkGlVn0+UdARtrlOF0Vk
 3w5wQHcWOy3PPIw4Rfj392QWInlf0iCzMsDnAD+It8xUA378QniVmihvLE3wDn9sxx
 q8qjzNIJHNuKQeRSZYNS2vfR7hWRAIF+GkDSx6KvU2HUtgA1hL9B4eJbMFg65ERwAw
 pCAoFzZcXKe4Q==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id t132so1608817vkc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 18:33:29 -0800 (PST)
X-Gm-Message-State: AA+aEWYfwkcMRaQhOgSGECCoXLy5wR5G7XwSOpCJUKQ/oYmcPQ8SBazj
 FuY6vB/g6RmVLVPeTtOP8Wn4bNRhWltOQoQySp0=
X-Google-Smtp-Source: AFSGD/WOaShAZWgbrF6drzEtDB7BJ8RrCSWMcw9Fa+4aDXL3U8vMURobcUXawjUcWKuzRTy8b7seybF2eyBenVK7VOk=
X-Received: by 2002:a1f:6bc8:: with SMTP id k69mr5479162vki.84.1542940408247; 
 Thu, 22 Nov 2018 18:33:28 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de>
In-Reply-To: <20181115190538.17016-1-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Nov 2018 11:32:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNARL8yZexzXiEaT77U_rdwhr5uENXbSaSTGHU33HbSmW6g@mail.gmail.com>
Message-ID: <CAK7LNARL8yZexzXiEaT77U_rdwhr5uENXbSaSTGHU33HbSmW6g@mail.gmail.com>
Subject: Re: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/ v4
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

Hi Christoph,


On Fri, Nov 16, 2018 at 4:08 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> currently every architecture that wants to provide on of the common
> periphal busses needs to add some boilerplate code and include the
> right Kconfig files.   This series instead just selects the presence
> (when needed) and then handles everything in the bus-specific
> Kconfig file under drivers/.


Thanks for this work!


I applied this series, and it is available at

git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
kconfig2


I made local fixups in some parts,
where I left comments in individual patches.





> Changes since v3:
>  - drop the patches already merged
>  - fix a typo in the PCI help text
>  - split the always enable PCI on alpha change into a separate patch
>  - remove the mips HT_PCI symbol
>  - add a new FORCE_PCI symbol to easily allow selecting PCI support
>  - new patch to consolidate PCI_DOMAINS
>  - new patch to consolidate PCI_SYSCALL
>
> Changes since v2:
>  - depend on HAVE_PCI for PCIe endpoint code
>  - fix some commit message typos
>  - remove CONFIG_PCI from xtensa iss defconfig
>  - drop EISA support from arm
>  - clean up EISA selection for alpha
>
> Changes since v1:
>  - rename all HAS_* Kconfig symbols to HAVE_*
>  - drop the CONFIG_PCI_QSPAN option entirely
>  - drop duplicate select from powerpc
>  - restore missing selection of PCI_MSI for riscv
>  - update x86 and riscv defconfigs to include PCI
>  - actually inclue drivers/eisa/Kconfig
>  - adjust some captilizations



--
Best Regards
Masahiro Yamada
