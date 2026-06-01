Return-Path: <linuxppc-dev+bounces-21821-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2804CD6E55
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 18:03:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gThf82lG2z2ysb;
	Tue, 02 Jun 2026 04:03:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780337008;
	cv=none; b=h4Ew7le3rvUqGKHwbJCwoW+e6LY2Nig6/r5Yumi0iVgrJooaItPGMrNttOfGcDHcrMQ/M89VMRfa4i4ARw6Hjk8e32t42RqU/U4HOIFvatCEqkb7wUSz/kjAlQzK5fgvcVOYzNnAkS5cvJEnfZAnFe1XZ5ZkQ1Ex40ZmmjMWQHt2yXblF9Zkj2dZOcK71cT1nuu6ucpRC70G4fSm+SG8OH0/b4yyQk4pw25fDY0EYWuUoXyqaGAwva7So75qFZ61QdCYRarp3PJlVx6FVzcPN+E3XXU+c22EtOgyAoRQA5zwRkwJYh0vLKkJkMWBhps60Hs1qUeLLqpkwcLqT2RvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780337008; c=relaxed/relaxed;
	bh=ze0THC1ORDVjGjduUvsCTxxpA9SXhn1S7QtYM25MH2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckffIgSBt7OEi55rfK1NRV5Ofyxg7ZZD3u/869vhr0LSV6tMqz/yzZaPEmquOVMbuJKgC/ZWDOjaW08EMcjfXBftm/kl+f721cyc0hJ+ynZgXqW2XrsQoPy4HVRCqbge1MmnW4mg41GqXJS8ZOehse+o3A+CU6hf8RP+3wemjAcJ1Dsb9bLh1gKaoAs8pbSlvPP7nzD7rnCozYvejfWUOF0oXR4xB+naasTi1gmhwYcBsiVpdAAPXaxMryTNZcyL5VlKFqR2lQ5lmrIQ1r/JmIX+ZpCQ8reDmDWc8uUForeG99nysxYFU4WhYL53Dy6Kf3T5gU/YhkryMLQIp55Inw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jzbVmUv3; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jzbVmUv3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gThf65z7Mz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 04:03:26 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651F7V0c1065217
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Jun 2026 18:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ze0THC
	1ORDVjGjduUvsCTxxpA9SXhn1S7QtYM25MH2g=; b=jzbVmUv3+h9VmHIpc5vB+X
	NwHHVx0MATfizBDjlsGg0xXCqEqmuiF6goKqM1o62La4G+0WAsE701uX08fsrbry
	kCj6bCRr8H8GfJ3+r3ozWwp2+2EMceMqrCpgeehgDqXS6OGRddvNRH2CGTP9stOb
	H+gSQaJJBJrgVxf1CP56LV2/w0RXXZIfA3f0IPOsX3f89gG8EeHyWDkSPbYTg/x4
	p7/HztnG2zvDTYXtVl3CWELp1kV9N3+GP/GzN8e+mTTwpNEZlwkeeZvF2ThoJ9If
	s89sXaeLRKGQtdO+C10C3SeQIanZu2Wa2D+GXEqAijzDXuBmGJIa666QQNLbMLRg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht1tbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 18:03:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651HsBBb025125;
	Mon, 1 Jun 2026 18:03:21 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegf7wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 18:03:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651I3K8d14025302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 18:03:21 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4D2158054;
	Mon,  1 Jun 2026 18:03:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6B1A58055;
	Mon,  1 Jun 2026 18:03:19 +0000 (GMT)
Received: from [9.67.109.152] (unknown [9.67.109.152])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 18:03:19 +0000 (GMT)
Message-ID: <2a1694c2-d3ed-475b-a4a6-2383d6229c3b@linux.ibm.com>
Date: Mon, 1 Jun 2026 13:03:19 -0500
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
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, maddy@linux.ibm.com,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>, sbhat@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com,
        vaibhav@linux.ibm.com, donettom@linux.ibm.com
References: <20260515155143.39050-1-gbatra@linux.ibm.com>
 <f7e3e2ec-5cbc-4ccc-bbc3-ec3ddd4e8b62@linux.ibm.com>
Content-Language: en-US
From: Gaurav Batra <gbatra@linux.ibm.com>
In-Reply-To: <f7e3e2ec-5cbc-4ccc-bbc3-ec3ddd4e8b62@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: GxaedmEukv_cHn8kMvh4pqqcxP3-6Nmz
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1dc96a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=FC4TS0sY5HBVIejZJxgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE3NCBTYWx0ZWRfXwzpNrCo6Mhhh
 ugx2Cda6SLGMNLQ7Soa2wlJ8PlBOR6oTfEUlr3leEtexEVQGH351yD+bGyFRqrWRgZK4241fAIm
 Tbl2PppIqpZC/Ic1fWK1+azD0L5d4ajNuudkn4pLVz2aHT873t2OsQEvFrhHe0TZ0WeoLmQtGBY
 LV8ns36pKIrKq7HHhBu+H35BLIBiYuzM8EjtCK4GgAqTwVfUheb436E+wMQytvzDN8RTiiIQF1P
 RUWGx6ynOqLE8wGr2Jdn5TMYWCS6fQ9sS6XgibHRnAw1ShKDLkgc2eAHw7MFjr1JID/wePxxjJr
 HauVbaCgqWbbtVO4BIYSgYczjqKpSfWMh0sw5K9E3xLM+gxn/T7FN2IHLgMkJ63hqajulnQ5VY0
 3JQ0ZG8FyLRFEb5hhTCL9kclugUp1URtTr+Kem1B8nCf7RIX8s7woqz0Nfjw+v3Heoq4UNHC+rU
 mEc5orlZFSvMnOpyXOw==
X-Proofpoint-ORIG-GUID: kPzDCkf7iUz7v9kaRyWeRaeEwH8qb9Kd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010174

Hello Harsh,


response is inline


On 5/31/26 12:48 PM, Harsh Prateek Bora wrote:
> + Venkat
>
> Hi Gaurav,
> Would just like to confirm if it is tested with multiple iterations of 
> hotplug of RAM (DLPAR) as well?
I tested the patch with both DLPAR of RAM and adapter, for 100 
iterations each.
>
> Hi Venkat,
> Could you please help validate the patch for above-mentioned scenario 
> as well?
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

