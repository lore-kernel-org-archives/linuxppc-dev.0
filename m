Return-Path: <linuxppc-dev+bounces-25222-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7514C5516F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 04:10:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD39m4sglz3092;
	Mon, 03 Aug 2026 14:10:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785730220;
	cv=none; b=nI7iYYw6L8A3jWEFgUGaZGt2HYp9aOByQkUHlhbmCa/7AqRGSFhDi8yHeMWpcA00keeC2cagUbL/Qt1g0QE8mkHrNt5W91ojMDSEItr839tryfuDAGQ4t7Y76BnQpiiEn062QInqmfoVxhhclh/O1h/IADu0l8YdsO+dmsAttGBar8xDP+G/rvxiG5TtVJ+lrxq6PzKvdS4d+M/z4IdIyrwy9NXbGkmW2aRrqFDr/vPa7A+L7h8jH0LTY3HUk8KWcXkkEJu9Q1m7IHTaixsf5TH/vvZsKj+eRUwtuEW/roIeDuiquX6S8Cy416nxru0K4be0p6bYCbFbaUDhPJfCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785730220; c=relaxed/relaxed;
	bh=mRmpwLHpUW97vUAr52T7Q1kNheV/Sr7fxok18coC6cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bU+cONL/g+0UimtT+MQlDSbrjpeCRuzlS5bMeKRIwchefueI7FaVpUhUfxNunIZQ/7P6rItlhbNGcCRWCi0nYr7v2OTZzrTgZd4pCadQA4uV57YccRDe3t0LZjLBBh22CZyOzcExe10p7qp2ksZ4+e7gMf9Pa0ZHjL8QN5SujtaEMON604IAy4dz84eGHhnoyTQPqU4/cFkQS/h/LC6hEydurBTFuSUrHS447l0oLs8wuWkUm22OTYhpTK3qB8chKlRsxgN0OHLnQEsOmHE5E8EJ7hPVkEVR1KLJbbE2RUkmMJ6k7wY8DG6sah6HjhAaFWjEoyS2B21bJrpz6INahw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a9tD+h3J; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a9tD+h3J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD39l46S8z308Y
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 14:10:19 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LlkdN223083;
	Mon, 3 Aug 2026 04:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mRmpwL
	HpUW97vUAr52T7Q1kNheV/Sr7fxok18coC6cI=; b=a9tD+h3JwYhKtkpYUNji7+
	fqtPUuqLlP76h7txWkCxlvCYl0PqznloDzuatiFLbb2EBHtjILFeyYXzkX+JEftc
	Qbw6E4SbEI8WqdAljU01eOY7oDwjkD8zuhOWZozKOtR94NKIllGafa/+9KvHLFik
	z3O4D1ZTDdiiuE+2Ng2luNn2LpzCkj8cM0BFTb/5jAvf709HObqhZEUisRoMgtFA
	93MNGJoQ1AHVP/6U48htl1yUNgzayaqu5f2rpMSS/cA++O5xZ25FqgBbjkeO3jJN
	b3bTJaIuNfNJidZtbrLP+1iQfhzxmXr/u1Ai4HvU09NqAlh8OMDyXBN2Y+XJRi4Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3prg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 04:09:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6733uOO5013645;
	Mon, 3 Aug 2026 04:09:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvurb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 04:09:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67349qVe29032828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 04:09:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE44820043;
	Mon,  3 Aug 2026 04:09:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C8CD20040;
	Mon,  3 Aug 2026 04:09:50 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 04:09:50 +0000 (GMT)
Message-ID: <30ba5292-978d-4273-9862-61ee6e96cb11@linux.ibm.com>
Date: Mon, 3 Aug 2026 09:39:49 +0530
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
Subject: Re: [PATCH v2 4/4] powerpc/kdump: add support for high crashkernel
 reservation
To: Hari Bathini <hbathini@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        shivangu@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com
References: <20260708143357.673251-1-sourabhjain@linux.ibm.com>
 <20260708143357.673251-5-sourabhjain@linux.ibm.com>
 <30f314c6-35ae-4fec-b6b4-41e57d013c75@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <30f314c6-35ae-4fec-b6b4-41e57d013c75@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a701496 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=fv8C12OSLEPNc-T-zucA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: xVpAJ0qyT6FfYhz2NzVVkrJlzDeK6svx
