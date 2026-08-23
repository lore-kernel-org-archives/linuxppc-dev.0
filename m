Return-Path: <linuxppc-dev+bounces-26055-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0D8C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Aug 2026 15:41:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hSdZC1Qryz2xrL;
	Mon, 24 Aug 2026 01:41:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787499699;
	cv=none; b=Jn9gv5aOT4g4evPAeqxMbGoThu2fHIRvFBMAjJdkU1Ig8Y0wOOo3TQ/kjlPHzvM91bnpKPIH3eSPg/yMVcT0oGZZ71S5LlHcwEM0K38afzfb4La5Nhk8NynOEULzZNNC4Jx1ivWoXMjG8LzkDkl7j3VZH7Kpa+vV+B6KJUxXhAN8MjUnmou98F52gRQM67mRoCZ8i6/ajZaigLPC4GKKoW3HeghKppxS+XICwLObt0i79nIduwaYG+SJvSLomafGv15XD1de1wGrlgcvHGj3Y7XcQGcVQWMsiVFdCDjAginO2L5+swy2u/rnWttMWwJtjYVGFGOpCkuSGcnf6ryFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787499699; c=relaxed/relaxed;
	bh=KrlUt0ri9zDAEFD732w+kX7g3HwxX7qpvSIJjeqD6Vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5YfpbiHCtkg63UFbvNoROLvesEqW7B3T40bZzhz+OrCZ9N6FUpZNzmcfG5iGC4AZdNfqT8ESUNpEXcA8hyT95oI3dVGQc4/3T1dd6AqDc5XaMOKsU4Z1GUAduqJfVx7iMXVPF4mk20pkDouKTNthVaElITm/aQ7MZ0qzIpYH36lSgc0+bFcP8xqx0+QPhr0qj7n8oUCoqKRlFMOxo4He5CQSUXumE9XQu3hIZny4JyKXqKTyoSLtPcmdjnhv6eACBFkClnD5v6BmLmKY2QE3mFASGxybtrcuTngaj9Lsyv3JbIqY38CPnJK0SKLSA3gRDpOgIND4BZM2uZ7q+HrQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WiAD/PkN; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WiAD/PkN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hSdZ92sLFz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2026 01:41:36 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67NDVTAU3248732;
	Sun, 23 Aug 2026 15:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KrlUt0
	ri9zDAEFD732w+kX7g3HwxX7qpvSIJjeqD6Vw=; b=WiAD/PkNHYUN/icBlAlaAn
	2EZ0HxpWvnoVA1V5yFnCw6b5hOMFLUDTSn2mIyhw0iYp8wVFQIr7cYSHl404uaCu
	1G4HkTznO5TPg1e2A7P2mQDJEmlR9vAev9Y8jCfypLMXapiK+CWoK209wMwTAzbT
	MSBAJJC1nNOjCMuSOHvdLWK4sL+h0t3JqPb6TjlC70lZH0R85Kyh8M4xO/QnIolo
	r3Vl79DE4DQEnZClOgky6SouedMSb4HeEPiyX9B9DSMOf17nNJsHP7AplzmmPOYo
	Rw+SiiikVsycoAn0TRuO/5N53wX/LRlMa7ztAH4j09pPANZ7hPV/DFVU7YO1GPXA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4d1e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Aug 2026 15:41:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67NFfGo3017791;
	Sun, 23 Aug 2026 15:41:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3pt21n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Aug 2026 15:41:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67NFfDkd45482334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Aug 2026 15:41:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02DA620043;
	Sun, 23 Aug 2026 15:41:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38EAB20040;
	Sun, 23 Aug 2026 15:41:07 +0000 (GMT)
Received: from [9.39.19.229] (unknown [9.39.19.229])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Aug 2026 15:41:06 +0000 (GMT)
Message-ID: <7bb84b8a-c394-4895-9e22-632dc506cbb6@linux.ibm.com>
Date: Sun, 23 Aug 2026 21:11:05 +0530
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
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <2vxza4qfznyo.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: UaHxPMF3E9ur5CJKEHjZxuUYAos2GX27
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDE0MCBTYWx0ZWRfXxUcelhRazD70
 VGrGvjXkm9NWbH0Vsf19SHgLgNnQ/Rohbe/fbvjskEbhQgBTedKe900qXttBFxzicZ9MtGgC0om
 qfwF1071wHnvMGbxPAozDmHJC9HK+ss=
