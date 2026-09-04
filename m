Return-Path: <linuxppc-dev+bounces-26560-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F33C79F87
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 14:51:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbztX0J8jz2xpn;
	Sat, 05 Sep 2026 00:51:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788533475;
	cv=none; b=XZdKqJCKDMmtfcP5uBxuc8wm3yLyfK9MP4qQvJ5SjRk7k6OZOpzm+hG+A9CaNBPuxakOUKnNY3uGfWv82TpEAZBg9zRjyqVdOtDaFop0DtfaPlQqzFH2IOIsSI2/Q+3d7HxByXd6GAUa0BTlKCgEAv/WTD05YyTl8x0kX5JGGVMQhAW9oPsmBzO8VrC9CM/vk6Mi88ioEM83moFsLZYiwBZ/ShX7x+EgEz/0qNE1dm4EgGX1pa0aK95RWAmuNV63HbZyXxbjVxpSDOnpKN7EyCVtH4dVYgO7tFXzavkKwI8pv1tZ8+yZHI1otdOozt2rlivDABtOCK4HbYZqIOLpEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788533475; c=relaxed/relaxed;
	bh=z84wpOj7CNOGSg65mDGIrYSnrJrlGh4ehhkoEAM8pT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9uQVUWcKDjYeo2gWs0p+girYXbRauyuQjNfUDpSVa3b9VXaDqRZsjGwaY+/tYy8OlzkIYoILTCXogpzzW2kMoUWjgxsYsx9hchpE1QxM/O2yJMxdGHJdW6OGJWhXUcEHyPMg37fXzg4a1GMWRvZsmycA0xUq0xhoMZssc38hWtChGszjdyqaRz3JKZpEW2e0fwgKvY86wIxcPfRCZqNj5ihFtMpnTUED1r+c+5Mnl/xkrtgokDBYmFwAdyXBQ1B9o3CfkqmpKPvdcyHyXkWFl8thFwEJpNMSkGbxepxGok44MyULgI/vnPzeW+JnbivnowGaRLghj2WyCm/v83/LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VlUnJy5L; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VlUnJy5L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbztV55w8z2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 00:51:14 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684E1nul1809083;
	Fri, 4 Sep 2026 14:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=z84wpO
	j7CNOGSg65mDGIrYSnrJrlGh4ehhkoEAM8pT0=; b=VlUnJy5LSg7sY30IsA5Bl3
	wDXrdDbOjtTj42TngRcuf260Mlbbvqo5y8A6n5pFx0HeqFY1bz5rqelkYFaz56oz
	iF9MqCfKrjc2e9PFwExohrJkvYSbdvWAzZv/tYUOh2Cu0Z1AuCZNbAljinYIuTvi
	m6LC8oDEPbFFaeEnrCN0q+lpie58c6edzC/V0bsPDshJDHN0Nyj4sp6bobZGK6HW
	NtySuTJF8c1V1DZL2YGTI1UE/IlRL0UMOZfvKQZUP9E4TZdYcbcWyqdxHhLhi6hi
	5tLxlgMVwFzC0JvlGUNqN9sIwfmPCCvUBxq8PSYVQBPo2HHnV62Rz/UyTxCIeJjA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmujb2re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 14:50:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 684EfGJY005113;
	Fri, 4 Sep 2026 14:50:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygwf73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 14:50:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 684Eoj0m42467610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 14:50:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 070A120040;
	Fri,  4 Sep 2026 14:50:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 496CD20043;
	Fri,  4 Sep 2026 14:50:40 +0000 (GMT)
Received: from [9.43.71.40] (unknown [9.43.71.40])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 14:50:40 +0000 (GMT)
Message-ID: <8fa790a7-f387-48f6-ac76-11cf71ef5589@linux.ibm.com>
Date: Fri, 4 Sep 2026 20:20:38 +0530
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
        linux-kernel@vger.kernel.org
