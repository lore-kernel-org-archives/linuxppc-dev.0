Return-Path: <linuxppc-dev+bounces-25295-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C686FC55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 20:48:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDTKK1fHgz2y8F;
	Tue, 04 Aug 2026 06:48:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785790101;
	cv=none; b=VYsalAkE3QgZu9Ol70E6/TxpDOtdf5HXkjhH5TwaxdW/oUR5Y5+XjbzQDBYbRFuBNBQLtxR681ZTJZRK/TG5rHFyMwn9oWmxjOBA9SLGo2IoNHQJFv0uD1+HsHFokkVAklVlWHWV2vF+kHzT+nbAnpWHs3uyOONZgER7nPv+vQmQQMijlUdEZi+hs+W0wZaLZ0PGbf8/jJx8E1c6pV2OEjlwOPqbvh2cvqGzOtJfMgIx+lFInvwsgVjRG7JpG7ba9T3Wj3DnzY3HjPnVApplIDF+2wjSBXXjEEjzsE2YZyVBpv0fgsDb7yHpakumorCRICGQMnLhCLntdZ8958S59A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785790101; c=relaxed/relaxed;
	bh=3xa7ysEPvdBo06sZYu7fUoH9tRg1ARooyAttxxeSrEA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=gPpHXjzTc1oHxWKVc/YOZNFX+ZvDxTu3BC4Lexy0yA2KC0K2fGMV58if0J3y7QO1taTNzcgoyPFxir/z38sS6b9576fF6oWeg0S0pJ9O9NijHoGGyPYRrs0+Qn7KG+Qrqp8B7pry8XM4GMlx71ZNLqihpcJ6xsPKYcGa9R/Gu2kUR0ilt/WltIha/byJ1nwTPStJbUqvyKyA1wYzZkH4FyGwTrXEa4tyaubE1fCH8UNxivTmxMjWeGITUuadnIoGgYUF+0Vv6BjHQZAPnWbWQ9Gb0egZiXNNCWWd6ywJGkZHuwP4mpGVWecIqDzVDxqvJnudiL4OvevbOy6bYuMr3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a0SstFYC; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a0SstFYC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDTKH4kr3z2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 06:48:19 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673JlxUQ2973693
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 20:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3xa7ysEPvdBo06sZYu7fUoH9tRg1AR
	ooyAttxxeSrEA=; b=a0SstFYCgnd2QDX0H8jQMmdGm1oO82bXHVhVAu9nBAjMHQ
	gf6dYXfD83cM6vz/TItGOYvbRoUmP/xncQLRR3+2IENAkhTuVucctV/fsQdnpozb
	D5Z0wSXb2cf0fQKaEoO7ij9NRSEcmXefb95x/fGHYknmQ6f9p4rT3pjKHyka0JjT
	D9TZMiaaO1GCW3mX1H44d6Aunt1iTxoyP6bLsgSLLl18DO8A77/zOxSLbXOmiqE/
	DhpJ2RO712vruUVT3XHbpocK+N1vgLfQ4giuv3/lxjPd6/+9UaHPzWbaACd+EI5n
	SR9XMxLLoalazqVrUY5EAw1Xr2dFlDKZeEdFhRAw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3tst7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 20:48:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673KfLuY010344;
	Mon, 3 Aug 2026 20:48:15 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qf9db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 20:48:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673KlYsY64422170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 20:47:34 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27EA158058;
	Mon,  3 Aug 2026 20:48:11 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E57958059;
	Mon,  3 Aug 2026 20:48:10 +0000 (GMT)
Received: from [9.67.105.130] (unknown [9.67.105.130])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 20:48:10 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------YprSB9iceroYyqYh9k1gIVnJ"
Message-ID: <55d7f592-234f-4482-9b16-1c74fab317a5@linux.ibm.com>
Date: Mon, 3 Aug 2026 15:48:09 -0500
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
 <c627cb09-5ac1-41f1-aaa1-88221f39c0c6@linux.ibm.com>
 <5x1umll7.ritesh.list@gmail.com>
