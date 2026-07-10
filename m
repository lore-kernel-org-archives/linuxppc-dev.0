Return-Path: <linuxppc-dev+bounces-24029-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57D3C44501
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 20:01:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxjQ83TB3z2yS4;
	Sat, 11 Jul 2026 06:01:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783713680;
	cv=none; b=h5IjgWo3J/spiJ+KvXGi+H59vGhNaoNh9vpzoZF9z3uBtO07b3L6G9NFFDGWtkAKuHbpi26O6anZl6qphRcaYmMoNMb4iCkmwNmyJ3PDginGidonQqWGll1VtRtxz1Qo3AQjHPxHTG4yFoE9bAK5ApA+7f6/DTnpikx2ICNtoDeP5xrn/D8FuiH5jTyt1AJQmrLtIcB5LdxcMwRk7OdIZrcMIlT9SH6qvvOC/HqPh0tz9dV7rl0+Mz4n5Qcv7uWOZ1v6Be8Xwg0Q3K0qQ+M0JpKsVmGjz++E35IOdYZV1n3YCVgXd9l1CXLYeP6D7BtWO/btk/iJN8WL7npQN6P3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783713680; c=relaxed/relaxed;
	bh=9NfLme4ZebC9GhFyt0D2VgczM9vtdumRFQjtnehESjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XN624905zuJ0XlsfbUdLG+2ZCQcQWExSg+T61JLO3fgAGoQ+Mxvd6PGUONOuzbGKBCcyO3kv8EGwIaj5xpV+jwUkWRzQTwI3xPVKJBO1NhhB6lc+86Zp1MVdOLbPGF6azGDxDtvK+fFlkJ+ZPGiK2Vsnm8oxm37MA5iViGM6FTvJ3+Wyr0832ARfwyJZZbbTjMurNlwPnSlXqo4nIflz0RbPC0WV5fZIUhrBY0xHAugM2BVYcB/S1gyksN6ZoO2ktLGhKqiS7r7t8fr0yMgxGhjp/mkXowSZ2vjAQvVX1Wavmcj7KXxVFCztAgje1pkaqB3HZR/ptCGzujJE17xWPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k1AqqEIr; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k1AqqEIr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxjQ73NXrz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 06:01:19 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AHINck1086005
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 20:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9NfLme
	4ZebC9GhFyt0D2VgczM9vtdumRFQjtnehESjA=; b=k1AqqEIrPLIBmTMV7wp24V
	tPD8RTyAbgGWQfHDRCBzUS2ADS2Rp4ZZfOq/DZg4ZQckzBLd67bYEQluwb++2pmD
	tk/IINW8OttZeFYuSRoLGh6a144U2I4spnwFRebLMvhy/Mv/n1SfIEU+9KopzL7r
	6zshqTy5Ul0+G7nyxNCOg4ateJrKEpzqe90dQ33J3/7e31NTwihwC/2/Bq2SHfrA
	opmAV+WsPtXHR70j0y6TLrRjNCwS5Mb3zkcEHYObXt1qUJSXuN16zI3IsID/XBaZ
	jBSHl1SwtnQ+xYsoRqdERbzHc20j7HiwYW8c3YjDjY+JtNShxBVrR6ZapkvI1lOQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke8pux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 20:01:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AJna1q022211;
	Fri, 10 Jul 2026 20:01:15 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqkw3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 20:01:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66AK1DAw26346204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 20:01:13 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C094D5805E;
	Fri, 10 Jul 2026 20:01:13 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A26E58056;
	Fri, 10 Jul 2026 20:01:13 +0000 (GMT)
Received: from [9.67.161.147] (unknown [9.67.161.147])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 20:01:12 +0000 (GMT)
Message-ID: <f16a019d-f464-4c17-b98f-c21e7c215af9@linux.ibm.com>
Date: Fri, 10 Jul 2026 15:01:12 -0500
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
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
        donettom@linux.ibm.com, harshpb@linux.ibm.com
References: <20260515155143.39050-1-gbatra@linux.ibm.com>
 <ik6qvw6j.ritesh.list@gmail.com>