References: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
 <20260821105609.983622-3-sourabhjain@linux.ibm.com>
 <2vxza4qfznyo.fsf@kernel.org>
 <7bb84b8a-c394-4895-9e22-632dc506cbb6@linux.ibm.com>
 <2vxz5x0ox7p9.fsf@kernel.org>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <2vxz5x0ox7p9.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ZuVGYkq6M7Ac90dVE0d7ogJJ4Uw4f_V4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEzMiBTYWx0ZWRfX6HJ8GB5LIm1I
 9yyQiaZCLp78oRy6HCn4nEMsi2sB+ws+Gaf9FPNv8AERig+Byvw9SOuYa8DJS3uEtjHkFBqkvfQ
 b8eNm5a1hp9Z8Bt8hsYNjjDyntf2fkwe4WirN60gpMQeGBy1XYz5RAEYN+Tdcwpln+1A9iWPtz8
 RBmOdmj23sII7TpxLxvzHgaYPYc2TU8ET5D9aRStiL7K28xbWIz/LVLhSwuYe1LZCwREjaYwS49
 YKNVHNDcmWBnyRVf9NGh6vLnAELnaOy2jep1nAaPsvJRN1MBDHTQH7HnTxmTcWsextWoMRmjZFg
 bvYT8DnLfZFVwFkw0q+nwg7tA/YKhKYDch1Du3ItdiSxPrlG3rFqwGU9FnkMLtup9L+xpH0hMTj
 a1GrZvLYeLhVPaqmzPDEnef8e4c6GP2N0ExCdXbvLVHHay83sdkiS1oj9mLksGxOudJYSuXpo1L
 ARZwAm6xfM2maxxcUlQ==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9adaca cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=sUgROpt_8gkIZWawIRsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEzMiBTYWx0ZWRfX8pPn+rD+4iEK
 QBTaJF7ilWe0zR0ir5GN0ZjiCfAQhxq/OGnQmI4KeOwkpxxEPP4U7MQyrcuQP1tb3mUW6bYWaTL
 JwHy9Y5f2UH6+XCBTHqvOYr86ofcLGc=
X-Proofpoint-ORIG-GUID: 55JCyPY_GdeWZ6Pfh6526yIwK2uy6q3s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040132



On 02/09/26 16:04, Pratyush Yadav wrote:
> On Sun, Aug 23 2026, Sourabh Jain wrote:
>
>> On 21/08/26 17:26, Pratyush Yadav wrote:
>>> On Fri, Aug 21 2026, Sourabh Jain wrote:
>>>
>>>> Add the architecture bits needed to enable CONFIG_KEXEC_HANDOVER on
>>>> powerpc.
>>>>
>>>> Set ARCH_SUPPORTS_KEXEC_HANDOVER for PPC64, following the existing
>>>> pattern used by ARCH_SUPPORTS_KEXEC and ARCH_SUPPORTS_KEXEC_FILE.
>>>>
>>>> On the boot path, parse the "linux,kho-fdt" and "linux,kho-scratch"
>>>> properties from /chosen and pass them to kho_populate(). This lets a
>>>> kernel booted via KHO kexec recover the FDT and scratch region left
>>>> behind by the previous kernel. The call is placed early in
>>>> setup_arch(), before unflatten_device_tree().
>>>>
>>>> Open issues:
>>>> ============
>>>>
>>>> This patch also adds "depends on !CRASH_DUMP" to
>>>> ARCH_SUPPORTS_KEXEC_HANDOVER. This is needed because of an ordering
>>>> conflict between crashkernel reservation and KHO scratch reservation
>>>> on powerpc.
>>>>
>>>> Crashkernel memory is reserved very early in boot, from arch-specific
>>>> code: head.S -> early_setup() -> early_init_devtree() ->
>>>> arch_reserve_crashkernel() / fadump_reserve_mem(). KHO's scratch
>>>> region is reserved later, from generic code: start_kernel() ->
>>>> mm_core_init() -> kho_memory_init(). So on powerpc, crashkernel
>>>> memory is always reserved first.
>>>>
>>>> This ordering causes a real failure. In the common case, crashkernel
>>>> reservation on powerpc starts at a 512M offset (the exact offset can
>>>> vary, but 512M is typical). So with crashkernel=3G, the reservation
>>>> occupies memory from 512M up to 3.5G -- roughly 75% of the entire low
>>>> 4G area.
>>>>
>>>> Since crashkernel reservation always happens first, that 3G is
>>>> already committed by the time kho_memory_init() runs. It then tries
>>>> to reserve a low scratch region sized at 200% of whatever is already
>>>> reserved below 4G. With ~75% of that 4G area already taken by
>>>> crashkernel memory, 200% of that easily exceeds the remaining space
>>>> -- and since the low scratch region is itself capped at 4G, there's
>>>> no room left to fit it. The reservation fails.
>>> crashkernel has the variant "crashkernel=size[KMG],high", which ensures
>>> memory is allocated above 4G. Unless powerpc has some requirement for
>>> strictly having the crashkernel below 4G, I think it will make a lot of
>>> sense to enable support for this feature. So KHO users can specify this
>>> to get crashkernel working with KHO.
>> I agree that this is one way to work around the low-memory reservation problem.
>> However, there are a few things that come into play here:
>>
>> 1. On powerpc, the crashkernel reservation can go up to 64 GB for kdump. With
>> the
>>     current default scratch memory reservation policy, this could result in
>> reserving
>>     up to 256 GB of scratch memory: 200% for the high-memory reservation and
>> another
>>     200% for per-node memory.
> That calculation looks off. It _should_ be 200% once not twice. So 128
> GB total. If the allocation came out via the global area, it should
> _only_ be accounted to the global scratch size. Similarly, only the
> allocations made specifically on that node should be counted for the
> per-node scratch size.