Content-Language: en-US
From: Gaurav Batra <gbatra@linux.ibm.com>
In-Reply-To: <5x1umll7.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a70fe90 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=cBUNWnkJGf9FskVC6tYA:9 a=QEXdDO2ut3YA:10
 a=ZmD_KyikDZ96U9kQ0IUA:9 a=pe7ISivnznzClyMi:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
X-Proofpoint-ORIG-GUID: XGSgGlgdRKNznCrlot7S8tQKtwEwPiql
X-Proofpoint-GUID: 8aZiLkYUvl_huH_L_n5CPbgQUqt0D999
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE4MyBTYWx0ZWRfX6rxWW5XHlckJ
 5PalvhYWYfGutcuzSUfugXI2jPNqRmwxirNEcT1XYuOyfaZqNy2MTcAOGcoyr9gW2LUwDK3OFkb
 l6oAgSJCuQRjSi1cxw/nZwTouJXBR/A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE4MyBTYWx0ZWRfX6HBRmvkDpzkt
 rU4abN+o5He9BD3DSwjZkN0BJ9FV+jIk2pygRE3FvSC6A6qERgXgTMHuDg05lFwGTYHPB1obFiF
 1wKbQTqD1REdu7s2p9jHBW2usvuugJq0J7CJVSMlsZKrubSJj4PCl27siKyeBYCp+9mKEjk90VF
 XBf/bOaPr+L/ut8CXSTO4oXpnQqAlLSJq+6u/DoCgLEXbVy9hC4mIzNHv/O+chQmnuoW1UnVmW8
 HFAE3D7EQSexjl5+ciQ1yJeHI2xoYDQX4M/DidO5gxNmnne+Rg8WszN+VTQcaGhLuCJNyylQdW4
 J51OFKPjYNcQKB7IoKbu9jqR+ohsHJZMsWWnOutE5YLSGdozcABl9+oy63zL20yEGYUKEhQFf8T
 Ug80tzh8hhOJ3cnvd9MbXqsfSsk3uehTC+5ouWdDxzONV3xje0er/pIUx1zgxinNYN8q7PAMEeu
 8hlkFJzvgV/O0brwVHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030183

This is a multi-part message in MIME format.
--------------YprSB9iceroYyqYh9k1gIVnJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Ritesh,

Responses are inline

- Gaurav

