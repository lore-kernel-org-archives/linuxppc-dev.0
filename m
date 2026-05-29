Return-Path: <linuxppc-dev+bounces-21690-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFB7CD6E45
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 08:09:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRbcB6jVzz2xnZ;
	Fri, 29 May 2026 18:09:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780042170;
	cv=none; b=Uzq8GzTiMJaIDPrC1rLjH7XoOmju00Vww4KJWhwLmGzUn9ajUPkk57i5SFOHv2FaY4NP0XqhNX1uh1oREr0sNqm+icgBJ0SXiv84e5dtohr+N+uM0fI4ZAkujGraW+4j1hw+07IFMj2Z9MyXfaf9AeQzTVT/5syoacGGdMWB48UUUpOF25kT2Lr2XmsmmTXmeMAODR80iCr9YY2kDgeCyLhRVV5YNnnlEO01cqbaFTytJADd8hsxNZCCHsEaupQIMqY/65fu8ZLXhSWV9La4KFY8VuZeD3NOJUEMd43oSVsGNP8O0+RiR0YyOU8tmw1eh5NsnGtaOdtIDPncvny4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780042170; c=relaxed/relaxed;
	bh=F/TsKHSDGyDPphQwI5FE1b6ZTik42lyZH6gJWtUcYls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOLzOdcbd8+t/0SKM3g5RBhrEmrd3MoHGE0SvY9VS7Iqhw27Wmlp0fzcu81eVWHLeK1e8u+GqRUGMEpvn0tYfW5wdnparm35iAtWUV6vEvp/1Z1BcHNn6NrLNFI5/qRiNZJT/TiayiL17mSu78aaE+9VFnFMW5d/NQ9GD3lmMduTnxNYR9A5wuqNAZoYPCfztvLTNJ3YY3WoSvCzfgoodXf+e0OUpCp+hpcv6lM5XgcyytZTjHlVKhrR8qLt9+9rmaBYsT9QrbhIcsm9ObWjRXrOAGYHvEUQQAsu7QFmpkrSvIQ35QpGMjrDL41zjHtV9m42+ifta76VQoDJ7nva5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FD2WZaIv; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FD2WZaIv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRbc963DSz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 18:09:29 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLls7U3216036;
	Fri, 29 May 2026 08:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F/TsKH
	SDGyDPphQwI5FE1b6ZTik42lyZH6gJWtUcYls=; b=FD2WZaIvBvryu5XgrqEkLC
	86vP4OvcXfBv5E5Muj9dlmYNXSIDIwDogWWbM1R+1Gt3meLVk9v4GjhEfMbpfmZT
	Iwq/hDFVVkgYGXvAWCYahkg4jU+7dk8flU/ALngyQMQR2bpT7uUAdHnA2+RhylWF
	LpZqx+tP9H44ecS2R2+09b6QvBMp1zYXX3wn3UylIDEjCKf/IRzjBE5n7D8vBsH4
	Mtqlw4g4IR5UagOWp9Fm2y2ImXuLcc2y2ENVJKd9zUSOwbn6vCOzc8nv/+oluvYT
	KSk5ssvXtKm8omnJR7I6GQ2bTwz9bNTDqhJRpdYs51Rsn4aP0x19tGsCLf7fW24Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee88bf344-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 08:09:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64T89MGT020226;
	Fri, 29 May 2026 08:09:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbcf03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 08:09:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64T89M6X44237290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 08:09:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC65F2005A;
	Fri, 29 May 2026 08:09:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47B4920040;
	Fri, 29 May 2026 08:09:21 +0000 (GMT)
