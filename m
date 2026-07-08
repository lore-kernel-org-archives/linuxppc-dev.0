Return-Path: <linuxppc-dev+bounces-23772-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BF3C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 07:26:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw8lY4Pwxz2xm3;
	Wed, 08 Jul 2026 17:26:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783495561;
	cv=none; b=jna1gIsZunOYWg7XlhxxNhNgFdqTnbNS5uoqBZbLCSwRB0ZnggguhO73qEfspw7heJ/WO2OzU9K0lZcs+/73dSoPx9n0kDSHxmRfesmp7tiaiO4OdulgVKmu3hoi2PLkaerRn9uMHznyb/jW3GbIbZuqMh4DY0WuEOLOIUJ/WRDGdux0PXP2gSNmes2cKhbID9J4OS1DTqQkNjHunscX9Vk0jJOTsRe+oExnX+weoa/8FKL0QCQe0tquP8qUxr2+c8k5h5Ba9Uj/6PMAu2H6b2iZgtGi6bAMbTDgeVJyQXDedkh/fb3bYug6G+PwBGHNhBbWG6gXDuf/obW5RAz/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783495561; c=relaxed/relaxed;
	bh=qefrf5l9lihScGalW/jsRpVcRfII+2L4nJseIDI5g20=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=f+vMgsdvcKF7hLi6zasq1xSvc5PiVGLhlb3pukrDpwp6no+870lv2Ju7eSUldnFcwn6QKlCGFDhy1QwiSAgcG5m9Nvg6+iVq1Dyjkgv0W+pb21THX7XUYFQVVQqqQPz4FThKPnN18G7Ip6HOSu5ITqKYHhRIEb9V9V4SABBOBmaMirDL4ds/GxQXv7EIUep4sNQoO2/EEmS2n60iZKUu4xtGrKL5gARMBx/8rssqFhwKR/tTnP7COYTEImCf7s6SDyv9G5/r0nJPDoCmQS8fS1hI+7H4Z2C1wEO0ME1x0IvIyl1WF2mBPmvSiyxUxP66bWrpy7sZEuzlOfU29k6inw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bk+cF8pw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bk+cF8pw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw8lX2RSwz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 17:25:59 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-c9aea40d799so144616a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 00:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783495557; x=1784100357; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qefrf5l9lihScGalW/jsRpVcRfII+2L4nJseIDI5g20=;
        b=bk+cF8pwVXABoGXi46zB0hdOjRGUwyXRuCu5GNJFJZTX68TTUZZJNbgYtzG5N7Rsmf
         iaS6VNb7ehFHGpQShiKER0B0zeBjXo+0ANtiQj0aR11bbx8Jk1q8/78i2BbZ4ZWASoVc
         RYFgDmYj/IKDi+3I/IMdetWvh+Z56Z/nJiw1K6na5sKC+QUK5reY1ANc/FxkNSijsN66
         2Tlhr0NnZjmsvyiO8gqFk2PUqJI3LLdPGBBV6RTVQjCar2fLDKGnDs1yMDcs7tRG+Hgp
         N7vVOH4pyilBsAdfhVTXivA/6L1e4E8b0/5il7FMg0Vq6C/DIYg7Wjl0y/31Pj6CFvwW
         OYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783495557; x=1784100357;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qefrf5l9lihScGalW/jsRpVcRfII+2L4nJseIDI5g20=;
        b=HAEVD9yswr8e4xTc4g82bbjQfk+sDApVwQviOTnP7noh/qBoFF8WPPiIGRO5apyRKr
         fYzinMQ8VpOtM7nWcRPjvnioxPEYkSQU8n5bQYGG4yyATHqtuZ+80Qo3tlBuZL4zSziR
         MhTBYz0d4Sq9Ny3sjjcZUeHqoOJzWajLn2Ktgk0dt39S3jRFXr7wBtw+kRxOASdCDTZf
         LFY3bsC2MWSMe/I2j7rXNbBtlXaA7ZLIJqmsIC46XPRu9AAWJCqRl1uWH5T6YJvdpcaw
         ApwYFn84eSEHoF69iSUeTZN+Q2JzS7yTMWN+XrPaiMOjEbton4JUXT2+xfI/ZG3Xlaa2
         fnHg==
