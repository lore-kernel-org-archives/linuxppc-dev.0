Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9350CC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 14:31:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F3620878
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 14:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FXsk21Q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F3620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439dMb6hnnzDqWR
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 01:31:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="FXsk21Q/";
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
 header.b="FXsk21Q/"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439cvZ1RjpzDrBk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 01:10:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8549A00OoBNGcGb2UherC8bfDxuBRh/wuw4HZS5ufQA=; b=FXsk21Q/B1ffr7DvVgMUyaWlr
 EbSLJVCeT6zFckd6sIKJUxxCS+GGWCgAip0J9t5ehmMovwQ1E1qxqZQ53WDQBfLpkqti5mlkag+aN
 60OwcDzxySVikQkGG4KTw4hDeKhW3JLfaKL42eXOFD6wjanW0VoQy1dmL86bEzpoIK/RRQxARV28z
 aMI2sFW9HwxOr32xNOGjR/wGVevxV/qvJsYW2ppgwtvg+L+Mf8xr02k3pF/gzOzPLXPZYevijczsg
 TGqf2+SVATJqEkO73t9e4+R5RyVruFLCEgXyu8IQ6NoZ2qq2NapsZMUDZYNwY5uZnha7gxLGTYeNX
 QKYLVLvqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gUuMA-0001Bv-GF; Thu, 06 Dec 2018 14:10:22 +0000
Date: Thu, 6 Dec 2018 06:10:22 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/34] powerpc/dma: split the two __dma_alloc_coherent
 implementations
Message-ID: <20181206141022.GG29741@infradead.org>
References: <20181114082314.8965-1-hch@lst.de>
 <20181114082314.8965-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114082314.8965-7-hch@lst.de>
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

