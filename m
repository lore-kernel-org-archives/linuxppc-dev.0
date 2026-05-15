Return-Path: <linuxppc-dev+bounces-20973-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F92CD4F25
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 14:23:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gH8Zj3DNbz2xHF;
	Sat, 16 May 2026 00:23:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778855037;
	cv=none; b=cs3L2OcXF8Q8Xn41EKrPGqtoOYAkDaTd6gkZS7ROQq4sGa0SpdDVBHuvgCyANw3XFPmqUMUGh6Sgcb1Wu2ZJ/FM1n35wTsGfrIuJVXOhjYZwFaVzSVBQfMsCJWvWPHf5dtJkpG4tOcFQ2OUd1NlnTWeIU80Fi7AVbZUbLQVnSQb0sK9keK5onlIt+rIKQO0ldNKXQpoMgaDzVaU8XRVxEAZVQ4qN+u+DVSQrQnetWcNLBLClBVq0iSxZQmMavbwjgVmMn2WyJjWvH7OJye7uN30VFUVC6AHdHRI49YiHXdL5SEsXMWr9YnkK2NDyWANtuQaJz8zxZimoGkK0gV7mew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778855037; c=relaxed/relaxed;
	bh=yzQesEvREs9egVV9l23Eo3QYsNrjK/3mgi9emIziNmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbWqF7XNA5TTAOU0zHBrNvtBp1Gy26m+qlNldzKwRxSz/YS9h6pn0wTL2V3vjASXw1g8239U+hmg9pr1MBCiC004OrKvuYLPyQp/oGMQ95DrNd1VKk/5VGyQoYfL+v2HXqy+yEBGqAN2Sc47hVgm/zvhBuSypuNQ54oQv/Rite4V5JJosGt/RRicOrIHqzPT8zU2Jz64igcCLaI9oyudTDaP1QXRxJ7yKa393FLz+oSv71uQWb8okIEX9jKCd1gGcgxXxKIuZ6rQ34SS8rGeI/sGgPdvpdJKtdiytSF3xhkkuFcUv/h99rOhrJs+OI1Mky/RnQyANCcN2Laz0dCHHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LbhihxIr; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LbhihxIr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gH8Zh42Jwz2xFl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 00:23:56 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FC03rn393903
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 14:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yzQesE
	vREs9egVV9l23Eo3QYsNrjK/3mgi9emIziNmA=; b=LbhihxIrXEEc5Nec9gC9ML
	ES4DbiAExlF99GH2IG+1a9MfgBE+8Pghlt9PDddekdbHD3n5LS3zfYuCU9nAY9Fq
	EcOZBG7/wxSR+ccydiIMMlOKHAX7jYS7WPQvx4+i76H0bXM3v5/JqK3PC4AmMrO5
	3u4hA2xIdbtQM/4nPg7DKKjYnLDyqrGEeBywWVS5AkjrVgQkxfukRY4Kjq/Tcy+G
	08i6nwlFmVqx8WmuDr/UwYhIAIO72YhJtYOy2JcFPKX2nLXoqiGBLdT6us0xvlUA
	/r6O4NHPu0GwQTnYXW1U7mWiHGfNzoMWwkEJejYjyjV9WcGCxoeANpA7PEoHJmUQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m8vbm05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 14:23:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64FE98wA022607;
	Fri, 15 May 2026 14:23:53 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e5kvcuvea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 14:23:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64FENphc11141676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 14:23:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9986658056;
	Fri, 15 May 2026 14:23:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 318C55805E;
	Fri, 15 May 2026 14:23:51 +0000 (GMT)
Received: from [9.16.48.107] (unknown [9.16.48.107])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 May 2026 14:23:51 +0000 (GMT)
Message-ID: <ed054a1c-47cc-4930-9d97-c3cf7a3e4bc1@linux.ibm.com>
Date: Fri, 15 May 2026 09:23:50 -0500
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
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com, sbhat@linux.ibm.com,
        vaibhav@linux.ibm.com, donettom@linux.ibm.com
References: <20260514185448.34434-1-gbatra@linux.ibm.com>
 <f6e0be64-fc54-4c36-b871-991771549b29@linux.ibm.com>
Content-Language: en-US
From: Gaurav Batra <gbatra@linux.ibm.com>
In-Reply-To: <f6e0be64-fc54-4c36-b871-991771549b29@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: cNMIyqFTOYWZ9-kB1pMlf0Bf7FcSV6Oi
X-Authority-Analysis: v=2.4 cv=duXrzVg4 c=1 sm=1 tr=0 ts=6a072c7a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=FC4TS0sY5HBVIejZJxgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vQoYD6YPsnaEJYls1SCR6faxDvgNxerh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE0MyBTYWx0ZWRfX1nfjXAcvfY6c
 YkRCZ49wy6krYMwQjw0W9Msi7OrqUjhR2HuNSLIgJbM0zCNWhdtyhg4+oQHgD2fj+qKzs3L9h5t
 lL06ZzxIKC4qQQyq7CGK3gqzzZ/DtyuFf3tahNS/9sF6geshwFCHT5oiWLssfTSQa1opl8N7d6C
 l+u1JaSEy6UPq/18RX6dnTU5gmvI09jVZ/qotKAJjil01BdrA2+hhsjLYQTN5cRW74XhqECYydw
 Mqo5yRu3sNh9znmmAgGqaSEFXDHnKq6sY4SVN4jKUiolTKYG5rpZp8DEaa+sp7N89gcvmaC5xOj
 gLOIPtv8MLBifHNE+pmDMF5dofMgRY1Z7EiZHjwkRDTH9pVtYTfMQk7BJlfA3WEoOUUGh/ipMkW
 jU1Uc8cM6a0OktCw0rC6NO8BC4B8K9OawL9Qo2anKCQ/F5BXxFwc+Uiv27sTB1B7k0DJ8WS/Ckv
 3X/P+22WCcyPAY8F9dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150143


