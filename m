Return-Path: <linuxppc-dev+bounces-26625-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B19EC79FA0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Sep 2026 15:33:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdDjw0DlRz2y2c;
	Mon, 07 Sep 2026 01:33:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788708787;
	cv=none; b=LvhN6B0Yeg184SIOv433TU/iUXU1GoEvMx4A9HKolJ597OqVsAbQLnVZUJhM9KbUtpnfrx4JGOn7fpPa1bNN75RzZeDI2HlGL4uCYAosR1aZK8TReHySujjYZUWAQhRfr8GfauNKry+sg53r5pYm8ejA94coZ0GNjPX0pVF/QWNLiO3pKU3rK5Om79WZ6DybsOcIPS/psDgz0v8JIsygPEtyEEp6W+eHGu+9D0fOR5xHQW82009SNlI4y4JRRjmLNZEq+LZo9RKVJBhEatM94oTib4NdDbaucnIJ+nlTkyf576SntJ6Y438GSceK161kanPszoVPXZEBMj4c+x0How==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788708787; c=relaxed/relaxed;
	bh=fZE0IWCrA6YqXzzv6iwoA4J+1qBR7GnxKy1Cf5FXBjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozBHu/0dcaloUYh5Qit5bFXXTV9Cx1YyWrQfY0jGRBw4OAduVu98X2v5wCLSZixqvL4TINYw6VoquZEd1Zdtts2fepbkr7IjVvpVfLDKgiclAc9r3y0P2T0YKuPOpOqU52uDSz5ZIcePW8Z2DdRh9u4aA8VRUqZiMU+TdUPYyQ+oWnAhSktSeEWRlilig8B/wymxlBn0TfFVL+TOiBiHXmwYFjCcrWCH9jDK/0hPI1x1IvSRy2XhU1QAeM3d12k578PJNGGiUrcJpuNDsgcJhMSKme1X1PMJaX10BAX7kkMWstOWC0nQX2AV0WCbdBtae1QiQfTINEDDTd7yvdvmfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PSgBSbuI; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PSgBSbuI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdDjt59MBz2y22
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 01:33:05 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 686EXLSh3368966;
	Sun, 6 Sep 2026 15:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fZE0IW
	CrA6YqXzzv6iwoA4J+1qBR7GnxKy1Cf5FXBjI=; b=PSgBSbuIDFC+l+9NFjin70
	46Iz+7CYe6lCglqKt5vuODjjf1YNNbfg4Cc1RhGwy21o14rpizEBBaJ8fsF4uFDC
	xrdVRw5kteeiTQvCiXZldzJvOPa5Fk864OUV8rcK6qNn5zYFcN0CahiHSxlCUcwf
	Dxfe6al1S9DQrDmESt7CcQN3aK7CfzC/wPTqj5kJRvb/AAurMbeRfExX92tAO4Vn
	tgb7ZjqZRgIFk9O5Lma99LmikUDrm2AxSPl9nwtKLA8waaHWGPA/Jkq5yRacYpeu
	ZJRhJfgENvtW5zaqzcZvahEtoHC/CTUKVmso4frQQDxjoa6fTQNFWrSAPMgh99tg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf3mk5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Sep 2026 15:32:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 686FQHkj003707;
	Sun, 6 Sep 2026 15:32:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxwgsr19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Sep 2026 15:32:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 686FWUZe42795302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 6 Sep 2026 15:32:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDD8920043;
	Sun,  6 Sep 2026 15:32:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F1AB20040;
	Sun,  6 Sep 2026 15:32:26 +0000 (GMT)
Received: from [9.43.69.205] (unknown [9.43.69.205])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  6 Sep 2026 15:32:25 +0000 (GMT)
Message-ID: <5854ba8b-07f3-4c88-90f0-3003bdbf9644@linux.ibm.com>
Date: Sun, 6 Sep 2026 21:02:24 +0530
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
Subject: Re: [RFC PATCH 2/3] powerpc: add support for Kexec HandOver (KHO)
To: Pratyush Yadav <pratyush@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Aditya Gupta <adityag@linux.ibm.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
References: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
 <20260821105609.983622-3-sourabhjain@linux.ibm.com>
 <2vxza4qfznyo.fsf@kernel.org>
 <7bb84b8a-c394-4895-9e22-632dc506cbb6@linux.ibm.com>
 <2vxz5x0ox7p9.fsf@kernel.org>
 <8fa790a7-f387-48f6-ac76-11cf71ef5589@linux.ibm.com>
 <2vxzwlt1vvet.fsf@kernel.org>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <2vxzwlt1vvet.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: aIIFFm0oA4TrhPCrZM2DRWJbzO1uK31S
