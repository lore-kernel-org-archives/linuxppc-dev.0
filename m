Return-Path: <linuxppc-dev+bounces-24841-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9246CC531CC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2026 11:29:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7KHz129jz2yd7;
	Sun, 26 Jul 2026 21:29:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785065359;
	cv=none; b=o0eihzh0vKpXa/BfwHIVDa2kJi/geGmiuHTI/2OzBiioTSa+/n27S+Br0k7CtXgwhJaXM0DoXes1YjF4CLwq2K2/Ply6HW+cCzQp8lN0oE4sfFnMfMzbn8hxNFSeerr+weW5SYkgb/OWuWzxUhnImb2ZA3SxJW12/2KIS94FqSeCC9WUcZ1mlLxl5lQhO9GnrXVpKMsJZFUrNSGrnWiFQLRm8SmW2kVS7Dvd4NmzKd2A9LF7GvohSBYA6nLMwATfvEqsvKlyrjBlWVMkiUjjjPeF02AZq7AQZ/L2TTlgQBPaTxOtDX21J8joQgJnPO+RoFZ+a4ZolV6k6UZTDb3O+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785065359; c=relaxed/relaxed;
	bh=1gKc/tEHvIl6NSsUGto1KyvngLRO0l7pwSc7l5wphWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juoiGJeHxNSmSrhhOI/p5sqe7ptzAjA2lenu4sIhwmyVsuel5uK6OxksmuA/DEXj1drP/i5k3FOoJqtIQEb30/b+uA/NKRmUji0xvG0vNWZ/VEV1xvaQVdFOo0Q8HnFc9VdfZB8LLJnVZRdsAg8pxLhslwiqM6dWRORyjOJSsyq8rN2p7IM6cAvWTl0euPIBpLYbAZelfLhAsIjQ2tEuRF69LjEJH1pv5MF4BrhCQfbMab7s2hMGzTmWRbY75mRyX3roLsy2RPrXCdPGxZ5wvjEY/eUILQFomt0jHT7HAMJFOIlF7NsLTMFzuvsloP1LcM/ts8lmeniP9/BrYWCoxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=il+5rbZc; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=il+5rbZc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7KHx71ylz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 21:29:17 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QBHaBg1467447;
	Sun, 26 Jul 2026 11:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1gKc/t
	EHvIl6NSsUGto1KyvngLRO0l7pwSc7l5wphWE=; b=il+5rbZcVZ/Xi9CY2Cgkgm
	FDjl/GRxQ37Do8ztELmeXQO1UucXK93Dp4zoWPtVg/dZsRAFEDiTzdiSAPJuaJB+
	TfSoO+zcH6AzdU3qD1fUuZwmU5NO+FmevEDz4k12KBHzJnQ72FMQoi09el/AncRJ
	Kr8lzZgIAviRa9tlgfopwCZ/98HpVD4M8oy51vjEbqZTkY4X0tLAq+vCa6XtlsiH
	woeS5Eirv4X6UWkgrZpwgcTgpORTWnuAf6ZxoKTB5W+vfJrH5sE7kJiCP7RCjLQz
	7kxnisKKtEDj4icgBFtLNruG83EeJuR17Hhq+i/pBQUYcBU5Bl+tvpAdFW/xAsPA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc3du7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 11:29:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66QBQQFv015424;
	Sun, 26 Jul 2026 11:29:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uvsg4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 11:29:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66QBT2IY32506246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 11:29:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98651200A7;
	Sun, 26 Jul 2026 10:57:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72043200A5;
	Sun, 26 Jul 2026 10:56:56 +0000 (GMT)
