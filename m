Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF7DC2BC61
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 13:03:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB8B20823
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 13:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB8B20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ks8V4xPYzDrGp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 00:03:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ks3V2qhmzDrYb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 23:58:44 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 3331768B02; Tue, 30 Oct 2018 13:58:41 +0100 (CET)
Date: Tue, 30 Oct 2018 13:58:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH] powerpc/npu-dma: Remove NPU DMA ops
Message-ID: <20181030125841.GB30158@lst.de>
References: <20181030110203.27257-1-alistair@popple.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030110203.27257-1-alistair@popple.id.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: hch@lst.de, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Please take my patch instead.  We have a kernel polcity to not keep
dead code around, and everyone including Linus and the attending IBMers
confirmed this.

On Tue, Oct 30, 2018 at 10:02:03PM +1100, Alistair Popple wrote:
> The NPU IOMMU is setup to mirror the parent PCIe device IOMMU
> setup. Therefore it does not make sense to call dma operations such as
> dma_map_page, etc. directly on these devices. The existing dma-ops
> simply print a warning if they are ever called, however this is
> unnecessary and the warnings are likely to go unnoticed.
> 
> It is instead simpler to remove these operations and let the generic
> DMA code print warnings (eg. via a NULL pointer deref) in cases of
> buggy drivers attempting dma operations on NVLink devices.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> ---
>  arch/powerpc/platforms/powernv/npu-dma.c | 64 ++------------------------------
>  1 file changed, 4 insertions(+), 60 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index 6f60e0931922..75b935252981 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -102,63 +102,6 @@ struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index)
>  }
>  EXPORT_SYMBOL(pnv_pci_get_npu_dev);
> 
> -#define NPU_DMA_OP_UNSUPPORTED()					\
> -	dev_err_once(dev, "%s operation unsupported for NVLink devices\n", \
> -		__func__)
> -
> -static void *dma_npu_alloc(struct device *dev, size_t size,
> -			   dma_addr_t *dma_handle, gfp_t flag,
> -			   unsigned long attrs)
> -{
> -	NPU_DMA_OP_UNSUPPORTED();
> -	return NULL;
> -}
> -
> -static void dma_npu_free(struct device *dev, size_t size,
> -			 void *vaddr, dma_addr_t dma_handle,
> -			 unsigned long attrs)
> -{
> -	NPU_DMA_OP_UNSUPPORTED();
> -}
> -
> -static dma_addr_t dma_npu_map_page(struct device *dev, struct page *page,
> -				   unsigned long offset, size_t size,
> -				   enum dma_data_direction direction,
> -				   unsigned long attrs)
> -{
> -	NPU_DMA_OP_UNSUPPORTED();
> -	return 0;
> -}
> -
> -static int dma_npu_map_sg(struct device *dev, struct scatterlist *sglist,
> -			  int nelems, enum dma_data_direction direction,
> -			  unsigned long attrs)
> -{
> -	NPU_DMA_OP_UNSUPPORTED();
> -	return 0;
> -}
> -
> -static int dma_npu_dma_supported(struct device *dev, u64 mask)
> -{
> -	NPU_DMA_OP_UNSUPPORTED();
> -	return 0;
> -}
> -
> -static u64 dma_npu_get_required_mask(struct device *dev)
> -{
> -	NPU_DMA_OP_UNSUPPORTED();
> -	return 0;
> -}
> -
> -static const struct dma_map_ops dma_npu_ops = {
> -	.map_page		= dma_npu_map_page,
> -	.map_sg			= dma_npu_map_sg,
> -	.alloc			= dma_npu_alloc,
> -	.free			= dma_npu_free,
> -	.dma_supported		= dma_npu_dma_supported,
> -	.get_required_mask	= dma_npu_get_required_mask,
> -};
> -
>  /*
>   * Returns the PE assoicated with the PCI device of the given
>   * NPU. Returns the linked pci device if pci_dev != NULL.
> @@ -270,10 +213,11 @@ static void pnv_npu_dma_set_32(struct pnv_ioda_pe *npe)
>  	rc = pnv_npu_set_window(npe, 0, gpe->table_group.tables[0]);
> 
>  	/*
> -	 * We don't initialise npu_pe->tce32_table as we always use
> -	 * dma_npu_ops which are nops.
> +	 * NVLink devices use the same TCE table configuration as
> +	 * their parent device so drivers shouldn't be doing DMA
> +	 * operations directly on these devices.
>  	 */
> -	set_dma_ops(&npe->pdev->dev, &dma_npu_ops);
> +	set_dma_ops(&npe->pdev->dev, NULL);
>  }
> 
>  /*
> --
> 2.11.0
---end quoted text---
