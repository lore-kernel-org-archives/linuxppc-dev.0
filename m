Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AE9C282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 20:26:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F1A21904
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 20:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRVLLXcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F1A21904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zZ1W4YJGzDqQs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:26:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="gRVLLXcg"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zYzP1qkMzDqNp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 07:24:33 +1100 (AEDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3016E21904
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 20:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550003071;
 bh=BveQ4nP7N3gyvkFjUSr90tJMP/e9r0pbToW4MSxdXJY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=gRVLLXcgZ1AIYHYj00/fl4zJj5uwHFRPiSNjERGvza+b63FiOJlGAARkss3C3bqVe
 4xSpSvXckOl0xlj/QTFw+dpy/7ieM/yBbv5RtKuxEnIMrAqW/ZjmlfrqjyFVRm9s3z
 z0YNNT67Hgad3I7KnqxwKPL9kYfuWQJIEs817/Zc=
Received: by mail-qt1-f175.google.com with SMTP id r9so21570qtt.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 12:24:31 -0800 (PST)
X-Gm-Message-State: AHQUAuYkrFJwm+8SEw+Ke0C5Gslgat6TNHJS8LoxfRuyUk/BGnHwy65E
 fv1ZTM3CfGIz9oMmJDAfxvEjBMLGdZELMoamCw==
X-Google-Smtp-Source: AHgI3IZ+aYxfQi/q+LDrbNlsuqcIsAtFo4UYad7A+3Ns0Rodh50TLXP9jNafEkB5/FuiwJjwL14XDxq/b8yo4h5Ejaw=
X-Received: by 2002:ac8:2f4e:: with SMTP id k14mr4325527qta.76.1550003070462; 
 Tue, 12 Feb 2019 12:24:30 -0800 (PST)
MIME-Version: 1.0
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-4-hch@lst.de>
In-Reply-To: <20190211133554.30055-4-hch@lst.de>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 Feb 2019 14:24:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ2Qt6=TTD250C9qW7Kv8rZn5PyB_C78FUhWwfgOnjPHg@mail.gmail.com>
Message-ID: <CAL_JsqJ2Qt6=TTD250C9qW7Kv8rZn5PyB_C78FUhWwfgOnjPHg@mail.gmail.com>
Subject: Re: [PATCH 03/12] of: mark early_init_dt_alloc_reserved_memory_arch
 static
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

On Mon, Feb 11, 2019 at 7:36 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This function is only used in of_reserved_mem.c, and never overridden
> despite the __weak marker.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/of/of_reserved_mem.c    | 2 +-
>  include/linux/of_reserved_mem.h | 7 -------
>  2 files changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

Looks like this one isn't a dependency, so I can take it if you want.

Rob
