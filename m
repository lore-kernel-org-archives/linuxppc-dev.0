Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A7EC282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 07:54:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C612082F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 07:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnKvLLxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C612082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zFL26jc0zDq72
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 18:54:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=5jtu=qt=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="QnKvLLxj"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zFFG1nBZzDqNp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 18:50:26 +1100 (AEDT)
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B3154206BA;
 Tue, 12 Feb 2019 07:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549957824;
 bh=doEoHEEJFxpJh5s2UkkMEtSv47p1Dos+NTCDCKD20ZA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QnKvLLxjCK2y717cXiFoL8W4t2PIRDjVHo4lvhFpFEO2Cuy6QpxsczeDi5u62YM4/
 BpZrBe/E/XkbnZiKwZmYBsDZQ75wZBJJOSIcHRq100Nkp/vGAm6Np1h6YnM3mTQnj8
 OA5V2KBCgNP3BdgpaF/2ci+Cpj52rFJT7k4WW2hA=
Date: Tue, 12 Feb 2019 08:50:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 09/12] dma-mapping: remove the DMA_MEMORY_EXCLUSIVE flag
Message-ID: <20190212075020.GC5924@kroah.com>
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211133554.30055-10-hch@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-riscv@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 11, 2019 at 02:35:51PM +0100, Christoph Hellwig wrote:
> All users of dma_declare_coherent want their allocations to be
> exclusive, so default to exclusive allocations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/DMA-API.txt                     |  9 +------
>  arch/arm/mach-imx/mach-imx27_visstrim_m10.c   | 12 +++------
>  arch/arm/mach-imx/mach-mx31moboard.c          |  3 +--
>  arch/sh/boards/mach-ap325rxa/setup.c          |  5 ++--
>  arch/sh/boards/mach-ecovec24/setup.c          |  6 ++---
>  arch/sh/boards/mach-kfr2r09/setup.c           |  5 ++--
>  arch/sh/boards/mach-migor/setup.c             |  5 ++--
>  arch/sh/boards/mach-se/7724/setup.c           |  6 ++---
>  arch/sh/drivers/pci/fixups-dreamcast.c        |  3 +--
>  .../soc_camera/sh_mobile_ceu_camera.c         |  3 +--
>  drivers/usb/host/ohci-sm501.c                 |  3 +--
>  drivers/usb/host/ohci-tmio.c                  |  2 +-
>  include/linux/dma-mapping.h                   |  7 ++----
>  kernel/dma/coherent.c                         | 25 ++++++-------------
>  14 files changed, 29 insertions(+), 65 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
