Return-Path: <linuxppc-dev+bounces-26299-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235D6C624A5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 14:55:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYX973H4Dz2y2J;
	Tue, 01 Sep 2026 00:55:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788188123;
	cv=none; b=MzHat4bGhktrMY8VmTpuQzUmPwPLbps5p7O9zWi3Xo0c42d7goTuNbZT7WyJKcEuhm6GGR1VIKrzlVYsl7rRJEcYvya0yUzoQ1LXE3SDAcMsYMqrMXcr4VpPM8jcGGiIY8N+Hms5EIntR8H2o6bgzEMQESYx9XNvut8BeGmxcAU0gswE/zF7aFSuSvO7UvJr+byP2B+B0HV6qOd+iv4S05V7qWeSdRC1Mkgs4PRs1cWppd5Ofx0gNc9LF5tTpbLGR2Lg8WsUVAIGUFqriKbWxNLTgj47lvMPWRw/ZzFB63LUE58uEwuGPY7lMuAPQOMD4b5PzBa0jk/U5qe9h9hDtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788188123; c=relaxed/relaxed;
	bh=1fxtE9eeS9Yt+xUAsP37ppCuAO30jFY/gxbihtekrqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8fsXGHtrzt+AUgQksdeJmoNKlY8DOD6ZIjCUQXR/jOztrXS5BvxWfX1ts8BjlxJI/nSn0Wc/5P2C6w5VfKtfeMNPWM9ppSw+Rf6cI0KB4cAekuiEI7FreT1wiHbQRWgKNyAY4eRx6WMBdfUmaRaG6PHRchFsUYNLZp4zarIqptAPg8qcQevzMU6fFu5H+aYAe/IbFDA1god0Y8XiYkvOyetO0u6Zkt158o6imbvpXwv5sDEAVU9f0bfNMQqeFsxLce7Oe+SaxAytDIrOzNDtsxTZzLEAJ8o0WniBLy12PtAwNcNelGupdKYp0Am1b7f0BS5FAN+omNGYYfPd+eNAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JqKnRYll; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JqKnRYll;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYX962Xbmz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 00:55:22 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ9EP652844;
	Mon, 31 Aug 2026 14:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1fxtE9
	eeS9Yt+xUAsP37ppCuAO30jFY/gxbihtekrqs=; b=JqKnRYllf0YlUISERaPHJH
	VLNdBt1AS7RwK+Wg2K0bv0nEPp6At/47XNYbEe+my/+ixur+Q0pQJ3hwysgGVx35
	bRPGXIS8MKTuxUyRcvckmSDAHBQ6IFoa+F1qF87A2Mg5vK4TfAjjtoZA5sskuAYy
	l8Y0inxyfolGTB6H3c+NznIA1XhSpOOzgzOe3jkfDFw27b2s91hbI32XhbKW1nNq
	AGYek8rplu5gxI7kjEie5RgdOz0s292oavg/hjRksInzLVuwMaEbgImMRJMyTmsC
	XAczUBZBWpdGOzxTAXg7tajsbvsFcW0GUkf309gH4tAw7A6yLSuSyfF2wFEmFqDQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r2056-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfjJp000540;
	Mon, 31 Aug 2026 14:55:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg6a5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEt39646334250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BABE820043;
	Mon, 31 Aug 2026 14:55:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4672620040;
	Mon, 31 Aug 2026 14:55:00 +0000 (GMT)
Received: from [9.124.217.83] (unknown [9.124.217.83])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:00 +0000 (GMT)
Message-ID: <d43bd71d-d5a3-45df-bf49-8a5e617061ac@linux.ibm.com>
Date: Mon, 31 Aug 2026 20:24:59 +0530
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
Subject: Re: [PATCH v3 2/5] powerpc/rtas: Allocate ibm,errinjct buffer below
 RTAS limit