On 8/1/26 12:55 AM, Ritesh Harjani (IBM) wrote:
> Gaurav Batra<gbatra@linux.ibm.com> writes:
>
>>> So looking at above, I had few questions -
>>> 1. In your kdump kernel how many nr_cpus you are booting up with?
>>>      Recently what I heard rhel/sles might be using nr_cpus=16/32. @Sourabh?
>>>      So the calculation in nvme-fc driver then becomes:
>>>        32(nr_cpus) * 64(queue_depth) * 2(cmd+resp) = 4096
>>>
>>>     If you are able to reproduce this issue 100% of the time - then can
>>>     you try kdump with nr_cpus=1 and see whether it fixes your iommu alloc
>>>     failure?
>> Initially, when I reproduced this issue, I was not passing any value to
>>
>> nr_cpus to the kdump kernel. I made changes to /etc/sysconfig/kdump to pass
>>
>> nr_cpus=1. With this the kdump was successful. I tried with
>> nr_cpus=16/32. These
>>
>> were successful as well. Though, in these cases, I did notice a few
>> iommu_alloc failures
>>
>> (maybe < 10), vmcore was gathered successfully.
>>
>> I started to see the issue with nr_cpus=64. My LPAR is configured with
>> max cpus = 64. So,
>>
>> earlier, when I was not specifying nr_cpus in the /etc/sysconfig/kdump,
>> kdump could be
>>
>> defaulting to 64 CPUs and hence allocating more resources during kdump.
>>
> Was this issue not reported via any system testing? Is this something
> that you found on your own when you attach nvme-fc?
> The reason I am interested in knowing that was - because the distro
> default for rhel/sles will be 16/32 cpus, so was wondering if it was
> repored with the default values as well and what were they?
This issue was reported during testing of of NVMe-FC device on SLES 16.1.
My understanding is that recently there has been changes in grub that 
enabled
NVMe over FC on SLES. It is not yet supported on RHEL. I am not sure 
what the
CPU configuration was in the tester's LPAR. Once of my team member, 
Wendy, was
able to reproduce the issue in her environment. This is where I debugged 
the issue.
Now, I am not sure, if this issue can be encountered in the fresh 
install of SLES 16.1
and what the kdump default parameters will be.
>
>
>>> 2. Also were there more than 1 controller attached? Which can change the
>>>     above calculation then.
>> Only 1 controller. Here is the output of lscpi
>>
>> ltcd41-lp11:~ # lspci
>> 0153:70:00.0 Fibre Channel: Emulex Corporation LPe37000/LPe38000 Series
>> 32Gb/64Gb Fibre Channel Adapter (rev 10)
>> 0153:70:00.1 Fibre Channel: Emulex Corporation LPe37000/LPe38000 Series
>> 32Gb/64Gb Fibre Channel Adapter (rev 10)
>> 0153:70:00.2 Fibre Channel: Emulex Corporation LPe37000/LPe38000 Series
>> 32Gb/64Gb Fibre Channel Adapter (rev 10)
>> 0153:70:00.3 Fibre Channel: Emulex Corporation LPe37000/LPe38000 Series
>> 32Gb/64Gb Fibre Channel Adapter (rev 10)
>>
>>> Looking at the lpfc and nvme-fc driver - a lot of the calculation are
>>> based on nr_online_cpus. I somehow think if we clamp that value of
>>> nr_online_cpus, we should stop seeing these alloc failures.
>>> Thoughts?
>>>
>>> Hopefully, if you can work on some above points further, it will also
>>> explain why are we seeing this failures only now. Is this something that
>>> has caused an issue after RHEL/SLES moved to nr_cpus=16/32?
>> it seems this got exposed because in my test LPAR, nr_cpus=1/16/32 was not
>>
>> getting passed to the kdump kernel.
>>
>>> Or was it after this commit from v6.9?
>>>      ec30b461f3d: ("blk-mq: don't change nr_hw_queues and nr_maps for kdump kernel")
>>>
>>>> Here are the driver logs and stack
>>>>
>>>> lpfc 0153:70:00.0: iommu_alloc failed,
>>>> tbl 0000000034ebcf5e vaddr 00000000d814df0b npages 1
>>>> lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
>>>> lpfc 0153:70:00.0: iommu_alloc failed,
>>>> tbl 0000000034ebcf5e vaddr 000000009779e4d2 npages 1
>>>> lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
>>>>
>>>> iommu_map_phys+0x1c4/0x1f0 (unreliable)
>>>> dma_iommu_map_phys+0x54/0xa0
>>>> dma_map_phys+0x3f8/0x590
>>>> __nvme_fc_init_request+0x110/0x300 [nvme_fc]
>>>> nvme_fc_init_request+0x60/0xb8 [nvme_fc]
>>>> blk_mq_alloc_map_and_rqs+0x388/0x510
>>>> blk_mq_alloc_tag_set+0x2a4/0x5f0
>>>> nvme_alloc_io_tag_set+0xe0/0x1e0 [nvme_core]
>>>> nvme_fc_connect_ctrl_work+0x85c/0xdac [nvme_fc]
>>>> process_one_work+0x1e4/0x5a0
>>>> worker_thread+0x1ec/0x3e0
>>>>
>>>> Increasing the number of free TCE entries in iommu_table_clear() will
>>>> increase the probability of hitting EEH since there could still be some
>>>> active IOs from the previous life of the kernel.
>>>>
>>>> Instead, during kdump, we can switch to default 2GB DMA window. This window
>>>> will mostly be empty. Or, could be slightly used if buffers in pmemory
>>>> were mapped for IO.
>>>>
>>> This will still remain a problem when we have SR-IOV adapter attached
>>> correct? Because in that case we only get 1 window, so we anyway can't
>>> use default window in kdump case. Correct?
>> you are right. The patch is fixing the dedicated adapter path only by
>> switching to
>>
>> default window for kdump. Before I submitted the patch, I did try SR-IOV
>> path as well.
>>
>> Here, I assigned a virtualized adapter to LPAR and gathered kdump over
>> NFS. I checked the
>>
>> footprint of DMA buffers in this path. They were not much. I think, I
>> did sent these details
>>
>> in my emails (the discussion/advice).
>>
>>
>> seems to me the least invasive fix for this very narrow problem.
> I went back and looked at the history of why do we use DDW window during
> kdump instead of default window. It looks like this commit itself
> changed the default to DDW instead of default window :) i.e.
>    Fixes: 09a3c1e46142 ("powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV")
>
> The commit msg is very detailed and explains a lof of things but somehow
> it didn't explain on why did we change the default to always use ddw
> window instead of using default window.
When I was working on that issue, it was clear, that the code path for 
SR-IOV case has
missed the DDW. This was because pci_dma_find() was specifically looking 
for default window,
which in the case of SR-IOV, will be missing.

