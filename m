Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D9FC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 14:21:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB63B20878
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 14:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HXch1zsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB63B20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439d7j52tKzDr7F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 01:21:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="HXch1zsJ";
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
 header.b="HXch1zsJ"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439ctt38HlzDr5l
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 01:10:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZrKB4sfEbsTIItO7rTtpYHjGNnttwfnOSxg8vOpWZoY=; b=HXch1zsJm170tVkDctkcOgLfg
 g0Yo1EeyX4ckJHfKzLYwzwXvhkHgRvqXRoKFKCR8XtwBUmjR6YWSwhH+pVgLvC13ikvIS0JWkx0gG
 ccGB+D9btGplUrZANedtL5dNWkZlUt6DMj3oHQMmWCRaYm5SKWIH+IQBjW3UmhTJ3EamLQ2OuIAd/
 OYksNJAAeo1lUpV+4NJsxk493EGD2/1wr/Komu9Iyx07e/cbMNzUp864ZCzXdChVsb3AhjyNrB6y5
 QxC1t4Y/2IGUxuzZrVEPk3/LpvDznFHJAGkjjet1jCL+yOD1RfvqHOEiGbn3gLbm3ANqbknfPzAMG
 yohWtCuDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gUuLt-0000Ct-1w; Thu, 06 Dec 2018 14:10:05 +0000
Date: Thu, 6 Dec 2018 06:10:04 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 05/34] powerpc/dma: remove the unused dma_iommu_ops export
Message-ID: <20181206141004.GE29741@infradead.org>
References: <20181114082314.8965-1-hch@lst.de>
 <20181114082314.8965-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114082314.8965-6-hch@lst.de>
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

On Wed, Nov 14, 2018 at 09:22:45AM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/kernel/dma-iommu.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
> index f9fe2080ceb9..2ca6cfaebf65 100644
> --- a/arch/powerpc/kernel/dma-iommu.c
> +++ b/arch/powerpc/kernel/dma-iommu.c
> @@ -6,7 +6,6 @@
>   * busses using the iommu infrastructure
>   */
>  
> -#include <linux/export.h>
>  #include <asm/iommu.h>
>  
>  /*
> @@ -123,4 +122,3 @@ struct dma_map_ops dma_iommu_ops = {
>  	.get_required_mask	= dma_iommu_get_required_mask,
>  	.mapping_error		= dma_iommu_mapping_error,
>  };
> -EXPORT_SYMBOL(dma_iommu_ops);
> -- 
> 2.19.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
