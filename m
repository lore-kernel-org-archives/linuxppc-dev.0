Return-Path: <linuxppc-dev+bounces-19305-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3649AE88D79
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 03:53:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnhX76Dmcz2yL8;
	Sat, 04 Apr 2026 14:53:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775274807;
	cv=none; b=CjhX5lOVnGeDS+nE/+UyFvBUxYTUFCzd7Tieb52PDHdHTwchzB3bUl2pZo4tS2oxbLpgDt5AXCTFnPtO+ypPPzMxjM/BzGMo7NsW9DtDeQo03Wut8mWBNv1q11T9O38P3SOUuTSUA1hYTa1SSvKNlD6tf6qrw68LRrUhSWyjRpVGeO8hrmWh6gYdweC6XTqXBJUmW9g5hV0SDd8wufEP0n73E7UymGRpgs/ykg3kjrzYkguZiJpOQREuXvA5Nv/VANz/x5GjqiTfGlKDT1QnfBCO1byuaj1F3mxnHFKEVZKeV9XfPouO6koK7pkz2FTj30DfzbKrvBMdjxF6rfdCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775274807; c=relaxed/relaxed;
	bh=f47cv8eJ2vAWPqWOjgcHGI9ehOdzsd6V72e/yqDS4mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJYcwEtfoNTppc67qYp6HwBaMVsGSNRkCVJYwCy6kODuUyi7GtJqLt1AIy3CSpkssfywYj4wovynF7O1mgIBkaQ68Ij5lQcXVPz+RQMHVySnIDTRbFWOMFg60TcyNMtJpBuAjvQFqbqUrYRHPKraXTPrlQ0G6MDVRDgP+2NSUK72/sKLcQ20yNdaBqlpAHHMXHqEZNZKzK0voPvr/EagsXCkcMIIBwv3dXdoNZO0BOrhZbp+FkFN0pTQOxDejpERYa0Jj19I0Mmfr3BEgk9Df9G0zd8YX5gltBCWuj1FsvMvEMqn1+YkLxHsTnEjBdH9I6/LdvwwZkKrLn+5pf31Cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jo6PsDjY; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jo6PsDjY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnhX615FTz2xQr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 14:53:25 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6342xNPm3075880;
	Sat, 4 Apr 2026 03:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f47cv8
	eJ2vAWPqWOjgcHGI9ehOdzsd6V72e/yqDS4mg=; b=jo6PsDjYNbtdaZdg4aifzb
	z72EhHbDVgQIeBehVxCg0Bqlgw/DxG4f1myFBuvwXwq8MdOod5Th0V9raRR6JQXq
	D13OSrp8avsDdSxiz4V8TarOTamqbiexu++2JZNu5VVPrnnkFnaER9DWGXKYt+av
	CLqt5jmrL76yJqg0jRKcwXutEvJ3fF0Afjl0SzJj67qkwwlSXVvG6r4wmWemEWHL
	yqxJKncImHm6pXNFYjAbGu5bxYQqpdbJwMiHNE2UmnyRxvzioUEXwiYNYqMmDft2
	1cCZ4CLMY66VFQ28oqNfqK6RHhUsE/5W+khSK+BPENdNF8K3Kfn3JgIg6cPWIBKA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datap03e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 03:53:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6342VaND008732;
	Sat, 4 Apr 2026 03:53:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v1205am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 03:53:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6343rDc815204696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 Apr 2026 03:53:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8C2A20040;
	Sat,  4 Apr 2026 03:53:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED4A420043;
	Sat,  4 Apr 2026 03:53:08 +0000 (GMT)
