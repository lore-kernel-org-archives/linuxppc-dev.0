Return-Path: <linuxppc-dev+bounces-28020-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88807C982FA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 13:13:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqcpR02Slz2yqw;
	Wed, 23 Sep 2026 23:13:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790169182;
	cv=none; b=gOWD8KHIdv2GCv22Vv6zSdMDHUAVOcvyIjjhSDy4yoLl6vAmu4/91qNnYboIg+YLn/NrVVhVKaEdkDgDa2sBQ246XhWX097l5QrkXQ/xs4oMjmqRWEz7O+NHX0KRs8mrSkJ69LRO/VZdh0pi3N40wf5CWgFYO9JrL/n7f3zFCiPdkpSBudH79jeSGkrpuAeB9ghrqq2OGPe8EFSJBTga8F5x88aOTc1vdC/DSpvxGAEDOBlyz+o77/MqEwJORSW5f96rMo+1CFkVulD6uV8LGYGWFMHl2J1ZH7g33R653l68sOdqF/eWwL1MpxpP+0/8oO/H5U9qEBju96bkD9D6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790169182; c=relaxed/relaxed;
	bh=RTn4OGwOGPRfi2cEJEfeMukuMx7i2BfSJzbwvifkfgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8TT9v8Bz1tJew1JjrzRxjVH9cGWzITXs0aRiFMJExuXBH/6bYVPUohmnkaK8MC439cEjqGLmBdZBe3nH3OQaWAbBeIIMduYtBkPzcBjMHL2hoHWaAfA2NivYNZmiSGLLKf8pXlBjBY16c3qq5Rz6p5RjhDVY9YUd2mS7/xM9S2OAIlox/JHyMqvPt5BSU8aaZn4StXjMygDl3dZVpk4AXCugkWGzbL9LHaueWAam0VuvxBcM0Pxgm0UyTrZf4NinN8Uds7Kwo685nUhh1xpBEPId58K91di0FV0Q5t07R9QFvVANPWufeNSGslbN+K7CcQLoh/W2fYrvA5CZZVRNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aYmen1TR; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aYmen1TR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqcpP6F45z2xs1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 23:13:01 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA44F1570;
	Wed, 23 Sep 2026 06:12:26 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DECAE3F86F;
	Wed, 23 Sep 2026 06:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790169150; bh=SmFHo2nDPpKUONOshPa8YT9u4NS/UwmA8+HdpmeKeFY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aYmen1TRM7QwJGqc4OFo5787lJ46tKHEUhwYkPXWOHO78pDyWHT/ftcomcAC4QiiM
	 uwuv2AuQKHBDvvrSfp103KDdhV9+AKBs552MKlmOb12iwVrK22hWi7KXM5UOO/7Th9
	 hwFueBx+pgNbLEPuAMRwfKDJM8gVQxNzs1TUlr4A=
Message-ID: <26dd45d3-067a-4999-9cf6-8a0633a594f8@arm.com>
Date: Wed, 23 Sep 2026 14:12:21 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] dma: swiotlb: Remove SWIOTLB_ANY
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon
 <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>,
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
 Petr Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>,
 Dan Williams <dan.j.williams@intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Russell King <linux@armlinux.org.uk>,
 Huacai Chen <chenhuacai@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, x86@kernel.org
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-7-aneesh.kumar@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260921063628.362078-7-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2026 7:36 am, Aneesh Kumar K.V (Arm) wrote:
> swiotlb pools are currently allocated below the architecture's low
> address limit by default. SWIOTLB_ANY overrides this and permits
> allocation anywhere in directly mapped memory.
> 
> SWIOTLB_INIT_ADDRESSING_LIMIT now explicitly identifies callers which
> need a pool that is reachable by devices with limited DMA addressing.
> Use it as the placement constraint and remove SWIOTLB_ANY.
> 
> This changes the default behavior for callers which do not set either
> flag. Previously, omitting SWIOTLB_ANY placed the default pool below the
> architecture's low address limit and also constrained dynamically
> allocated pools to the same range. After this change, omitting
> SWIOTLB_INIT_ADDRESSING_LIMIT permits both static and dynamic pools to
> use any directly mapped memory.

