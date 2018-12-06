Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B934AC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 14:29:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383EB208E7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 14:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="psPHXtNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383EB208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439dJf6kSdzDqCc
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 01:29:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="psPHXtNI";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+70d48d6b9c27e7160fa0+5583+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="psPHXtNI"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439cvL4FwqzDqgL
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 01:10:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qd/N8v4WLST7e+Rgj899KmUUcIZDgRuyOZOYu6GcjiU=; b=psPHXtNI4mC17WCXLsvCQahby
 RpTEiOEq8cHoV5mH2mIYdG2AeUeqfLbd38Au+RWjBm+0A+OEDYSHG9sZGhP7dfxuWJ2+QcRCQPAza
 2A2jwc/I1Fj/6dXi5XBsOw7y1eUdtlhgOneQEqq/+/uIcY+xeCcIO9GT3E7NmnHeB/q1dgEfZVSPQ
 4Yi1M6XLOleFWpeK4iLPr7o6ibJVRMekjWjeo5qvCZvZK7X85GoqJ/Gm1SGvLyLzlx+D1xJnbqbSy
 dXQNm/xivkdTLhb16qFyONsE8b6CtPGky9AjPeQkENc0GDmv0LEvIAaU1yu1Uv2Jv9qEp5/pUjTaf
 qzXDb9K+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gUuLy-0001B2-N5; Thu, 06 Dec 2018 14:10:10 +0000
Date: Thu, 6 Dec 2018 06:10:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 07/34] powerpc/dma: remove the no-op
 dma_nommu_unmap_{page, sg} routines
Message-ID: <20181206141010.GF29741@infradead.org>
References: <20181114082314.8965-1-hch@lst.de>
 <20181114082314.8965-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114082314.8965-8-hch@lst.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

ping?

On Wed, Nov 14, 2018 at 09:22:47AM +0100, Christoph Hellwig wrote:
> These methods are optional, no need to implement no-op versions.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/dma.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index d6deb458bb91..7078d72baec2 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -197,12 +197,6 @@ static int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
>  	return nents;
>  }
>  
> -static void dma_nommu_unmap_sg(struct device *dev, struct scatterlist *sg,
> -				int nents, enum dma_data_direction direction,
> -				unsigned long attrs)
> -{
> -}
> -
>  static u64 dma_nommu_get_required_mask(struct device *dev)
>  {
>  	u64 end, mask;
> @@ -228,14 +222,6 @@ static inline dma_addr_t dma_nommu_map_page(struct device *dev,
>  	return page_to_phys(page) + offset + get_dma_offset(dev);
>  }
>  
> -static inline void dma_nommu_unmap_page(struct device *dev,
> -					 dma_addr_t dma_address,
> -					 size_t size,
> -					 enum dma_data_direction direction,
> -					 unsigned long attrs)
> -{
> -}
> -
>  #ifdef CONFIG_NOT_COHERENT_CACHE
>  static inline void dma_nommu_sync_sg(struct device *dev,
>  		struct scatterlist *sgl, int nents,
> @@ -261,10 +247,8 @@ const struct dma_map_ops dma_nommu_ops = {
>  	.free				= dma_nommu_free_coherent,
>  	.mmap				= dma_nommu_mmap_coherent,
>  	.map_sg				= dma_nommu_map_sg,
> -	.unmap_sg			= dma_nommu_unmap_sg,
>  	.dma_supported			= dma_nommu_dma_supported,
>  	.map_page			= dma_nommu_map_page,
> -	.unmap_page			= dma_nommu_unmap_page,
>  	.get_required_mask		= dma_nommu_get_required_mask,
>  #ifdef CONFIG_NOT_COHERENT_CACHE
>  	.sync_single_for_cpu 		= dma_nommu_sync_single,
> -- 
> 2.19.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
