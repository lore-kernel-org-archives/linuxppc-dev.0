Return-Path: <linuxppc-dev+bounces-18276-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE96F53D9B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 21:03:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZSGx69W8z2xVT;
	Tue, 17 Mar 2026 08:03:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773694985;
	cv=none; b=T+p45smy+24wsn27/VTT8prmOCCZAsUEjON2ckYq3TgKMJ7Mz1bDwQMudlIJm3IZDLgQZ86rcYbwRGpIqfaeHQkoM2OIanpjDdjBrruIccM45+uR6IqFsNEWWLUTIPWDm2ePq6tWOgc6x+hixUiTcpfzKZwagizFj95BP5/Z+qF2sKyoK75uqLkvdvpKaNIA51iLOrElkcJImPKng7b9ELUqnCZ22Xq5znDbfz5+1dKqyboB4BODlGkj+sNlG+ku9GxUtPafG/f1wZnAfaj1jw/mHloW1lOgZvGGk8CiLtFafJ4+itJZIn2CqfIP2twRzyZtMqNLrzgGgHNXI6Ratg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773694985; c=relaxed/relaxed;
	bh=tYj+FTbKeDciaSlkJFVGvqQ6WvZQvvaTJjaCeiN3lY4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=RHRfFKvoYeiCQsuPQwC5/lmDZRGossnYa+1wIDRS7VtqJxyvbj3PJKfpKYp7b11yImDhHLJAUNvRrYaiaOFcNjbERtiw4LI+l7UXqwDoIiDy1PcMhk32vLrQvkMKi56hLqPZ+4HzaOM7kU+jDWOpRN7KAIJgQschRRuQ0xfdJz30aJhDayNtnCfCQeXYq3f/YXCEt7n6pUsDMaBKEdOZE7qskx71y/IDoTBwJu3mpEKckMWJ9rfWJjEt1bXWHp7c7NKLYiOq3f+Bl1ECASJUwMI1Yj9DQiAmi8Iogro+UhrQoyQxwkQjRzMcqUGm8DBAprSkiJSdl2QTraCmf/e1Pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ccMtjOOO; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ccMtjOOO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZSGw007Qz2xS5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 08:03:03 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GExFWt622825;
	Mon, 16 Mar 2026 21:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tYj+FTbKeDciaSlkJFVGvqQ6WvZQvv
	aTJjaCeiN3lY4=; b=ccMtjOOOCo1dEduYFTExRhlopX3L2Cp8Unr7heT0EwhxvD
	KX5JkPXrX9atM5357Wwj8axLdekrkUaf/lSyntlrsLtfTTv83hXQ8rbRz0s1LcY5
	klMW3uz07A77s7S3+Qndi7BpDz83nHRu+8LZr01B++p6uUMaRzjbdeQImDAb9ysj
	zh81vl9PVb2sRP95Vlqe1CHOKmZea2Ua4oMq4VdPiaiXD2iaZRFTfU1kJCBsIqYW
	E1SMemjD5GqNxtHvRnkamgsog10OOSE74pVT19lGxYy7m2Q7CTKV62odPESptEy1
	mAB8lR7dZS2A7DurRCMoToPAPY2l/8tC3vNQB+iw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cscrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 21:02:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GKVtU9028753;
	Mon, 16 Mar 2026 21:02:56 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk68w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 21:02:56 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GL2tEc29033144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 21:02:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D66858043;
	Mon, 16 Mar 2026 21:02:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 363DF58059;
	Mon, 16 Mar 2026 21:02:55 +0000 (GMT)
Received: from [9.61.247.28] (unknown [9.61.247.28])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 21:02:55 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------qVH0eePotoFEHbraDmtYK0KG"
Message-ID: <da93575e-92ad-4a7b-83df-1cb956bd2bc2@linux.ibm.com>
Date: Mon, 16 Mar 2026 16:02:54 -0500
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
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
To: =?UTF-8?Q?Dan_Hor=C3=A1k?= <dan@danny.cz>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, amd-gfx@lists.freedesktop.org,
        Donet Tom <donettom@linux.ibm.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz>
 <1phlu3bs.ritesh.list@gmail.com>
 <20260315105021.667e52d4a99b154ef1e6aa34@danny.cz>