Both dedicated adapter and SR-IOV will have DDW. That is why I switched 
to DDW in both the case
(dedicated and SR-IOV). Also, iommu_table_clear() was making space in 
DDW by clearing 2K worth of
TCEs, and the fact that this is not a performance path, I switched to 
DDW. I have detailed all this
reasoning in the commit: 09a3c1e46142 ("powerpc/pseries/iommu: IOMMU 
table is not initialized for kdump over SR-IOV")
>
>> Your insight and thoughts?
>>
> Somehow in the current commit msg we didn't mention that this commit is
> just a partial revert of that previous fixes commit - i.e. we are
> switching back to using 2GB default DMA window as the preferred window
> for kdump case.
>
> IMO, let's please also _add_ something like this to the existing commit
> msg, so that it becomes clear for others.
>
> <snip>
>    (after this) ...kdump path and DMA window is needed for IO to the device.
>
> Although this commit fixed an issue during kdump with SR-IOV case,
>    09a3c1e46142 ("powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV")
> but this also made the kdump prefer DDW over the default DMA window when
> both are present (dedicated adapter case). Since the DDW is fully mapped
> by the previous kernel, iommu_table_clear() can free only
> KDUMP_MIN_TCE_ENTRIES (2048) TCEs for use by kdump kernel.
>
> This is not enough when the dump device is NVMe over Fibre Channel.
> Because nvme-fc driver DMA-maps the cmds and resp IUs of every
> pre-allocated request and each such mapping consumes roughly:
>         32(IO queues, one per cpus = nr_cpus) * 64(queue_depth, blk-mq kdump limit) * 2(cmd+resp) = 4096
>
> This is already double of what we have without counting admin queues and
> lpfc driver's own allocations / mapping requirement. Hence this results
> into iommu_alloc failures like -
>
> lpfc 0153:70:00.0: iommu_alloc failed,
> tbl 0000000034ebcf5e vaddr 00000000d814df0b npages 1
> lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
> lpfc 0153:70:00.0: iommu_alloc failed,
> tbl 0000000034ebcf5e vaddr 000000009779e4d2 npages 1
> lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
>
> iommu_map_phys+0x1c4/0x1f0 (unreliable)
> dma_iommu_map_phys+0x54/0xa0
> dma_map_phys+0x3f8/0x590
> __nvme_fc_init_request+0x110/0x300 [nvme_fc]
> nvme_fc_init_request+0x60/0xb8 [nvme_fc]
> blk_mq_alloc_map_and_rqs+0x388/0x510
> blk_mq_alloc_tag_set+0x2a4/0x5f0
> nvme_alloc_io_tag_set+0xe0/0x1e0 [nvme_core]
> nvme_fc_connect_ctrl_work+0x85c/0xdac [nvme_fc]
> process_one_work+0x1e4/0x5a0
> worker_thread+0x1ec/0x3e0
>
> Increasing the number of free TCE entries in iommu_table_clear() will
> increase the probability of hitting EEH since there could still be some
> active IOs from the previous life of the kernel.
>
> Hence this patch partially reverts the previous fixes commit and
> switches the kdump's default back to 2GB default DMA window instead of
> DDW window. This window will mostly be empty. Or, could be slightly used
> if buffers in pmemory were mapped for IO.
>
> Fixes: 09a3c1e46142 ("powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV")
> Cc:stable@vger.kernel.org
>
> (before this) ...Signed-off-by:...
> </snip>
>
>
> With that added to the commit msg - please also feel free to add:
> Reviewed-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>

I will add the above in my next version of the patch. Thanks a lot for 
digging into this and
providing a much better and detailed commit message.
>> Thanks a lot
>>
>> Gaurav
>>
> Thanks again for adding detailed info. After looking at the history, I
> agree we can partially revert the previous patch to prefer the default
> DMA window for kdump case.
>
>> As of now SR-IOV path doesn't seems to be of concern. But, I think, the
>> correct overall fix
>>
>> should be to maintain the DDW state --> if it is pre-mapped DDW,
>> transfer this knowledge to kdump.
>>
>> With this, the DDW will be intact and buffers pre-mapped, as before.
>> But, this requires more work
>>
>> and thorough testing by FVT/ISST. So, I kept this for later. For now,
>> switching to default window
> I guess for kdump using 2GB default DMA window is not an issue, however
> I agree that for kexec case we should find a way to fix this.
> Because IIUC - kexec path on pseries is not performant today. It doesn't
> use pre-mapped TCEs. So if someone is doing any I/O performance
> measurement, we have to go via the full reboot cycle instead of just
> using kexec.
Totally agree with you. I will work on a patch that fixes this and 
retains the
DDW as pre-mapped in the kexec case. There are some nuances that I would 
need to
take care of. I will list all those when I sent that patch for review.
>
> -ritesh

--------------YprSB9iceroYyqYh9k1gIVnJ
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
    Responses are inline<br>
    <br>
    - Gaurav<br>
    <br>
    <div class="moz-cite-prefix">On 8/1/26 12:55 AM, Ritesh Harjani
      (IBM) wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:5x1umll7.ritesh.list@gmail.com">
      <pre wrap="" class="moz-quote-pre">Gaurav Batra <a class="moz-txt-link-rfc2396E" href="mailto:gbatra@linux.ibm.com">&lt;gbatra@linux.ibm.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
So looking at above, I had few questions -
1. In your kdump kernel how many nr_cpus you are booting up with?
    Recently what I heard rhel/sles might be using nr_cpus=16/32. @Sourabh?
    So the calculation in nvme-fc driver then becomes:
      32(nr_cpus) * 64(queue_depth) * 2(cmd+resp) = 4096

   If you are able to reproduce this issue 100% of the time - then can
   you try kdump with nr_cpus=1 and see whether it fixes your iommu alloc
   failure?
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Initially, when I reproduced this issue, I was not passing any value to

nr_cpus to the kdump kernel. I made changes to /etc/sysconfig/kdump to pass

nr_cpus=1. With this the kdump was successful. I tried with 
nr_cpus=16/32. These

were successful as well. Though, in these cases, I did notice a few 
iommu_alloc failures

(maybe &lt; 10), vmcore was gathered successfully.

I started to see the issue with nr_cpus=64. My LPAR is configured with 
max cpus = 64. So,

earlier, when I was not specifying nr_cpus in the /etc/sysconfig/kdump, 
kdump could be

defaulting to 64 CPUs and hence allocating more resources during kdump.

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Was this issue not reported via any system testing? Is this something
that you found on your own when you attach nvme-fc?
The reason I am interested in knowing that was - because the distro
default for rhel/sles will be 16/32 cpus, so was wondering if it was
repored with the default values as well and what were they?</pre>
    </blockquote>
    This issue was reported during testing of of NVMe-FC device on SLES
    16.1.<br>
    My understanding is that recently there has been changes in grub
    that enabled <br>
    NVMe over FC on SLES. It is not yet supported on RHEL. I am not sure
    what the <br>
    CPU configuration was in the tester's LPAR. Once of my team member,
    Wendy, was<br>
    able to reproduce the issue in her environment. This is where I
    debugged the issue.<br>
    Now, I am not sure, if this issue can be encountered in the fresh
    install of SLES 16.1<br>
    and what the kdump default parameters will be.
    <blockquote type="cite" cite="mid:5x1umll7.ritesh.list@gmail.com">
      <pre wrap="" class="moz-quote-pre">


</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">2. Also were there more than 1 controller attached? Which can change the
   above calculation then.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
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

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
Looking at the lpfc and nvme-fc driver - a lot of the calculation are
based on nr_online_cpus. I somehow think if we clamp that value of
nr_online_cpus, we should stop seeing these alloc failures.
Thoughts?

Hopefully, if you can work on some above points further, it will also
explain why are we seeing this failures only now. Is this something that
has caused an issue after RHEL/SLES moved to nr_cpus=16/32?
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
it seems this got exposed because in my test LPAR, nr_cpus=1/16/32 was not

getting passed to the kdump kernel.

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Or was it after this commit from v6.9?
    ec30b461f3d: ("blk-mq: don't change nr_hw_queues and nr_maps for kdump kernel")

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Here are the driver logs and stack

lpfc 0153:70:00.0: iommu_alloc failed,
tbl 0000000034ebcf5e vaddr 00000000d814df0b npages 1
lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
lpfc 0153:70:00.0: iommu_alloc failed,
tbl 0000000034ebcf5e vaddr 000000009779e4d2 npages 1
lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.

iommu_map_phys+0x1c4/0x1f0 (unreliable)
dma_iommu_map_phys+0x54/0xa0
dma_map_phys+0x3f8/0x590
__nvme_fc_init_request+0x110/0x300 [nvme_fc]
nvme_fc_init_request+0x60/0xb8 [nvme_fc]
blk_mq_alloc_map_and_rqs+0x388/0x510
blk_mq_alloc_tag_set+0x2a4/0x5f0
nvme_alloc_io_tag_set+0xe0/0x1e0 [nvme_core]
nvme_fc_connect_ctrl_work+0x85c/0xdac [nvme_fc]
process_one_work+0x1e4/0x5a0
worker_thread+0x1ec/0x3e0

Increasing the number of free TCE entries in iommu_table_clear() will
increase the probability of hitting EEH since there could still be some
active IOs from the previous life of the kernel.

Instead, during kdump, we can switch to default 2GB DMA window. This window
will mostly be empty. Or, could be slightly used if buffers in pmemory
were mapped for IO.

</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">This will still remain a problem when we have SR-IOV adapter attached
correct? Because in that case we only get 1 window, so we anyway can't
use default window in kdump case. Correct?
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
you are right. The patch is fixing the dedicated adapter path only by 
switching to

default window for kdump. Before I submitted the patch, I did try SR-IOV 
path as well.

Here, I assigned a virtualized adapter to LPAR and gathered kdump over 
NFS. I checked the

footprint of DMA buffers in this path. They were not much. I think, I 
did sent these details

in my emails (the discussion/advice).


seems to me the least invasive fix for this very narrow problem.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I went back and looked at the history of why do we use DDW window during
kdump instead of default window. It looks like this commit itself
changed the default to DDW instead of default window :) i.e.
  Fixes: 09a3c1e46142 ("powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV")

