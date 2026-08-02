Return-Path: <linuxppc-dev+bounces-25207-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8772FC55162
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2026 16:52:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hCm741grbz2yN8;
	Mon, 03 Aug 2026 02:52:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785689520;
	cv=none; b=diTYCWzfMXutKLRUmu0a+t1Q4sdbfMAUo2FQsriYjaAkEmFk29J6IGM1B18Go/pSTVX8Pc4SClQOmUxNVhVL/B5HYphpV+yyBo28XYKMVXmm0y3PkWqEtye4osPULdoKIVSHPY/c8bf6wXxQI1nIdNoP9gD3AFS4Qw9Zw6El8AjnIkoSrMUAP1X+ywNe223LV9iC/H3sck5UN34nPQZGA5esxeSCJnMxO8j/OgeaCrN113PShlc5ZYsKCPLBCUeEOLfcH+dEtA9agQ0qnOkcz+PsSWA1wYPIveEbqcS6RC3NHlsWJHUg3Pblw0OAurMl603Ld9/EOGInL4RejWlvjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785689520; c=relaxed/relaxed;
	bh=Xf3Z9IRZ/3NgJy38KN45MpbbbE4RTU8qIVQ7DeUTHcs=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Ttpl1weAeNy0jB+MivA1AxAHW9oX2JHWluBKZGzeDNbofiYmtWHHQzk4LXUyTvx0A79iS5JwZMS7OWbxu3rRcHrClN4d3UgCl/Nd3JnQyyCaocBbzevU9IxWPB3Pk74XB2/FGmsJLTvROdIkcmujDIBWN0QTaZE9yiF5RPHcEiy8Gg1fD3nxiYWnQfebBxazJ6R5wUpsBO9CIfiPxKa1pjyr268qq4RDdwTpyxgP++Cy+BMDArE4bbacgcdZOi49F3zxyW9gleadJx9G3SWRQEjb4dU0WH/cW8xlyvTbIuUuE/yJSHZwEJPqu9tzQ+WrQQPCHqurZMMNsGh5mCqlEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O9/JtOux; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O9/JtOux;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hCm726R2Fz2yh4
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 02:51:58 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672EmgWG1750577;
	Sun, 2 Aug 2026 16:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Xf3Z9IRZ/3NgJy38KN45MpbbbE4RTU
	8qIVQ7DeUTHcs=; b=O9/JtOuxFPuqCy5qwES5naGPw2seHPSTr6wyzU+/R2mFwR
	pUsB/zTgVTSzi5/f+8cRST/UtsX5uXLs7Soj94WYSGWJMcKngPo/lbVwOgSm6UFS
	9DnpuxIivW33Izka93fO0MNPhLqTVIJ3u7Kef1tYb4sEAgFFNdLedfmX1flsw5Ba
	3PXbU6jf1lSQlhPWvYfCSqBr06MK9OJ70DvJQXSO5mbDZwAC1DfBTN9lRQsk69Rd
	zyHQKHsRrMKFMCLynJWDi3AZuYoO8LxdCqOerHV2vR6znzKSZI4o1oN+mlBB5cV6
	/0ZOGe7SbQ2Jh/lQG5fV6IOWFCW/D07qsLZ9+EqQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqd0v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 16:51:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 672GfdFQ003060;
	Sun, 2 Aug 2026 16:51:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg1u2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 16:51:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 672Gprsp19399266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Aug 2026 16:51:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAC7558058;
	Sun,  2 Aug 2026 16:51:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E326D58057;
	Sun,  2 Aug 2026 16:51:52 +0000 (GMT)
Received: from [9.67.176.62] (unknown [9.67.176.62])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  2 Aug 2026 16:51:52 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------dukfeNUgyTyWP7kFBsWM6RD9"
Message-ID: <db0911c1-0be3-4b8e-be0a-ea02a76cf122@linux.ibm.com>
Date: Sun, 2 Aug 2026 11:51:52 -0500
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
Subject: Re: [PATCH v4] powerpc/pseries/iommu: Add TCEs for 16GB pages when
 RAM is pre-mapped
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
        donettom@linux.ibm.com, harshpb@linux.ibm.com, stable@vger.kernel.org
