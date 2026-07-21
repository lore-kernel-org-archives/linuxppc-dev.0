Return-Path: <linuxppc-dev+bounces-24609-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0503CC44532
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 15:33:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4Ly463Btz2xm3;
	Wed, 22 Jul 2026 01:33:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784648012;
	cv=none; b=A48xujdU5b8BNLXli7AoKxuvaTV1KC9pFtTOpEQUxQHEswhyTBP19Zi6nKARmooPZqy3F6R5/RbQUIsbUulv7sY1hRk6lFQ/8LBOEXkXzKr8e6pMoTla/6qQLKU6c5Pp1JPyh33chPMNWHyZEkoWedxTHUtYTefnG/8gpWJbp89u5GkyJHMmjcZSceLqLg/npqB2MMMZy2+xLhDr0kCPWQsTEbelewUgYed90I+MuEon/gXPFjKCCGDHbngW3vTJeHfto0xT7SghIOhMyNYWEQL56lB0LDnMP48yUnpSdJXOvM0Xj9FG5ytJuDYQkxWCDgrPnvrQ+2hQVXP7V4RlMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784648012; c=relaxed/relaxed;
	bh=0MsfUHsh7/pU0dEmGJ8yQrcxAOBrj57aAW4TYmEgSa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0qdXPzzhJnk7rI5UK3kjYv9CC3LVGc7NsoqwR/Vx3jYJoJKch2qm2fwFQFXk1/l7W9K2AexRelPE/S8E6CvJGQah6HSyut5ud8CK0a46wgtVR2h9IuHPyB/q8eOvPK2yPtPWyqkc0Q8Ie2xA+JaouYy7PwE7u8K8aKQHm6AOy9Xs5QlQdi8vcGQGGeFTPBd8zIoTDz1hcZ6gnvBmcDlvycnz6S4+tdQLFv0DXTkQ8L8gxMWj2KUbt3W/f4m1X8o5ZkLthdbv3UwpgmqlLhnBPRkpyRqHh9SMHU7VrD1DV2LwYvWYIDlY9d8rcKTHQugcRp/SerHQJEqbwWoLjOKWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtTlvsgB; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtTlvsgB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4Ly33K6Gz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 01:33:31 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DC42A43E60;
	Tue, 21 Jul 2026 15:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E401F000E9;
	Tue, 21 Jul 2026 15:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784648007;
	bh=0MsfUHsh7/pU0dEmGJ8yQrcxAOBrj57aAW4TYmEgSa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RtTlvsgBwpvI0cpC2iB7lmnZsJJQS3iN2nxCIQ//4/R7sa6Ddwam0EfjjO67bp+fO
	 ZUvnFVQCbVdC+rprpImnQ71P/DXiWl4BcNPLzChAK5mZc6IC7Fg7/+u3KpDARDYE48
	 783F22LzzVw+RaD1DEkOXy6Hmr7sf5hej91oSPVKZPxvUyT34ZcmiF29+aHPPjBQ5I
	 GQ9xQgSmPNM3x8bNp45OOFOZDKpUwuRY+pw61HJlkyNZZPXHkzn4MuVJl8wAQQncL0
	 xB0NTm977UpaO8i1yNgz9I7sxcKIQ34Wqb3yHygOtgO5PY3h0RqiM4Fh+NA77y/ggd
	 u6EVDacyAMw7w==
Date: Tue, 21 Jul 2026 18:33:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 01/23] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <20260721153321.GO110966@unreal>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-2-aneesh.kumar@kernel.org>
 <20260721115456.GI110966@unreal>
 <yq5atsps77c5.fsf@kernel.org>
 <20260721142921.GN110966@unreal>
 <yq5ao6g0750v.fsf@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ao6g0750v.fsf@kernel.org>

On Tue, Jul 21, 2026 at 08:40:08PM +0530, Aneesh Kumar K.V wrote:
> Leon Romanovsky <leon@kernel.org> writes:
> 
> > On Tue, Jul 21, 2026 at 07:50:10PM +0530, Aneesh Kumar K.V wrote:
> >> Leon Romanovsky <leon@kernel.org> writes:
> >> 
> >> > On Fri, Jul 17, 2026 at 11:34:19PM +0530, Aneesh Kumar K.V (Arm) wrote:
> ....
> >> >>  static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
> >> >> @@ -247,8 +246,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >> >>  	 * the atomic pools instead if we aren't allowed block.
> >> >>  	 */
> >> >>  	if ((remap || force_dma_unencrypted(dev)) &&
> >> >> -	    dma_direct_use_pool(dev, gfp))
> >> >> -		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
> >> >> +	    dma_direct_use_pool(dev, gfp)) {
> >> >> +		page = dma_direct_alloc_from_pool(dev, size, dma_handle,
> >> >> +						  &ret, gfp);
> >> >> +		return page ? ret : NULL;
> >> >
> >> > Sorry for joining the discussion late, but the line above caught my
> >> > attention.
> >> >
> >> > Why do we need both ret and page? We can derive cpu_addr from page and
> >> > vice versa. Do we really need the &ret parameter? Or, more generally, do
> >> > we really need "struct page *"?
> >> >
> >> > static struct page *__dma_alloc_from_pool(struct device *dev, size_t size,
> >> > 		struct gen_pool *pool, void **cpu_addr,
> >> > 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
> >> > {
> >> > ...
> >> > 	*cpu_addr = (void *)addr;
> >> > 	memset(*cpu_addr, 0, size);
> >> > 	return pfn_to_page(__phys_to_pfn(phys));
> >> > }
> >> >
> >> > Why
> >> >
> >> 
> >> With CONFIG_DMA_DIRECT_REMAP the cpu_addr can be different from
> >> page_address.
> >
> > Can you please point to the code there it can happen?
> > __dma_alloc_from_pool() has direct connection between physical address
> > and struct page.
> >
> 
> dma_direct_alloc -> 	remap = IS_ENABLED(CONFIG_DMA_DIRECT_REMAP);
> 	if ((remap && dma_direct_use_pool(dev, gfp)) {
> 		page = dma_direct_alloc_from_pool(dev, size,
> 
> ..
> __dma_alloc_from_pool -> 
> 	addr = gen_pool_alloc(pool, size);
> 	if (!addr)
> 
> 
> We expand the pool as below..
> 
> atomic_pool_expand ->
> 
> #ifdef CONFIG_DMA_DIRECT_REMAP
> 	addr = dma_common_contiguous_remap(page, pool_size,
> 			pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL)),
> 			__builtin_return_address(0));
> 	if (!addr)
> 		goto free_page;
> #else
> 	addr = page_to_virt(page);
> #endif

Right, and nothing prevents you from adding a small DMA helper
that translates mapped/direct addresses back to struct page.

Something like, but probably void* needs to be phys_addr_t:

static inline struct page *dma_phys_to_page(void *addr)
{
#ifdef CONFIG_DMA_DIRECT_REMAP
	return vmalloc_to_page(addr);
#else
	return virt_to_page(addr);
#endif
}

Architecture code already does this throughout the tree.

Thanks


> 
> 
> -aneesh
> 