X-Proofpoint-GUID: yfNnEcJ45EF43dtPKGFTPTgh1KwayJmg
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6a9d8794 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=X0f19CpMum2MarKMJ0sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDE3MyBTYWx0ZWRfXztOVvKy3wrI5
 8Q5Z9BXXZGPs/ZelOb6OfaVMXZztVya4JmVLoYp9OPdoyxi/4LCkS6FkrKDNUM9RPtvGwO5B3cm
 hJo992kdjKOw7lcjPnwiilSAdA0/GV+YmVBsRFojuIQaqdKCDiEHaho+K+l79nAOaLlksECjf36
 5DaG522uWauDR8iYfcMcovzz3kdlMCMxTzTRGfXdvsUnYC4RG/AZMiNrkOr1ZUS/R32AN5NymEi
 AMHqfHB1vvlSurEHM3oJPpbSMPMVNAIDZwua139AqpnMXepVw2n/IfrxbYXGrOeb5LKjFvKC0gk
 Beu2SeiTommUQesdVymmVLDWBu/YcIlce1gspmd116jslYL+ZU0cFHLWGf6kae0OB4jiGr2sfUz
 aA3qJf206XrK5VgL/wPWI4d3V1q5SAMsKBCjGHov7Xr6dATNarSXB0mAWLIKm+pvSSLqsPFVlqv
 EjjUK/WeTfnHuOA5i4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDE3MyBTYWx0ZWRfX4b311dRuVv39
 v/JSAgJ6D1WKfvBnaGMVv3I/FDmYwaZuw2fKJ/qH9q49qdGgfKCVUyrO6pWTTOZ8QZ1YW6gB0FB
 7j0oEErUYCuc0aAxSrl3J+fL9JU7LOQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060173



On 04/09/26 21:52, Pratyush Yadav wrote:
> On Fri, Sep 04 2026, Sourabh Jain wrote:
>
>> On 02/09/26 16:04, Pratyush Yadav wrote:
>>> On Sun, Aug 23 2026, Sourabh Jain wrote:
>>>
>>>> On 21/08/26 17:26, Pratyush Yadav wrote:
>>>>> On Fri, Aug 21 2026, Sourabh Jain wrote:
> [...]
>>>> I agree that this is one way to work around the low-memory reservation problem.
>>>> However, there are a few things that come into play here:
>>>>
>>>> 1. On powerpc, the crashkernel reservation can go up to 64 GB for kdump. With
>>>> the
>>>>      current default scratch memory reservation policy, this could result in
>>>> reserving
>>>>      up to 256 GB of scratch memory: 200% for the high-memory reservation and
>>>> another
>>>>      200% for per-node memory.
>>> That calculation looks off. It _should_ be 200% once not twice. So 128
>>> GB total. If the allocation came out via the global area, it should
>>> _only_ be accounted to the global scratch size. Similarly, only the
>>> allocations made specifically on that node should be counted for the
>>> per-node scratch size.
>> For example, if a system has only one node and 64 GB is allocated from
>> that node before the kernel starts calculating the per-node and global
>> allocations for scratch memory, wouldn't the per-node allocation also be 64 GB?
>>
>> If so, wouldn't that result in 200% of 64 GB being allocated for the global
>> area and another 200% of 64 GB for the per-node area, resulting in 256 GB
>> of total scratch memory allocation? Or am I missing something here?
> It shouldn't. If the 64 GB of allocation was done with NUMA_NO_NODE, and
> it _happened_ to land on node X, it should not be counted for per-node
> sizing. It should count towards the global pool. Only allocations that
> were explicitly requested with node X should be count for that node's
> scratch size.
>
> So on a one node system where 64G of memory is allocated with
> NUMA_NO_NODE and 8G is allocated with node X, we should get 128G of
> global scratch and 16G of per-node scratch, giving us a total of 144G.

That makes sense. I was just going by the reservation that was made. As
you mentioned, an allocation made on a specific node can be
differentiated from a general allocation because users pass the NID for
a specific NUMA allocation and |NUMA_NO_NODE|for a general allocation.

Thanks for the clarification!


