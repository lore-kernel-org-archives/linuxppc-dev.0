Return-Path: <linuxppc-dev+bounces-25223-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E743EC55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 04:11:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD3BX0S5Jz309L;
	Mon, 03 Aug 2026 14:11:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785730260;
	cv=none; b=HLnaS45gcAwZGOjqcPlTQgbXTO2LN4tX4Rr1YOz5f8XqTiBGvNEy4m1Un/JMBZvbcYXGEJtQLxn4s7WtlEumAG0LXe4tNvzH2zLmF7MWSu20AuBzcyzOjlEyk4nGK4jL4nNa6FkwsKV5s+vIBY5OkX6BLiWhc/4ToSihe6AygUb8AlFc6wU6mtb7xNcRh4W/5XwNFU/qOUPntWZDSmuW0sg4rxqX37xUF0YTof+07ZAaca7J/Ew+GnYSlKZo9l3wmD+EzmO6W5VmZQSmwgqj8oxgykzZGm8M5/zT1B51dKmPja4P7gN1BJPWOcsYFA5IAw1qyh+y6kFu72jIbSTalw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785730260; c=relaxed/relaxed;
	bh=jPi9KFJ4I5qkfQdVe8y6Wt9JN9ezAV5CrIogg7iBezw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jE0tmreQAtP3K6qsiEiKDGYc4iaVg8dLoq7qfbw3SCxr/1FW7mI+x2m5XUTmQ/qHCMWGRpBIHU9YdlxkUQqSw1RTTgUNh/E0shX89eg2KIoEMKXRyZO3NYR2J9a0DMHEYDlkgRH5uVmYpA7SKui4x2F16vH18o/nmqjnAHEp2s2Ua7PCUVBteIuN0D0MBSfNZv8ldv5hAnACTXFqNZ7Y/rOOVH5RDNjOJ/cA3s50f8bhIJ7ThaN4imcKJXucjp1y+uGD4YKf0JePeo6JsXB7gzlSB1uawzJtu7wbtPS1Bj5nAU6epH0g7h4kFsHP01zFAP6cnuw5WxrtGixVUQ8+SA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YXUJFCsr; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YXUJFCsr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD3BW2LkPz3092
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 14:10:59 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LnRFX246776;
	Mon, 3 Aug 2026 04:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jPi9KF
	J4I5qkfQdVe8y6Wt9JN9ezAV5CrIogg7iBezw=; b=YXUJFCsrkpzOTef9kwDcvZ
	QOibUppp6E9ll9CRkrIz0HQP+zLECPac2EkedCHFOQlZybYaTVh3ISrjlsWcvSL4
	KJTIccsiLBNjL748OuvrhvS1Qlh1/ODMHmnbfNn77AbF0cAavIpGxJ4eZh55xWmw
	5+wmMXLXAodUgUJ6888GoEMeqoA8kfKFSEr0xXuys3d11CLkJFRek014FU3b6ABU
	Dd7xYuLVF9Dw47Wt/7FXjXkQkOCsaewXqqK0LTy97YnSPuqeWJBwVRcYHQ9M9sjO
	9NnC4jWHPDQuqbmg/WpwmisinYX+J+a+fl/dj3RMjkkT44F8BiiHyMz9TOFJ2mGg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4pqjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 04:10:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6733uFox021398;
	Mon, 3 Aug 2026 04:10:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh3m5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 04:10:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6734AfRP29950430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 04:10:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCA4020043;
	Mon,  3 Aug 2026 04:10:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 782352004D;
	Mon,  3 Aug 2026 04:10:39 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 04:10:39 +0000 (GMT)
Message-ID: <ef4635e2-6971-4125-99c3-a96e2f5a9d10@linux.ibm.com>
Date: Mon, 3 Aug 2026 09:40:38 +0530
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
 <ffd8a15f-9526-413d-8a0e-f86b4b6964b8@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ffd8a15f-9526-413d-8a0e-f86b4b6964b8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAyOSBTYWx0ZWRfXzCZgJfvCGgW0
 U9wz0+adTy0gdH2ypGna4Ye+XMXqFT/w2fFuIUDOI6C4qtazJ++EsIM9dgfaKIS7kdep7wzylhI
 oSAgEFypCwKzCGSys1c1hneg+iPcPW0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAyOSBTYWx0ZWRfX0Kx8tHCmIyiU
 4l6nnHQkPNobGo+/ZTdZnbz4ZJE02z2auhOl9rd9hl174z1zr4xC5UevEplcXhg9beZ1IkgqKme
 eyfwlvccDF5LyKsXbSg7FClm7TZSe3oxsbFol6R02cGrBFkMQsd9Z6mZvT1hSktOYJBA7cCHE6B
 YTa52lDgMDrH4PmSUT8InNvknc/75Ogb/6UgXCdfR6NazrXB0f21hoTROTw8Fv/JoSTEiiMgeXA
 8I41GRYveXp9knmN8LUqZoODrcrTEgZQv7HAHuIU3kIcJymUGkhN7GjeMYai95u6X6k3eoVDqK+
 +jCdwvfAGUCwqMdjCSgClSAiez5YxqRijua0SjyoPdwe/k93zjL2iyI5jsDWWSeJi59GcJ4+5fU
 62lG2TOlLM4lH6cyaUTDGOapo13g+Cmeza782VvNibCIWyQujf1rI6q71blk6UJDFP99f8P+sg/
 XCfeWFiL5cJYEQncCDg==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a7014c7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=M53gW7DFudA35W5FFxMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: oUbJUDjX1jxn5m96RxZ6uqKwHu6vkne4
X-Proofpoint-GUID: OHtzVqnmEXqfmMGO-YmHSepnOawWZnPS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030029



On 26/07/26 16:53, Hari Bathini wrote:
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
> !CONFIG_PPC_RTAS case seems counter-intuitive.
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
>
>> +static bool high_crashkernel_supported(void)
>> +{
>> +#if defined(CONFIG_PPC64) && (defined(CONFIG_PPC_PSERIES) || 
>> defined(CONFIG_PPC_POWERNV))
>> +    if (early_radix_enabled() && is_rtas_high_crashkernel_capable())
>> +        return true;
>> +#endif
>> +    return false;
>> +}
>
> Have this function that accounts for high crashkernel support in
> different scenarios and drop is_rtas_high_crashkernel_capable()? 

Agree.

- Sourabh Jain


