Return-Path: <linuxppc-dev+bounces-25135-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8933FC5516F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 20:07:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB0c03cSjz2yH4;
	Fri, 31 Jul 2026 06:07:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785442048;
	cv=none; b=ltQEruELwmD3t0ccagI2zh+hED50xSKL0ch6CcwgcDnvOQHK5vcQuOelvuYwEvZ/UyYHqNxTUncadlWmrNAUiOaM9SNg85eBYWSiMhuUVjEIeLkf5iU5EQL+Emr5PT1t09wqMyouzSY/n+J+QicVKGXMwxcGK4ynfXahz/iVtzHv31M/b5FacDZCOpSm14vK9HsChgMrKPYTo0Q8Flg3n9o4839B9xQdivknIu1M8kfi6p54r1Le5cvykx14LZMMjxZ1HJ9P/3NZxJOWpbf/v8o9bkDZ1sJpcdD3l9xexRpJeO7Jye54dVtBGYiIltrSRB2EQDCcZ3KcByDsiTD0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785442048; c=relaxed/relaxed;
	bh=vxHT3G7Zqj0lh9WD+MqAZFJJt7kRE2D18LBBJT8qJ50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixR1LfeoQaiyPbpLg3X42Ut/FQzS/UD9gvelRtl2J1IrWjzyVyZtq4jxu1BxMCHxxb0DtU2sjkAYPRPV1uDKntoaQBDMyyVp//YfintSx41w6Yx70IqbwhCJG6A1fyh5R8q/V+OCmb6hOGyPJZ0L+s5cLfXQ9/awoMFfao4Es8yM75bqACQ610PV5VsbcWFwpRXx3TSOoGBPa2qFQUD/QdM2ZyLGKni/cda/JLLYMrx0DaCMqmlyPF7PpXlS6i4n9OqnwLF1zngFBbWuZYc8H4cjB4FDHmPbyEKjToghRn3BHNm1IxTOJrFMQEfCzHqhXZsfUngksSqtHqZpz1wWWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YoTFvUpr; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YoTFvUpr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB0bz2rSzz2y8c
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 06:07:26 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UJm1iJ2080330
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 20:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vxHT3G
	7Zqj0lh9WD+MqAZFJJt7kRE2D18LBBJT8qJ50=; b=YoTFvUprCuFp1fgV3YaoEV
	9upmqK7rWzkSid3jYX4sr9rP7Zp59rO97cMPt9m6QgZxvWU5VlTfE7ifk4VhAOGo
	6KqYEsh8IXMfo7lDwFF0kV3m045uZg1JjKVXjXMtkpahX2qL0P+XaKPJkS6yUiNs
	QZWP4m6vTMG+UNfjAUst4h6SiPZO/rPbwG68PUbRYC5pvY1pVGW0cAcqcog1qXTS
	baesL5wknazfEXki4HYpy53jKgatlwO2/9QGNbsi+tWD/gLfxW6VP8RM41M0KwDU
	Ym7JsoY+4lG7NngpQX5o+EhyhyCL3lABYDa4FfpnUET0tJUe6YBSsqV0JY4EeKHQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycsm8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 20:07:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UJuFbL006137;
	Thu, 30 Jul 2026 20:07:22 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5ycped-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 20:07:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UK7Km232637614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 20:07:20 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18F675805F;
	Thu, 30 Jul 2026 20:07:20 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 979A95806C;
	Thu, 30 Jul 2026 20:07:19 +0000 (GMT)
Received: from [9.16.49.178] (unknown [9.16.49.178])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 20:07:19 +0000 (GMT)
Message-ID: <c627cb09-5ac1-41f1-aaa1-88221f39c0c6@linux.ibm.com>
Date: Thu, 30 Jul 2026 15:07:19 -0500
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
Subject: Re: [PATCH] powerpc/pseries/iommu: switch to Default DMA window
 during kdump
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, maddy@linux.ibm.com
Cc: npiggin@gmail.com, ltc-dev@lists.linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com, vaibhav@linux.ibm.com
References: <20260720203034.95244-1-gbatra@linux.ibm.com>
 <8q6sms4w.ritesh.list@gmail.com>
