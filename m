Return-Path: <linuxppc-dev+bounces-22339-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746DFCD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:33:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZVGZ1Fj7z2ySf;
	Tue, 09 Jun 2026 23:33:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781011990;
	cv=none; b=TpepS6ObeEkhdIkkoaMRFpHa9W3Fo4t0lBcg6MN5i+5XfB9guI59czWY8dmL6axdbdU18pubrNsbVb65eBsG2Ckf5Mmb0SX0KTRi6UwS0vrqptbHJNFCrMdveBrAPP0vG8Wm3SH/Wob6RpXGToOm/USYCUjtEaQDtacIETWAa9qxFxC3sW5SR36qEkKZb2dU8RnF0R0/89EG4oW8wQ6vSrUpkLN0Hn4sbENyk4Rm469FRb7Ctv7pRy4jVf3giwYhpDd82cqa+lJ53VtBStjwYVECt0Blfw1rkMjCn0siXHHiTQ+07t0nHJq5XQFsGmGeyXZF7jGIpFXbwihbsdcbRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781011990; c=relaxed/relaxed;
	bh=r+UubitX36JVc6CTd2RtBwcVL2yqRgVyLq15MXv0auc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+26romZoOCslzhym7j+14yec1lzIIemTHn48eELxPQQI7qa/Wdt8o5NcceO/XY9V21y28FB2k0eKdAf+a/aExQnRUcmV5XIsYe2QUou/2Z3Ue39GYiiePUQoF5SoB7OWBJZlDTZGq2A1TFYvmfWV6yBqDl6yS3e3vklXlwAvHRhk220AVe/z61zj0N3POFWozKFpU5w0LpXNRmHiVAbx1cX5vxCoPZOaUdQC/E0brHoyk8Na9DhkwnV7UKn3Nt25jM9JmMuIqbPMOTXJPpwJLRHV9tzQYF8VqFFTrlam9s1UtqchDxHU4ORg12TAzdW/D6hzKRVDb4lSZChT+MLVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=RM03pYy9; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=RM03pYy9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZVGX0lBcz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:33:07 +1000 (AEST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-46018d6c00aso310533f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 06:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781011984; x=1781616784; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+UubitX36JVc6CTd2RtBwcVL2yqRgVyLq15MXv0auc=;
        b=RM03pYy9Ikf1GEvQNT0gHI31xp9BzpXa8KCWhd4/TkGQItUjzZPkFsDdadH6gYGJW0
         IejPkD+oq6XfutfDvf/t7SHMcwJlvP6yPT5Tfr9Kw88nTESMkachKSdGHR8L4gmAJcyk
         WL8cP6/MG2OrOC2kh39c0sq7x0c64wGWunSqCLOvc7uFZitcYxLi0AxlX8UXK5CJ2Qnh
         o5ihqoLdExSPA6hBSHFILnK2xWfQ+uHamhQtaHWX0KoRYwXNAII+ADZkMm+K2b8zkJ9X
         UR98B3gJGNQwkmDA7oq7Z1Fpmh9WX5K+0R+v9MjPsjdgnb7htnH+CTfmT81VFGstGoiB
         1zZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011984; x=1781616784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r+UubitX36JVc6CTd2RtBwcVL2yqRgVyLq15MXv0auc=;
        b=NM+ho0v9P6wqrTRON8/Yy5AvqlWxs1cWAAnCCdnAF8le3xU72XkFHpPy1RPlsfuQO0
         13fif04ruSqY8k/auh3SGniYWgM4onqiQGUSV3lwscP4dlwcL08iizhd604Dp9ypEYnq
         1UqGsxLB31K5DQVcQ6PlzA62ZqkNtoW3rFZkmfFutJtur5AjncnBFMdUVEwFzVDG+ykx
         +QOdEO3ByEFsZAxHffSYc9nIbCGaI1h+rU6tFAmqAQ+7W1+1I15hi3T96jbQ8kJ8/64U
         27tQiSv70SEXe4IK6BRzZUHDgR+/vwDCIh6bRiF7Vz70p7xSwx56rj70zYjJxJ0ZYzTL
         3Qpw==
X-Forwarded-Encrypted: i=1; AFNElJ9TRFp1f5w5XHanm2IrZkxnKCZ1roza+cquPEcL4nHaEFNDj188FlnzY93v5Ti6HfX+X01x6vZFkDvKU6c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyOtR0sAcJAJozFVGp9y8pDJ+9zmKj2wRApXNcC1ogTzsofgKI5
	AdcxwH9ttZlAnXsoDTmcE56Iowy+eYjOtqcKn30V84dcp9gnb5TxDB6aQDLxD7m3bpI=
X-Gm-Gg: Acq92OEfH7G3HSS9BcUBhaKbifyVl/KrsK2Gw05Uo61Dmw+4cLiCNwLg8Z82Q2/1Dx6
	vfNVjoKmg8620Rzbj4lXv61cDLlBkRw3gfCjoeEh3cJ/Q5HRAC3GqbYNZyfnqbjj7qFVkbn5ebV
	kwFaCbEKegGigcFyaewoiwwUSEYxQiTWlcmdSDd5Md65KmxcCX7gnHFFrjTxUiqJiEnWXJKvhD5
	vAhWccqRyNxYJw1Wb6pZ26+1rJ8WkkdlaeBi6wKpCJwADRq/hp6TH3xncwYP4znRBuNbREQTOEh
	j24Hl30QMMaP0+PsiMv8dbdJPCQlbftXsW1/FvcDxOuJJ4BQiIn9zqUVz1MFYv7M0gWb2qut4Vu
	chgPF61RmXsYLTzSt7N89bT8XFkrsjhhXEj6TkMHhATqK/ndjoAaHp9UbqFczT6HzMW/3Vh2Pbv
	MIp7sv1tWk22yPQ/+BByn5R28=
X-Received: by 2002:a05:6000:4022:b0:45e:f68d:e7ac with SMTP id ffacd0b85a97d-46056439196mr1887515f8f.0.1781011984149;
        Tue, 09 Jun 2026 06:33:04 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46059346676sm1079048f8f.26.2026.06.09.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:32:58 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:32:55 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Will
 Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
 <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Alexey
 Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
 Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org, Michael Kelley
 <mhklinux@outlook.com>
Subject: Re: [PATCH v6 17/20] dma: swiotlb: handle set_memory_decrypted()
 failures
Message-ID: <20260609153255.4b9e9373@mordecai>
In-Reply-To: <20260604083959.1265923-18-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-18-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 14:09:56 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Check the return value when converting swiotlb pools between encrypted and
> decrypted mappings. If the default pool cannot be decrypted after early
> initialization, mark the pool fully used so it cannot satisfy future bounce
> allocations.
> 
> For late initialization, return the `set_memory_decrypted()` failure. For
> restricted DMA pools, fail device initialization if the reserved pool
> cannot be decrypted.
> 
> This prevents swiotlb from using pools whose encryption attributes do not
> match their metadata, and avoids returning pages with uncertain encryption
> state back to the allocator.

This works fine, but instead of effectively leaking the memory, we
could return it to the buddy allocator and reset nslabs to zero as if
SWIOTLB was not even initialized.

OTOH I don't want to overthink this, because the system is probably not
too useful after such a boot-time failure, so unless you _want_ to
improve the error path, you can simply add:

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 80 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 65 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 4c56f64602ea..14d834ca298b 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -248,6 +248,23 @@ static inline unsigned long nr_slots(u64 val)
>  	return DIV_ROUND_UP(val, IO_TLB_SIZE);
>  }
>  
> +static void swiotlb_mark_pool_used(struct io_tlb_pool *pool)
> +{
> +	unsigned long i;
> +
> +	for (i = 0; i < pool->nareas; i++) {
> +		pool->areas[i].index = 0;
> +		pool->areas[i].used = pool->area_nslabs;
> +	}
> +
> +	for (i = 0; i < pool->nslabs; i++) {
> +		pool->slots[i].list = 0;
> +		pool->slots[i].orig_addr = INVALID_PHYS_ADDR;
> +		pool->slots[i].alloc_size = 0;
> +		pool->slots[i].pad_slots = 0;
> +	}
> +}
> +
>  /*
>   * Early SWIOTLB allocation may be too early to allow an architecture to
>   * perform the desired operations.  This function allows the architecture to
> @@ -272,8 +289,16 @@ void __init swiotlb_update_mem_attributes(void)
>  		return;
>  	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
>  
> -	if (io_tlb_default_mem.unencrypted)
> -		set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);
> +	if (io_tlb_default_mem.unencrypted) {
> +		int ret;
> +
> +		ret = set_memory_decrypted((unsigned long)mem->vaddr,
> +					   bytes >> PAGE_SHIFT);
> +		if (ret) {
> +			pr_warn("Failed to decrypt default memory pool, disabling it\n");
> +			swiotlb_mark_pool_used(mem);
> +		}
> +	}
>  }
>  
>  static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
> @@ -442,9 +467,10 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  {
>  	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
>  	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
> +	unsigned int order, area_order, slot_order;
> +	bool leak_pages = false;
>  	unsigned int nareas;
>  	unsigned char *vstart = NULL;
> -	unsigned int order, area_order;
>  	bool retried = false;
>  	int rc = 0;
>  
> @@ -504,6 +530,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  			(PAGE_SIZE << order) >> 20);
>  	}
>  
> +	rc = -ENOMEM;
>  	nareas = limit_nareas(default_nareas, nslabs);
>  	area_order = get_order(array_size(sizeof(*mem->areas), nareas));
>  	mem->areas = (struct io_tlb_area *)
> @@ -511,14 +538,20 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  	if (!mem->areas)
>  		goto error_area;
>  
> +	slot_order = get_order(array_size(sizeof(*mem->slots), nslabs));
>  	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> -		get_order(array_size(sizeof(*mem->slots), nslabs)));
> +					      slot_order);
>  	if (!mem->slots)
>  		goto error_slots;
>  
> -	if (io_tlb_default_mem.unencrypted)
> -		set_memory_decrypted((unsigned long)vstart,
> -				     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
> +	if (io_tlb_default_mem.unencrypted) {
> +		rc = set_memory_decrypted((unsigned long)vstart,
> +					  (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
> +		if (rc) {
> +			leak_pages = true;
> +			goto error_decrypt;
> +		}
> +	}
>  
>  	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), nslabs, true,
>  				 nareas);
> @@ -527,16 +560,20 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  	swiotlb_print_info();
>  	return 0;
>  
> +error_decrypt:
> +	free_pages((unsigned long)mem->slots, slot_order);
>  error_slots:
>  	free_pages((unsigned long)mem->areas, area_order);
>  error_area:
> -	free_pages((unsigned long)vstart, order);
> -	return -ENOMEM;
> +	if (!leak_pages)
> +		free_pages((unsigned long)vstart, order);
> +	return rc;
>  }
>  
>  void __init swiotlb_exit(void)
>  {
>  	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
> +	bool leak_pages = false;
>  	unsigned long tbl_vaddr;
>  	size_t tbl_size, slots_size;
>  	unsigned int area_order;
> @@ -552,19 +589,23 @@ void __init swiotlb_exit(void)
>  	tbl_size = PAGE_ALIGN(mem->end - mem->start);
>  	slots_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), mem->nslabs));
>  
> -	if (io_tlb_default_mem.unencrypted)
> -		set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
> +	if (io_tlb_default_mem.unencrypted) {
> +		if (set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT))
> +			leak_pages = true;
> +	}
>  
>  	if (mem->late_alloc) {
>  		area_order = get_order(array_size(sizeof(*mem->areas),
>  			mem->nareas));
>  		free_pages((unsigned long)mem->areas, area_order);
> -		free_pages(tbl_vaddr, get_order(tbl_size));
> +		if (!leak_pages)
> +			free_pages(tbl_vaddr, get_order(tbl_size));
>  		free_pages((unsigned long)mem->slots, get_order(slots_size));
>  	} else {
>  		memblock_free(mem->areas,
>  			array_size(sizeof(*mem->areas), mem->nareas));
> -		memblock_phys_free(mem->start, tbl_size);
> +		if (!leak_pages)
> +			memblock_phys_free(mem->start, tbl_size);
>  		memblock_free(mem->slots, slots_size);
>  	}
>  
> @@ -1938,9 +1979,18 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>  		 * restricted mem pool is decrypted by default
>  		 */
>  		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> +			int ret;
> +
>  			mem->unencrypted = true;
> -			set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
> -					     rmem->size >> PAGE_SHIFT);
> +			ret = set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
> +						   rmem->size >> PAGE_SHIFT);
> +			if (ret) {
> +				dev_err(dev, "Failed to decrypt restricted DMA pool\n");
> +				kfree(pool->areas);
> +				kfree(pool->slots);
> +				kfree(mem);
> +				return ret;
> +			}
>  		} else {
>  			mem->unencrypted = false;
>  		}