Content-Language: en-US
From: Gaurav Batra <gbatra@linux.ibm.com>
In-Reply-To: <ik6qvw6j.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a514f8c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=F1Zjttk1BedhBYLBhgEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE5OSBTYWx0ZWRfX5eN+GUas09ED
 uGORw5onm+qdr+iqQOk2QU/fBMysES9BeysHVB2TasCNll61DB9/OUcYd6m1hgB0vUtARAWvvDh
 Z98QwXV01tVD4+DicSZIAeTRie8TttkMaz/IkYgpavqQ9H8xT8MRA8rzBZ/uDC6zDKcy1QnIKwC
 /wPx3DgeMXfDR2Hz3JB4i39Xngv1JAgaFFvINWBS+HIeq/EUxozoUHRzrGTQooHfCy0ailXl60W
 ZMhsSe2FBejQ8v5U/LbK0ShdtXlB9UwhWtdg7PAfXDzzsARRJ9CIeEq+Sx09BT6vaRVwemdA11B
 1njRZK33B4QSVAUzy1CxqPTq7bY91Hzh3PjDvxXNwcZ/ja+lhl/jGtldtTsI6E4m7BZKhtdt5de
 KY1F/2k/7pYnkW43ePVqaVa7/EvHmukEcSu2UQOf1R6VUfU60A+2qAUHD/+rlvWIU7vGY/zwond
 SZkEWnYmkTd8b/XD6dw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE5OSBTYWx0ZWRfXyTGmglZeQJYy
 16Emd00gcuHJpfocsGi2/aqm5ilLrj+QTxYeMX4O3fhN07TJmhnagAfvfAuewMQcaE4gw1FKu9t
 DFo7yij++fvFeP7snYbeexafCe8VqMk=
X-Proofpoint-GUID: cbVXjaSKpDJ5rHsTyy6VV8k3rWTVP5iW
X-Proofpoint-ORIG-GUID: XbqH_jD8uz9Gm_tXRPSTEbirZ9AfVa9t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100199


On 7/8/26 1:21 AM, Ritesh Harjani (IBM) wrote:
> Thanks for the changes. Added minor comments and queries.
>
> Gaurav Batra <gbatra@linux.ibm.com> writes:
>
>> In powerPC, if Dynamic DMA Window is big enough, RAM is pre-mapped. To
>> determine the size of RAM, a PAPR+ property "ibm,lrdr-capacity" is used.
>> This OF property dictates what is the max size of RAM an LPAR can have,
>> including DR added memory.
>>
>> In PowerPC, 16GB pages can be allocated at machine level and then
> This will be mostly for Hash MMU correct? Which will be P9 then?
> Is this also possible in case of P10?
> Can this 16GB pages be added via HMC? How can one test this?

Huge pages needs to be allocate at CEC level and then CEC rebooted.

After that, you can assign these huge pages to an LPAR. The LPAR needs 
to be in

hash MMU mode. Both P9 and P10 are supported.

>
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
>> RANGE                                 SIZE  STATE REMOVABLE     BLOCK
>> 0x0000000000000000-0x0000000fffffffff  64G online       yes     0-255
>> 0x0000004000000000-0x00000047ffffffff  32G online       yes 1024-1151
>>
>> cat /sys/bus/nd/devices/region0/resource
>> 0x40100000000
>> cat /sys/bus/nd/devices/region0/size
>> 8589934592
>>
> cat /proc/iomem should show the output for pmemory as well correct?

Well, it depends. If pmemory is just assigned to the LPAR, it will not 
show in /proc/iomem.

This is how is it in my LPAR

cat /sys/bus/nd/devices/region0/resource
0x40100000000

(0) root @ ltcd41-lp10: /root
# cat /sys/bus/nd/devices/region0/size
17179869184

# cat /proc/iomem
00000000-7ffffffff : System RAM
40000000000-40001ffffff : pci@80000002900c002
   40000000000-40001ffffff : c002:01:00.0
     40000000000-40001ffffff : mlx5_core
40080000000-400feffffff : pci@800000020000012
   40080000000-40087ffffff : 0012:01:00.1
     40080000000-40087ffffff : mlx5_core
   40088000000-4008fffffff : 0012:01:00.0
     40088000000-4008fffffff : mlx5_core
   40090000000-400900fffff : 0012:01:00.1
   40090100000-400901fffff : 0012:01:00.0
44000000000-47fffffffff : pci@800000020000012

So, pmemory is assigned by not shown in /proc/iomem.

Now, if I use daxctl to convert this pmemory into regular memory it will 
show in /proc/iomem

# cat /proc/iomem
00000000-7ffffffff : System RAM
40000000000-40001ffffff : pci@80000002900c002
   40000000000-40001ffffff : c002:01:00.0
     40000000000-40001ffffff : mlx5_core
40080000000-400feffffff : pci@800000020000012
   40080000000-40087ffffff : 0012:01:00.1
     40080000000-40087ffffff : mlx5_core
   40088000000-4008fffffff : 0012:01:00.0
     40088000000-4008fffffff : mlx5_core
   40090000000-400900fffff : 0012:01:00.1
   40090100000-400901fffff : 0012:01:00.0
