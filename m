Return-Path: <linuxppc-dev+bounces-25808-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99E2C5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 08:00:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLHpD3c4rz2ysb;
	Thu, 13 Aug 2026 18:00:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786608004;
	cv=none; b=kYs/F8p4GP1QKpuRIx2fLlKKkcNPEgPS53yY5NImK7BGZBgVbpJOMIeD8h0LTrt8pbc4KYqv1J2BdxHqWcrtAs9Hu9+ElDXgBzdqSvh3pEcYUpTWKi9n3stDYXPeTZkh2TG78Pg3gVtvrxe8Ax/UNsIuO/oNyrw8jHgKtZX69th9S7kTUPhhd3biE3/PfxHLsLmsmgyOUte4Thn9uB+vM3FMbPFgbq5+FLqQwHr4cTJhLMm4wHEFCheU7MJ/wIbuflgHRGKwrRvjlNFhq1PqInsuaMA0thIBVeI8dVw3RQwfjdJGXCwIKcdtMO+F6xcTy+GdtnPzKY+Suohl/65Ljg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786608004; c=relaxed/relaxed;
	bh=os1mJb5gxPuQETbz6HrtaRWy9c4O9P5EGbkydAUgEDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XjHfUS9RaKWTFPP5IBu5/MCGmhjMyGbyCS9VyEk7517jISZi1Qy1zLOFJ+vNslOnicCluJxmv1OGzzr+F/yfjk1YmeEl+HVSf9wB8KWaWNKwrfgYUzDEIcqJA2hGLe9wm1Do6gho91YZQkNaTwqJWmXo0RW85DsDlxwInO7JXaD8gtz9wxmFtFBFPTC2LW1p4sFji/37IoWYlAIRgO/geDSTAZzgo172TfT30v0bG+7v8Ve3S4HQt1CiBkonRXAKHqNNLuabZ0Vp4v7qFGdKL+jaDNdbcG2Fv+5uk2H4hRJwC8S0urwBTXdGs/k/+3mOp9NtNsgK2kF8n3TpBcCHIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GIL3uXrk; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GIL3uXrk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLHpC0rxmz2yjs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 18:00:02 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D61nhb1430627;
	Thu, 13 Aug 2026 07:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=os1mJb
	5gxPuQETbz6HrtaRWy9c4O9P5EGbkydAUgEDo=; b=GIL3uXrkqquBDyfUbPzHST
	YNtoSxj5fjnglb5LdtE8UW2BnmCxjQo+qfB51zvvHT9lSudqm3I6afp8eqQL7R+I
	TXK8u3Dtadd7oyz1zdLReGmNkI4md62/CGGNPLJADskK8VuYyPDcMqU8ycmc+uxi
	BS568IHS+Pl5SJGrCULFgr1b8Lza73DS7TwpzSLtA//AZyHkOK8DIyCV0A1adpQ0
	NO/jA/PwhAwExLRkNd444CtjPfuAa0d7rbFt3oOcHZSXwV1+e0HfvFopzAehzATh
	p3WrWbBMqHRMdDPoJIilYcxxk8CkXOPTu/TH8siWULln/tLhv33H1K+tl9uz4cNQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp35wsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 07:59:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D7uRct021987;
	Thu, 13 Aug 2026 07:59:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy9x1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 07:59:48 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67D7xk2q25231912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 07:59:46 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1AA758060;
	Thu, 13 Aug 2026 07:59:46 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF35758056;
	Thu, 13 Aug 2026 07:59:43 +0000 (GMT)
Received: from [9.61.244.175] (unknown [9.61.244.175])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 07:59:43 +0000 (GMT)
Message-ID: <47a762fc-40da-4df2-be3a-8f4ab1ca1093@linux.ibm.com>
Date: Thu, 13 Aug 2026 13:29:41 +0530
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
Subject: Re: [PATCH] powerpc/entry: Use hard_irq_disable() in
 arch_interrupt_exit_prepare()
Content-Language: en-GB
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        sshegde@linux.ibm.com, mchauras@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260812152035.1661781-1-mkchauras@gmail.com>
 <4882a3cc-30f4-477e-8126-0c244b4a5072@linux.ibm.com>
 <4e0d3ccc-04b2-41a7-b498-a7f55c18d596@kernel.org>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <4e0d3ccc-04b2-41a7-b498-a7f55c18d596@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7d7975 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=UqCG9HQmAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=-XaMBf1mjDECRHgeTNUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VH4Q6V2qPWczq18IaOPC6XhP5p8UHfJE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1MSBTYWx0ZWRfX6zq9Yox9lbg/
 d/FB7/C+3inX4j3szH9raVjt1nqqG66KOJwTtE+ZCt/kVNrp4i7GjvhcQufrJPesWlf8Ui4dMRW
 A9HYRP59ky1Kh9dWa/FSEfy3i+J18eT/JVtRcEJI7iJKssFk0pnYnkK+9we170krL/Yy8e3NJ6W
 tMbfGFUULSWGL2I76UIfOxtfrXTgHVdQc99i1uj/8chmDNU+Y6sYDvsVSJCtf+wLFCQyZ/o4JBI
 1Gr0OqQn+NdGrzearVSdY8jyHEAw+rOdDTRRpWIRwvAl3Cq4vBPIJ5O5aCVIP+s9YwQN1MVz8kO
 awwwJeYaUKMdF9/x8dnSsi/lVFHztc7s0I4BH0aHdJdD/oMEjDn8tBn2yIH4QpgANSkBCpMaElE
 E9mtfNHL34qcBVI5bLOuqJuFWy4SiK8eEM5ev45TfoGquOxJ4UTd2dfTPRZrlh3u9sRhuFiJrS1
 Ku8dNIQzT1K7HalEOqQ==