For example, if a system has only one node and 64 GB is allocated from
that node before the kernel starts calculating the per-node and global
allocations for scratch memory, wouldn't the per-node allocation also be 
64 GB?

If so, wouldn't that result in 200% of 64 GB being allocated for the global
area and another 200% of 64 GB for the per-node area, resulting in 256 GB
of total scratch memory allocation? Or am I missing something here?


>
> But I have also noticed this problem on some of the systems Google has.
> Which makes me wonder if scratch_size_update() is broken and
> over-calculating. I have this on my TODO list and have been meaning to
> look into it, but other things keep intervening.
>
> If you are interested, feel free to take it off my hands.

Yes, I can take this up and propose patches to make crashkernel and
scratch reservations work together.

Based on my current testing, a Linux partition (powerpc) with 16 CPUs 
and 30 GB
of RAM needs only 16 MB of scratch memory in the low-memory area when
crashkernel=xxM is not specified.

16 MB is not much. I am also trying to get a larger Linux partition with 
1000+
CPUs to get a better idea of the limits for low-memory reservations.

BTW, do you know the rationale behind the 200% value?

I couldn't find any explanation for it in the commit message of
3dc92c311498c ("kexec: add Kexec HandOver (KHO) generation helpers")


>
>>     For fadump, which is the powerpc-specific memory dump capture mechanism, the
>> crashkernel
>>     reservation can go up to 180 GB. In this case, we could end up reserving up
>> to 720 GB of
>>     scratch memory, which is too much. I agree that users can tune this, but I
>> think the
>>     default scale should be more reasonable for powerpc.
> Once we fix scratch_size_update() to actually use 200% and not 400%,
> perhaps that alone will be enough? If not, we can discuss reducing the
> default scratch scale to maybe 150%. But I'd rather do it for all
> platforms if we do it at all, because this problem doesn't seem specific
> to PowerPC.

Yes, it makes sense to have a general fix that works for all architectures.

BTW, I was able to reproduce this issue on x86 as well. Please have a
look at this:

https://lore.kernel.org/all/008fe00e-fd52-4010-86ca-f0ab80a65a46@linux.ibm.com/ 
<https://lore.kernel.org/all/008fe00e-fd52-4010-86ca-f0ab80a65a46@linux.ibm.com/>

I have also suggested an approach to handle this issue which is similar 
how you handle
huge pages. Please share your thoughts on it.


>
>>
>> 2. Fadump also uses the crashkernel kernel command-line argument, but its
>> reservation policy
>>     is different from kdump. The crashkernel base address starts after the memory
>> needed for
>>     fadump. For example, with crashkernel=3G, the base address would be 3 GB, and
>> the crashkernel
>>     reservation would be from 3 GB to 6 GB. So, depending on the crashkernel
>> size, the reservation
>>     may or may not fall within low memory. Also, fadump does not support
>> crashkernel=xxM,high.
>>
>> 3. I do have a patch [1] to support high crashkernel reservations with kdump,
>> but this would not
>>     work with Hash MMU. With Hash MMU, the kernel image is constrained to low
>> memory, whereas with
>>     crashkernel=,high, all segments would be loaded into high memory.
> Oh, nice!
>
>> So, while supporting crashkernel=,high can help address the low-memory
>> reservation issue for kdump,
>> I think there are still some powerpc-specific constraints to consider. I would
>> like to explore
>> whether we can fix the ordering between crashkernel and scratch memory
>> reservations, so that we can
>> avoid unnecessarily large scratch memory reservations and address some of the
>> other constraints mentioned
>> above. Please share your thoughts.
>>
>>> Powerpc doesn't support this right now, but from a quick skim of the
>>> code, I think it should be simple enough.
>> I have patch series under review for the same:
>> [1]
>> https://lore.kernel.org/all/20260708143357.673251-1-sourabhjain@linux.ibm.com/
>>
>>> From
>>> arch_reserve_crashkernel() you just need to pass a bool * to
>>> parse_crashkernel(), and then pass the result to
>>> reserve_crashkernel_generic().
>> Due to some architecture-specific dependencies (such as RTAS), booting the
>> kernel from above 4G with
>> support for high crashkernel is not as straightforward as on other
>> architectures. Patch 2/4 in [1] has the
>> details.
>>
>>> Solving the ordering of crash reservations and KHO is tricky and comes
>>> with some difficult tradeoffs. Allocating crash from highmem should be a
>>> lot simpler.
>>
>> Could you please elaborate a bit on what makes the ordering tricky and what the
>> main tradeoffs are between crash reservations and KHO? It would help me better
>> understand the concerns here.
> The problem today is that kho_preserved_memory_reserve() (called by
> kho_mem_retrieve()) does a memblock_reserve() for each preserved folio.
> So if you have a lot of order-0 (or, 4k) folios, you end up with a lot
> of reservations in memblock. The large number of reservations can slow
> down later memblock operations like allocations too since memblock might
> have to walk through a lot of ranges to find free memory.
>
> We kind of work around this problem by calling kho_mem_retrieve() as
> pretty much the last thing in the MM init. So all allocations prior to
> this have already been fulfilled from scratch without any of the
> reservations added, so it should be pretty fast. You only take the
> performance hit at the end, where the only thing left is to release
> pages to buddy.