X-Gm-Message-State: AOJu0Yw4V3s193FR1+NQpP4j+8RQE8k1nthp5Dq+/9ET8fmEcF48NhJI
	rpyMR02b21cYkM6di1uCvc/TXlrQSQMqMzaQSNUo1lMYIFzz3TtCmKFX
X-Gm-Gg: AfdE7cnYJ5yG7LgnmdR1xosvAt0TscPEKaaBNyBHtriuw93lo6Qed9SVmf7HmDxkc/p
	4CthWGANeBt+HPnAu/JplbQv8OdWxD+XHe1s40N9k459QwC/mBxtRFwepSiXcyHjpknFAR4+Pv3
	7sU45rcUDLvYIVsjXOvSHmVW8zSlvCNFzFOsE/GIOAegUtxTPceUl8Lus7z6wA3eJ4hQZt8Y3s4
	pwst2g87WUSB3PK6D8sWelzgrVifBtAKdcHjPahHGQVqSqcChkN9b+eL9KZRUMzXhGpSYiJmSt1
	zjt6l8s7b/kYJ0Ewcgx46NkA6kFJ/ExBFHXT4lbM4mX4wctggkBPGXgcvyt0Ig+wQxyFlwldt13
	mXZtZjeZBYijW2JIlqcvFAGPMp8Y/VsxawcorHJnFxOgOgVxc/OPMis7J+zSf0IsFuGI/jJtMvZ
	doKH+8ywMJXh8=
X-Received: by 2002:a05:6a21:a49:b0:3bf:e761:626a with SMTP id adf61e73a8af0-3c0bd16f98emr1545202637.38.1783495556463;
        Wed, 08 Jul 2026 00:25:56 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm15716118eec.4.2026.07.08.00.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:25:55 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, sbhat@linux.ibm.com, vaibhav@linux.ibm.com, donettom@linux.ibm.com, harshpb@linux.ibm.com, Gaurav Batra <gbatra@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped
In-Reply-To: <20260515155143.39050-1-gbatra@linux.ibm.com>
Date: Wed, 08 Jul 2026 11:51:08 +0530
Message-ID: <ik6qvw6j.ritesh.list@gmail.com>
References: <20260515155143.39050-1-gbatra@linux.ibm.com>
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


Thanks for the changes. Added minor comments and queries.

Gaurav Batra <gbatra@linux.ibm.com> writes:

> In powerPC, if Dynamic DMA Window is big enough, RAM is pre-mapped. To
> determine the size of RAM, a PAPR+ property "ibm,lrdr-capacity" is used.
> This OF property dictates what is the max size of RAM an LPAR can have,
> including DR added memory.
>
> In PowerPC, 16GB pages can be allocated at machine level and then

This will be mostly for Hash MMU correct? Which will be P9 then?
Is this also possible in case of P10?
Can this 16GB pages be added via HMC? How can one test this?

> assigned to LPARs. These 16GB pages are added to LPAR memory at the time
> of boot. The address range for these 16GB pages is above MAX RAM an LPAR
> can have (ibm,lrdr-capacity). In the current implementation, these 16GB
> pages are being excluded from pre-mapped TCEs. A driver can have DMA
> buffers allocated from 16GB pages. This results in platform to raise an
> EEH when DMA is attempted on buffers in 16GB memory range.
>
> commit 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly
> adds TCEs for pmemory")
>
> Prior to the above patch, memblock_end_of_DRAM() was being used to
> determine the MAX memory of an LPAR. This included 16GB pages as well.
> The issue with using memblock_end_of_DRAM() is that when pmemory is
> converted to RAM via daxctl command, the DDW engine will incorrectly try
> to add TCEs for pmemory as well.
>
> Below is the address distribution of RAM, 16GB pages and pmemory for an
> LPAR with max memory of 256GB, memory allocated 64GB, 2 16GB pages and
> assigned pmemory of 8GB.
>
> RANGE                                 SIZE  STATE REMOVABLE     BLOCK
> 0x0000000000000000-0x0000000fffffffff  64G online       yes     0-255
> 0x0000004000000000-0x00000047ffffffff  32G online       yes 1024-1151
>
> cat /sys/bus/nd/devices/region0/resource
> 0x40100000000
> cat /sys/bus/nd/devices/region0/size
> 8589934592
>