40100000000-401009fffff : namespace0.0 <----------
40100a00000-402ffffffff : dax0.0 <--------
44000000000-47fffffffff : pci@800000020000012


>
>> The approach to fix this problem is to revert back the code changes
>> introduced by the above patch and to stash away the MAX memory of an
>> LPAR, including 16GB pages, at the LPAR boot time. This value is then
>> used whenever TCEs are needed to be pre-mapped - enable_DDW() or,
>> iommu_mem_notifier()
>>
> Was this hit in an internal testing? Is it possible to have a test
> around this please?

This was hit in one of the environments by Sypre system test. They had 2 
16GB pages created in CEC

and they assigned all the resources to just one LPAR. They were not 
aware of this configuration.

I don't have access to that LPAP any more, but, I am sure this can be 
recreated in the lab.

>
> @Venkat, did we test this specific case with and w/o this patch as well?
> Reason for my asks is - since we will be backporting this patch to older
> stable kernels, it will be good to ensure this has been properly tested
> and if possible we should even have a unit test to ensure this
> doesn't break in future.
>
>> Fixes: 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly adds TCEs for pmemory")
> This patch was made in v6.15. Since we want this to be backported, I
> would suggested add a CC stable tag as well.
Will do in my next iteration of the patch
>
>> Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
>> ---
>>
>> Change log:
>>
>> V2 -> V3
>>
>> 1. Harsh: Remove R-b tags from the change log
>>
>>     Response: Incorporated changes
>>
>> 2. Harsh: Change WARN_ON() to WARN_ONCE()
>>
>>     Response: Incorporated changes
>>
>> 3. Harsh: Fix indendation
>>
>>     Response: Incorporated changes
>>
>> 4. Harsh: Replace comment with a log if limit < arg->nr_pages ?
>>
>>     Response: Doesn't seems to be needed since the WARN_ONCE() will log this
>>     scenario. I removed the comment instead.
>>
>> V1 -> V2
>>
>> 1. Harsh: Not only start_pfn, but end_pfn also needs to be within allowed
>>     range, which may require clamping arg->nr_pages if crossing the limits.
>>
>>     Response: Incorporated changes.
>>
>>   arch/powerpc/platforms/pseries/iommu.c | 58 ++++++++++++++++++--------
>>   1 file changed, 41 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
>> index 3e1f915fe4f6..7bbe070006fa 100644
>> --- a/arch/powerpc/platforms/pseries/iommu.c
>> +++ b/arch/powerpc/platforms/pseries/iommu.c
>> @@ -69,6 +69,8 @@ static struct iommu_table *iommu_pseries_alloc_table(int node)
>>   	return tbl;
>>   }
>>   
>> +static phys_addr_t pseries_ddw_max_ram;
>> +
> Since this is only set once during init and read afterwards.. Maybe we
> should change this to __ro_after_init?
Will do
>>   #ifdef CONFIG_IOMMU_API
>>   static struct iommu_table_group_ops spapr_tce_table_group_ops;
>>   #endif
>> @@ -1285,13 +1287,17 @@ static LIST_HEAD(failed_ddw_pdn_list);
>>   
>>   static phys_addr_t ddw_memory_hotplug_max(void)
> After this change, this function only gets called from __init function.
> So let's mark it as __init.
Will do
>
>>   {
>> -	resource_size_t max_addr;
>> +	resource_size_t max_addr = memory_hotplug_max();
>> +	struct device_node *memory;
>>   
>> -#if defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)
>> -	max_addr = hot_add_drconf_memory_max();
>> -#else
>> -	max_addr = memblock_end_of_DRAM();
>> -#endif
>> +	for_each_node_by_type(memory, "memory") {
>> +		struct resource res;
>> +
>> +		if (of_address_to_resource(memory, 0, &res))
>> +			continue;
>> +
>> +		max_addr = max_t(resource_size_t, max_addr, res.end + 1);
>> +	}
>>   
>>   	return max_addr;
>>   }
>> @@ -1446,7 +1452,7 @@ static struct property *ddw_property_create(const char *propname, u32 liobn, u64
>>   static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mask)
>>   {
>>   	int len = 0, ret;
>> -	int max_ram_len = order_base_2(ddw_memory_hotplug_max());
>> +	int max_ram_len = order_base_2(pseries_ddw_max_ram);
>>   	struct ddw_query_response query;
>>   	struct ddw_create_response create;
>>   	int page_shift;
>> @@ -1668,7 +1674,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mas
>>   
>>   	if (direct_mapping) {
> Outside of this patch, but I see a case where:
>
> - pmem is present and if ddw_sz is larger than MAX_PHYSMEM_BITS, in that
> case we use the direct mapping (enable_ddw()).
> So IMO - that path looks a bit buggy, because we say our ddw_sz is large enough
> even with vpmem but we only create TCE entries for system ram and not for
> vPMEM. So say when there is a DMA to the vpmem devdax region, then we
> won't find any TCE entries and that may cause EEH too right?

In this scenario, bus_dma_limit will be set to max_ram (not including 
vpmem). Any buffers in the

devdax region will get dynamic mapping from the 2GB default window.

>
>
>>   		/* DDW maps the whole partition, so enable direct DMA mapping */
>> -		ret = walk_system_ram_range(0, ddw_memory_hotplug_max() >> PAGE_SHIFT,
>> +		ret = walk_system_ram_range(0, pseries_ddw_max_ram >> PAGE_SHIFT,
>>   					    win64->value, tce_setrange_multi_pSeriesLP_walk);
>>   		if (ret) {
>>   			dev_info(&dev->dev, "failed to map DMA window for %pOF: %d\n",
>> @@ -2419,23 +2425,35 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
>>   {
>>   	struct dma_win *window;
>>   	struct memory_notify *arg = data;
>> +	unsigned long limit = arg->nr_pages;
>> +	unsigned long max_ram_pages = pseries_ddw_max_ram >> PAGE_SHIFT;
>>   	int ret = 0;
>>   
>>   	/* This notifier can get called when onlining persistent memory as well.
>>   	 * TCEs are not pre-mapped for persistent memory. Persistent memory will
>> -	 * always be above ddw_memory_hotplug_max()
>> +	 * always be above pseries_ddw_max_ram
>>   	 */
>> +	if (arg->start_pfn >= max_ram_pages)
>> +		return NOTIFY_OK;
> This case is when we have pmem converted to system ram correct?
right
>
>> +
>> +	/* RAM is being DLPAR'ed. The range should never exceed max ram.
>> +	 * Just in case, clamp the range and throw a warning.
>> +	 */
>> +	if (arg->start_pfn + limit > max_ram_pages) {
>> +		limit = max_ram_pages - arg->start_pfn;
>> +		WARN_ONCE(1, "Limiting Page Range %lx - %lx to Max Mem Pages: %lx\n",
>> +					arg->start_pfn, arg->start_pfn + arg->nr_pages,
>> +					max_ram_pages);
>> +	}
> when would this condition hit if at all? Have we seen this happening in
> past anytime?

I don't think we will have this condition hit at all. notifier handler 
will be called during DLPAR of RAM

or, vpmem getting converted to dax. So, there is no way this will cross 
the RAM/vpmem boundary in the same

invocation of iommu_mem_notifier()

>>   
>>   	switch (action) {
>>   	case MEM_GOING_ONLINE:
>>   		spin_lock(&dma_win_list_lock);
>>   		list_for_each_entry(window, &dma_win_list, list) {
>> -			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
>> -				ddw_memory_hotplug_max()) {
>> +			if (window->direct) {
>>   				ret |= tce_setrange_multi_pSeriesLP(arg->start_pfn,
>> -						arg->nr_pages, window->prop);
>> +						limit, window->prop);
>>   			}
>> -			/* XXX log error */
>>   		}
>>   		spin_unlock(&dma_win_list_lock);
>>   		break;
>> @@ -2443,12 +2461,10 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
>>   	case MEM_OFFLINE:
>>   		spin_lock(&dma_win_list_lock);
>>   		list_for_each_entry(window, &dma_win_list, list) {
>> -			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
>> -				ddw_memory_hotplug_max()) {
>> +			if (window->direct) {
>>   				ret |= tce_clearrange_multi_pSeriesLP(arg->start_pfn,
>> -						arg->nr_pages, window->prop);
>> +						limit, window->prop);
>>   			}
>> -			/* XXX log error */
>>   		}
>>   		spin_unlock(&dma_win_list_lock);
>>   		break;
>> @@ -2532,6 +2548,14 @@ void __init iommu_init_early_pSeries(void)
>>   	register_memory_notifier(&iommu_mem_nb);
>>   
>>   	set_pci_dma_ops(&dma_iommu_ops);
>> +
>> +	/* During init determine the max memory an LPAR can have and set it. This
>> +	 * will be used for pre-mapping RAM in DDW. memblock_end_of_DRAM() can
>> +	 * change during the running of LPAR - daxctl can add pmemory as
>> +	 * "system-ram". This memory range should not be pre-mapped in DDW since
>> +	 * the address of pmemory can be much higher than the DDW size.
>> +	 */
>> +	pseries_ddw_max_ram = ddw_memory_hotplug_max();
>>   }
>>   
>>   static int __init disable_multitce(char *str)
>>
>> base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
>> -- 
>> 2.39.3
> -ritesh