X-Proofpoint-ORIG-GUID: ihW-B_pj1xDXsprcnMNzDbLG2wbEDshR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1MSBTYWx0ZWRfX/1UsK7oN4orF
 RnNFa+FUKqzrpQ33g8YUs853BhWW6xB0mJd3oiIsREOTDXjyAOfGLtSam3ZMzQIlQVK0aKZSaky
 TFk2Lb1McdW+LBqyn7qPd2ZjqanKz5Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130051


On 13/08/26 12:12 pm, Christophe Leroy (CS GROUP) wrote:
>
>
> Le 13/08/2026 à 08:36, Venkat Rao Bagalkote a écrit :
>>
>> On 12/08/26 8:50 pm, Mukesh Kumar Chaurasiya (IBM) wrote:
>>> commit 334f3f6d7a16 ("powerpc/entry: Disable interrupts before 
>>> irqentry_exit")
>>> fixed a BUG in preempt_schedule_irq() by calling local_irq_disable()
>>> unconditionally in arch_interrupt_exit_prepare() before 
>>> irqentry_exit().
>>> The fix is correct in intent but uses the wrong primitive for PPC64.
>>>
>>> On PPC64, local_irq_disable() only sets the soft-mask
>>> (irq_soft_mask = IRQS_DISABLED). It does not set PACA_IRQ_HARD_DIS in
>>> irq_happened and does not clear MSR[EE].
>>>
>>> This causes a continuous WARN_ON boot hang on Power11 pSeries LPARs
>>> using the dedicated-cede cpuidle path. When the CPU wakes from H_CEDE,
>>> interrupt_exit_kernel_prepare() calls replay_soft_interrupts(), which
>>> dispatches pending async handlers (timer_interrupt, do_IRQ) using the
>>> DEFINE_INTERRUPT_HANDLER_ASYNC macro. That macro calls
>>> arch_interrupt_async_exit_prepare() -> arch_interrupt_exit_prepare()
>>> before irqentry_exit(). With local_irq_disable(), PACA_IRQ_HARD_DIS
>>> is not set, but next_interrupt() unconditionally asserts it:
>>>
>>>    WARN_ON(!(local_paca->irq_happened & PACA_IRQ_HARD_DIS));
>>>
>>> This fires on every replayed interrupt, looping indefinitely and
>>> preventing boot completion.
>>>
>>> Fix this by replacing local_irq_disable() with hard_irq_disable().
>>> On PPC64, hard_irq_disable() sets irq_soft_mask to IRQS_ALL_DISABLED,
>>> sets PACA_IRQ_HARD_DIS in irq_happened, and clears MSR[EE] — satisfying
>>> all of:
>>>
>>>    - lockdep_assert_irqs_disabled() in irqentry_exit_to_kernel_mode()
>>>    - next_interrupt()'s WARN_ON(!(irq_happened & PACA_IRQ_HARD_DIS))
>>>    - preempt_schedule_irq()'s BUG_ON(!irqs_disabled())
>>>
>>> On PPC32/non-64, hard_irq_disable() is equivalent to 
>>> local_irq_disable(),
>>> so there is no regression on those platforms.
>>>
>>> Fixes: 334f3f6d7a16 ("powerpc/entry: Disable interrupts before 
>>> irqentry_exit")
>>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>> Closes: https://eur01.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Flore.kernel.org%2Fall%2F6f9bfb0f-b14c-468e-bb9f- 
>>> c157d120d0dc%40linux.ibm.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cf780f6a2abcf425c875808def90533e4%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639221997929524168%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=kOer%2B610LkQs0ZKBn%2FutIB6j1bMoFasK4DmX4AEWOXA%3D&reserved=0 
>>>
>>> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
>>> ---
>>
>>
>> Tested this, and it fixes the reported issue.
>>
>> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
> Didn't you say yesterday [1] that the change doesn't fix the issue ? 
> Did I miss something ?
>
> [1] 
> https://lore.kernel.org/all/2f7e6c34-7258-4b20-a38e-cedebccb835f@linux.ibm.com/ 
>
>
>
Hi Christophe,

I think there are two separate issues being mixed together here, both of 
which were reported by me.

The first issue is the early boot hang. I tested the patch in that 
context and reported that the boot hang still persisted.

The second issue is the WARN in __replay_soft_interrupts(). For that 
issue, the same patch fixes the problem, which is why I provided the 
Tested-by tag.

I believe the confusion comes from the fact that the same patch ended up 
being discussed in relation to both reports. My earlier comment that the 
patch did not fix the issue was referring to the boot hang, while my 
Tested-by was for the WARN in __replay_soft_interrupts().

So, to clarify:

Boot hang issue: not fixed by the patch.
WARN in __replay_soft_interrupts(): fixed by the patch.

Regards,
Venkat


>>
>>
>> Regards,
>>
>> Venkat.
>>
>>
>>> arch/powerpc/include/asm/entry-common.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/ 
>>> include/asm/entry-common.h
>>> index c5adb5006361..de64389b0815 100644
>>> --- a/arch/powerpc/include/asm/entry-common.h
>>> +++ b/arch/powerpc/include/asm/entry-common.h
>>> @@ -270,7 +270,7 @@ static inline void 
>>> arch_interrupt_exit_prepare(struct pt_regs *regs)
>>>       }
>>>       /* irqentry_exit expects to be called with interrupts disabled */
>>> -    local_irq_disable();
>>> +    hard_irq_disable();
>>>   }
>>>   static inline void arch_interrupt_async_enter_prepare(struct 
>>> pt_regs *regs)
>