Received: from [9.124.221.69] (unknown [9.124.221.69])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 08:09:20 +0000 (GMT)
Message-ID: <ecb38ae9-e0d5-4038-8473-4913af6f1d5e@linux.ibm.com>
Date: Fri, 29 May 2026 13:39:20 +0530
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
Subject: Re: [PATCH 3/3] powerpc/irq: Suppress unlikely interrupt stats by
 default
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, tglx@kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260523174016.999456-1-sshegde@linux.ibm.com>
 <20260523174016.999456-4-sshegde@linux.ibm.com>
 <584f7d44-4486-4fad-a925-abb69c362f06@kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <584f7d44-4486-4fad-a925-abb69c362f06@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA3OCBTYWx0ZWRfX8ISNnV5wlMQA
 8JcuHXeVrkL7cllGjz3mf3sfzRriC0Yv/BbM5WgXjOHf17zg8ppjINOAdj4bnSn+K8ZAktGHVI7
 c7YQMbM3DADztluhiapaBXUd9HCghqazs4Vq0+9FK/yP1dqdfveG5pZexUYzaCuA/hEWae+tabd
 wIACHhujblMp7U7peJS+Z3sZ/08cm9YZ9yE4wPFFoQ8b5+lBRc7cwbExb1JNWw3KGpv+dg0lPRu
 SmiuZQZ8YFs7+sB5EPVn3yuMWuvNjVAnrd9mJ0hqSlvzda0v8kU5JTBxSDnlTBx2zLGuzr4kUtG
 e/66Y9OsE4mExqWWdjOfO6fSER+lCi4Gkrf5/NaXLyATyxN/5pk1oT868c8c7ZVwqELH+0+bmI1
 ctO8SQ6xhTbLTU23nbl883QiLIhHEOT3naYGYWu2c5YBrfzotJB9QCiz6v5QD0LBBGZ1cZVcJUu
 2TNZvcxYv+9BNVyoFLQ==
X-Proofpoint-ORIG-GUID: NmfStuzi8WcFT4VJeZA8LxastbLAp03e
X-Authority-Analysis: v=2.4 cv=IJEyzAvG c=1 sm=1 tr=0 ts=6a1949b5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=rLY5H6RoDMQm1aRIlS4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NmfStuzi8WcFT4VJeZA8LxastbLAp03e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290078

Hi Christophe.
Thanks for reviewing the patch series.

On 5/29/26 1:21 PM, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 23/05/2026 à 19:40, Shrikanth Hegde a écrit :
>> Some interrupts are always zero and that is expected since they occur
>> very rarely and are mostly error indications. Don't print them by
>> default.
>>
>> "MCE" -  "Machine check exceptions"
>> "NMI" -  "System Reset interrupts"
>>
>> Print them if they occur once. Maintain a bitmap to know which
>> interrupts are to be printed.
> 
> Is that bitmap needed at all ? Can't we just print them as soon as they 
> are not zero ?
> 

I think Yes. Otherwise need to traverse all the per_cpu count and to see 
if it is zero or not.