Ah, okay, that makes sense. Thanks for the clarification.


> Even then, the memblock reservations can get pretty damn slow. In some
> of my testing with under-load systems, preserving a 2G memfd with 4k
> pages can go over **5 minutes** in only kho_mem_retrieve() if the folios
> of the memfd are fragmented enough. Plus there is the memory overhead of
> the regions in memblock.reserved.

5 minutes in kho_mem_retrieve(), which is primarily marking a bunch
of memory as reserved using memblock, seems like quite a lot. If you
have the test case handy somewhere, I would be interested in trying it
myself, just to get a better feel for the issue.

Regardless, I understand the concern now. From my perspective also, the
current ordering of crashkernel and scratch memory reservations seems
reasonable, because crashkernel is not as flexible as scratch reservation
atleast on powerpc.

On powerpc, the crashkernel offset is determined first, and the
corresponding memory region is reserved. To make sure that no
other reservation falls within the crashkernel region, the crashkernel
reservation is one of the first reservations we make on powerpc.

If we change this ordering, there is a possibility that a scratch
reservation could end up in a region where the crashkernel is supposed
to be placed. That would lead to crashkernel reservation failure.

Also, reserving scratch memory at a location where the crashkernel
cannot be placed could be problematic. Each architecture has its own
constraints on where the crashkernel can be placed, so the available
memory for scratch reservation may need to account for those constraints.
Which I think too much to take care off...

And, of course, moving kho_mem_retrieve()earlier during boot would
also mean taking the performance hit you mentioned earlier.

So let's keep the current ordering and find a way to make both
reservations work with it: reserve the crashkernel first, and then
reserve the scratch memory.


> So long-term, I would like to get rid of the memblock reservations
> entirely and use scratch-only mode all the way until buddy comes up. And
> I would like to modify buddy init (free_low_memory_core_early() and
> deferred_init_memmap_chunk()) to be KHO-aware and directly skip the KHO
> pages.
>
> This vision goes in the opposite direction of turning scratch-only mode
> off _earlier_. And turning off scratch-only mode earlier is necessary
> for doing crash reservations outside of scratch.
>
> That is the tradeoff I mentioned. Hope I was clear enough.

Yes, that makes sense. I understand the tradeoff you're pointing out
now.

>
>>> And on that note, I don't think you should do a depends on !CRASH_DUMP.
>>> Even when CONFIG_KEXEC_HANDOVER is enabled, KHO isn't on by default
>>> (well, unless KEXEC_HANDOVER_ENABLE_DEFAULT is set). You need to enable
>>> it via cmdline. So it is entirely possible for people using KHO on PPC
>>> to not use crash and vice versa. This decision can be made at deployment
>>> time, not at compile time.
>> Agree. depends on !CRASH_DUMP is temporary and will be removed once
>> we settle the crashkernel reservation and scratch region handling.
> My point is that !CRASH_DUMP can be removed _even if_ we don't settle
> the reservation thing, because it is perfectly valid for the same kernel
> to use either KHO or crash but not at the same time. These both can be
> enabled/disabled at runtime.

Agree I will drop the !CRASH_DUMP dependency...

- Sourabh Jain

