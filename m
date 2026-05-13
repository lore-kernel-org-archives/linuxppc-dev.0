Return-Path: <linuxppc-dev+bounces-20925-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C053CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 23:01:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gG88c4lS1z2y8W;
	Thu, 14 May 2026 09:01:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778680739;
	cv=none; b=JTKlrHWHHVjzCvFSn2/UJTCPuyz2/Nz75BfUnudkt1YV0iMIkg1Wl4F2UPwm6u7UEkwE6Xl35UcH7V/R5H411zaEx/5POgmXADogDtNFbt6E+7dxhorlXIz2EnSgMt39j7pQxfO2wxZ22uQMibMdToXpQN70ltDjGJg/BFxr1vJFq0fURk4K1eyX5SRbJZbyJ+7ocl4B4dosjL1uUi4NhCi5kJKTm7p+aGPVwNK5wlQdc+T1FxEbKDC5yY5hDPe2t0qlKRI4ViVMQuA7N8SVlr4WVVPLUU+lTSSB9+yTQwL+ERiQHaXnXmlEiWFb68oQUOpXgTUcjEsSbpMZxgDtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778680739; c=relaxed/relaxed;
	bh=tPMVkSo7vb48jv7YwJ0Vd+mCEf6970EXP9V58QWiGq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aaqx5HVmEgyx02VU/xtOQ4an6IjxaaFrbAkOILjYCSGQ9nTm+Q4dI9eUatrTaKknuBHVx4XbYPsnkU7soDfD3BTBk7yeCxnwVa76scNWXCGh9xoofGjfr2pQiMvp9IbW/7RrB3pngwWS4wdKeZqh6E00s/NqaXrJQKh8BrBF1FAEqn370tBaAjUW1ZFSBDZya+pSleEdLrWhpSA5+LSz+9IwFYoqL20rh58s4HA0SLZ6+TI0+KuZRo8BBu4k2ylNzxWwB0ya2Ng6L09wFPzRL4oRRX3MplArdIIThIIWaIL6mheg1mPOQnYUEm441b15Cpe6IYVNAe+DBCWjFiLBdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OsBuYyeD; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OsBuYyeD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFw6n4JQ6z2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:58:57 +1000 (AEST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so3525e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778680729; x=1779285529; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tPMVkSo7vb48jv7YwJ0Vd+mCEf6970EXP9V58QWiGq0=;
        b=OsBuYyeDD2xiObB27tZD3/PWyLf15jO6FPD2GLKhmQrTaTOZbE2NxHE6+m6b/Swcqw
         223/oGs2/If1HaDJPrtOUiQ8F8/x87uZ6fq8IM/4aMcJiU2UrPLfKXZGgtWVfxXVUqQY
         lorafQ9ItSYNqWczdETLhi9SlpqsY9ki+yKagbOPgpVgjGA5qZ9qiXcOt8nGIxVYguQs
         uE+jYXuXRQHecHBruDhP+bSVwfZ3aykE8JrL6ZMaeh/Jmr0Rik25km/qa5vpSGsWNq/9
         tRzdaXlchSrbfDgGLb76iOuPPv8lQO4UBJUtyPU3ijZQz1n/wadR8qc8ZQisA8kRlr8o
         8z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680729; x=1779285529;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPMVkSo7vb48jv7YwJ0Vd+mCEf6970EXP9V58QWiGq0=;
        b=pVPFrW8K60O5tyN77JrQy1jkLugxPR5qySwQephq1FFcSaZjaCq/BmuU4YTBYWGH6Z
         efZPgX5qG4BHgqRwn+84dme9k0344Af8u44GkGeowda+SaYGoz1d2HOTL8Oqb1X9MOKf
         kyeu2gVQARDCq/Wd5QlP11cgbXIJKZX8qbg8QNpa+k/kYZwClOJYtyWMUMpaqc0aZFKx
         NTK4a+bapFI/OqQ5mjruvuzfbROGikDw5iIm1RGy7BzXW1IuN7cKlRVUJp7cCptaxrWt
         FLqwCnsAbHpeek8OETc3eZk0o1ovTtpajZgYbWQaupubbXz1JxttEjKL10JfW9QhOE58
         9sTA==
X-Forwarded-Encrypted: i=1; AFNElJ+5j071BxeR6mD2N3oUBDvdY2rwLmdugxW0RG4o3UKW3kbb7A7gHJ0HObTXlyXz5C6jVYF4Cujd2A0Ylm8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxLgUJzbiRDtBMEa3K253BGs38K2/7QQNEKzzVMnAL3uYo1tJl8
	Ql39mLPlWX18t8pWpXVY7VtzFotpt6U5mX40cpwZKKwoF5BP8IolEZc7rBg1Nfh47A==
X-Gm-Gg: Acq92OG4OXu5kNLOPt2BaRzgKK8aM4/kQ/B9md3/x81Q/RMrjWY1PYkcgsp3ERY7h6y
	us9yZPZEMhTJaELhBsxUHZi/EefL/6UcqJUQOD5fEgkchBf/lgtOCkOne1+zXE9rYQApOZ27DBN
	1OTmh1ZJ5R0TMynx/vYbgGaQq3OaI0MYDyamcGLSRGpxG0tb9TwTHem+Bg+b2aQmaDIbJLWmPIH
	fk1hVR9avrLeB6yAido5rGksAnYMqX9iLcYK0cWAwud0t2/hgXPHo47mz1PzHXraV1Hyrn1J6Gp
	Xq2fii0+qQdWtYLXUpcLVm9EmH8jhrfvAXl8mocbubUGHMoOVuU0OOju5KMYWI10dHBB2TPJgG1
	Ux6wAPTS+IZ4MxLj5wMCmstrL7qfYc0qGi910dlJGak3MtO+wXR/GMmddqVfi5mdXj2m6XzldiY
	eu39nsqROOgbrOYMaoLPltp7NcsbDmq8xi0lOr3MSRIZnIWWJ26OddgaYU6xxE0N7D8Bs=
X-Received: by 2002:a05:600c:8a16:10b0:48a:5618:b4d4 with SMTP id 5b1f17b1804b1-48fcacd0d81mr589735e9.1.1778680729194;
        Wed, 13 May 2026 06:58:49 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6cd75sm39576190f8f.16.2026.05.13.06.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:58:48 -0700 (PDT)
Date: Wed, 13 May 2026 13:58:43 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 02/13] dma-direct: use DMA_ATTR_CC_SHARED in
 alloc/free paths
