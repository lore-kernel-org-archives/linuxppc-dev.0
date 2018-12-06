Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84A4C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 14:34:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DE620878
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 14:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mce0Y3Ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DE620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439dQP1gbSzDqvh
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 01:34:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="Mce0Y3Ry";
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
 header.b="Mce0Y3Ry"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439cw05YshzDr5Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 01:11:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=viiDVyzJaB3rTVvtO4TYkza+OHah/1wsa4lbl2vkAOQ=; b=Mce0Y3RynLAIwbdsnD5nCW1c5
 RBNWyOxdVM8V2/hG1XWAQ+zvEp0vKaj3EVpxxG3P7FhEdkIaVjmRxtN5pARszU0nx3y5zm40DSyts
 d0gSe4OWGLtpTcAp/78lyLw0US4RkXGC1GNENUZz/Y/HT795Q/OfiHlf837TnsLcv84hG+h2k0Ljo
 99FGbo63qPlICiCCfX2SicOpqceiDW83QDrsU5kA+14BhW5YljJYClaD6BeUVBiZ6TbWCoNkYhXHd
 w8YPoIgxvHpY9GJ7h+vQ0IVUa8Zlu/7Om6O3rEdeoM/4XYXwXdyxLE7NERgO5yj8uex1jrI3EQqlz
 AOCJHUeLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gUuMY-0001DL-32; Thu, 06 Dec 2018 14:10:46 +0000
Date: Thu, 6 Dec 2018 06:10:45 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 19/34] cxl: drop the dma_set_mask callback from vphb
Message-ID: <20181206141045.GI29741@infradead.org>
References: <20181114082314.8965-1-hch@lst.de>
 <20181114082314.8965-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114082314.8965-20-hch@lst.de>
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

On Wed, Nov 14, 2018 at 09:22:59AM +0100, Christoph Hellwig wrote:
> The CXL code never even looks at the dma mask, so there is no good
> reason for this sanity check.  Remove it because it gets in the way
> of the dma ops refactoring.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/misc/cxl/vphb.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
> index 7908633d9204..49da2f744bbf 100644
> --- a/drivers/misc/cxl/vphb.c
> +++ b/drivers/misc/cxl/vphb.c
> @@ -11,17 +11,6 @@
>  #include <misc/cxl.h>
>  #include "cxl.h"
>  
> -static int cxl_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
> -{
> -	if (dma_mask < DMA_BIT_MASK(64)) {
> -		pr_info("%s only 64bit DMA supported on CXL", __func__);
> -		return -EIO;
> -	}
> -
> -	*(pdev->dev.dma_mask) = dma_mask;
> -	return 0;
> -}
> -
>  static int cxl_pci_probe_mode(struct pci_bus *bus)
>  {
>  	return PCI_PROBE_NORMAL;
> @@ -220,7 +209,6 @@ static struct pci_controller_ops cxl_pci_controller_ops =
>  	.reset_secondary_bus = cxl_pci_reset_secondary_bus,
>  	.setup_msi_irqs = cxl_setup_msi_irqs,
>  	.teardown_msi_irqs = cxl_teardown_msi_irqs,
> -	.dma_set_mask = cxl_dma_set_mask,
>  };
>  
>  int cxl_pci_vphb_add(struct cxl_afu *afu)
> -- 
> 2.19.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