Content-Language: en-US
From: Gaurav Batra <gbatra@linux.ibm.com>
In-Reply-To: <20260315105021.667e52d4a99b154ef1e6aa34@danny.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b87001 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=r77TgQKjGQsHNAKrUKIA:9 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=e5mUnYsNAAAA:8 a=pGLkceISAAAA:8
 a=qgMqNXEgndFwA8iqf38A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=u5tx-guY5AZpxSE8hFAA:9 a=gU3KwZq02wXRGdE0:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE2OCBTYWx0ZWRfXwbZWIEwQiHp7
 rgyEEa3eGEoUoPMH3BwjNo9lbc0L5agmt3mrQWfjF3nXkPR3T79p/+HdXQ8YSXgu6EpzCqet2fG
 foV0kWAIVAAExJpTFz6OuvUXrsn+VaFPQlFWHPtq6dkn5mUB6J6ZqnyDtKxdZkj8WwF+Ak5s+rv
 6k6UWd5uV5JvDzHa7qX4DRy1CNvxz3dZqLjB0xoZKpYSLGKUu+Lfuv+Vt8rrZGIRF9hkDX15sFN
 MMA5UtLzF5QTga5Wp2YUL6drUnVPzdMdjETYmOobaHiFpuDoZcHBDOTdnr2Y8Uj66QtD4LVv94a
 vOiRsDVHZJ09Zeli8vWXZIQoa7hC4NEtacouTwHRjkBWtvnEHU8oo2kGUyY08TQCaizZe/L2r0x
 /WWnT4BpPCVdT2U5TTEVn48KK09Yi1WxPb9xdfn5U7fZh9V50pioXZP27+F3o3S4YIYksoDuQjN
 eVuHCetGoayxGuEIO6g==
X-Proofpoint-GUID: ojIvxJrdipc3Fgy-PqMLQw_39WD3KUxW
X-Proofpoint-ORIG-GUID: XGfn86bUe0ubAEUwJkiI5a0lHzmFN6Jg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160168

This is a multi-part message in MIME format.
--------------qVH0eePotoFEHbraDmtYK0KG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Ritesh/Dan,


Here is the motivation for my patch and thoughts on the issue.


Before my patch, there were 2 scenarios to consider where, even when the 
memory
was pre-mapped for DMA, coherent allocations were getting mapped from 2GB
default DMA Window. In case of pre-mapped memory, the allocations should 
not be
directed towards 2GB default DMA window.

1. AMD GPU which has device DMA mask > 32 bits but less then 64 bits. In 
this
case the PHB is put into Limited Addressability mode.

    This scenario doesn't have vPMEM

2. Device that supports 64-bit DMA mask. The LPAR has vPMEM assigned.


In both the above scenarios, IOMMU has pre-mapped RAM from DDW (64-bit 
PPC DMA
window).


Lets consider code paths for both the case, before my patch

1. AMD GPU

dev->dma_ops_bypass = true

dev->bus_dma_limit = 0

- Here the AMD controller shows 3 functions on the PHB.

- After the first function is probed, it sees that the memory is pre-mapped
   and doesn't direct DMA allocations towards 2GB default window.
   So, dma_go_direct() worked as expected.

- AMD GPU driver, adds device memory to system pages. The stack is as below

add_pages+0x118/0x130 (unreliable)
pagemap_range+0x404/0x5e0
memremap_pages+0x15c/0x3d0
devm_memremap_pages+0x38/0xa0
kgd2kfd_init_zone_device+0x110/0x210 [amdgpu]
amdgpu_device_ip_init+0x648/0x6d8 [amdgpu]
amdgpu_device_init+0xb10/0x10c0 [amdgpu]
amdgpu_driver_load_kms+0x2c/0xb0 [amdgpu]
amdgpu_pci_probe+0x2e4/0x790 [amdgpu]

- This changed max_pfn to some high value beyond max RAM.

- Subsequently, for each other functions on the PHB, the call to
   dma_go_direct() will return false which will then direct DMA 
allocations towards
   2GB Default DMA window even if the memory is pre-mapped.

    dev->dma_ops_bypass is true, dma_direct_get_required_mask() resulted 
in large
    value for the mask (due to changed max_pfn) which is beyond AMD GPU 
device DMA mask


2. Device supports 64-bit DMA mask. The LPAR has vPMEM assigned

dev->dma_ops_bypass = false
dev->bus_dma_limit = has some value depending on size of RAM (eg.  
0x0800001000000000)

- Here the call to dma_go_direct() returns false since 
dev->dma_ops_bypass = false.



I crafted the solution to cover both the case. I tested today on an LPAR
with 7.0-rc4 and it works with AMDGPU.

