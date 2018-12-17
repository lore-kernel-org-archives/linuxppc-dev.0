Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262B9C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 06:53:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF5F20675
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 06:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF5F20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JBgN46PPzDqSR
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 17:53:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JBdB6wBNzDqQf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 17:51:10 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43JBd47132z9v08m;
 Mon, 17 Dec 2018 07:51:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 6vLb5HBjnK5F; Mon, 17 Dec 2018 07:51:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43JBd463BGz9v08l;
 Mon, 17 Dec 2018 07:51:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 289858B7B4;
 Mon, 17 Dec 2018 07:51:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ESh-zCJmRMgp; Mon, 17 Dec 2018 07:51:05 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E931D8B74B;
 Mon, 17 Dec 2018 07:51:04 +0100 (CET)
Subject: Re: [PATCH 7/8] powerpc/dma: split the two __dma_alloc_coherent
 implementations
To: Christoph Hellwig <hch@lst.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <20181216171951.31306-1-hch@lst.de>
 <20181216171951.31306-8-hch@lst.de>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <de3d6e75-70d6-e1af-f733-b1aeed99d6c5@c-s.fr>
Date: Mon, 17 Dec 2018 07:51:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181216171951.31306-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, Christian Lamparter <chunkeey@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 16/12/2018 à 18:19, Christoph Hellwig a écrit :
> The implemementation for the CONFIG_NOT_COHERENT_CACHE case doesn't share
> any code with the one for systems with coherent caches.  Split it off
> and merge it with the helpers in dma-noncoherent.c that have no other
> callers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>   arch/powerpc/include/asm/dma-mapping.h |  5 -----
>   arch/powerpc/kernel/dma.c              | 14 ++------------

Instead of all the ifdefs in dma.c, couldn't we split it
in two files, ie dma.c for common parts and dma-coherence.c for specific 
stuff ?

Christophe