Received: from [9.124.223.5] (unknown [9.124.223.5])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 26 Jul 2026 10:56:56 +0000 (GMT)
Message-ID: <30f314c6-35ae-4fec-b6b4-41e57d013c75@linux.ibm.com>
Date: Sun, 26 Jul 2026 16:26:55 +0530
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
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        shivangu@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com
References: <20260708143357.673251-1-sourabhjain@linux.ibm.com>
 <20260708143357.673251-5-sourabhjain@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260708143357.673251-5-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 89Yb6WM1QG86L6o7WeS7MFOWZkpvRGOe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDExMyBTYWx0ZWRfX+kKmFhDau3ph
 gY0M/dQlL5KhlFdsgEsFmenCMFlkSRXDH0Ry7ITxdtbIaw3Uk543I6loml5xadE+D0DEXbZAvzC
 v7NdFmTAt0IPV87XzrcOg7GWpB/Rohqjkax2WL6RGFqPFrPS0bEXxtD1p8+QfD0AKwZZJfr2YbK
 nTGoehLkQFaX1JmQVFykCETJh+xW6cjVD/jE+rDrr9DQzuBoPzKFoU9pl4U3QkbDOvw1JSbVffH
 +uanKEYsdT8MCGu9G0YwIxjfPVY3xDicrHNgPB7SA0exWASJf9RWratfIg1wuXWPB3eF5b3mPdj
 WeFqRHIe02IxIUNOXlOAMIIjbJidsmxdAwwc3yoB1LY6AEada15V/WGgoXzIEWte7xrX9zcz1au
 NLMuPYH4zzJHxNVXWMcmheoaEWn+FL68SIh6COZ5Pf/LKWX8VUNcAg5GbQRW1Vcnhcoc5RLj/9g
 N4mkLrlyEOFRoj8MmsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDExMyBTYWx0ZWRfXw9r/te/qorep
 KoZIXY/bEefWbcmGKOulyFUz3G80JHgf8ktutGJ/ihRkgbnN3jAdSLYA8YvzptFzMfOahIgUGBA
 TG01LBlpzJzmp6XeekLIRCBVrY0AqTw=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a65ef84 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=RZoRp3Lhb-INW950ffIA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: T4E5GGTODsV15z-5dQp2f3wD-cn3x0m8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260113



On 08/07/26 8:03 pm, Sourabh Jain wrote:
> With this changes included crashkernel=xxM,high will be supported on
> powerpc. This allow user to allocated crashkernel memory on higer memory
> region and keeping the low memory allocation minimal.
> 
> The low memory reservation is by default set to 64 MB and it is reserved
> below RTAS_INSTANTIATE_MAX (1G) to make sure rtas instantiation work
> properly.
> 
> powerpc uses generic crashkernel parser and reserve functions and they
> are capable of handling high crashkernel reservtion so
> arch_reserve_crashkernel() is updated call generic crashkernel praser
> and reserve function with resptive options to make
> crashkernel=XXM,high prase and make crashkernel memory get reserved on
> higher memory regions.
> 
> Note: High crashkernel is supported only on PPC 64-bit systems when
> 64-bit RTAS is instantiated and Radix MMU is enabled; otherwise, the
> crashkernel reservation falls back to the default, even if the kernel
> command includes crashkernel=XXM,high.
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/crash_reserve.h |  6 ++++
>   arch/powerpc/include/asm/kexec.h         |  1 +
>   arch/powerpc/include/asm/rtas.h          |  9 +++++
>   arch/powerpc/kexec/core.c                | 45 +++++++++++++++++-------
>   4 files changed, 49 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/crash_reserve.h b/arch/powerpc/include/asm/crash_reserve.h
> index d1b570ddbf98..4f2096984736 100644
> --- a/arch/powerpc/include/asm/crash_reserve.h
> +++ b/arch/powerpc/include/asm/crash_reserve.h
> @@ -2,6 +2,8 @@
>   #ifndef _ASM_POWERPC_CRASH_RESERVE_H
>   #define _ASM_POWERPC_CRASH_RESERVE_H
>   
> +#include <asm/rtas.h>
> +
>   /* crash kernel regions are Page size agliged */
>   #define CRASH_ALIGN             PAGE_SIZE
>   
> @@ -12,5 +14,9 @@ static inline bool arch_add_crash_res_to_iomem(void)
>   }
>   #define arch_add_crash_res_to_iomem arch_add_crash_res_to_iomem
>   #endif
> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE SZ_64M
> +
> +#define CRASH_ADDR_LOW_MAX	RTAS_INSTANTIATE_MAX
> +#define CRASH_ADDR_HIGH_MAX	memblock_end_of_DRAM()
>   
>   #endif /* _ASM_POWERPC_CRASH_RESERVE_H */
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index e02710d6a2e1..9e676bd3bf03 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -118,6 +118,7 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt, struct crash_mem
>   int __init overlaps_crashkernel(unsigned long start, unsigned long size);
>   extern void arch_reserve_crashkernel(void);
>   extern void kdump_cma_reserve(void);
> +unsigned long long __init get_crash_base(unsigned long long crash_base);
>   #else
>   static inline void arch_reserve_crashkernel(void) {}
>   static inline int overlaps_crashkernel(unsigned long start, unsigned long size) { return 0; }
> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> index aaa4c3bc1d61..d290437d8131 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -561,6 +561,14 @@ static inline int page_is_rtas_user_buf(unsigned long pfn)
>   	return 0;
>   }
>   
> +static inline bool is_rtas_high_crashkernel_capable(void)
> +{
> +	if (rtas_64)
> +		return true;
> +
> +	return false;
> +}
> +
>   /* Not the best place to put pSeries_coalesce_init, will be fixed when we
>    * move some of the rtas suspend-me stuff to pseries */
>   void pSeries_coalesce_init(void);
> @@ -569,6 +577,7 @@ void rtas_initialize(void);
>   static inline int page_is_rtas_user_buf(unsigned long pfn) { return 0;}
>   static inline void pSeries_coalesce_init(void) { }
>   static inline void rtas_initialize(void) { }

