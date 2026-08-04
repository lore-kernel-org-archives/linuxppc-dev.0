Return-Path: <linuxppc-dev+bounces-25322-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECDFC55822
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 05:57:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDjWR6LZkz2yYs;
	Tue, 04 Aug 2026 15:57:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785823075;
	cv=none; b=c6csIpFnS9W1KeGZ+gC85NP0r2FQTinljbV8JrrnlHfnZ4/8cRYix0kJ0EuSrw8ESLm5n6KTehkf0f3y5pk1WI+M9wn/zD7ldr4FFXqlzR5x7Pg7De8wQlvRWJ+h2azAZq4ppkP9RVCYCRLDO9P3hxSAehwzzZ2vo17wqatXNwe3ca95TabkJ6rqcuwdwK4fLBZbKna4pLLZdjEx0mOuJiorNDJgBB1w/iI3mgvrptTRVvU8bBU1XDcFvhXVQ+aXfd8SEUuIYRYqoO4gXapD6ued7WsmQ2innkYDNE9SVw5cr1XnSOlnLhT631aWeF7puzCSjoCfZq9wfZ7bDL3NcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785823075; c=relaxed/relaxed;
	bh=6hpAqQPA4oxL4HinUVudIL8+ZDvg+ivM+w0Sdhjvzec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ccu7O4SlWm0crYV3DUD7IheUzgOH4p2fEJ4li61cYwgNHKCZgYrFRi9AsSTYjIcbG1kYd9toty8tbeEIhE6s3xMmRaVD1WkPNzig7zrKESu8h+cPzZMNF4r+ER8ydcTszFD2GeylpsC9WVPf3jRgzEpxv75dDIDN2Z6iNu8SDNVEuW6w18qcgx2gEkO4N9pnEWwknpDCBtO6fUzJiRmdh0szyZvu6/JT0Z1txvRCEGCBJ5MzKxTNACUFJDAF/iau9Zoq6pyPDBHYdyJFZrZqiZ/gc1+EaAiJOGjRBVHkk/Iz/KHboAnJRicjdlc7spEQ//HAEBoo6o7OQyy8lglTiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KW6lcuDE; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KW6lcuDE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDjWR0cYpz2yMl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 15:57:54 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741Hfbj1784049;
	Tue, 4 Aug 2026 05:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6hpAqQ
	PA4oxL4HinUVudIL8+ZDvg+ivM+w0Sdhjvzec=; b=KW6lcuDEhSyiBJsQFvMH24
	o8FH8sGP9SgxR8mfCYkuCm2DbHuzQ8alTxjggAH1BngqtA2FywEu/kJ5ZzE/FZQw
	dD72ArmbEX/WDD5kpLE02VhNJ7SD+C58+SnWk9IhbVBtBdFIX49f9ywwv/SD4zJO
	nzI9s5+vzVDqaEynM2xhamD8jcXyg2+MXG6WbwWpnFVEK9CGxfqzdSm6EJJUhw2f
	vdiWDEzGLCJ6HB0eRdI7gwB/XzpAXnBy0oZ9FOA95pMG6ticZOLXrackSb7ktwQC
	38kruo7pof29S+QVw6pqHMKOYszGIiAHw7Iji9jxtS7aGwWBi6GgcmA/qWDpn8KA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqma41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 05:57:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6745uK4T013969;
	Tue, 4 Aug 2026 05:57:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh8kg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 05:57:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6745vSvX42860954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 05:57:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8099820043;
	Tue,  4 Aug 2026 05:57:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1F5020040;
	Tue,  4 Aug 2026 05:57:25 +0000 (GMT)
Received: from [9.123.6.250] (unknown [9.123.6.250])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 05:57:25 +0000 (GMT)
Message-ID: <8eda9bd3-d58c-41a0-a144-d02cb7d72a25@linux.ibm.com>
Date: Tue, 4 Aug 2026 11:27:24 +0530
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
Subject: Re: [PATCH v2 2/5] powerpc/pseries: Add RTAS error injection buffer
 infrastructure
To: Sourabh Jain <sourabhjain@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
 <20260527072433.94510-3-nnmlinux@linux.ibm.com>
 <fd32da15-9952-4d46-9c28-5c2aa87fad0c@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <fd32da15-9952-4d46-9c28-5c2aa87fad0c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: D9HToVF_HFE1Z1RK-oo1qMlEKhMq7Q68