Content-Language: en-US
From: Gaurav Batra <gbatra@linux.ibm.com>
In-Reply-To: <8q6sms4w.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: O26YUCrubJvx6UDXOw7IP-ZoOyM6geOj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE0NSBTYWx0ZWRfX6qoz5RsVwuef
 HTe055vFDi9HFIi5Li4QxmHpfd+GWNUa1Exfh/ApRT0KvADrX5J2U/H64Qo0rjfO4fdF4ARATDC
 lAoC8OigrhIXcSr2oDf+jkUEIuHyytrmfuyKgZQWhovc6B79SFeyaWVr1WVOuAC6ENxKtrZBfwI
 auB9ISLfF0Lp7oBUVDzHQhDYRgVh1WIkwle2XvroQRWgoVgN9B1B47KM8iJFLd5nhI8HgV9m63I
 MNR63V7Ky4fDfBVtonB4XfFGYYx7H09QiJjo7hZvBoHbZwvtk8BvaZDw4oAXMDS+usB8B6Pkzke
 uCXvNovLHMdrjlRXPJRcfdPuDckTbadec+TzX+ClEoqoI3cA+RJm0WOPxfL2ZSIW31oOXStMleH
 gqcjehOJz1HNH6Ekt2ZA7AcuBdKBOHfCHHR6p/EqoIHTrdDa9QCq7uxCLCPx3RlRc9BvxiwUm2x
 jX31lKB7qHpTM54s3yw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE0NSBTYWx0ZWRfX2fEePOj9/9PI
 uYvczs1iMOqvvJPzpVCvHuPgtX0WCiXiusu3VOMuGCl2Fo4akBPUqwGjx3lKmNSJ9WfBee16yXW
 h6JMJi80qThNIB+1O6PvvKgtg3HH1+Q=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6baefc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=6xRWFclLTPyp6aml6oYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dlxXb2Bi4k1C4qTCrowY1C8-aDIBqx0L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300145

Hello Ritesh,

Thanks a lot for reviewing this patch. My responses are inline

