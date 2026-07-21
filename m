Return-Path: <linuxppc-dev+bounces-24610-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92590C44532
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 15:35:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4Lzt5Rq1z2y8p;
	Wed, 22 Jul 2026 01:35:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784648106;
	cv=none; b=iKhPC/cnUS7xM21Dyh6UYChcJPdbcvXziui4mu0is3fREBnhyqJA9qrmec79xfxNLl++67Rfw/tNEKA5KeU2HnLtaI0NuYuKh3UUpYkDUE01L8H0OqVcW/mflisBIbLLtbfg+cpxaQONoqHNVLR+lJe1qrdJQvkCmCFjg7h3ZpLbegEBfQ/zFS1R6Px114jaXBtY83NpqRJQ+5Ws8/+cPFc9UV2fuuANsanc/EVZ69I6GhOFA/JORzD9Yt4Brw7RODM7Fb2gkKmLhyy+KCNTxVXgVZMs3cCN4141Bj5Iv9RCakEYu32IuGIrC5m8C47//x78lliP2CJJ5E9W/WqFew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784648106; c=relaxed/relaxed;
	bh=QVePzAEvk/HRAZDkJnNSAQ/f5uWHK1anOdVi7+q3VC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGsrEWrKGs7Tdy6ZH7VKJiI0OM4KkbDVoJjrP8ZfV6kO8DujENpV+ZtzVmDAHiZm7QO6Is78TDLT+LyA01Pg2QnPEsOw569ngz81L4eCoH/+GgpG1FVsPu4rYes+fN9/KEaDdawXTxClNErJLwB86953dzeLtPllo30CRcR6p9AJnrw0ZfDKXpHh+AkqXVSXu6Bgi3bkj1cOsiW0REt0lGABo6wyiLNz2Mlv9RT+APYiF3/wQD4JaRnmAWZll2Cz4djCEASrwzSrn17Qw2+j/NvuFi2wjLxh2M6/WNtgm3He1CtUGqyxjtz6nguSXjyBzRjmYZP5bHBMkWHBWuy/Ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJiPu+RZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJiPu+RZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4Lzs5Pkjz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 01:35:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 28E7D43AB4;
	Tue, 21 Jul 2026 15:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D001F000E9;
	Tue, 21 Jul 2026 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784648102;
	bh=QVePzAEvk/HRAZDkJnNSAQ/f5uWHK1anOdVi7+q3VC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IJiPu+RZcRhgVPKAHX5VV+zkTpGbxlaIRt8LxXNBYciu1fuMPhhgYPKJQ96TwVCRB
	 3n+JiLog3a27/oOTINg2GG5gDlhgSmxXdIOL+JxMBbJBKdkjaOmMJ+qUFIRhCQswJt
	 RyFoKN8CBSq9d43YYEEbCAToMoDtSj2osByB1nu529L9d5iwVIM8Chf46dxyH7IXiF
	 mv6Mt4mlVUU73mvkDpfQ+y/6Ov42XFQI740FHvBbKbsKR0gJgcOGnQAHeOGj1DRBJo
	 RVu3b7leBlQogcOqXBk0V9pb/AfRcNa77YB1xLEHV8PPgq6WzgTFVNUdArT+9LHotq
	 mk+vfcLOSch0w==
Date: Tue, 21 Jul 2026 18:34:57 +0300
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
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 02/23] dma-pool: fix page leak in atomic_pool_expand()
 cleanup
Message-ID: <20260721153457.GP110966@unreal>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-3-aneesh.kumar@kernel.org>
 <20260721123107.GJ110966@unreal>
 <yq5aqzkw76ch.fsf@kernel.org>
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
In-Reply-To: <yq5aqzkw76ch.fsf@kernel.org>

On Tue, Jul 21, 2026 at 08:11:34PM +0530, Aneesh Kumar K.V wrote:
> Leon Romanovsky <leon@kernel.org> writes:
> 
> > On Fri, Jul 17, 2026 at 11:34:20PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> atomic_pool_expand() frees the allocated pages from the remove_mapping
> >> error path only when CONFIG_DMA_DIRECT_REMAP is enabled.
> >> 
> >> When CONFIG_DMA_DIRECT_REMAP is disabled, failures after page allocation,
> >> such as gen_pool_add_virt(), jump to remove_mapping and return without
> >> freeing the pages.
> >> 
> >> Move __free_pages(page, order) out of the CONFIG_DMA_DIRECT_REMAP block so
> >> that cleanup paths always release the allocation.
> >> 
> >> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> >> Tested-by: Michael Kelley <mhklinux@outlook.com>
> >> Tested-by: Mostafa Saleh <smostafa@google.com>
> >> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> >> ---
> >>  kernel/dma/pool.c | 10 +++++++---
> >>  1 file changed, 7 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> >> index 2b2fbb709242..b0303efbc153 100644
> >> --- a/kernel/dma/pool.c
> >> +++ b/kernel/dma/pool.c
> >> @@ -81,6 +81,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
> >>  {
> >>  	unsigned int order;
> >>  	struct page *page = NULL;
> >> +	bool leak_pages = false;
> >>  	void *addr;
> >>  	int ret = -ENOMEM;
> >>  
> >> @@ -115,8 +116,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
> >>  	 */
> >>  	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> >>  				   1 << order);
> >> -	if (ret)
> >> +	if (ret) {
> >> +		leak_pages = true;
> >>  		goto remove_mapping;
> >> +	}
> >>  	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
> >>  				pool_size, NUMA_NO_NODE);
> >>  	if (ret)
> >> @@ -130,14 +133,15 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
> >>  				   1 << order);
> >>  	if (WARN_ON_ONCE(ret)) {
> >>  		/* Decrypt succeeded but encrypt failed, purposely leak */
> >> -		goto out;
> >> +		leak_pages = true;
> >
> > Instead of doing this dance with temporal variable, change "goto out" to
> > be "return true".
> >
> 
> 
> I didn't follow the return true part. A failure in
> set_memory_encrypted() or set_memory_decrypted() requires the pages to
> be leaked, so this is not the only call site that sets leak_pages =
> true. There is a similar case a few lines above.

Comment about "leaked" is enough. There is no need to introduce
convoluted flow just to check that page != NULL.

Thanks

> 
> 
> >
> >>  	}
> >>  remove_mapping:
> >>  #ifdef CONFIG_DMA_DIRECT_REMAP
> >>  	dma_common_free_remap(addr, pool_size);
> >>  free_page:
> >
> > Remove free_page label, and change leftover of "goto free_page" to be
> > "goto out"
> >
> >> -	__free_pages(page, order);
> >>  #endif
> >> +	if (!leak_pages)
> >> +		__free_pages(page, order);
> >
> > Put these checks under out label and rely on page != NULL as a marker.
> > if (page)
> >  __free_pages(page, order);
> >
> >>  out:
> >>  	return ret;
> >>  }
> >> -- 
> >> 2.43.0
> >> 
> >> 
> 
> -aneesh
> 

