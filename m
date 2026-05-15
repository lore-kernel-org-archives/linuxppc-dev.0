Return-Path: <linuxppc-dev+bounces-20967-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4141ECD343F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 09:07:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gH1Y56v9kz2y8p;
	Fri, 15 May 2026 19:07:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778836025;
	cv=none; b=URKlTePdcW7Z3X1gEmzaHnGZ2WNpD6V7i/GrQ/L2sJd8KHLerPzFNd+uwZ8vXnKAARyoWAOYrYVRnq/EQXr+66xoQhiDZ3OQySWvmY0Q11GSBIoupa4v5LyJR5P+NMoYHOxLoMm8f8n1AMZXGOVPL4dBOCnagOONABJF+NODCBuhc8G2T2bzeb2VhYo1Y65c/a9Vto++JWgkxyi3AvlV8jBSOgcblZZ7UbKYyvuntt4p9uDdStx9/0gLlREiLi2VcH+JrhXLyqHJ1eTK0JVXqKuuPhK0tK9LWpTpRaFwHHY7FRCY65CUKurYHk1DvOGGywLxomIPSG8OeMidKNBmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778836025; c=relaxed/relaxed;
	bh=Y2+c/+5QGhGqD/FJcdd7cyeojVcPTAmYdEOnekStjRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWKMwDL9Op3qaSk5261fmXj6T5qk7vQZ2s5rHxagSMCWmBO2feprd0Etx0tFAbhb/yjRzqTJ2ug2nNIZt2KhQE9g7Oxrwoefcars4ZH4p1pReBn6oBElqpVNSLktVCEQLIDClx2vBu2FeVtac4/4UX28gUxE8FO/djT0Dqv3Zd28hUUhN2s6D8+Qd9MfZbIU1LZKHh+AEdzocnFIq531fLjwLekbOxu+lWBeygrDfjPZeqi4GCESws1mhPzb3k3cGGCpTtf6QcS61HgRl24BQDtWkPsPJXbnhqcQXbmz65GveMbzN1LKT0SunxPPdoFDWWXlkefWr1Vs4nB9Jqb5WA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PJeu8Oie; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PJeu8Oie;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gH1Y46c53z2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 19:07:04 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EJ7GQA4090618
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 09:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Y2+c/+
	5QGhGqD/FJcdd7cyeojVcPTAmYdEOnekStjRE=; b=PJeu8OieswfURdXBxt3euQ
	qISXDjXsuZQScxbGC37lcuHJ/utdALZOjT4xP2vp4PrhulZYR9PDtPyV2jMVNket
	P/Cg67lCfdmQy6nLEzSawlL6eIcEI3WG01NGZEVgj8ZOfLnl3VW5w2LZo9ELTn7l
	Fj0iXXRfgqN8pUL+cMD8gtyl0b6BBtws9jrsJt/VkblBtb6+jwx9Zej/En+NRJRg
	HHYSOntZBUcgpjIuD8vBrn6Qs3EKiH0kLci84rLGW21DTUkrYS3HhQqIRWe+D8GK
	ZxBvgWoLbV/0RAFzw4vFDRzcwrlLNq5bEIF0frGFzHt8tlao+qoBUpxgGzS47XYg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m93t9vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 09:07:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64F8sWeD011811;
	Fri, 15 May 2026 09:07:01 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e5m3ajfpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 09:07:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64F970vi30278396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 09:07:00 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A06F58051;
	Fri, 15 May 2026 09:07:00 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8FBD5805A;
	Fri, 15 May 2026 09:06:57 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 May 2026 09:06:57 +0000 (GMT)
Message-ID: <f6e0be64-fc54-4c36-b871-991771549b29@linux.ibm.com>
Date: Fri, 15 May 2026 14:36:56 +0530
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
Subject: Re: [PATCH v2] powerpc/pseries/iommu: Add TCEs for 16GB pages when
 RAM is pre-mapped