>   arch/powerpc/mm/dma-noncoherent.c      | 15 +++++++--------
>   arch/powerpc/platforms/44x/warp.c      |  2 +-
>   4 files changed, 10 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> index f2a4a7142b1e..dacd0f93f2b2 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -39,9 +39,6 @@ extern int dma_nommu_mmap_coherent(struct device *dev,
>    * to ensure it is consistent.
>    */
>   struct device;
> -extern void *__dma_alloc_coherent(struct device *dev, size_t size,
> -				  dma_addr_t *handle, gfp_t gfp);
> -extern void __dma_free_coherent(size_t size, void *vaddr);
>   extern void __dma_sync(void *vaddr, size_t size, int direction);
>   extern void __dma_sync_page(struct page *page, unsigned long offset,
>   				 size_t size, int direction);
> @@ -52,8 +49,6 @@ extern unsigned long __dma_get_coherent_pfn(unsigned long cpu_addr);
>    * Cache coherent cores.
>    */
>   
> -#define __dma_alloc_coherent(dev, gfp, size, handle)	NULL
> -#define __dma_free_coherent(size, addr)		((void)0)
>   #define __dma_sync(addr, size, rw)		((void)0)
>   #define __dma_sync_page(pg, off, sz, rw)	((void)0)
>   
> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index d442d23e182b..270b2911c437 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -62,18 +62,12 @@ static int dma_nommu_dma_supported(struct device *dev, u64 mask)
>   #endif
>   }
>   
> +#ifndef CONFIG_NOT_COHERENT_CACHE
>   void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
>   				  dma_addr_t *dma_handle, gfp_t flag,
>   				  unsigned long attrs)
>   {
>   	void *ret;
> -#ifdef CONFIG_NOT_COHERENT_CACHE
> -	ret = __dma_alloc_coherent(dev, size, dma_handle, flag);
> -	if (ret == NULL)
> -		return NULL;
> -	*dma_handle += get_dma_offset(dev);
> -	return ret;
> -#else
>   	struct page *page;
>   	int node = dev_to_node(dev);
>   #ifdef CONFIG_FSL_SOC
> @@ -113,19 +107,15 @@ void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
>   	*dma_handle = __pa(ret) + get_dma_offset(dev);
>   
>   	return ret;
> -#endif
>   }
>   
>   void __dma_nommu_free_coherent(struct device *dev, size_t size,
>   				void *vaddr, dma_addr_t dma_handle,
>   				unsigned long attrs)
>   {
> -#ifdef CONFIG_NOT_COHERENT_CACHE
> -	__dma_free_coherent(size, vaddr);
> -#else
>   	free_pages((unsigned long)vaddr, get_order(size));
> -#endif
>   }
> +#endif /* !CONFIG_NOT_COHERENT_CACHE */
>   
>   static void *dma_nommu_alloc_coherent(struct device *dev, size_t size,
>   				       dma_addr_t *dma_handle, gfp_t flag,
> diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
> index b6e7b5952ab5..e955539686a4 100644
> --- a/arch/powerpc/mm/dma-noncoherent.c
> +++ b/arch/powerpc/mm/dma-noncoherent.c
> @@ -29,7 +29,7 @@
>   #include <linux/string.h>
>   #include <linux/types.h>
>   #include <linux/highmem.h>
> -#include <linux/dma-mapping.h>
> +#include <linux/dma-direct.h>
>   #include <linux/export.h>
>   
>   #include <asm/tlbflush.h>
> @@ -151,8 +151,8 @@ static struct ppc_vm_region *ppc_vm_region_find(struct ppc_vm_region *head, unsi
>    * Allocate DMA-coherent memory space and return both the kernel remapped
>    * virtual and bus address for that space.
>    */
> -void *
> -__dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp)
> +void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>   {
>   	struct page *page;
>   	struct ppc_vm_region *c;
> @@ -223,7 +223,7 @@ __dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t
>   		/*
>   		 * Set the "dma handle"
>   		 */
> -		*handle = page_to_phys(page);
> +		*dma_handle = phys_to_dma(dev, page_to_phys(page));
>   
>   		do {
>   			SetPageReserved(page);
> @@ -249,12 +249,12 @@ __dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t
>    no_page:
>   	return NULL;
>   }
> -EXPORT_SYMBOL(__dma_alloc_coherent);
>   
>   /*
>    * free a page as defined by the above mapping.
>    */
> -void __dma_free_coherent(size_t size, void *vaddr)
> +void __dma_nommu_free_coherent(struct device *dev, size_t size, void *vaddr,
> +		dma_addr_t dma_handle, unsigned long attrs)
>   {
>   	struct ppc_vm_region *c;
>   	unsigned long flags, addr;
> @@ -309,7 +309,6 @@ void __dma_free_coherent(size_t size, void *vaddr)
>   	       __func__, vaddr);
>   	dump_stack();
>   }
> -EXPORT_SYMBOL(__dma_free_coherent);
>   
>   /*
>    * make an area consistent.
> @@ -401,7 +400,7 @@ EXPORT_SYMBOL(__dma_sync_page);
>   
>   /*
>    * Return the PFN for a given cpu virtual address returned by
> - * __dma_alloc_coherent. This is used by dma_mmap_coherent()
> + * __dma_nommu_alloc_coherent. This is used by dma_mmap_coherent()
>    */
>   unsigned long __dma_get_coherent_pfn(unsigned long cpu_addr)
>   {
> diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
> index a886c2c22097..7e4f8ca19ce8 100644
> --- a/arch/powerpc/platforms/44x/warp.c
> +++ b/arch/powerpc/platforms/44x/warp.c
> @@ -47,7 +47,7 @@ static int __init warp_probe(void)
>   	if (!of_machine_is_compatible("pika,warp"))
>   		return 0;
>   
> -	/* For __dma_alloc_coherent */
> +	/* For __dma_nommu_alloc_coherent */
>   	ISA_DMA_THRESHOLD = ~0L;
>   
>   	return 1;
> 