References: <20260727221437.89644-1-gbatra@linux.ibm.com>
 <a4r9mf8r.ritesh.list@gmail.com>
Content-Language: en-US
From: Gaurav Batra <gbatra@linux.ibm.com>
In-Reply-To: <a4r9mf8r.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: N4shGSdrF2EGbHCcrlWk7TIE3PRLEMt3
X-Proofpoint-ORIG-GUID: ibhVoy8tytAPbYxNY8f7TmKQKTT21O3p
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfX+uadqn7zTmq1
 G4qPJ6oazeenNg7mDs0Mp/FrYpE3MWO0QGOhkYb3BEWRukTQD97UCPw+N3EwhhhfDILxSumGSBU
 7OFft27NnD924hc5bdfoK5O8sHwIfD4=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a6f75ac cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=SSguSjWRoSmyEpdDFXsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pGLkceISAAAA:8 a=TbstS9boakCHb6G_jFcA:9 a=D5FF8RfyP7Mpnois:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=MI8xIAbEOuIY_LT7l7ut:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfX6nOtLbK/3Cx+
 IC8RED6/5ufP4mn+VmCOsVW74wo6dF005DOOPZNoRhkKu2MoEO2C3hiWZleOopn/WIS4aIjdXOY
 KSR/iBF8WHXzCFOAh1wOqHP9rk3Yq9sPY5th2Af+Eb7jZ9XnoiI8C7H28Ua88eaMbZfdq0AXHXn
 P4+0eFu+Z9X66B8K1F+3DgpUpzoymn4pn9V06EdVc6h+e8EiGyjg8HoZvjbB9wibarwSdfis68L
 cKuY6GSD/FMEFa0yhWDN6aXlyrJcU7KFDEvpA8dQbroyo1NoFwQ/h/sc7MVhQsPnnDWk7Ti1T0C
 4JgfYXpn1S3ArUUrSG4pTynbplyQcA+0imb9NUYwevNrXjLEbWlIMaHNTE4Z4mo7JFMeAJodiFH
 rw52stbeWs7w6uJdqvDDxY7Yy3oX/fASWrr8MYE2FloMsMSdHRSs3vx503FcdT29oPbAI/DQK3l
 /IrL8k5sZIrbLyNykhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020153

This is a multi-part message in MIME format.
--------------dukfeNUgyTyWP7kFBsWM6RD9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Ritesh,

Please check my responses inline.

- Gaurav

On 7/29/26 8:35 PM, Ritesh Harjani (IBM) wrote:
> Hi Gaurav,
>
> Gaurav Batra<gbatra@linux.ibm.com> writes:
>
>> In powerPC, if Dynamic DMA Window is big enough, RAM is pre-mapped. To
>> determine the size of RAM, a PAPR+ property "ibm,lrdr-capacity" is used.
>> This OF property dictates what is the max size of RAM an LPAR can have,
>> including DR added memory.
>>
>> In PowerPC, 16GB pages can be allocated at machine level and then
>> assigned to LPARs. These 16GB pages are added to LPAR memory at the time
>> of boot. The address range for these 16GB pages is above MAX RAM an LPAR
>> can have (ibm,lrdr-capacity). In the current implementation, these 16GB
> So these 16GB pages must be apperaing as "memory" nodes, because that's
> how the code must be detecting them above "ibm,lrdr-capacity"?
> Do you have the device node example for the same?
yes, these 16GB pages appear as memory node right after the max-memory 
possible
for the LPAR. Here are the properties from the device tree for a case 
where LPAR
min/desired/max is 256GB/512GB/2048GB

memory@20000000000:
ibm,expected#pages
                  00000000
ibm,phandle      80002000
device_type      "memory"
reg              00000200 00000000 00000004 00000000
phandle          00cdd850 (13490256)
name             "memory"
ibm,associativity
                  00000004 00000000 00000001 00000006 0000000c