With my patch, allocations will go towards direct only when 
dev->dma_ops_bypass = true,
which will be the case for "pre-mapped" RAM.

Ritesh mentioned that this is PowerNV. I need to revisit this patch and 
see why it
is failing on PowerNV. From the logs, I do see some issue. The log indicates
dev->bus_dma_limit is set to 0. This is incorrect. For pre-mapped RAM, 
with my
patch, bus_dma_limit should always be set to some value.

bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 
64-bit OK but direct DMA is limited by *0*

Thanks,

Gaurav

On 3/15/26 4:50 AM, Dan Horák wrote:
> Hi Ritesh,
>
> On Sun, 15 Mar 2026 09:55:11 +0530
> Ritesh Harjani (IBM)<ritesh.list@gmail.com> wrote:
>
>> Dan Horák<dan@danny.cz> writes:
>>
>> +cc Gaurav,
>>
>>> Hi,
>>>
>>> starting with 7.0-rc1 (meaning 6.19 is OK) the amdgpu driver fails to
>>> initialize on my Linux/ppc64le Power9 based system (with Radeon Pro WX4100)
>>> with the following in the log
>>>
>>> ...
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
>>                    ^^^^
>> So looks like this is a PowerNV (Power9) machine.
> correct :-)
>   
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Detected VRAM RAM=4096M, BAR=4096M
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] RAM width 128bits GDDR5
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  4096M of VRAM memory ready
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  32570M of GTT memory ready.
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Debug VRAM access will use slowpath MM access
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] GART: num cpu pages 4096, num gpu pages 65536
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF80000).
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) create WB bo failed
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_wb_init failed -12
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_ip_init failed
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: Fatal error during GPU init
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: finishing device.
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: probe with driver amdgpu failed with error -12
>>> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  ttm finalized
>>> ...
>>>
>>> After some hints from Alex and bisecting and other investigation I have
>>> found thathttps://github.com/torvalds/linux/commit/1471c517cf7dae1a6342fb821d8ed501af956dd0
>>> is the culprit and reverting it makes amdgpu load (and work) again.
>> Thanks for confirming this. Yes, this was recently added [1]
>>
>> [1]:https://lore.kernel.org/linuxppc-dev/20251107161105.85999-1-gbatra@linux.ibm.com/ 
>>
>>
>> @Gaurav,
>>
>> I am not too familiar with the area, however looking at the logs shared
>> by Dan, it looks like we might be always going for dma direct allocation
>> path and maybe the device doesn't support this address limit.
>>
>>   bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
>>   bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
> a complete kernel log is at
> https://gitlab.freedesktop.org/-/project/4522/uploads/c4935bca6f37bbd06bb4045c07d00b5b/kernel.log
>
> Please let me know if you need more info.
>
>
> 		Dan
>
>   
>> Looking at the code..
>>
>> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>> index fe7472f13b10..d5743b3c3ab3 100644
>> --- a/kernel/dma/mapping.c
>> +++ b/kernel/dma/mapping.c
>> @@ -654,7 +654,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>>   	/* let the implementation decide on the zone to allocate from: */
>>   	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
>>   
>> -	if (dma_alloc_direct(dev, ops)) {
>> +	if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
>>   		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
>>   	} else if (use_dma_iommu(dev)) {
>>   		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);
>>
>> Now, do we need arch_dma_alloc_direct() here? It always returns true if
>> dev->dma_ops_bypass is set to true, w/o checking for checks that
>> dma_go_direct() has.
>>
>> whereas...
>>
>> /*
>>   * Check if the devices uses a direct mapping for streaming DMA operations.
>>   * This allows IOMMU drivers to set a bypass mode if the DMA mask is large
>>   * enough.
>>   */
>> static inline bool
>> dma_alloc_direct(struct device *dev, const struct dma_map_ops *ops)
>> ..dma_go_direct(dev, dev->coherent_dma_mask, ops);
>> ....  ...
>>        #ifdef CONFIG_DMA_OPS_BYPASS
>>            if (dev->dma_ops_bypass)
>>                return min_not_zero(mask, dev->bus_dma_limit) >=
>>                        dma_direct_get_required_mask(dev);
>>        #endif
>>
>> dma_alloc_direct() already checks for dma_ops_bypass and also if
>> dev->coherent_dma_mask >= dma_direct_get_required_mask(). So...
>>
>> .... Do we really need the machinary of arch_dma_{alloc|free}_direct()?
>> Isn't dma_alloc_direct() checks sufficient?
>>
>> Thoughts?
>>
>> -ritesh
>>
>>
>>> for the record, I have originally openedhttps://gitlab.freedesktop.org/drm/amd/-/issues/5039
>>>
>>>
>>> 	With regards,
>>>
>>> 		Dan
--------------qVH0eePotoFEHbraDmtYK0KG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hello Ritesh/Dan,</p>
    <p><br>
    </p>
    <p>Here is the motivation for my patch and thoughts on the issue. </p>
    <p><br>
    </p>
    <p>Before my patch, there were 2 scenarios to consider where, even
      when the memory<br>
      was pre-mapped for DMA, coherent allocations were getting mapped
      from 2GB<br>
      default DMA Window. In case of pre-mapped memory, the allocations
      should not be<br>
      directed towards 2GB default DMA window.<br>
      <br>
      1. AMD GPU which has device DMA mask &gt; 32 bits but less then 64
      bits. In this<br>
      case the PHB is put into Limited Addressability mode.<br>
        <br>
         This scenario doesn't have vPMEM<br>
        <br>
      2. Device that supports 64-bit DMA mask. The LPAR has vPMEM
      assigned.<br>
      <br>
        <br>
      In both the above scenarios, IOMMU has pre-mapped RAM from DDW
      (64-bit PPC DMA<br>
      window).<br>
        <br>
      <br>
      Lets consider code paths for both the case, before my patch<br>
      <br>
      1. AMD GPU<br>
          <br>
      dev-&gt;dma_ops_bypass = true<br>
              <br>
      dev-&gt;bus_dma_limit = 0<br>
              <br>
      - Here the AMD controller shows 3 functions on the PHB.<br>
      <br>
      - After the first function is probed, it sees that the memory is
      pre-mapped<br>
        and doesn't direct DMA allocations towards 2GB default window.<br>
        So, dma_go_direct() worked as expected.<br>
              <br>
      - AMD GPU driver, adds device memory to system pages. The stack is
      as below<br>
              <br>
      add_pages+0x118/0x130 (unreliable)<br>
      pagemap_range+0x404/0x5e0<br>
      memremap_pages+0x15c/0x3d0<br>
      devm_memremap_pages+0x38/0xa0<br>
      kgd2kfd_init_zone_device+0x110/0x210 [amdgpu]<br>
      amdgpu_device_ip_init+0x648/0x6d8 [amdgpu]<br>
      amdgpu_device_init+0xb10/0x10c0 [amdgpu]<br>
      amdgpu_driver_load_kms+0x2c/0xb0 [amdgpu]<br>
      amdgpu_pci_probe+0x2e4/0x790 [amdgpu]<br>
      <br>
      - This changed max_pfn to some high value beyond max RAM.<br>
      <br>
      - Subsequently, for each other functions on the PHB, the call to<br>
        dma_go_direct() will return false which will then direct DMA
      allocations towards<br>
        2GB Default DMA window even if the memory is pre-mapped.<br>
        <br>
         dev-&gt;dma_ops_bypass is true, dma_direct_get_required_mask()
      resulted in large<br>
         value for the mask (due to changed max_pfn) which is beyond AMD
      GPU device DMA mask<br>
      <br>
          <br>
      2. Device supports 64-bit DMA mask. The LPAR has vPMEM assigned<br>
      <br>
      dev-&gt;dma_ops_bypass = false<br>
      dev-&gt;bus_dma_limit = has some value depending on size of RAM
      (eg.  0x0800001000000000)<br>
        <br>
      - Here the call to dma_go_direct() returns false since
      dev-&gt;dma_ops_bypass = false.<br>
        <br>
      <br>
        <br>
      I crafted the solution to cover both the case. I tested today on
      an LPAR<br>
      with 7.0-rc4 and it works with AMDGPU.<br>
      <br>
      With my patch, allocations will go towards direct only when
      dev-&gt;dma_ops_bypass = true,<br>
      which will be the case for "pre-mapped" RAM.<br>
      <br>
      Ritesh mentioned that this is PowerNV. I need to revisit this
      patch and see why it<br>
      is failing on PowerNV. From the logs, I do see some issue. The log
      indicates<br>
      dev-&gt;bus_dma_limit is set to 0. This is incorrect. For
      pre-mapped RAM, with my<br>
      patch, bus_dma_limit should always be set to some value.<br>
      <br>
      bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu:
      64-bit OK but direct DMA is limited by <b>0</b><br>
           </p>
    <p>Thanks,</p>
    <p>Gaurav</p>
    <div class="moz-cite-prefix">On 3/15/26 4:50 AM, Dan Horák wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20260315105021.667e52d4a99b154ef1e6aa34@danny.cz">
      <pre wrap="" class="moz-quote-pre">Hi Ritesh,

