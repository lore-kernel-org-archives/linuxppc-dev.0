Return-Path: <linuxppc-dev+bounces-18779-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B85109C02F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 14:56:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgqjc6xNvz2xcB;
	Thu, 26 Mar 2026 01:56:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774450580;
	cv=none; b=Q8WorBxmTdlVkQgbrzK3wlIAgjgEwGAjQSAsSIBI0QBZzkts+kCV8Beyg3kyx9kNCrmAFcyOLIdyMKLsmVsYVegyFgxayGjofnfCrn3A3MjuvBZL5zrW2L6w0uS5DH0g9PqXMqhj4cmaFCs5g8bbmnKSDqkraVfdH7id0dfCuSBe/DpxsNGWaNvVrGjiYhtceINk0q8daXRpxe+roVj0KDgxdfH4v8FyAoxzii2kz64DRd5tZhZuAO0ZAzm1nMTgmuQ6U9mEvZD2ASyrXjegmuaRpDY0R4fwQ4K3zFs/omLvhNoVzgoGAcara/cKyLSZNS5PVgJs9Y+WI0TXuq1Ryw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774450580; c=relaxed/relaxed;
	bh=5xhVPeMDWKI3xMon13upBC5mdBn5Z1mGbc+XZxH4Nns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+vi5f9BzyZyfBGPePJLr/1R4CrECkrqgHllzdkco1ZlNgt9wdezGCrG1WnBPQmmLr8GxRN06x9qhSugsV8RDNGAbzPtC3ijvyH6q4Uk76t+NGJ4SGDSTixsghf0BA+2puiHsYxPn417RDcCGtX/cBgL5q0+jwSPp5MkuuHp4fBrV/oa1I2pRrBCWYih/O7dXWMLIETfaCPSAkP8j48FXpFOwBdmfk/zxNgKjBNQhEVF91OvVGNCg/9Ngjz7kdw8vhWoWtT6XE4pngvTe7xG9BRfZZQU2kjlfwSR/j2to6v6bSI2G/cnJP3mfTZ09TrVfu/sFnk3dP/HClK/kXIr9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iI/M+cMH; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iI/M+cMH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgqjZ6DWDz2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 01:56:17 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P9Xrp5092005;
	Wed, 25 Mar 2026 14:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5xhVPe
	MDWKI3xMon13upBC5mdBn5Z1mGbc+XZxH4Nns=; b=iI/M+cMH60YUbGJ+eXRrBd
	WQ/Hyjhewd8KVmXfu2Fjx8HP7pYS7Ci3JgN3L0NdQOfS8mPOa/+/yB+mpU90sjWQ
	euzoEX9sNy7mCF+4k9oyvK0wb0KG1fopVy5JMPVpWzGV7JmUS6M+em9dkKySHBvU
	y0axaiW5ps7ern1yu8R4WbqCFGGtDkplA4otYiQv0NcPz+RlXRHcrsZ4ugeSKYNh
	q81IV6brKsnYPeW0YPV5RHUwe7qPHvrTbcdiEJyPrPTqI1gxHtiwlT+19zrQprvE
	1VjpXgjQ63UJ2lxe40hw+rU6TczsEwMIf0TyAQIOSVMMw13OVcnQhlAqmIxvoA7w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa0ymn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 14:56:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PBJtBU009126;
	Wed, 25 Mar 2026 14:56:11 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnpyw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 14:56:11 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PEuApd53477768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 14:56:10 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48C365805E;
	Wed, 25 Mar 2026 14:56:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25EAC58051;
	Wed, 25 Mar 2026 14:56:10 +0000 (GMT)
Received: from [9.61.251.205] (unknown [9.61.251.205])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 14:56:10 +0000 (GMT)
Message-ID: <a6b93f6d-500d-4307-a502-ce241ebe8aec@linux.ibm.com>
Date: Wed, 25 Mar 2026 09:56:09 -0500
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
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        =?UTF-8?Q?Dan_Hor=C3=A1k?=
 <dan@danny.cz>
Cc: linuxppc-dev@lists.ozlabs.org, amd-gfx@lists.freedesktop.org,
        Donet Tom <donettom@linux.ibm.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz>
 <1phlu3bs.ritesh.list@gmail.com>
 <20260315105021.667e52d4a99b154ef1e6aa34@danny.cz>
 <da93575e-92ad-4a7b-83df-1cb956bd2bc2@linux.ibm.com>
 <5x6knm5q.ritesh.list@gmail.com>
Content-Language: en-US
From: Gaurav Batra <gbatra@linux.ibm.com>
In-Reply-To: <5x6knm5q.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 2gWE4V00CCZF_jdDldHYBa-7LRBOMLD7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEwNiBTYWx0ZWRfX+jHLqdkP/aEd
 HFzMxZZ9EoyB29zvW3nLNdX4xNEd86zOpKDFqwFhwiiZWHjduhIcjs9fY+TtM5SRh8BaY7mw10H
 krSO61qrKPRVnsEBubJVOQ0h4B9vWEWYrcsfxxAbEH9Y9qbryjke/nJkXu2BYv9RQSU8cDEBNhm
 1D5gcT8w2iXzFDU49PXjC6RBMxNytEO773S+W7kQqZyrM+L2TN6G1Ha4YeEg9b3rDHyoIopcIy2
 7VAdvuiGy1GZWGxTrT9sMRZvCbntISz8jW1dxWKxpLvi2er8vp0ea90Gt/BhJoFyXzLna8X2vJX
 HcZRWYiA1pHjkK1N2SsGdbkXOF8MIT8SmUhOGMkl2NdisuMQXBTw2ydO51HV0DNHZwtr7+lGb4a
 kZRWZc0U+CNsoRkK76BiuKkLv+4hGqmADUoiH9Agf9h9up3wfz1aYBgOudmFHP5iU0eRM8Ll4Pw
 VHXL1djoYLvi0zZIOLw==