Received: from [9.124.211.17] (unknown [9.124.211.17])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  4 Apr 2026 03:53:08 +0000 (GMT)
Message-ID: <1bfca7b8-58f6-4670-b0ac-f448ae22bd43@linux.ibm.com>
Date: Sat, 4 Apr 2026 09:23:07 +0530
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
Subject: Re: [PATCH] powerpc/powernv/iommu: iommu incorrectly bypass DMA APIs
To: Gaurav Batra <gbatra@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Dan_Hor=C3=A1k?= <dan@danny.cz>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        vaibhav@linux.ibm.com, balbirs@nvidia.com
References: <20260331223022.47488-1-gbatra@linux.ibm.com>
 <o6k3mqwc.ritesh.list@gmail.com>
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <o6k3mqwc.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Bp+QAIX5 c=1 sm=1 tr=0 ts=69d08b2e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=Ikd4Dj_1AAAA:8
 a=40Wu3GLdS-AkG9vhGqcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDAyOSBTYWx0ZWRfX0waeVr8e4dU8
 m7D3oWcUFndjhT/cvsSpCy0/KDC3wzc/13MQYtI4LCxVxXSxTs4BC63EZt2SCwbPJ0MBmd3S+Ve
 OdH+g2n5va2UnWuodtlI1gSMRtF+ahduHsMTBEKfLnOriGI8pSyVg6qqodkoHsh6Soj2d7A1pQp
 7OhegQnBFjzu9OOjl4MTiMH+emCgRoUzZuocd2nqRsqEqoAfZWbYh9wYE6nQI/FZflLwH7doWAX
 FvvGy5V5LWE571BUVXO0d+mywhCTWS1seozlMtjVVvSsa1AGyGlOJuzeWPG0r3JRXwbY4rzsh6i
 +x/pzx/y1Am1dHoKWqEr1bHeTwH+BNCUxS1XAunQk1lUClBeAfbLfIh9n5ojOreWwDJfsoCeKZ+
 Dan1hsGoZS79HPZ1sgOAok5ECPPnRv/9H3mmdHgCPKCXErR2RI9xCxjZzp2OBoAgN5VQmawsPr/
 eh78V3C94YJlQgSnzgg==
X-Proofpoint-GUID: pt4PlvLC926CnHID0gLGLaN7mtF31glh
X-Proofpoint-ORIG-GUID: if1hMCpsJxuJgRKshqsHYKn0KAqrZYIB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040029