On Sun, 15 Mar 2026 09:55:11 +0530
Ritesh Harjani (IBM) <a class="moz-txt-link-rfc2396E" href="mailto:ritesh.list@gmail.com">&lt;ritesh.list@gmail.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Dan Horák <a class="moz-txt-link-rfc2396E" href="mailto:dan@danny.cz">&lt;dan@danny.cz&gt;</a> writes:

+cc Gaurav,

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Hi,

starting with 7.0-rc1 (meaning 6.19 is OK) the amdgpu driver fails to
initialize on my Linux/ppc64le Power9 based system (with Radeon Pro WX4100)
with the following in the log

...
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
                  ^^^^
So looks like this is a PowerNV (Power9) machine.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
correct :-)
 
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Detected VRAM RAM=4096M, BAR=4096M
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] RAM width 128bits GDDR5
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  4096M of VRAM memory ready
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  32570M of GTT memory ready.
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Debug VRAM access will use slowpath MM access
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] GART: num cpu pages 4096, num gpu pages 65536
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF80000).
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) create WB bo failed
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_wb_init failed -12
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_ip_init failed
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: Fatal error during GPU init
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: finishing device.
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: probe with driver amdgpu failed with error -12
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  ttm finalized
...

After some hints from Alex and bisecting and other investigation I have
found that <a class="moz-txt-link-freetext" href="https://github.com/torvalds/linux/commit/1471c517cf7dae1a6342fb821d8ed501af956dd0">https://github.com/torvalds/linux/commit/1471c517cf7dae1a6342fb821d8ed501af956dd0</a>
is the culprit and reverting it makes amdgpu load (and work) again.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Thanks for confirming this. Yes, this was recently added [1]