The commit msg is very detailed and explains a lof of things but somehow
it didn't explain on why did we change the default to always use ddw
window instead of using default window.</pre>
    </blockquote>
    When I was working on that issue, it was clear, that the code path
    for SR-IOV case has<br>
    missed the DDW. This was because pci_dma_find() was specifically
    looking for default window,<br>
    which in the case of SR-IOV, will be missing.<br>
    <br>
    Both dedicated adapter and SR-IOV will have DDW. That is why I
    switched to DDW in both the case<br>
    (dedicated and SR-IOV). Also, iommu_table_clear() was making space
    in DDW by clearing 2K worth of<br>
    TCEs, and the fact that this is not a performance path, I switched
    to DDW. I have detailed all this<br>
    reasoning in the commit: <span style="white-space: pre-wrap">09a3c1e46142 </span><span
    style="white-space: pre-wrap">("powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV")</span>
    <blockquote type="cite" cite="mid:5x1umll7.ritesh.list@gmail.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Your insight and thoughts?

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Somehow in the current commit msg we didn't mention that this commit is
just a partial revert of that previous fixes commit - i.e. we are
switching back to using 2GB default DMA window as the preferred window
for kdump case.

IMO, let's please also _add_ something like this to the existing commit
msg, so that it becomes clear for others.