To: Sourabh Jain <sourabhjain@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
 <20260721033815.5300-3-nnmlinux@linux.ibm.com>
 <9c12964a-f35a-464a-8e65-e0e9fa674819@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <9c12964a-f35a-464a-8e65-e0e9fa674819@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9595ce cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=0DTG2NOfNbhX3YZ-qi4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX7+Ibm2ae0A76
 vnPNDi8D0vMBFJzQckiGfEQmpSuxSySr/YSUGDOFibNP5skU3lwk13Dhtk0tD0Y2NKj+1g0xpuU
 XL+8mVgmcRvWgwBOnweus5uC4StwEIczZdM8XAh/QpG3PWa377CCJjjaJcAOJhmpyX24vUlRH0e
 QzHh5jkCoBiToCrqHpkoP/9h6zahw71ZbTeYJhKYWe/DIVMGdhIQFGiIbzxLiU6/0M17tcLk63J
 31Hk3yS73A6wxfiVCf+KL5CAW00S8hSdpyICHi3cVOvVXwdEXQwzewcLAGOVMFL5a82mhWOJ0Cu
 VGxfgZnchJer8zkmkdR9I5JiubS6SQqjwOX3SUw2qxivXbcErZyy34pdW6s1WQfJLKxnVDe38QT
 QHVsFhlompyphY8rmtgDEMTKbo9BqOTNVp+0LxWNUOzo2ilpItvOrj7WctDK6ooBibYICIO2bMB
 Mqfnwnzy2r/TrPFuJVA==
X-Proofpoint-GUID: T-nBCFkRvkMzPYFWg2cV6jWFHjDK2uSY
X-Proofpoint-ORIG-GUID: XX_lvHF8GkwY7uv6rwN7UJbeeO_qn_zf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXyEwbxo3VmHCA
 l1pfBiqMPKfpr0H17ZAEBRHhYhxk5J2LnUuiF/kYCnJx96Aoq4eFJJr5rjKuv8zVc8eXFiUvOlK
 thtX18Z/nkrrJ+i4EXM7XTPCvm1YhLY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

Hi Sourabh,

