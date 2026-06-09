Return-Path: <linuxppc-dev+bounces-22312-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED84CD8C85
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 06:38:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZK3v0XCtz2xR4;
	Tue, 09 Jun 2026 16:38:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780987098;
	cv=none; b=j81GKCv/s3aZRTs5i/ADJVj/Yjly4leVrAYXY9JSlmipsPpDxj9JtkkojUYvq0bcfHv8fxiyXJ2R2oPIFEuog9hYbtB53PVsZJvG7I9NX8XdLrlNlP8Flf4A0kTAc8Atm6Wh7WQOh0cIb6Sled8JhdKj47eZ2FJ6WE1dh/S2yBkXB4zlpBlKBS+axZRrKRD/gsiOrY7f+Hs5hEYnP8bshH3wOGSlrWAoVhULttYlIQx9Xsa1adebw/eR3uOpT843hJa/UgMAS/QRMvs/dkIaoFAmJ134K52/ALvLZJ6UtVRe/qJsAfxNmnjNNL32DQHdsWderElGderFq8rh/qx30A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780987098; c=relaxed/relaxed;
	bh=ios025aH5rxkTDf1RO8DRSO8/pX+jvxkUL7rn9r9OTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PD1PtlPsWvVuYNvA/ED9blxc1tUcQAMSGzpU2onTEZ89hSfRxOEe01zcLnOpLTTWKioKmb2NWvbK4RCDXxQEq2P90b6XmXfCfeoqtVx7XCSK9HGcaDl6/nRTzDMPFtoAs0rHn/+A54rB61qdL1vg6IJP9CwhnpdrNi6FC6QvUkkTV7pXNJu9n94uj+Ra35ciDAz3DP95vkJ3G8aJIaQDoFl6QUpaNBWwntIjK/x+hvkDRy52b5TV2tNjv+BYQ8Uyu31nFjfzx8IfRXNIJVaKo8orBkJrSM75G0UaTLRkiNyMzDKya9dDLc33hzdgHMDQDaNRuLflHxX2IbbEId/V/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BqHhev4t; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BqHhev4t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZK3s69B0z2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 16:38:16 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6592lKtS3020105
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Jun 2026 06:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ios025
	aH5rxkTDf1RO8DRSO8/pX+jvxkUL7rn9r9OTY=; b=BqHhev4twSQvTe9WHWYiyI
	BVinEO0PsF4I32DIoKUweMHxmfAFMqhoNPvQZPTdLyDV4192Sw7eIwXDkFveUs+y
	YYI5BLoBJn9UQ54sTVlfxDcynidg0A6lv+VdOV+bsNxx3ec3Q+ns75KrudVapSlo
	6hT10/8MRRGZeagUZLuXopwrfgAtdQrU4Qqy+9fHOn6/exhJTqsnZDFGg1UGRAyw
	GZxb3ZCYQ2DXqA0J45Myg3tjC76QIqprdTqo1FiFjLlFuNhfOVNGE30xGga+JVTF
	GUISapUAKlPD9MMvufLMdT9AvPB9ypegPFyqzFegi4Y9dJjw9JWyfPUrrYZeV+Kw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qjrf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 06:38:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6596YbW7026055;
	Tue, 9 Jun 2026 06:38:13 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy8gpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 06:38:13 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6596cCWj27591340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 06:38:12 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EE6F58059;
	Tue,  9 Jun 2026 06:38:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7B615805D;
	Tue,  9 Jun 2026 06:38:09 +0000 (GMT)
Received: from [9.123.5.122] (unknown [9.123.5.122])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 06:38:09 +0000 (GMT)
Message-ID: <fa19e228-c426-422a-b7f4-ac08705f3fd6@linux.ibm.com>
Date: Tue, 9 Jun 2026 12:08:08 +0530
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
Subject: Re: [PATCH v3] powerpc/pseries/iommu: Add TCEs for 16GB pages when
 RAM is pre-mapped
Content-Language: en-GB
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com,
        sbhat@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com,
        vaibhav@linux.ibm.com, donettom@linux.ibm.com