[1]: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/linuxppc-dev/20251107161105.85999-1-gbatra@linux.ibm.com/">https://lore.kernel.org/linuxppc-dev/20251107161105.85999-1-gbatra@linux.ibm.com/</a> 


@Gaurav,

I am not too familiar with the area, however looking at the logs shared
by Dan, it looks like we might be always going for dma direct allocation
path and maybe the device doesn't support this address limit. 

 bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
 bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
a complete kernel log is at
<a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/-/project/4522/uploads/c4935bca6f37bbd06bb4045c07d00b5b/kernel.log">https://gitlab.freedesktop.org/-/project/4522/uploads/c4935bca6f37bbd06bb4045c07d00b5b/kernel.log</a>

Please let me know if you need more info.


		Dan

 
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Looking at the code..

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index fe7472f13b10..d5743b3c3ab3 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -654,7 +654,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	/* let the implementation decide on the zone to allocate from: */
 	flag &amp;= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
-	if (dma_alloc_direct(dev, ops)) {
+	if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
 		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
 	} else if (use_dma_iommu(dev)) {
 		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);

Now, do we need arch_dma_alloc_direct() here? It always returns true if
dev-&gt;dma_ops_bypass is set to true, w/o checking for checks that
dma_go_direct() has.

whereas...

/*
 * Check if the devices uses a direct mapping for streaming DMA operations.
 * This allows IOMMU drivers to set a bypass mode if the DMA mask is large
 * enough.
 */
static inline bool
dma_alloc_direct(struct device *dev, const struct dma_map_ops *ops)
..dma_go_direct(dev, dev-&gt;coherent_dma_mask, ops);
....  ...
      #ifdef CONFIG_DMA_OPS_BYPASS
          if (dev-&gt;dma_ops_bypass)
              return min_not_zero(mask, dev-&gt;bus_dma_limit) &gt;=
                      dma_direct_get_required_mask(dev);
      #endif

dma_alloc_direct() already checks for dma_ops_bypass and also if
dev-&gt;coherent_dma_mask &gt;= dma_direct_get_required_mask(). So...

.... Do we really need the machinary of arch_dma_{alloc|free}_direct()?
Isn't dma_alloc_direct() checks sufficient?

Thoughts?

-ritesh


</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
for the record, I have originally opened <a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/issues/5039">https://gitlab.freedesktop.org/drm/amd/-/issues/5039</a>


	With regards,

		Dan
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------qVH0eePotoFEHbraDmtYK0KG--