memory@20400000000:
ibm,expected#pages
                  00000000
ibm,phandle      80002040
device_type      "memory"
reg              00000204 00000000 00000004 00000000
phandle          00cdda38 (13490744)
name             "memory"
ibm,associativity
                  00000004 00000000 00000001 00000007 0000000e


This LPAR has 2 16GB pages addigned to it and so, there are 2 16GB nodes
presented to the LPAR.
>
>
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
> Is there any formal placement contract in the PAPR which tells where
> would PMEM appear in the logical real address range for LPAR?
I went through the PAPR for placement requirements for pmemory but, 
didn't see anything.
I was able to get access to a machine which has 8TB of memory. I checked 
the
placement of pmemory with various memory settings and 2 16GB of pages. 
Size of
pmemory assigned to the LPAR is 8GB.

mem     256/512/2048    (min/desired/max)

[root@ltcmcka1n-lp1 ~]# lsmem
RANGE                                  SIZE  STATE REMOVABLE  BLOCK
0x0000000000000000-0x0000007fffffffff  512G online       yes 0-2047
0x0000020000000000-0x00000207ffffffff   32G online       yes 8192-8319

[root@ltcmcka1n-lp1 ~]# cat /sys/bus/nd/devices/region0/resource
0x40010000000   <=====  pmemory placement above 4TB


mem     256/512/4096

[root@ltcmcka1n-lp1 ~]# lsmem
RANGE                                  SIZE  STATE REMOVABLE  BLOCK
0x0000000000000000-0x0000007fffffffff  512G online       yes 0-2047
0x0000040000000000-0x00000407ffffffff   32G online       yes 16384-16511

[root@ltcmcka1n-lp1 ~]# cat /sys/bus/nd/devices/region0/resource
0x80010000000   <===== 8TB


mem     256/512/6144

[root@ltcmcka1n-lp1 ~]# lsmem
RANGE                                  SIZE  STATE REMOVABLE  BLOCK
0x0000000000000000-0x0000007fffffffff  512G online       yes 0-2047
0x0000060000000000-0x00000607ffffffff   32G online       yes 24576-24703

[root@ltcmcka1n-lp1 ~]# cat /sys/bus/nd/devices/region0/resource
0x80010000000   <===== 8TB