References: <20260515155143.39050-1-gbatra@linux.ibm.com>
 <f7e3e2ec-5cbc-4ccc-bbc3-ec3ddd4e8b62@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <f7e3e2ec-5cbc-4ccc-bbc3-ec3ddd4e8b62@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a27b4d6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=11UfJHsWVZ6zdE_UNG4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ag5O1trjSBK-wR5Ic8ARXoSKjbaNbSUB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA2MCBTYWx0ZWRfX7fU3Zz7Mo6cG
 +F19to0v+SUJJBLfF0lCVgTIaXrKlRl/JLFRoyFdoyA7a0JqYso8wteCUcNEGep6+YtT144qr16
 eISr7aC/2DxmJhhR/hF+nuHXgqgqMZE99635JP8iOz1B6nTV2Lq/Zp8sk+QcBWEjolYX33ILDOT
 45kiaRLq52s/ufGPkTIq/gH76w+35WV1HL1U6yL0St/WpP/RHpmBGK2H0jagTlkcsL3DvdLawne
 lOR7ypDKhOYD6/6vzeFt+X3XcaHAXFMvOL4LrhnBsVKHCOJuSqOzeMVIcfaReM5xect3SKkbOyZ
 dzOFsGTyO6WwjsJGlUCFwXW3AnIGE4h3zG8HO0CLwt5xnUh1MqtZ3FV9pazt2P/6EmtCpWAkwtY
 q/LuyRqQAa4Q+WRZdFYLLugHyyORJZ0q5IRPwB+4pM7DoKoRguY6s2keryIH8BrSRofEpFrQZY3
 GI25LRRIvLqnqoqCZaQ==
X-Proofpoint-ORIG-GUID: v7uDlwoStoBKIIJiivWcFK7b-Wh2aQ0i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090060


On 31/05/26 11:18 pm, Harsh Prateek Bora wrote:
> + Venkat
>
> Hi Gaurav,
> Would just like to confirm if it is tested with multiple iterations of 
> hotplug of RAM (DLPAR) as well?
>
> Hi Venkat,
> Could you please help validate the patch for above-mentioned scenario 
> as well?


Hi Harsh,

Thanks for looping me in on this.

I have performed DLPAR testing of memory for around 100 iterations and 
also carried out DLPAR of an adapter a few times.

I did not observe any issues during these tests.

Please let me know if any additional scenarios need to be validated.

Thanks again for cc’ing me and reaching out for this validation.

Please add, below tag.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,
Venkat.

>
> Hi Shivaprasad,
> Please share your review feedback or any additional testing scenarios 
> needed?
>
> Thanks
> Harsh
>
> On 15/05/26 9:21 pm, Gaurav Batra wrote:
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
>> V2 -> V3
>>
>> 1. Harsh: Remove R-b tags from the change log
>>
>>     Response: Incorporated changes
>>
>> 2. Harsh: Change WARN_ON() to WARN_ONCE()
>>
>>     Response: Incorporated changes
>>
>> 3. Harsh: Fix indendation
>>
>>     Response: Incorporated changes
>>
>> 4. Harsh: Replace comment with a log if limit < arg->nr_pages ?
>>
>>     Response: Doesn't seems to be needed since the WARN_ONCE() will 
>> log this
>>     scenario. I removed the comment instead.
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
>>   arch/powerpc/platforms/pseries/iommu.c | 58 ++++++++++++++++++--------
>>   1 file changed, 41 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/iommu.c 
>> b/arch/powerpc/platforms/pseries/iommu.c
>> index 3e1f915fe4f6..7bbe070006fa 100644
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
>> @@ -1285,13 +1287,17 @@ static LIST_HEAD(failed_ddw_pdn_list);
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
>> +    }
>>         return max_addr;
>>   }
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
>> @@ -2419,23 +2425,35 @@ static int iommu_mem_notifier(struct 
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
>> +        WARN_ONCE(1, "Limiting Page Range %lx - %lx to Max Mem 
>> Pages: %lx\n",
>> +                    arg->start_pfn, arg->start_pfn + arg->nr_pages,
>> +                    max_ram_pages);
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
>> -            /* XXX log error */
>>           }
>>           spin_unlock(&dma_win_list_lock);
>>           break;
>> @@ -2443,12 +2461,10 @@ static int iommu_mem_notifier(struct 
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
>> -            /* XXX log error */
>>           }
>>           spin_unlock(&dma_win_list_lock);
>>           break;
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
>