Message-ID: <agSDk0QsEM0ZBCTA@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-3-aneesh.kumar@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512090408.794195-3-aneesh.kumar@kernel.org>

On Tue, May 12, 2026 at 02:33:57PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Propagate force_dma_unencrypted() into DMA_ATTR_CC_SHARED in the
> dma-direct allocation path and use the attribute to drive the related
> decisions.
> 
> This updates dma_direct_alloc(), dma_direct_free(), and
> dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c | 44 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index b958f150718a..0c2e1f8436ce 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -201,16 +201,31 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	bool remap = false, set_uncached = false;
> -	bool mark_mem_decrypt = true;
> +	bool mark_mem_decrypt = false;
>  	struct page *page;
>  	void *ret;
>  
> +	/*
> +	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
> +	 * attribute. The direct allocator uses it internally after it has
> +	 * decided that the backing pages must be shared/decrypted, so the
> +	 * rest of the allocation path can consistently select DMA addresses,
> +	 * choose compatible pools and restore encryption on free.
> +	 */
> +	if (attrs & DMA_ATTR_CC_SHARED)
> +		return NULL;
> +
> +	if (force_dma_unencrypted(dev)) {
> +		attrs |= DMA_ATTR_CC_SHARED;
> +		mark_mem_decrypt = true;
> +	}
> +
>  	size = PAGE_ALIGN(size);
>  	if (attrs & DMA_ATTR_NO_WARN)
>  		gfp |= __GFP_NOWARN;
>  
> -	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> -	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
> +	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) ==
> +	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev))
>  		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
>  
>  	if (!dev_is_dma_coherent(dev)) {
> @@ -244,7 +259,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	 * Remapping or decrypting memory may block, allocate the memory from
>  	 * the atomic pools instead if we aren't allowed block.
>  	 */
> -	if ((remap || force_dma_unencrypted(dev)) &&
> +	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
>  	    dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>  
> @@ -318,11 +333,20 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  void dma_direct_free(struct device *dev, size_t size,
>  		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>  {
> -	bool mark_mem_encrypted = true;
> +	bool mark_mem_encrypted = false;
>  	unsigned int page_order = get_order(size);
>  
> -	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> -	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
> +	/*
> +	 * if the device had requested for an unencrypted buffer,
> +	 * convert it to encrypted on free
> +	 */
> +	if (force_dma_unencrypted(dev)) {
> +		attrs |= DMA_ATTR_CC_SHARED;
> +		mark_mem_encrypted = true;
> +	}
> +
> +	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) ==
> +	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev)) {
>  		/* cpu_addr is a struct page cookie, not a kernel address */
>  		dma_free_contiguous(dev, cpu_addr, size);
>  		return;
> @@ -365,10 +389,14 @@ void dma_direct_free(struct device *dev, size_t size,
>  struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
>  {
> +	unsigned long attrs = 0;
>  	struct page *page;
>  	void *ret;
>  
> -	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
> +	if (force_dma_unencrypted(dev))
> +		attrs |= DMA_ATTR_CC_SHARED;
> +
> +	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);

What about dma_direct_free_pages()? Nothing inside uses attrs, but
that’s quite similar to dma_direct_alloc_pages()

Also, at this point, shouldn’t this patch also remove
force_dma_unencrypted() calls from dma_set_decrypted() and
dma_set_encrypted()?

Thanks,
Mostafa

>  
>  	if (is_swiotlb_for_alloc(dev)) {
> -- 
> 2.43.0
> 