Content-Language: en-GB
To: Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com, sbhat@linux.ibm.com,
        vaibhav@linux.ibm.com, donettom@linux.ibm.com
References: <20260514185448.34434-1-gbatra@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260514185448.34434-1-gbatra@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: XSS_2Ywb3hXqTSQ4JoLLHIWEhp-6_3g3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA5MSBTYWx0ZWRfX3BnCBrnJ1t2u
 gvv+WBsoyxg8CIHDHJLcsmPV9QicvF0t80J39CIQSLGgiCQu8jiI6VIDd9TmtZEfvZ1dYQQ6Xpr
 Z1D9ZqsPHN7nUbs5k8VApQSuHWPPxgUernEZQDwooaYabX3FwGG0ohgPF9TlvtfF/2+AFkO3jJZ
 fee2KqJmvIpLUok8AYM6ci4TutCNYKx1Qs3Yb+Hx7DGURucbgZC10So0IrxT6HR5BDd/xvLdOB5
 UR2PSprfePEzu7byq7yYGohkauDcKSpvogrlByNwOsV3WWWnwhfx8XNP0d5TzPcbfmt8W53EADP
 CFwAEyBd/OD6DXrSm8XPWpiMiGf/41/x1gNqZnFUqom8wdPzFAEhQjiXN5/+oSSlmtmBk2qWaGC
 ttbekOf0RZtW/Z1xRNAukopHmrOQzi6owsU+BpiGiNgBTWSErlPk7CgfyVLFGDGpMOOv3PciFIF
 YXIqzQz3k97RrKUZ73A==
X-Authority-Analysis: v=2.4 cv=ZZEt8MVA c=1 sm=1 tr=0 ts=6a06e236 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VnNF1IyMAAAA:8 a=oVqp26acJU3lcOPZk5cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WH8_PBuo7WBD4AyB_lJmepCCEHQo4tgT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150091



On 15/05/26 12:24 am, Gaurav Batra wrote:
> In powerPC, if Dynamic DMA Window is big enough, RAM is pre-mapped. To
> determine the size of RAM, a PAPR+ property "ibm,lrdr-capacity" is used.
> This OF property dictates what is the max size of RAM an LPAR can have,
> including DR added memory.
> 
> In PowerPC, 16GB pages can be allocated at machine level and then
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
> The approach to fix this problem is to revert back the code changes
> introduced by the above patch and to stash away the MAX memory of an
> LPAR, including 16GB pages, at the LPAR boot time. This value is then
> used whenever TCEs are needed to be pre-mapped - enable_DDW() or,
> iommu_mem_notifier()
> 
> Fixes: 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly adds TCEs for pmemory")
> Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
> ---
> 
> Change log:
> 
> V1 -> V2
> 
> 1. Harsh: Not only start_pfn, but end_pfn also needs to be within allowed
>     range, which may require clamping arg->nr_pages if crossing the limits.
> 
>     Response: Incorporated changes.
> 
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

I think I mentioned it before also. Please avoid using tags unless 
explicitly provided by the reviewer.

> 
>   arch/powerpc/platforms/pseries/iommu.c | 56 ++++++++++++++++++--------
>   1 file changed, 40 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 3e1f915fe4f6..fdb160b72938 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -69,6 +69,8 @@ static struct iommu_table *iommu_pseries_alloc_table(int node)
>   	return tbl;
>   }
>   
> +static phys_addr_t pseries_ddw_max_ram;
> +
>   #ifdef CONFIG_IOMMU_API
>   static struct iommu_table_group_ops spapr_tce_table_group_ops;
>   #endif
> @@ -1285,15 +1287,19 @@ static LIST_HEAD(failed_ddw_pdn_list);
>   
>   static phys_addr_t ddw_memory_hotplug_max(void)
>   {
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
> +		}

Indentation needs to be corrected above and below.