X-Proofpoint-ORIG-GUID: qxQistu2AmU2xwMhKcaCg_2lVltndpCs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA0MyBTYWx0ZWRfX1GZbKa+n0G7m
 XsPU1q52ocdkUN/UNGTfc5r3vWttWj1ra9Q76/+Txe3pCom90g73VJhH9ZS6kGLKKNZ05RJwkRZ
 9U0wnjTv3THbkDeEsK5AboNyZY847kw=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a717f50 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=YnlHx7dLygz1jVq2heAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA0MyBTYWx0ZWRfX/+yhLcOJ+FnW
 3BXjibOFwfG8MieAZyB/jiZym9R3N+ZeZvTJj0wiotpDOwAbM7w5CXo3ZJKP0lXytkPXUfosM+b
 k0D3KKIQMuuqpGAHg5wuh9u+18C6D1Z1NQk3SXCsHu0kOA34lc2FENWEZAOrg3FtWk48FyaT86/
 CeFIcIF4839IYD8AfB0nxYDgVCXssnUR1zH857LTG164zuV6FkCV8h3L3Isurk9Zaxxsr07fyL2
 nhyz+MfRou20QX3xHv3wB0AA3qOoA2ezRlG4PHQu4LAPSZzfcV4EwPSp2H52BDdQD5b7f8WzxcM
 QpJGHXQ1LzI6AU/nXJUhsFG7DQUhAxe9wvuTxE69B1BvSfbbF4e28wS71mwfrC3d+rzZd87BgTU
 6y11El7ARreZGMbetV+rTaXjBpVZUWLgGLnjBPpsLUnR+ba9nc+J1jtXYy2VIo/6OALO/pvZSog
 ulDX+T2aH8dA0aTqU6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040043