&lt;snip&gt;
  (after this) ...kdump path and DMA window is needed for IO to the device.

Although this commit fixed an issue during kdump with SR-IOV case,
  09a3c1e46142 ("powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV")
but this also made the kdump prefer DDW over the default DMA window when
both are present (dedicated adapter case). Since the DDW is fully mapped
by the previous kernel, iommu_table_clear() can free only
KDUMP_MIN_TCE_ENTRIES (2048) TCEs for use by kdump kernel.

This is not enough when the dump device is NVMe over Fibre Channel.
Because nvme-fc driver DMA-maps the cmds and resp IUs of every
pre-allocated request and each such mapping consumes roughly:
       32(IO queues, one per cpus = nr_cpus) * 64(queue_depth, blk-mq kdump limit) * 2(cmd+resp) = 4096

This is already double of what we have without counting admin queues and
lpfc driver's own allocations / mapping requirement. Hence this results
into iommu_alloc failures like - 

lpfc 0153:70:00.0: iommu_alloc failed,
tbl 0000000034ebcf5e vaddr 00000000d814df0b npages 1
lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
lpfc 0153:70:00.0: iommu_alloc failed,
tbl 0000000034ebcf5e vaddr 000000009779e4d2 npages 1
lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.

iommu_map_phys+0x1c4/0x1f0 (unreliable)
dma_iommu_map_phys+0x54/0xa0
dma_map_phys+0x3f8/0x590
__nvme_fc_init_request+0x110/0x300 [nvme_fc]
nvme_fc_init_request+0x60/0xb8 [nvme_fc]
blk_mq_alloc_map_and_rqs+0x388/0x510
blk_mq_alloc_tag_set+0x2a4/0x5f0
nvme_alloc_io_tag_set+0xe0/0x1e0 [nvme_core]
nvme_fc_connect_ctrl_work+0x85c/0xdac [nvme_fc]
process_one_work+0x1e4/0x5a0
worker_thread+0x1ec/0x3e0