> +static inline bool is_rtas_high_crashkernel_capable(void) { return true; }

Though !CONFIG_PPC_RTAS may imply radix MMU and high crashkernel
capable, is_rtas_high_crashkernel_capable() returning true for
!CONFIG_PPC_RTAS case seems counter-intuitive. Have a single
generic (non-rtas specific) function that accounts for high
crashkernel support in different scenarios?

>   #endif
>   
>   #ifdef CONFIG_HV_PERF_CTRS
> diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
> index dc44f11be353..81fc437377c8 100644
> --- a/arch/powerpc/kexec/core.c
> +++ b/arch/powerpc/kexec/core.c
> @@ -15,6 +15,7 @@
>   #include <linux/irq.h>
>   #include <linux/ftrace.h>
>   
> +#include <asm/rtas.h>
>   #include <asm/kdump.h>
>   #include <asm/machdep.h>
>   #include <asm/pgalloc.h>
> @@ -64,7 +65,7 @@ void machine_kexec(struct kimage *image)
>   
>   static unsigned long long crashk_cma_size;
>   
> -static unsigned long long __init get_crash_base(unsigned long long crash_base)
> +unsigned long long __init get_crash_base(unsigned long long crash_base)
>   {
>   
>   #ifndef CONFIG_NONSTATIC_KERNEL
> @@ -104,35 +105,55 @@ static unsigned long long __init get_crash_base(unsigned long long crash_base)
>   #endif
>   }
>   
> +static bool high_crashkernel_supported(void)
> +{
> +#if defined(CONFIG_PPC64) && (defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV))
> +	if (early_radix_enabled() && is_rtas_high_crashkernel_capable())
> +		return true;
> +#endif
> +	return false;
> +}
> +
>   void __init arch_reserve_crashkernel(void)
>   {
> -	unsigned long long crash_size, crash_base, crash_end;
> +	unsigned long long crash_size, crash_base, crash_end, low_size = 0;
>   	unsigned long long kernel_start, kernel_size;
>   	unsigned long long total_mem_sz;
> +	bool high = false;
>   	int ret;
>   
>   	total_mem_sz = memory_limit ? memory_limit : memblock_phys_mem_size();
>   
>   	/* use common parsing */
>   	ret = parse_crashkernel(boot_command_line, total_mem_sz, &crash_size,
> -				&crash_base, NULL, &crashk_cma_size, NULL);
> +				&crash_base, &low_size, &crashk_cma_size, &high);
>   
>   	if (ret)
>   		return;
>   
> -	crash_base = get_crash_base(crash_base);
> -	crash_end = crash_base + crash_size - 1;
> +	if (high && !high_crashkernel_supported()) {
> +		high = false;
> +		low_size = 0;
> +		pr_warn("High crashkernel unsupported, using standard reservation");
> +	}
>   
> -	kernel_start = __pa(_stext);
> -	kernel_size = _end - _stext;
> +	if (high) {
> +		crash_base = 0;
> +	} else {
> +		crash_base = get_crash_base(crash_base);
> +		crash_end = crash_base + crash_size - 1;
>   
> -	/* The crash region must not overlap the current kernel */
> -	if ((kernel_start + kernel_size > crash_base) && (kernel_start <= crash_end)) {
> -		pr_warn("Crash kernel can not overlap current kernel\n");
> -		return;
> +		kernel_start = __pa(_stext);
> +		kernel_size = _end - _stext;
> +
> +		/* The crash region must not overlap the current kernel */
> +		if ((kernel_start + kernel_size > crash_base) && (kernel_start <= crash_end)) {
> +			pr_warn("Crash kernel can not overlap current kernel\n");
> +			return;
> +		}
>   	}
>   
> -	reserve_crashkernel_generic(crash_size, crash_base, 0, false);
> +	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
>   }
>   
>   void __init kdump_cma_reserve(void)

- Hari