>   
> -	return max_addr;
> +		return max_addr;
>   }
>   
>   /*
> @@ -1446,7 +1452,7 @@ static struct property *ddw_property_create(const char *propname, u32 liobn, u64
>   static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mask)
>   {
>   	int len = 0, ret;
> -	int max_ram_len = order_base_2(ddw_memory_hotplug_max());
> +	int max_ram_len = order_base_2(pseries_ddw_max_ram);
>   	struct ddw_query_response query;
>   	struct ddw_create_response create;
>   	int page_shift;
> @@ -1668,7 +1674,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mas
>   
>   	if (direct_mapping) {
>   		/* DDW maps the whole partition, so enable direct DMA mapping */
> -		ret = walk_system_ram_range(0, ddw_memory_hotplug_max() >> PAGE_SHIFT,
> +		ret = walk_system_ram_range(0, pseries_ddw_max_ram >> PAGE_SHIFT,
>   					    win64->value, tce_setrange_multi_pSeriesLP_walk);
>   		if (ret) {
>   			dev_info(&dev->dev, "failed to map DMA window for %pOF: %d\n",
> @@ -2419,21 +2425,32 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
>   {
>   	struct dma_win *window;
>   	struct memory_notify *arg = data;
> +	unsigned long limit = arg->nr_pages;
> +	unsigned long max_ram_pages = pseries_ddw_max_ram >> PAGE_SHIFT;
>   	int ret = 0;
>   
>   	/* This notifier can get called when onlining persistent memory as well.
>   	 * TCEs are not pre-mapped for persistent memory. Persistent memory will
> -	 * always be above ddw_memory_hotplug_max()
> +	 * always be above pseries_ddw_max_ram
>   	 */
> +	if (arg->start_pfn >= max_ram_pages)
> +		return NOTIFY_OK;
> +
> +	/* RAM is being DLPAR'ed. The range should never exceed max ram.
> +	 * Just in case, clamp the range and throw a warning.
> +	 */
> +	if (arg->start_pfn + limit > max_ram_pages) {
> +		limit = max_ram_pages - arg->start_pfn;
> +		WARN_ON(1);

WARN_ONCE with an appropriate warning message may be a better choice.

> +	}
>   
>   	switch (action) {
>   	case MEM_GOING_ONLINE:
>   		spin_lock(&dma_win_list_lock);
>   		list_for_each_entry(window, &dma_win_list, list) {
> -			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
> -				ddw_memory_hotplug_max()) {
> +			if (window->direct) {
>   				ret |= tce_setrange_multi_pSeriesLP(arg->start_pfn,
> -						arg->nr_pages, window->prop);
> +						limit, window->prop);
>   			}
>   			/* XXX log error */

Replace comment with a log if limit < arg->nr_pages ?
Similarly below as well.

>   		}
> @@ -2443,10 +2460,9 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
>   	case MEM_OFFLINE:
>   		spin_lock(&dma_win_list_lock);
>   		list_for_each_entry(window, &dma_win_list, list) {
> -			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
> -				ddw_memory_hotplug_max()) {
> +			if (window->direct) {
>   				ret |= tce_clearrange_multi_pSeriesLP(arg->start_pfn,
> -						arg->nr_pages, window->prop);
> +						limit, window->prop);
>   			}
>   			/* XXX log error */

^^^ Ditto.

Thanks
Harsh

>   		}
> @@ -2532,6 +2548,14 @@ void __init iommu_init_early_pSeries(void)
>   	register_memory_notifier(&iommu_mem_nb);
>   
>   	set_pci_dma_ops(&dma_iommu_ops);
> +
> +	/* During init determine the max memory an LPAR can have and set it. This
> +	 * will be used for pre-mapping RAM in DDW. memblock_end_of_DRAM() can
> +	 * change during the running of LPAR - daxctl can add pmemory as
> +	 * "system-ram". This memory range should not be pre-mapped in DDW since
> +	 * the address of pmemory can be much higher than the DDW size.
> +	 */
> +	pseries_ddw_max_ram = ddw_memory_hotplug_max();
>   }
>   
>   static int __init disable_multitce(char *str)
> 
> base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a