X-Proofpoint-GUID: wPSQcNWzB0HK5iaxQ7liASl_Hu685hfr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAyOSBTYWx0ZWRfX8H47A91JiW4b
 vuDne3SMQj++kVmtfAc4/s0LfjMaIm8gBp1al81CDx0RqgP18M8EKl/vjvGX1lTdbkYauVhCi88
 k23BGsfmYjeXYvw8+KHgfd5uzaJA3/A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAyOSBTYWx0ZWRfX56N0psdtSicA
 kCyOHiai+Nb0d92Yogmthe7i2DtyGwibetK3ToIcnNh8v3gIwHvxdSS55pr2j1EFEQYlfPmGQQx
 kl13IuaTc+WT5+YlCtunTzAi7ytscsUwxPxv9z3dX9yBca6Li0vFflnDfB3lPG5iyTR+5Mtq6Dz
 5bJ1UdNZjsnZgB1xDwAK+j9xw8lP5Lww5YgqTKk3gpr44fjdqWZMIouKsuqXCdldPy+B5BbhFTV
 gEeAlt7ig7oZf8opHzEuB7LafqbPwCF0vnfFNt2wKNB8evMIl7uKgEF3bkEAfsLFjDM0201tb2U
 bei+02uuH/c100FDpyGvCMQ4XN/mIQS8SkTDGZlokAiToAa/Fejrq054PMUVzZ61NV63hDFnSFO
 RiGUNRgY2UuYI1JTBtcmLlRN9BYT1/8ehvHWzVdiwve/4hOWl48wS1MnnWqWXeozc1td4Wt86zt
 1lm1FPIJN35SBfPtXLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030029



On 26/07/26 16:26, Hari Bathini wrote:
>
>
> On 08/07/26 8:03 pm, Sourabh Jain wrote:
>> With this changes included crashkernel=xxM,high will be supported on
>> powerpc. This allow user to allocated crashkernel memory on higer memory
>> region and keeping the low memory allocation minimal.
>>
>> The low memory reservation is by default set to 64 MB and it is reserved
>> below RTAS_INSTANTIATE_MAX (1G) to make sure rtas instantiation work
>> properly.
>>
>> powerpc uses generic crashkernel parser and reserve functions and they
>> are capable of handling high crashkernel reservtion so
>> arch_reserve_crashkernel() is updated call generic crashkernel praser
>> and reserve function with resptive options to make
>> crashkernel=XXM,high prase and make crashkernel memory get reserved on
>> higher memory regions.
>>
>> Note: High crashkernel is supported only on PPC 64-bit systems when
>> 64-bit RTAS is instantiated and Radix MMU is enabled; otherwise, the
>> crashkernel reservation falls back to the default, even if the kernel
>> command includes crashkernel=XXM,high.
>>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/crash_reserve.h |  6 ++++
>>   arch/powerpc/include/asm/kexec.h         |  1 +
>>   arch/powerpc/include/asm/rtas.h          |  9 +++++
>>   arch/powerpc/kexec/core.c                | 45 +++++++++++++++++-------
>>   4 files changed, 49 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/crash_reserve.h 
>> b/arch/powerpc/include/asm/crash_reserve.h
>> index d1b570ddbf98..4f2096984736 100644
>> --- a/arch/powerpc/include/asm/crash_reserve.h
>> +++ b/arch/powerpc/include/asm/crash_reserve.h
>> @@ -2,6 +2,8 @@
>>   #ifndef _ASM_POWERPC_CRASH_RESERVE_H
>>   #define _ASM_POWERPC_CRASH_RESERVE_H
>>   +#include <asm/rtas.h>
>> +
>>   /* crash kernel regions are Page size agliged */
>>   #define CRASH_ALIGN             PAGE_SIZE
>>   @@ -12,5 +14,9 @@ static inline bool arch_add_crash_res_to_iomem(void)
>>   }
>>   #define arch_add_crash_res_to_iomem arch_add_crash_res_to_iomem
>>   #endif
>> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE SZ_64M
>> +
>> +#define CRASH_ADDR_LOW_MAX    RTAS_INSTANTIATE_MAX
>> +#define CRASH_ADDR_HIGH_MAX    memblock_end_of_DRAM()
>>     #endif /* _ASM_POWERPC_CRASH_RESERVE_H */
>> diff --git a/arch/powerpc/include/asm/kexec.h 
>> b/arch/powerpc/include/asm/kexec.h
>> index e02710d6a2e1..9e676bd3bf03 100644
>> --- a/arch/powerpc/include/asm/kexec.h
>> +++ b/arch/powerpc/include/asm/kexec.h
>> @@ -118,6 +118,7 @@ int setup_new_fdt_ppc64(const struct kimage 
>> *image, void *fdt, struct crash_mem
>>   int __init overlaps_crashkernel(unsigned long start, unsigned long 
>> size);
>>   extern void arch_reserve_crashkernel(void);
>>   extern void kdump_cma_reserve(void);
>> +unsigned long long __init get_crash_base(unsigned long long 
>> crash_base);
>>   #else
>>   static inline void arch_reserve_crashkernel(void) {}
>>   static inline int overlaps_crashkernel(unsigned long start, 
>> unsigned long size) { return 0; }
>> diff --git a/arch/powerpc/include/asm/rtas.h 
>> b/arch/powerpc/include/asm/rtas.h
>> index aaa4c3bc1d61..d290437d8131 100644
>> --- a/arch/powerpc/include/asm/rtas.h
>> +++ b/arch/powerpc/include/asm/rtas.h
>> @@ -561,6 +561,14 @@ static inline int page_is_rtas_user_buf(unsigned 
>> long pfn)
>>       return 0;
>>   }
>>   +static inline bool is_rtas_high_crashkernel_capable(void)
>> +{
>> +    if (rtas_64)
>> +        return true;
>> +
>> +    return false;
>> +}
>> +
>>   /* Not the best place to put pSeries_coalesce_init, will be fixed 
>> when we
>>    * move some of the rtas suspend-me stuff to pseries */
>>   void pSeries_coalesce_init(void);
>> @@ -569,6 +577,7 @@ void rtas_initialize(void);
>>   static inline int page_is_rtas_user_buf(unsigned long pfn) { return 
>> 0;}
>>   static inline void pSeries_coalesce_init(void) { }
>>   static inline void rtas_initialize(void) { }
>
>> +static inline bool is_rtas_high_crashkernel_capable(void) { return 
>> true; }
>
> Though !CONFIG_PPC_RTAS may imply radix MMU and high crashkernel
> capable, is_rtas_high_crashkernel_capable() returning true for
> !CONFIG_PPC_RTAS case seems counter-intuitive. Have a single
> generic (non-rtas specific) function that accounts for high
> crashkernel support in different scenarios?

