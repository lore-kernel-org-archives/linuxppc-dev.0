Return-Path: <linuxppc-dev+bounces-25981-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C969C5DF6D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 13:06:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQ6Jk2K4nz2yRc;
	Wed, 19 Aug 2026 23:06:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787144774;
	cv=none; b=LeVa9S9FLoYHhgRO/2oOi9EBwveMttVGC90Npwi4B8OC6QCPuM6Sg+u96NdGruTXuf8rovZUxIIC601seAXYGc+79qOQR0SrRCxfUStu/v7I0D6KGr7uDd6d/rO/iHBpCktp934bJkve0UNjZOS69ORmzw0rFT+5lB3bWxRoJFdTD8k4Xj2gpFr4Aetr6P365tHbuYxPCWiigWOoNN6k3NHNLwND0LWSbslSCFW6ec18k/7o+cpD7LrfQXHPXLYJrif17dMMILkL9ZTrHyANbTJqVQuiqBE5EKmoxdQPbOPsm0PrUBvUVYdcchUj8CAAxOOZZzO9hO7J2Rx8J0D4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787144774; c=relaxed/relaxed;
	bh=OU9YOC2PJ8C7fh5u3ebSjsuKNC81kz3bZh/4S+JHqyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfU95BEODcXdEfzvsneGxFPo3ppDAjOfRyt8PVsBLj/yPhqL0Z59VZueKSYZWVGLmzh8fj4Mir8FGO2rtkuqrchsR4MStTO/QallCEcs5uuurwjV7y+wsw4/FvigEyCOkI03KmTJrjZCf34x8dpQXSr5rYgJ0b21LqLV74GnGu7MzZfziVWQa6lM4pGE5T8mp7ssqSqHGzJgoIuE32DlQdVSfykRCp+MaRoOU7lkrSfZuc5OBBywNv/cT40zEABrgwx0Uo+0BCkn9FuDi+lJubNDsEJvRHobG4UnYmZLneH2jWDeXlUV37urRw6kDHSeIEjn4JQqjVj/jYfRN4SZRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=t3yWksBP; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=t3yWksBP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQ6Jf4TkYz2yRZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 23:06:08 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAF8214BF;
	Wed, 19 Aug 2026 06:05:31 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4142F3F763;
	Wed, 19 Aug 2026 06:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787144735; bh=8tZeoA1qM6yseHc5wH6x5IAXCz7o0dIu8IBtXCtDR5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3yWksBPwJHtK3Fh45zd2qMesmCsZj0EcT0Z3hkyOVtVEG9Mxa6bfiidSqLWTXzo4
	 whdeeirC8wqKVHU+1MTFT5sLwfrgQ2XXTsu9lig87KYPcNaBdKnnKT+HDpBjIv1tHd
	 6Sq3qDJKVnxymVmnOpi18PnEp+N8VXvbXJBYRKRY=
Date: Wed, 19 Aug 2026 14:05:29 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [RFC PATCH v2 2/2] dma: swiotlb: Initialize and size shared
 default pools for memory encryption
Message-ID: <aoWqGW5PhY9K_xTs@arm.com>
References: <20260813102521.1367737-1-aneesh.kumar@kernel.org>
 <20260813102521.1367737-3-aneesh.kumar@kernel.org>
 <an9RrwoaAsqJQ2vN@arm.com>
 <yq5aecfuiapg.fsf@kernel.org>
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
In-Reply-To: <yq5aecfuiapg.fsf@kernel.org>