Increasing the number of free TCE entries in iommu_table_clear() will
increase the probability of hitting EEH since there could still be some
active IOs from the previous life of the kernel.

Hence this patch partially reverts the previous fixes commit and
switches the kdump's default back to 2GB default DMA window instead of
DDW window. This window will mostly be empty. Or, could be slightly used
if buffers in pmemory were mapped for IO.

Fixes: 09a3c1e46142 ("powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV")
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>

(before this) ...Signed-off-by:...
&lt;/snip&gt;


With that added to the commit msg - please also feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <a class="moz-txt-link-rfc2396E" href="mailto:ritesh.list@gmail.com">&lt;ritesh.list@gmail.com&gt;</a>
</pre>
    </blockquote>
    <br>
    I will add the above in my next version of the patch. Thanks a lot
    for digging into this and <br>
    providing a much better and detailed commit message.
    <blockquote type="cite" cite="mid:5x1umll7.ritesh.list@gmail.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Thanks a lot

Gaurav

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Thanks again for adding detailed info. After looking at the history, I
agree we can partially revert the previous patch to prefer the default
DMA window for kdump case.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">As of now SR-IOV path doesn't seems to be of concern. But, I think, the 
correct overall fix

should be to maintain the DDW state --&gt; if it is pre-mapped DDW, 
transfer this knowledge to kdump.

With this, the DDW will be intact and buffers pre-mapped, as before. 
But, this requires more work

and thorough testing by FVT/ISST. So, I kept this for later. For now, 
switching to default window
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I guess for kdump using 2GB default DMA window is not an issue, however
I agree that for kexec case we should find a way to fix this.
Because IIUC - kexec path on pseries is not performant today. It doesn't
use pre-mapped TCEs. So if someone is doing any I/O performance
measurement, we have to go via the full reboot cycle instead of just
using kexec.</pre>
    </blockquote>
    Totally agree with you. I will work on a patch that fixes this and
    retains the<br>
    DDW as pre-mapped in the kexec case. There are some nuances that I
    would need to <br>
    take care of. I will list all those when I sent that patch for
    review.
    <blockquote type="cite" cite="mid:5x1umll7.ritesh.list@gmail.com">
      <pre wrap="" class="moz-quote-pre">

-ritesh
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------YprSB9iceroYyqYh9k1gIVnJ--