In all these cases, pmemory was assigned to above power-of-2 which included
memory + 16GB pages.
>
>> The approach to fix this problem is to revert back the code changes
>> introduced by the above patch and to stash away the MAX memory of an
>> LPAR, including 16GB pages, at the LPAR boot time. This value is then
>> used whenever TCEs are needed to be pre-mapped - enable_DDW() or,
>> iommu_mem_notifier()
> So, can it appear for e.g. in above case from 288G to 512G? In your
> example we see pmem coming at 4TB, but what if the system DRAM was above
> 4TB? In that case, could vPMEM appear at non-power-of-2 address just
> above ibm,lrdr-capacity+16G?
>
> The reason for the ask is, I see a small window where we don't have any
> direct pre-mappings, but we do allow for core dma mapping apis to use the
> direct-mapping window.
>
> Here...
>
> In the current code we check for:
>
> @@ -2419,23 +2425,35 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
>   {
> +	unsigned long max_ram_pages = pseries_ddw_max_ram >> PAGE_SHIFT;
>   	int ret = 0;
> <...>
> +	if (arg->start_pfn >= max_ram_pages)
> +		return NOTIFY_OK;
>
> & but in enable_ddw() {
>      <...>
> 	int max_ram_len = order_base_2(pseries_ddw_max_ram);
>      <...>
> 	/* For pre-mapped memory, set bus_dma_limit to the max RAM */
> 	if (direct_mapping)
> 		dev->dev.bus_dma_limit = dev->dev.archdata.dma_offset +
> 						(1ULL << max_ram_len);
>
> So, we don't pre-map anything above pseries_ddw_max_ram in the
> iommu_notifier() but we allow for dma_mapping to use direct map until
> order_base_2(pseries_ddw_max_ram).
> So it looks like that, there is a small gap left in direct_mapping
> window for e.g. in above case between 288G to 512G (because of
> order_base_2()), where there are no pre-mapped TCE entries but if the
> PMEM is added within that range, then we do allow to use the
> direct-mapping path (due to bus_dma_limit) - which means an EEH could
> occur.
>
> Could you please check this claim?

Now, as per PAPR, when an OS is making an RTAS call to create DDW, the size
of the DDW needs to be power-of-2. But, I didn't see any such 
requirement for
the placement of pmemory. Even though, in my experiment above, pmemory 
was always given
a region above power-of-2 of (RAM + 16GB), I think, we cannot assume 
that will be the
case all the time. It could be different for different configurations.

As you correctly pointed out in the enable_ddw() code, this could lead 
to EEH if
pmemory is assigned to the same power-of-2 chunk as (RAM + 16GB pages).

It would be better to set device bus_dma_limit to pseries_ddw_max_ram 
and *not*

max_ram_pages, which in this case is the size of the DDW.

I will fix this in my next version of the patch. Please let me know if you have any
other concerns. I will incorporate all those changes in the next version of the patch.

Thanks a lot for spending time and checking this code in deep.

>
> -ritesh
>
>
>> Fixes: 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly adds TCEs for pmemory")
>> Cc:stable@vger.kernel.org
>> Signed-off-by: Gaurav Batra<gbatra@linux.ibm.com>
>> ---
>>
>> Change log:
>>
>> V3 -> V4
>>
>> 1. Ritesh: Change pseries_ddw_max_ram to __ro_after_init;
>>
>>     Response: Incorporated changes
>>
>> 2. Ritesh: Mark function ddw_memory_hotplug_max() as __init function
>>
>>     Response: Incorporated changes
>>
>> 3. Ritesh: This patch was made in v6.15. Since we want this to be backported, I
>>     would suggested add a CC stable tag as well.
>>
>>     Response: Incorporated changes
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
>>
>>   arch/powerpc/platforms/pseries/iommu.c | 60 ++++++++++++++++++--------
>>   1 file changed, 42 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
>> index 3e1f915fe4f6..7f63adafaf91 100644
>> --- a/arch/powerpc/platforms/pseries/iommu.c
>> +++ b/arch/powerpc/platforms/pseries/iommu.c
>> @@ -69,6 +69,8 @@ static struct iommu_table *iommu_pseries_alloc_table(int node)
>>   	return tbl;
>>   }
>>   
>> +static phys_addr_t pseries_ddw_max_ram __ro_after_init;
>> +
>>   #ifdef CONFIG_IOMMU_API
>>   static struct iommu_table_group_ops spapr_tce_table_group_ops;
>>   #endif
>> @@ -1283,15 +1285,19 @@ struct failed_ddw_pdn {
>>   
>>   static LIST_HEAD(failed_ddw_pdn_list);
>>   
>> -static phys_addr_t ddw_memory_hotplug_max(void)
>> +static phys_addr_t __init ddw_memory_hotplug_max(void)
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

--------------dukfeNUgyTyWP7kFBsWM6RD9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Hello Ritesh,<br>
    <br>
    Please check my responses inline.<br>
    <br>
    - Gaurav<br>
    <br>
    <div class="moz-cite-prefix">On 7/29/26 8:35 PM, Ritesh Harjani
      (IBM) wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a4r9mf8r.ritesh.list@gmail.com">
      <pre wrap="" class="moz-quote-pre">Hi Gaurav,

Gaurav Batra <a class="moz-txt-link-rfc2396E" href="mailto:gbatra@linux.ibm.com">&lt;gbatra@linux.ibm.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">In powerPC, if Dynamic DMA Window is big enough, RAM is pre-mapped. To
determine the size of RAM, a PAPR+ property "ibm,lrdr-capacity" is used.
This OF property dictates what is the max size of RAM an LPAR can have,
including DR added memory.

In PowerPC, 16GB pages can be allocated at machine level and then
assigned to LPARs. These 16GB pages are added to LPAR memory at the time
of boot. The address range for these 16GB pages is above MAX RAM an LPAR
can have (ibm,lrdr-capacity). In the current implementation, these 16GB
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
So these 16GB pages must be apperaing as "memory" nodes, because that's
how the code must be detecting them above "ibm,lrdr-capacity"?
Do you have the device node example for the same?</pre>
    </blockquote>
    yes, these 16GB pages appear as memory node right after the
    max-memory possible<br>
    for the LPAR. Here are the properties from the device tree for a
    case where LPAR<br>
    min/desired/max is 256GB/512GB/2048GB<br>
    <br>
    memory@20000000000:<br>
    ibm,expected#pages<br>
                     00000000<br>
    ibm,phandle      80002000<br>
    device_type      "memory"<br>
    reg              00000200 00000000 00000004 00000000<br>
    phandle          00cdd850 (13490256)<br>
    name             "memory"<br>
    ibm,associativity<br>
                     00000004 00000000 00000001 00000006 0000000c<br>
    <br>
    memory@20400000000:<br>
    ibm,expected#pages<br>
                     00000000<br>
    ibm,phandle      80002040<br>
    device_type      "memory"<br>
    reg              00000204 00000000 00000004 00000000<br>
    phandle          00cdda38 (13490744)<br>
    name             "memory"<br>
    ibm,associativity<br>
                     00000004 00000000 00000001 00000007 0000000e<br>
    <br>
    <br>
    This LPAR has 2 16GB pages addigned to it and so, there are 2 16GB
    nodes <br>
    presented to the LPAR.
    <blockquote type="cite" cite="mid:a4r9mf8r.ritesh.list@gmail.com">
      <pre wrap="" class="moz-quote-pre">


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">pages are being excluded from pre-mapped TCEs. A driver can have DMA
buffers allocated from 16GB pages. This results in platform to raise an
EEH when DMA is attempted on buffers in 16GB memory range.

commit 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly
adds TCEs for pmemory")

Prior to the above patch, memblock_end_of_DRAM() was being used to
determine the MAX memory of an LPAR. This included 16GB pages as well.
The issue with using memblock_end_of_DRAM() is that when pmemory is
converted to RAM via daxctl command, the DDW engine will incorrectly try
to add TCEs for pmemory as well.

Below is the address distribution of RAM, 16GB pages and pmemory for an
LPAR with max memory of 256GB, memory allocated 64GB, 2 16GB pages and
assigned pmemory of 8GB.

RANGE                                 SIZE  STATE REMOVABLE     BLOCK
0x0000000000000000-0x0000000fffffffff  64G online       yes     0-255
0x0000004000000000-0x00000047ffffffff  32G online       yes 1024-1151

cat /sys/bus/nd/devices/region0/resource
0x40100000000
cat /sys/bus/nd/devices/region0/size
8589934592
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Is there any formal placement contract in the PAPR which tells where
would PMEM appear in the logical real address range for LPAR?</pre>
    </blockquote>
    I went through the PAPR for placement requirements for pmemory but,
    didn't see anything.<br>
    I was able to get access to a machine which has 8TB of memory. I
    checked the <br>
    placement of pmemory with various memory settings and 2 16GB of
    pages. Size of<br>
    pmemory assigned to the LPAR is 8GB.<br>
    <br>
    mem     256/512/2048    (min/desired/max)<br>
    <br>
    [root@ltcmcka1n-lp1 ~]# lsmem<br>
    RANGE                                  SIZE  STATE REMOVABLE   
     BLOCK<br>
    0x0000000000000000-0x0000007fffffffff  512G online       yes   
    0-2047<br>
    0x0000020000000000-0x00000207ffffffff   32G online       yes
    8192-8319<br>
    <br>
    [root@ltcmcka1n-lp1 ~]# cat /sys/bus/nd/devices/region0/resource<br>
    0x40010000000   &lt;=====  pmemory placement above 4TB<br>
      <br>
    <br>
    mem     256/512/4096 <br>
    <br>
    [root@ltcmcka1n-lp1 ~]# lsmem<br>
    RANGE                                  SIZE  STATE REMOVABLE     
     BLOCK<br>
    0x0000000000000000-0x0000007fffffffff  512G online       yes     
    0-2047<br>
    0x0000040000000000-0x00000407ffffffff   32G online       yes
    16384-16511<br>
        <br>
    [root@ltcmcka1n-lp1 ~]# cat /sys/bus/nd/devices/region0/resource<br>
    0x80010000000   &lt;===== 8TB<br>
      <br>
      <br>
    mem     256/512/6144<br>
    <br>
    [root@ltcmcka1n-lp1 ~]# lsmem<br>
    RANGE                                  SIZE  STATE REMOVABLE     
     BLOCK<br>
    0x0000000000000000-0x0000007fffffffff  512G online       yes     
    0-2047<br>
    0x0000060000000000-0x00000607ffffffff   32G online       yes
    24576-24703<br>
    <br>
    [root@ltcmcka1n-lp1 ~]# cat /sys/bus/nd/devices/region0/resource<br>
    0x80010000000   &lt;===== 8TB<br>
    <br>
    <br>
    In all these cases, pmemory was assigned to above power-of-2 which
    included <br>
    memory + 16GB pages.
    <blockquote type="cite" cite="mid:a4r9mf8r.ritesh.list@gmail.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
The approach to fix this problem is to revert back the code changes
introduced by the above patch and to stash away the MAX memory of an
LPAR, including 16GB pages, at the LPAR boot time. This value is then
used whenever TCEs are needed to be pre-mapped - enable_DDW() or,
iommu_mem_notifier()
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
So, can it appear for e.g. in above case from 288G to 512G? In your
example we see pmem coming at 4TB, but what if the system DRAM was above
4TB? In that case, could vPMEM appear at non-power-of-2 address just
above ibm,lrdr-capacity+16G?

The reason for the ask is, I see a small window where we don't have any
direct pre-mappings, but we do allow for core dma mapping apis to use the
direct-mapping window.

Here...

In the current code we check for:

@@ -2419,23 +2425,35 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
 {
+	unsigned long max_ram_pages = pseries_ddw_max_ram &gt;&gt; PAGE_SHIFT;
 	int ret = 0;
&lt;...&gt; 
+	if (arg-&gt;start_pfn &gt;= max_ram_pages)
+		return NOTIFY_OK;

&amp; but in enable_ddw() {
    &lt;...&gt;
	int max_ram_len = order_base_2(pseries_ddw_max_ram);
    &lt;...&gt;
	/* For pre-mapped memory, set bus_dma_limit to the max RAM */
	if (direct_mapping)
		dev-&gt;dev.bus_dma_limit = dev-&gt;dev.archdata.dma_offset +
						(1ULL &lt;&lt; max_ram_len);

So, we don't pre-map anything above pseries_ddw_max_ram in the
iommu_notifier() but we allow for dma_mapping to use direct map until
order_base_2(pseries_ddw_max_ram). 
So it looks like that, there is a small gap left in direct_mapping
window for e.g. in above case between 288G to 512G (because of
order_base_2()), where there are no pre-mapped TCE entries but if the
PMEM is added within that range, then we do allow to use the
direct-mapping path (due to bus_dma_limit) - which means an EEH could
occur.

Could you please check this claim?</pre>
    </blockquote>
    <br>
    Now, as per PAPR, when an OS is making an RTAS call to create DDW,
    the size<br>
    of the DDW needs to be power-of-2. But, I didn't see any such
    requirement for <br>
    the placement of pmemory. Even though, in my experiment above,
    pmemory was always given<br>
    a region above power-of-2 of (RAM + 16GB), I think, we cannot assume
    that will be the<br>
    case all the time. It could be different for different
    configurations.<br>
    <br>
    As you correctly pointed out in the enable_ddw() code, this could
    lead to EEH if<br>
    pmemory is assigned to the same power-of-2 chunk as (RAM + 16GB
    pages).<br>
    <br>
    It would be better to set device bus_dma_limit to <span
    style="white-space: pre-wrap">pseries_ddw_max_ram and *not*
</span>
    <pre wrap="" class="moz-quote-pre">max_ram_pages, which in this case is the size of the DDW. 

I will fix this in my next version of the patch. Please let me know if you have any
other concerns. I will incorporate all those changes in the next version of the patch.

Thanks a lot for spending time and checking this code in deep.</pre>
    <blockquote type="cite" cite="mid:a4r9mf8r.ritesh.list@gmail.com">
      <pre wrap="" class="moz-quote-pre">

-ritesh


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Fixes: 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly adds TCEs for pmemory")
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
Signed-off-by: Gaurav Batra <a class="moz-txt-link-rfc2396E" href="mailto:gbatra@linux.ibm.com">&lt;gbatra@linux.ibm.com&gt;</a>
---

Change log:

V3 -&gt; V4

1. Ritesh: Change pseries_ddw_max_ram to __ro_after_init;

   Response: Incorporated changes

2. Ritesh: Mark function ddw_memory_hotplug_max() as __init function

   Response: Incorporated changes

3. Ritesh: This patch was made in v6.15. Since we want this to be backported, I
   would suggested add a CC stable tag as well.

   Response: Incorporated changes

V2 -&gt; V3

1. Harsh: Remove R-b tags from the change log

   Response: Incorporated changes

2. Harsh: Change WARN_ON() to WARN_ONCE()

   Response: Incorporated changes

3. Harsh: Fix indendation

   Response: Incorporated changes

4. Harsh: Replace comment with a log if limit &lt; arg-&gt;nr_pages ? 

   Response: Doesn't seems to be needed since the WARN_ONCE() will log this
   scenario. I removed the comment instead.

V1 -&gt; V2

1. Harsh: Not only start_pfn, but end_pfn also needs to be within allowed
   range, which may require clamping arg-&gt;nr_pages if crossing the limits.

   Response: Incorporated changes.


 arch/powerpc/platforms/pseries/iommu.c | 60 ++++++++++++++++++--------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 3e1f915fe4f6..7f63adafaf91 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -69,6 +69,8 @@ static struct iommu_table *iommu_pseries_alloc_table(int node)
 	return tbl;
 }
 
+static phys_addr_t pseries_ddw_max_ram __ro_after_init;
+
 #ifdef CONFIG_IOMMU_API
 static struct iommu_table_group_ops spapr_tce_table_group_ops;
 #endif
@@ -1283,15 +1285,19 @@ struct failed_ddw_pdn {
 
 static LIST_HEAD(failed_ddw_pdn_list);
 
-static phys_addr_t ddw_memory_hotplug_max(void)
+static phys_addr_t __init ddw_memory_hotplug_max(void)
 {
-	resource_size_t max_addr;
+	resource_size_t max_addr = memory_hotplug_max();
+	struct device_node *memory;
 
-#if defined(CONFIG_NUMA) &amp;&amp; defined(CONFIG_MEMORY_HOTPLUG)
-	max_addr = hot_add_drconf_memory_max();
-#else
-	max_addr = memblock_end_of_DRAM();
-#endif
+	for_each_node_by_type(memory, "memory") {
+		struct resource res;
+
+		if (of_address_to_resource(memory, 0, &amp;res))
+			continue;
+
+		max_addr = max_t(resource_size_t, max_addr, res.end + 1);
+	}
 
 	return max_addr;
 }
@@ -1446,7 +1452,7 @@ static struct property *ddw_property_create(const char *propname, u32 liobn, u64
 static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mask)
 {
 	int len = 0, ret;
-	int max_ram_len = order_base_2(ddw_memory_hotplug_max());
+	int max_ram_len = order_base_2(pseries_ddw_max_ram);
 	struct ddw_query_response query;
 	struct ddw_create_response create;
 	int page_shift;
@@ -1668,7 +1674,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mas
 
 	if (direct_mapping) {
 		/* DDW maps the whole partition, so enable direct DMA mapping */
-		ret = walk_system_ram_range(0, ddw_memory_hotplug_max() &gt;&gt; PAGE_SHIFT,
+		ret = walk_system_ram_range(0, pseries_ddw_max_ram &gt;&gt; PAGE_SHIFT,
 					    win64-&gt;value, tce_setrange_multi_pSeriesLP_walk);
 		if (ret) {
 			dev_info(&amp;dev-&gt;dev, "failed to map DMA window for %pOF: %d\n",
@@ -2419,23 +2425,35 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
 {
 	struct dma_win *window;
 	struct memory_notify *arg = data;
+	unsigned long limit = arg-&gt;nr_pages;
+	unsigned long max_ram_pages = pseries_ddw_max_ram &gt;&gt; PAGE_SHIFT;
 	int ret = 0;
 
 	/* This notifier can get called when onlining persistent memory as well.
 	 * TCEs are not pre-mapped for persistent memory. Persistent memory will
-	 * always be above ddw_memory_hotplug_max()
+	 * always be above pseries_ddw_max_ram
 	 */
+	if (arg-&gt;start_pfn &gt;= max_ram_pages)
+		return NOTIFY_OK;
+
+	/* RAM is being DLPAR'ed. The range should never exceed max ram.
+	 * Just in case, clamp the range and throw a warning.
+	 */
+	if (arg-&gt;start_pfn + limit &gt; max_ram_pages) {
+		limit = max_ram_pages - arg-&gt;start_pfn;
+		WARN_ONCE(1, "Limiting Page Range %lx - %lx to Max Mem Pages: %lx\n",
+					arg-&gt;start_pfn, arg-&gt;start_pfn + arg-&gt;nr_pages,
+					max_ram_pages);
+	}
 
 	switch (action) {
 	case MEM_GOING_ONLINE:
 		spin_lock(&amp;dma_win_list_lock);
 		list_for_each_entry(window, &amp;dma_win_list, list) {
-			if (window-&gt;direct &amp;&amp; (arg-&gt;start_pfn &lt;&lt; PAGE_SHIFT) &lt;
-				ddw_memory_hotplug_max()) {
+			if (window-&gt;direct) {
 				ret |= tce_setrange_multi_pSeriesLP(arg-&gt;start_pfn,
-						arg-&gt;nr_pages, window-&gt;prop);
+						limit, window-&gt;prop);
 			}
-			/* XXX log error */
 		}
 		spin_unlock(&amp;dma_win_list_lock);
 		break;
@@ -2443,12 +2461,10 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
 	case MEM_OFFLINE:
 		spin_lock(&amp;dma_win_list_lock);
 		list_for_each_entry(window, &amp;dma_win_list, list) {
-			if (window-&gt;direct &amp;&amp; (arg-&gt;start_pfn &lt;&lt; PAGE_SHIFT) &lt;
-				ddw_memory_hotplug_max()) {
+			if (window-&gt;direct) {
 				ret |= tce_clearrange_multi_pSeriesLP(arg-&gt;start_pfn,
-						arg-&gt;nr_pages, window-&gt;prop);
+						limit, window-&gt;prop);
 			}
-			/* XXX log error */
 		}
 		spin_unlock(&amp;dma_win_list_lock);
 		break;
@@ -2532,6 +2548,14 @@ void __init iommu_init_early_pSeries(void)
 	register_memory_notifier(&amp;iommu_mem_nb);
 
 	set_pci_dma_ops(&amp;dma_iommu_ops);
+
+	/* During init determine the max memory an LPAR can have and set it. This
+	 * will be used for pre-mapping RAM in DDW. memblock_end_of_DRAM() can
+	 * change during the running of LPAR - daxctl can add pmemory as
+	 * "system-ram". This memory range should not be pre-mapped in DDW since
+	 * the address of pmemory can be much higher than the DDW size.
+	 */
+	pseries_ddw_max_ram = ddw_memory_hotplug_max();
 }
 
 static int __init disable_multitce(char *str)

base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
-- 
2.39.3
</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------dukfeNUgyTyWP7kFBsWM6RD9--