>>
>> Time taken to read /proc/interrupts 1000 times.
>> Base and v6 details can be found in cover-letter.
>> Base            :  103us
>> v6              :   63us
>> v6+patch 1+2    :   57us
>> v6+patch 1+2+3  :   54us
>>
>> Patch 3 shows an additional 5% gain compared to patch 1+2. So it does
>> make sense to print them only if they are ever set.
>>
>> Note: Since /proc/interrupts depend on kconfig and arch dependent,
>> userspace tools don't make explicit assumptions.
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/hardirq.h |  1 +
>>   arch/powerpc/kernel/irq.c          | 37 +++++++++++++++++++++++++++---
>>   arch/powerpc/kernel/traps.c        |  4 ++--
>>   3 files changed, 37 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/ 
>> include/asm/hardirq.h
>> index 38098e35b241..be6cd5aab016 100644
>> --- a/arch/powerpc/include/asm/hardirq.h
>> +++ b/arch/powerpc/include/asm/hardirq.h
>> @@ -31,6 +31,7 @@ DECLARE_PER_CPU(unsigned int, __softirq_pending);
>>   #define local_softirq_pending_ref       __softirq_pending
>>   #define inc_irq_stat(index)    
>> __this_cpu_inc(irq_stat.counts[IRQ_COUNT_##index])
>> +void inc_irq_stat_and_enable(enum irq_stat_counts which);
>>   #define __ARCH_IRQ_STAT
>>   #define __ARCH_IRQ_EXIT_IRQS_DISABLED
>> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
>> index e67a18f62142..048ddfa66fc4 100644
>> --- a/arch/powerpc/kernel/irq.c
>> +++ b/arch/powerpc/kernel/irq.c
>> @@ -87,9 +87,13 @@ u32 tau_interrupts(unsigned long cpu);
>>   struct irq_stat_info {
>>       const char    *symbol;
>>       const char    *text;
>> +    int        skip;
> 
> I'd call it 'optional' instead, and then during the print, if value 0 
> and optional then don't print.
> 

Ok. Makes sense. Will do it in v2.

Will add below way

         if (!(info->optional && test_bit(i, irq_stat_count_show)))
             continue;

>>   };
>> -#define ISE(idx, sym, txt)[IRQ_COUNT_##idx] = { .symbol = sym, .text 
>> = txt}
>> +/* ISE - IRQ STAT ENABLED, ISC - IRQ STAT CONDITIONAL */
>> +#define ISE(idx, sym, txt)[IRQ_COUNT_##idx] = { .symbol = sym, .text 
>> = txt, .skip = 0}
>> +#define ISC(idx, sym, txt)[IRQ_COUNT_##idx] = { .symbol = sym, .text 
>> = txt, .skip = 1}
>> +
>>   static struct irq_stat_info irq_stat_info[IRQ_COUNT_MAX] 
>> __ro_after_init = {
>>       ISE(LOC_TIMER,        "LOC", "  Local timer interrupts for timer 
>> event device\n"),
>> @@ -97,8 +101,8 @@ static struct irq_stat_info 
>> irq_stat_info[IRQ_COUNT_MAX] __ro_after_init = {
>>       ISE(OTHER_TIMER,    "LOC", "  Local timer interrupts for 
>> others\n"),
>>       ISE(SPURIOUS,        "SPU", "  Spurious interrupts\n"),
>>       ISE(PMI,        "PMI", "  Performance monitoring interrupts\n"),
>> -    ISE(MCE,        "MCE", "  Machine check exceptions\n"),
>> -    ISE(NMI_SRESET,        "NMI", "  System Reset interrupts\n"),
>> +    ISC(MCE,        "MCE", "  Machine check exceptions\n"),
>> +    ISC(NMI_SRESET,        "NMI", "  System Reset interrupts\n"),
>>   #ifdef CONFIG_PPC_WATCHDOG
>>       ISE(WATCHDOG,        "WDG", "  Watchdog soft-NMI interrupts\n"),
>>   #endif
>> @@ -107,11 +111,25 @@ static struct irq_stat_info 
>> irq_stat_info[IRQ_COUNT_MAX] __ro_after_init = {
>>   #endif
>>   };
>> +/*
>> + * Used for default disabled counters to increment the stats and to 
>> enable the
>> + * entry for /proc/interrupts output.
>> + */
>> +static DECLARE_BITMAP(irq_stat_count_show, IRQ_COUNT_MAX) __read_mostly;
>> +void inc_irq_stat_and_enable(enum irq_stat_counts which)
>> +{
>> +    __this_cpu_inc(irq_stat.counts[which]);
>> +    set_bit(which, irq_stat_count_show);
>> +}
>> +
>>   int arch_show_interrupts(struct seq_file *p, int prec)
>>   {
>>       const struct irq_stat_info *info = irq_stat_info;
>>       for (unsigned int i = 0; i < ARRAY_SIZE(irq_stat_info); i++, 
>> info++) {
>> +        if (!test_bit(i, irq_stat_count_show))
>> +            continue;
>> +
>>           seq_printf(p, "%*s:", prec, info->symbol);
>>           irq_proc_emit_counts(p, &irq_stat.counts[i]);
>>           seq_puts(p, info->text);
>> @@ -138,6 +156,19 @@ int arch_show_interrupts(struct seq_file *p, int 
>> prec)
>>       return 0;
>>   }
>> +static int __init irq_init_stats(void)
>> +{
>> +    struct irq_stat_info *info = irq_stat_info;
>> +
>> +    for (unsigned int i = 0; i < ARRAY_SIZE(irq_stat_info); i++, 
>> info++) {
>> +        if (info->skip == 0)
>> +            set_bit(i, irq_stat_count_show);
>> +    }
>> +
>> +    return 0;
>> +}
>> +late_initcall(irq_init_stats);
>> +
>>   /*
>>    * /proc/stat helpers
>>    */
>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>> index a8f15154bd9a..3eacbd20fc80 100644
>> --- a/arch/powerpc/kernel/traps.c
>> +++ b/arch/powerpc/kernel/traps.c
>> @@ -459,7 +459,7 @@ DEFINE_INTERRUPT_HANDLER_NMI(system_reset_exception)
>>       }
>>       hv_nmi_check_nonrecoverable(regs);
>> -    inc_irq_stat(NMI_SRESET);
>> +    inc_irq_stat_and_enable(IRQ_COUNT_NMI_SRESET);
>>       /* See if any machine dependent calls */
>>       if (ppc_md.system_reset_exception) {
>> @@ -816,7 +816,7 @@ static void __machine_check_exception(struct 
>> pt_regs *regs)
>>   {
>>       int recover = 0;
>> -    inc_irq_stat(MCE);
>> +    inc_irq_stat_and_enable(IRQ_COUNT_MCE);
>>       add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
> 