While it's rather dependent on some of the other aspects wanting a bit 
more work still, this part I do entirely agree with :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   Documentation/core-api/swiotlb.rst |  8 ++++----
>   arch/powerpc/mm/mem.c              |  6 ++++--
>   arch/riscv/mm/init.c               | 16 ----------------
>   arch/s390/mm/init.c                |  2 +-
>   arch/x86/kernel/pci-dma.c          |  2 +-
>   include/linux/swiotlb.h            |  7 +++----
>   kernel/dma/swiotlb.c               | 17 ++++++-----------
>   7 files changed, 19 insertions(+), 39 deletions(-)
> 
> diff --git a/Documentation/core-api/swiotlb.rst b/Documentation/core-api/swiotlb.rst
> index 71b4e4c27eb5..06d9f88fdf7b 100644
> --- a/Documentation/core-api/swiotlb.rst
> +++ b/Documentation/core-api/swiotlb.rst
> @@ -148,10 +148,10 @@ may also be adjusted
>   due to other conditions, such as running in a CoCo VM, as described above. If
>   CONFIG_SWIOTLB_DYNAMIC is enabled, additional pools may be allocated later in
>   the life of the system. Each pool must be a contiguous range of physical
> -memory. The default pool is allocated below the 4 GiB physical address line so
> -it works for devices that can only address 32-bits of physical memory (unless
> -architecture-specific code provides the SWIOTLB_ANY flag). In a CoCo VM, the
> -pool memory must be decrypted before swiotlb is used.
> +memory. The default pool is allocated below the architecture's low address
> +limit when it is needed for devices with limited DMA addressing. Otherwise,
> +it may be allocated anywhere in directly mapped memory. In a CoCo VM, the pool
> +memory must be decrypted before swiotlb is used.
>   
>   Each pool is divided into "slots" of size IO_TLB_SIZE, which is 2 KiB with
>   current definitions. IO_TLB_SEGSIZE contiguous slots (128 slots) constitute
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 006ed41097e9..1bdea6c03848 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -295,9 +295,11 @@ void __init arch_mm_preinit(void)
>   		/*
>   		 * Since the guest memory is inaccessible to the host,
>   		 * devices always need to use the SWIOTLB buffer for DMA
> -		 * even if dma_capable() says otherwise.
> +		 * even if dma_capable() says otherwise. The hypervisor has
> +		 * no addressing limitation, so the buffer may be allocated
> +		 * anywhere.
>   		 */
> -		ppc_swiotlb_flags |= SWIOTLB_ANY;
> +		ppc_swiotlb_flags &= ~SWIOTLB_INIT_ADDRESSING_LIMIT;
>   	}
>   
>   	/*
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 96856114b387..734712230f35 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -165,27 +165,11 @@ static void print_vm_layout(void) { }
>   
>   void __init arch_mm_preinit(void)
>   {
> -	bool swiotlb = max_pfn > PFN_DOWN(dma32_phys_limit) &&
> -		       memblock_start_of_DRAM() < dma32_phys_limit;
>   	unsigned int swiotlb_flags = SWIOTLB_VERBOSE;
>   #ifdef CONFIG_FLATMEM
>   	BUG_ON(!mem_map);
>   #endif /* CONFIG_FLATMEM */
>   
> -	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb &&
> -	    dma_cache_alignment != 1) {
> -		/*
> -		 * No 32-bit DMA bouncing needed (either all DRAM is within
> -		 * the 32-bit limit, or it all starts above it), but
> -		 * kmalloc() buffers whose sizes are not cache-line-aligned
> -		 * still require bouncing for non-coherent DMA.  Use
> -		 * SWIOTLB_ANY so that the buffer can be allocated from high
> -		 * memory when DRAM starts above dma32_phys_limit.  Allocate
> -		 * ~1 MB per 1 GB of RAM.
> -		 */
> -		swiotlb_flags |= SWIOTLB_ANY;
> -	}
> -
>   	if ((max_pfn > PFN_DOWN(dma32_phys_limit)) &&
>   	     (memblock_start_of_DRAM() < dma32_phys_limit))
>   		swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 78f507e24ceb..ce10292447f1 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -166,7 +166,7 @@ static void __init pv_init(void)
>   	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
>   
>   	/* make sure bounce buffers are shared */
> -	swiotlb_init(SWIOTLB_VERBOSE | SWIOTLB_ANY);
> +	swiotlb_init(SWIOTLB_VERBOSE);
>   	swiotlb_update_mem_attributes();
>   }
>   
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index ce257b20ea9c..74e92b457758 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -90,7 +90,7 @@ static void __init pci_xen_swiotlb_init(void)
>   	/* Xen can use a SWIOTLB pool anywhere in directly mapped memory. */
>   	x86_swiotlb_flags &= ~(SWIOTLB_INIT_ADDRESSING_LIMIT |
>   			       SWIOTLB_INIT_DEFAULT_OFF);
> -	x86_swiotlb_flags |= SWIOTLB_INIT_REMAP | SWIOTLB_ANY;
> +	x86_swiotlb_flags |= SWIOTLB_INIT_REMAP;
>   	swiotlb_init_remap(x86_swiotlb_flags, xen_swiotlb_fixup);
>   	dma_ops = &xen_swiotlb_dma_ops;
>   	if (IS_ENABLED(CONFIG_PCI))
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 466c33795db0..503e1446e0d8 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -15,13 +15,12 @@ struct page;
>   struct scatterlist;
>   
>   #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
> -#define SWIOTLB_ANY	(1 << 1) /* allow any memory for the buffer */
>   /* Initialize a default-sized pool for devices with limited DMA addressing. */
> -#define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 2)
> +#define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 1)
>   /* Initialize a default-sized pool that requires architecture remapping. */
> -#define SWIOTLB_INIT_REMAP		(1 << 3)
> +#define SWIOTLB_INIT_REMAP		(1 << 2)
>   /* Do not initialize a pool unless SWIOTLB is explicitly required. */
> -#define SWIOTLB_INIT_DEFAULT_OFF		(1 << 4)
> +#define SWIOTLB_INIT_DEFAULT_OFF	(1 << 3)
>   
>   /*
>    * Maximum allowable number of contiguous slabs to map,
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 46b789eb0806..77d7c320de28 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -450,15 +450,10 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
>   	size_t bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
>   	void *tlb;
>   
> -	/*
> -	 * By default allocate the bounce buffer memory from low memory, but
> -	 * allow to pick a location everywhere for hypervisors with guest
> -	 * memory encryption.
> -	 */
> -	if (flags & SWIOTLB_ANY)
> -		tlb = memblock_alloc(bytes, PAGE_SIZE);
> -	else
> +	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
>   		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
> +	else
> +		tlb = memblock_alloc(bytes, PAGE_SIZE);
>   
>   	if (!tlb) {
>   		pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
> @@ -604,10 +599,10 @@ void __init swiotlb_init_remap(unsigned int flags,
>   #ifdef CONFIG_SWIOTLB_DYNAMIC
>   	if (!remap)
>   		io_tlb_default_mem.can_grow = true;
> -	if (flags & SWIOTLB_ANY)
> -		io_tlb_default_mem.phys_limit = virt_to_phys(high_memory - 1);
> -	else
> +	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
>   		io_tlb_default_mem.phys_limit = ARCH_LOW_ADDRESS_LIMIT;
> +	else
> +		io_tlb_default_mem.phys_limit = virt_to_phys(high_memory - 1);
>   #endif
>   
>   	/* if we have host or guest memory encryption */


