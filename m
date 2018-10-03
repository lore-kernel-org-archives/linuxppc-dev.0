Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F94C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 23:13:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1004213A2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 23:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAS3H7iR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1004213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QWyt3qPjzF399
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 09:13:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aAS3H7iR";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=alexander.duyck@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aAS3H7iR"; 
 dkim-atps=neutral
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QWwJ2H01zF37n
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 09:10:55 +1000 (AEST)
Received: by mail-it1-x142.google.com with SMTP id c23-v6so10684703itd.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Oct 2018 16:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WkneyoPSzQoLcAs/axE/9Wn7NDHDcegu/815uCyWtMQ=;
 b=aAS3H7iR7tKCn18Bu+R32muRHNGmesECifoN6+HaBzwzWou8RvaJKS5mvdhzMIP50o
 3yBpvLrKH1OBDLET7sSFa3XI+zP37X9cskU3e6dfd6anZTptDHDLbQ+HIey2iu/93dvS
 Ui0s3EsCBaTLwQ/FzIcdINEVUnxqHNCnAo13e1ur0jl9DL1EasnhqEppccKEHMudUSxM
 JdcefefdmeAvHgKKdygewMnQxkLcTdd8MaK/7g04fW2f4KN4EAyGAvC8MnS3hbUtiC08
 p61jtfmN0EeN+oIFyrasdH5vtC8FtRqf0S5Sr4pbsYKIIfeTu1ATQJYrVoc7X1vxG2RV
 3cOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WkneyoPSzQoLcAs/axE/9Wn7NDHDcegu/815uCyWtMQ=;
 b=CUny15XZCWcrENh4o4E0ujaSeDZ+Gz60/nhtg1fnKCuz4aXsLuxqghwAYBu5VuvzB2
 KhPg31OOQRUIjhR54gpi0UbeDFXDPLIuUaXDHCkMl9djFEmn3rTGxvLdC59Eozy/frtG
 1YuDA00d9oiezIQGzI1UoURbokOGWBYA6cbWRTX2XvmU7iSFhcsDC4KAEHSEgzqvMHbz
 T6sHrm/I5PpYdeDDFrRpXTOX0/vu8eqOXG0f7JZCYLjMwntGQElLuI64QBmmLSYhPVjz
 fO/wDfbqgPopGr5Edfy5pCoQRBwaofl3381XP9o9q36yj/dLL9RRgtdDukK7tJ2HQNVV
 lVig==
X-Gm-Message-State: ABuFfogfA+CeHXeHAkWxmTt10uM/2azjR6lIvcePJArzviFdUhFDZ4gM
 To1yudLDFBarPWjOZy1z6Cl3VKChHXD+54veVYk=
X-Google-Smtp-Source: ACcGV61yJGqdImxFUQ185ncRCzs26khJfftTvba1wTU1tDyNNhtXksshLE/PMTxBzPFSN0y2EGlBjQoQF4a5iZfz1x0=
X-Received: by 2002:a02:3d8e:: with SMTP id
 n136-v6mr3010705jan.87.1538608253265; 
 Wed, 03 Oct 2018 16:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180927223539.28449-1-hch@lst.de>
 <20180927223539.28449-6-hch@lst.de>
In-Reply-To: <20180927223539.28449-6-hch@lst.de>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 3 Oct 2018 16:10:42 -0700
Message-ID: <CAKgT0Ucii29i7S8eCj20D=a+=DeyKxREG0U2DBNRp3jFpgLu_A@mail.gmail.com>
Subject: Re: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal memory
 size
To: Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
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
Cc: Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 "open list:INTEL IOMMU \(VT-d\)" <iommu@lists.linux-foundation.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 "open list:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 27, 2018 at 3:38 PM Christoph Hellwig <hch@lst.de> wrote:
>
> This way an architecture with less than 4G of RAM can support dma_mask
> smaller than 32-bit without a ZONE_DMA.  Apparently that is a common
> case on powerpc.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  kernel/dma/direct.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 60c433b880e0..170bd322a94a 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -284,21 +284,25 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>         return nents;
>  }
>
> +/*
> + * Because 32-bit DMA masks are so common we expect every architecture to be
> + * able to satisfy them - either by not supporting more physical memory, or by
> + * providing a ZONE_DMA32.  If neither is the case, the architecture needs to
> + * use an IOMMU instead of the direct mapping.
> + */
>  int dma_direct_supported(struct device *dev, u64 mask)
>  {
> -#ifdef CONFIG_ZONE_DMA
> -       if (mask < phys_to_dma(dev, DMA_BIT_MASK(ARCH_ZONE_DMA_BITS)))
> -               return 0;
> -#else
> -       /*
> -        * Because 32-bit DMA masks are so common we expect every architecture
> -        * to be able to satisfy them - either by not supporting more physical
> -        * memory, or by providing a ZONE_DMA32.  If neither is the case, the
> -        * architecture needs to use an IOMMU instead of the direct mapping.
> -        */
> -       if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
> +       u64 min_mask;
> +
> +       if (IS_ENABLED(CONFIG_ZONE_DMA))
> +               min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
> +       else
> +               min_mask = DMA_BIT_MASK(32);
> +
> +       min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
> +
> +       if (mask >= phys_to_dma(dev, min_mask))
>                 return 0;
> -#endif
>         return 1;
>  }

So I believe I have run into the same issue that Guenter reported. On
an x86_64 system w/ Intel IOMMU. I wasn't able to complete boot and
all probe attempts for various devices were failing with -EIO errors.

I believe the last mask check should be "if (mask < phys_to_dma(dev,
min_mask))" not a ">=" check.

- Alex