cat /proc/iomem should show the output for pmemory as well correct?

> The approach to fix this problem is to revert back the code changes
> introduced by the above patch and to stash away the MAX memory of an
> LPAR, including 16GB pages, at the LPAR boot time. This value is then
> used whenever TCEs are needed to be pre-mapped - enable_DDW() or,
> iommu_mem_notifier()
>

Was this hit in an internal testing? Is it possible to have a test
around this please?

@Venkat, did we test this specific case with and w/o this patch as well?
Reason for my asks is - since we will be backporting this patch to older
stable kernels, it will be good to ensure this has been properly tested
and if possible we should even have a unit test to ensure this
doesn't break in future.

> Fixes: 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly adds TCEs for pmemory")

This patch was made in v6.15. Since we want this to be backported, I
would suggested add a CC stable tag as well.

> Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
> ---
>
> Change log:
>
> V2 -> V3
>
> 1. Harsh: Remove R-b tags from the change log
>
>    Response: Incorporated changes
>
> 2. Harsh: Change WARN_ON() to WARN_ONCE()
>
>    Response: Incorporated changes
>
> 3. Harsh: Fix indendation
>
>    Response: Incorporated changes
>
> 4. Harsh: Replace comment with a log if limit < arg->nr_pages ? 
>
>    Response: Doesn't seems to be needed since the WARN_ONCE() will log this
>    scenario. I removed the comment instead.
>
> V1 -> V2
>
> 1. Harsh: Not only start_pfn, but end_pfn also needs to be within allowed
>    range, which may require clamping arg->nr_pages if crossing the limits.
>
>    Response: Incorporated changes.
>
>  arch/powerpc/platforms/pseries/iommu.c | 58 ++++++++++++++++++--------
>  1 file changed, 41 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 3e1f915fe4f6..7bbe070006fa 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -69,6 +69,8 @@ static struct iommu_table *iommu_pseries_alloc_table(int node)
>  	return tbl;
>  }
>  
> +static phys_addr_t pseries_ddw_max_ram;
> +

Since this is only set once during init and read afterwards.. Maybe we
should change this to __ro_after_init?

>  #ifdef CONFIG_IOMMU_API
>  static struct iommu_table_group_ops spapr_tce_table_group_ops;
>  #endif
> @@ -1285,13 +1287,17 @@ static LIST_HEAD(failed_ddw_pdn_list);
>  
>  static phys_addr_t ddw_memory_hotplug_max(void)

After this change, this function only gets called from __init function.
So let's mark it as __init.

