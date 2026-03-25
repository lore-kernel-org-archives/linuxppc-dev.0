Return-Path: <linuxppc-dev+bounces-18782-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC81109C036
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 16:29:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgsmh5MkPz2xSX;
	Thu, 26 Mar 2026 03:29:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774456148;
	cv=none; b=mkEV1A+/T/i49mWjPWbm149G5fITjh35TOE/1ydIz9PnK0d+5udfP7aHtvihRcP3zQt2gf4YoA09w244asP33GSdO6C3TwhbfNQC0C+2EDyC9omIB6T/kmEOCiJZRAzLyu0UXlQRB/UnsD9xl+wOXtIMqc/hViI+f3dsRYwpeuuhcysELppUaBt4CPmCRP0H+yFQj8R3lIizrEC6zOjOBoVMa7qm32Gaz4afK+81DPi02HfGHDOgw70yDaYT+PQsmEYnpJNj9KSjacEVBMa0veOHB3wkctiPN4uzxZxwOo2ARCi9+UvSIAyj5p8wYmGw73G+sNqh/yz9VaJ8uobFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774456148; c=relaxed/relaxed;
	bh=aBOnqBWEL2czgyDz2xU9T9LWfdDwG1t2YQ0ArASBwpg=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=ehBEl5Bxu5mDfqcQJwL6n+56LxuH2CBs/GYINSL8oV7IoIIKVRXPOB1Ydpf1XF7vhCo446S+tcoySsL3pQ4fnpV+d7bjj4Klh+2U1Zd6DM7s/5PAvzDDileErH1e1GiKXKBV0CYW6mxqhWiuxpP+YtvMblaFL9xBku7o/aOmHAnqRwBOwi8KIPX/JYnIhzhxxZLaq93XD8ivDfL8gz9Qc8CxSwPcLRwl5sFanEM+Le62fGtPiyNAG1GYg/uoDH3rVXSr5N+yhVn8LwuMZMgg6GX80dfNOHEPIcWgsCt8+rD4AjFYM8cusI6DbxUKmgVSUXot6PWbLYruXPTz55wJqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XSeHk3VL; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XSeHk3VL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgsmg3rktz2xBV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 03:29:06 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P2jLvq3255707;
	Wed, 25 Mar 2026 16:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=aBOnqBWEL2czgyDz2xU9T9LWfdDwG1
	t2YQ0ArASBwpg=; b=XSeHk3VL6anxRrEWRNGy9IiaHaYplO1lSmQsn9V1/rx94h
	eSltE4HuX1+YfFi8z0I2iBRBBdYC4OiiRJAd6oHmvLZ0Dsjkr8HNtdOEnvjQlv5y
	/F0rSDNniDgWMwyyVJ54S0kXkeOCcWqSOiJVP0vUh08u6Ae97RVvcypY9PPVMGSm
	YqoSTeYUtADa0C+6kcbH3lvkmN5PyFfT119C76b3tR0ptaB6r9gTxbzcKOK8vmn1
	KqWcOX2WRbHvYixVU4jirJ+LU8DROPPnT3UA9m2BiLzIEppkyYI3C0HUfy82k27p
	GFe7M+oHq3kn0YenLkBgVelDmWM1eopIvY5mtF9A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumrk3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 16:29:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PEeRXf031598;
	Wed, 25 Mar 2026 16:29:00 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsydev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 16:29:00 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PGSxTH31851070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 16:29:00 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D97995805A;
	Wed, 25 Mar 2026 16:28:59 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACA7D58051;
	Wed, 25 Mar 2026 16:28:59 +0000 (GMT)
Received: from [9.61.251.205] (unknown [9.61.251.205])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 16:28:59 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------4Z4JYfk9s1hj0pMfVELb3yCz"
Message-ID: <2d5fd6ec-003f-4d24-aa2e-06ba94d6cba4@linux.ibm.com>
Date: Wed, 25 Mar 2026 11:28:59 -0500
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: SNaQry9uZg9NDHQ0Vqp7dGrqC2aKGCgc
X-Proofpoint-ORIG-GUID: _mhZX4G286COMPDE1u_sxt1KT-ifrUDI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDExNyBTYWx0ZWRfX+HKs0U2BKmpU
 M8QaWCM4KJ2und+ZTSQ7mYSc1dg/RpVfKTI/IdZEq0p2cAe1KMV1ArY40yHefev3sWiS5qa0vLQ
 WacYX4Am30pyfEJwN7Fh7UnYoqPGAnhmCFl1uF8wpIJ9/8hMhcH1CMm4qnLdEJGQfQKhKl6rZgn
 ns7oiqX5rAm+sPasVxEkIIQtELXd7x0KzOlIGgIl0qvtsxxjYtkNu1VJ+Jy1bfcKZo9WaxThAYi
 HBMNg3DtodLhmutGjkFL7y5YUrk2omtfw1Ci3K6AFFKjUU58eHJZVMr8O1seBXq9vqYUrKFuqZJ
 M5tafwCOBWFChvW6sJncEXQrs2HuZ9Xh+XnS1bcaiR5k/M4tBWmfNcCwlngNUce2Qh2N42BRTCA
 KLTJGTbC5eHs4QRG3TymMt7EyjqL7FbPJNjjb96oJ9HdAx8CBA9cVqujtv0BoZ8A3xoLm6Ye2M/
 /o1zdP6MW/8oZnRv8og==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c40d4d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=sdj6hJBvrL_aPr-BQAQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pGLkceISAAAA:8
 a=5PeequN1kYYrHle9yAYA:9 a=206HcwMMZcWizhqR:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250117