On 10/06/26 8:57 AM, Sourabh Jain wrote:
>
>
> On 27/05/26 12:54, Narayana Murty N wrote:
>> Adds global infrastructure required by the injection engine:
>>   - a 1KB aligned RTAS working buffer in rtas.c
>>   - a spinlock to serialize buffer access
>>   - UAPI definitions for error-injection tokens (added to eeh.h)
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/rtas.h     | 21 +++++++++++++++++++++
>>   arch/powerpc/include/uapi/asm/eeh.h | 18 ++++++++++++++++++
>>   arch/powerpc/kernel/rtas.c          | 12 ++++++++++++
>>   3 files changed, 51 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/rtas.h 
>> b/arch/powerpc/include/asm/rtas.h
>> index d046bbd5017d..82512f822c7a 100644
>> --- a/arch/powerpc/include/asm/rtas.h
>> +++ b/arch/powerpc/include/asm/rtas.h
>> @@ -519,6 +519,27 @@ int rtas_get_error_log_max(void);
>>   extern spinlock_t rtas_data_buf_lock;
>>   extern char rtas_data_buf[RTAS_DATA_BUF_SIZE];
>>   +/*
>> + * RTAS Error Injection Buffer (PAPR-compliant)
>> + * ============================================
>> + *
>> + * 1KB aligned, zero-initialized buffer for ibm,errinjct RTAS work 
>> area.
>> + * Protected by rtas_errinjct_buf_lock for concurrent access safety.
>> + *
>> + * PAPR Requirement: ibm,errinjct requires a caller-allocated buffer 
>> passed
>> + * via physical address. Buffer must accommodate largest error type 
>> layouts:
>> + * - IOA bus error (64-bit): 8x32-bit words (32 bytes)
>> + * - All other types: <=4x32-bit words (16 bytes)
>> + *
>> + * Usage:
>> + * prepare_errinjct_buffer() -> spin_lock() -> rtas_call() -> 
>> spin_unlock()
>> + *
>> + * Alignment: SZ_1K ensures PAPR firmware requirements and 
>> cache-line safety.
>> + */
>> +#define RTAS_ERRINJCT_BUF_SIZE 1024
>> +extern spinlock_t rtas_errinjct_buf_lock;
>> +extern char rtas_errinjct_buf[RTAS_ERRINJCT_BUF_SIZE];
>
> The kernel has a similar buffer for userspace (named rtas_rmo_buf),
> which is allocated in the range (0, min(ppc64_rma_size, 
> RTAS_INSTANTIATE_MAX)).
>
> Whereas, the base address of the statically allocated 
> rtas_errinjct_buf array
> depends on the location at which the kernel is loaded, which could be 
> higher than
> RTAS_INSTANTIATE_MAX.
>
> Also, things will break if the base address of rtas_errinjct_buf is 
> greater than
> 4 GB. In that case, the kernel will send a truncated address, and RTAS 
> may
> corrupt memory as a result.
>
> Why don't we allocate rtas_errinjct_buf in the same range where
> rtas_rmo_buf is allocated?
Yes, I do agree for the design direction and is addressed in V3 patch
https://lore.kernel.org/all/20260721033815.5300-1-nnmlinux@linux.ibm.com/
>> +
>>   /* RMO buffer reserved for user-space RTAS use */
>>   extern unsigned long rtas_rmo_buf;
>>   diff --git a/arch/powerpc/include/uapi/asm/eeh.h 
>> b/arch/powerpc/include/uapi/asm/eeh.h
>> index 3b5c47ff3fc4..86645cab2827 100644
>> --- a/arch/powerpc/include/uapi/asm/eeh.h
>> +++ b/arch/powerpc/include/uapi/asm/eeh.h
>> @@ -41,4 +41,22 @@
>>   #define EEH_ERR_FUNC_DMA_WR_TARGET    19
>>   #define EEH_ERR_FUNC_MAX        19
>>   +/* RTAS PCI Error Injection Token Types */
>> +#define RTAS_ERR_TYPE_FATAL                     0x1
>> +#define RTAS_ERR_TYPE_RECOVERED_RANDOM_EVENT    0x2
>> +#define RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT   0x3
>> +#define RTAS_ERR_TYPE_CORRUPTED_PAGE            0x4
>> +#define RTAS_ERR_TYPE_CORRUPTED_SLB             0x5
>> +#define RTAS_ERR_TYPE_TRANSLATOR_FAILURE        0x6
>> +#define RTAS_ERR_TYPE_IOA_BUS_ERROR             0x7
>> +#define RTAS_ERR_TYPE_PLATFORM_SPECIFIC         0x8
>> +#define RTAS_ERR_TYPE_CORRUPTED_DCACHE_START    0x9
>> +#define RTAS_ERR_TYPE_CORRUPTED_DCACHE_END      0xA
>> +#define RTAS_ERR_TYPE_CORRUPTED_ICACHE_START    0xB
>> +#define RTAS_ERR_TYPE_CORRUPTED_ICACHE_END      0xC
>> +#define RTAS_ERR_TYPE_CORRUPTED_TLB_START       0xD
>> +#define RTAS_ERR_TYPE_CORRUPTED_TLB_END         0xE
>> +#define RTAS_ERR_TYPE_IOA_BUS_ERROR_64          0xF
>> +#define RTAS_ERR_TYPE_UPSTREAM_IO_ERROR         0x10
>> +
>>   #endif /* _ASM_POWERPC_EEH_H */
>> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
>> index a2dd94eed9d0..c110965ea1d9 100644
>> --- a/arch/powerpc/kernel/rtas.c
>> +++ b/arch/powerpc/kernel/rtas.c
>> @@ -769,6 +769,18 @@ EXPORT_SYMBOL_GPL(rtas_data_buf);
>>     unsigned long rtas_rmo_buf;
>>   +/*
>> + * RTAS Error Injection Buffer - Global Definitions
>> + * Global 1KB buffer and spinlock for ibm,errinjct RTAS service.
>> + * Exported for pseries EEH error injection usage.
>> + */
>> +
>> +DEFINE_SPINLOCK(rtas_errinjct_buf_lock);
>> +EXPORT_SYMBOL_GPL(rtas_errinjct_buf_lock);
>> +
>> +char rtas_errinjct_buf[1024] __aligned(SZ_1K);
>> +EXPORT_SYMBOL_GPL(rtas_errinjct_buf);
>> +
>>   /*
>>    * If non-NULL, this gets called when the kernel terminates.
>>    * This is done like this so rtas_flash can be a module.
>
Thanks,
Narayana