On 4/1/26 6:35 AM, Ritesh Harjani (IBM) wrote:
> ++CC few people who would be interested in this fix.
>
> Gaurav Batra <gbatra@linux.ibm.com> writes:
>
>> In a PowerNV environment, for devices that supports DMA mask less than
>> 64 bit but larger than 32 bits, iommu is incorrectly bypassing DMA
>> APIs while allocating and mapping buffers for DMA operations.
>>
>> Devices are failing with ENOMEN during probe with the following messages
>>
>> amdgpu 0000:01:00.0: [drm] Detected VRAM RAM=4096M, BAR=4096M
>> amdgpu 0000:01:00.0: [drm] RAM width 128bits GDDR5
>> amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
>> amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
>> amdgpu 0000:01:00.0:  4096M of VRAM memory ready
>> amdgpu 0000:01:00.0:  32570M of GTT memory ready.
>> amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
>> amdgpu 0000:01:00.0: [drm] Debug VRAM access will use slowpath MM access
>> amdgpu 0000:01:00.0: [drm] GART: num cpu pages 4096, num gpu pages 65536
>> amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF80000).
>> amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
>> amdgpu 0000:01:00.0: (-12) create WB bo failed
>> amdgpu 0000:01:00.0: amdgpu_device_wb_init failed -12
>> amdgpu 0000:01:00.0: amdgpu_device_ip_init failed
>> amdgpu 0000:01:00.0: Fatal error during GPU init
>> amdgpu 0000:01:00.0: finishing device.
>> amdgpu 0000:01:00.0: probe with driver amdgpu failed with error -12
>> amdgpu 0000:01:00.0:  ttm finalized
>>
>> Fixes: 1471c517cf7d ("powerpc/iommu: bypass DMA APIs for coherent allocations for pre-mapped memory")
>> Reported-by: Dan Horák <dan@danny.cz>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5039
> We could even add the lore link so that in future people can find the
> discussion.
> Closes: https://lore.kernel.org/linuxppc-dev/20260313142351.609bc4c3efe1184f64ca5f44@danny.cz/
>
>> Tested-by: Dan Horak <dan@danny.cz>
>> Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
> Feel free to change this to the following, I mainly only suggested the fix :)
>
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
>
>> Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
>> ---
> Generally this info...
>> I am working on testing the patch in an LPAR with AMDGPU. I will update the
>> results soon.
> ... goes below the three dashes in here ^^^
> This is the same place where people also update the patch change log.
>
> But sure, thanks for updating. As for this patch, it looks good to me.
> So, feel free to add:
>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
>
>>   arch/powerpc/kernel/dma-iommu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
>> index 73e10bd4d56d..8b4de508d2eb 100644
>> --- a/arch/powerpc/kernel/dma-iommu.c
>> +++ b/arch/powerpc/kernel/dma-iommu.c
>> @@ -67,7 +67,7 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
>>   }
>>   bool arch_dma_alloc_direct(struct device *dev)
>>   {
>> -	if (dev->dma_ops_bypass)
>> +	if (dev->dma_ops_bypass && dev->bus_dma_limit)
>>   		return true;
>>   
>>   	return false;
>> @@ -75,7 +75,7 @@ bool arch_dma_alloc_direct(struct device *dev)
>>   
>>   bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
>>   {
>> -	if (!dev->dma_ops_bypass)
>> +	if (!dev->dma_ops_bypass || !dev->bus_dma_limit)
>>   		return false;


While this works, looking more on why the 1471c517cf7dae needed 
arch_dma_[alloc|free]_direct()

functions was because dev->bus_dma_limit being not updated when the new 
memory pages were

getting added in add_pages() case leading to the can_map_direct() checks 
failing later when needed.

Looks like these functions were modeled after 
arch_dma_[map|unmap]_phys_direct() which were

introduced for handing a similar need.


Do we get iommu_mem_notifier() call for action MEM_GOING_ONLINE in 
device memory being

made online case? If yes, we can just update the bus_dma_limit for each 
device in the iommu

group to include the new max_pfn. This makes it sound wrong as the pages 
though configured

as system memory, are still  device private and the memory notifiers are 
for the real memory

hotplug/unplug cases.


In the commit 7170130e4c below, Balibir does point this out to be a 
problem and prevents updating

max_pfn for device private memory. He has mentioned it to be considered 
for PPC too.

The dma_addressing_limited() of x86 is same as PPC can_map_direct() and 
we know why

arch_dma_[alloc|free]_direct() would not be needed anymore.


commit 7170130e4c72ce0caa0cb42a1627c635cc262821
Author: Balbir Singh <balbirs@nvidia.com>
Date:   Tue Apr 1 11:07:52 2025 +1100

     x86/mm/init: Handle the special case of device private pages in 
add_pages(), to not increase max_pfn and trigger 
dma_addressing_limited() bounce buffers

So, I think we need to bring the changes from 7170130e4c72ce0c into PPC.


With that, the original hunk setting the bypass unconditionally in 
1471c517cf7dae can be

changed like below, and remove the redundant 
arch_dma_[alloc|free]_direct() functions.


diff --git a/arch/powerpc/kernel/dma-iommu.c 
b/arch/powerpc/kernel/dma-iommu.c
index aa3689d61917..120800b962cf 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -150,7 +150,7 @@ int dma_iommu_dma_supported(struct device *dev, u64 
mask)
                  * 1:1 mapping but it is somehow limited.
                  * ibm,pmemory is one example.
                  */
-               dev->dma_ops_bypass = dev->bus_dma_limit == 0;
+               dev->dma_ops_bypass = (dev->bus_dma_limit == 0) || 
(min_not_zero(mask, dev->bus_dma_limit) >= 
dma_direct_get_required_mask(dev));
                 if (!dev->dma_ops_bypass)
                         dev_warn(dev,
                                  "iommu: 64-bit OK but direct DMA is 
limited by %llx\n",

Suggested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>


Thanks,

Shivaprasad