X-Proofpoint-GUID: Fso7MjbKhQa6GwkFQdNebw7patyA51yp
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c3f78c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=yeSHx0KCWZ4fTT9b9oQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250106

Hello Ritesh,

This fix needs to be re-worked. My design was to have both 
"dma_ops_bypass" and bus_dma_limit set in case of pre-mapped TCEs.

There were a lot of things to consider - a major one was "max_pfn". This 
is not just reflective of "max memory". max_pfn changes when a GPU 
memory is added, or when pmemory is converted to RAM with a DLPAR event. 
This results in max_pfn to be much higher value than the actual RAM.

This throws off dma_direct_get_required_mask().

It will be better to revert this patch and re-work.

Thanks,

Gaurav

On 3/25/26 7:12 AM, Ritesh Harjani (IBM) wrote:
> Gaurav Batra <gbatra@linux.ibm.com> writes:
>
> Hi Gaurav,
>
>> Hello Ritesh/Dan,
>>
>>
>> Here is the motivation for my patch and thoughts on the issue.
>>
>>
>> Before my patch, there were 2 scenarios to consider where, even when the
>> memory
>> was pre-mapped for DMA, coherent allocations were getting mapped from 2GB
>> default DMA Window. In case of pre-mapped memory, the allocations should
>> not be
>> directed towards 2GB default DMA window.
>>
>> 1. AMD GPU which has device DMA mask > 32 bits but less then 64 bits. In
>> this
>> case the PHB is put into Limited Addressability mode.
>>
>>      This scenario doesn't have vPMEM
>>
>> 2. Device that supports 64-bit DMA mask. The LPAR has vPMEM assigned.
>>
>>
>> In both the above scenarios, IOMMU has pre-mapped RAM from DDW (64-bit
>> PPC DMA
>> window).
>>
>>
>> Lets consider code paths for both the case, before my patch
>>
>> 1. AMD GPU
>>
>> dev->dma_ops_bypass = true
>>
>> dev->bus_dma_limit = 0
>>
>> - Here the AMD controller shows 3 functions on the PHB.
>>
>> - After the first function is probed, it sees that the memory is pre-mapped
>>     and doesn't direct DMA allocations towards 2GB default window.
>>     So, dma_go_direct() worked as expected.
>>
>> - AMD GPU driver, adds device memory to system pages. The stack is as below
>>
>> add_pages+0x118/0x130 (unreliable)
>> pagemap_range+0x404/0x5e0
>> memremap_pages+0x15c/0x3d0
>> devm_memremap_pages+0x38/0xa0
>> kgd2kfd_init_zone_device+0x110/0x210 [amdgpu]
>> amdgpu_device_ip_init+0x648/0x6d8 [amdgpu]
>> amdgpu_device_init+0xb10/0x10c0 [amdgpu]
>> amdgpu_driver_load_kms+0x2c/0xb0 [amdgpu]
>> amdgpu_pci_probe+0x2e4/0x790 [amdgpu]
>>
>> - This changed max_pfn to some high value beyond max RAM.
>>
>> - Subsequently, for each other functions on the PHB, the call to
>>     dma_go_direct() will return false which will then direct DMA
>> allocations towards
>>     2GB Default DMA window even if the memory is pre-mapped.
>>
>>      dev->dma_ops_bypass is true, dma_direct_get_required_mask() resulted
>> in large
>>      value for the mask (due to changed max_pfn) which is beyond AMD GPU
>> device DMA mask
>>
>>
>> 2. Device supports 64-bit DMA mask. The LPAR has vPMEM assigned
>>
>> dev->dma_ops_bypass = false
>> dev->bus_dma_limit = has some value depending on size of RAM (eg.
>> 0x0800001000000000)
>>
>> - Here the call to dma_go_direct() returns false since
>> dev->dma_ops_bypass = false.
>>
>>
>>
>> I crafted the solution to cover both the case. I tested today on an LPAR
>> with 7.0-rc4 and it works with AMDGPU.
>>
>> With my patch, allocations will go towards direct only when
>> dev->dma_ops_bypass = true,
>> which will be the case for "pre-mapped" RAM.
>>
>> Ritesh mentioned that this is PowerNV. I need to revisit this patch and
>> see why it is failing on PowerNV.
>> ...
>>  From the logs, I do see some issue. The log indicates
>> dev->bus_dma_limit is set to 0. This is incorrect. For pre-mapped RAM,
>> with my
>> patch, bus_dma_limit should always be set to some value.
>>
> In that case, do you think adding an extra check for dev->bus_dma_limit
> would help? I am sure you already would have thought of this and
> probably are still working to find the correct fix?
>
> +bool arch_dma_alloc_direct(struct device *dev)
> +{
> +	if (dev->dma_ops_bypass && dev->bus_dma_limit)
> +		return true;
> +
> +	return false;
> +}
> +
> +bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
> +{
> +	if (!dev->dma_ops_bypass || !dev->bus_dma_limit)
> +		return false;
> +
> +	return is_direct_handle(dev, dma_handle);
> +}
>
> <snip from Timothy>
>
>> introduced a serious regression into the kernel for a large number of
>> active users of the PowerNV platform, I would kindly ask that it be
>> reverted until it can be reworked not to break PowerNV support.  Bear
>> in mind there are other devices that are 40 bit DMA limited, and they
>> are also likely to break on Linux 7.0.
> Looks like more people are facing an issue with this now.
>
> -ritesh

