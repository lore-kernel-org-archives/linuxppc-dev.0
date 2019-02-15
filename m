Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4ED5C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 07:58:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422CD207E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 07:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="r36eIZwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422CD207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4415H20M9LzDqL2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 18:58:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.90; helo=conssluserg-05.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="r36eIZwV"; 
 dkim-atps=neutral
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4415FJ0PvpzDqJC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 18:56:51 +1100 (AEDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id x1F7uObY006158
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 16:56:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x1F7uObY006158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1550217385;
 bh=+CMccOOQs2SIMZf8GEgGda1f8v4r4nxXcnL40kDZkWo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=r36eIZwVVVerHTYGeE8H+hEk+dhffubWfEDTlx9AG4RL30kTqsQTAzSh77Yzior4A
 rb6X+C8vBMNhI+YwVXTTjM9LnDfR3daR1tXWjaNmJyxsOuOMEwgjbx3rQc03c8GLxz
 yZZCqQIgSfqA8WYMLrpMBjDw4BX9lLoRV22TX4ikyjYGbQusLu59bvMGD5V59B/8Wo
 3uV/JlnVvKPwj25pwn015lWVfcZBo3cqXxUcljGmy7rPvZImAO+SSvn6svQVUDYcLq
 8E/lRD4NxqqWOXTgghHWu+Skw3KftagWt7hj8AEiV8rh1x0En6J0KRiWoXBxDfffXA
 cK/rnETWff5bw==
X-Nifty-SrcIP: [209.85.221.179]
Received: by mail-vk1-f179.google.com with SMTP id x140so2037755vke.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 23:56:24 -0800 (PST)
X-Gm-Message-State: AHQUAuYgMPQqkjEVrNS3bmFnKG2wtJthXCSIbMFE75b5YssYrQZajW8F
 UfiDrESErk8IRpIuBPOP0gedYdC32PQD9Hl0Qfs=
X-Google-Smtp-Source: AHgI3Ib2LcLTF5+1932eP4k/Ka4siIF35t+ho0EcrAqV+ljWi5cwUgFr5/PGJnMNXYpvgO5M7IKEjNDvTWma6+EqebI=
X-Received: by 2002:a1f:4406:: with SMTP id r6mr4284655vka.84.1550217383704;
 Thu, 14 Feb 2019 23:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de>
 <20190213174005.28785-6-hch@lst.de>
In-Reply-To: <20190213174005.28785-6-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 15 Feb 2019 16:55:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNARDdPabSOq6vHvxTPPWaMguJUEtok=dNrfnLEz=UtHO+w@mail.gmail.com>
Message-ID: <CAK7LNARDdPabSOq6vHvxTPPWaMguJUEtok=dNrfnLEz=UtHO+w@mail.gmail.com>
Subject: Re: [PATCH 05/11] tracing: consolidate the TRACE_IRQFLAGS_SUPPORT
 symbol
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
 nios2-dev@lists.rocketboards.org, Ley Foon Tan <lftan@altera.com>,
 linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

+CC: Ley Foon Tan <lftan@altera.com>
+CC: nios2-dev@lists.rocketboards.org


On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:

> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
> index 715e6c09b4a5..3b50689007f5 100644
> --- a/arch/nios2/Kconfig
> +++ b/arch/nios2/Kconfig
> @@ -20,6 +20,7 @@ config NIOS2
>         select OF_EARLY_FLATTREE
>         select SOC_BUS
>         select SPARSE_IRQ
> +       select TRACE_IRQFLAGS_SUPPORT


This is a behavior change of nios2.

TRACE_IRQFLAGS_SUPPORT was previously 'n',
and this commit is changing it to 'y'.




Strangely, nios2 defines TRACE_IRQFLAGS_SUPPORT twice
with different default values.

In Kconfig, the first one becomes effective.

In this case, 'def_bool n' in arch/nios2/Kconfig is used.
'def_bool y' in arch/nios2/Kconfig.debug is dead code.


I think this select should be dropped
to keep the current behavior,
but I hope the NIOS2 maintainer will give us
some comments just in case.




>         select USB_ARCH_HAS_HCD if USB_SUPPORT
>         select CPU_NO_EFFICIENT_FFS
>         select ARCH_DISCARD_MEMBLOCK
> @@ -39,9 +40,6 @@ config NO_IOPORT_MAP
>  config FPU
>         def_bool n
>
> -config TRACE_IRQFLAGS_SUPPORT
> -       def_bool n
> -
>  menu "Kernel features"
>
>  source "kernel/Kconfig.hz"
> diff --git a/arch/nios2/Kconfig.debug b/arch/nios2/Kconfig.debug
> index f1da8a7b17ff..a8bc06e96ef5 100644
> --- a/arch/nios2/Kconfig.debug
> +++ b/arch/nios2/Kconfig.debug
> @@ -1,8 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -config TRACE_IRQFLAGS_SUPPORT
> -       def_bool y
> -
>  config EARLY_PRINTK
>         bool "Activate early kernel debugging"
>         default y

--
Best Regards
Masahiro Yamada
