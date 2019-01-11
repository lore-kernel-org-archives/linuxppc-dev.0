Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5C6C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 19:56:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3D520836
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 19:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mbohqD2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3D520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43btsY3k2SzDr4t
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 06:56:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="mbohqD2Q"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43btqk3Z92zDr4L
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 06:54:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fMcNvquDgQQYlKE4Y7lNw6Nx1C1EhjU6J5BGveGlj+4=; b=mbohqD2QpEMefQWwUsKCJJR0wu
 XLxAF7/7GnD3lzQsYsgzRvoy1zuL7Ej70GIMeFRCcP6OoqrQ5zEbi3ymwpEXuE8uU+YWZg1Gp5EQ/
 4otHAYmsRlUMimv7+sUOhH7xlI537dTWBlz21EilYEsoRClF7Mc76ZM5aJlB5CO9fzeeNiq95PRcv
 tU1bQ5OdGrT9SQgptnDn1p/CqPKxQJW/h9+Bmc6E0J675O13PXHHI8iN7g+v+ZnA5MjEoLdWoyrVa
 oLvXi+/a8wZ3SkoSbTiyARozxYoYa3ppl0LF0X5BNi1DgOEj2LhBA7evi/bgAhBuyyDGHmrPx6s9Q
 MIxVgPSA==;
Received: from 177.17.174.42.dynamic.adsl.gvt.net.br ([177.17.174.42]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi2sp-0000fE-UV; Fri, 11 Jan 2019 19:54:24 +0000
Date: Fri, 11 Jan 2019 17:54:16 -0200
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] videobuf2: replace a layering violation with
 dma_map_resource
Message-ID: <20190111175416.7d291e25@coco.lan>
In-Reply-To: <20190111181731.11782-4-hch@lst.de>
References: <20190111181731.11782-1-hch@lst.de>
 <20190111181731.11782-4-hch@lst.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?=
 <niklas.soderlund+renesas@ragnatech.se>, Pawel Osciak <pawel@osciak.com>,
 Russell King <linux@armlinux.org.uk>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>,
 linux-media@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Fri, 11 Jan 2019 19:17:31 +0100
Christoph Hellwig <hch@lst.de> escreveu:

> vb2_dc_get_userptr pokes into arm direct mapping details to get the
> resemblance of a dma address for a a physical address that does is
> not backed by a page struct.  Not only is this not portable to other
> architectures with dma direct mapping offsets, but also not to uses
> of IOMMUs of any kind.  Switch to the proper dma_map_resource /
> dma_unmap_resource interface instead.

Makes sense to me. I'm assuming that you'll be pushing it together
with other mm patches, so:

Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  .../common/videobuf2/videobuf2-dma-contig.c   | 41 ++++---------------
>  1 file changed, 9 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> index aff0ab7bf83d..82389aead6ed 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> @@ -439,42 +439,14 @@ static void vb2_dc_put_userptr(void *buf_priv)
>  				set_page_dirty_lock(pages[i]);
>  		sg_free_table(sgt);
>  		kfree(sgt);
> +	} else {
> +		dma_unmap_resource(buf->dev, buf->dma_addr, buf->size,
> +				   buf->dma_dir, 0);
>  	}
>  	vb2_destroy_framevec(buf->vec);
>  	kfree(buf);
>  }
>  
> -/*
> - * For some kind of reserved memory there might be no struct page available,
> - * so all that can be done to support such 'pages' is to try to convert
> - * pfn to dma address or at the last resort just assume that
> - * dma address == physical address (like it has been assumed in earlier version
> - * of videobuf2-dma-contig
> - */
> -
> -#ifdef __arch_pfn_to_dma
> -static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
> -{
> -	return (dma_addr_t)__arch_pfn_to_dma(dev, pfn);
> -}
> -#elif defined(__pfn_to_bus)
> -static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
> -{
> -	return (dma_addr_t)__pfn_to_bus(pfn);
> -}
> -#elif defined(__pfn_to_phys)
> -static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
> -{
> -	return (dma_addr_t)__pfn_to_phys(pfn);
> -}
> -#else
> -static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
> -{
> -	/* really, we cannot do anything better at this point */
> -	return (dma_addr_t)(pfn) << PAGE_SHIFT;
> -}
> -#endif
> -
>  static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
>  	unsigned long size, enum dma_data_direction dma_dir)
>  {
> @@ -528,7 +500,12 @@ static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
>  		for (i = 1; i < n_pages; i++)
>  			if (nums[i-1] + 1 != nums[i])
>  				goto fail_pfnvec;
> -		buf->dma_addr = vb2_dc_pfn_to_dma(buf->dev, nums[0]);
> +		buf->dma_addr = dma_map_resource(buf->dev,
> +				__pfn_to_phys(nums[0]), size, buf->dma_dir, 0);
> +		if (dma_mapping_error(buf->dev, buf->dma_addr)) {
> +			ret = -ENOMEM;
> +			goto fail_pfnvec;
> +		}
>  		goto out;
>  	}
>  



Thanks,
Mauro