> I took a quick look and it looks like the problem might be that the
> calculation for global scratch includes _all_ nodes in it. See
> memblock_reserved_kern_size():
>
> 	for_each_reserved_mem_region(r) {
> 		...
>                  
> 		if (nid == memblock_get_region_node(r) || !numa_valid_node(nid))
> 			if (r->flags & MEMBLOCK_RSRV_KERN)
> 				total += size;
> 	}
>
> And for global scratch we pass nid as NUMA_NO_NODE.
>
> For KHO we could just drop the || !numa_valid_node(), but
> memblock_estimated_nr_free_pages() seems to depend on that behaviour. It
> wants to get _all_ allocations across all nodes. KHO only wants
> allocations explicitly made with NUMA_NO_NODE.

Yes the above explanation seems correct to me. !numa_valid_node() is 
problem in KHO scratch memory reservation context.
> But disclaimer: all this is from reading the code for maybe 15 minutes.
> I didn't run anything and might be missing something. So please
> double-check what I am saying.
>
> Not sure how to fix this. Since memblock_estimated_nr_free_pages() needs
> all the reservations anyway, perhaps open code a simple counting loop
> there? And the drop the || !numa_valid_node() from
> memblock_reserved_kern_size().
>
> But yeah, it would be much appreciated if you'd care to fix this.

I will send a fix for this.

>
> The fix should be a separete patch, since it fixes problems on all
> platforms, and not just PowerPC.

Yes the fix shouldn't be part of this series...

>
>>> But I have also noticed this problem on some of the systems Google has.
>>> Which makes me wonder if scratch_size_update() is broken and
>>> over-calculating. I have this on my TODO list and have been meaning to
>>> look into it, but other things keep intervening.
>>>
>>> If you are interested, feel free to take it off my hands.
>> Yes, I can take this up and propose patches to make crashkernel and
>> scratch reservations work together.
>>
>> Based on my current testing, a Linux partition (powerpc) with 16 CPUs and 30 GB
>> of RAM needs only 16 MB of scratch memory in the low-memory area when
>> crashkernel=xxM is not specified.
>>
>> 16 MB is not much. I am also trying to get a larger Linux partition with 1000+
>> CPUs to get a better idea of the limits for low-memory reservations.
>>
>> BTW, do you know the rationale behind the 200% value?
>>
>> I couldn't find any explanation for it in the commit message of
>> 3dc92c311498c ("kexec: add Kexec HandOver (KHO) generation helpers")
> We need to ask Alex (or maybe Mike?; I forget who added this).
>
> But if I were to guess, I don't think there is much science involved
> behind the number. Since the scratch lives across all kexecs, it needs
> to be large enough in case the next kernel uses more memory. 200% sounds
> "large enough".

OK..

>
>>>>      For fadump, which is the powerpc-specific memory dump capture mechanism, the
>>>> crashkernel
>>>>      reservation can go up to 180 GB. In this case, we could end up reserving up
>>>> to 720 GB of
>>>>      scratch memory, which is too much. I agree that users can tune this, but I
>>>> think the
>>>>      default scale should be more reasonable for powerpc.
>>> Once we fix scratch_size_update() to actually use 200% and not 400%,
>>> perhaps that alone will be enough? If not, we can discuss reducing the
>>> default scratch scale to maybe 150%. But I'd rather do it for all
>>> platforms if we do it at all, because this problem doesn't seem specific
>>> to PowerPC.
>> Yes, it makes sense to have a general fix that works for all architectures.
>>
>> BTW, I was able to reproduce this issue on x86 as well. Please have a
>> look at this:
>>
>> https://lore.kernel.org/all/008fe00e-fd52-4010-86ca-f0ab80a65a46@linux.ibm.com/
>>
>> I have also suggested an approach to handle this issue which is similar how you
>> handle
>> huge pages. Please share your thoughts on it.
> I missed this.
>
> We can exclude HugeTLB pages from scratch accounting because the series
> updates HugeTLB to use a new routine called memblock_alloc_hugetlb() to
> allocate pages. This special allocator makes sure the pages are
> _outside_ of scratch even if scratch-only mode is used. Since HugeTLB
> pages come outside of scratch, they don't get counted in scratch sizing.
>
> We need to do this for HugeTLB mainly because we want to preserve
> HugeTLB pages in the future, and pages from scratch can't be preserved.
>
> We could perhaps do so for crash as well, but I need to think more about
> this.
>
> But at first glance, if you need to allocate crash super early, perhaps
> memblock won't be able to cope. Because allocating crash outside of
> scratch would depend on kho_extend_scratch() and that needs
> memblock_allow_resize() to be called to be able to cope with multiple
> memory regions.

