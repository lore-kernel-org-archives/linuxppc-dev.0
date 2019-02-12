Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E081C282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 20:13:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5671121B68
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 20:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rS1bcNk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5671121B68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zYkY1YYxzDqNp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:13:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="rS1bcNk+"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zYhW51Z9zDqJN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 07:11:39 +1100 (AEDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6E3D1222C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 20:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550002297;
 bh=3jUa/zunVYEZn+DyMnsy8KXouqEiFYqtXTvcx6an4qk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=rS1bcNk+w8HmhmSC51+HlkPK92wtM4VYvSp1r6hov6nO+UgUiVmNcSMLjdzccAjIS
 CGfD1WLWCgx6ETbf06Bs3l5HGaxPcdQTrOW4X3yWLL/uX4LMGl6JioWcOF3ro1y/xl
 I2QY4V+JzHuYKiqSYoL+o1vgv+BgF3yQob+EZwW4=
Received: by mail-qt1-f172.google.com with SMTP id a48so4541759qtb.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 12:11:37 -0800 (PST)
X-Gm-Message-State: AHQUAuaNM1QDJE8riv0M/4bGvY6ramPYzfZ2VlpeB3VBNvHVsFVCpkMH
 csQEOItO4EjTGSAQpSVIS62njBfZ9c3W4w3JZw==
X-Google-Smtp-Source: AHgI3IbkdyI3kKb4Rqp5UgWWae9Pz2hV3loOAoVLCgrxJ3QQUi58Dd1hLL5El9rPrWVkYWU9ykNePmU2n4HW1F2r7SM=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr4072679qve.246.1550002296610; 
 Tue, 12 Feb 2019 12:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-5-hch@lst.de>
In-Reply-To: <20190211133554.30055-5-hch@lst.de>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 Feb 2019 14:11:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJFGhTa+izRTeUxjtbyOek-zynZofOJGDK+xZbD4r5H0Q@mail.gmail.com>
Message-ID: <CAL_JsqJFGhTa+izRTeUxjtbyOek-zynZofOJGDK+xZbD4r5H0Q@mail.gmail.com>
Subject: Re: [PATCH 04/12] of: select OF_RESERVED_MEM automatically
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
Cc: linux-xtensa@linux-xtensa.org, Lee Jones <lee.jones@linaro.org>,
 SH-Linux <linux-sh@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
 linux-mips@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, linux-riscv@lists.infradead.org,
 arcml <linux-snps-arc@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, devicetree@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 11, 2019 at 7:37 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The OF_RESERVED_MEM can be used if we have either CMA or the generic
> declare coherent code built and we support the early flattened DT.
>
> So don't bother making it a user visible options that is selected
> by most configs that fit the above category, but just select it when
> the requirements are met.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/Kconfig     | 1 -
>  arch/arm/Kconfig     | 1 -
>  arch/arm64/Kconfig   | 1 -
>  arch/csky/Kconfig    | 1 -
>  arch/powerpc/Kconfig | 1 -
>  arch/xtensa/Kconfig  | 1 -
>  drivers/of/Kconfig   | 5 ++---
>  7 files changed, 2 insertions(+), 9 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