On 04/08/26 12:52 PM, Sourabh Jain wrote:
> Hello Narayana,
> 
> How about using the rtas_work_area_alloc() instead of allocating a new 
> dedicated buffer
> for errinjct only?
> 
> Checkout Commit 43033bc62d34 ("powerpc/pseries: add RTAS work area 
> allocator") for
> infrastructure to allocated working buffer.
> 
> Also checkout commit e27e14231eb5 ("powerpc/pseries/dlpar: use RTAS work 
> area API")
> on how to use work area API.
> 
Agreed. I reworked this in v4 to use the RTAS work area allocator 
instead of adding a dedicated global rtas_errinjct_buf.

The v3 approach allocated a separate error-injection buffer during
rtas_initialize(), but that is not necessary now that the RTAS work area
allocator already provides the right infrastructure for RTAS-accessible 
working buffers.

In v4, the pseries error-injection path allocates a work area for the 
RTAS parameter buffer, fills it using the mapped kernel address, passes 
the RTAS-visible physical address to firmware, and frees the work area 
after the open/inject/close sequence.

This also removes the extra global buffer only for error injection.

Thanks,
Narayana

> - Sourabh Jain
> 
> On 21/07/26 09:08, Narayana Murty N wrote:
>> ibm,errinjct requires a caller-provided work buffer whose physical
>> address is passed to RTAS firmware.
>>
>> A static C array such as:
>>
>>    char rtas_errinjct_buf[1024] __aligned(SZ_1K);
>>
>> only guarantees alignment, not physical placement.  If the array lands
>> above the RTAS-safe range (RTAS_INSTANTIATE_MAX, 1 GB) or above 4 GB,
>> RTAS receives a truncated or invalid address and the injection call
>> will fail silently or corrupt memory.
>>
>> Instead, introduce rtas_errinjct_buf as a global unsigned long storing
>> the physical address allocated during rtas_initialize() using
>> memblock_phys_alloc_range() with the same rtas_region upper bound used
>> for rtas_rmo_buf.  This matches the existing placement model for
>> RTAS-accessible buffers and guarantees the physical address fits in 32
>> bits.
>>
>>    Usage:
>>      void *buf    = __va(rtas_errinjct_buf);       /* kernel VA to 
>> fill */
>>      u32  buf_phys = lower_32_bits(rtas_errinjct_buf); /* PA for RTAS */
>>
>> Always check upper_32_bits(rtas_errinjct_buf) == 0 before passing the
>> lower 32 bits to RTAS.
>>
>> Add rtas_errinjct_mutex to serialise the complete open-session /
>> inject / close-session firmware call sequence.  A mutex is required
>> because the sequence involves multiple rtas_call() invocations with
>> possible busy/extended-delay retries that may sleep.
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/rtas.h | 26 ++++++++++++++++++++++++++
>>   arch/powerpc/kernel/rtas.c      | 17 +++++++++++++++++
>>   2 files changed, 43 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/ 
>> asm/rtas.h
>> index d046bbd5017d..59e3c1296018 100644
>> --- a/arch/powerpc/include/asm/rtas.h
>> +++ b/arch/powerpc/include/asm/rtas.h
>> @@ -4,6 +4,7 @@
>>   #ifdef __KERNEL__
>>   #include <linux/mutex.h>
>> +#include <linux/sizes.h>
>>   #include <linux/spinlock.h>
>>   #include <asm/page.h>
>>   #include <asm/rtas-types.h>
>> @@ -519,6 +520,31 @@ int rtas_get_error_log_max(void);
>>   extern spinlock_t rtas_data_buf_lock;
>>   extern char rtas_data_buf[RTAS_DATA_BUF_SIZE];
>> +/*
>> + * RTAS error-injection work buffer.
>> + *
>> + * ibm,errinjct requires a caller-provided work buffer whose physical
>> + * address is passed to firmware.  A static C array only guarantees
>> + * alignment, not physical placement; if it lands above the RTAS-safe
>> + * range or above 4 GB, RTAS receives a truncated or bogus address.
>> + *
>> + * rtas_errinjct_buf stores the physical address allocated during
>> + * rtas_initialize() using memblock_phys_alloc_range() with the same
>> + * rtas_region upper bound used for rtas_rmo_buf, matching the existing
>> + * placement model for RTAS-accessible buffers.
>> + *
>> + * Use __va(rtas_errinjct_buf) to obtain the kernel virtual address for
>> + * filling the buffer, and lower_32_bits(rtas_errinjct_buf) to pass the
>> + * physical address to RTAS (after checking upper_32_bits() == 0).
>> + *
>> + * rtas_errinjct_mutex must be held across the complete
>> + * ibm,open-errinjct / ibm,errinjct / ibm,close-errinjct sequence.
>> + */
>> +#define RTAS_ERRINJCT_BUF_SIZE    SZ_1K
>> +
>> +extern unsigned long rtas_errinjct_buf;
>> +extern struct mutex rtas_errinjct_mutex;
>> +
>>   /* RMO buffer reserved for user-space RTAS use */
>>   extern unsigned long rtas_rmo_buf;
>> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
>> index 27d53f34494d..7883f973e8c9 100644
>> --- a/arch/powerpc/kernel/rtas.c
>> +++ b/arch/powerpc/kernel/rtas.c
>> @@ -769,6 +769,17 @@ EXPORT_SYMBOL_GPL(rtas_data_buf);
>>   unsigned long rtas_rmo_buf;
>> +/*
>> + * Physical address of the ibm,errinjct work buffer.  Allocated during
>> + * rtas_initialize() using memblock_phys_alloc_range() below rtas_region
>> + * so the address fits in 32 bits and is safe to pass to RTAS firmware.
>> + */
>> +unsigned long rtas_errinjct_buf;
>> +EXPORT_SYMBOL_GPL(rtas_errinjct_buf);
>> +
>> +DEFINE_MUTEX(rtas_errinjct_mutex);
>> +EXPORT_SYMBOL_GPL(rtas_errinjct_mutex);
>> +
>>   /*
>>    * If non-NULL, this gets called when the kernel terminates.
>>    * This is done like this so rtas_flash can be a module.
>> @@ -2109,6 +2120,12 @@ void __init rtas_initialize(void)
>>           panic("ERROR: RTAS: Failed to allocate %lx bytes below %pa\n",
>>                 PAGE_SIZE, &rtas_region);
>> +    rtas_errinjct_buf = 
>> memblock_phys_alloc_range(RTAS_ERRINJCT_BUF_SIZE,
>> +                              SZ_1K, 0, rtas_region);
>> +    if (!rtas_errinjct_buf)
>> +        panic("ERROR: RTAS: Failed to allocate %lu bytes below %pa\n",
>> +              (unsigned long)RTAS_ERRINJCT_BUF_SIZE, &rtas_region);
>> +
>>       rtas_work_area_reserve_arena(rtas_region);
>>   }
> 