I just saw your patches to handle HugeTLB separately. I was thinking of
handling the crashkernel reservation in a similar way.

Let me first understand the HugeTLB handling in KHO completely, and then
I can propose a similar approach for the crashkernel reservation. This
should allow the crashkernel and scratch reservations to coexist in most
cases.



>
> [...]
>>>> Could you please elaborate a bit on what makes the ordering tricky and what the
>>>> main tradeoffs are between crash reservations and KHO? It would help me better
>>>> understand the concerns here.
>>> The problem today is that kho_preserved_memory_reserve() (called by
>>> kho_mem_retrieve()) does a memblock_reserve() for each preserved folio.
>>> So if you have a lot of order-0 (or, 4k) folios, you end up with a lot
>>> of reservations in memblock. The large number of reservations can slow
>>> down later memblock operations like allocations too since memblock might
>>> have to walk through a lot of ranges to find free memory.
>>>
>>> We kind of work around this problem by calling kho_mem_retrieve() as
>>> pretty much the last thing in the MM init. So all allocations prior to
>>> this have already been fulfilled from scratch without any of the
>>> reservations added, so it should be pretty fast. You only take the
>>> performance hit at the end, where the only thing left is to release
>>> pages to buddy.
>> Ah, okay, that makes sense. Thanks for the clarification.
>>
>>
>>> Even then, the memblock reservations can get pretty damn slow. In some
>>> of my testing with under-load systems, preserving a 2G memfd with 4k
>>> pages can go over **5 minutes** in only kho_mem_retrieve() if the folios
>>> of the memfd are fragmented enough. Plus there is the memory overhead of
>>> the regions in memblock.reserved.
>> 5 minutes in kho_mem_retrieve(), which is primarily marking a bunch
>> of memory as reserved using memblock, seems like quite a lot. If you
>> have the test case handy somewhere, I would be interested in trying it
>> myself, just to get a better feel for the issue.
> I do, but unfortunately based on downstream code so it is neither useful
> to you nor something I can share I think.
>
> But your friendly neighbourhood LLM can help here. Ask it to preserve
> you a memfd but fragment/shatter buddy blocks first. That's pretty much
> how I wrote my test.

Sure I will try it and share my experience.

>
> But also see [0] which fixes the problem. Maybe Tarun (+Cc) has a test
> based on upstream that he can share?
>
> [0] https://lore.kernel.org/kexec/20260903155907.1065681-1-tarunsahu@google.com/

Thanks for the Cc. I will try the above patch also.

>
>> Regardless, I understand the concern now. From my perspective also, the
>> current ordering of crashkernel and scratch memory reservations seems
>> reasonable, because crashkernel is not as flexible as scratch reservation
>> atleast on powerpc.
>>
>> On powerpc, the crashkernel offset is determined first, and the
>> corresponding memory region is reserved. To make sure that no
>> other reservation falls within the crashkernel region, the crashkernel
>> reservation is one of the first reservations we make on powerpc.
>>
>> If we change this ordering, there is a possibility that a scratch
>> reservation could end up in a region where the crashkernel is supposed
>> to be placed. That would lead to crashkernel reservation failure.
>>
>> Also, reserving scratch memory at a location where the crashkernel
>> cannot be placed could be problematic. Each architecture has its own
>> constraints on where the crashkernel can be placed, so the available
>> memory for scratch reservation may need to account for those constraints.
>> Which I think too much to take care off...
> That's a real problem. But I am hoping the restrictions are something
> along the lines of "crash kernel must be in lowmem", so the lowmem
> scratch already solves that problem?


Yes, for different reasons, the architecture may need to load the
vmlinux kexec segment in low memory. Alternatively, there may need to
be some crashkernel reservation in low memory to satisfy the memory
requirements of components that can only allocate memory from low
memory.


I will also explore how KHO handles reserved memory regions.

For example, let’s say the firmware marks 10 MB as reserved and exports
that region as reserved in the DTB. If I am not mistaken, while parsing the
FDT, the kernel calls memblock_reserve() for these regions. PowerPC has
some such regions, like RTAS and OPAL. Generally, these regions should
persist across KHO.

So I will explore:
- How these regions are handled by KHO
- How they affect the scratch kernel reservation, specially in lowmem

- Sourabh Jain

>> And, of course, moving kho_mem_retrieve()earlier during boot would
>> also mean taking the performance hit you mentioned earlier.
>>
>> So let's keep the current ordering and find a way to make both
>> reservations work with it: reserve the crashkernel first, and then
>> reserve the scratch memory.
> [...]
>