On 5/15/26 4:06 AM, Harsh Prateek Bora wrote:
>
>
> On 15/05/26 12:24 am, Gaurav Batra wrote:
>> In powerPC, if Dynamic DMA Window is big enough, RAM is pre-mapped. To
>> determine the size of RAM, a PAPR+ property "ibm,lrdr-capacity" is used.
>> This OF property dictates what is the max size of RAM an LPAR can have,
>> including DR added memory.
>>
>> In PowerPC, 16GB pages can be allocated at machine level and then
>> assigned to LPARs. These 16GB pages are added to LPAR memory at the time
>> of boot. The address range for these 16GB pages is above MAX RAM an LPAR
>> can have (ibm,lrdr-capacity). In the current implementation, these 16GB
>> pages are being excluded from pre-mapped TCEs. A driver can have DMA
>> buffers allocated from 16GB pages. This results in platform to raise an
>> EEH when DMA is attempted on buffers in 16GB memory range.
>>
>> commit 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly
>> adds TCEs for pmemory")
>>
>> Prior to the above patch, memblock_end_of_DRAM() was being used to
>> determine the MAX memory of an LPAR. This included 16GB pages as well.
>> The issue with using memblock_end_of_DRAM() is that when pmemory is
>> converted to RAM via daxctl command, the DDW engine will incorrectly try
>> to add TCEs for pmemory as well.
>>
>> Below is the address distribution of RAM, 16GB pages and pmemory for an
>> LPAR with max memory of 256GB, memory allocated 64GB, 2 16GB pages and
>> assigned pmemory of 8GB.
>>
>> RANGE                                 SIZE  STATE REMOVABLE BLOCK
>> 0x0000000000000000-0x0000000fffffffff  64G online       yes 0-255
>> 0x0000004000000000-0x00000047ffffffff  32G online       yes 1024-1151
>>
>> cat /sys/bus/nd/devices/region0/resource
>> 0x40100000000
>> cat /sys/bus/nd/devices/region0/size
>> 8589934592
>>
>> The approach to fix this problem is to revert back the code changes
>> introduced by the above patch and to stash away the MAX memory of an
>> LPAR, including 16GB pages, at the LPAR boot time. This value is then
>> used whenever TCEs are needed to be pre-mapped - enable_DDW() or,
>> iommu_mem_notifier()
>>
>> Fixes: 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier 
>> incorrectly adds TCEs for pmemory")
>> Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
>> ---
>>
>> Change log:
>>
>> V1 -> V2
>>
>> 1. Harsh: Not only start_pfn, but end_pfn also needs to be within 
>> allowed
>>     range, which may require clamping arg->nr_pages if crossing the 
>> limits.
>>
>>     Response: Incorporated changes.
>>
>> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>
> I think I mentioned it before also. Please avoid using tags unless 
> explicitly provided by the reviewer.
my apologies, I thought you meant to move it to "review comments 
section". I will remove them in my next version of the patch
>
>>
>>   arch/powerpc/platforms/pseries/iommu.c | 56 ++++++++++++++++++--------
>>   1 file changed, 40 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/iommu.c 
>> b/arch/powerpc/platforms/pseries/iommu.c
>> index 3e1f915fe4f6..fdb160b72938 100644
>> --- a/arch/powerpc/platforms/pseries/iommu.c
>> +++ b/arch/powerpc/platforms/pseries/iommu.c
>> @@ -69,6 +69,8 @@ static struct iommu_table 
>> *iommu_pseries_alloc_table(int node)
>>       return tbl;
>>   }
>>   +static phys_addr_t pseries_ddw_max_ram;
>> +
>>   #ifdef CONFIG_IOMMU_API
>>   static struct iommu_table_group_ops spapr_tce_table_group_ops;
>>   #endif
>> @@ -1285,15 +1287,19 @@ static LIST_HEAD(failed_ddw_pdn_list);
>>     static phys_addr_t ddw_memory_hotplug_max(void)
>>   {
>> -    resource_size_t max_addr;
>> +    resource_size_t max_addr = memory_hotplug_max();
>> +    struct device_node *memory;
>>   -#if defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)
>> -    max_addr = hot_add_drconf_memory_max();
>> -#else
>> -    max_addr = memblock_end_of_DRAM();
>> -#endif
>> +    for_each_node_by_type(memory, "memory") {
>> +        struct resource res;
>> +
>> +        if (of_address_to_resource(memory, 0, &res))
>> +            continue;
>> +
>> +        max_addr = max_t(resource_size_t, max_addr, res.end + 1);
>> +        }
>
> Indentation needs to be corrected above and below.
>
>>   -    return max_addr;
>> +        return max_addr;
>>   }
>>     /*
>> @@ -1446,7 +1452,7 @@ static struct property 
>> *ddw_property_create(const char *propname, u32 liobn, u64
>>   static bool enable_ddw(struct pci_dev *dev, struct device_node 
>> *pdn, u64 dma_mask)
>>   {
>>       int len = 0, ret;
>> -    int max_ram_len = order_base_2(ddw_memory_hotplug_max());
>> +    int max_ram_len = order_base_2(pseries_ddw_max_ram);
>>       struct ddw_query_response query;
>>       struct ddw_create_response create;
>>       int page_shift;
>> @@ -1668,7 +1674,7 @@ static bool enable_ddw(struct pci_dev *dev, 
>> struct device_node *pdn, u64 dma_mas
>>         if (direct_mapping) {
>>           /* DDW maps the whole partition, so enable direct DMA 
>> mapping */
>> -        ret = walk_system_ram_range(0, ddw_memory_hotplug_max() >> 
>> PAGE_SHIFT,
>> +        ret = walk_system_ram_range(0, pseries_ddw_max_ram >> 
>> PAGE_SHIFT,
>>                           win64->value, 
>> tce_setrange_multi_pSeriesLP_walk);
>>           if (ret) {
>>               dev_info(&dev->dev, "failed to map DMA window for %pOF: 
>> %d\n",
>> @@ -2419,21 +2425,32 @@ static int iommu_mem_notifier(struct 
>> notifier_block *nb, unsigned long action,
>>   {
>>       struct dma_win *window;
>>       struct memory_notify *arg = data;
>> +    unsigned long limit = arg->nr_pages;
>> +    unsigned long max_ram_pages = pseries_ddw_max_ram >> PAGE_SHIFT;
>>       int ret = 0;
>>         /* This notifier can get called when onlining persistent 
>> memory as well.
>>        * TCEs are not pre-mapped for persistent memory. Persistent 
>> memory will
>> -     * always be above ddw_memory_hotplug_max()
>> +     * always be above pseries_ddw_max_ram
>>        */
>> +    if (arg->start_pfn >= max_ram_pages)
>> +        return NOTIFY_OK;
>> +
>> +    /* RAM is being DLPAR'ed. The range should never exceed max ram.
>> +     * Just in case, clamp the range and throw a warning.
>> +     */
>> +    if (arg->start_pfn + limit > max_ram_pages) {
>> +        limit = max_ram_pages - arg->start_pfn;
>> +        WARN_ON(1);
>
> WARN_ONCE with an appropriate warning message may be a better choice.
>
>> +    }
>>         switch (action) {
>>       case MEM_GOING_ONLINE:
>>           spin_lock(&dma_win_list_lock);
>>           list_for_each_entry(window, &dma_win_list, list) {
>> -            if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
>> -                ddw_memory_hotplug_max()) {
>> +            if (window->direct) {
>>                   ret |= tce_setrange_multi_pSeriesLP(arg->start_pfn,
>> -                        arg->nr_pages, window->prop);
>> +                        limit, window->prop);
>>               }
>>               /* XXX log error */
>
> Replace comment with a log if limit < arg->nr_pages ?
> Similarly below as well.
>
>>           }
>> @@ -2443,10 +2460,9 @@ static int iommu_mem_notifier(struct 
>> notifier_block *nb, unsigned long action,
>>       case MEM_OFFLINE:
>>           spin_lock(&dma_win_list_lock);
>>           list_for_each_entry(window, &dma_win_list, list) {
>> -            if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
>> -                ddw_memory_hotplug_max()) {
>> +            if (window->direct) {
>>                   ret |= tce_clearrange_multi_pSeriesLP(arg->start_pfn,
>> -                        arg->nr_pages, window->prop);
>> +                        limit, window->prop);
>>               }
>>               /* XXX log error */
>
> ^^^ Ditto.
>
> Thanks
> Harsh
>
>>           }
>> @@ -2532,6 +2548,14 @@ void __init iommu_init_early_pSeries(void)
>>       register_memory_notifier(&iommu_mem_nb);
>>         set_pci_dma_ops(&dma_iommu_ops);
>> +
>> +    /* During init determine the max memory an LPAR can have and set 
>> it. This
>> +     * will be used for pre-mapping RAM in DDW. 
>> memblock_end_of_DRAM() can
>> +     * change during the running of LPAR - daxctl can add pmemory as
>> +     * "system-ram". This memory range should not be pre-mapped in 
>> DDW since
>> +     * the address of pmemory can be much higher than the DDW size.
>> +     */
>> +    pseries_ddw_max_ram = ddw_memory_hotplug_max();
>>   }
>>     static int __init disable_multitce(char *str)
>>
>> base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
>