This is a multi-part message in MIME format.
--------------4Z4JYfk9s1hj0pMfVELb3yCz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Ritesh

I think, what you are proposing to add dev->bus_dma_limit in the check 
might work. In the case of PowerNV, this is not set, but 
dev->dma_ops_bypass is set. So, for PowerNV, it will fall back to how it 
was before.

Also, since these both are set in LPAR mode, the current patch as-is 
will work.

Dan, can you please try Ritesh proposed fix on your PowerNV box? I am 
not able to lay my hands on a PowerNV box yet.

Thanks,

Gaurav

On 3/25/26 7:12 AM, Ritesh Harjani (IBM) wrote:
> Gaurav Batra<gbatra@linux.ibm.com> writes:
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
--------------4Z4JYfk9s1hj0pMfVELb3yCz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hello Ritesh</p>
    <p>I think, what you are proposing to add <span
      style="white-space: pre-wrap">dev-&gt;bus_dma_limit in the check might work. In the case of PowerNV, this is not set, but dev-&gt;dma_ops_bypass is set. So, for PowerNV, it will fall back to how it was before.</span></p>
    <p>Also, since these both are set in LPAR mode, the current patch
      as-is will work.</p>
    <p>Dan, can you please try Ritesh proposed fix on your PowerNV box?
      I am not able to lay my hands on a PowerNV box yet.</p>
    <p>Thanks,</p>
    <p>Gaurav</p>
    <div class="moz-cite-prefix">On 3/25/26 7:12 AM, Ritesh Harjani
      (IBM) wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:5x6knm5q.ritesh.list@gmail.com">
      <pre wrap="" class="moz-quote-pre">Gaurav Batra <a class="moz-txt-link-rfc2396E" href="mailto:gbatra@linux.ibm.com">&lt;gbatra@linux.ibm.com&gt;</a> writes:

Hi Gaurav,

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Hello Ritesh/Dan,


Here is the motivation for my patch and thoughts on the issue.


Before my patch, there were 2 scenarios to consider where, even when the 
memory
was pre-mapped for DMA, coherent allocations were getting mapped from 2GB
default DMA Window. In case of pre-mapped memory, the allocations should 
not be
directed towards 2GB default DMA window.

1. AMD GPU which has device DMA mask &gt; 32 bits but less then 64 bits. In 
this
case the PHB is put into Limited Addressability mode.

    This scenario doesn't have vPMEM

2. Device that supports 64-bit DMA mask. The LPAR has vPMEM assigned.


In both the above scenarios, IOMMU has pre-mapped RAM from DDW (64-bit 
PPC DMA
window).


Lets consider code paths for both the case, before my patch

1. AMD GPU

dev-&gt;dma_ops_bypass = true

dev-&gt;bus_dma_limit = 0

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

    dev-&gt;dma_ops_bypass is true, dma_direct_get_required_mask() resulted 
in large
    value for the mask (due to changed max_pfn) which is beyond AMD GPU 
device DMA mask


2. Device supports 64-bit DMA mask. The LPAR has vPMEM assigned

dev-&gt;dma_ops_bypass = false
dev-&gt;bus_dma_limit = has some value depending on size of RAM (eg.  
0x0800001000000000)

- Here the call to dma_go_direct() returns false since 
dev-&gt;dma_ops_bypass = false.



I crafted the solution to cover both the case. I tested today on an LPAR
with 7.0-rc4 and it works with AMDGPU.

With my patch, allocations will go towards direct only when 
dev-&gt;dma_ops_bypass = true,
which will be the case for "pre-mapped" RAM.

Ritesh mentioned that this is PowerNV. I need to revisit this patch and 
see why it is failing on PowerNV.
...
From the logs, I do see some issue. The log indicates
dev-&gt;bus_dma_limit is set to 0. This is incorrect. For pre-mapped RAM, 
with my
patch, bus_dma_limit should always be set to some value.

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
In that case, do you think adding an extra check for dev-&gt;bus_dma_limit
would help? I am sure you already would have thought of this and
probably are still working to find the correct fix?

+bool arch_dma_alloc_direct(struct device *dev)
+{
+	if (dev-&gt;dma_ops_bypass &amp;&amp; dev-&gt;bus_dma_limit)
+		return true;
+
+	return false;
+}
+
+bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
+{
+	if (!dev-&gt;dma_ops_bypass || !dev-&gt;bus_dma_limit)
+		return false;
+
+	return is_direct_handle(dev, dma_handle);
+}

&lt;snip from Timothy&gt;

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">introduced a serious regression into the kernel for a large number of
active users of the PowerNV platform, I would kindly ask that it be
reverted until it can be reworked not to break PowerNV support.  Bear
in mind there are other devices that are 40 bit DMA limited, and they
are also likely to break on Linux 7.0.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Looks like more people are facing an issue with this now.

-ritesh
</pre>
    </blockquote>
  </body>
</html>

--------------4Z4JYfk9s1hj0pMfVELb3yCz--