X-Proofpoint-GUID: 4udt-c7kZbw_OOZTEbp2GAhljNbdhXHv
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8b149e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=9zatUX3LUsGwtMCblQwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDE0MCBTYWx0ZWRfXy1MkItAHQHCz
 7xsE8cfeXXce1mBLR/LOgpPH5xCPQxQdt1v8E7URdDdTCMhjSbUEYmFnVIJN1456CMileF+rwnC
 es2Ml/s11mSWbO99x4aMr24yC3ymF+DkFNNI1Lx2hr0KgpbQrnK5pwgLt0K0YFQk+bsGPjEeJ4z
 Z39RoBMsQR2Q8IIgRyJ1f9q6V9wuV/2LmTtV4KC2XRHEg1iAKW8/w0gTAertD8OjrIp/uT+zpWi
 lbgRDxhNy9ZUZCPsJ2eEgNLdDr0NPxGEq43Emp55P01QW5yGTPqz57VtsVuiVPagBVsqAWA4u6/
 1btqbwu7mhNTSAQrIXFfbdFBwyPZaIPr4kswlHQou+rrR0nGdpEDyVFcPtg0pZkMto0Kq5DJxnb
 MpzRC3hpigof9APShEQB90zvRxr6AQ7CyHyJnYhX0dGd9jr233+gJfuOFor1u8qMdyil3aGi0R9
 LhNWkEbQiVzmibs6FYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608230140



On 21/08/26 17:26, Pratyush Yadav wrote:
> On Fri, Aug 21 2026, Sourabh Jain wrote:
>
>> Add the architecture bits needed to enable CONFIG_KEXEC_HANDOVER on
>> powerpc.
>>
>> Set ARCH_SUPPORTS_KEXEC_HANDOVER for PPC64, following the existing
>> pattern used by ARCH_SUPPORTS_KEXEC and ARCH_SUPPORTS_KEXEC_FILE.
>>
>> On the boot path, parse the "linux,kho-fdt" and "linux,kho-scratch"
>> properties from /chosen and pass them to kho_populate(). This lets a
>> kernel booted via KHO kexec recover the FDT and scratch region left
>> behind by the previous kernel. The call is placed early in
>> setup_arch(), before unflatten_device_tree().
>>
>> Open issues:
>> ============
>>
>> This patch also adds "depends on !CRASH_DUMP" to
>> ARCH_SUPPORTS_KEXEC_HANDOVER. This is needed because of an ordering
>> conflict between crashkernel reservation and KHO scratch reservation
>> on powerpc.
>>
>> Crashkernel memory is reserved very early in boot, from arch-specific
>> code: head.S -> early_setup() -> early_init_devtree() ->
>> arch_reserve_crashkernel() / fadump_reserve_mem(). KHO's scratch
>> region is reserved later, from generic code: start_kernel() ->
>> mm_core_init() -> kho_memory_init(). So on powerpc, crashkernel
>> memory is always reserved first.
>>
>> This ordering causes a real failure. In the common case, crashkernel
>> reservation on powerpc starts at a 512M offset (the exact offset can
>> vary, but 512M is typical). So with crashkernel=3G, the reservation
>> occupies memory from 512M up to 3.5G -- roughly 75% of the entire low
>> 4G area.
>>
>> Since crashkernel reservation always happens first, that 3G is
>> already committed by the time kho_memory_init() runs. It then tries
>> to reserve a low scratch region sized at 200% of whatever is already
>> reserved below 4G. With ~75% of that 4G area already taken by
>> crashkernel memory, 200% of that easily exceeds the remaining space
>> -- and since the low scratch region is itself capped at 4G, there's
>> no room left to fit it. The reservation fails.
> crashkernel has the variant "crashkernel=size[KMG],high", which ensures
> memory is allocated above 4G. Unless powerpc has some requirement for
> strictly having the crashkernel below 4G, I think it will make a lot of
> sense to enable support for this feature. So KHO users can specify this
> to get crashkernel working with KHO.

I agree that this is one way to work around the low-memory reservation 
problem.
However, there are a few things that come into play here:

1. On powerpc, the crashkernel reservation can go up to 64 GB for kdump. 
With the
    current default scratch memory reservation policy, this could result 
in reserving
    up to 256 GB of scratch memory: 200% for the high-memory reservation 
and another
    200% for per-node memory.
    For fadump, which is the powerpc-specific memory dump capture 
mechanism, the crashkernel
    reservation can go up to 180 GB. In this case, we could end up 
reserving up to 720 GB of
    scratch memory, which is too much. I agree that users can tune this, 
but I think the
    default scale should be more reasonable for powerpc.


2. Fadump also uses the crashkernel kernel command-line argument, but 
its reservation policy
    is different from kdump. The crashkernel base address starts after 
the memory needed for
    fadump. For example, with crashkernel=3G, the base address would be 
3 GB, and the crashkernel
    reservation would be from 3 GB to 6 GB. So, depending on the 
crashkernel size, the reservation
    may or may not fall within low memory. Also, fadump does not support 
crashkernel=xxM,high.

3. I do have a patch [1] to support high crashkernel reservations with 
kdump, but this would not
    work with Hash MMU. With Hash MMU, the kernel image is constrained 
to low memory, whereas with
    crashkernel=,high, all segments would be loaded into high memory.

So, while supporting crashkernel=,high can help address the low-memory 
reservation issue for kdump,
I think there are still some powerpc-specific constraints to consider. I 
would like to explore
whether we can fix the ordering between crashkernel and scratch memory 
reservations, so that we can
avoid unnecessarily large scratch memory reservations and address some 
of the other constraints mentioned
above. Please share your thoughts.