On Wed, Aug 19, 2026 at 05:28:03PM +0530, Aneesh Kumar K.V wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > On Thu, Aug 13, 2026 at 03:55:21PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index 9f5b366d2086..c3188ca878f3 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -338,12 +338,8 @@ void __init arch_setup_zero_pages(void)
> >>  void __init arch_mm_preinit(void)
> >>  {
> >>  	unsigned int flags = SWIOTLB_VERBOSE;
> >> -	/* pKVM uses restricted-dma-pool */
> >> -	bool cc_guest = is_realm_world();
> >>  
> >> -	if (cc_guest)
> >> -		flags |= SWIOTLB_INIT_CC_SHARED;
> >> -	else if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
> >> +	if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
> >>  		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
> >>  
> >>  	swiotlb_init(flags);
> >
> > This looks fine. As I mentioned on patch 1, we might as well move this
> > hunk over there and avoid the flag definition.
> >
> >> @@ -102,9 +101,6 @@ void __init mem_encrypt_init(void)
> >>  
> >>  void __init mem_encrypt_setup_arch(void)
> >>  {
> >> -	phys_addr_t total_mem = memblock_phys_mem_size();
> >> -	unsigned long size;
> >> -
> >>  	/*
> >>  	 * Do RMP table fixups after the e820 tables have been setup by
> >>  	 * e820__memory_setup().
> >> @@ -112,33 +108,9 @@ void __init mem_encrypt_setup_arch(void)
> >>  	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> >>  		snp_fixup_e820_tables();
> >>  
> >> -	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> >> -		x86_swiotlb_flags |= SWIOTLB_INIT_CC_SHARED;
> >> -
> >>  	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> >>  		return;
> >>  
> >> -	/*
> >> -	 * For SEV and TDX, all DMA has to occur via shared/unencrypted pages.
> >> -	 * Kernel uses SWIOTLB to make this happen without changing device
> >> -	 * drivers. However, depending on the workload being run, the
> >> -	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
> >> -	 * run out of buffers for DMA, resulting in I/O errors and/or
> >> -	 * performance degradation especially with high I/O workloads.
> >> -	 *
> >> -	 * Adjust the default size of SWIOTLB using a percentage of guest
> >> -	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
> >> -	 * memory is allocated from low memory, ensure that the adjusted size
> >> -	 * is within the limits of low available memory.
> >> -	 *
> >> -	 * The percentage of guest memory used here for SWIOTLB buffers
> >> -	 * is more of an approximation of the static adjustment which
> >> -	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> >> -	 */
> >> -	size = total_mem * 6 / 100;
> >> -	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> >> -	swiotlb_adjust_size(size);
> >> -
> >>  	/* Set restricted memory access for virtio. */
> >>  	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
> >>  }
> >
> > Credit to claude, it noticed a slight change in behaviour for x86 w.r.t.
> > the crash kernel reservation. crash_low_size_default() reads the swiotlb
> > size but the resizing now happens after arch_reserve_crashkernel().
> > Maybe not an issue.
> >
> > Alternatively, we could build the sizing logic into
> > swiotlb_size_or_default() but I haven't checked whether we have the
> > right information when this function is called.
> 
> IIUC, the current code can still get a different value from
> crash_low_size_default() than the final swiotlb size we end up using.
> This is because crash_low_size_default() is computed early, before
> default_nareas, which is derived from num_possible_cpus(), has been set.
> 
> If we are okay with keeping this consistent with the existing behavior,
> moving sizing logic to swiotlb_adjusted_size() looks like a clean option.

See how it looks, it may turn out cleaner.

> > I think at a high level, we need (i.e. separate attributed from sizing):
> >
> > 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> > 		io_tlb_default_mem.cc_shared = true;
> >
> > 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> > 		if (!restricted_dma_pool_present)
> > 			swiotlb_adjust_cc_size();	/* 6%, clamped */
> > 	} else if (!(flags & SWIOTLB_INIT_ADDRESSING_LIMIT) &&
> > 		   swiotlb_kmalloc_needs_bounce()) {
> > 		swiotlb_shrink_for_kmalloc();		/* 1MB per 1GB */
> > 	}
> >
> 
> But pKVM wants to reduce the swiotlb size based on
> kmalloc_needs_bounce() when it is using a restricted-dma-pool.
> 
> ie,
> 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> 		io_tlb_default_mem.cc_shared = true;
> ..
> 
> 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> 	    !restricted_dma_pool_present) {
> 		swiotlb_adjust_cc_attributes();
> 	} else if (!(flags & SWIOTLB_INIT_ADDRESSING_LIMIT) &&
> 		   swiotlb_kmalloc_needs_bounce()) {

Ah, right, I got my conditions wrong. Basically a restricted pool
prevents an swiotlb growth in a protected guest. If no addressing limit
but kmalloc bouncing, we allocate a small one. Otherwise we should not
have any swiotlb at all.

I need to write it in a table, too many combinations

CC guest:
  no restricted pool			=> 6% of RAM
  restricted pool (pKVM heuristics):
    addressing limit			=> default size
    no addressing limit:
      kmalloc needs bounce		=> minimal
      no kmalloc bouncing		=> no default swiotlb

Host CC_ATTR_MEM_ENCRYPT		=> default size

No CC:
  addressing limit			=> default size
  no addressing limit:
    kmalloc needs bounce		=> minimal
    no kmalloc bouncing			=> no default swiotlb

-- 
Catalin

