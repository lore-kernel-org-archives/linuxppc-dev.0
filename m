Return-Path: <linuxppc-dev+bounces-19121-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A73C109B495
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 04:29:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flsT24Zrcz2yfl;
	Wed, 01 Apr 2026 15:29:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775017766;
	cv=none; b=VkhnDdyqLj727viEk69GIHatX8YhSrT2lj3BQ56oYlYQvYjrByoFvGPbE5Am3WdDnMjVlGT5grcXWNEIsomLbns9mpo+SwMMKdTHSK4h86G1pvnvBcMm8ojVCvqHOf5+Z1yI598nxvXgPr8STzEWqpYblJZE7S4qRLcRXVx/uWZg5q8p3etAejU6UvDzpV5oLeFZKbLFHSkKGCg9b7l4+wt6yOesQCEf+sFXXJ6xaY+W4NXvvU6BcvtbfYr7W2FPnA35usjp6+o+CaTxBv74b79cwdwknQmFQd1fY+jUyhX7ThhHbNMrS0TdtrUpnp4p7CUFH8SeOhEC+wQVKPKPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775017766; c=relaxed/relaxed;
	bh=ydjx9Luh9uZb5KhbfCOp8RMzdAilCc3c0i9D9Edl4ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUjSFlNK9+ALInBSvmG3G+pN40trocpkXz9Q32I1MqmwLZw6QSHBNFAKV0VQHGMiPhttbmHV7z0lMdvGo7zM7j/IAjs7LOW1laUvNA+VIxK5imqBd4I6ehTnJSf8EHxJ4KWeuZ+61Yq7vFLlsT0CORqkDP1o1k/qkPengeUuQJxtkMA/WA6Y5AydzMepI0XD/ZlFFOcWfbphoSeBgoZ4PVF21XIQcRL33lUyIHA24uAj4v4PUXvBn9ZLgFQqWibGZoFdL1qhYgVW+6PUHnGywFP2pzKwdChS7RSzWNz9nISDN5WWcG17jixpPNp1xU00+KX0BZRkkbNwN4bvYLPcig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GPL/4PlC; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GPL/4PlC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flsT10JGkz2yVT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 15:29:24 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VIFJkL119453;
	Wed, 1 Apr 2026 04:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ydjx9L
	uh9uZb5KhbfCOp8RMzdAilCc3c0i9D9Edl4ts=; b=GPL/4PlCW28DlaZ+wlSAMb
	i+MNzYY4vJARScUp500+JjrUMnu+E92pndn5ab4L/eae9kK53AwozhfodbPcyFXt
	Xf4Y9qiX0PdwJLUOOB2rWWHpx+2SlsNlKP9tbRLX3TbEle9Ij+pUuDWplQIQ6q5F
	FPum2ltkkXpWBenU5FOf7a56X3wBK3yNqk95H0icgMwf2P23l9CDEkNkD0ya1VoW
	hKXbllVXdG2vdBlnJn2sYuMQHSeZ/zKJH90grz5/Jm+jlNmEkRPYar4R67muYcJV
	6N123Gz9JfnexZ7vetsaLP8LvhlDVLklmBd3igNvO8jaVW0pu4wNiGFrG+K/GgFg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms5ss7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 04:29:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6311krqR013898;
	Wed, 1 Apr 2026 04:29:10 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkm0b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 04:29:10 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6314T8j419792628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 04:29:08 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C377558059;
	Wed,  1 Apr 2026 04:29:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7BCA58058;
	Wed,  1 Apr 2026 04:29:05 +0000 (GMT)
Received: from [9.43.86.180] (unknown [9.43.86.180])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 04:29:05 +0000 (GMT)
Message-ID: <fc9d7311-312c-4ab0-8605-23cf47062da7@linux.ibm.com>
Date: Wed, 1 Apr 2026 09:59:04 +0530
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
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Gaurav Batra <gbatra@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Dan_Hor=C3=A1k?= <dan@danny.cz>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>
References: <20260331223022.47488-1-gbatra@linux.ibm.com>
 <o6k3mqwc.ritesh.list@gmail.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <o6k3mqwc.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cc9f17 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=6s5eKYM0FkCK758NQkcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAzMyBTYWx0ZWRfX8qS/v/5xCoi3
 ID6Zo//FGtgW76iN+q0ncgiiuztJc3AL2Cvc7F2GxszD4AGj6e12ubMegAkgLqujL/iBD9t6o5s
 wHsnNcJ7lGfJTgJKT5AtwpgNDjXJM7LuXQ9hqTUJv7n+ON9zMpByhXq7yDFYhPKcQyHeH8EnTBw
 riOJWuv2k1O5tiRgR8K0mKtuKCgKeKYoBxqHeN0K+0hoQZc/6T3ARBPQn2ydPE2uz98oN5/5axB
 BwrRCHz8mLBwBL+SZ9cWAuX28GqitfvDtDDLvwrA/n+rF+GnRERHMewiqfqGHv5Yhm2ozQPgLyO
 MdRF9frcIFx5XrVnUTVaA+o7jO/zbFyd+Xvg5JOU0rQ4YqvqCz8BFiMalRV7TamzyyaJl48/8tY
 rtVHclVXge5figH6hYG2rZGq4P/HfWh30ijMpooM+GmMbDrmCofdbSlTuyYkMH3KoKWtSLhsjcW
 DHU5E6nqTl2JlH0RgxQ==
X-Proofpoint-GUID: ZL9W-IgEwM9qdbmEU6yia0SM9YAEVUBe
X-Proofpoint-ORIG-GUID: pMThqyg-x3KKzK_I5uWqQEoIjcHHCagy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010033


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
I will fix the commit message changes and add it to my fixes-test
since we are at the end of -rc7 window, need to get this out soon

Maddy

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
>>   
>>   	return is_direct_handle(dev, dma_handle);
>> -- 
>>
>> I am working on testing the patch in an LPAR with AMDGPU. I will update the
>> results soon.
> This should go up, as mentioned above.
>
> -ritesh