Yeah that's a good point. Having is_rtas_high_crashkernel_capable() for 
!CONFIG_PPC_RTAS
creates confusion. Single function to find high crashkernel support will 
be much better.

- Sourabh Jain

>
>>   #endif
>>     #ifdef CONFIG_HV_PERF_CTRS
>> diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
>> index dc44f11be353..81fc437377c8 100644
>> --- a/arch/powerpc/kexec/core.c
>> +++ b/arch/powerpc/kexec/core.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/irq.h>
>>   #include <linux/ftrace.h>
>>   +#include <asm/rtas.h>
>>   #include <asm/kdump.h>
>>   #include <asm/machdep.h>
>>   #include <asm/pgalloc.h>
>> @@ -64,7 +65,7 @@ void machine_kexec(struct kimage *image)
>>     static unsigned long long crashk_cma_size;
>>   -static unsigned long long __init get_crash_base(unsigned long long 
>> crash_base)
>> +unsigned long long __init get_crash_base(unsigned long long crash_base)
>>   {
>>     #ifndef CONFIG_NONSTATIC_KERNEL
>> @@ -104,35 +105,55 @@ static unsigned long long __init 
>> get_crash_base(unsigned long long crash_base)
>>   #endif
>>   }
>>   +static bool high_crashkernel_supported(void)
>> +{
>> +#if defined(CONFIG_PPC64) && (defined(CONFIG_PPC_PSERIES) || 
>> defined(CONFIG_PPC_POWERNV))
>> +    if (early_radix_enabled() && is_rtas_high_crashkernel_capable())
>> +        return true;
>> +#endif
>> +    return false;
>> +}
>> +
>>   void __init arch_reserve_crashkernel(void)
>>   {
>> -    unsigned long long crash_size, crash_base, crash_end;
>> +    unsigned long long crash_size, crash_base, crash_end, low_size = 0;
>>       unsigned long long kernel_start, kernel_size;
>>       unsigned long long total_mem_sz;
>> +    bool high = false;
>>       int ret;
>>         total_mem_sz = memory_limit ? memory_limit : 
>> memblock_phys_mem_size();
>>         /* use common parsing */
>>       ret = parse_crashkernel(boot_command_line, total_mem_sz, 
>> &crash_size,
>> -                &crash_base, NULL, &crashk_cma_size, NULL);
>> +                &crash_base, &low_size, &crashk_cma_size, &high);
>>         if (ret)
>>           return;
>>   -    crash_base = get_crash_base(crash_base);
>> -    crash_end = crash_base + crash_size - 1;
>> +    if (high && !high_crashkernel_supported()) {
>> +        high = false;
>> +        low_size = 0;
>> +        pr_warn("High crashkernel unsupported, using standard 
>> reservation");
>> +    }
>>   -    kernel_start = __pa(_stext);
>> -    kernel_size = _end - _stext;
>> +    if (high) {
>> +        crash_base = 0;
>> +    } else {
>> +        crash_base = get_crash_base(crash_base);
>> +        crash_end = crash_base + crash_size - 1;
>>   -    /* The crash region must not overlap the current kernel */
>> -    if ((kernel_start + kernel_size > crash_base) && (kernel_start 
>> <= crash_end)) {
>> -        pr_warn("Crash kernel can not overlap current kernel\n");
>> -        return;
>> +        kernel_start = __pa(_stext);
>> +        kernel_size = _end - _stext;
>> +
>> +        /* The crash region must not overlap the current kernel */
>> +        if ((kernel_start + kernel_size > crash_base) && 
>> (kernel_start <= crash_end)) {
>> +            pr_warn("Crash kernel can not overlap current kernel\n");
>> +            return;
>> +        }
>>       }
>>   -    reserve_crashkernel_generic(crash_size, crash_base, 0, false);
>> +    reserve_crashkernel_generic(crash_size, crash_base, low_size, 
>> high);
>>   }
>>     void __init kdump_cma_reserve(void)
>
> - Hari