On 7/30/26 10:09 AM, Ritesh Harjani (IBM) wrote:
> Hi Gaurav,
>
> Thanks for the patch. Few observation, inputs and queries -
>
> Gaurav Batra <gbatra@linux.ibm.com> writes:
>
>> In PowerPC (pseries) a non-virtualized adapter will have 2 DMA windows -
>> 2GB default and a larger Dynamic DMA Window (DDW). DDW is large enough to
>> map total RAM to a device.
>>
>> During normal functioning of OS, since RAM is pre-mapped, 2GB default
>> window is not used. The only scenario it might get used is when buffers in
>> pmemory are mapped to the device for DMA.
>>
>> As of today, during kdump, during early device discovery, pci_dma_find()
>> finds that the device has 2 DMA windows. It selects to use DDW. This is a
>> kdump path and DMA window is needed for IO to the device.
>>
>> Since, in the previous life of the LPAR (before panic), RAM was pre-mapped
>> via DDW, the DDW is completely full. So, in the iommu table initialization
>> code, iommu_table_clear() frees KDUMP_MIN_TCE_ENTRIES (2K) number of
>> TCEs.
>>
>> But, it seems these are not enough for NVMe over Fibre-channel. When kdump
>> is trying to save vmcore on storage device, which is NVMe-FC, the
>> TCE usage is much more than 2K number of entries. The driver is mapping
>> a lot more buffers for DMA. After all the TCEs are consumed, iommu returns
>> iommu_alloc failures and the driver is not able to further map buffers for
>> IO. kdump fails to copy vmcore to NVMe-FC storage device.
> Some context I collected while reviewing this patch -
>
> 1. kdump environment generally prefers configurations so that we could
>     avoid issues like memory allocation failures. I guess, we don't want to
>     be running the system with max configurations - that is also the reason
>     why distros keep nr_cpus to a lower value during kdump case.
>     For e.g. see this [1]:
>          scsi: lpfc: Limit xri count for kdump environment
>
>          scsi-mq operation inherently performs pre-allocation of resources for
>          blk-mq request queues. Even though the kdump environment reduces the
>          configuration to a single CPU, thus 1 hardware queue, which helps
>          significantly, the resources are still rather large due to the per request
>          allocations.
>          <...>
>     [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=31f06d2e73726160645f8d9976a0b3f42e136da7
>
> 2. While looking more into this call stack path I also saw -
>              /*
>              * If a crashdump is active, then we are potentially in a very
>          -	 * memory constrained environment. Limit us to 1 queue and
>          -	 * 64 tags to prevent using too much memory.
>          +	 * memory constrained environment. Limit us to  64 tags to prevent
>          +	 * using too much memory.
>              */
>          -	if (is_kdump_kernel()) {
>          -		set->nr_hw_queues = 1;
>          -		set->nr_maps = 1;
>          +	if (is_kdump_kernel())
>                  set->queue_depth = min(64U, set->queue_depth);
>          -	}
>          +
>          @@ -4515,7 +4513,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
>                                  GFP_KERNEL, set->numa_node);
>                  if (!set->map[i].mq_map)
>                      goto out_free_mq_map;
>          -		set->map[i].nr_queues = is_kdump_kernel() ? 1 : set->nr_hw_queues;
>          +		set->map[i].nr_queues = set->nr_hw_queues;
>              }
>
>              blk_mq_update_queue_map(set);
>
>     So looks like we already reduce blk-mq queue_depth to 64 in
>     blk_mq_alloc_tag_set(), no matter what the queue_depth is passed to
>     us by the driver.
>
> 3. Also with above patch from v6.9 onwards, we made nr_queues as
>     set->nr_hw_queues, whereas earlier it was clamped to 1. Because the
>     code assumes that in kdump kernel we boot with nr_cpus=1..
>          blk-mq: don't change nr_hw_queues and nr_maps for kdump kernel
>
>          For most of ARCHs, 'nr_cpus=1' is passed for kdump kernel, so
>          nr_hw_queues for each mapping is supposed to be 1 already.
>
>          More importantly, this way may cause trouble for driver, because blk-mq and
>          driver see different queue mapping since driver should setup hardware
>          queue setting before calling into allocating blk-mq tagset.
>
>          So not overriding nr_hw_queues and nr_maps for kdump kernel.
>
>     [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ec30b461f3d067bd322a6c3a6c5105746ed9bf14

I agree with your assessment that kdump executes in a very limited 
environment

and drivers make an effort to use less resources. The goal is to dump 
memory and

not performance.

>
> So looking at above, I had few questions -
> 1. In your kdump kernel how many nr_cpus you are booting up with?
>     Recently what I heard rhel/sles might be using nr_cpus=16/32. @Sourabh?
>     So the calculation in nvme-fc driver then becomes:
>       32(nr_cpus) * 64(queue_depth) * 2(cmd+resp) = 4096
>
>    If you are able to reproduce this issue 100% of the time - then can
>    you try kdump with nr_cpus=1 and see whether it fixes your iommu alloc
>    failure?

Initially, when I reproduced this issue, I was not passing any value to

nr_cpus to the kdump kernel. I made changes to /etc/sysconfig/kdump to pass

nr_cpus=1. With this the kdump was successful. I tried with 
nr_cpus=16/32. These

were successful as well. Though, in these cases, I did notice a few 
iommu_alloc failures

(maybe < 10), vmcore was gathered successfully.

I started to see the issue with nr_cpus=64. My LPAR is configured with 
max cpus = 64. So,

earlier, when I was not specifying nr_cpus in the /etc/sysconfig/kdump, 
kdump could be

defaulting to 64 CPUs and hence allocating more resources during kdump.

> 2. Also were there more than 1 controller attached? Which can change the
>    above calculation then.

Only 1 controller. Here is the output of lscpi

ltcd41-lp11:~ # lspci
0153:70:00.0 Fibre Channel: Emulex Corporation LPe37000/LPe38000 Series 
32Gb/64Gb Fibre Channel Adapter (rev 10)
0153:70:00.1 Fibre Channel: Emulex Corporation LPe37000/LPe38000 Series 
32Gb/64Gb Fibre Channel Adapter (rev 10)
0153:70:00.2 Fibre Channel: Emulex Corporation LPe37000/LPe38000 Series 
32Gb/64Gb Fibre Channel Adapter (rev 10)
0153:70:00.3 Fibre Channel: Emulex Corporation LPe37000/LPe38000 Series 
32Gb/64Gb Fibre Channel Adapter (rev 10)

>
> Looking at the lpfc and nvme-fc driver - a lot of the calculation are
> based on nr_online_cpus. I somehow think if we clamp that value of
> nr_online_cpus, we should stop seeing these alloc failures.
> Thoughts?
>
> Hopefully, if you can work on some above points further, it will also
> explain why are we seeing this failures only now. Is this something that
> has caused an issue after RHEL/SLES moved to nr_cpus=16/32?

it seems this got exposed because in my test LPAR, nr_cpus=1/16/32 was not

getting passed to the kdump kernel.

> Or was it after this commit from v6.9?
>     ec30b461f3d: ("blk-mq: don't change nr_hw_queues and nr_maps for kdump kernel")
>
>> Here are the driver logs and stack
>>
>> lpfc 0153:70:00.0: iommu_alloc failed,
>> tbl 0000000034ebcf5e vaddr 00000000d814df0b npages 1
>> lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
>> lpfc 0153:70:00.0: iommu_alloc failed,
>> tbl 0000000034ebcf5e vaddr 000000009779e4d2 npages 1
>> lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
>>
>> iommu_map_phys+0x1c4/0x1f0 (unreliable)
>> dma_iommu_map_phys+0x54/0xa0
>> dma_map_phys+0x3f8/0x590
>> __nvme_fc_init_request+0x110/0x300 [nvme_fc]
>> nvme_fc_init_request+0x60/0xb8 [nvme_fc]
>> blk_mq_alloc_map_and_rqs+0x388/0x510
>> blk_mq_alloc_tag_set+0x2a4/0x5f0
>> nvme_alloc_io_tag_set+0xe0/0x1e0 [nvme_core]
>> nvme_fc_connect_ctrl_work+0x85c/0xdac [nvme_fc]
>> process_one_work+0x1e4/0x5a0
>> worker_thread+0x1ec/0x3e0
>>
>> Increasing the number of free TCE entries in iommu_table_clear() will
>> increase the probability of hitting EEH since there could still be some
>> active IOs from the previous life of the kernel.
>>
>> Instead, during kdump, we can switch to default 2GB DMA window. This window
>> will mostly be empty. Or, could be slightly used if buffers in pmemory
>> were mapped for IO.
>>
> This will still remain a problem when we have SR-IOV adapter attached
> correct? Because in that case we only get 1 window, so we anyway can't
> use default window in kdump case. Correct?

you are right. The patch is fixing the dedicated adapter path only by 
switching to

default window for kdump. Before I submitted the patch, I did try SR-IOV 
path as well.

Here, I assigned a virtualized adapter to LPAR and gathered kdump over 
NFS. I checked the

footprint of DMA buffers in this path. They were not much. I think, I 
did sent these details

in my emails (the discussion/advice).

As of now SR-IOV path doesn't seems to be of concern. But, I think, the 
correct overall fix

should be to maintain the DDW state --> if it is pre-mapped DDW, 
transfer this knowledge to kdump.

With this, the DDW will be intact and buffers pre-mapped, as before. 
But, this requires more work

and thorough testing by FVT/ISST. So, I kept this for later. For now, 
switching to default window

seems to me the least invasive fix for this very narrow problem.

Your insight and thoughts?


Thanks a lot

Gaurav

>
> -ritesh
>

