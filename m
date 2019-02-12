Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB95C282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 20:42:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C915F222BE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 20:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfKA6/6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C915F222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zZN06CZKzDqL7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:42:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="QfKA6/6/"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zZKy2QH1zDqNv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 07:40:37 +1100 (AEDT)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DAFF8222BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 20:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550004036;
 bh=vjjmB3q5kxynqTfBl4fMXnJzLtFOe/CWMrbnP/HvubI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=QfKA6/6/PzAH/1DTX5KyhQZjfr82FQxTeLuAkVGfvNPh0B5ZeDW8YW0zkx2oYKF8x
 js6uiZtrNajIS0RO2RaoERpXiSG8LLpOW2CofF7tRM0Ar6Gkfs/XYQaSDu8gGWSYkl
 fig/6HVAkxpsdIZs+cf77ZjUfMX0mfPMDlK+pctE=
Received: by mail-qk1-f172.google.com with SMTP id u188so20725qkh.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 12:40:35 -0800 (PST)
X-Gm-Message-State: AHQUAuapX3NHH+Phn7DlQnaM8jhC3fsB+frxKLTh3/PgRVwNPgQwlYWU
 TRMKNzH/KtUkJkegkjVGUnmp+jYVoZJPtxIOXg==
X-Google-Smtp-Source: AHgI3IYz2gzbmamNNYONyTiDfE0zREh3E/QtpTpAvvx3glvEe3X+ZYzmIZ6HhCz+z+2Heg/0CZQUYhYHO3QCjAjIpjc=
X-Received: by 2002:a37:5686:: with SMTP id k128mr3834629qkb.29.1550004035085; 
 Tue, 12 Feb 2019 12:40:35 -0800 (PST)
MIME-Version: 1.0
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-7-hch@lst.de>
In-Reply-To: <20190211133554.30055-7-hch@lst.de>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 Feb 2019 14:40:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL+LiJTF5kZz2hXGbQcH+D4U0jAQE376VSUVMQmdg=XFA@mail.gmail.com>
Message-ID: <CAL_JsqL+LiJTF5kZz2hXGbQcH+D4U0jAQE376VSUVMQmdg=XFA@mail.gmail.com>
Subject: Re: [PATCH 06/12] dma-mapping: improve selection of
 dma_declare_coherent availability
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
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 SH-Linux <linux-sh@vger.kernel.org>, devicetree@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
 linux-mips@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 linux-riscv@lists.infradead.org, arcml <linux-snps-arc@lists.infradead.org>,
 Lee Jones <lee.jones@linaro.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 11, 2019 at 7:37 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This API is primarily used through DT entries, but two architectures
> and two drivers call it directly.  So instead of selecting the config
> symbol for random architectures pull it in implicitly for the actual
> users.  Also rename the Kconfig option to describe the feature better.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/Kconfig            | 1 -
>  arch/arm/Kconfig            | 2 +-
>  arch/arm64/Kconfig          | 1 -
>  arch/csky/Kconfig           | 1 -
>  arch/mips/Kconfig           | 1 -
>  arch/riscv/Kconfig          | 1 -
>  arch/sh/Kconfig             | 2 +-
>  arch/unicore32/Kconfig      | 1 -
>  arch/x86/Kconfig            | 1 -
>  drivers/mfd/Kconfig         | 2 ++
>  drivers/of/Kconfig          | 3 ++-
>  include/linux/device.h      | 2 +-
>  include/linux/dma-mapping.h | 8 ++++----
>  kernel/dma/Kconfig          | 2 +-
>  kernel/dma/Makefile         | 2 +-
>  15 files changed, 13 insertions(+), 17 deletions(-)

> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 3607fd2810e4..f8c66a9472a4 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -43,6 +43,7 @@ config OF_FLATTREE
>
>  config OF_EARLY_FLATTREE
>         bool
> +       select DMA_DECLARE_COHERENT

Is selecting DMA_DECLARE_COHERENT okay on UML? We run the unittests with UML.

Maybe we should just get rid of OF_RESERVED_MEM. If we support booting
from DT, then it should always be enabled anyways.

>         select OF_FLATTREE
>
>  config OF_PROMTREE
> @@ -83,7 +84,7 @@ config OF_MDIO
>  config OF_RESERVED_MEM
>         bool
>         depends on OF_EARLY_FLATTREE
> -       default y if HAVE_GENERIC_DMA_COHERENT || DMA_CMA
> +       default y if DMA_DECLARE_COHERENT || DMA_CMA
>
>  config OF_RESOLVE
>         bool