>  {
> -	resource_size_t max_addr;
> +	resource_size_t max_addr = memory_hotplug_max();
> +	struct device_node *memory;
>  
> -#if defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)
> -	max_addr = hot_add_drconf_memory_max();
> -#else
> -	max_addr = memblock_end_of_DRAM();
> -#endif
> +	for_each_node_by_type(memory, "memory") {
> +		struct resource res;
> +
> +		if (of_address_to_resource(memory, 0, &res))
> +			continue;
> +
> +		max_addr = max_t(resource_size_t, max_addr, res.end + 1);
> +	}
>  
>  	return max_addr;
>  }
> @@ -1446,7 +1452,7 @@ static struct property *ddw_property_create(const char *propname, u32 liobn, u64
>  static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mask)
>  {
>  	int len = 0, ret;
> -	int max_ram_len = order_base_2(ddw_memory_hotplug_max());
> +	int max_ram_len = order_base_2(pseries_ddw_max_ram);
>  	struct ddw_query_response query;
>  	struct ddw_create_response create;
>  	int page_shift;
> @@ -1668,7 +1674,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mas
>  
>  	if (direct_mapping) {

Outside of this patch, but I see a case where:

- pmem is present and if ddw_sz is larger than MAX_PHYSMEM_BITS, in that
case we use the direct mapping (enable_ddw()).
So IMO - that path looks a bit buggy, because we say our ddw_sz is large enough
even with vpmem but we only create TCE entries for system ram and not for
vPMEM. So say when there is a DMA to the vpmem devdax region, then we
won't find any TCE entries and that may cause EEH too right?


>  		/* DDW maps the whole partition, so enable direct DMA mapping */
> -		ret = walk_system_ram_range(0, ddw_memory_hotplug_max() >> PAGE_SHIFT,
> +		ret = walk_system_ram_range(0, pseries_ddw_max_ram >> PAGE_SHIFT,
>  					    win64->value, tce_setrange_multi_pSeriesLP_walk);
>  		if (ret) {
>  			dev_info(&dev->dev, "failed to map DMA window for %pOF: %d\n",
> @@ -2419,23 +2425,35 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
>  {
>  	struct dma_win *window;
>  	struct memory_notify *arg = data;
> +	unsigned long limit = arg->nr_pages;
> +	unsigned long max_ram_pages = pseries_ddw_max_ram >> PAGE_SHIFT;
>  	int ret = 0;
>  
>  	/* This notifier can get called when onlining persistent memory as well.
>  	 * TCEs are not pre-mapped for persistent memory. Persistent memory will
> -	 * always be above ddw_memory_hotplug_max()
> +	 * always be above pseries_ddw_max_ram
>  	 */
> +	if (arg->start_pfn >= max_ram_pages)
> +		return NOTIFY_OK;

This case is when we have pmem converted to system ram correct?

> +
> +	/* RAM is being DLPAR'ed. The range should never exceed max ram.
> +	 * Just in case, clamp the range and throw a warning.
> +	 */
> +	if (arg->start_pfn + limit > max_ram_pages) {
> +		limit = max_ram_pages - arg->start_pfn;
> +		WARN_ONCE(1, "Limiting Page Range %lx - %lx to Max Mem Pages: %lx\n",
> +					arg->start_pfn, arg->start_pfn + arg->nr_pages,
> +					max_ram_pages);
> +	}

when would this condition hit if at all? Have we seen this happening in
past anytime?

>  
>  	switch (action) {
>  	case MEM_GOING_ONLINE:
>  		spin_lock(&dma_win_list_lock);
>  		list_for_each_entry(window, &dma_win_list, list) {
> -			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
> -				ddw_memory_hotplug_max()) {
> +			if (window->direct) {
>  				ret |= tce_setrange_multi_pSeriesLP(arg->start_pfn,
> -						arg->nr_pages, window->prop);
> +						limit, window->prop);
>  			}
> -			/* XXX log error */
>  		}
>  		spin_unlock(&dma_win_list_lock);
>  		break;
> @@ -2443,12 +2461,10 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
>  	case MEM_OFFLINE:
>  		spin_lock(&dma_win_list_lock);
>  		list_for_each_entry(window, &dma_win_list, list) {
> -			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
> -				ddw_memory_hotplug_max()) {
> +			if (window->direct) {
>  				ret |= tce_clearrange_multi_pSeriesLP(arg->start_pfn,
> -						arg->nr_pages, window->prop);
> +						limit, window->prop);
>  			}
> -			/* XXX log error */
>  		}
>  		spin_unlock(&dma_win_list_lock);
>  		break;
> @@ -2532,6 +2548,14 @@ void __init iommu_init_early_pSeries(void)
>  	register_memory_notifier(&iommu_mem_nb);
>  
>  	set_pci_dma_ops(&dma_iommu_ops);
> +
> +	/* During init determine the max memory an LPAR can have and set it. This
> +	 * will be used for pre-mapping RAM in DDW. memblock_end_of_DRAM() can
> +	 * change during the running of LPAR - daxctl can add pmemory as
> +	 * "system-ram". This memory range should not be pre-mapped in DDW since
> +	 * the address of pmemory can be much higher than the DDW size.
> +	 */
> +	pseries_ddw_max_ram = ddw_memory_hotplug_max();
>  }
>  
>  static int __init disable_multitce(char *str)
>
> base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
> -- 
> 2.39.3

-ritesh