>
> Powerpc doesn't support this right now, but from a quick skim of the
> code, I think it should be simple enough.

I have patch series under review for the same:
[1] 
https://lore.kernel.org/all/20260708143357.673251-1-sourabhjain@linux.ibm.com/

> From
> arch_reserve_crashkernel() you just need to pass a bool * to
> parse_crashkernel(), and then pass the result to
> reserve_crashkernel_generic().

Due to some architecture-specific dependencies (such as RTAS), booting 
the kernel from above 4G with
support for high crashkernel is not as straightforward as on other 
architectures. Patch 2/4 in [1] has the
details.

>
> Solving the ordering of crash reservations and KHO is tricky and comes
> with some difficult tradeoffs. Allocating crash from highmem should be a
> lot simpler.


Could you please elaborate a bit on what makes the ordering tricky and 
what the
main tradeoffs are between crash reservations and KHO? It would help me 
better
understand the concerns here.


>
> And on that note, I don't think you should do a depends on !CRASH_DUMP.
> Even when CONFIG_KEXEC_HANDOVER is enabled, KHO isn't on by default
> (well, unless KEXEC_HANDOVER_ENABLE_DEFAULT is set). You need to enable
> it via cmdline. So it is entirely possible for people using KHO on PPC
> to not use crash and vice versa. This decision can be made at deployment
> time, not at compile time.

Agree. depends on !CRASH_DUMP is temporary and will be removed once
we settle the crashkernel reservation and scratch region handling.

>
>> To work around this and get KHO working on powerpc, this patch:
>>
>> 1. Makes KHO usable on powerpc only when CRASH_DUMP is disabled.
>> 2. Calls kho_populate() from setup_arch(), so it runs before
>>     kho_memory_init() reserves the scratch region.
>>
>> The real fix would be to reserve the KHO scratch region before
>> crashkernel memory instead of after. But scratch reservation happens
>> in generic code (kho_memory_init(), called from mm_core_init()), so
>> this isn't something powerpc can address on its own -- it needs
>> discussion on how to influence the ordering between generic scratch
>> reservation and arch-specific crashkernel reservation. This patch
>> doesn't attempt that; it's meant as a starting point for that
>> discussion.
>>
> [...]
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 2580e27e4328..61350d3e7a19 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -716,6 +716,11 @@ config ARCH_SELECTS_CRASH_DUMP
>>   	depends on CRASH_DUMP
>>   	select RELOCATABLE if PPC64 || 44x || PPC_85xx
>>   
>> +config ARCH_SUPPORTS_KEXEC_HANDOVER
>> +	def_bool y
>> +	depends on PPC64
>> +	depends on !CRASH_DUMP
>> +
>>   config ARCH_SUPPORTS_CRASH_HOTPLUG
>>   	def_bool y
>>   	depends on PPC64
>> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
>> index 4afaba19b586..1fee743abdf2 100644
>> --- a/arch/powerpc/kernel/setup-common.c
>> +++ b/arch/powerpc/kernel/setup-common.c
> [...]
>>   }
>>   #endif
>>   
>> +#ifdef CONFIG_PPC64
>> +static void __init init_kho(const void *fdt)
>> +{
>> +	unsigned long node;
>> +	u64 fdt_start, fdt_size, scratch_start, scratch_size;
>> +
>> +	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER))
>> +		return;
>> +
>> +	/* Find and verify the /chosen node, same as early_init_dt_scan_chosen() does */
>> +	node = fdt_path_offset(fdt, "/chosen");
>> +	if ((long)node < 0)
>> +		node = fdt_path_offset(fdt, "/chosen@0");
>> +	if ((long)node < 0)
>> +		return;
>> +
>> +	if (!of_flat_dt_get_addr_size(node, "linux,kho-fdt",
>> +				      &fdt_start, &fdt_size))
>> +		return;
>> +	if (!of_flat_dt_get_addr_size(node, "linux,kho-scratch",
>> +				      &scratch_start, &scratch_size))
>> +		return;
>> +
>> +	kho_populate(fdt_start, fdt_size, scratch_start, scratch_size);
>> +}
> This looks pretty much a duplicate of early_init_dt_check_kho(). On
> arm64 this is called via early_init_dt_scan(). But from a quick search I
> don't see powerpc calling it.

Yes it is not called on powerpc.

>
> Would it make sense to call this function (or
> early_init_dt_scan_nodes()) for powerpc?
>
> If not, I think it would be a better idea to expose
> early_init_dt_check_kho() and call it from powerpc setup_arch() instead
> of duplicating the logic.

Agree they are identical.

I would prefer making early_init_dt_check_kho() as public function and 
call from arch specific code. Thanks for the review. - Sourabh Jain

>
>> +#endif
>> +
>>   /*
>>    * Called into from start_kernel this initializes memblock, which is used
>>    * to manage page allocation until mem_init is called.
> [...]
>