On Wed, Nov 14, 2018 at 09:22:46AM +0100, Christoph Hellwig wrote:
> The implemementation for the CONFIG_NOT_COHERENT_CACHE case doesn't share
> any code with the one for systems with coherent caches.  Split it off
> and merge it with the helpers in dma-noncoherent.c that have no other
> callers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/include/asm/dma-mapping.h |  5 -----
>  arch/powerpc/kernel/dma.c              | 14 ++------------
>  arch/powerpc/mm/dma-noncoherent.c      | 15 +++++++--------
>  arch/powerpc/platforms/44x/warp.c      |  2 +-
>  4 files changed, 10 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> index f2a4a7142b1e..dacd0f93f2b2 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -39,9 +39,6 @@ extern int dma_nommu_mmap_coherent(struct device *dev,
>   * to ensure it is consistent.
>   */
>  struct device;
> -extern void *__dma_alloc_coherent(struct device *dev, size_t size,
> -				  dma_addr_t *handle, gfp_t gfp);
> -extern void __dma_free_coherent(size_t size, void *vaddr);
>  extern void __dma_sync(void *vaddr, size_t size, int direction);
>  extern void __dma_sync_page(struct page *page, unsigned long offset,
>  				 size_t size, int direction);
> @@ -52,8 +49,6 @@ extern unsigned long __dma_get_coherent_pfn(unsigned long cpu_addr);
>   * Cache coherent cores.
>   */
>  
> -#define __dma_alloc_coherent(dev, gfp, size, handle)	NULL
> -#define __dma_free_coherent(size, addr)		((void)0)
>  #define __dma_sync(addr, size, rw)		((void)0)
>  #define __dma_sync_page(pg, off, sz, rw)	((void)0)
>  
> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index 6551685a4ed0..d6deb458bb91 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -62,18 +62,12 @@ static int dma_nommu_dma_supported(struct device *dev, u64 mask)
>  #endif
>  }
>  
> +#ifndef CONFIG_NOT_COHERENT_CACHE
>  void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
>  				  dma_addr_t *dma_handle, gfp_t flag,
>  				  unsigned long attrs)
>  {
>  	void *ret;
> -#ifdef CONFIG_NOT_COHERENT_CACHE
> -	ret = __dma_alloc_coherent(dev, size, dma_handle, flag);
> -	if (ret == NULL)
> -		return NULL;
> -	*dma_handle += get_dma_offset(dev);
> -	return ret;
> -#else
>  	struct page *page;
>  	int node = dev_to_node(dev);
>  #ifdef CONFIG_FSL_SOC
> @@ -110,19 +104,15 @@ void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
>  	*dma_handle = __pa(ret) + get_dma_offset(dev);
>  
>  	return ret;
> -#endif
>  }
>  
>  void __dma_nommu_free_coherent(struct device *dev, size_t size,
>  				void *vaddr, dma_addr_t dma_handle,
>  				unsigned long attrs)
>  {
> -#ifdef CONFIG_NOT_COHERENT_CACHE
> -	__dma_free_coherent(size, vaddr);
> -#else
>  	free_pages((unsigned long)vaddr, get_order(size));
> -#endif
>  }
> +#endif /* !CONFIG_NOT_COHERENT_CACHE */
>  
>  static void *dma_nommu_alloc_coherent(struct device *dev, size_t size,
>  				       dma_addr_t *dma_handle, gfp_t flag,
> diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
> index b6e7b5952ab5..e955539686a4 100644
> --- a/arch/powerpc/mm/dma-noncoherent.c
> +++ b/arch/powerpc/mm/dma-noncoherent.c
> @@ -29,7 +29,7 @@
>  #include <linux/string.h>
>  #include <linux/types.h>
>  #include <linux/highmem.h>
> -#include <linux/dma-mapping.h>
> +#include <linux/dma-direct.h>
>  #include <linux/export.h>
>  
>  #include <asm/tlbflush.h>
> @@ -151,8 +151,8 @@ static struct ppc_vm_region *ppc_vm_region_find(struct ppc_vm_region *head, unsi
>   * Allocate DMA-coherent memory space and return both the kernel remapped
>   * virtual and bus address for that space.
>   */
> -void *
> -__dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp)
> +void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	struct page *page;
>  	struct ppc_vm_region *c;
> @@ -223,7 +223,7 @@ __dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t
>  		/*
>  		 * Set the "dma handle"
>  		 */
> -		*handle = page_to_phys(page);
> +		*dma_handle = phys_to_dma(dev, page_to_phys(page));
>  
>  		do {
>  			SetPageReserved(page);
> @@ -249,12 +249,12 @@ __dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t
>   no_page:
>  	return NULL;
>  }
> -EXPORT_SYMBOL(__dma_alloc_coherent);
>  
>  /*
>   * free a page as defined by the above mapping.
>   */
> -void __dma_free_coherent(size_t size, void *vaddr)
> +void __dma_nommu_free_coherent(struct device *dev, size_t size, void *vaddr,
> +		dma_addr_t dma_handle, unsigned long attrs)
>  {
>  	struct ppc_vm_region *c;
>  	unsigned long flags, addr;
> @@ -309,7 +309,6 @@ void __dma_free_coherent(size_t size, void *vaddr)
>  	       __func__, vaddr);
>  	dump_stack();
>  }
> -EXPORT_SYMBOL(__dma_free_coherent);
>  
>  /*
>   * make an area consistent.
> @@ -401,7 +400,7 @@ EXPORT_SYMBOL(__dma_sync_page);
>  
>  /*
>   * Return the PFN for a given cpu virtual address returned by
> - * __dma_alloc_coherent. This is used by dma_mmap_coherent()
> + * __dma_nommu_alloc_coherent. This is used by dma_mmap_coherent()
>   */
>  unsigned long __dma_get_coherent_pfn(unsigned long cpu_addr)
>  {
> diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
> index a886c2c22097..7e4f8ca19ce8 100644
> --- a/arch/powerpc/platforms/44x/warp.c
> +++ b/arch/powerpc/platforms/44x/warp.c
> @@ -47,7 +47,7 @@ static int __init warp_probe(void)
>  	if (!of_machine_is_compatible("pika,warp"))
>  		return 0;
>  
> -	/* For __dma_alloc_coherent */
> +	/* For __dma_nommu_alloc_coherent */
>  	ISA_DMA_THRESHOLD = ~0L;
>  
>  	return 1;
> -- 
> 2.19.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
